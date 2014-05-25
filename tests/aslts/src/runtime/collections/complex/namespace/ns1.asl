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

Name(z155, 155)

/*
 * Three tests below are here
 * as specific type arguments passing -
 * arguments though passed directly to method, not as references,
 * nevertheless allow access to the elements of original objects.
 */

Method(m100,, Serialized)
{
	Name(ts, "m100")
	Name(p000, Package() {0xabcd0000, 0xabcd0001, 0xabcd0002})
	Method(m001, 2)
	{
		Store(0x11112222, Index(arg0, 0))
	}

	m001(p000, RefOf(p000))

	Store(DerefOf(Index(p000, 0)), Local0)

	if (LNotEqual(Local0, 0x11112222)) {
		err(ts, z155, 0x000, 0, 0, Local0, 0x11112222)
	}

	CH03(ts, z155, 0x001, 0, 0)
}

Method(m101,, Serialized)
{
	Name(ts, "m101")
	Name(b000, Buffer() {0x10, 0x11, 0x12})
	Method(m001, 2)
	{
		Store(0x67, Index(arg0, 0))
	}

	m001(b000, RefOf(b000))

	Store(DerefOf(Index(b000, 0)), Local0)

	if (LNotEqual(Local0, 0x67)) {
		err(ts, z155, 0x002, 0, 0, Local0, 0x67)
	}

	CH03(ts, z155, 0x003, 0, 0)
}

Method(m102,, Serialized)
{
	Name(ts, "m102")
	Name(s000, "qqqqqqqqqqqqqq")
	Method(m001, 2)
	{
		Store(0x38, Index(arg0, 0))
	}

	m001(s000, RefOf(s000))

	Store(DerefOf(Index(s000, 0)), Local0)

	if (LNotEqual(Local0, 0x38)) {
		err(ts, z155, 0x004, 0, 0, Local0, 0x38)
	}

	CH03(ts, z155, 0x005, 0, 0)
}

/*
 * Element of Package instead of i000 (in m001)
 */
Method(m103, 1, Serialized)
{
	Name(ts, "m103")
	Name(i001, 0)
	Name(p000, Package() {1,2,3,4})
	Name(pp00, Package() {0x11111111, 0x00000001, 0x22223333})

	CH03(ts, z155, 0x006, 0, 0)

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
										Store(p000, Index(pp00, 1))
									}
									Return (0)
								}
								Store(0x80000000, Index(pp00, 1))
								Return (Add(DerefOf(Index(pp00, 1)), m008()))
							}
							Store(0x07000000, Index(pp00, 1))
							Return (Add(DerefOf(Index(pp00, 1)), m007()))
						}
						Store(0x00600000, Index(pp00, 1))
						Return (Add(DerefOf(Index(pp00, 1)), m006()))
					}
					Store(0x00050000, Index(pp00, 1))
					Return (Add(DerefOf(Index(pp00, 1)), m005()))
				}
				Store(0x00004000, Index(pp00, 1))
				Return (Add(DerefOf(Index(pp00, 1)), m004()))
			}
			Store(0x00000300, Index(pp00, 1))
			Return (Add(DerefOf(Index(pp00, 1)), m003()))
		}
		Store(0x00000020, Index(pp00, 1))
		Return (Add(DerefOf(Index(pp00, 1)), m002()))
	}
	Store(Add(DerefOf(Index(pp00, 1)), m001()), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z155, 0x007, 0, 0, Local0, 0x87654321)
	}

	Store(DerefOf(Index(pp00, 1)), Local0)

	if (LNotEqual(Local0, 0x80000000)) {
		err(ts, z155, 0x008, 0, 0, Local0, 0x80000000)
	}

	CH03(ts, z155, 0x009, 0, 0)
}

/*
 * Element of Package instead of i000 (in m002)
 */
