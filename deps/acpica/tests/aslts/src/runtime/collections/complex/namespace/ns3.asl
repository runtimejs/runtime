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
 * The tests differ those from ns1.asl by that the parent object is
 * passed to methods as argument (Arg) but not directly by name.
 */
Name(z157, 157)

Method(m300,, Serialized)
{
	Name(ts, "m300")
	Name(p000, Package() {0xabcd0000, 0xabcd0001, 0xabcd0002})
	Method(m000, 1)
	{
		Method(m001, 2)
		{
			Store(0x11112222, Index(arg0, 0))
		}

		m001(arg0, RefOf(arg0))

		Store(DerefOf(Index(arg0, 0)), Local0)

		if (LNotEqual(Local0, 0x11112222)) {
			err(ts, z157, 0x000, 0, 0, Local0, 0x11112222)
		}
	}

	m000(p000)

	Store(DerefOf(Index(p000, 0)), Local0)

	if (LNotEqual(Local0, 0x11112222)) {
		err(ts, z157, 0x001, 0, 0, Local0, 0x11112222)
	}

	CH03(ts, z157, 0x002, 0, 0)
}

Method(m301,, Serialized)
{
	Name(ts, "m301")
	Name(b000, Buffer() {0x10, 0x11, 0x12})

	Method(m000, 1)
	{
		Method(m001, 2)
		{
			Store(0x67, Index(arg0, 0))
		}

		m001(arg0, RefOf(arg0))

		Store(DerefOf(Index(arg0, 0)), Local0)

		if (LNotEqual(Local0, 0x67)) {
			err(ts, z157, 0x003, 0, 0, Local0, 0x67)
		}
	}

	m000(b000)

	Store(DerefOf(Index(b000, 0)), Local0)

	if (LNotEqual(Local0, 0x67)) {
		err(ts, z157, 0x004, 0, 0, Local0, 0x67)
	}

	CH03(ts, z157, 0x005, 0, 0)
}

Method(m302,, Serialized)
{
	Name(ts, "m302")
	Name(s000, "qqqqqqqqqqqqqq")
	Method(m000, 1)
	{
		Method(m001, 2)
		{
			Store(0x38, Index(arg0, 0))
		}

		m001(arg0, RefOf(arg0))

		Store(DerefOf(Index(arg0, 0)), Local0)

		if (LNotEqual(Local0, 0x38)) {
			err(ts, z157, 0x006, 0, 0, Local0, 0x38)
		}
	}

	m000(s000)

	Store(DerefOf(Index(s000, 0)), Local0)

	if (LNotEqual(Local0, 0x38)) {
		err(ts, z157, 0x007, 0, 0, Local0, 0x38)
	}

	CH03(ts, z157, 0x008, 0, 0)
}

/*
 * Element of Package instead of i000 (in m001)
 */
Method(m303, 1, Serialized)
{
	Name(ts, "m303")
	Name(pp00, Package() {0x11111111, 0x00000001, 0x22223333})

	Method(m000, 2, Serialized)
	{
		Name(i001, 0)
		Name(p000, Package() {1,2,3,4})

		CH03(ts, z157, 0x009, 0, 0)

		Store(arg1, i001)

		Method(m001, 1)
		{
			Method(m002, 1)
			{
				Method(m003, 1)
				{
					Method(m004, 1)
					{
						Method(m005, 1)
						{
							Method(m006, 1)
							{
								Method(m007, 1)
								{
									Method(m008, 1)
									{
										if (i001)
										{
											Store(p000, Index(arg0, 1))
										}
										Return (0)
									}
									Store(0x80000000, Index(arg0, 1))
									Return (Add(DerefOf(Index(arg0, 1)), m008(arg0)))
								}
								Store(0x07000000, Index(arg0, 1))
								Return (Add(DerefOf(Index(arg0, 1)), m007(arg0)))
							}
							Store(0x00600000, Index(arg0, 1))
							Return (Add(DerefOf(Index(arg0, 1)), m006(arg0)))
						}
						Store(0x00050000, Index(arg0, 1))
						Return (Add(DerefOf(Index(arg0, 1)), m005(arg0)))
					}
					Store(0x00004000, Index(arg0, 1))
					Return (Add(DerefOf(Index(arg0, 1)), m004(arg0)))
				}
				Store(0x00000300, Index(arg0, 1))
				Return (Add(DerefOf(Index(arg0, 1)), m003(arg0)))
			}
			Store(0x00000020, Index(arg0, 1))
			Return (Add(DerefOf(Index(arg0, 1)), m002(arg0)))
		}
		Store(Add(DerefOf(Index(arg0, 1)), m001(arg0)), Local0)

		if (LNotEqual(Local0, 0x87654321)) {
			err(ts, z157, 0x00a, 0, 0, Local0, 0x87654321)
		}

		Store(DerefOf(Index(arg0, 1)), Local1)

		if (LNotEqual(Local1, 0x80000000)) {
			err(ts, z157, 0x00b, 0, 0, Local1, 0x80000000)
		}

		CH03(ts, z157, 0x00c, 0, 0)

		Return (Local0)
	}

	Store(m000(pp00, arg0), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z157, 0x00d, 0, 0, Local0, 0x87654321)
	}

	Store(DerefOf(Index(pp00, 1)), Local0)

	if (LNotEqual(Local0, 0x80000000)) {
		err(ts, z157, 0x00e, 0, 0, Local0, 0x80000000)
	}

	CH03(ts, z157, 0x00f, 0, 0)
}

