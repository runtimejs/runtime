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
 * Bug 186:
 *
 * SUMMARY: The predicate value of If/While operations is implicitly returned in slack mode
 */


Method(mf6d, 0, Serialized)
{
	Name(fl00, 0)
	Name(i000, 0xabcd0000)
	Name(i001, 0xabcd0001)

	Method(m000)
	{
		Switch (ToInteger (Store(0xabcd0000, i001))) {
			Case (0) {
				if (fl00) {
					Return (0)
				}
			}
		}
	}

	Method(m001)
	{
		if (Store(0xabcd0001, i001)) {
			if (fl00) {
				Return (0)
			}
		}
	}

	Method(m002)
	{
		While (Store(0xabcd0002, i001)) {
			if (fl00) {
				Return (0)
			}
			Break
		}
	}


	// m000

	Store(0xdddd0000, i000)

	CH03("", 0, 0x000, 0, 0)

	Store(m000, i000)

	if (SLCK) {
		CH03("", 0, 0x001, 0, 0)

		//y901: Predicate generates Implicit Return since ACPICA release 20080926	
		if (y901) {
			Store(0, Local0)
		} else {
			Store(0xabcd0000, Local0)
		}
		if (LNotEqual(i000, Local0)) {
			err("", zFFF, 0x002, 0, 0, i000, Local0)
		}
	} else {
		CH07("", 0, 0xff, 0, 0x003, 0, 0)
	}

	// m001

	Store(0xdddd0001, i000)

	CH03("", 0, 0x004, 0, 0)

	Store(m001, i000)

	if (SLCK) {
		CH03("", 0, 0x005, 0, 0)

		//y901: Predicate generates Implicit Return since ACPICA release 20080926	
		if (y901) {
			Store(0, Local0)
		} else {
			Store(0xabcd0001, Local0)
		}
		if (LNotEqual(i000, Local0)) {
			err("", zFFF, 0x006, 0, 0, i000, Local0)
		}
	} else {
		CH07("", 0, 0xff, 0, 0x007, 0, 0)
	}

	// m002

	Store(0xdddd0002, i000)

	CH03("", 0, 0x008, 0, 0)

	Store(m001, i000)

	if (SLCK) {
		CH03("", 0, 0x009, 0, 0)

		//y901: Predicate generates Implicit Return since ACPICA release 20080926	
		if (y901) {
			Store(0, Local0)
		} else {
			Store(0xabcd0002, Local0)
		}
		if (LNotEqual(i000, Local0)) {
			err("", zFFF, 0x00a, 0, 0, i000, Local0)
		}
	} else {
		CH07("", 0, 0xff, 0, 0x00b, 0, 0)
	}
}
