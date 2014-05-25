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
 * Bug 0180:
 *
 * SUMMARY: Failed to compiler Switch/Case operators
 */

Method(me89, 1, Serialized)
{
	Store(0xff, Local0)

	Switch (ToInteger (arg0)) {
		Case (0) {
			Store(0, Local0)
		}
		Case (1) {
			Store(1, Local0)
		}
		Default {
			Store(2, Local0)
		}
	}

	if (LEqual(arg0, 0)) {
		if (LNotEqual(Local0, 0)) {
			err("", zFFF, 0x000, 0, 0, Local0, 0)
		}
	}
	if (LEqual(arg0, 1)) {
		if (LNotEqual(Local0, 1)) {
			err("", zFFF, 0x000, 0, 0, Local0, 1)
		}
	}
	if (LEqual(arg0, 2)) {
		if (LNotEqual(Local0, 2)) {
			err("", zFFF, 0x000, 0, 0, Local0, 2)
		}
	}
}

Method(me8a)
{
	me89(0)
	me89(1)
	me89(2)
}