/*
 * Element of Package instead of i000 (in m002)
 */
Method(m304,, Serialized)
{
	Name(ts, "m304")
	Name(i001, 0)
	Name(pp00, Package() {0x11111111, 0x00100000, 0x22223333})

	Method(m000, 1)
	{
		Method(m001, 1)
		{
			if (LLess(i001, 100)) {
				Store(DerefOf(Index(arg0, 1)), Local0)
				Increment(Local0)
				Store(Local0, Index(arg0, 1))
				Increment(i001)
				Add(DerefOf(Index(arg0, 1)), m001(arg0), Local0)
				Return (Local0)
			}
			Return (0)
		}
		Store(Add(DerefOf(Index(arg0, 1)), m001(arg0)), Local0)

		if (LNotEqual(Local0, 0x065013BA)) {
			err(ts, z157, 0x010, 0, 0, Local0, 0x065013BA)
		}

		Store(DerefOf(Index(arg0, 1)), Local1)

		if (LNotEqual(Local1, 0x00100064)) {
			err(ts, z157, 0x011, 0, 0, Local1, 0x00100064)
		}
		Return (Local0)
	}

	Store(m000(pp00), Local0)

	if (LNotEqual(Local0, 0x065013BA)) {
		err(ts, z157, 0x012, 0, 0, Local0, 0x065013BA)
	}

	Store(DerefOf(Index(pp00, 1)), Local1)

	if (LNotEqual(Local1, 0x00100064)) {
		err(ts, z157, 0x013, 0, 0, Local1, 0x00100064)
	}

	CH03(ts, z157, 0x014, 0, 0)
}

/*
 * Buffer Field instead of i000 (in m001)
 */
Method(m305,, Serialized)
{
	Name(ts, "m305")
	Name(b000, Buffer(16) {})

	CH03(ts, z157, 0x015, 0, 0)

	CreateField(b000, 5, 32, bf00)
	Store(0xabcdef70, bf00)

	Method(m000, 1)
	{
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
										Return (0)
									}
									Store(0x80000000, arg0)
									Return (Add(arg0, m008()))
								}
								Store(0x07000000, arg0)
								Return (Add(arg0, m007()))
							}
							Store(0x00600000, arg0)
							Return (Add(arg0, m006()))
						}
						Store(0x00050000, arg0)
						Return (Add(arg0, m005()))
					}
					Store(0x00004000, arg0)
					Return (Add(arg0, m004()))
				}
				Store(0x00000300, arg0)
				Return (Add(arg0, m003()))
			}
			Store(0x00000020, arg0)
			Return (Add(arg0, m002()))
		}

		Store(0x0000001, arg0)

		Store(Add(arg0, m001()), Local0)

		if (LNotEqual(Local0, 0x87654321)) {
			err(ts, z157, 0x016, 0, 0, Local0, 0x87654321)
		}

		Store(0x0000001, Local1)

		if (LNotEqual(arg0, Local1)) {
			err(ts, z157, 0x017, 0, 0, arg0, Local1)
		}

		CH03(ts, z157, 0x018, 0, 0)

		Return (Local0)
	}

	Store(m000(bf00), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z157, 0x019, 0, 0, Local0, 0x87654321)
	}

	Store(0xabcdef70, Local1)

	if (LNotEqual(bf00, Local1)) {
		err(ts, z157, 0x01a, 0, 0, bf00, Local1)
	}

	CH03(ts, z157, 0x01b, 0, 0)
}

/*
 * Field instead of i000 (in m001)
 */
