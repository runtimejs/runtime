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
 * Store Integer/String/Buffer/Package to Device (global objects)
 */

// Glob to Loc

// Integer

Method(md5b,, Serialized)
{
	Device(OOO2) { Name(i900, 0xabcd0017) }

	Store(id00, OOO2)
	Store (0x61, OOO2)

	Store(DeRefof(Refof(OOO2)), Local1)

	if (LNotEqual(Local1, 0x61)) {
		err("", zFFF, 0xd00, 0, 0, Local1, 0x61)
	}
	if (LNotEqual(id00, 0xe0385bcd)) {
		err("", zFFF, 0xd01, 0, 0, id00, 0xe0385bcd)
	}
}

// String

Method(md5c,, Serialized)
{
	Device(OOO2) { Name(i900, 0xabcd0017) }

	Store(sd00, OOO2)
	Store(Refof(OOO2), Local0)
	Store (0x61, Index(DeRefof(Local0), 3))

	Store(Refof(OOO2), Local0)
	Store(DeRefof(Local0), Local1)

	if (LNotEqual(Local1, "Strang")) {
		err("", zFFF, 0xd02, 0, 0, Local1, "Strang")
	}
	if (LNotEqual(sd00, "String")) {
		err("", zFFF, 0xd03, 0, 0, sd00, "String")
	}
}

// Buffer

Method(md5d,, Serialized)
{
	Device(OOO2) { Name(i900, 0xabcd0017) }

	Store(bd00, OOO2)

	Store(Refof(OOO2), Local0)
	Store (0x61, Index(DeRefof(Local0), 3))
	Store(DeRefof(Local0), Local1)

	if (LNotEqual(Local1, Buffer(32) {1,2,3,0x61})) {
		err("", zFFF, 0xd04, 0, 0, Local1, Buffer() {1,2,3,0x61})
	}
	if (LNotEqual(bd00, Buffer(32) {1,2,3,4})) {
		err("", zFFF, 0xd05, 0, 0, bd00, Buffer() {1,2,3,4})
	}
}

// Package

Method(md5e,, Serialized)
{
	Device(OOO2) { Name(i900, 0xabcd0017) }

	Store(pd00, OOO2)
	Store(Refof(OOO2), Local0)
	Store (0x61, Index(DerefOf(Index(DeRefof(Local0), 0)), 3))

	// OOO2

	Store(DeRefof(Index(DerefOf(Index(DeRefof(Local0), 0)), 0)), Local1)
	if (LNotEqual(Local1, 1)) {
		err("", zFFF, 0xd06, 0, 0, Local1, 1)
	}
	Store(DeRefof(Index(DerefOf(Index(DeRefof(Local0), 0)), 1)), Local1)
	if (LNotEqual(Local1, 2)) {
		err("", zFFF, 0xd07, 0, 0, Local1, 2)
	}
	Store(DeRefof(Index(DerefOf(Index(DeRefof(Local0), 0)), 2)), Local1)
	if (LNotEqual(Local1, 3)) {
		err("", zFFF, 0xd08, 0, 0, Local1, 3)
	}
	Store(DeRefof(Index(DerefOf(Index(DeRefof(Local0), 0)), 3)), Local1)
	if (LNotEqual(Local1, 0x61)) {
		err("", zFFF, 0xd09, 0, 0, Local1, 0x61)
	}

	// pd00

	Store(DeRefof(Index(DerefOf(Index(pd00, 0)), 0)), Local0)
	if (LNotEqual(Local0, 1)) {
		err("", zFFF, 0xd0a, 0, 0, Local0, 1)
	}
	Store(DeRefof(Index(DerefOf(Index(pd00, 0)), 1)), Local0)
	if (LNotEqual(Local0, 2)) {
		err("", zFFF, 0xd0b, 0, 0, Local0, 2)
	}
	Store(DeRefof(Index(DerefOf(Index(pd00, 0)), 2)), Local0)
	if (LNotEqual(Local0, 3)) {
		err("", zFFF, 0xd0c, 0, 0, Local0, 3)
	}
	Store(DeRefof(Index(DerefOf(Index(pd00, 0)), 3)), Local0)
	if (LNotEqual(Local0, 4)) {
		err("", zFFF, 0xd0d, 0, 0, Local0, 4)
	}
}

