/*
 * Some or all of this work - Copyright (c) 2006 - 2014, Intel Corp.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 * Neither the name of Intel Corporation nor the names of its contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 * Resource Descriptor macros
 *
 * Generic Register Resource Descriptor Macro
 */

Name (p436, Package() {

	// Byte 3 (Address Space ID) of Register Descriptor

	ResourceTemplate () {
		Register (SystemMemory, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9)
	},
	ResourceTemplate () {
		Register (SystemIO, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9)
	},
	ResourceTemplate () {
		Register (PCI_Config, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9)
	},
	ResourceTemplate () {
		Register (EmbeddedControl, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9)
	},
	ResourceTemplate () {
		Register (SMBus, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9)
	},
	ResourceTemplate () {
		Register (SystemCMOS, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9)
	},
	ResourceTemplate () {
		Register (PciBarTarget, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9)
	},
	ResourceTemplate () {
		Register (IPMI, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9)
	},
	ResourceTemplate () {
		Register (GeneralPurposeIo, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9)
	},
	ResourceTemplate () {
		Register (GenericSerialBus, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9)
	},
	ResourceTemplate () {
		Register (FFixedHW, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9)
	},

	// Byte 6 (Address Size) of Register Descriptor

	ResourceTemplate () {
		Register (SystemMemory, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9, 0)
	},
	ResourceTemplate () {
		Register (SystemMemory, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9, 1)
	},
	ResourceTemplate () {
		Register (SystemMemory, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9, 2)
	},
	ResourceTemplate () {
		Register (SystemMemory, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9, 3)
	},
	ResourceTemplate () {
		Register (SystemMemory, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9, 4)
	},

	// Particular cases

	ResourceTemplate () {
		Register (SystemMemory, 0, 0, 0)
	},
	ResourceTemplate () {
		Register (SystemMemory, 0xff, 0xff, 0)
	},
})

/*
ACPI Specification, Revision 3.0, September 2, 2004
6.4.3.7   Generic Register Descriptor

Generic Register Descriptor layout:

Byte 0	Generic register descriptor	Value = 10000010B (0x82) (Type = 1, Large item name = 0x2)
Byte 1	Length, bits[7:0]	Value = 00001100B (12)
Byte 2	Length, bits[15:8]	Value = 00000000B (0)
Byte 3	Address Space ID, _ASI	The address space where the data structure or register exists.
				Defined values are:
	0x00	System Memory
	0x01	System I/O
	0x02	PCI Configuration Space
	0x03	Embedded Controller
	0x04	SMBus
	0x7F	Functional Fixed Hardware
Byte 4	Register Bit Width, _RBW	Indicates the register width in bits.
Byte 5	Register Bit Offset, _RBO	Indicates the offset to the start of the register in bits
				from the Register Address.
Byte 6	Address Size, _ASZ	Specifies access size.
	0-Undefined (legacy reasons)
	1-Byte access
	2-Word access
	3-Dword access
	4-Qword access
Byte 7	Register Address, _ADR bits[7:0]	Register Address
Byte 8	Register Address, _ADR bits[15:8]	
Byte 9	Register Address, _ADR bits[23:16]	
Byte 10	Register Address, _ADR bits[31:24]	
Byte 11	Register Address, _ADR bits[39:32]	
Byte 12	Register Address, _ADR bits[47:40]	
Byte 13	Register Address, _ADR bits[55:48]	
Byte 14	Register Address, _ADR bits[63:56]	
*/

Name (p437, Package() {

	// Byte 3 (Address Space ID) of Register Descriptor

	Buffer () {0x82, 0x0c, 0x00, 0x00, 0xf0, 0xf1, 0x00,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},
	Buffer () {0x82, 0x0c, 0x00, 0x01, 0xf0, 0xf1, 0x00,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},
	Buffer () {0x82, 0x0c, 0x00, 0x02, 0xf0, 0xf1, 0x00,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},
	Buffer () {0x82, 0x0c, 0x00, 0x03, 0xf0, 0xf1, 0x00,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},
	Buffer () {0x82, 0x0c, 0x00, 0x04, 0xf0, 0xf1, 0x00,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},
	Buffer () {0x82, 0x0c, 0x00, 0x05, 0xf0, 0xf1, 0x00,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},
	Buffer () {0x82, 0x0c, 0x00, 0x06, 0xf0, 0xf1, 0x00,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},
	Buffer () {0x82, 0x0c, 0x00, 0x07, 0xf0, 0xf1, 0x00,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},
	Buffer () {0x82, 0x0c, 0x00, 0x08, 0xf0, 0xf1, 0x00,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},
	Buffer () {0x82, 0x0c, 0x00, 0x09, 0xf0, 0xf1, 0x00,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},
	Buffer () {0x82, 0x0c, 0x00, 0x7f, 0xf0, 0xf1, 0x00,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},

	// Byte 6 (Address Size) of Register Descriptor

	Buffer () {0x82, 0x0c, 0x00, 0x00, 0xf0, 0xf1, 0x00,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},
	Buffer () {0x82, 0x0c, 0x00, 0x00, 0xf0, 0xf1, 0x01,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},
	Buffer () {0x82, 0x0c, 0x00, 0x00, 0xf0, 0xf1, 0x02,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},
	Buffer () {0x82, 0x0c, 0x00, 0x00, 0xf0, 0xf1, 0x03,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},
	Buffer () {0x82, 0x0c, 0x00, 0x00, 0xf0, 0xf1, 0x04,
		0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00},

	// Particular cases

	Buffer () {0x82, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x79, 0x00},
	Buffer () {0x82, 0x0c, 0x00, 0x00, 0xff, 0xff, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x79, 0x00},
})

Method(RT19,, Serialized)
{
	Name(ts, "RT19")

	// Emit test header, set the filename

	THDR (ts, "Register Resource Descriptor Macro", __FILE__)

    // The main test packages must have the same number of entries

    If (LNotEqual (SizeOf (p436), SizeOf (p437)))
    {
        err (ts, 179, 0, 0, 0, 0, "Incorrect package length")
        Return ()
    }

    // Main test case for packages above

	m330(ts, SizeOf (p436), "p436", p436, p437)

	/* Register macro DescriptorName is recently implemented */

    // Check resource descriptor tag offsets

	Store (
		ResourceTemplate () {
			Register (SystemMemory, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9, 0, REG0)
			Register (SystemMemory, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9, 0, REG1)
		}, Local0)

	m331(ts, 1, REG0._ASI, 0x18, REG1._ASI, 0x90, "_ASI")
	m331(ts, 2, REG0._RBW, 0x20, REG1._RBW, 0x98, "_RBW")
	m331(ts, 3, REG0._RBO, 0x28, REG1._RBO, 0xA0, "_RBO")
	m331(ts, 4, REG0._ASZ, 0x30, REG1._ASZ, 0xA8, "_ASZ")
	m331(ts, 5, REG0._ADR, 0x38, REG1._ADR, 0xB0, "_ADR")
}
