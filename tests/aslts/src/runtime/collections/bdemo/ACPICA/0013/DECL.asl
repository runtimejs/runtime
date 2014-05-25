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
 * Bug 0013:
 *
 * SUMMARY: The type returned by ObjectType for Object created by Create*Field operator is not BufferField
 */

Method(mdad)
{
	Store(Buffer(100) {}, Local0)

	CreateBitField   (Local0, 0,     bf00)
	CreateByteField  (Local0, 0,     bf01)
	CreateDWordField (Local0, 0,     bf02)
	CreateField      (Local0, 0, 32, bf03)
	CreateField      (Local0, 0, 64, bf04)
	CreateField      (Local0, 0, 65, bf05)
	CreateQWordField (Local0, 0,     bf06)
	CreateWordField  (Local0, 0,     bf07)

	Store(ObjectType(bf00), Local7)
	if (LNotEqual(Local7, c016)) {
		err("", zFFF, 0x000, 0, 0, Local7, c016)
	}

	Store(ObjectType(bf01), Local7)
	if (LNotEqual(Local7, c016)) {
		err("", zFFF, 0x001, 0, 0, Local7, c016)
	}

	Store(ObjectType(bf02), Local7)
	if (LNotEqual(Local7, c016)) {
		err("", zFFF, 0x002, 0, 0, Local7, c016)
	}

	Store(ObjectType(bf03), Local7)
	if (LNotEqual(Local7, c016)) {
		err("", zFFF, 0x003, 0, 0, Local7, c016)
	}

	Store(ObjectType(bf04), Local7)
	if (LNotEqual(Local7, c016)) {
		err("", zFFF, 0x004, 0, 0, Local7, c016)
	}

	Store(ObjectType(bf05), Local7)
	if (LNotEqual(Local7, c016)) {
		err("", zFFF, 0x005, 0, 0, Local7, c016)
	}

	Store(ObjectType(bf06), Local7)
	if (LNotEqual(Local7, c016)) {
		err("", zFFF, 0x006, 0, 0, Local7, c016)
	}

	Store(ObjectType(bf07), Local7)
	if (LNotEqual(Local7, c016)) {
		err("", zFFF, 0x007, 0, 0, Local7, c016)
	}
}
