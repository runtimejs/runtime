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
 * ns0 originated but has names from root
 */

/*
 * Internal Integer of Device instead of i000 (in m001)
 */
Method(m006, 1, Serialized)
{
	Name(ts, "m006")
	Device(d000)
	{
		Name(i000, 0x00000001)
	}
	Name(i001, 0)
	Name(p000, Package() {1,2,3,4})

	Store(arg0, i001)

	CH03(ts, z154, 0x014, 0, 0)

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
										CopyObject(p000, \m006.d000.i000)
									}
									Return (0)
								}
								Store(0x80000000, \m006.d000.i000)
								Return (Add(\m006.d000.i000, m008()))
							}
							Store(0x07000000, \m006.d000.i000)
							Return (Add(\m006.d000.i000, m007()))
						}
						Store(0x00600000, \m006.d000.i000)
						Return (Add(\m006.d000.i000, m006()))
					}
					Store(0x00050000, \m006.d000.i000)
					Return (Add(\m006.d000.i000, m005()))
				}
				Store(0x00004000, \m006.d000.i000)
				Return (Add(\m006.d000.i000, m004()))
			}
			Store(0x00000300, \m006.d000.i000)
			Return (Add(\m006.d000.i000, m003()))
		}
		Store(0x00000020, ^d000.i000)
		Return (Add(^d000.i000, m002()))
	}

	Store(Add(d000.i000, m001()), Local0)

	if (FLG9) {
		CH03(ts, z154, 0x014, 0, 0)
		if (LNotEqual(Local0, 0x87654321)) {
			err(ts, z154, 0x012, 0, 0, Local0, 0x87654321)
		}
		if (LNotEqual(d000.i000, 0x80000000)) {
			err(ts, z154, 0x013, 0, 0, d000.i000, 0x80000000)
		}
	} else {
		CH04(ts, 1, 5, z154, 0x014, 0, 0)	// AE_NOT_FOUND
	}
}

/*
 * Internal Integer of ThermalZone instead of i000 (in m001)
 */
Method(m007, 1, Serialized)
{
	Name(ts, "m007")
	ThermalZone(tz00)
	{
		Name(i000, 0x00000001)
	}
	Name(i001, 0)
	Name(p000, Package() {1,2,3,4})

	Store(arg0, i001)

	CH03(ts, z154, 0x014, 0, 0)

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
										CopyObject(p000, \m007.tz00.i000)
									}
									Return (0)
								}
								Store(0x80000000, \m007.tz00.i000)
								Return (Add(\m007.tz00.i000, m008()))
							}
							Store(0x07000000, \m007.tz00.i000)
							Return (Add(\m007.tz00.i000, m007()))
						}
						Store(0x00600000, \m007.tz00.i000)
						Return (Add(\m007.tz00.i000, m006()))
					}
					Store(0x00050000, \m007.tz00.i000)
					Return (Add(\m007.tz00.i000, m005()))
				}
				Store(0x00004000, \m007.tz00.i000)
				Return (Add(\m007.tz00.i000, m004()))
			}
			Store(0x00000300, \m007.tz00.i000)
			Return (Add(\m007.tz00.i000, m003()))
		}
		Store(0x00000020, ^tz00.i000)
		Return (Add(^tz00.i000, m002()))
	}
	Store(Add(tz00.i000, m001()), Local0)

	if (FLG9) {
		CH03(ts, z154, 0x014, 0, 0)
		if (LNotEqual(Local0, 0x87654321)) {
			err(ts, z154, 0x015, 0, 0, Local0, 0x87654321)
		}
		if (LNotEqual(tz00.i000, 0x80000000)) {
			err(ts, z154, 0x016, 0, 0, tz00.i000, 0x80000000)
		}
	} else {
		CH04(ts, 1, 5, z154, 0x014, 0, 0)	// AE_NOT_FOUND
	}
}

/*
 * Internal Integer of Processor instead of i000 (in m001)
 */
