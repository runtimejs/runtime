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
 * Bug 263:
 *
 * SUMMARY: The sequence of evaluating operands of expression with the named objects is violated
 */

Method(m026)
{
	Method(mm00,, Serialized)
	{
		Name(i000, 0x00000001)

		Method(m001)
		{
			Store(0x50000000, i000)
			Return (i000)
		}
		Store(Add(i000, m001()), Local0)

		Store(Local0, Debug)
		Store(i000, Debug)

		if (LNotEqual(Local0, 0x50000001)) {
			err("", zFFF, 0x000, 0, 0, Local0, 0x50000001)
		}

		if (LNotEqual(i000, 0x50000000)) {
			err("", zFFF, 0x001, 0, 0, i000, 0x50000000)
		}
	}

	Method(mm01, 1, Serialized)
	{
		Name(i000, 0x00000001)
		Name(i001, 0)
		Name(p000, Package() {1,2,3,4})

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
											CopyObject(p000, i000)
										}
										Return (0)
									}
									Store(0x80000000, i000)
									Return (Add(i000, m008()))
								}
								Store(0x07000000, i000)
								Return (Add(i000, m007()))
							}
							Store(0x00600000, i000)
							Return (Add(i000, m006()))
						}
						Store(0x00050000, i000)
						Return (Add(i000, m005()))
					}
					Store(0x00004000, i000)
					Return (Add(i000, m004()))
				}
				Store(0x00000300, i000)
				Return (Add(i000, m003()))
			}
			Store(0x00000020, i000)
			Return (Add(i000, m002()))
		}
		Store(Add(i000, m001()), Local0)

		if (LNotEqual(Local0, 0x87654321)) {
			err("", zFFF, 0x002, 0, 0, Local0, 0x87654321)
		}

		if (LNotEqual(i000, 0x80000000)) {
			err("", zFFF, 0x003, 0, 0, i000, 0x80000000)
		}
	}
	mm00()
	mm01(0)
}