Method(m306,, Serialized)
{
	Name(ts, "m306")
	Name(i001, 0)
	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	Field(r000, ByteAcc, NoLock, Preserve) { f000,32, f001,32 }

	CH03(ts, z157, 0x01c, 0, 0)

	Store(0xabcdef70, f000)

	Method(m000, 1)
	{
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
										Return (0)
									}
									Store(0x80000000, arg0)
									Return (Add(arg0, m008()))
								}
								Store(0x07000000, arg0)
								Return (Add(arg0, m007()))
							}
							Store(0x00600000, arg0)
							Return (Add(arg0, m006()))
						}
						Store(0x00050000, arg0)
						Return (Add(arg0, m005()))
					}
					Store(0x00004000, arg0)
					Return (Add(arg0, m004()))
				}
				Store(0x00000300, arg0)
				Return (Add(arg0, m003()))
			}
			Store(0x00000020, arg0)
			Return (Add(arg0, m002()))
		}

		Store(0x0000001, arg0)

		Store(Add(arg0, m001()), Local0)

		if (LNotEqual(Local0, 0x87654321)) {
			err(ts, z157, 0x01d, 0, 0, Local0, 0x87654321)
		}

		Store(0x0000001, Local1)

		if (LNotEqual(arg0, Local1)) {
			err(ts, z157, 0x01e, 0, 0, arg0, Local1)
		}

		CH03(ts, z157, 0x01f, 0, 0)

		Return (Local0)
	}

	Store(m000(f000), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z157, 0x020, 0, 0, Local0, 0x87654321)
	}

	Store(0xabcdef70, Local1)

	if (LNotEqual(f000, Local1)) {
		err(ts, z157, 0x021, 0, 0, f000, Local1)
	}

	CH03(ts, z157, 0x022, 0, 0)
}

/*
 * Bank Field instead of i000 (in m001)
 */
Method(m307,, Serialized)
{
	Name(ts, "m307")
	Name(i001, 0)
	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	Field(r000, ByteAcc, NoLock, Preserve) { f000,32, f001,32 }
	BankField(r000, f001, 0, ByteAcc, NoLock, Preserve) { bnk0, 32 }

	CH03(ts, z157, 0x023, 0, 0)

	Store(0xabcdef70, bnk0)

	Method(m000, 1)
	{
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
										Return (0)
									}
									Store(0x80000000, arg0)
									Return (Add(arg0, m008()))
								}
								Store(0x07000000, arg0)
								Return (Add(arg0, m007()))
							}
							Store(0x00600000, arg0)
							Return (Add(arg0, m006()))
						}
						Store(0x00050000, arg0)
						Return (Add(arg0, m005()))
					}
					Store(0x00004000, arg0)
					Return (Add(arg0, m004()))
				}
				Store(0x00000300, arg0)
				Return (Add(arg0, m003()))
			}
			Store(0x00000020, arg0)
			Return (Add(arg0, m002()))
		}

		Store(0x0000001, arg0)

		Store(Add(arg0, m001()), Local0)

		if (LNotEqual(Local0, 0x87654321)) {
			err(ts, z157, 0x024, 0, 0, Local0, 0x87654321)
		}

		Store(0x0000001, Local1)

		if (LNotEqual(arg0, Local1)) {
			err(ts, z157, 0x025, 0, 0, arg0, Local1)
		}

		CH03(ts, z157, 0x026, 0, 0)

		Return (Local0)
	}

	Store(m000(bnk0), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z157, 0x027, 0, 0, Local0, 0x87654321)
	}

	Store(0xabcdef70, Local1)

	if (LNotEqual(bnk0, Local1)) {
		err(ts, z157, 0x028, 0, 0, bnk0, Local1)
	}

	CH03(ts, z157, 0x029, 0, 0)
}

/*
 * Index Field instead of i000 (in m001)
 */