Method(m008, 1, Serialized)
{
	Name(ts, "m008")
	Processor(pr00, 0, 0xFFFFFFFF, 0)
	{
		Name(i000, 0x00000001)
	}
	Name(i001, 0)
	Name(p000, Package() {1,2,3,4})

	Store(arg0, i001)

	CH03(ts, z154, 0x014, 0, 0)

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
										CopyObject(p000, \m008.pr00.i000)
									}
									Return (0)
								}
								Store(0x80000000, \m008.pr00.i000)
								Return (Add(\m008.pr00.i000, m008()))
							}
							Store(0x07000000, \m008.pr00.i000)
							Return (Add(\m008.pr00.i000, m007()))
						}
						Store(0x00600000, \m008.pr00.i000)
						Return (Add(\m008.pr00.i000, m006()))
					}
					Store(0x00050000, \m008.pr00.i000)
					Return (Add(\m008.pr00.i000, m005()))
				}
				Store(0x00004000, \m008.pr00.i000)
				Return (Add(\m008.pr00.i000, m004()))
			}
			Store(0x00000300, \m008.pr00.i000)
			Return (Add(\m008.pr00.i000, m003()))
		}
		Store(0x00000020, ^pr00.i000)
		Return (Add(^pr00.i000, m002()))
	}

	Store(Add(pr00.i000, m001()), Local0)

	if (FLG9) {
		CH03(ts, z154, 0x014, 0, 0)
		if (LNotEqual(Local0, 0x87654321)) {
			err(ts, z154, 0x018, 0, 0, Local0, 0x87654321)
		}
		if (LNotEqual(pr00.i000, 0x80000000)) {
			err(ts, z154, 0x019, 0, 0, pr00.i000, 0x80000000)
		}
	} else {
		CH04(ts, 1, 5, z154, 0x014, 0, 0)	// AE_NOT_FOUND
	}
}

/*
 * Internal Integer of PowerResource instead of i000 (in m001)
 */
Method(m009, 1, Serialized)
{
	Name(ts, "m009")
	PowerResource(pw00, 1, 0)
	{
		Name(i000, 0x00000001)
	}
	Name(i001, 0)
	Name(p000, Package() {1,2,3,4})

	Store(arg0, i001)

	CH03(ts, z154, 0x01d, 0, 0)

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
										CopyObject(p000, \m009.pw00.i000)
									}
									Return (0)
								}
								Store(0x80000000, \m009.pw00.i000)
								Return (Add(\m009.pw00.i000, m008()))
							}
							Store(0x07000000, \m009.pw00.i000)
							Return (Add(\m009.pw00.i000, m007()))
						}
						Store(0x00600000, \m009.pw00.i000)
						Return (Add(\m009.pw00.i000, m006()))
					}
					Store(0x00050000, \m009.pw00.i000)
					Return (Add(\m009.pw00.i000, m005()))
				}
				Store(0x00004000, \m009.pw00.i000)
				Return (Add(\m009.pw00.i000, m004()))
			}
			Store(0x00000300, \m009.pw00.i000)
			Return (Add(\m009.pw00.i000, m003()))
		}
		Store(0x00000020, ^pw00.i000)
		Return (Add(^pw00.i000, m002()))
	}

	Store(Add(pw00.i000, m001()), Local0)

	if (FLG9) {
		CH03(ts, z154, 0x014, 0, 0)
		if (LNotEqual(Local0, 0x87654321)) {
			err(ts, z154, 0x01b, 0, 0, Local0, 0x87654321)
		}
		if (LNotEqual(pw00.i000, 0x80000000)) {
			err(ts, z154, 0x01c, 0, 0, pw00.i000, 0x80000000)
		}
	} else {
		CH04(ts, 1, 5, z154, 0x014, 0, 0)	// AE_NOT_FOUND
	}
}

Method(n100)
{
if (1) {
	SRMT("m006-0")
	m006(0)
	SRMT("m006-1")
	if (y200) {
		m006(1)
	} else {
		BLCK()
	}
	SRMT("m007-0")
	m007(0)
	SRMT("m007-1")
	if (y200) {
		m007(1)
	} else {
		BLCK()
	}
	SRMT("m008-0")
	m008(0)
	SRMT("m008-1")
	if (y200) {
		m008(1)
	} else {
		BLCK()
	}
	SRMT("m009-0")
	m009(0)
	SRMT("m009-1")
	if (y200) {
		m009(1)
	} else {
		BLCK()
	}
} else {
}
}