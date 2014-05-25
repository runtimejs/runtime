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
 * EISA ID String To Integer Conversion Macro
 */

Name(p360, Package()
{
	EISAID("ABC0123"),
	EISAID("DEF4567"),
	EISAID("GHI8abc"),
	EISAID("JKLdefA"),
	EISAID("MNOBCDE"),
	EISAID("PQRF012"),
	EISAID("STU3456"),
	EISAID("VWX789a"),
	EISAID("YZAbcde"),
	// check uppercase requirement to the EISAID
	// form "UUUXXXX" (UUU - 3 uppercase letters)
	EISAID("ABC0123"),
})

Name(p361, Package()
{
	0x23014304,
	0x6745a610,
	0xbc8a091d,
	0xfade6c29,
	0xdebccf35,
	0x12f03242,
	0x5634954e,
	0x9a78f85a,
	0xdebc4167,
	0x23014304,	// 0x23014384
})

// Run-method
Method(EIS0,, Serialized)
{
	Name(ts, "EIS0")

	Store("TEST: EIS0, EISA ID String To Integer Conversion Macro", Debug)

	m302(ts, 10, "p360", p360, p361, 9)
}
