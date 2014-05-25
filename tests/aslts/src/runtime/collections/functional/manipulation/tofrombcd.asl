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
 * Data type conversion and manipulation
 *
 * Convert Integer to BCD
 * Convert BCD To Integer
 */

// 32-bit
Name(p352, Package()
{
	0,
	1,
	12,
	345,
	6789,
	12345,
	678901,
	2345678,
	90123456,
	99999999,
	0xff,
	0xffff,
})

Name(p353, Package()
{
	0x0,
	0x1,
	0x12,
	0x345,
	0x6789,
	0x12345,
	0x678901,
	0x2345678,
	0x90123456,
	0x99999999,
	0x255,
	0x65535,
})

// 64-bit
Name(p354, Package()
{
	512346789,
	9999999999,
	10000000000,
	30123456790,
	123456789012,
	3456789012345,
	26789012346789,
	123456789012345,
	3789012345678901,
	9999999999999999,
})

Name(p355, Package()
{
	0x512346789,
	0x9999999999,
	0x10000000000,
	0x30123456790,
	0x123456789012,
	0x3456789012345,
	0x26789012346789,
	0x123456789012345,
	0x3789012345678901,
	0x9999999999999999,
})

Method(BCD1,, Serialized)
{
	Name(ts, "BCD1")

	Store("TEST: BCD1, Convert Integer to BCD", Debug)

	if (LEqual(F64, 1)) {
		m302(ts, 12, "p352", p352, p353, 5)
		m302(ts, 10, "p354", p354, p355, 5)
	} else {
		m302(ts, 12, "p352", p352, p353, 5)
	}
}

Method(BCD2,, Serialized)
{
	Name(ts, "BCD2")

	Store("TEST: BCD2, Convert BCD To Integer", Debug)

	if (LEqual(F64, 1)) {
		m302(ts, 12, "p353", p353, p352, 6)
		m302(ts, 10, "p355", p355, p354, 6)
	} else {
		m302(ts, 12, "p353", p353, p352, 6)
	}
}

// Run-method
Method(BCD0)
{
	BCD1()
	BCD2()
}