Method(m104,, Serialized)
{
	Name(ts, "m104")
	Name(i001, 0)
	Name(pp00, Package() {0x11111111, 0x00100000, 0x22223333})

	Method(m001)
	{
		if (LLess(i001, 100)) {

			Store(DerefOf(Index(pp00, 1)), Local0)
			Increment(Local0)
			Store(Local0, Index(pp00, 1))
			Increment(i001)
			Add(DerefOf(Index(pp00, 1)), m001(), Local0)
			Return (Local0)
		}
		Return (0)
	}
	Store(Add(DerefOf(Index(pp00, 1)), m001()), Local0)

	if (LNotEqual(Local0, 0x065013BA)) {
		err(ts, z155, 0x00a, 0, 0, Local0, 0x065013BA)
	}

	Store(DerefOf(Index(pp00, 1)), Local0)

	if (LNotEqual(Local0, 0x00100064)) {
		err(ts, z155, 0x00b, 0, 0, Local0, 0x00100064)
	}

	CH03(ts, z155, 0x00c, 0, 0)
}

/*
 * Buffer Field instead of i000 (in m001)
 */
Method(m105, 1, Serialized)
{
	Name(ts, "m105")
	Name(i001, 0)
	Name(b000, Buffer(16) {})
	CreateField(b000, 5, 32, bf00)

	CH03(ts, z155, 0x00d, 0, 0)

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
										Store(0x11223344, bf00)
									}
									Return (0)
								}
								Store(0x80000000, bf00)
								Return (Add(bf00, m008()))
							}
							Store(0x07000000, bf00)
							Return (Add(bf00, m007()))
						}
						Store(0x00600000, bf00)
						Return (Add(bf00, m006()))
					}
					Store(0x00050000, bf00)
					Return (Add(bf00, m005()))
				}
				Store(0x00004000, bf00)
				Return (Add(bf00, m004()))
			}
			Store(0x00000300, bf00)
			Return (Add(bf00, m003()))
		}
		Store(0x00000020, bf00)
		Return (Add(bf00, m002()))
	}

	Store(0x00000001, bf00)

	Store(Add(bf00, m001()), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z155, 0x00e, 0, 0, Local0, 0x87654321)
	}

	if (arg0) {
		Store(0x11223344, Local1)
	} else {
		Store(0x80000000, Local1)
	}

	if (LNotEqual(bf00, Local1)) {
		err(ts, z155, 0x00f, 0, 0, bf00, Local1)
	}

	CH03(ts, z155, 0x010, 0, 0)
}

/*
 * Field instead of i000 (in m001)
 */
Method(m106, 1, Serialized)
{
	Name(ts, "m106")
	Name(i001, 0)
	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	Field(r000, ByteAcc, NoLock, Preserve) { f000,32, f001,32 }

	CH03(ts, z155, 0x011, 0, 0)

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
										Store(0x11223344, f001)
									}
									Return (0)
								}
								Store(0x80000000, f001)
								Return (Add(f001, m008()))
							}
							Store(0x07000000, f001)
							Return (Add(f001, m007()))
						}
						Store(0x00600000, f001)
						Return (Add(f001, m006()))
					}
					Store(0x00050000, f001)
					Return (Add(f001, m005()))
				}
				Store(0x00004000, f001)
				Return (Add(f001, m004()))
			}
			Store(0x00000300, f001)
			Return (Add(f001, m003()))
		}
		Store(0x00000020, f001)
		Return (Add(f001, m002()))
	}

	Store(0x00000001, f001)

	Store(Add(f001, m001()), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z155, 0x012, 0, 0, Local0, 0x87654321)
	}

	if (arg0) {
		Store(0x11223344, Local1)
	} else {
		Store(0x80000000, Local1)
	}

	if (LNotEqual(f001, Local1)) {
		err(ts, z155, 0x013, 0, 0, f001, Local1)
	}

	CH03(ts, z155, 0x014, 0, 0)
}

/*
 * Bank Field instead of i000 (in m001)
 *
 * (is this test correct?)
 */