Method(m308,, Serialized)
{
	Name(ts, "m308")
	Name(i001, 0)
	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	Field(r000, ByteAcc, NoLock, Preserve) { f000,32, f001,32 }
	IndexField(f000, f001, ByteAcc, NoLock, Preserve) { if00, 32 }

	CH03(ts, z157, 0x02a, 0, 0)

	Store(0xabcdef70, if00)

	Method(m000, 1)
	{
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
										Return (0)
									}
									Store(0x80000000, arg0)
									Return (Add(arg0, m008()))
								}
								Store(0x07000000, arg0)
								Return (Add(arg0, m007()))
							}
							Store(0x00600000, arg0)
							Return (Add(arg0, m006()))
						}
						Store(0x00050000, arg0)
						Return (Add(arg0, m005()))
					}
					Store(0x00004000, arg0)
					Return (Add(arg0, m004()))
				}
				Store(0x00000300, arg0)
				Return (Add(arg0, m003()))
			}
			Store(0x00000020, arg0)
			Return (Add(arg0, m002()))
		}

		Store(0x0000001, arg0)

		Store(Add(arg0, m001()), Local0)

		if (LNotEqual(Local0, 0x87654321)) {
			err(ts, z157, 0x02b, 0, 0, Local0, 0x87654321)
		}

		Store(0x0000001, Local1)

		if (LNotEqual(arg0, Local1)) {
			err(ts, z157, 0x02c, 0, 0, arg0, Local1)
		}

		CH03(ts, z157, 0x02d, 0, 0)

		Return (Local0)
	}

	Store(m000(if00), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z157, 0x02e, 0, 0, Local0, 0x87654321)
	}

	Store(0xabcdef70, Local1)

	if (LNotEqual(if00, Local1)) {
		err(ts, z157, 0x02f, 0, 0, if00, Local1)
	}

	CH03(ts, z157, 0x030, 0, 0)
}

/*
 * Element of Buffer instead of i000 (in m001)
 */
Method(m309, 1, Serialized)
{
	Name(ts, "m309")
	Name(i001, 0)
	Name(b000, Buffer() {0x11, 0x01, 0x22})

	CH03(ts, z157, 0x031, 0, 0)

	Store(arg0, i001)

	Method(m000, 2)
	{
		Method(m001, 1)
		{
			Method(m002, 1)
			{
				Method(m003, 1)
				{
					Method(m004, 1)
					{
						Method(m005, 1)
						{
							Method(m006, 1)
							{
								Method(m007, 1)
								{
									Method(m008, 1)
									{
										if (i001)
										{
											Store(0xff, Index(arg0, 1))
										}
										Return (0)
									}
									Store(0x08, Index(arg0, 1))
									Return (Add(DerefOf(Index(arg0, 1)), m008(arg0)))
								}
								Store(0x07, Index(arg0, 1))
								Return (Add(DerefOf(Index(arg0, 1)), m007(arg0)))
							}
							Store(0x06, Index(arg0, 1))
							Return (Add(DerefOf(Index(arg0, 1)), m006(arg0)))
						}
						Store(0x05, Index(arg0, 1))
						Return (Add(DerefOf(Index(arg0, 1)), m005(arg0)))
					}
					Store(0x04, Index(arg0, 1))
					Return (Add(DerefOf(Index(arg0, 1)), m004(arg0)))
				}
				Store(0x03, Index(arg0, 1))
				Return (Add(DerefOf(Index(arg0, 1)), m003(arg0)))
			}
			Store(0x02, Index(arg0, 1))
			Return (Add(DerefOf(Index(arg0, 1)), m002(arg0)))
		}
		Store(Add(DerefOf(Index(arg0, 1)), m001(arg0)), Local0)

		if (LNotEqual(Local0, 0x24)) {
			err(ts, z157, 0x032, 0, 0, Local0, 0x24)
		}

		Store(DerefOf(Index(arg0, 1)), Local1)

		if (arg1) {
			Store(0xff, Local2)
		} else {
			Store(0x08, Local2)
		}

		if (LNotEqual(Local1, Local2)) {
			err(ts, z157, 0x033, 0, 0, Local1, Local2)
		}

		CH03(ts, z157, 0x034, 0, 0)

		Return (Local0)
	}

	Store(m000(b000, arg0), Local0)

	if (LNotEqual(Local0, 0x24)) {
		err(ts, z157, 0x035, 0, 0, Local0, 0x24)
	}

	Store(DerefOf(Index(b000, 1)), Local1)

	if (arg0) {
		Store(0xff, Local2)
	} else {
		Store(0x08, Local2)
	}

	if (LNotEqual(Local1, Local2)) {
		err(ts, z157, 0x036, 0, 0, Local1, Local2)
	}

	CH03(ts, z157, 0x037, 0, 0)
}

/*
 * Element of String instead of i000 (in m001)
 */
