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


Name(z114, 114)

// Check the type of Object
// arg0 - Object
// arg1 - expected type
// arg2 - absolute index of file initiating the checking
// arg3 - the name of Method initiating the checking
// arg4 - index of checking (inside the file)
Method(m1a3, 5)
{
	Store(1, Local7)

	Store(ObjectType(arg0), Local0)

	if (LNotEqual(Local0, arg1)) {
		err("m1a3", z114, 0, arg2, arg4, Local0, arg1)
		Store(0, Local7)
	}

	return (Local7)
}

// Check that all the data (global) are not corrupted
Method(m1a6,, Serialized)
{
	Name(ts, "m1a6")

	// Computational Data

	// Integer

	Store(ObjectType(i900), Local0)
	if (LNotEqual(Local0, c009)) {
		err(ts, z114, 0x100, 0, 0, Local0, c009)
	}
	if (LNotEqual(i900, 0xfe7cb391d65a0000)) {
		err(ts, z114, 0x101, 0, 0, i900, 0xfe7cb391d65a0000)
	}

	Store(ObjectType(i901), Local0)
	if (LNotEqual(Local0, c009)) {
		err(ts, z114, 0x102, 0, 0, Local0, c009)
	}
	if (LNotEqual(i901, 0xc1790001)) {
		err(ts, z114, 0x103, 0, 0, i901, 0xc1790001)
	}

	Store(ObjectType(i902), Local0)
	if (LNotEqual(Local0, c009)) {
		err(ts, z114, 0x104, 0, 0, Local0, c009)
	}
	if (LNotEqual(i902, 0)) {
		err(ts, z114, 0x105, 0, 0, i902, 0)
	}

	Store(ObjectType(i903), Local0)
	if (LNotEqual(Local0, c009)) {
		err(ts, z114, 0x106, 0, 0, Local0, c009)
	}
	if (LNotEqual(i903, 0xffffffffffffffff)) {
		err(ts, z114, 0x107, 0, 0, i903, 0xffffffffffffffff)
	}

	Store(ObjectType(i904), Local0)
	if (LNotEqual(Local0, c009)) {
		err(ts, z114, 0x108, 0, 0, Local0, c009)
	}
	if (LNotEqual(i904, 0xffffffff)) {
		err(ts, z114, 0x109, 0, 0, i904, 0xffffffff)
	}

	// String

	Store(ObjectType(s900), Local0)
	if (LNotEqual(Local0, c00a)) {
		err(ts, z114, 0x10a, 0, 0, Local0, c00a)
	}
	if (LNotEqual(s900, "12340002")) {
		err(ts, z114, 0x10b, 0, 0, s900, "12340002")
	}

	Store(ObjectType(s901), Local0)
	if (LNotEqual(Local0, c00a)) {
		err(ts, z114, 0x10c, 0, 0, Local0, c00a)
	}
	if (LNotEqual(s901, "qwrtyu0003")) {
		err(ts, z114, 0x10d, 0, 0, s901, "qwrtyu0003")
	}

	// Buffer

	Store(ObjectType(b900), Local0)
	if (LNotEqual(Local0, c00b)) {
		err(ts, z114, 0x10e, 0, 0, Local0, c00b)
	}
	if (LNotEqual(b900, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})) {
		err(ts, z114, 0x10f, 0, 0, b900, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	}

	// Buffer Field

	Store(ObjectType(bf90), Local0)
	if (LNotEqual(Local0, c016)) {
		err(ts, z114, 0x110, 0, 0, Local0, c016)
	}
	if (LNotEqual(bf90, 0xb0)) {
		err(ts, z114, 0x111, 0, 0, bf90, 0xb0)
	}

	// One level Package

	Store(Index(p900, 0), Local0)
	Store(ObjectType(Local0), Local1)
	if (LNotEqual(Local1, c008)) {
		err(ts, z114, 0x112, 0, 0, Local1, c008)
	}

	Store(Index(p901, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(ts, z114, 0x113, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd0004)) {
		err(ts, z114, 0x114, 0, 0, Local1, 0xabcd0004)
	}

	Store(Index(p901, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(ts, z114, 0x115, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0x1122334455660005)) {
		err(ts, z114, 0x116, 0, 0, Local1, 0x1122334455660005)
	}

	Store(Index(p902, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(ts, z114, 0x117, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "12340006")) {
		err(ts, z114, 0x118, 0, 0, Local1, "12340006")
	}

	Store(Index(p902, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(ts, z114, 0x119, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "q1w2e3r4t5y6u7i80007")) {
		err(ts, z114, 0x11a, 0, 0, Local1, "q1w2e3r4t5y6u7i80007")
	}

	Store(Index(p903, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(ts, z114, 0x11b, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "qwrtyuiop0008")) {
		err(ts, z114, 0x11c, 0, 0, Local1, "qwrtyuiop0008")
	}

	Store(Index(p903, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(ts, z114, 0x11d, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "1234567890abdef0250009")) {
		err(ts, z114, 0x11e, 0, 0, Local1, "1234567890abdef0250009")
	}

	Store(Index(p904, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00b)) {
		err(ts, z114, 0x11f, 0, 0, Local2, c00b)
	}
	if (LNotEqual(Local1, Buffer() {0xb5,0xb6,0xb7})) {
		err(ts, z114, 0x120, 0, 0, Local1, Buffer() {0xb5,0xb6,0xb7})
	}

	Store(Index(p904, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00b)) {
		err(ts, z114, 0x121, 0, 0, Local2, c00b)
	}
	if (LNotEqual(Local1, Buffer() {0xb8,0xb9})) {
		err(ts, z114, 0x122, 0, 0, Local1, Buffer() {0xb8,0xb9})
	}

	// Two level Package

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c009)) {
		err(ts, z114, 0x123, 0, 0, Local4, c009)
	}
	if (LNotEqual(Local3, 0xabc000a)) {
		err(ts, z114, 0x124, 0, 0, Local3, 0xabc000a)
	}

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 1), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(ts, z114, 0x125, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "0xabc000b")) {
		err(ts, z114, 0x126, 0, 0, Local3, "0xabc000b")
	}

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 2), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(ts, z114, 0x127, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "abc000c")) {
		err(ts, z114, 0x128, 0, 0, Local3, "abc000c")
	}

	Store(Index(p906, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(ts, z114, 0x129, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "abc000d")) {
		err(ts, z114, 0x12a, 0, 0, Local3, "abc000d")
	}

	Store(Index(p907, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(ts, z114, 0x12b, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "aqwevbgnm000e")) {
		err(ts, z114, 0x12c, 0, 0, Local3, "aqwevbgnm000e")
	}

	Store(Index(p908, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00b)) {
		err(ts, z114, 0x12d, 0, 0, Local4, c00b)
	}
	if (LNotEqual(Local3, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe})) {
		err(ts, z114, 0x12e, 0, 0, Local3, Buffer() {0xba,0xbb,0xbc,0xbd,0xbe})
	}

	// Three level Package

	Store(Index(p909, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c009)) {
		err(ts, z114, 0x12f, 0, 0, Local6, c009)
	}
	if (LNotEqual(Local5, 0xabc000f)) {
		err(ts, z114, 0x130, 0, 0, Local5, 0xabc000f)
	}

	Store(Index(p90a, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00a)) {
		err(ts, z114, 0x131, 0, 0, Local6, c00a)
	}
	if (LNotEqual(Local5, "12340010")) {
		err(ts, z114, 0x132, 0, 0, Local5, "12340010")
	}

	Store(Index(p90b, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00a)) {
		err(ts, z114, 0x133, 0, 0, Local6, c00a)
	}
	if (LNotEqual(Local5, "zxswefas0011")) {
		err(ts, z114, 0x134, 0, 0, Local5, "zxswefas0011")
	}

	Store(Index(p90c, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00b)) {
		err(ts, z114, 0x135, 0, 0, Local6, c00b)
	}
	if (LNotEqual(Local5, Buffer() {0xbf,0xc0,0xc1})) {
		err(ts, z114, 0x136, 0, 0, Local5, Buffer() {0xbf,0xc0,0xc1})
	}

	// Additional Packages

	// p953

	Store(Index(p953, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(ts, z114, 0x137, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd0018)) {
		err(ts, z114, 0x138, 0, 0, Local1, 0xabcd0018)
	}

	Store(Index(p953, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(ts, z114, 0x139, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd0019)) {
		err(ts, z114, 0x13a, 0, 0, Local1, 0xabcd0019)
	}

	// p955

	m1af(p955, 1, 1, 0)

	// Not Computational Data

	m1aa(ts, e900, c00f, 0, 0x13b)
	m1aa(ts, mx90, c011, 0, 0x13c)
	m1aa(ts, d900, c00e, 0, 0x13d)
	if (y508) {
		m1aa(ts, tz90, c015, 0, 0x13e)
	}
	m1aa(ts, pr90, c014, 0, 0x13f)
	m1aa(ts, r900, c012, 0, 0x140)
	m1aa(ts, pw90, c013, 0, 0x141)

	// Field Unit (Field)

	Store(ObjectType(f900), Local0)
	if (LNotEqual(Local0, c00d)) {
		err(ts, z114, 0x142, 0, 0, Local0, c00d)
	}
	Store(ObjectType(f901), Local0)
	if (LNotEqual(Local0, c00d)) {
		err(ts, z114, 0x143, 0, 0, Local0, c00d)
	}
	Store(ObjectType(f902), Local0)
	if (LNotEqual(Local0, c00d)) {
		err(ts, z114, 0x144, 0, 0, Local0, c00d)
	}
	Store(ObjectType(f903), Local0)
	if (LNotEqual(Local0, c00d)) {
		err(ts, z114, 0x145, 0, 0, Local0, c00d)
	}

	// Field Unit (IndexField)

	Store(ObjectType(if90), Local0)
	if (LNotEqual(Local0, c00d)) {
		err(ts, z114, 0x146, 0, 0, Local0, c00d)
	}
	Store(ObjectType(if91), Local0)
	if (LNotEqual(Local0, c00d)) {
		err(ts, z114, 0x147, 0, 0, Local0, c00d)
	}

	// Field Unit (BankField)

	Store(ObjectType(bn90), Local0)
	if (LNotEqual(Local0, c00d)) {
		err(ts, z114, 0x148, 0, 0, Local0, c00d)
	}

/*
 *	if (LNotEqual(f900, 0xd7)) {
 *		err(ts, z114, 0x149, 0, 0, f900, 0xd7)
 *	}
 *
 *	if (LNotEqual(if90, 0xd7)) {
 *		err(ts, z114, 0x14a, 0, 0, if90, 0xd7)
 *	}
 */
}

// Verifying result
// arg0 - test name
// arg1 - object
// arg2 - expected type of object
// arg3 - expected value of object
// arg4 - index of checking (inside the file)
Method(m1aa, 5)
{
	Store(0, Local7)

	Store(ObjectType(arg1), Local0)

	if (LNotEqual(Local0, arg2)) {
		err(arg0, z114, 8, 0, arg4, Local0, arg2)
		Store(1, Local7)
	} elseif (LLess(arg2, c00c)) {
		if (LNotEqual(arg1, arg3)) {
			err(arg0, z114, 9, 0, arg4, arg1, arg3)
			Store(1, Local7)
		}
	}

	Return (Local7)
}

// Check and restore the global data after writing into them

Method(m1ab,, Serialized)
{
	Name(ts, "m1ab")

	// Computational Data

	m1aa(ts, i900, c009, c08a, 0x144)
	m1aa(ts, i901, c009, c08a, 0x145)
	m1aa(ts, s900, c009, c08a, 0x146)
	m1aa(ts, s901, c009, c08a, 0x147)
	m1aa(ts, b900, c009, c08a, 0x148)

	// Package

	m1aa(ts, p953, c009, c08a, 0x149)

	// Not Computational Data

	m1aa(ts, e900, c009, c08a, 0x14a)
	m1aa(ts, mx90, c009, c08a, 0x14b)
	m1aa(ts, d900, c009, c08a, 0x14c)

	if (y508) {
		m1aa(ts, tz90, c009, c08a, 0x14d)
	}

	m1aa(ts, pr90, c009, c08a, 0x14e)

	if (y510) {
		m1aa(ts, r900, c009, c08a, 0x14f)
	}

	m1aa(ts, pw90, c009, c08a, 0x150)

	m1ac()

	m1a6()
}

// Restore the global data after writing into them
Method(m1ac)
{

	// Computational Data

	CopyObject(i9Z0, i900)
	CopyObject(i9Z1, i901)
	CopyObject(s9Z0, s900)
	CopyObject(s9Z1, s901)
	CopyObject(b9Z0, b900)

	// Package

	CopyObject(p954, p953)

	// Restore p955 Package
	m1c6()

	// Not Computational Data

	CopyObject(e9Z0, e900)
	CopyObject(mx91, mx90)
	CopyObject(d9Z0, d900)

	if (y508) {
		CopyObject(tz91, tz90)
	}

	CopyObject(pr91, pr90)

	if (y510) {
		CopyObject(r9Z0, r900)
	}

	CopyObject(pw91, pw90)
}

// Verify p955-like Package
// arg0 - Package
// arg1 - check for non-computational data
// arg2 - check Field Unit and Buffer Field
// arg3 - elements of Package are RefOf_References
Method(m1af, 4, Serialized)
{
	Name(ts, "m1af")

	Store(Index(arg0, 0), Local0)
	Store(ObjectType(Local0), Local1)

	if (LNotEqual(Local1, c009)) {
		err(ts, z114, 0x112, 0, 0, Local1, c009)
	} else {
		Store(DerefOf(Local0), Local1)
		if (LNotEqual(Local1, 0)) {
			err(ts, z113, 0x112, 0, 0, Local1, 0)
		}
	}

	Store(Index(arg0, 1), Local0)
	Store(ObjectType(Local0), Local1)

	if (LNotEqual(Local1, c009)) {
		err(ts, z114, 0x112, 0, 0, Local1, c009)
	} else {
		Store(DerefOf(Local0), Local1)
		if (arg3) {
			Store(DerefOf(Local1), Local2)
			Store(Local2, Local1)
		}
		if (LNotEqual(Local1, 0xfe7cb391d65a0000)) {
			err(ts, z114, 0x112, 0, 0, Local1, 0xfe7cb391d65a0000)
		}
	}

	Store(Index(arg0, 2), Local0)
	Store(ObjectType(Local0), Local1)

	if (LNotEqual(Local1, c00a)) {
		err(ts, z114, 0x112, 0, 0, Local1, c00a)
	} else {
		Store(DerefOf(Local0), Local1)
		if (arg3) {
			Store(DerefOf(Local1), Local2)
			Store(Local2, Local1)
		}
		if (LNotEqual(Local1, "12340002")) {
			err(ts, z114, 0x112, 0, 0, Local1, "12340002")
		}
	}

	Store(Index(arg0, 3), Local0)
	Store(ObjectType(Local0), Local1)

	if (LNotEqual(Local1, c00b)) {
		err(ts, z114, 0x112, 0, 0, Local1, c00a)
	} else {
		Store(DerefOf(Local0), Local1)
		if (arg3) {
			Store(DerefOf(Local1), Local2)
			Store(Local2, Local1)
		}
		if (LNotEqual(Local1, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})) {
			err(ts, z114, 0x112, 0, 0, Local1, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		}
	}

	Store(Index(arg0, 4), Local0)
	m1aa(ts, Local0, c00c, 0, 0x13f)


    // 5th element is a region field, which will be resolved to an integer

	if (arg2) {
	    Store(Index(arg0, 5), Local0)
	    Store(ObjectType(Local0), Local1)
		Store(DerefOf(Local0), Local7)

        if (arg3) {
	        if (LNotEqual(Local1, c00d)) {
		        err(ts, z114, 0x112, 0, 0, Local1, c00d)
	        } else {
			    Store(DerefOf(Local7), Local6)
			    Store(Local6, Local7)
            }
        }

	    Store(ObjectType(Local7), Local5)

	    if (LNotEqual(Local5, c009)) {
		    err(ts, z114, 0x112, 0, 0, Local5, c009)
	    } else {
		    if (LNotEqual(Local7, 0)) {
			    err(ts, z114, 0x112, 0, 0, Local7, 0)
            }
		}
    }

	if (arg1) {

		Store(Index(arg0, 6), Local0)
		m1aa(ts, Local0, c00e, 0, 0x13f)

		Store(Index(arg0, 7), Local0)
		m1aa(ts, Local0, c00f, 0, 0x13f)

		Store(Index(arg0, 8), Local0)
		m1aa(ts, Local0, c010, 0, 0x13f)

		Store(Index(arg0, 9), Local0)
		m1aa(ts, Local0, c011, 0, 0x13f)

		Store(Index(arg0, 10), Local0)
		m1aa(ts, Local0, c012, 0, 0x13f)

		Store(Index(arg0, 11), Local0)
		m1aa(ts, Local0, c013, 0, 0x13f)

		Store(Index(arg0, 12), Local0)
		m1aa(ts, Local0, c014, 0, 0x13f)

		Store(Index(arg0, 13), Local0)
		m1aa(ts, Local0, c015, 0, 0x13f)
	}

    // 14th element is a buffer field, which will be resolved to an integer

	if (arg2) {
	    Store(Index(arg0, 14), Local0)
	    Store(ObjectType(Local0), Local1)
		Store(DerefOf(Local0), Local7)

        if (arg3) {
	        if (LNotEqual(Local1, c016)) {
		        err(ts, z114, 0x112, 0, 0, Local1, c016)
	        } else {
			    Store(DerefOf(Local7), Local6)
			    Store(Local6, Local7)
            }
        }

	    Store(ObjectType(Local7), Local5)

	    if (LNotEqual(Local5, c009)) {
		    err(ts, z114, 0x112, 0, 0, Local5, c009)
	    } else {
		    if (LNotEqual(Local7, 0xb0)) {
			    err(ts, z114, 0x112, 0, 0, Local7, 0)
            }
		}
    }

	Store(Index(arg0, 15), Local0)
	Store(ObjectType(Local0), Local1)

	if (LNotEqual(Local1, c009)) {
		err(ts, z114, 0x112, 0, 0, Local1, c009)
	} else {
		Store(DerefOf(Local0), Local1)
		if (LNotEqual(Local1, 15)) {
			err(ts, z114, 0x112, 0, 0, Local1, 15)
		}
	}

	Store(Index(arg0, 16), Local0)
	Store(ObjectType(Local0), Local1)

	if (LNotEqual(Local1, c009)) {
		err(ts, z114, 0x112, 0, 0, Local1, c009)
	} else {
		Store(DerefOf(Local0), Local1)
		if (LNotEqual(Local1, 16)) {
			err(ts, z114, 0x112, 0, 0, Local1, 16)
		}
	}

	Store(Index(arg0, 17), Local0)
	Store(ObjectType(Local0), Local1)

	if (LNotEqual(Local1, c008)) {
		err(ts, z114, 0x115, 0, 0, Local1, c008)
	}

	// Evaluation of Method m936 takes place

	if (LNotEqual(i905, 0xabcd001a)) {
		err(ts, z114, 0x116, 0, 0, i905, 0xabcd001a)
	}
}

// Restore p955 Package
Method(m1c6)
{
	CopyObject(p956, p955)
	Store(i9Z5, i905)
}