// All objects are global

// Integer

Method(md5f)
{
	Store(id00, dd00)
	Store (0x61, dd00)

	Store(DeRefof(Refof(dd00)), Local1)

	if (LNotEqual(Local1, 0x61)) {
		err("", zFFF, 0xd0e, 0, 0, Local1, 0x61)
	}
	if (LNotEqual(id00, 0xe0385bcd)) {
		err("", zFFF, 0xd0f, 0, 0, id00, 0xe0385bcd)
	}
}

// String

Method(md60,, Serialized)
{
	Device(dd01) { Name(i900, 0xabcd0017) }

	Store(sd00, dd01)
	Store(Refof(dd01), Local0)
	Store (0x61, Index(DeRefof(Local0), 3))

	Store(Refof(dd01), Local0)
	Store(DeRefof(Local0), Local1)

	if (LNotEqual(Local1, "Strang")) {
		err("", zFFF, 0xd10, 0, 0, Local1, "Strang")
	}
	if (LNotEqual(sd00, "String")) {
		err("", zFFF, 0xd11, 0, 0, sd00, "String")
	}
}

// Buffer

Method(md61,, Serialized)
{
	Device(dd02) { Name(i900, 0xabcd0017) }

	Store(bd00, dd02)

	Store(Refof(dd02), Local0)
	Store (0x61, Index(DeRefof(Local0), 3))
	Store(DeRefof(Local0), Local1)

	if (LNotEqual(Local1, Buffer(32) {1,2,3,0x61})) {
		err("", zFFF, 0xd12, 0, 0, Local1, Buffer() {1,2,3,0x61})
	}
	if (LNotEqual(bd00, Buffer(32) {1,2,3,4})) {
		err("", zFFF, 0xd13, 0, 0, bd00, Buffer() {1,2,3,4})
	}
}

// Package

Method(md62,, Serialized)
{
	Device(dd03) { Name(i900, 0xabcd0017) }

	Store(pd00, dd03)
	Store(Refof(dd03), Local0)
	Store (0x61, Index(DerefOf(Index(DeRefof(Local0), 0)), 3))

	// dd03

	Store(DeRefof(Index(DerefOf(Index(DeRefof(Local0), 0)), 0)), Local1)
	if (LNotEqual(Local1, 1)) {
		err("", zFFF, 0xd14, 0, 0, Local1, 1)
	}
	Store(DeRefof(Index(DerefOf(Index(DeRefof(Local0), 0)), 1)), Local1)
	if (LNotEqual(Local1, 2)) {
		err("", zFFF, 0xd15, 0, 0, Local1, 2)
	}
	Store(DeRefof(Index(DerefOf(Index(DeRefof(Local0), 0)), 2)), Local1)
	if (LNotEqual(Local1, 3)) {
		err("", zFFF, 0xd16, 0, 0, Local1, 3)
	}
	Store(DeRefof(Index(DerefOf(Index(DeRefof(Local0), 0)), 3)), Local1)
	if (LNotEqual(Local1, 0x61)) {
		err("", zFFF, 0xd17, 0, 0, Local1, 0x61)
	}

	// pd00

	Store(DeRefof(Index(DerefOf(Index(pd00, 0)), 0)), Local0)
	if (LNotEqual(Local0, 1)) {
		err("", zFFF, 0xd18, 0, 0, Local0, 1)
	}
	Store(DeRefof(Index(DerefOf(Index(pd00, 0)), 1)), Local0)
	if (LNotEqual(Local0, 2)) {
		err("", zFFF, 0xd19, 0, 0, Local0, 2)
	}
	Store(DeRefof(Index(DerefOf(Index(pd00, 0)), 2)), Local0)
	if (LNotEqual(Local0, 3)) {
		err("", zFFF, 0xd1a, 0, 0, Local0, 3)
	}
	Store(DeRefof(Index(DerefOf(Index(pd00, 0)), 3)), Local0)
	if (LNotEqual(Local0, 4)) {
		err("", zFFF, 0xd1b, 0, 0, Local0, 4)
	}
}

// Loc to Glob

// Integer

