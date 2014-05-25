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
 * Bug 0093:
 *
 * SUMMARY: Invalid result of Index operator passed with the immediate image of Buffer
 */

	Method(me42, 1, Serialized)
	{
		Name(b000, Buffer() {11,22,33,44,55,66,77,88})

		if (LEqual(Arg0, 0)) {

			Store("Buffer as a named object:", Debug)

			CH03("", 0, 0x000, 0, 0)
			Store(DerefOf(Index(b000, 5)), Local0)
			if (LNotEqual(Local0, 66)) {
				err("", zFFF, 0x001, 0, 0, Local0, 66)
			}
			CH03("", 0, 0x002, 0, 0)

		} elseif (LEqual(Arg0, 1)) {

			Store("The same Buffer but substituted immediately:", Debug)

			CH03("", 0, 0x003, 0, 0)
			Store(Index(Buffer() {11,22,33,44,55,66,77,88}, 5), Local1)
			if (y900) {
				Store(DerefOf(Local1), Local0)
				if (LNotEqual(Local0, 66)) {
					err("", zFFF, 0x004, 0, 0, Local0, 66)
				}
				CH03("", 0, 0x005, 0, 0)
			} else {
				CH04("", 0, 0xff, 0, 0x006, 0, 0) // AE_INDEX_TO_NOT_ATTACHED
			}

		} else {

			CH03("", 0, 0x007, 0, 0)
			Store(DerefOf(Index(Buffer() {11,22,33,44,55,66,77,88}, 5)), Local0)
			if (y900) {
				if (LNotEqual(Local0, 66)) {
					err("", zFFF, 0x008, 0, 0, Local0, 66)
				}
				CH03("", 0, 0x009, 0, 0)
			} else {
				CH04("", 0, 0xff, 0, 0x00a, 0, 0) // AE_INDEX_TO_NOT_ATTACHED
			}
		}
	}

	Method(me43)
	{
		// 0,1 - success,   2 - crash
		me42(0)
		me42(1)
		me42(2)

		return (0)
	}


