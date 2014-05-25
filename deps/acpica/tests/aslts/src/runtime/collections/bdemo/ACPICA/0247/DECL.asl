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
 * Bug 247:
 *
 * SUMMARY: ASL compiler incorrectly implements Break within Switch
 */

Method(m17c,, Serialized)
{
	Name(ERRN, 0x000)

	Method(m000, 3)
	{
		Name(CH10, 0)
		Name(CH11, 0)
		Name(CH20, 0)
		Name(CH21, 0)

		Store(arg0, Debug)
		Store(2, Local0)

		while (Local0) {
			if (CH03("", 0, ERRN, 0, 0)) {
				return
			}
			Increment(ERRN)
			switch (Local0) {
				case (1) {
					if (Arg1) {
						Store(1, CH10)
						Break
					}
					Store(1, CH11)
				}
				case (2) {
					if (Arg2) {
						Store(1, CH20)
						Break
					}
					Store(1, CH21)
				}
			}
			if (CH03("", 0, ERRN, 0, 0)) {
				return
			}
			Increment(ERRN)
			Decrement(Local0)
		}

		if (LNotEqual(CH10, Arg1)) {
			err("", zFFF, ERRN, 0, 0, CH10, Arg1)
		}
		Increment(ERRN)
		if (LEqual(CH11, Arg1)) {
			err("", zFFF, ERRN, 0, 0, CH11, Arg1)
		}
		Increment(ERRN)
		if (LNotEqual(CH20, Arg2)) {
			err("", zFFF, ERRN, 0, 0, CH20, Arg2)
		}
		Increment(ERRN)
		if (LEqual(CH21, Arg2)) {
			err("", zFFF, ERRN, 0, 0, CH21, Arg2)
		}
		Increment(ERRN)
	}

	m000("No Breaks", 0, 0)
	m000("Break 2", 0, 1)
	m000("Break 1", 1, 0)
	m000("2 Breaks", 1, 1)
}