Method(md63,, Serialized)
{
	Name(i000, 0xe0385bcd)

	Store(i000, dd04)
	Store (0x61, dd04)

	Store(DeRefof(Refof(dd04)), Local1)

	if (LNotEqual(Local1, 0x61)) {
		err("", zFFF, 0xd1c, 0, 0, Local1, 0x61)
	}
	if (LNotEqual(i000, 0xe0385bcd)) {
		err("", zFFF, 0xd1d, 0, 0, i000, 0xe0385bcd)
	}
}

// String

Method(md64,, Serialized)
{
	Name(s000, "String")

	Store(s000, dd05)
	Store(Refof(dd05), Local0)
	Store (0x61, Index(DeRefof(Local0), 3))

	Store(Refof(dd05), Local0)
	Store(DeRefof(Local0), Local1)

	if (LNotEqual(Local1, "Strang")) {
		err("", zFFF, 0xd1e, 0, 0, Local1, "Strang")
	}
	if (LNotEqual(s000, "String")) {
		err("", zFFF, 0xd1f, 0, 0, s000, "String")
	}
}

// Buffer

Method(md65,, Serialized)
{
	Name(b000, Buffer() {1,2,3,4})

	Store(b000, dd06)

	Store(Refof(dd06), Local0)
	Store (0x61, Index(DeRefof(Local0), 3))
	Store(DeRefof(Local0), Local1)

	if (LNotEqual(Local1, Buffer() {1,2,3,0x61})) {
		err("", zFFF, 0xd20, 0, 0, Local1, Buffer() {1,2,3,0x61})
	}
	if (LNotEqual(b000, Buffer() {1,2,3,4})) {
		err("", zFFF, 0xd21, 0, 0, b000, Buffer() {1,2,3,4})
	}
}

// Package

Method(md66,, Serialized)
{
	Name(pppp, Package(1){Buffer() {1,2,3,4}})

	Store(pppp, dd07)
	Store(Refof(dd07), Local0)
	Store (0x61, Index(DerefOf(Index(DeRefof(Local0), 0)), 3))

	// dd07

	Store(DeRefof(Index(DerefOf(Index(DeRefof(Local0), 0)), 0)), Local1)
	if (LNotEqual(Local1, 1)) {
		err("", zFFF, 0xd22, 0, 0, Local1, 1)
	}
	Store(DeRefof(Index(DerefOf(Index(DeRefof(Local0), 0)), 1)), Local1)
	if (LNotEqual(Local1, 2)) {
		err("", zFFF, 0xd23, 0, 0, Local1, 2)
	}
	Store(DeRefof(Index(DerefOf(Index(DeRefof(Local0), 0)), 2)), Local1)
	if (LNotEqual(Local1, 3)) {
		err("", zFFF, 0xd24, 0, 0, Local1, 3)
	}
	Store(DeRefof(Index(DerefOf(Index(DeRefof(Local0), 0)), 3)), Local1)
	if (LNotEqual(Local1, 0x61)) {
		err("", zFFF, 0xd25, 0, 0, Local1, 0x61)
	}

	// pppp

	Store(DeRefof(Index(DerefOf(Index(pppp, 0)), 0)), Local0)
	if (LNotEqual(Local0, 1)) {
		err("", zFFF, 0xd26, 0, 0, Local0, 1)
	}
	Store(DeRefof(Index(DerefOf(Index(pppp, 0)), 1)), Local0)
	if (LNotEqual(Local0, 2)) {
		err("", zFFF, 0xd27, 0, 0, Local0, 2)
	}
	Store(DeRefof(Index(DerefOf(Index(pppp, 0)), 2)), Local0)
	if (LNotEqual(Local0, 3)) {
		err("", zFFF, 0xd28, 0, 0, Local0, 3)
	}
	Store(DeRefof(Index(DerefOf(Index(pppp, 0)), 3)), Local0)
	if (LNotEqual(Local0, 4)) {
		err("", zFFF, 0xd29, 0, 0, Local0, 4)
	}
}

Method(md67)
{
	CH03("", 0, 0xf08, 0, 0)
	md5b()
	md5c()
	md5d()
	md5e()
	md5f()
	md60()
	md61()
	md62()
	md63()
	md64()
	md65()
	md66()
	CH03("", 0, 0xf09, 0, 0)
}
