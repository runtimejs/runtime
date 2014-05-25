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
 * Bug 246:
 *
 * SUMMARY: Switch implementation can cause AE_ALREADY_EXISTS exception when Switch
 *          is within While
 */

Method(m17b, 0, Serialized)
{
	Store(2, Local0)
	Store(0, Local1)
	Store(0x000, Local2)

	while (Local0) {
		if (CH03("", 0, Local2, 0, 0)) {
			return
		}
		Increment(Local2)
		switch (ToInteger (Local0)) {
			case (1) {
				Store("Case 1", Debug)
				Add(Local1, 1, Local1)
			}
			case (2) {
				Store("Case 2", Debug)
				Add(Local1, 2, Local1)
			}
		}
		if (CH03("", 0, Local2, 0, 0)) {
			return
		}
		Increment(Local2)
		Decrement(Local0)
	}

	if (LNotEqual(Local1, 3)) {
		err("", zFFF, Local2, 0, 0, Local1, 3)
	}
}