Method(m107, 1, Serialized)
{
	Name(ts, "m107")
	Name(i001, 0)
	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	Field(r000, ByteAcc, NoLock, Preserve) { f000,32, f001,32 }
	BankField(r000, f001, 0, ByteAcc, NoLock, Preserve) { bnk0, 32 }

	CH03(ts, z155, 0x015, 0, 0)

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
										Store(0x11223344, bnk0)
									}
									Return (0)
								}
								Store(0x80000000, bnk0)
								Return (Add(bnk0, m008()))
							}
							Store(0x07000000, bnk0)
							Return (Add(bnk0, m007()))
						}
						Store(0x00600000, bnk0)
						Return (Add(bnk0, m006()))
					}
					Store(0x00050000, bnk0)
					Return (Add(bnk0, m005()))
				}
				Store(0x00004000, bnk0)
				Return (Add(bnk0, m004()))
			}
			Store(0x00000300, bnk0)
			Return (Add(bnk0, m003()))
		}
		Store(0x00000020, bnk0)
		Return (Add(bnk0, m002()))
	}

	Store(0x00000001, bnk0)

	Store(Add(bnk0, m001()), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z155, 0x016, 0, 0, Local0, 0x87654321)
	}

	if (arg0) {
		Store(0x11223344, Local1)
	} else {
		Store(0x80000000, Local1)
	}

	if (LNotEqual(bnk0, Local1)) {
		err(ts, z155, 0x017, 0, 0, bnk0, Local1)
	}

	CH03(ts, z155, 0x018, 0, 0)
}

/*
 * Index Field instead of i000 (in m001)
 *
 * (is this test correct?)
 */
Method(m108, 1, Serialized)
{
	Name(ts, "m108")
	Name(i001, 0)
	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	Field(r000, ByteAcc, NoLock, Preserve) { f000,32, f001,32 }
	IndexField(f000, f001, ByteAcc, NoLock, Preserve) { if00, 32 }

	CH03(ts, z155, 0x019, 0, 0)

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
										Store(0x11223344, if00)
									}
									Return (0)
								}
								Store(0x80000000, if00)
								Return (Add(if00, m008()))
							}
							Store(0x07000000, if00)
							Return (Add(if00, m007()))
						}
						Store(0x00600000, if00)
						Return (Add(if00, m006()))
					}
					Store(0x00050000, if00)
					Return (Add(if00, m005()))
				}
				Store(0x00004000, if00)
				Return (Add(if00, m004()))
			}
			Store(0x00000300, if00)
			Return (Add(if00, m003()))
		}
		Store(0x00000020, if00)
		Return (Add(if00, m002()))
	}

	Store(0x00000001, if00)

	Store(Add(if00, m001()), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z155, 0x01a, 0, 0, Local0, 0x87654321)
	}

	if (arg0) {
		Store(0x11223344, Local1)
	} else {
		Store(0x80000000, Local1)
	}

	if (LNotEqual(if00, Local1)) {
		err(ts, z155, 0x01b, 0, 0, if00, Local1)
	}

	CH03(ts, z155, 0x01c, 0, 0)
}

/*
 * Element of Buffer instead of i000 (in m001)
 */