Method(m30a, 1, Serialized)
{
	Name(ts, "m30a")
	Name(i001, 0)
	Name(s000, "q\001ertyuiop")

	CH03(ts, z157, 0x038, 0, 0)

	Store(arg0, i001)

	Method(m000, 2)
	{
		Method(m001, 1)
		{
			Method(m002, 1)
			{
				Method(m003, 1)
				{
					Method(m004, 1)
					{
						Method(m005, 1)
						{
							Method(m006, 1)
							{
								Method(m007, 1)
								{
									Method(m008, 1)
									{
										if (i001)
										{
											Store(0xff, Index(arg0, 1))
										}
										Return (0)
									}
									Store(0x08, Index(arg0, 1))
									Return (Add(DerefOf(Index(arg0, 1)), m008(arg0)))
								}
								Store(0x07, Index(arg0, 1))
								Return (Add(DerefOf(Index(arg0, 1)), m007(arg0)))
							}
							Store(0x06, Index(arg0, 1))
							Return (Add(DerefOf(Index(arg0, 1)), m006(arg0)))
						}
						Store(0x05, Index(arg0, 1))
						Return (Add(DerefOf(Index(arg0, 1)), m005(arg0)))
					}
					Store(0x04, Index(arg0, 1))
					Return (Add(DerefOf(Index(arg0, 1)), m004(arg0)))
				}
				Store(0x03, Index(arg0, 1))
				Return (Add(DerefOf(Index(arg0, 1)), m003(arg0)))
			}
			Store(0x02, Index(arg0, 1))
			Return (Add(DerefOf(Index(arg0, 1)), m002(arg0)))
		}
		Store(Add(DerefOf(Index(arg0, 1)), m001(arg0)), Local0)

		if (LNotEqual(Local0, 0x24)) {
			err(ts, z157, 0x039, 0, 0, Local0, 0x24)
		}

		Store(DerefOf(Index(arg0, 1)), Local1)

		if (arg1) {
			Store(0xff, Local2)
		} else {
			Store(0x08, Local2)
		}

		if (LNotEqual(Local1, Local2)) {
			err(ts, z157, 0x03a, 0, 0, Local1, Local2)
		}

		CH03(ts, z157, 0x03b, 0, 0)

		Return (Local0)
	}

	Store(m000(s000, arg0), Local0)

	if (LNotEqual(Local0, 0x24)) {
		err(ts, z157, 0x03c, 0, 0, Local0, 0x24)
	}

	Store(DerefOf(Index(s000, 1)), Local1)

	if (arg0) {
		Store(0xff, Local2)
	} else {
		Store(0x08, Local2)
	}

	if (LNotEqual(Local1, Local2)) {
		err(ts, z157, 0x03d, 0, 0, Local1, Local2)
	}

	CH03(ts, z157, 0x03e, 0, 0)
}

/*
 * Buffer Field instead of i000 (in m001)
 *
 * CreateField deeper than parent
 */
Method(m30b, 1, Serialized)
{
	Name(ts, "m30b")
	Name(i001, 0)
	Name(b000, Buffer(16) {})

	Store(arg0, i001)

	CH03(ts, z157, 0x03f, 0, 0)

	Method(m000, 2)
	{
		CreateField(b000, 5, 32, bf00)

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
			err(ts, z157, 0x040, 0, 0, Local0, 0x87654321)
		}

		if (arg1) {
			Store(0x11223344, Local1)
		} else {
			Store(0x80000000, Local1)
		}

		if (LNotEqual(bf00, Local1)) {
			err(ts, z157, 0x041, 0, 0, bf00, Local1)
		}

		CH03(ts, z157, 0x042, 0, 0)

		Return (Local0)
	}

	Store(m000(0, arg0), Local0)

	if (LNotEqual(Local0, 0x87654321)) {
		err(ts, z157, 0x043, 0, 0, Local0, 0x87654321)
	}

	CH03(ts, z157, 0x044, 0, 0)
}

Method(n003)
{
if (1) {
	SRMT("m300")
	m300()
	SRMT("m301")
	m301()
	SRMT("m302")
	m302()
	SRMT("m303-0")
	m303(0)
	SRMT("m303-1")
	if (y200) {
		m303(1)
	} else {
		BLCK()
	}
	SRMT("m304")
	m304()
	SRMT("m305")
	m305()
	SRMT("m306")
	m306()
	SRMT("m307")
	m307()
	SRMT("m308")
	m308()
	SRMT("m309-0")
	m309(0)
	SRMT("m309-1")
	m309(1)
	SRMT("m30a-0")
	m30a(0)
	SRMT("m30a-1")
	m30a(1)
	SRMT("m30b-0")
	m30b(0)
	SRMT("m30b-1")
	m30b(1)
} else {
	SRMT("m300")
	m300()
}
}

