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
 * ns2 originated but has names from root
 */

/*
 * Element of Package instead of i000 (in m001)
 */
Method(m203, 1, Serialized)
{
	Name(ts, "m203")
	Name(i001, 0)
	Name(p000, Package() {1,2,3,4})
	Device(d000)
	{
		Name(pp00, Package() {0x11111111, 0x00000001, 0x22223333})
	}

	CH03(ts, z156, 0x006, 0, 0)

	Store(arg0, i001)

	Method(m001)
	{
		Method(m002)
		{
			Method(m003)
			{
				Method(m004)
				{
					Method(m005)
					{
						Method(m006)
						{
							Method(m007)
							{
								Method(m008)
								{
									if (i001)
									{
										Store(p000, Index(\m203.d000.pp00, 1))
									}
									Return (0)
								}
								Store(0x80000000, Index(\m203.d000.pp00, 1))
								Return (Add(DerefOf(Index(\m203.d000.pp00, 1)), m008()))
							}
							Store(0x07000000, Index(\m203.d000.pp00, 1))
							Return (Add(DerefOf(Index(\m203.d000.pp00, 1)), m007()))
						}
						Store(0x00600000, Index(\m203.d000.pp00, 1))
						Return (Add(DerefOf(Index(\m203.d000.pp00, 1)), m006()))
					}
					Store(0x00050000, Index(\m203.d000.pp00, 1))
					Return (Add(DerefOf(Index(\m203.d000.pp00, 1)), m005()))
				}
				Store(0x00004000, Index(\m203.d000.pp00, 1))
				Return (Add(DerefOf(Index(\m203.d000.pp00, 1)), m004()))
			}
			Store(0x00000300, Index(\m203.d000.pp00, 1))
			Return (Add(DerefOf(Index(\m203.d000.pp00, 1)), m003()))
		}
		Store(0x00000020, Index(^d000.pp00, 1))
		Return (Add(DerefOf(Index(^d000.pp00, 1)), m002()))
	}
	Store(Add(DerefOf(Index(d000.pp00, 1)), m001()), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z156, 0x007, 0, 0, Local0, 0x87654321)
	}

	Store(DerefOf(Index(d000.pp00, 1)), Local0)

	if (LNotEqual(Local0, 0x80000000)) {
		err(ts, z156, 0x008, 0, 0, Local0, 0x80000000)
	}

	CH03(ts, z156, 0x009, 0, 0)
}

/*
 * Buffer Field instead of i000 (in m001)
 */
Method(m205, 1, Serialized)
{
	Name(ts, "m205")
	Name(i001, 0)
	Name(p000, Package() {1,2,3,4})

	CH03(ts, z156, 0x00d, 0, 0)

	Device(d000)
	{
		Name(b000, Buffer(16) {})
		CreateField(b000, 5, 32, bf00)
	}

	CH03(ts, z156, 0x00e, 0, 0)

	if (0) {
		CreateField(d000.b000, 5, 32, bf00)
	}

	Store(arg0, i001)

	Method(m001)
	{
		Method(m002)
		{
			Method(m003)
			{
				Method(m004)
				{
					Method(m005)
					{
						Method(m006)
						{
							Method(m007)
							{
								Method(m008)
								{
									if (i001)
									{
										Store(p000, Index(\m205.d000.bf00, 1))
									}
									Return (0)
								}
								Store(0x80000000, Index(\m205.d000.bf00, 1))
								Return (Add(DerefOf(Index(\m205.d000.bf00, 1)), m008()))
							}
							Store(0x07000000, Index(\m205.d000.bf00, 1))
							Return (Add(DerefOf(Index(\m205.d000.bf00, 1)), m007()))
						}
						Store(0x00600000, Index(\m205.d000.bf00, 1))
						Return (Add(DerefOf(Index(\m205.d000.bf00, 1)), m006()))
					}
					Store(0x00050000, Index(\m205.d000.bf00, 1))
					Return (Add(DerefOf(Index(\m205.d000.bf00, 1)), m005()))
				}
				Store(0x00004000, Index(\m205.d000.bf00, 1))
				Return (Add(DerefOf(Index(\m205.d000.bf00, 1)), m004()))
			}
			Store(0x00000300, Index(\m205.d000.bf00, 1))
			Return (Add(DerefOf(Index(\m205.d000.bf00, 1)), m003()))
		}
		Store(0x00000020, Index(^d000.bf00, 1))
		Return (Add(DerefOf(Index(^d000.bf00, 1)), m002()))
	}
	Store(Add(DerefOf(Index(d000.bf00, 1)), m001()), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z156, 0x00f, 0, 0, Local0, 0x87654321)
	}

	Store(DerefOf(Index(d000.bf00, 1)), Local0)

	if (LNotEqual(Local0, 0x80000000)) {
		err(ts, z156, 0x010, 0, 0, Local0, 0x80000000)
	}

	CH03(ts, z156, 0x011, 0, 0)
}

Method(n102)
{
if (1) {

	SRMT("m203-0")
	m203(0)
	SRMT("m203-1")
	if (y200) {
		m203(1)
	} else {
		BLCK()
	}
	SRMT("m205-0")
	if (y216) {
		m205(0)
	} else {
		BLCK()
	}
	SRMT("m205-1")
	if (LAnd(y200, y216)) {
		m205(1)
	} else {
		BLCK()
	}
} else {
	SRMT("m205-0")
	m205(0)
}
}

