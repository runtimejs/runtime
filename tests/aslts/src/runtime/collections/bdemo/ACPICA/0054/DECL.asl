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
 * Bug 0054:
 *
 * SUMMARY: All ASL Operators causes exceptions on two immediately passed Buffers
 *
 * All the ASL Operators which deal with
 * at least two Buffer type objects cause
 * unexpected exceptions in cases when both
 * Buffer type objects are passed immediately.
 */

Method(mddf,, Serialized)
{
	Name(b000, Buffer() {0x79, 0x00})
	Name(b001, Buffer() {0x79, 0x00})

	Store(ConcatenateResTemplate( b000, b001 ), Local0)
	if (LNotEqual(Local0, Buffer() {0x79, 0x00})) {
		err("", zFFF, 0x000, 0, 0, Local0, Buffer() {0x79, 0x00})
	}
}

// ConcatenateResTemplate

Method(mde0,, Serialized)
{
	Name(b000, Buffer() {0x79, 0x00})

	Store(ConcatenateResTemplate( b000, Buffer() {0x79, 0x00} ), Local0)
	if (LNotEqual(Local0, Buffer() {0x79, 0x00})) {
		err("", zFFF, 0x001, 0, 0, Local0, Buffer() {0x79, 0x00})
	}

	Store(ConcatenateResTemplate( Buffer() {0x79, 0x00}, b000 ), Local0)
	if (LNotEqual(Local0, Buffer() {0x79, 0x00})) {
		err("", zFFF, 0x002, 0, 0, Local0, Buffer() {0x79, 0x00})
	}
}

Method(mde1)
{
	Store(ConcatenateResTemplate( Buffer() {0x79, 0x00}, Buffer() {0x79, 0x00} ), Local0)
	if (LNotEqual(Local0, Buffer() {0x79, 0x00})) {
		err("", zFFF, 0x003, 0, 0, Local0, Buffer() {0x79, 0x00})
	}
}

// LEqual

Method(mde2,, Serialized)
{
	Name(b000, Buffer() {0x79})

	Store(LEqual( b000, Buffer(1) {0x79} ), Local0)
	if (LNotEqual(Local0, Ones)) {
		err("", zFFF, 0x004, 0, 0, Local0, Ones)
	}

	Store(LEqual( Buffer(1) {0x79}, b000 ), Local0)
	if (LNotEqual(Local0, Ones)) {
		err("", zFFF, 0x005, 0, 0, Local0, Ones)
	}
}

Method(mde3)
{
	Store(LEqual( Buffer(1) {0x79}, Buffer(1) {0x79} ), Local0)
	if (LNotEqual(Local0, Ones)) {
		err("", zFFF, 0x006, 0, 0, Local0, Ones)
	}
}

// LGreater

Method(mde4,, Serialized)
{
	Name(b000, Buffer() {0x79})

	Store(LGreater( b000, Buffer(1) {0x79} ), Local0)
	if (LNotEqual(Local0, Zero)) {
		err("", zFFF, 0x007, 0, 0, Local0, Zero)
	}

	Store(LGreater( Buffer(1) {0x79}, b000 ), Local0)
	if (LNotEqual(Local0, Zero)) {
		err("", zFFF, 0x008, 0, 0, Local0, Zero)
	}
}

Method(mde5)
{
	Store(LGreater( Buffer(1) {0x79}, Buffer(1) {0x79} ), Local0)
	if (LNotEqual(Local0, Zero)) {
		err("", zFFF, 0x009, 0, 0, Local0, Zero)
	}
}

// ..........

// Concatenate

Method(mde6,, Serialized)
{
	Name(b000, Buffer() {0x79})

	Store(Concatenate( b000, Buffer() {0x79} ), Local0)
	if (LNotEqual(Local0, Buffer() {0x79, 0x79})) {
		err("", zFFF, 0x00a, 0, 0, Local0, Buffer() {0x79, 0x79})
	}

	Store(Concatenate( Buffer() {0x79}, b000 ), Local0)
	if (LNotEqual(Local0, Buffer() {0x79, 0x79})) {
		err("", zFFF, 0x00b, 0, 0, Local0, Buffer() {0x79, 0x79})
	}
}

Method(mde7)
{
	Store(Concatenate( Buffer() {0x79}, Buffer() {0x79} ), Local0)
	if (LNotEqual(Local0, Buffer() {0x79, 0x79})) {
		err("", zFFF, 0x00c, 0, 0, Local0, Buffer() {0x79, 0x79})
	}
}

// Add

Method(mde8,, Serialized)
{
	Name(b000, Buffer() {0x79})

	Add( b000, Buffer() {0x79}, Local0)
	if (LNotEqual(Local0, 0xf2)) {
		err("", zFFF, 0x00d, 0, 0, Local0, 0xf2)
	}

	Add( Buffer() {0x79}, b000, Local0)
	if (LNotEqual(Local0, 0xf2)) {
		err("", zFFF, 0x00e, 0, 0, Local0, 0xf2)
	}
}

Method(mde9)
{
	Add( Buffer() {0x79}, Buffer() {0x79}, Local0)
	if (LNotEqual(Local0, 0xf2)) {
		err("", zFFF, 0x00f, 0, 0, Local0, 0xf2)
	}
}

// ..........

Method(mdea)
{
	mddf()

	// ConcatenateResTemplate
	mde0()
	mde1()

	// LEqual
	mde2()
	mde3()

	// LGreater
	mde4()
	mde5()

	// Concatenate
	mde6()
	mde7()

	// Add
	mde8()
	mde9()
}
