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
 * Bug 0058:
 *
 * SUMMARY: Concatenate of two Integers may operates in 32-bit mode as in 64-bit mode
 *
 * These are three appearances probably
 * of one the same differently looking bug.
 * Concatenate Operator seems to have
 * indirect effect in all those cases.
 */

Method(mdf5, 1)
{
	Store("Run mdf5:", Debug)

	if (arg0) {
		Store("===================== 0:", Debug)
		Store(Concatenate(1, 2), Local0)
		if (F64) {
			if (LNotEqual(Local0, Buffer() {1,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0})){
				err("", zFFF, 0x000, 0, 0, Local0, Buffer() {1,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0})
			}
		} else {
			if (LNotEqual(Local0, Buffer() {1,0,0,0,2,0,0,0})){
				err("", zFFF, 0x001, 0, 0, Local0, Buffer() {1,0,0,0,2,0,0,0})
			}
		}
	} else {
		Store("===================== 1:", Debug)
	}
}

Method(mdf6, 1)
{
	Store("Run mdf6:", Debug)

	if (arg0) {
		Store("===================== 2:", Debug)
		Store(Concatenate(0x1234, 0x7890), Local0)
		if (F64) {
			if (LNotEqual(Local0, Buffer() {0x34,0x12,0,0,0,0,0,0,0x90,0x78,0,0,0,0,0,0})){
				err("", zFFF, 0x002, 0, 0, Local0, Buffer() {0x34,0x12,0,0,0,0,0,0,0x90,0x78,0,0,0,0,0,0})
			}
		} else {
			if (LNotEqual(Local0, Buffer() {0x34,0x12,0,0,0x90,0x78,0,0})){
				err("", zFFF, 0x003, 0, 0, Local0, Buffer() {0x34,0x12,0,0,0x90,0x78,0,0})
			}
		}
	} else {
		Store("===================== 3:", Debug)
	}
}

Method(mdf7)
{
	Store("Run mdf7:", Debug)
	Store(Concatenate(1, 2), Local0)
	if (F64) {
		if (LNotEqual(Local0, Buffer() {1,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0})){
			err("", zFFF, 0x004, 0, 0, Local0, Buffer() {1,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0})
		}
	} else {
		if (LNotEqual(Local0, Buffer() {1,0,0,0,2,0,0,0})){
			err("", zFFF, 0x005, 0, 0, Local0, Buffer() {1,0,0,0,2,0,0,0})
		}
	}
	Store(Local0, Debug)
}

Method(mdf8)
{
	mdf5(0)
	mdf6(0)
	mdf7()
	mdf5(1)
	mdf6(1)
}
