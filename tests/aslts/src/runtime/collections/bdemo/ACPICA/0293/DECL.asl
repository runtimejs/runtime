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
 * Bug 293:
 *
 * SUMMARY: Incorrect zero-length Buffer to String conversion
 */

Method(m293)
{
	// Prepare zero-length Buffer
	Store(0, Local0)
	Store(Buffer(Local0){}, Local1)

	Store(ToHexString(Local1), Local2)
	Store(Local2, Debug)
	Store(Sizeof(Local2), Debug)

	Store(ToDecimalString(Local1), Local3)
	Store(Local3, Debug)
	Store(Sizeof(Local3), Debug)

	If (LNotEqual(Sizeof(Local2), 0)) {
		err("", zFFF, 0x001, 0, 0, Sizeof(Local2), 0)
	}

	If (LNotEqual(Sizeof(Local3), 0)) {
		err("", zFFF, 0x001, 0, 0, Sizeof(Local3), 0)
	}

	If (LNotEqual("", Local1)) {
		err("", zFFF, 0x001, 0, 0, "", Local1)
	}

	If (LNotEqual("", Local2)) {
		err("", zFFF, 0x001, 0, 0, "", Local2)
	}

	If (LNotEqual("", Local3)) {
		err("", zFFF, 0x001, 0, 0, "", Local3)
	}

	If (LNotEqual(Local2, Local3)) {
		err("", zFFF, 0x001, 0, 0, Local2, Local3)
	}

	If (LNotEqual(Local2, Local1)) {
		err("", zFFF, 0x001, 0, 0, Local2, Local1)
	}

	If (LNotEqual(Local3, Local1)) {
		err("", zFFF, 0x001, 0, 0, Local3, Local1)
	}
}