Method(m109, 1, Serialized)
{
	Name(ts, "m109")
	Name(i001, 0)
	Name(b000, Buffer() {0x11, 0x01, 0x22})

	CH03(ts, z155, 0x01d, 0, 0)

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
										Store(0xff, Index(b000, 1))
									}
									Return (0)
								}
								Store(0x08, Index(b000, 1))
								Return (Add(DerefOf(Index(b000, 1)), m008()))
							}
							Store(0x07, Index(b000, 1))
							Return (Add(DerefOf(Index(b000, 1)), m007()))
						}
						Store(0x06, Index(b000, 1))
						Return (Add(DerefOf(Index(b000, 1)), m006()))
					}
					Store(0x05, Index(b000, 1))
					Return (Add(DerefOf(Index(b000, 1)), m005()))
				}
				Store(0x04, Index(b000, 1))
				Return (Add(DerefOf(Index(b000, 1)), m004()))
			}
			Store(0x03, Index(b000, 1))
			Return (Add(DerefOf(Index(b000, 1)), m003()))
		}
		Store(0x02, Index(b000, 1))
		Return (Add(DerefOf(Index(b000, 1)), m002()))
	}
	Store(Add(DerefOf(Index(b000, 1)), m001()), Local0)

	if (LNotEqual(Local0, 0x24)) {
		err(ts, z155, 0x01e, 0, 0, Local0, 0x24)
	}

	Store(DerefOf(Index(b000, 1)), Local0)

	if (arg0) {
		Store(0xff, Local1)
	} else {
		Store(0x08, Local1)
	}

	if (LNotEqual(Local0, Local1)) {
		err(ts, z155, 0x01f, 0, 0, Local0, Local1)
	}

	CH03(ts, z155, 0x020, 0, 0)
}

/*
 * Element of String instead of i000 (in m001)
 */
Method(m10a, 1, Serialized)
{
	Name(ts, "m10a")
	Name(i001, 0)
	Name(s000, "q\001ertyuiop")

	CH03(ts, z155, 0x021, 0, 0)

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
										Store(0xff, Index(s000, 1))
									}
									Return (0)
								}
								Store(0x08, Index(s000, 1))
								Return (Add(DerefOf(Index(s000, 1)), m008()))
							}
							Store(0x07, Index(s000, 1))
							Return (Add(DerefOf(Index(s000, 1)), m007()))
						}
						Store(0x06, Index(s000, 1))
						Return (Add(DerefOf(Index(s000, 1)), m006()))
					}
					Store(0x05, Index(s000, 1))
					Return (Add(DerefOf(Index(s000, 1)), m005()))
				}
				Store(0x04, Index(s000, 1))
				Return (Add(DerefOf(Index(s000, 1)), m004()))
			}
			Store(0x03, Index(s000, 1))
			Return (Add(DerefOf(Index(s000, 1)), m003()))
		}
		Store(0x02, Index(s000, 1))
		Return (Add(DerefOf(Index(s000, 1)), m002()))
	}
	Store(Add(DerefOf(Index(s000, 1)), m001()), Local0)

	if (LNotEqual(Local0, 0x24)) {
		err(ts, z155, 0x022, 0, 0, Local0, 0x24)
	}

	Store(DerefOf(Index(s000, 1)), Local0)

	if (arg0) {
		Store(0xff, Local1)
	} else {
		Store(0x08, Local1)
	}

	if (LNotEqual(Local0, Local1)) {
		err(ts, z155, 0x023, 0, 0, Local0, Local1)
	}

	CH03(ts, z155, 0x024, 0, 0)
}

Method(n001)
{
if (1) {
	SRMT("m100")
	m100()
	SRMT("m101")
	m101()
	SRMT("m102")
	m102()
	SRMT("m103-0")
	m103(0)
	SRMT("m103-1")
	if (y200) {
		m103(1)
	} else {
		BLCK()
	}
	SRMT("m104")
	m104()
	SRMT("m105-0")
	m105(0)
	SRMT("m105-1")
	m105(1)
	SRMT("m106-0")
	m106(0)
	SRMT("m106-1")
	m106(1)
	SRMT("m107-0")
	m107(0)
	SRMT("m107-1")
	m107(1)
	SRMT("m108-0")
	m108(0)
	SRMT("m108-1")
	m108(1)
	SRMT("m109-0")
	m109(0)
	SRMT("m109-1")
	m109(1)
	SRMT("m10a-0")
	m10a(0)
	SRMT("m10a-1")
	m10a(1)
	SRMT("m10a-0-2") // Run it twice: see bug 265
	m10a(0)
	m10a(0)
} else {
	SRMT("m10a-0")
	m10a(0)
	SRMT("m10a-1")
	m10a(0)
}
}

