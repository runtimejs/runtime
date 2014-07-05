// Copyright 2014 Runtime.JS project authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

(function RTL8139Driver(args) {
    "use strict";

    var utils = rt.initrdRequire("/utils.js");
    var mmio = args.pci.bars[1];
    var iobuf = mmio.resource.buffer();
    var irq = args.pci.irq;
    var allocator = args.allocator;

    var sizeMult = {
        KiB: 1024,
        MiB: 1024 * 1024,
    };

    var buffers = (function Buffers() {
        // Allocate 2 MB DMA buffers page
        var allocated = allocator.allocDMA();

        var maxEthernetPacketSize = 1536;

        var rxOffset = 0;
        var rxSize = 8 * sizeMult.KiB;
        var rxExtraWrap = 2048;

        var txFirst = 128 * sizeMult.KiB;
        var txSize = 4 * sizeMult.KiB;
        var txOffsets = [
            txFirst + 0 * txSize,
            txFirst + 1 * txSize,
            txFirst + 2 * txSize,
            txFirst + 3 * txSize,
        ];
        var txCount = 4;
        var txCurrent = 0;
        var txDirtyCount = 0;

        var buffer = allocated.buffer;

        var rx = {
            address: allocated.address + rxOffset,
            length: rxSize,
            copy: function(offset, size) {
                return buffer.slice(rxOffset + offset, rxOffset + offset + size);
            },
            b: new Uint8Array(buffer, rxOffset, rxSize + rxExtraWrap),
            w: new Uint16Array(buffer, rxOffset, (rxSize + rxExtraWrap) >>> 1),
        };

        var tx = txOffsets.map(function(offset, index) {
            return {
                index: index,
                address: allocated.address + offset,
                b: new Uint8Array(buffer, offset, txSize),
                w: new Uint16Array(buffer, offset, txSize >>> 1),
            };
        });

        return {
            rx: function() { return rx; },
            // tx: function(index) { return tx[index]; },
            takeTx: function() {
                if (txDirtyCount >= txCount) {
                    return null;
                }

                ++txDirtyCount;

                var txc = tx[txCurrent];
                if (++txCurrent >= txCount) {
                    txCurrent = 0;
                }

                return txc;
            },
        };
    })();

    var r = (function RegisterAccessor(iobuf) {
        var iobuf8 = new Uint8Array(iobuf);
        var iobuf16 = new Uint16Array(iobuf);
        var iobuf32 = new Uint32Array(iobuf);

        var registers = {
            // Ethernet ID
            IDR             : [{offset: 0x00, size: 4}, 
                               {offset: 0x04, size: 4}],

            // Multicast
            MAR             : [{offset: 0x08, size: 4}, 
                               {offset: 0x0c, size: 4}],

            // Transmit Status of Descriptor 0-3
            TX_STATUS       : [{offset: 0x10, size: 4},
                               {offset: 0x14, size: 4},
                               {offset: 0x18, size: 4},
                               {offset: 0x1c, size: 4}],

            // Transmit Start Address of Descriptor 0-3
            TX_START        : [{offset: 0x20, size: 4},
                               {offset: 0x24, size: 4},
                               {offset: 0x28, size: 4},
                               {offset: 0x2c, size: 4}],

            // Recv buffer start address
            RX_START        :  {offset: 0x30, size: 4},

            // Command register
            CR              :  {offset: 0x37, size: 1, flag: {
                                    RESET: 0x10,
                                    RX_ENABLE: 0x08,
                                    TX_ENABLE: 0x04,
                                    RX_EMPTY: 0x01,
                               }},

            // Current Address of Packet Read
            CAPR            :  {offset: 0x38, size: 2},

            // Interrupt Mask Register
            IMR             :  {offset: 0x3c, size: 2, flag: {
                                    RECV_OK: 0x01,
                                    RECV_ERROR: 0x02,
                                    SEND_OK: 0x04,
                                    SEND_ERROR: 0x08,
                                    RX_BUF_OVERFLOW: 0x10,
                                    PCK_UNDERRUN: 0x20,
                                    RX_FIFO_OVERFLOW: 0x40,
                                    CABLE_CHANGE: 0x2000,
                                    TIMEOUT: 0x4000,
                                    SYS_ERROR: 0x8000,
                               }},

            // Interrupt Status Register
            ISR             :  {offset: 0x3e, size: 2, flag: {
                                    RECV_OK: 0x01,
                                    RECV_ERROR: 0x02,
                                    SEND_OK: 0x04,
                                    SEND_ERROR: 0x08,
                                    RX_BUF_OVERFLOW: 0x10,
                                    PCK_UNDERRUN: 0x20,
                                    RX_FIFO_OVERFLOW: 0x40,
                                    CABLE_CHANGE: 0x2000,
                                    TIMEOUT: 0x4000,
                                    SYS_ERROR: 0x8000,
                               }},

            // Receive (Rx) Configuration Register
            TX_CONF         :  {offset: 0x40, size: 4, flag: {
                               }},

            // Receive (Rx) Configuration Register
            RX_CONF         :  {offset: 0x44, size: 4, flag: {
                                    ACCEPT_ALL: (1 << 0),
                                    ACCEPT_PHYSICAL_MATCH: (1 << 1),
                                    ACCEPT_MULTICAST: (1 << 2),
                                    ACCEPT_BROADCAST: (1 << 3),
                                    WRAP: (1 << 7),
                               }},

            // Missed Packet Counter
            MPC             :  {offset: 0x4c, size: 4},

            // 93C46 Command Register
            CR9346          :  {offset: 0x50, size: 1, flag: {
                                    LOCK: 0x00,
                                    UNLOCK: 0xc0,
                               }}, 

            // Configuration Register 0
            CONFIG0         :  {offset: 0x51, size: 1}, 

            // Configuration Register 1
            CONFIG1         :  {offset: 0x52, size: 1, flag: {
                                    PM_ENABLE: 0x01,
                                    VPD_ENABLE: 0x02,
                                    PIO: 0x04,
                                    MMIO: 0x08,
                                    LWAKE: 0x10,         /* except 8139, 8139A */
                                    DRIVER_LOADED: 0x20,
                                    LED0: 0x40,
                                    LED1: 0x80,
                                    SLEEP: (1 << 1),     /* only on 8139, 8139A */
                                    PWRDN: (1 << 0),     /* only on 8139, 8139A */
                               }},

            // Configuration Register 4
            CONFIG4         :  {offset: 0x5a, size: 1, flag: {
                                    LWPTN: (1 << 2),
                               }}, 

            HLTCLK          :  {offset: 0x5b, size: 1},

            // Multiple Interrupt Select Register
            MULINT          :  {offset: 0x5c, size: 2, flag: {
                                    CLEAR: 0xf000,
                               }},

            // Basic Mode Control Register
            BMCR            :  {offset: 0x62, size: 2, flag: {
                                    AUTONEG_ENABLED: (1 << 12),
                               }},

            // Auto-negotiation Advertisement Register
            ANAR            :  {offset: 0x66, size: 2, flag: {
                                    SELECTOR: (1 << 0),
                                    SUPPORT_10: (1 << 5),
                                    SUPPORT_10_FULL_DUPLEX: (1 << 6),
                                    SUPPORT_100: (1 << 7),
                                    SUPPORT_100_FULL_DUPLEX: (1 << 8),
                               }},

            // CS Configuration Register
            CSCR            :  {offset: 0x74, size: 2}, 
        };

        function checkAlign(reg, align) {
            if (reg % align !== 0) {
                throw new Error('unaligned register access');
            }
        }

        function readB(reg) { return iobuf8[reg]; }
        function readW(reg) { checkAlign(reg, 2); return iobuf16[reg >>> 1]; }
        function readDW(reg) { checkAlign(reg, 4); return iobuf32[reg >>> 2]; }

        function writeB(reg, val) { iobuf8[reg] = val; }
        function writeW(reg, val) { checkAlign(reg, 2); iobuf16[reg >>> 1] = val; }
        function writeDW(reg, val) { checkAlign(reg, 4); iobuf32[reg >>> 2] = val; }

        var obj = {
            read: function(reg) {
                // runtime.log('read from', '0x'+reg.offset.toString(16));
                switch (reg.size) {
                    case 1: return readB(reg.offset);
                    case 2: return readW(reg.offset);
                    case 4: return readDW(reg.offset);
                    default: throw new Error('invalid register size');
                }
            },
            write: function(reg, value) {
                // runtime.log('written invalid value to 0x' + reg.offset.toString(16) + ' = ' + value);
                if ('number' !== typeof value || value < 0) {
                    throw new Error('written invalid value to 0x' + reg.offset.toString(16) + ' = ' + value);
                }

                switch (reg.size) {
                    case 1: writeB(reg.offset, value); return;
                    case 2: writeW(reg.offset, value); return;
                    case 4: writeDW(reg.offset, value); return;
                    default: throw new Error('invalid register size');
                }
            },
            writeFlush: function(reg, value) {
                obj.write(reg, value);
                obj.read(reg);
            },
            alter: function(reg, alterFn) {
                obj.write(reg, alterFn(obj.read(reg)));
            },
        };

        // Merge registers into object
        for (var at in registers) {
            obj[at] = registers[at];
        }

        return obj;
    })(iobuf);

    function startup() {
        function readMac() {
            var v1 = r.read(r.IDR[0]);
            var v2 = r.read(r.IDR[1]);

            var mac = [
                (v1 >>>  0) & 0xff,
                (v1 >>>  8) & 0xff,
                (v1 >>> 16) & 0xff,
                (v1 >>> 24) & 0xff,
                (v2 >>>  0) & 0xff,
                (v2 >>>  8) & 0xff,
            ];

            var macString = mac.map(function(x) {
                return x.toString(16);
            }).join(':');

            runtime.log('mac addr', macString);
        }

        return new Promise(function(resolve, reject) {
            readMac();
            resolve();
        });
    }

    function powerUp() {
        // Start timer
        r.write(r.HLTCLK, 'R'.charCodeAt(0));

        // Unlock config registers
        r.write(r.CR9346, r.CR9346.flag.UNLOCK);

        // Power
        r.alter(r.CONFIG1, function(x) {
            x |= r.CONFIG1.flag.PM_ENABLE;
            x &= ~r.CONFIG1.flag.LWAKE;
            return x >>> 0;
        });

        r.alter(r.CONFIG4, function(x) {
            x &= ~r.CONFIG4.flag.LWPTN;
            return x >>> 0;
        });

        // Lock config registers
        r.write(r.CR9346, r.CR9346.flag.LOCK);

        // Set multicast
        r.write(r.MAR[0], 0xffffffff);
        r.write(r.MAR[1], 0xffffffff);

        // Disable multiple interrupt
        r.alter(r.MULINT, function(x) {
            return x & r.MULINT.flag.CLEAR;
        });
    }

    function reset() {
        var resetFlag = r.CR.flag.RESET;
        r.write(r.CR, resetFlag);

        return utils.waitFor(function() {
            var b = r.read(r.CR);
            return 0 === (b & resetFlag);
        }, 20, 10);
    }

    var allFlagsISR =
        r.ISR.flag.RECV_OK |
        r.ISR.flag.RECV_ERROR |
        r.ISR.flag.SEND_OK |
        r.ISR.flag.SEND_ERROR |
        r.ISR.flag.RX_BUF_OVERFLOW |
        r.ISR.flag.PCK_UNDERRUN |
        r.ISR.flag.RX_FIFO_OVERFLOW |
        r.ISR.flag.CABLE_CHANGE |
        r.ISR.flag.TIMEOUT |
        r.ISR.flag.SYS_ERROR;

    // r.alter(r.BMCR, function(x) {
    //     return x | r.BMCR.flag.AUTONEG_ENABLED;
    // });
    //
    // r.alter(r.ANAR, function(x) {
    //     return x | r.ANAR.flag.SELECTOR | r.ANAR.flag.SUPPORT_10 |
    //                r.ANAR.flag.SUPPORT_10_FULL_DUPLEX | r.ANAR.flag.SUPPORT_100 |
    //                r.ANAR.flag.SUPPORT_100_FULL_DUPLEX;
    // });

    function enableTxRx() {
        // Enable Rx (receiver) and Tx (transmitter)
        r.write(r.CR, r.CR.flag.RX_ENABLE | r.CR.flag.TX_ENABLE);
        runtime.log('EN: rxtx');

        return utils.waitFor(function() {
            var b = r.read(r.CR);

            var flag = r.CR.flag.RX_ENABLE | r.CR.flag.TX_ENABLE;
            var ret = (b & flag) === flag;
            runtime.log('check ret', ret);

            if (!ret) {
                r.write(r.CR, flag);
            }

            return ret;
        }, 20, 100);
    }

    function configure() {
        /* Rx buffer level before first PCI xfer.  */
        var RX_FIFO_THRESH = 4;

        /* 0, 1, 2 is allowed - 8,16,32K rx buffer */
        var RX_BUF_LEN_IDX = 0;

        /* Maximum PCI burst, '4' is 256 bytes */
        var RX_DMA_BURST = 4;

       /* Maximum PCI burst, '4' is 256 bytes */
        var TX_DMA_BURST = 4;

        r.write(r.RX_CONF,
                (RX_FIFO_THRESH << 13) | (RX_BUF_LEN_IDX << 11) | (RX_DMA_BURST << 8));

        r.write(r.TX_CONF, (TX_DMA_BURST << 8) | 0x03000000);

        // Set Rx buffer
        runtime.log('DMA(js)', '0x' + (buffers.rx().address >>> 0).toString(16));
        r.write(r.RX_START, buffers.rx().address >>> 0);

        // Reset Rx missed counter
        r.write(r.MPC, 0);

        r.write(r.RX_CONF,
                (RX_FIFO_THRESH << 13) | (RX_BUF_LEN_IDX << 11) | (RX_DMA_BURST << 8) |
                r.RX_CONF.flag.ACCEPT_ALL |
                r.RX_CONF.flag.ACCEPT_PHYSICAL_MATCH |
                r.RX_CONF.flag.ACCEPT_MULTICAST |
                r.RX_CONF.flag.ACCEPT_BROADCAST |
                r.RX_CONF.flag.WRAP);
    }

    function enableInterrupt() {
        r.write(r.IMR, allFlagsISR);
    }

    var irqCounter = (function IRQCounter() {
        var value = 0;

        return {
            inc: function() { ++value; },
            value: function() { return value; },
        };
    })();

    var curRx = 0;
    var maxEthernetPacketSize = 1536;

    function ab2str(buf) {
        var s = '';
        var v = new Uint8Array(buf);
        for (var i = 0; i < v.length; ++i) {
            var t = v[i].toString(16);
            if (1 === t.length) {
                t = '0' + t;
            }
            s += t + ' ';
        }

        return s;
    }

    function recv() {
        while (0 == (r.read(r.CR) & r.CR.flag.RX_EMPTY)) {
            var rx = buffers.rx();

            var offset = curRx % rx.length;


            var frameHeader = rx.w[offset >>> 1];
            var frameSize = rx.w[(offset + 2) >>> 1];

            // CRC size 4 bytes
            var packetSize = frameSize - 4;

            if (packetSize > maxEthernetPacketSize || packetSize < 8) {
                runtime.log('invalid packet size');
            }

            var packet = rx.copy(offset + 4, packetSize);
            // runtime.log('recv packet size', packetSize, 'data', ab2str(packet));
            runtime.log('recv packet size', packetSize);

            curRx = (curRx + frameSize + 4 + 3) & 0xfffffffc;
            r.write(r.CAPR, curRx - 16);
        }
    }

    function Handler() {
        var status = r.read(r.ISR);

        if (0 === status) {
            return;
        }

        // Reset IRQ status by writing any value to ISR
        r.write(r.ISR, status);

        // Invalid status check
        if (0xffff === status) {
            return;
        }

        // Check if packet received
        if (status & r.ISR.flag.RECV_OK) {
            recv();
            // runtime.log('recv');
        }

        if (status & r.ISR.flag.SEND_OK) {
            runtime.log('sent');
        }
    }

    function poll() {
        setTimeout(function sf() {
            Handler();
            setTimeout(sf, 100);
        }, 100);
    }

    function transmit(buffer) {
        runtime.log('transmit');
        var len = buffer.byteLength;

        var tx = buffers.takeTx();

        // Copy packet buffer into Tx buffer
        tx.b.set(buffer);
        r.write(r.TX_START[tx.index], tx.address >>> 0);
        r.write(r.TX_STATUS[tx.index], (len & 0x1fff) >>> 0);
    }

    // irq.on(function() {
    //     irqCounter.inc();
    //     Handler();
    // });

    startup()
        .chain(powerUp)
        .chain(reset)
        .chain(enableTxRx)
        .chain(configure)
        .chain(enableInterrupt)
        .chain(poll)
        .chain(function() {
            var b = new ArrayBuffer(64);
            transmit(b);
        })
        .then(function() {
            runtime.log('chip ready.');
        }, function(error) {
            runtime.log('chip failed.', error.stack);
        });

})(runtime.args());
