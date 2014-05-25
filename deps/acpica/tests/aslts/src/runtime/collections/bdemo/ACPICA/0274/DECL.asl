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
 * Bug 274:
 *
 * SUMMARY: Named object as element of Package is handled by ACPICA differently than by MS
 */

Method(mc74,, Serialized)
{
	Name(i000, 0xabcd0000)
	Name(i001, 0xabcd0001)
	Name(i002, 0xabcd0002)
	Name(i003, 0xabcd0003)

	Name(ii00, 0x11112222)

	Name(p000, Package() {
		i000,
		i001,
		i002,
		"i000",
		\mc74.i003,
		0xabcd0004
		})

	Method(CHCK, 4)
	{
		Store(DerefOf(Index(Arg1, Arg2)), Local0)
		if (LNotEqual(Local0, Arg0)) {
			err("", zFFF, Arg3, 0, 0, Arg0, Local0)
		}
	}

	// Choose benchmark package
	if (SLCK) {
		Store(Package() {
				"I000",
				"I001",
				"I002",
				"i000",
				"I003",
				0xabcd0004},
			Local2)
	} else {
		Store(Package() {
				0xabcd0000,
				0xabcd0001,
				0xabcd0002,
				"i000",
				0xabcd0003,
				0xabcd0004},
			Local2)
	}

	Store(DerefOf(Index(p000, 0)), Local0)
	CHCK(Local0, Local2, 0, 0x001)
	Store(DerefOf(Index(p000, 1)), Local0)
	CHCK(Local0, Local2, 1, 0x002)
	Store(DerefOf(Index(p000, 2)), Local0)
	CHCK(Local0, Local2, 2, 0x003)
	Store(DerefOf(Index(p000, 3)), Local0)
	CHCK(Local0, Local2, 3, 0x004)
	Store(DerefOf(Index(p000, 4)), Local0)
	CHCK(Local0, Local2, 4, 0x005)
	Store(DerefOf(Index(p000, 5)), Local0)
	CHCK(Local0, Local2, 5, 0x006)
}
