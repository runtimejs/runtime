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
 * Data type conversion and manipulation
 *
 * SizeOf, Get the size of Integer, Buffer, String or Package
 */

Name(z041, 41)

// Simplest test of SizeOf for all available type objects
Method(m1ef,, Serialized)
{
	Name(ts, "m1ef")

	Name(i000, 0)
	Name(s000, "vcd")
	Name(b000, Buffer() {1,2,3,4,5})
	Name(p000, Package() {11,12,13,14,15,16,17})

	Store(SizeOf(i000), Local0)
	if (LEqual(F64, 1)) {
		if (LNotEqual(Local0, 8)) {
			err(ts, z041, 0, 0, 0, Local0, 8)
		}
	} else {
		if (LNotEqual(Local0, 4)) {
			err(ts, z041, 1, 0, 0, Local0, 4)
		}
	}

	Store(SizeOf(s000), Local0)
	if (LNotEqual(Local0, 3)) {
		err(ts, z041, 2, 0, 0, Local0, 3)
	}

	Store(SizeOf(b000), Local0)
	if (LNotEqual(Local0, 5)) {
		err(ts, z041, 3, 0, 0, Local0, 5)
	}

	Store(SizeOf(p000), Local0)
	if (LNotEqual(Local0, 7)) {
		err(ts, z041, 4, 0, 0, Local0, 7)
	}
}

// Run-method
Method(SZO0)
{
	Store("TEST: SZO0, Get the size of Integer, Buffer, String or Package:", Debug)

	m1ef()
}
