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
 * References
 *
 *          (named objects, if present, are the local objects of Method)
 *
 * TABLE 1: all the legal ways to generate references to the
 *          immediate images (constants)
 * TABLE 2: all the legal ways to generate references to the
 *          named objects
 * TABLE 3: all the legal ways to generate references to the
 *          immediate images (constants) being elements of Package
 * TABLE 4: all the legal ways to generate references to the
 *          named objects being elements of Package
 *
 * Producing Reference operators:
 *
 *    Index, RefOf, CondRefOf
 */

/*
???????????????????????????????????????
SEE: after fixing bug 118 of ACPICA change all the local data
     so that they differ the relevant global ones.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/


Name(z077, 77)


// ///////////////////////////////////////////////////////////////////////////
//
// TABLE 1: all the legal ways to generate references
//          to the immediate images (constants)
//
// ///////////////////////////////////////////////////////////////////////////

Method(m168)
{
	if (y100) {
		ts00("m168")
	} else {
		Store("m168", Debug)
	}

	if (LNot(y900)) {
		Store("Test m168 skipped!", Debug)
		return
	}

	// T1:I2-I4

	Store(Index("123456789", 5), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x36, 1260)

	Store(Index("qwrtyuiop", 5), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x75, 1261)

	Store(Index(Buffer() {1,2,3,4,5,6,7,8}, 5), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x06, 1262)

	Store(Index(Package() {0xabcdef}, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xabcdef, 1263)

	Store(Index(Package() {"123456789"}, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "123456789", 1264)

	Store(Index(Package() {"qwrtyuiop"}, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyuiop", 1265)

	Store(Index(Package() {Buffer() {1,2,3,4,5,6,7,8,9}}, 0), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {1,2,3,4,5,6,7,8,9}, 1266)

	Store(Index(Package() {Package() {0xabcdef}}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabcdef, 1267)

	Store(Index(Package() {Package() {"123456789"}}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "123456789", 1268)

	Store(Index(Package() {Package() {"qwrtyuiop"}}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyuiop", 1269)

	Store(Index(Package() {Package() {Buffer() {1,2,3,4,5,6,7,8,9}}}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {1,2,3,4,5,6,7,8,9}, 1270)

	Store(Index(Package() {Package() {Package() {0xabcdef}}}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabcdef, 1271)

	Store(Index(Package() {Package() {Package() {"123456789"}}}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "123456789", 1272)

	Store(Index(Package() {Package() {Package() {"qwrtyuiop"}}}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "qwrtyuiop", 1273)

	Store(Index(Package() {Package() {Package() {Buffer() {1,2,3,4,5,6,7,8,9}}}}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {1,2,3,4,5,6,7,8,9}, 1274)

	// T1:IR2-IR4

	if (y098) {
		Store(Index("qwrtyuiop", 5, Local1), Local0)
		m1a2(Local0, c016, 0, 0, c009, 0x75, 1275)
		m1a2(Local1, c016, 0, 0, c009, 0x75, 1276)

		Store(Index(Buffer() {1,2,3,4,5,6,7,8}, 5, Local1), Local0)
		m1a2(Local0, c016, 0, 0, c009, 0x06, 1277)
		m1a2(Local1, c016, 0, 0, c009, 0x06, 1278)

		Store(Index(Package() {1,2,3,4,5,6,7,8}, 5, Local1), Local0)
		m1a2(Local0, c009, 0, 0, c009, 0x06, 1279)
		m1a2(Local1, c009, 0, 0, c009, 0x06, 1280)
	}
}

// ///////////////////////////////////////////////////////////////////////////
//
// TABLE 2: all the legal ways to generate references to the named objects
//
// ///////////////////////////////////////////////////////////////////////////

Method(m169,, Serialized)
{
	if (y100) {
		ts00("m169")
	} else {
		Store("m169", Debug)
	}

	// Not Computational Data

	Event(e900)
	Event(e9Z0)
	Mutex(mx90, 0)
	Mutex(mx91, 0)
	Device(d900) { Name(i900, 0xabcd1017) }
	Device(d9Z0) { Name(i900, 0xabcd1017) }
	ThermalZone(tz90) {}
	ThermalZone(tz91) {}
	Processor(pr90, 0, 0xFFFFFFFF, 0) {}
	Processor(pr91, 0, 0xFFFFFFFF, 0) {}
	OperationRegion(r900, SystemMemory, 0x100, 0x100)
	OperationRegion(r9Z0, SystemMemory, 0x100, 0x100)
	PowerResource(pw90, 1, 0) {Method(mmmm){return (0)}}
	PowerResource(pw91, 1, 0) {Method(mmmm){return (0)}}

	// Computational Data

	Name(i900, 0xfe7cb391d65a1000)
	Name(i9Z0, 0xfe7cb391d65a1000)
	Name(i901, 0xc1791001)
	Name(i9Z1, 0xc1791001)
	Name(i902, 0)
	Name(i903, 0xffffffffffffffff)
	Name(i904, 0xffffffff)
	Name(s900, "12341002")
	Name(s9Z0, "12341002")
	Name(s901, "qwrtyu1003")
	Name(s9Z1, "qwrtyu1003")
	Name(b900, Buffer() {0x10,0x11,0x12,0x13,0x14})
	Name(b9Z0, Buffer() {0x10,0x11,0x12,0x13,0x14})

	CreateField(b9Z0, 0, 8, bf90)
	Field(r9Z0, ByteAcc, NoLock, Preserve) {f900,8,f901,8,f902,8,f903,8}
	BankField(r9Z0, f901, 0, ByteAcc, NoLock, Preserve) {bn90,4}
	IndexField(f902, f903, ByteAcc, NoLock, Preserve) {if90,8,if91,8}

	// Elements of Package are Uninitialized

	Name(p900, Package(1) {})

	// Elements of Package are Computational Data

	Name(p901, Package() {0xabcd1004, 0x1122334455661005})
	Name(p902, Package() {"12341006", "q1w2e3r4t5y6u7i81007"})
	Name(p903, Package() {"qwrtyuiop1008", "1234567890abdef0251009"})
	Name(p904, Package() {Buffer() {0xa0,0xa1,0xa2}, Buffer() {0xa3,0xa4}})
	Name(p905, Package() {Package() {0xabc100a, "0xabc100b", "abc100c"}})
	Name(p906, Package() {Package() {"abc100d"}})
	Name(p907, Package() {Package() {"aqwevbgnm100e"}})
	Name(p908, Package() {Package() {Buffer() {0xa5,0xa6,0xa7,0xa8,0xa9}}})
	Name(p909, Package() {Package() {Package() {0xabc100f}}})
	Name(p90a, Package() {Package() {Package() {"12341010"}}})
	Name(p90b, Package() {Package() {Package() {"zxswefas1011"}}})
	Name(p90c, Package() {Package() {Package() {Buffer() {0xaa,0xab,0xac}}}})

	Name(p90d, Package() {i900})
	Name(p90e, Package() {i901})
	Name(p90f, Package() {s900})
	Name(p910, Package() {s901})
	Name(p911, Package() {b9Z0})
	Name(p912, Package() {f900})
	Name(p913, Package() {bn90})
	Name(p914, Package() {if90})
	Name(p915, Package() {bf90})

	// Elements of Package are NOT Computational Data

	Name(p916, Package() {d900})
	Name(p917, Package() {e900})
	Name(p918, Package() {mx90})
	Name(p919, Package() {r9Z0})
	Name(p91a, Package() {pw90})
	Name(p91b, Package() {pr90})
	Name(p91c, Package() {tz90})

	// Methods

	Method(m900) {}
	Method(m901) { return (0xabc1012) }
	Method(m902) { return ("zxvgswquiy1013") }
	Method(m903) { return (Buffer() {0xad}) }
	Method(m904) { return (Package() {0xabc1014}) }
	Method(m905) { return (Package() {"lkjhgtre1015"}) }
	Method(m906) { return (Package() {Buffer() {0xae}}) }
	Method(m907) { return (Package() {Package() {0xabc1016}}) }

	Method(m908) { return (i900) }
	Method(m909) { return (i901) }
	Method(m90a) { return (s900) }
	Method(m90b) { return (s901) }
	Method(m90c) { return (b9Z0) }
	Method(m90d) { return (f900) }
	Method(m90e) { return (bn90) }
	Method(m90f) { return (if90) }
	Method(m910) { return (bf90) }

	Method(m911) { return (d900) }
	Method(m912) { return (e900) }
	Method(m913) { return (m901) }
	Method(m914) { return (mx90) }
	Method(m915) { return (r9Z0) }
	Method(m916) { return (pw90) }
	Method(m917) { return (pr90) }
	Method(m918) { return (tz90) }
	Method(m919) { return (p900) }
	Method(m91a) { return (p901) }
	Method(m91b) { return (p902) }
	Method(m91c) { return (p903) }
	Method(m91d) { return (p904) }
	Method(m91e) { return (p905) }
	Method(m91f) { return (p906) }
	Method(m920) { return (p907) }
	Method(m921) { return (p908) }
	Method(m922) { return (p909) }
	Method(m923) { return (p90a) }
	Method(m924) { return (p90b) }
	Method(m925) { return (p90c) }
	Method(m926) { return (p90d) }
	Method(m927) { return (p90e) }
	Method(m928) { return (p90f) }
	Method(m929) { return (p910) }
	Method(m92a) { return (p911) }
	Method(m92b) { return (p912) }
	Method(m92c) { return (p913) }
	Method(m92d) { return (p914) }
	Method(m92e) { return (p915) }
	Method(m92f) { return (p916) }
	Method(m930) { return (p917) }
	Method(m931) { return (p918) }
	Method(m932) { return (p919) }
	Method(m933) { return (p91a) }
	Method(m934) { return (p91b) }
	Method(m935) { return (p91c) }

	// Elements of Package are Methods

	Name(p91d, Package() {m900})
	Name(p91e, Package() {m901})
	Name(p91f, Package() {m902})
	Name(p920, Package() {m903})
	Name(p921, Package() {m904})
	Name(p922, Package() {m905})
	Name(p923, Package() {m906})
	Name(p924, Package() {m907})
	Name(p925, Package() {m908})
	Name(p926, Package() {m909})
	Name(p927, Package() {m90a})
	Name(p928, Package() {m90b})
	Name(p929, Package() {m90c})
	Name(p92a, Package() {m90d})
	Name(p92b, Package() {m90e})
	Name(p92c, Package() {m90f})
	Name(p92d, Package() {m910})
	Name(p92e, Package() {m911})
	Name(p92f, Package() {m912})
	Name(p930, Package() {m913})
	Name(p931, Package() {m914})
	Name(p932, Package() {m915})
	Name(p933, Package() {m916})
	Name(p934, Package() {m917})
	if (y103) {
		Name(p935, Package() {m918})
	}
	Name(p936, Package() {m919})
	Name(p937, Package() {m91a})
	Name(p938, Package() {m91b})
	Name(p939, Package() {m91c})
	Name(p93a, Package() {m91d})
	Name(p93b, Package() {m91e})
	Name(p93c, Package() {m91f})
	Name(p93d, Package() {m920})
	Name(p93e, Package() {m921})
	Name(p93f, Package() {m922})
	Name(p940, Package() {m923})
	Name(p941, Package() {m924})
	Name(p942, Package() {m925})
	Name(p943, Package() {m926})
	Name(p944, Package() {m927})
	Name(p945, Package() {m928})
	Name(p946, Package() {m929})
	Name(p947, Package() {m92a})
	Name(p948, Package() {m92b})
	Name(p949, Package() {m92c})
	Name(p94a, Package() {m92d})
	Name(p94b, Package() {m92e})
	Name(p94c, Package() {m92f})
	Name(p94d, Package() {m930})
	Name(p94e, Package() {m931})
	Name(p94f, Package() {m932})
	Name(p950, Package() {m933})
	Name(p951, Package() {m934})
	Name(p952, Package() {m935})

	Name(p953, Package() {0xabcd1018, 0xabcd1019})
	Name(p954, Package() {0xabcd1018, 0xabcd1019})


	// Check that all the data (local) are not corrupted
	Method(m000)
	{
	// Computational Data

	// Integer

	Store(ObjectType(i900), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x100, 0, 0, Local0, c009)
	}
	if (LNotEqual(i900, 0xfe7cb391d65a1000)) {
		err(c080, z077, 0x101, 0, 0, i900, 0xfe7cb391d65a1000)
	}

	Store(ObjectType(i901), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x102, 0, 0, Local0, c009)
	}
	if (LNotEqual(i901, 0xc1791001)) {
		err(c080, z077, 0x103, 0, 0, i901, 0xc1791001)
	}

	Store(ObjectType(i902), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x104, 0, 0, Local0, c009)
	}
	if (LNotEqual(i902, 0)) {
		err(c080, z077, 0x105, 0, 0, i902, 0)
	}

	Store(ObjectType(i903), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x106, 0, 0, Local0, c009)
	}
	if (LNotEqual(i903, 0xffffffffffffffff)) {
		err(c080, z077, 0x107, 0, 0, i903, 0xffffffffffffffff)
	}

	Store(ObjectType(i904), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x108, 0, 0, Local0, c009)
	}
	if (LNotEqual(i904, 0xffffffff)) {
		err(c080, z077, 0x109, 0, 0, i904, 0xffffffff)
	}

	// String

	Store(ObjectType(s900), Local0)
	if (LNotEqual(Local0, c00a)) {
		err(c080, z077, 0x10a, 0, 0, Local0, c00a)
	}
	if (LNotEqual(s900, "12341002")) {
		err(c080, z077, 0x10b, 0, 0, s900, "12341002")
	}

	Store(ObjectType(s901), Local0)
	if (LNotEqual(Local0, c00a)) {
		err(c080, z077, 0x10c, 0, 0, Local0, c00a)
	}
	if (LNotEqual(s901, "qwrtyu1003")) {
		err(c080, z077, 0x10d, 0, 0, s901, "qwrtyu1003")
	}

	// Buffer

	Store(ObjectType(b900), Local0)
	if (LNotEqual(Local0, c00b)) {
		err(c080, z077, 0x10e, 0, 0, Local0, c00b)
	}
	if (LNotEqual(b900, Buffer() {0x10,0x11,0x12,0x13,0x14})) {
		err(c080, z077, 0x10f, 0, 0, b900, Buffer() {0x10,0x11,0x12,0x13,0x14})
	}

	// Buffer Field

	Store(ObjectType(bf90), Local0)
	if (LNotEqual(Local0, c016)) {
		err(c080, z077, 0x110, 0, 0, Local0, c016)
	}
	if (LNotEqual(bf90, 0x10)) {
		err(c080, z077, 0x111, 0, 0, bf90, 0x10)
	}

	// One level Package

	Store(Index(p900, 0), Local0)
	Store(ObjectType(Local0), Local1)
	if (LNotEqual(Local1, c008)) {
		err(c080, z077, 0x112, 0, 0, Local1, c008)
	}

	Store(Index(p901, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x113, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd1004)) {
		err(c080, z077, 0x114, 0, 0, Local1, 0xabcd1004)
	}

	Store(Index(p901, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x115, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0x1122334455661005)) {
		err(c080, z077, 0x116, 0, 0, Local1, 0x1122334455661005)
	}

	Store(Index(p902, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x117, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "12341006")) {
		err(c080, z077, 0x118, 0, 0, Local1, "12341006")
	}

	Store(Index(p902, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x119, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "q1w2e3r4t5y6u7i81007")) {
		err(c080, z077, 0x11a, 0, 0, Local1, "q1w2e3r4t5y6u7i81007")
	}

	Store(Index(p903, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x11b, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "qwrtyuiop1008")) {
		err(c080, z077, 0x11c, 0, 0, Local1, "qwrtyuiop1008")
	}

	Store(Index(p903, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x11d, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "1234567890abdef0251009")) {
		err(c080, z077, 0x11e, 0, 0, Local1, "1234567890abdef0251009")
	}

	Store(Index(p904, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00b)) {
		err(c080, z077, 0x11f, 0, 0, Local2, c00b)
	}
	if (LNotEqual(Local1, Buffer() {0xa0,0xa1,0xa2})) {
		err(c080, z077, 0x120, 0, 0, Local1, Buffer() {0xa0,0xa1,0xa2})
	}

	Store(Index(p904, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00b)) {
		err(c080, z077, 0x121, 0, 0, Local2, c00b)
	}
	if (LNotEqual(Local1, Buffer() {0xa3,0xa4})) {
		err(c080, z077, 0x122, 0, 0, Local1, Buffer() {0xa3,0xa4})
	}

	// Two level Package

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c009)) {
		err(c080, z077, 0x123, 0, 0, Local4, c009)
	}
	if (LNotEqual(Local3, 0xabc100a)) {
		err(c080, z077, 0x124, 0, 0, Local3, 0xabc100a)
	}

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 1), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x125, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "0xabc100b")) {
		err(c080, z077, 0x126, 0, 0, Local3, "0xabc100b")
	}

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 2), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x127, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "abc100c")) {
		err(c080, z077, 0x128, 0, 0, Local3, "abc100c")
	}

	Store(Index(p906, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x129, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "abc100d")) {
		err(c080, z077, 0x12a, 0, 0, Local3, "abc100d")
	}

	Store(Index(p907, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x12b, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "aqwevbgnm100e")) {
		err(c080, z077, 0x12c, 0, 0, Local3, "aqwevbgnm100e")
	}

	Store(Index(p908, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00b)) {
		err(c080, z077, 0x12d, 0, 0, Local4, c00b)
	}
	if (LNotEqual(Local3, Buffer() {0xa5,0xa6,0xa7,0xa8,0xa9})) {
		err(c080, z077, 0x12e, 0, 0, Local3, Buffer() {0xa5,0xa6,0xa7,0xa8,0xa9})
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
		err(c080, z077, 0x12f, 0, 0, Local6, c009)
	}
	if (LNotEqual(Local5, 0xabc100f)) {
		err(c080, z077, 0x130, 0, 0, Local5, 0xabc100f)
	}

	Store(Index(p90a, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00a)) {
		err(c080, z077, 0x131, 0, 0, Local6, c00a)
	}
	if (LNotEqual(Local5, "12341010")) {
		err(c080, z077, 0x132, 0, 0, Local5, "12341010")
	}

	Store(Index(p90b, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00a)) {
		err(c080, z077, 0x133, 0, 0, Local6, c00a)
	}
	if (LNotEqual(Local5, "zxswefas1011")) {
		err(c080, z077, 0x134, 0, 0, Local5, "zxswefas1011")
	}

	Store(Index(p90c, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00b)) {
		err(c080, z077, 0x135, 0, 0, Local6, c00b)
	}
	if (LNotEqual(Local5, Buffer() {0xaa,0xab,0xac})) {
		err(c080, z077, 0x136, 0, 0, Local5, Buffer() {0xaa,0xab,0xac})
	}

	Store(Index(p953, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x137, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd1018)) {
		err(c080, z077, 0x138, 0, 0, Local1, 0xabcd1018)
	}

	Store(Index(p953, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x139, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd1019)) {
		err(c080, z077, 0x13a, 0, 0, Local1, 0xabcd1019)
	}

	// Not Computational Data

	m1aa(c080, e900, c00f, 0, 0x13b)
	m1aa(c080, mx90, c011, 0, 0x13c)
	m1aa(c080, d900, c00e, 0, 0x13d)
	if (y508) {
		m1aa(c080, tz90, c015, 0, 0x13e)
	}
	m1aa(c080, pr90, c014, 0, 0x13f)
	m1aa(c080, r900, c012, 0, 0x140)
	m1aa(c080, pw90, c013, 0, 0x141)

/*
 *	// Field Unit (Field)
 *
 *	if (LNotEqual(f900, 0xd7)) {
 *		err(c080, z077, 0x137, 0, 0, f900, 0xd7)
 *	}
 *
 *	// Field Unit (IndexField)
 *
 *	if (LNotEqual(if90, 0xd7)) {
 *		err(c080, z077, 0x138, 0, 0, if90, 0xd7)
 *	}
 */
	} /* m000 */


	// T2:I2-I4

	if (y114) {
		Store(Index(m902, 0), Local0)
		m1a0(Local0, c010, Ones, 0)
	}

	// Computational Data

	Store(Index(s900, 0), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x31, 1)

	Store(Index(s901, 2), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x72, 2)

	Store(Index(b900, 3), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x13, 3)

	// Package

	Store(Index(p953, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xabcd1018, 1006)

	// Elements of Package are Uninitialized

	if (y104) {
		Store(Index(p900, 0), Local0)
		m1a0(Local0, c008, Ones, 4)
	}

	// Elements of Package are Computational Data

	Store(Index(p901, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xabcd1004, 5)

	Store(Index(p901, 1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0x1122334455661005, 6)

	Store(Index(p902, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12341006", 7)

	Store(Index(p902, 1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "q1w2e3r4t5y6u7i81007", 8)

	Store(Index(p903, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyuiop1008", 9)

	Store(Index(p903, 1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "1234567890abdef0251009", 10)

	Store(Index(p904, 0), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xa0,0xa1,0xa2}, 11)

	Store(Index(p905, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabc100a, 12)

	Store(Index(p905, 0), Local0)
	m1a2(Local0, c00c, 1, 1, c00a, "0xabc100b", 13)

	Store(Index(p906, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "abc100d", 14)

	Store(Index(p907, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "aqwevbgnm100e", 15)

	Store(Index(p908, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xa5,0xa6,0xa7,0xa8,0xa9}, 16)

	Store(Index(p909, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabc100f, 17)

	Store(Index(p90a, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "12341010", 18)

	Store(Index(p90b, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "zxswefas1011", 19)

	Store(Index(p90c, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xaa,0xab,0xac}, 20)

	Store(Index(p90d, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a1000, 21)

	Store(Index(p90e, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xc1791001, 22)

	Store(Index(p90f, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12341002", 23)

	Store(Index(p910, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu1003", 24)

	Store(Index(p911, 0), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0x10,0x11,0x12,0x13,0x14}, 25)

	if (y118) {
		Store(Index(p912, 0), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 26)

		Store(Index(p913, 0), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 27)

		Store(Index(p914, 0), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 28)

		Store(Index(p915, 0), Local0)
		m1a2(Local0, c016, 0, 0, c016, 0x10, 29)
	}

	// Elements of Package are NOT Computational Data

	Store(Index(p916, 0), Local0)
	m1a0(Local0, c00e, Ones, 30)

	Store(Index(p917, 0), Local0)
	m1a0(Local0, c00f, Ones, 31)

	Store(Index(p918, 0), Local0)
	m1a0(Local0, c011, Ones, 32)

	Store(Index(p919, 0), Local0)
	m1a0(Local0, c012, Ones, 33)

	Store(Index(p91a, 0), Local0)
	m1a0(Local0, c013, Ones, 34)

	Store(Index(p91b, 0), Local0)
	m1a0(Local0, c014, Ones, 35)

	Store(Index(p91c, 0), Local0)
	m1a0(Local0, c015, Ones, 36)

	// Elements of Package are Methods

	if (y105) {

		Store(Index(p91d, 0), Local0)
		m1a0(Local0, c010, Ones, 37)

		Store(Index(p91e, 0), Local0)
		m1a0(Local0, c010, Ones, 38)

		Store(Index(p91f, 0), Local0)
		m1a0(Local0, c010, Ones, 39)

		Store(Index(p920, 0), Local0)
		m1a0(Local0, c010, Ones, 40)

		Store(Index(p921, 0), Local0)
		m1a0(Local0, c010, Ones, 41)

		Store(Index(p922, 0), Local0)
		m1a0(Local0, c010, Ones, 42)

		Store(Index(p923, 0), Local0)
		m1a0(Local0, c010, Ones, 43)

		Store(Index(p924, 0), Local0)
		m1a0(Local0, c010, Ones, 44)

		Store(Index(p925, 0), Local0)
		m1a0(Local0, c010, Ones, 45)

		Store(Index(p926, 0), Local0)
		m1a0(Local0, c010, Ones, 46)

		Store(Index(p927, 0), Local0)
		m1a0(Local0, c010, Ones, 47)

		Store(Index(p928, 0), Local0)
		m1a0(Local0, c010, Ones, 48)

		Store(Index(p929, 0), Local0)
		m1a0(Local0, c010, Ones, 49)

		Store(Index(p92a, 0), Local0)
		m1a0(Local0, c010, Ones, 50)

		Store(Index(p92b, 0), Local0)
		m1a0(Local0, c010, Ones, 51)

		Store(Index(p92c, 0), Local0)
		m1a0(Local0, c010, Ones, 52)

		Store(Index(p92d, 0), Local0)
		m1a0(Local0, c010, Ones, 53)

		Store(Index(p92e, 0), Local0)
		m1a0(Local0, c010, Ones, 54)

		Store(Index(p92f, 0), Local0)
		m1a0(Local0, c010, Ones, 55)

		Store(Index(p930, 0), Local0)
		m1a0(Local0, c010, Ones, 56)

		Store(Index(p931, 0), Local0)
		m1a0(Local0, c010, Ones, 57)

		Store(Index(p932, 0), Local0)
		m1a0(Local0, c010, Ones, 58)

		Store(Index(p933, 0), Local0)
		m1a0(Local0, c010, Ones, 59)

		Store(Index(p934, 0), Local0)
		m1a0(Local0, c010, Ones, 60)

		if (y103) {
			Store(Index(p935, 0), Local0)
			m1a0(Local0, c010, Ones, 61)
		}

		Store(Index(p936, 0), Local0)
		m1a0(Local0, c010, Ones, 62)

		Store(Index(p937, 0), Local0)
		m1a0(Local0, c010, Ones, 63)

		Store(Index(p938, 0), Local0)
		m1a0(Local0, c010, Ones, 64)

		Store(Index(p939, 0), Local0)
		m1a0(Local0, c010, Ones, 65)

		Store(Index(p93a, 0), Local0)
		m1a0(Local0, c010, Ones, 66)

		Store(Index(p93b, 0), Local0)
		m1a0(Local0, c010, Ones, 67)

		Store(Index(p93c, 0), Local0)
		m1a0(Local0, c010, Ones, 68)

		Store(Index(p93d, 0), Local0)
		m1a0(Local0, c010, Ones, 69)

		Store(Index(p93e, 0), Local0)
		m1a0(Local0, c010, Ones, 70)

		Store(Index(p93f, 0), Local0)
		m1a0(Local0, c010, Ones, 71)

		Store(Index(p940, 0), Local0)
		m1a0(Local0, c010, Ones, 72)

		Store(Index(p941, 0), Local0)
		m1a0(Local0, c010, Ones, 73)

		Store(Index(p942, 0), Local0)
		m1a0(Local0, c010, Ones, 74)

		Store(Index(p943, 0), Local0)
		m1a0(Local0, c010, Ones, 75)

		Store(Index(p944, 0), Local0)
		m1a0(Local0, c010, Ones, 76)

		Store(Index(p945, 0), Local0)
		m1a0(Local0, c010, Ones, 77)

		Store(Index(p946, 0), Local0)
		m1a0(Local0, c010, Ones, 78)

		Store(Index(p947, 0), Local0)
		m1a0(Local0, c010, Ones, 79)

		Store(Index(p948, 0), Local0)
		m1a0(Local0, c010, Ones, 80)

		Store(Index(p949, 0), Local0)
		m1a0(Local0, c010, Ones, 81)

		Store(Index(p94a, 0), Local0)
		m1a0(Local0, c010, Ones, 82)

		Store(Index(p94b, 0), Local0)
		m1a0(Local0, c010, Ones, 83)

		Store(Index(p94c, 0), Local0)
		m1a0(Local0, c010, Ones, 84)

		Store(Index(p94d, 0), Local0)
		m1a0(Local0, c010, Ones, 85)

		Store(Index(p94e, 0), Local0)
		m1a0(Local0, c010, Ones, 86)

		Store(Index(p94f, 0), Local0)
		m1a0(Local0, c010, Ones, 87)

		Store(Index(p950, 0), Local0)
		m1a0(Local0, c010, Ones, 88)

		Store(Index(p951, 0), Local0)
		m1a0(Local0, c010, Ones, 89)

		Store(Index(p952, 0), Local0)
		m1a0(Local0, c010, Ones, 90)
	}

	// T2:IR2-IR4

	// Computational Data

	Store(Index(s900, 0, Local1), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x31, 91)
	m1a2(Local1, c016, 0, 0, c009, 0x31, 92)

	Store(Index(s901, 2, Local1), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x72, 93)
	m1a2(Local1, c016, 0, 0, c009, 0x72, 94)

	Store(Index(b900, 4, Local1), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0x14, 95)
	m1a2(Local1, c016, 0, 0, c009, 0x14, 96)

	// Elements of Package are Uninitialized

	if (y104) {
		Store(Index(p900, 0, Local1), Local0)
		m1a0(Local0, c008, Ones, 97)
		m1a0(Local1, c008, Ones, 98)
	}

	// Elements of Package are Computational Data

	Store(Index(p901, 0, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xabcd1004, 99)
	m1a2(Local1, c009, 0, 0, c009, 0xabcd1004, 100)

	Store(Index(p901, 1, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0x1122334455661005, 101)
	m1a2(Local1, c009, 0, 0, c009, 0x1122334455661005, 102)

	Store(Index(p902, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12341006", 103)
	m1a2(Local1, c00a, 0, 0, c00a, "12341006", 104)

	Store(Index(p902, 1, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "q1w2e3r4t5y6u7i81007", 105)
	m1a2(Local1, c00a, 0, 0, c00a, "q1w2e3r4t5y6u7i81007", 106)

	Store(Index(p903, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyuiop1008", 107)
	m1a2(Local1, c00a, 0, 0, c00a, "qwrtyuiop1008", 108)

	Store(Index(p903, 1, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "1234567890abdef0251009", 109)
	m1a2(Local1, c00a, 0, 0, c00a, "1234567890abdef0251009", 110)

	Store(Index(p904, 0, Local1), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xa0,0xa1,0xa2}, 111)
	m1a2(Local1, c00b, 0, 0, c00b, Buffer() {0xa0,0xa1,0xa2}, 112)

	Store(Index(p905, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabc100a, 113)
	m1a2(Local1, c00c, 1, 0, c009, 0xabc100a, 114)

	Store(Index(p905, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 1, c00a, "0xabc100b", 115)
	m1a2(Local1, c00c, 1, 1, c00a, "0xabc100b", 116)

	Store(Index(p906, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "abc100d", 117)
	m1a2(Local1, c00c, 1, 0, c00a, "abc100d", 118)

	Store(Index(p907, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "aqwevbgnm100e", 119)
	m1a2(Local1, c00c, 1, 0, c00a, "aqwevbgnm100e", 120)

	Store(Index(p908, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xa5,0xa6,0xa7,0xa8,0xa9}, 121)
	m1a2(Local1, c00c, 1, 0, c00b, Buffer() {0xa5,0xa6,0xa7,0xa8,0xa9}, 122)

	Store(Index(p909, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabc100f, 123)
	m1a2(Local1, c00c, 2, 0, c009, 0xabc100f, 124)

	Store(Index(p90a, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "12341010", 125)
	m1a2(Local1, c00c, 2, 0, c00a, "12341010", 126)

	Store(Index(p90b, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "zxswefas1011", 127)
	m1a2(Local1, c00c, 2, 0, c00a, "zxswefas1011", 128)

	Store(Index(p90c, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xaa,0xab,0xac}, 129)
	m1a2(Local1, c00c, 2, 0, c00b, Buffer() {0xaa,0xab,0xac}, 130)

	Store(Index(p90d, 0, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a1000, 131)
	m1a2(Local1, c009, 0, 0, c009, 0xfe7cb391d65a1000, 132)

	Store(Index(p90e, 0, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xc1791001, 133)
	m1a2(Local1, c009, 0, 0, c009, 0xc1791001, 134)

	Store(Index(p90f, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12341002", 135)
	m1a2(Local1, c00a, 0, 0, c00a, "12341002", 136)

	Store(Index(p910, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu1003", 137)
	m1a2(Local1, c00a, 0, 0, c00a, "qwrtyu1003", 138)

	Store(Index(p911, 0, Local1), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0x10,0x11,0x12,0x13,0x14}, 139)
	m1a2(Local1, c00b, 0, 0, c00b, Buffer() {0x10,0x11,0x12,0x13,0x14}, 140)

	if (y118) {
		Store(Index(p912, 0, Local1), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 141)
		m1a2(Local1, c00d, 0, 0, c00d, 0, 142)

		Store(Index(p913, 0, Local1), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 143)
		m1a2(Local1, c00d, 0, 0, c00d, 0, 144)

		Store(Index(p914, 0, Local1), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 145)
		m1a2(Local1, c00d, 0, 0, c00d, 0, 146)

		Store(Index(p915, 0, Local1), Local0)
		m1a2(Local0, c016, 0, 0, c016, 0x10, 147)
		m1a2(Local1, c016, 0, 0, c016, 0x10, 148)
	}

	// Elements of Package are NOT Computational Data

	Store(Index(p916, 0, Local1), Local0)
	m1a0(Local0, c00e, Ones, 149)
	m1a0(Local1, c00e, Ones, 150)

	Store(Index(p917, 0, Local1), Local0)
	m1a0(Local0, c00f, Ones, 151)
	m1a0(Local1, c00f, Ones, 152)

	Store(Index(p918, 0, Local1), Local0)
	m1a0(Local0, c011, Ones, 153)
	m1a0(Local1, c011, Ones, 154)

	Store(Index(p919, 0, Local1), Local0)
	m1a0(Local0, c012, Ones, 155)
	m1a0(Local1, c012, Ones, 156)

	Store(Index(p91a, 0, Local1), Local0)
	m1a0(Local0, c013, Ones, 157)
	m1a0(Local1, c013, Ones, 158)

	Store(Index(p91b, 0, Local1), Local0)
	m1a0(Local0, c014, Ones, 159)
	m1a0(Local1, c014, Ones, 160)

	Store(Index(p91c, 0, Local1), Local0)
	m1a0(Local0, c015, Ones, 161)
	m1a0(Local1, c015, Ones, 162)

	// Elements of Package are Methods

	if (y105) {

		Store(Index(p91d, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 163)
		m1a0(Local1, c010, Ones, 164)

		Store(Index(p91e, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 165)
		m1a0(Local1, c010, Ones, 166)

		Store(Index(p91f, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 167)
		m1a0(Local1, c010, Ones, 168)

		Store(Index(p920, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 169)
		m1a0(Local1, c010, Ones, 170)

		Store(Index(p921, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 171)
		m1a0(Local1, c010, Ones, 172)

		Store(Index(p922, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 173)
		m1a0(Local1, c010, Ones, 174)

		Store(Index(p923, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 175)
		m1a0(Local1, c010, Ones, 176)

		Store(Index(p924, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 177)
		m1a0(Local1, c010, Ones, 178)

		Store(Index(p925, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 179)
		m1a0(Local1, c010, Ones, 180)

		Store(Index(p926, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 181)
		m1a0(Local1, c010, Ones, 182)

		Store(Index(p927, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 183)
		m1a0(Local1, c010, Ones, 184)

		Store(Index(p928, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 185)
		m1a0(Local1, c010, Ones, 186)

		Store(Index(p929, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 187)
		m1a0(Local1, c010, Ones, 188)

		Store(Index(p92a, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 189)
		m1a0(Local1, c010, Ones, 190)

		Store(Index(p92b, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 191)
		m1a0(Local1, c010, Ones, 192)

		Store(Index(p92c, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 193)
		m1a0(Local1, c010, Ones, 194)

		Store(Index(p92d, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 195)
		m1a0(Local1, c010, Ones, 196)

		Store(Index(p92e, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 197)
		m1a0(Local1, c010, Ones, 198)

		Store(Index(p92f, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 199)
		m1a0(Local1, c010, Ones, 200)

		Store(Index(p930, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 201)
		m1a0(Local1, c010, Ones, 202)

		Store(Index(p931, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 203)
		m1a0(Local1, c010, Ones, 204)

		Store(Index(p932, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 205)
		m1a0(Local1, c010, Ones, 206)

		Store(Index(p933, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 207)
		m1a0(Local1, c010, Ones, 208)

		Store(Index(p934, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 209)
		m1a0(Local1, c010, Ones, 210)

		if (y103) {
			Store(Index(p935, 0, Local1), Local0)
			m1a0(Local0, c010, Ones, 211)
			m1a0(Local1, c010, Ones, 212)
		}

		Store(Index(p936, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 213)
		m1a0(Local1, c010, Ones, 214)

		Store(Index(p937, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 215)
		m1a0(Local1, c010, Ones, 216)

		Store(Index(p938, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 217)
		m1a0(Local1, c010, Ones, 218)

		Store(Index(p939, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 219)
		m1a0(Local1, c010, Ones, 220)

		Store(Index(p93a, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 221)
		m1a0(Local1, c010, Ones, 222)

		Store(Index(p93b, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 223)
		m1a0(Local1, c010, Ones, 224)

		Store(Index(p93c, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 225)
		m1a0(Local1, c010, Ones, 226)

		Store(Index(p93d, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 227)
		m1a0(Local1, c010, Ones, 228)

		Store(Index(p93e, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 229)
		m1a0(Local1, c010, Ones, 230)

		Store(Index(p93f, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 231)
		m1a0(Local1, c010, Ones, 232)

		Store(Index(p940, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 233)
		m1a0(Local1, c010, Ones, 234)

		Store(Index(p941, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 235)
		m1a0(Local1, c010, Ones, 236)

		Store(Index(p942, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 237)
		m1a0(Local1, c010, Ones, 238)

		Store(Index(p943, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 239)
		m1a0(Local1, c010, Ones, 240)

		Store(Index(p944, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 241)
		m1a0(Local1, c010, Ones, 242)

		Store(Index(p945, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 243)
		m1a0(Local1, c010, Ones, 244)

		Store(Index(p946, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 245)
		m1a0(Local1, c010, Ones, 246)

		Store(Index(p947, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 247)
		m1a0(Local1, c010, Ones, 248)

		Store(Index(p948, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 249)
		m1a0(Local1, c010, Ones, 250)

		Store(Index(p949, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 251)
		m1a0(Local1, c010, Ones, 252)

		Store(Index(p94a, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 253)
		m1a0(Local1, c010, Ones, 254)

		Store(Index(p94b, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 255)
		m1a0(Local1, c010, Ones, 256)

		Store(Index(p94c, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 257)
		m1a0(Local1, c010, Ones, 258)

		Store(Index(p94d, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 259)
		m1a0(Local1, c010, Ones, 260)

		Store(Index(p94e, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 261)
		m1a0(Local1, c010, Ones, 262)

		Store(Index(p94f, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 263)
		m1a0(Local1, c010, Ones, 264)

		Store(Index(p950, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 265)
		m1a0(Local1, c010, Ones, 266)

		Store(Index(p951, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 267)
		m1a0(Local1, c010, Ones, 268)

		Store(Index(p952, 0, Local1), Local0)
		m1a0(Local0, c010, Ones, 269)
		m1a0(Local1, c010, Ones, 270)
	}

	m000()
	m1a6()
}

// arg0 - writing mode
Method(m16a, 1, Serialized)
{
	if (y100) {
		ts00("m16a")
	} else {
		Store("m16a", Debug)
	}

	// Not Computational Data

	Event(e900)
	Event(e9Z0)
	Mutex(mx90, 0)
	Mutex(mx91, 0)
	Device(d900) { Name(i900, 0xabcd2017) }
	Device(d9Z0) { Name(i900, 0xabcd2017) }
	ThermalZone(tz90) {}
	ThermalZone(tz91) {}
	Processor(pr90, 0, 0xFFFFFFFF, 0) {}
	Processor(pr91, 0, 0xFFFFFFFF, 0) {}
	OperationRegion(r900, SystemMemory, 0x100, 0x100)
	OperationRegion(r9Z0, SystemMemory, 0x100, 0x100)
	PowerResource(pw90, 1, 0) {Method(mmmm){return (0)}}
	PowerResource(pw91, 1, 0) {Method(mmmm){return (0)}}

	// Computational Data

	Name(i900, 0xfe7cb391d65a2000)
	Name(i9Z0, 0xfe7cb391d65a2000)
	Name(i901, 0xc1792001)
	Name(i9Z1, 0xc1792001)
	Name(i902, 0)
	Name(i903, 0xffffffffffffffff)
	Name(i904, 0xffffffff)
	Name(s900, "12342002")
	Name(s9Z0, "12342002")
	Name(s901, "qwrtyu2003")
	Name(s9Z1, "qwrtyu2003")
	Name(b900, Buffer() {0xc0,0xc1,0xc2,0xc3,0xc4})
	Name(b9Z0, Buffer() {0xc0,0xc1,0xc2,0xc3,0xc4})

	CreateField(b9Z0, 0, 8, bf90)
	Field(r9Z0, ByteAcc, NoLock, Preserve) {f900,8,f901,8,f902,8,f903,8}
	BankField(r9Z0, f901, 0, ByteAcc, NoLock, Preserve) {bn90,4}
	IndexField(f902, f903, ByteAcc, NoLock, Preserve) {if90,8,if91,8}

	// Elements of Package are Uninitialized

	Name(p900, Package(1) {})

	// Elements of Package are Computational Data

	Name(p901, Package() {0xabcd2004, 0x1122334455662005})
	Name(p902, Package() {"12342006", "q1w2e3r4t5y6u7i82007"})
	Name(p903, Package() {"qwrtyuiop2008", "1234567890abdef0252009"})
	Name(p904, Package() {Buffer() {0xc5,0xc6,0xc7}, Buffer() {0xc8,0xc9}})
	Name(p905, Package() {Package() {0xabc200a, "0xabc200b", "abc200c"}})
	Name(p906, Package() {Package() {"abc200d"}})
	Name(p907, Package() {Package() {"aqwevbgnm200e"}})
	Name(p908, Package() {Package() {Buffer() {0xca,0xcb,0xcc,0xcd,0xce}}})
	Name(p909, Package() {Package() {Package() {0xabc200f}}})
	Name(p90a, Package() {Package() {Package() {"12342010"}}})
	Name(p90b, Package() {Package() {Package() {"zxswefas2011"}}})
	Name(p90c, Package() {Package() {Package() {Buffer() {0xcf,0xd0,0xd1}}}})

	Name(p90d, Package() {i900})
	Name(p90e, Package() {i901})
	Name(p90f, Package() {s900})
	Name(p910, Package() {s901})
	Name(p911, Package() {b9Z0})
	Name(p912, Package() {f900})
	Name(p913, Package() {bn90})
	Name(p914, Package() {if90})
	Name(p915, Package() {bf90})

	// Elements of Package are NOT Computational Data

	Name(p916, Package() {d900})
	Name(p917, Package() {e900})
	Name(p918, Package() {mx90})
	Name(p919, Package() {r9Z0})
	Name(p91a, Package() {pw90})
	Name(p91b, Package() {pr90})
	Name(p91c, Package() {tz90})

	// Methods

	Method(m900) {}
	Method(m901) { return (0xabc2012) }
	Method(m902) { return ("zxvgswquiy2013") }
	Method(m903) { return (Buffer() {0xd2}) }
	Method(m904) { return (Package() {0xabc2014}) }
	Method(m905) { return (Package() {"lkjhgtre2015"}) }
	Method(m906) { return (Package() {Buffer() {0xd3}}) }
	Method(m907) { return (Package() {Package() {0xabc2016}}) }

	Method(m908) { return (i900) }
	Method(m909) { return (i901) }
	Method(m90a) { return (s900) }
	Method(m90b) { return (s901) }
	Method(m90c) { return (b9Z0) }
	Method(m90d) { return (f900) }
	Method(m90e) { return (bn90) }
	Method(m90f) { return (if90) }
	Method(m910) { return (bf90) }

	Method(m911) { return (d900) }
	Method(m912) { return (e900) }
	Method(m913) { return (m901) }
	Method(m914) { return (mx90) }
	Method(m915) { return (r9Z0) }
	Method(m916) { return (pw90) }
	Method(m917) { return (pr90) }
	Method(m918) { return (tz90) }
	Method(m919) { return (p900) }
	Method(m91a) { return (p901) }
	Method(m91b) { return (p902) }
	Method(m91c) { return (p903) }
	Method(m91d) { return (p904) }
	Method(m91e) { return (p905) }
	Method(m91f) { return (p906) }
	Method(m920) { return (p907) }
	Method(m921) { return (p908) }
	Method(m922) { return (p909) }
	Method(m923) { return (p90a) }
	Method(m924) { return (p90b) }
	Method(m925) { return (p90c) }
	Method(m926) { return (p90d) }
	Method(m927) { return (p90e) }
	Method(m928) { return (p90f) }
	Method(m929) { return (p910) }
	Method(m92a) { return (p911) }
	Method(m92b) { return (p912) }
	Method(m92c) { return (p913) }
	Method(m92d) { return (p914) }
	Method(m92e) { return (p915) }
	Method(m92f) { return (p916) }
	Method(m930) { return (p917) }
	Method(m931) { return (p918) }
	Method(m932) { return (p919) }
	Method(m933) { return (p91a) }
	Method(m934) { return (p91b) }
	Method(m935) { return (p91c) }

	// Elements of Package are Methods

	Name(p91d, Package() {m900})
	Name(p91e, Package() {m901})
	Name(p91f, Package() {m902})
	Name(p920, Package() {m903})
	Name(p921, Package() {m904})
	Name(p922, Package() {m905})
	Name(p923, Package() {m906})
	Name(p924, Package() {m907})
	Name(p925, Package() {m908})
	Name(p926, Package() {m909})
	Name(p927, Package() {m90a})
	Name(p928, Package() {m90b})
	Name(p929, Package() {m90c})
	Name(p92a, Package() {m90d})
	Name(p92b, Package() {m90e})
	Name(p92c, Package() {m90f})
	Name(p92d, Package() {m910})
	Name(p92e, Package() {m911})
	Name(p92f, Package() {m912})
	Name(p930, Package() {m913})
	Name(p931, Package() {m914})
	Name(p932, Package() {m915})
	Name(p933, Package() {m916})
	Name(p934, Package() {m917})
	if (y103) {
		Name(p935, Package() {m918})
	}
	Name(p936, Package() {m919})
	Name(p937, Package() {m91a})
	Name(p938, Package() {m91b})
	Name(p939, Package() {m91c})
	Name(p93a, Package() {m91d})
	Name(p93b, Package() {m91e})
	Name(p93c, Package() {m91f})
	Name(p93d, Package() {m920})
	Name(p93e, Package() {m921})
	Name(p93f, Package() {m922})
	Name(p940, Package() {m923})
	Name(p941, Package() {m924})
	Name(p942, Package() {m925})
	Name(p943, Package() {m926})
	Name(p944, Package() {m927})
	Name(p945, Package() {m928})
	Name(p946, Package() {m929})
	Name(p947, Package() {m92a})
	Name(p948, Package() {m92b})
	Name(p949, Package() {m92c})
	Name(p94a, Package() {m92d})
	Name(p94b, Package() {m92e})
	Name(p94c, Package() {m92f})
	Name(p94d, Package() {m930})
	Name(p94e, Package() {m931})
	Name(p94f, Package() {m932})
	Name(p950, Package() {m933})
	Name(p951, Package() {m934})
	Name(p952, Package() {m935})

	Name(p953, Package() {0xabcd2018, 0xabcd2019})
	Name(p954, Package() {0xabcd2018, 0xabcd2019})


	// Check that all the data (local) are not corrupted
	Method(m000)
	{
	// Computational Data

	// Integer

	Store(ObjectType(i900), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x100, 0, 0, Local0, c009)
	}
	if (LNotEqual(i900, 0xfe7cb391d65a2000)) {
		err(c080, z077, 0x101, 0, 0, i900, 0xfe7cb391d65a2000)
	}

	Store(ObjectType(i901), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x102, 0, 0, Local0, c009)
	}
	if (LNotEqual(i901, 0xc1792001)) {
		err(c080, z077, 0x103, 0, 0, i901, 0xc1792001)
	}

	Store(ObjectType(i902), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x104, 0, 0, Local0, c009)
	}
	if (LNotEqual(i902, 0)) {
		err(c080, z077, 0x105, 0, 0, i902, 0)
	}

	Store(ObjectType(i903), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x106, 0, 0, Local0, c009)
	}
	if (LNotEqual(i903, 0xffffffffffffffff)) {
		err(c080, z077, 0x107, 0, 0, i903, 0xffffffffffffffff)
	}

	Store(ObjectType(i904), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x108, 0, 0, Local0, c009)
	}
	if (LNotEqual(i904, 0xffffffff)) {
		err(c080, z077, 0x109, 0, 0, i904, 0xffffffff)
	}

	// String

	Store(ObjectType(s900), Local0)
	if (LNotEqual(Local0, c00a)) {
		err(c080, z077, 0x10a, 0, 0, Local0, c00a)
	}
	if (LNotEqual(s900, "12342002")) {
		err(c080, z077, 0x10b, 0, 0, s900, "12342002")
	}

	Store(ObjectType(s901), Local0)
	if (LNotEqual(Local0, c00a)) {
		err(c080, z077, 0x10c, 0, 0, Local0, c00a)
	}
	if (LNotEqual(s901, "qwrtyu2003")) {
		err(c080, z077, 0x10d, 0, 0, s901, "qwrtyu2003")
	}

	// Buffer

	Store(ObjectType(b900), Local0)
	if (LNotEqual(Local0, c00b)) {
		err(c080, z077, 0x10e, 0, 0, Local0, c00b)
	}
	if (LNotEqual(b900, Buffer() {0xc0,0xc1,0xc2,0xc3,0xc4})) {
		err(c080, z077, 0x10f, 0, 0, b900, Buffer() {0xc0,0xc1,0xc2,0xc3,0xc4})
	}

	// Buffer Field

	Store(ObjectType(bf90), Local0)
	if (LNotEqual(Local0, c016)) {
		err(c080, z077, 0x110, 0, 0, Local0, c016)
	}
	if (LNotEqual(bf90, 0xc0)) {
		err(c080, z077, 0x111, 0, 0, bf90, 0xc0)
	}

	// One level Package

	Store(Index(p900, 0), Local0)
	Store(ObjectType(Local0), Local1)
	if (LNotEqual(Local1, c008)) {
		err(c080, z077, 0x112, 0, 0, Local1, c008)
	}

	Store(Index(p901, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x113, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd2004)) {
		err(c080, z077, 0x114, 0, 0, Local1, 0xabcd2004)
	}

	Store(Index(p901, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x115, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0x1122334455662005)) {
		err(c080, z077, 0x116, 0, 0, Local1, 0x1122334455662005)
	}

	Store(Index(p902, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x117, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "12342006")) {
		err(c080, z077, 0x118, 0, 0, Local1, "12342006")
	}

	Store(Index(p902, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x119, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "q1w2e3r4t5y6u7i82007")) {
		err(c080, z077, 0x11a, 0, 0, Local1, "q1w2e3r4t5y6u7i82007")
	}

	Store(Index(p903, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x11b, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "qwrtyuiop2008")) {
		err(c080, z077, 0x11c, 0, 0, Local1, "qwrtyuiop2008")
	}

	Store(Index(p903, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x11d, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "1234567890abdef0252009")) {
		err(c080, z077, 0x11e, 0, 0, Local1, "1234567890abdef0252009")
	}

	Store(Index(p904, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00b)) {
		err(c080, z077, 0x11f, 0, 0, Local2, c00b)
	}
	if (LNotEqual(Local1, Buffer() {0xc5,0xc6,0xc7})) {
		err(c080, z077, 0x120, 0, 0, Local1, Buffer() {0xc5,0xc6,0xc7})
	}

	Store(Index(p904, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00b)) {
		err(c080, z077, 0x121, 0, 0, Local2, c00b)
	}
	if (LNotEqual(Local1, Buffer() {0xc8,0xc9})) {
		err(c080, z077, 0x122, 0, 0, Local1, Buffer() {0xc8,0xc9})
	}

	// Two level Package

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c009)) {
		err(c080, z077, 0x123, 0, 0, Local4, c009)
	}
	if (LNotEqual(Local3, 0xabc200a)) {
		err(c080, z077, 0x124, 0, 0, Local3, 0xabc200a)
	}

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 1), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x125, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "0xabc200b")) {
		err(c080, z077, 0x126, 0, 0, Local3, "0xabc200b")
	}

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 2), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x127, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "abc200c")) {
		err(c080, z077, 0x128, 0, 0, Local3, "abc200c")
	}

	Store(Index(p906, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x129, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "abc200d")) {
		err(c080, z077, 0x12a, 0, 0, Local3, "abc200d")
	}

	Store(Index(p907, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x12b, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "aqwevbgnm200e")) {
		err(c080, z077, 0x12c, 0, 0, Local3, "aqwevbgnm200e")
	}

	Store(Index(p908, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00b)) {
		err(c080, z077, 0x12d, 0, 0, Local4, c00b)
	}
	if (LNotEqual(Local3, Buffer() {0xca,0xcb,0xcc,0xcd,0xce})) {
		err(c080, z077, 0x12e, 0, 0, Local3, Buffer() {0xca,0xcb,0xcc,0xcd,0xce})
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
		err(c080, z077, 0x12f, 0, 0, Local6, c009)
	}
	if (LNotEqual(Local5, 0xabc200f)) {
		err(c080, z077, 0x130, 0, 0, Local5, 0xabc200f)
	}

	Store(Index(p90a, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00a)) {
		err(c080, z077, 0x131, 0, 0, Local6, c00a)
	}
	if (LNotEqual(Local5, "12342010")) {
		err(c080, z077, 0x132, 0, 0, Local5, "12342010")
	}

	Store(Index(p90b, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00a)) {
		err(c080, z077, 0x133, 0, 0, Local6, c00a)
	}
	if (LNotEqual(Local5, "zxswefas2011")) {
		err(c080, z077, 0x134, 0, 0, Local5, "zxswefas2011")
	}

	Store(Index(p90c, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00b)) {
		err(c080, z077, 0x135, 0, 0, Local6, c00b)
	}
	if (LNotEqual(Local5, Buffer() {0xcf,0xd0,0xd1})) {
		err(c080, z077, 0x136, 0, 0, Local5, Buffer() {0xcf,0xd0,0xd1})
	}

	Store(Index(p953, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x137, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd2018)) {
		err(c080, z077, 0x138, 0, 0, Local1, 0xabcd2018)
	}

	Store(Index(p953, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x139, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd2019)) {
		err(c080, z077, 0x13a, 0, 0, Local1, 0xabcd2019)
	}

	// Not Computational Data

	m1aa(c080, e900, c00f, 0, 0x13b)
	m1aa(c080, mx90, c011, 0, 0x13c)
	m1aa(c080, d900, c00e, 0, 0x13d)
	if (y508) {
		m1aa(c080, tz90, c015, 0, 0x13e)
	}
	m1aa(c080, pr90, c014, 0, 0x13f)
	m1aa(c080, r900, c012, 0, 0x140)
	m1aa(c080, pw90, c013, 0, 0x141)

/*
 *	// Field Unit (Field)
 *
 *	if (LNotEqual(f900, 0xd7)) {
 *		err(c080, z077, 0x137, 0, 0, f900, 0xd7)
 *	}
 *
 *	// Field Unit (IndexField)
 *
 *	if (LNotEqual(if90, 0xd7)) {
 *		err(c080, z077, 0x138, 0, 0, if90, 0xd7)
 *	}
 */
	} /* m000 */

	// Check and restore the global data after writing into them
	Method(m001)
	{

	// Computational Data

	m1aa(c080, i900, c009, c08a, 0x144)
	CopyObject(i9Z0, i900)

	m1aa(c080, i901, c009, c08a, 0x145)
	CopyObject(i9Z1, i901)

	m1aa(c080, s900, c009, c08a, 0x146)
	CopyObject(s9Z0, s900)

	m1aa(c080, s901, c009, c08a, 0x147)
	CopyObject(s9Z1, s901)

	m1aa(c080, b900, c009, c08a, 0x148)
	CopyObject(b9Z0, b900)

	// Package

	m1aa(c080, p953, c009, c08a, 0x149)
	CopyObject(p954, p953)

	// Not Computational Data

	m1aa(c080, e900, c009, c08a, 0x14a)
	CopyObject(e9Z0, e900)

	m1aa(c080, mx90, c009, c08a, 0x14b)
	CopyObject(mx91, mx90)

	m1aa(c080, d900, c009, c08a, 0x14c)
	CopyObject(d9Z0, d900)

	if (y508) {
		m1aa(c080, tz90, c009, c08a, 0x14d)
		CopyObject(tz91, tz90)
	}

	m1aa(c080, pr90, c009, c08a, 0x14e)
	CopyObject(pr91, pr90)

	if (y510) {
		m1aa(c080, r900, c009, c08a, 0x14f)
		CopyObject(r9Z0, r900)
	}

	m1aa(c080, pw90, c009, c08a, 0x150)
	CopyObject(pw91, pw90)

	m000()
	} /* m001 */


	// T2:R1-R14

	// Computational Data

	Store(RefOf(i900), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a2000, 271)

	Store(RefOf(i901), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xc1792001, 272)

	Store(RefOf(s900), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12342002", 273)

	Store(RefOf(s901), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu2003", 274)

	Store(RefOf(b900), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xc0,0xc1,0xc2,0xc3,0xc4}, 275)

	// Not Computational Data

	Store(RefOf(e900), Local0)
	m1a0(Local0, c00f, Ones, 280)

	Store(RefOf(mx90), Local0)
	m1a0(Local0, c011, Ones, 281)

	Store(RefOf(d900), Local0)
	m1a0(Local0, c00e, Ones, 282)

	if (arg0) {
		if (y508) {
			Store(RefOf(tz90), Local0)
			m1a0(Local0, c015, Ones, 283)
		}
	} else {
		Store(RefOf(tz90), Local0)
		m1a0(Local0, c015, Ones, 283)
	}

	Store(RefOf(pr90), Local0)
	m1a0(Local0, c014, Ones, 284)

	if (arg0) {
		if (y510) {
			Store(RefOf(r900), Local0)
			m1a0(Local0, c012, Ones, 285)
		}
	} else {
		Store(RefOf(r900), Local0)
		m1a0(Local0, c012, Ones, 1002)
	}

	Store(RefOf(pw90), Local0)
	m1a0(Local0, c013, Ones, 286)

	// Package

	Store(RefOf(p953), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabcd2018, 1001)

	if (arg0) {
		m001()
		return
	}

	// Computational Data (Field Unit and Buffer Field)

	Store(RefOf(f900), Local0)
	m1a2(Local0, c00d, 0, 0, c009, 0, 276)

	Store(RefOf(bn90), Local0)
	m1a2(Local0, c00d, 0, 0, c009, 0, 277)

	Store(RefOf(if90), Local0)
	m1a2(Local0, c00d, 0, 0, c009, 0, 278)

	Store(RefOf(bf90), Local0)
	m1a2(Local0, c016, 0, 0, c009, 0xc0, 279)

	// Elements of Package are Uninitialized

	Store(RefOf(p900), Local0)
	m1a0(Local0, c00c, Ones, 287)

	// Elements of Package are Computational Data

	Store(RefOf(p901), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabcd2004, 288)
	m1a2(Local0, c00c, 1, 1, c009, 0x1122334455662005, 289)

	Store(RefOf(p902), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "12342006", 290)
	m1a2(Local0, c00c, 1, 1, c00a, "q1w2e3r4t5y6u7i82007", 291)

	Store(RefOf(p903), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyuiop2008", 292)
	m1a2(Local0, c00c, 1, 1, c00a, "1234567890abdef0252009", 293)

	Store(RefOf(p904), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xc5,0xc6,0xc7}, 294)

	Store(RefOf(p905), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabc200a, 295)
	m1a2(Local0, c00c, 2, 1, c00a, "0xabc200b", 296)

	Store(RefOf(p906), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "abc200d", 297)

	Store(RefOf(p907), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "aqwevbgnm200e", 298)

	Store(RefOf(p908), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xca,0xcb,0xcc,0xcd,0xce}, 299)

	Store(RefOf(p909), Local0)
	m1a2(Local0, c00c, 3, 0, c009, 0xabc200f, 300)

	Store(RefOf(p90a), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "12342010", 301)

	Store(RefOf(p90b), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "zxswefas2011", 302)

	Store(RefOf(p90c), Local0)
	m1a2(Local0, c00c, 3, 0, c00b, Buffer() {0xcf,0xd0,0xd1}, 303)

	Store(RefOf(p90d), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xfe7cb391d65a2000, 304)

	Store(RefOf(p90e), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xc1792001, 305)

	Store(RefOf(p90f), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "12342002", 306)

	Store(RefOf(p910), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyu2003", 307)

	Store(RefOf(p911), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xc0,0xc1,0xc2,0xc3,0xc4}, 308)

	if (y118) {
		Store(RefOf(p912), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 309)

		Store(RefOf(p913), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 310)

		Store(RefOf(p914), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 311)

		Store(RefOf(p915), Local0)
		m1a2(Local0, c00c, 1, 0, c016, 0xc0, 312)
	}

	// Elements of Package are NOT Computational Data

	Store(RefOf(p916), Local0)
	m1a0(Local0, c00c, Ones, 313)

	Store(RefOf(p917), Local0)
	m1a0(Local0, c00c, Ones, 314)

	Store(RefOf(p918), Local0)
	m1a0(Local0, c00c, Ones, 315)

	Store(RefOf(p919), Local0)
	m1a0(Local0, c00c, Ones, 316)

	Store(RefOf(p91a), Local0)
	m1a0(Local0, c00c, Ones, 317)

	Store(RefOf(p91b), Local0)
	m1a0(Local0, c00c, Ones, 318)

	Store(RefOf(p91c), Local0)
	m1a0(Local0, c00c, Ones, 319)

	// Elements of Package are Methods

	Store(RefOf(p91d), Local0)
	m1a0(Local0, c00c, Ones, 320)

	Store(RefOf(p91e), Local0)
	m1a0(Local0, c00c, Ones, 321)

	Store(RefOf(p91f), Local0)
	m1a0(Local0, c00c, Ones, 322)

	Store(RefOf(p920), Local0)
	m1a0(Local0, c00c, Ones, 323)

	Store(RefOf(p921), Local0)
	m1a0(Local0, c00c, Ones, 324)

	Store(RefOf(p922), Local0)
	m1a0(Local0, c00c, Ones, 325)

	Store(RefOf(p923), Local0)
	m1a0(Local0, c00c, Ones, 326)

	Store(RefOf(p924), Local0)
	m1a0(Local0, c00c, Ones, 327)

	Store(RefOf(p925), Local0)
	m1a0(Local0, c00c, Ones, 328)

	Store(RefOf(p926), Local0)
	m1a0(Local0, c00c, Ones, 329)

	Store(RefOf(p927), Local0)
	m1a0(Local0, c00c, Ones, 330)

	Store(RefOf(p928), Local0)
	m1a0(Local0, c00c, Ones, 331)

	Store(RefOf(p929), Local0)
	m1a0(Local0, c00c, Ones, 332)

	Store(RefOf(p92a), Local0)
	m1a0(Local0, c00c, Ones, 333)

	Store(RefOf(p92b), Local0)
	m1a0(Local0, c00c, Ones, 334)

	Store(RefOf(p92c), Local0)
	m1a0(Local0, c00c, Ones, 335)

	Store(RefOf(p92d), Local0)
	m1a0(Local0, c00c, Ones, 336)

	Store(RefOf(p92e), Local0)
	m1a0(Local0, c00c, Ones, 337)

	Store(RefOf(p92f), Local0)
	m1a0(Local0, c00c, Ones, 338)

	Store(RefOf(p930), Local0)
	m1a0(Local0, c00c, Ones, 339)

	Store(RefOf(p931), Local0)
	m1a0(Local0, c00c, Ones, 340)

	Store(RefOf(p932), Local0)
	m1a0(Local0, c00c, Ones, 341)

	Store(RefOf(p933), Local0)
	m1a0(Local0, c00c, Ones, 342)

	Store(RefOf(p934), Local0)
	m1a0(Local0, c00c, Ones, 343)

	Store(RefOf(p935), Local0)
	m1a0(Local0, c00c, Ones, 344)

	Store(RefOf(p936), Local0)
	m1a0(Local0, c00c, Ones, 345)

	Store(RefOf(p937), Local0)
	m1a0(Local0, c00c, Ones, 346)

	Store(RefOf(p938), Local0)
	m1a0(Local0, c00c, Ones, 347)

	Store(RefOf(p939), Local0)
	m1a0(Local0, c00c, Ones, 348)

	Store(RefOf(p93a), Local0)
	m1a0(Local0, c00c, Ones, 349)

	Store(RefOf(p93b), Local0)
	m1a0(Local0, c00c, Ones, 350)

	Store(RefOf(p93c), Local0)
	m1a0(Local0, c00c, Ones, 351)

	Store(RefOf(p93d), Local0)
	m1a0(Local0, c00c, Ones, 352)

	Store(RefOf(p93e), Local0)
	m1a0(Local0, c00c, Ones, 353)

	Store(RefOf(p93f), Local0)
	m1a0(Local0, c00c, Ones, 354)

	Store(RefOf(p940), Local0)
	m1a0(Local0, c00c, Ones, 355)

	Store(RefOf(p941), Local0)
	m1a0(Local0, c00c, Ones, 356)

	Store(RefOf(p942), Local0)
	m1a0(Local0, c00c, Ones, 357)

	Store(RefOf(p943), Local0)
	m1a0(Local0, c00c, Ones, 358)

	Store(RefOf(p944), Local0)
	m1a0(Local0, c00c, Ones, 359)

	Store(RefOf(p945), Local0)
	m1a0(Local0, c00c, Ones, 360)

	Store(RefOf(p946), Local0)
	m1a0(Local0, c00c, Ones, 361)

	Store(RefOf(p947), Local0)
	m1a0(Local0, c00c, Ones, 362)

	Store(RefOf(p948), Local0)
	m1a0(Local0, c00c, Ones, 363)

	Store(RefOf(p949), Local0)
	m1a0(Local0, c00c, Ones, 364)

	Store(RefOf(p94a), Local0)
	m1a0(Local0, c00c, Ones, 365)

	Store(RefOf(p94b), Local0)
	m1a0(Local0, c00c, Ones, 366)

	Store(RefOf(p94c), Local0)
	m1a0(Local0, c00c, Ones, 367)

	Store(RefOf(p94d), Local0)
	m1a0(Local0, c00c, Ones, 368)

	Store(RefOf(p94e), Local0)
	m1a0(Local0, c00c, Ones, 369)

	Store(RefOf(p94f), Local0)
	m1a0(Local0, c00c, Ones, 370)

	Store(RefOf(p950), Local0)
	m1a0(Local0, c00c, Ones, 371)

	Store(RefOf(p951), Local0)
	m1a0(Local0, c00c, Ones, 372)

	Store(RefOf(p952), Local0)
	m1a0(Local0, c00c, Ones, 373)

	// Methods

	Store(RefOf(m900), Local0)
	m1a0(Local0, c010, Ones, 374)

	Store(RefOf(m901), Local0)
	m1a0(Local0, c010, Ones, 375)

	Store(RefOf(m902), Local0)
	m1a0(Local0, c010, Ones, 376)

	Store(RefOf(m903), Local0)
	m1a0(Local0, c010, Ones, 377)

	Store(RefOf(m904), Local0)
	m1a0(Local0, c010, Ones, 378)

	Store(RefOf(m905), Local0)
	m1a0(Local0, c010, Ones, 379)

	Store(RefOf(m906), Local0)
	m1a0(Local0, c010, Ones, 380)

	Store(RefOf(m907), Local0)
	m1a0(Local0, c010, Ones, 381)

	Store(RefOf(m908), Local0)
	m1a0(Local0, c010, Ones, 382)

	Store(RefOf(m909), Local0)
	m1a0(Local0, c010, Ones, 383)

	Store(RefOf(m90a), Local0)
	m1a0(Local0, c010, Ones, 384)

	Store(RefOf(m90b), Local0)
	m1a0(Local0, c010, Ones, 385)

	Store(RefOf(m90c), Local0)
	m1a0(Local0, c010, Ones, 386)

	Store(RefOf(m90d), Local0)
	m1a0(Local0, c010, Ones, 387)

	Store(RefOf(m90e), Local0)
	m1a0(Local0, c010, Ones, 388)

	Store(RefOf(m90f), Local0)
	m1a0(Local0, c010, Ones, 389)

	Store(RefOf(m910), Local0)
	m1a0(Local0, c010, Ones, 390)

	Store(RefOf(m911), Local0)
	m1a0(Local0, c010, Ones, 391)

	Store(RefOf(m912), Local0)
	m1a0(Local0, c010, Ones, 392)

	Store(RefOf(m913), Local0)
	m1a0(Local0, c010, Ones, 393)

	Store(RefOf(m914), Local0)
	m1a0(Local0, c010, Ones, 394)

	Store(RefOf(m915), Local0)
	m1a0(Local0, c010, Ones, 395)

	Store(RefOf(m916), Local0)
	m1a0(Local0, c010, Ones, 396)

	Store(RefOf(m917), Local0)
	m1a0(Local0, c010, Ones, 397)

	Store(RefOf(m918), Local0)
	m1a0(Local0, c010, Ones, 398)

	Store(RefOf(m919), Local0)
	m1a0(Local0, c010, Ones, 399)

	Store(RefOf(m91a), Local0)
	m1a0(Local0, c010, Ones, 400)

	Store(RefOf(m91b), Local0)
	m1a0(Local0, c010, Ones, 401)

	Store(RefOf(m91c), Local0)
	m1a0(Local0, c010, Ones, 402)

	Store(RefOf(m91d), Local0)
	m1a0(Local0, c010, Ones, 403)

	Store(RefOf(m91e), Local0)
	m1a0(Local0, c010, Ones, 404)

	Store(RefOf(m91f), Local0)
	m1a0(Local0, c010, Ones, 405)

	Store(RefOf(m920), Local0)
	m1a0(Local0, c010, Ones, 406)

	Store(RefOf(m921), Local0)
	m1a0(Local0, c010, Ones, 407)

	Store(RefOf(m922), Local0)
	m1a0(Local0, c010, Ones, 408)

	Store(RefOf(m923), Local0)
	m1a0(Local0, c010, Ones, 409)

	Store(RefOf(m924), Local0)
	m1a0(Local0, c010, Ones, 410)

	Store(RefOf(m925), Local0)
	m1a0(Local0, c010, Ones, 411)

	Store(RefOf(m926), Local0)
	m1a0(Local0, c010, Ones, 412)

	Store(RefOf(m927), Local0)
	m1a0(Local0, c010, Ones, 413)

	Store(RefOf(m928), Local0)
	m1a0(Local0, c010, Ones, 414)

	Store(RefOf(m929), Local0)
	m1a0(Local0, c010, Ones, 415)

	Store(RefOf(m92a), Local0)
	m1a0(Local0, c010, Ones, 416)

	Store(RefOf(m92b), Local0)
	m1a0(Local0, c010, Ones, 417)

	Store(RefOf(m92c), Local0)
	m1a0(Local0, c010, Ones, 418)

	Store(RefOf(m92d), Local0)
	m1a0(Local0, c010, Ones, 419)

	Store(RefOf(m92e), Local0)
	m1a0(Local0, c010, Ones, 420)

	Store(RefOf(m92f), Local0)
	m1a0(Local0, c010, Ones, 421)

	Store(RefOf(m930), Local0)
	m1a0(Local0, c010, Ones, 422)

	Store(RefOf(m931), Local0)
	m1a0(Local0, c010, Ones, 423)

	Store(RefOf(m932), Local0)
	m1a0(Local0, c010, Ones, 424)

	Store(RefOf(m933), Local0)
	m1a0(Local0, c010, Ones, 425)

	Store(RefOf(m934), Local0)
	m1a0(Local0, c010, Ones, 426)

	Store(RefOf(m935), Local0)
	m1a0(Local0, c010, Ones, 427)

	m000()
	m1a6()

	return
}

Method(m16b,, Serialized)
{
	if (y100) {
		ts00("m16b")
	} else {
		Store("m16b", Debug)
	}

	// Not Computational Data

	Event(e900)
	Mutex(mx90, 0)
	Device(d900) {}
	ThermalZone(tz90) {}
	Processor(pr90, 0, 0xFFFFFFFF, 0) {}
	OperationRegion(r900, SystemMemory, 0x100, 0x100)
	OperationRegion(r9Z0, SystemMemory, 0x100, 0x100)
	PowerResource(pw90, 1, 0) {Method(mmmm){return (0)}}

	// Computational Data

	Name(i900, 0xfe7cb391d65a3000)
	Name(i901, 0x21793001)
	Name(i902, 0)
	Name(i903, 0xffffffffffffffff)
	Name(i904, 0xffffffff)
	Name(s900, "12343002")
	Name(s901, "qwrtyu3003")
	Name(b900, Buffer() {0xd0,0xd1,0xd2,0xd3,0xd4})
	Name(b9Z0, Buffer() {0xd0,0xd1,0xd2,0xd3,0xd4})

	CreateField(b900, 0, 8, bf90)
	Field(r900, ByteAcc, NoLock, Preserve) {f900,8,f901,8,f902,8,f903,8}
	BankField(r900, f901, 0, ByteAcc, NoLock, Preserve) {bn90,4}
	IndexField(f902, f903, ByteAcc, NoLock, Preserve) {if90,8,if91,8}

	// Elements of Package are Uninitialized

	Name(p900, Package(1) {})

	// Elements of Package are Computational Data

	Name(p901, Package() {0xabcd3004, 0x1122334455663005})
	Name(p902, Package() {"12343006", "q1w2e3r4t5y6u7i83007"})
	Name(p903, Package() {"qwrtyuiop3008", "1234567890abdef0253009"})
	Name(p904, Package() {Buffer() {0xd5,0xd6,0xd7}, Buffer() {0xd8,0xd9}})
	Name(p905, Package() {Package() {0xabc300a, "0xabc300b", "abc300c"}})
	Name(p906, Package() {Package() {"abc300d"}})
	Name(p907, Package() {Package() {"aqwevbgnm300e"}})
	Name(p908, Package() {Package() {Buffer() {0xda,0xdb,0xdc,0xdd,0xde}}})
	Name(p909, Package() {Package() {Package() {0xabc300f}}})
	Name(p90a, Package() {Package() {Package() {"12343010"}}})
	Name(p90b, Package() {Package() {Package() {"zxswefas3011"}}})
	Name(p90c, Package() {Package() {Package() {Buffer() {0xdf,0x20,0x21}}}})

	Name(p90d, Package() {i900})
	Name(p90e, Package() {i901})
	Name(p90f, Package() {s900})
	Name(p910, Package() {s901})
	Name(p911, Package() {b9Z0})
	Name(p912, Package() {f900})
	Name(p913, Package() {bn90})
	Name(p914, Package() {if90})
	Name(p915, Package() {bf90})

	// Elements of Package are NOT Computational Data

	Name(p916, Package() {d900})
	Name(p917, Package() {e900})
	Name(p918, Package() {mx90})
	Name(p919, Package() {r900})
	Name(p91a, Package() {pw90})
	Name(p91b, Package() {pr90})
	Name(p91c, Package() {tz90})

	// Methods

	Method(m900) {}
	Method(m901) { return (0xabc3012) }
	Method(m902) { return ("zxvgswquiy3013") }
	Method(m903) { return (Buffer() {0x22}) }
	Method(m904) { return (Package() {0xabc3014}) }
	Method(m905) { return (Package() {"lkjhgtre3015"}) }
	Method(m906) { return (Package() {Buffer() {0x23}}) }
	Method(m907) { return (Package() {Package() {0xabc3016}}) }

	Method(m908) { return (i900) }
	Method(m909) { return (i901) }
	Method(m90a) { return (s900) }
	Method(m90b) { return (s901) }
	Method(m90c) { return (b9Z0) }
	Method(m90d) { return (f900) }
	Method(m90e) { return (bn90) }
	Method(m90f) { return (if90) }
	Method(m910) { return (bf90) }

	Method(m911) { return (d900) }
	Method(m912) { return (e900) }
	Method(m913) { return (m901) }
	Method(m914) { return (mx90) }
	Method(m915) { return (r900) }
	Method(m916) { return (pw90) }
	Method(m917) { return (pr90) }
	Method(m918) { return (tz90) }

	Method(m919) { return (p900) }
	Method(m91a) { return (p901) }
	Method(m91b) { return (p902) }
	Method(m91c) { return (p903) }
	Method(m91d) { return (p904) }
	Method(m91e) { return (p905) }
	Method(m91f) { return (p906) }
	Method(m920) { return (p907) }
	Method(m921) { return (p908) }
	Method(m922) { return (p909) }
	Method(m923) { return (p90a) }
	Method(m924) { return (p90b) }
	Method(m925) { return (p90c) }
	Method(m926) { return (p90d) }
	Method(m927) { return (p90e) }
	Method(m928) { return (p90f) }
	Method(m929) { return (p910) }
	Method(m92a) { return (p911) }
	Method(m92b) { return (p912) }
	Method(m92c) { return (p913) }
	Method(m92d) { return (p914) }
	Method(m92e) { return (p915) }
	Method(m92f) { return (p916) }
	Method(m930) { return (p917) }
	Method(m931) { return (p918) }
	Method(m932) { return (p919) }
	Method(m933) { return (p91a) }
	Method(m934) { return (p91b) }
	Method(m935) { return (p91c) }

	// Elements of Package are Methods

	Name(p91d, Package() {m900})
	Name(p91e, Package() {m901})
	Name(p91f, Package() {m902})
	Name(p920, Package() {m903})
	Name(p921, Package() {m904})
	Name(p922, Package() {m905})
	Name(p923, Package() {m906})
	Name(p924, Package() {m907})
	Name(p925, Package() {m908})
	Name(p926, Package() {m909})
	Name(p927, Package() {m90a})
	Name(p928, Package() {m90b})
	Name(p929, Package() {m90c})
	Name(p92a, Package() {m90d})
	Name(p92b, Package() {m90e})
	Name(p92c, Package() {m90f})
	Name(p92d, Package() {m910})
	Name(p92e, Package() {m911})
	Name(p92f, Package() {m912})
	Name(p930, Package() {m913})
	Name(p931, Package() {m914})
	Name(p932, Package() {m915})
	Name(p933, Package() {m916})
	Name(p934, Package() {m917})
	if (y103) {
		Name(p935, Package() {m918})
	}
	Name(p936, Package() {m919})
	Name(p937, Package() {m91a})
	Name(p938, Package() {m91b})
	Name(p939, Package() {m91c})
	Name(p93a, Package() {m91d})
	Name(p93b, Package() {m91e})
	Name(p93c, Package() {m91f})
	Name(p93d, Package() {m920})
	Name(p93e, Package() {m921})
	Name(p93f, Package() {m922})
	Name(p940, Package() {m923})
	Name(p941, Package() {m924})
	Name(p942, Package() {m925})
	Name(p943, Package() {m926})
	Name(p944, Package() {m927})
	Name(p945, Package() {m928})
	Name(p946, Package() {m929})
	Name(p947, Package() {m92a})
	Name(p948, Package() {m92b})
	Name(p949, Package() {m92c})
	Name(p94a, Package() {m92d})
	Name(p94b, Package() {m92e})
	Name(p94c, Package() {m92f})
	Name(p94d, Package() {m930})
	Name(p94e, Package() {m931})
	Name(p94f, Package() {m932})
	Name(p950, Package() {m933})
	Name(p951, Package() {m934})
	Name(p952, Package() {m935})

	Name(p953, Package() {0xabcd3018, 0xabcd3019})
	Name(p954, Package() {0xabcd3018, 0xabcd3019})

	// Check that all the data (local) are not corrupted
	Method(m000)
	{
	// Computational Data

	// Integer

	Store(ObjectType(i900), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x100, 0, 0, Local0, c009)
	}
	if (LNotEqual(i900, 0xfe7cb391d65a3000)) {
		err(c080, z077, 0x101, 0, 0, i900, 0xfe7cb391d65a3000)
	}

	Store(ObjectType(i901), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x102, 0, 0, Local0, c009)
	}
	if (LNotEqual(i901, 0x21793001)) {
		err(c080, z077, 0x103, 0, 0, i901, 0x21793001)
	}

	Store(ObjectType(i902), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x104, 0, 0, Local0, c009)
	}
	if (LNotEqual(i902, 0)) {
		err(c080, z077, 0x105, 0, 0, i902, 0)
	}

	Store(ObjectType(i903), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x106, 0, 0, Local0, c009)
	}
	if (LNotEqual(i903, 0xffffffffffffffff)) {
		err(c080, z077, 0x107, 0, 0, i903, 0xffffffffffffffff)
	}

	Store(ObjectType(i904), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x108, 0, 0, Local0, c009)
	}
	if (LNotEqual(i904, 0xffffffff)) {
		err(c080, z077, 0x109, 0, 0, i904, 0xffffffff)
	}

	// String

	Store(ObjectType(s900), Local0)
	if (LNotEqual(Local0, c00a)) {
		err(c080, z077, 0x10a, 0, 0, Local0, c00a)
	}
	if (LNotEqual(s900, "12343002")) {
		err(c080, z077, 0x10b, 0, 0, s900, "12343002")
	}

	Store(ObjectType(s901), Local0)
	if (LNotEqual(Local0, c00a)) {
		err(c080, z077, 0x10c, 0, 0, Local0, c00a)
	}
	if (LNotEqual(s901, "qwrtyu3003")) {
		err(c080, z077, 0x10d, 0, 0, s901, "qwrtyu3003")
	}

	// Buffer

	Store(ObjectType(b900), Local0)
	if (LNotEqual(Local0, c00b)) {
		err(c080, z077, 0x10e, 0, 0, Local0, c00b)
	}
	if (LNotEqual(b900, Buffer() {0xd0,0xd1,0xd2,0xd3,0xd4})) {
		err(c080, z077, 0x10f, 0, 0, b900, Buffer() {0xd0,0xd1,0xd2,0xd3,0xd4})
	}

	// Buffer Field

	Store(ObjectType(bf90), Local0)
	if (LNotEqual(Local0, c016)) {
		err(c080, z077, 0x110, 0, 0, Local0, c016)
	}
	if (LNotEqual(bf90, 0xd0)) {
		err(c080, z077, 0x111, 0, 0, bf90, 0xd0)
	}

	// One level Package

	Store(Index(p900, 0), Local0)
	Store(ObjectType(Local0), Local1)
	if (LNotEqual(Local1, c008)) {
		err(c080, z077, 0x112, 0, 0, Local1, c008)
	}

	Store(Index(p901, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x113, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd3004)) {
		err(c080, z077, 0x114, 0, 0, Local1, 0xabcd3004)
	}

	Store(Index(p901, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x115, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0x1122334455663005)) {
		err(c080, z077, 0x116, 0, 0, Local1, 0x1122334455663005)
	}

	Store(Index(p902, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x117, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "12343006")) {
		err(c080, z077, 0x118, 0, 0, Local1, "12343006")
	}

	Store(Index(p902, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x119, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "q1w2e3r4t5y6u7i83007")) {
		err(c080, z077, 0x11a, 0, 0, Local1, "q1w2e3r4t5y6u7i83007")
	}

	Store(Index(p903, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x11b, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "qwrtyuiop3008")) {
		err(c080, z077, 0x11c, 0, 0, Local1, "qwrtyuiop3008")
	}

	Store(Index(p903, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x11d, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "1234567890abdef0253009")) {
		err(c080, z077, 0x11e, 0, 0, Local1, "1234567890abdef0253009")
	}

	Store(Index(p904, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00b)) {
		err(c080, z077, 0x11f, 0, 0, Local2, c00b)
	}
	if (LNotEqual(Local1, Buffer() {0xd5,0xd6,0xd7})) {
		err(c080, z077, 0x120, 0, 0, Local1, Buffer() {0xd5,0xd6,0xd7})
	}

	Store(Index(p904, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00b)) {
		err(c080, z077, 0x121, 0, 0, Local2, c00b)
	}
	if (LNotEqual(Local1, Buffer() {0xd8,0xd9})) {
		err(c080, z077, 0x122, 0, 0, Local1, Buffer() {0xd8,0xd9})
	}

	// Two level Package

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c009)) {
		err(c080, z077, 0x123, 0, 0, Local4, c009)
	}
	if (LNotEqual(Local3, 0xabc300a)) {
		err(c080, z077, 0x124, 0, 0, Local3, 0xabc300a)
	}

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 1), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x125, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "0xabc300b")) {
		err(c080, z077, 0x126, 0, 0, Local3, "0xabc300b")
	}

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 2), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x127, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "abc300c")) {
		err(c080, z077, 0x128, 0, 0, Local3, "abc300c")
	}

	Store(Index(p906, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x129, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "abc300d")) {
		err(c080, z077, 0x12a, 0, 0, Local3, "abc300d")
	}

	Store(Index(p907, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x12b, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "aqwevbgnm300e")) {
		err(c080, z077, 0x12c, 0, 0, Local3, "aqwevbgnm300e")
	}

	Store(Index(p908, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00b)) {
		err(c080, z077, 0x12d, 0, 0, Local4, c00b)
	}
	if (LNotEqual(Local3, Buffer() {0xda,0xdb,0xdc,0xdd,0xde})) {
		err(c080, z077, 0x12e, 0, 0, Local3, Buffer() {0xda,0xdb,0xdc,0xdd,0xde})
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
		err(c080, z077, 0x12f, 0, 0, Local6, c009)
	}
	if (LNotEqual(Local5, 0xabc300f)) {
		err(c080, z077, 0x130, 0, 0, Local5, 0xabc300f)
	}

	Store(Index(p90a, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00a)) {
		err(c080, z077, 0x131, 0, 0, Local6, c00a)
	}
	if (LNotEqual(Local5, "12343010")) {
		err(c080, z077, 0x132, 0, 0, Local5, "12343010")
	}

	Store(Index(p90b, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00a)) {
		err(c080, z077, 0x133, 0, 0, Local6, c00a)
	}
	if (LNotEqual(Local5, "zxswefas3011")) {
		err(c080, z077, 0x134, 0, 0, Local5, "zxswefas3011")
	}

	Store(Index(p90c, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00b)) {
		err(c080, z077, 0x135, 0, 0, Local6, c00b)
	}
	if (LNotEqual(Local5, Buffer() {0xdf,0x20,0x21})) {
		err(c080, z077, 0x136, 0, 0, Local5, Buffer() {0xdf,0x20,0x21})
	}

	Store(Index(p953, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x137, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd3018)) {
		err(c080, z077, 0x138, 0, 0, Local1, 0xabcd3018)
	}

	Store(Index(p953, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x139, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd3019)) {
		err(c080, z077, 0x13a, 0, 0, Local1, 0xabcd3019)
	}

	// Not Computational Data

	m1aa(c080, e900, c00f, 0, 0x13b)
	m1aa(c080, mx90, c011, 0, 0x13c)
	m1aa(c080, d900, c00e, 0, 0x13d)
	if (y508) {
		m1aa(c080, tz90, c015, 0, 0x13e)
	}
	m1aa(c080, pr90, c014, 0, 0x13f)
	m1aa(c080, r900, c012, 0, 0x140)
	m1aa(c080, pw90, c013, 0, 0x141)

/*
 *	// Field Unit (Field)
 *
 *	if (LNotEqual(f900, 0xd7)) {
 *		err(c080, z077, 0x137, 0, 0, f900, 0xd7)
 *	}
 *
 *	// Field Unit (IndexField)
 *
 *	if (LNotEqual(if90, 0xd7)) {
 *		err(c080, z077, 0x138, 0, 0, if90, 0xd7)
 *	}
 */
	} /* m000 */


	// T2:C1-C14

	// Computational Data

	Store(CondRefOf(i900), Local0)
	m1a4(Local0, 428)

	Store(CondRefOf(i901), Local0)
	m1a4(Local0, 429)

	Store(CondRefOf(s900), Local0)
	m1a4(Local0, 430)

	Store(CondRefOf(s901), Local0)
	m1a4(Local0, 431)

	Store(CondRefOf(b900), Local0)
	m1a4(Local0, 432)

	Store(CondRefOf(f900), Local0)
	m1a4(Local0, 433)

	Store(CondRefOf(bn90), Local0)
	m1a4(Local0, 434)

	Store(CondRefOf(if90), Local0)
	m1a4(Local0, 435)

	Store(CondRefOf(bf90), Local0)
	m1a4(Local0, 436)

	// Not Computational Data

	Store(CondRefOf(e900), Local0)
	m1a4(Local0, 437)

	Store(CondRefOf(mx90), Local0)
	m1a4(Local0, 438)

	Store(CondRefOf(d900), Local0)
	m1a4(Local0, 439)

	Store(CondRefOf(tz90), Local0)
	m1a4(Local0, 450)

	Store(CondRefOf(pr90), Local0)
	m1a4(Local0, 451)

	Store(CondRefOf(r900), Local0)
	m1a4(Local0, 452)

	Store(CondRefOf(pw90), Local0)
	m1a4(Local0, 453)

	// Elements of Package are Uninitialized

	Store(CondRefOf(p900), Local0)
	m1a4(Local0, 454)

	// Elements of Package are Computational Data

	Store(CondRefOf(p901), Local0)
	m1a4(Local0, 455)

	Store(CondRefOf(p902), Local0)
	m1a4(Local0, 456)

	Store(CondRefOf(p903), Local0)
	m1a4(Local0, 457)

	Store(CondRefOf(p904), Local0)
	m1a4(Local0, 458)

	Store(CondRefOf(p905), Local0)
	m1a4(Local0, 459)

	Store(CondRefOf(p906), Local0)
	m1a4(Local0, 460)

	Store(CondRefOf(p907), Local0)
	m1a4(Local0, 461)

	Store(CondRefOf(p908), Local0)
	m1a4(Local0, 462)

	Store(CondRefOf(p909), Local0)
	m1a4(Local0, 463)

	Store(CondRefOf(p90a), Local0)
	m1a4(Local0, 464)

	Store(CondRefOf(p90b), Local0)
	m1a4(Local0, 465)

	Store(CondRefOf(p90c), Local0)
	m1a4(Local0, 466)

	Store(CondRefOf(p90d), Local0)
	m1a4(Local0, 467)

	Store(CondRefOf(p90e), Local0)
	m1a4(Local0, 468)

	Store(CondRefOf(p90f), Local0)
	m1a4(Local0, 469)

	Store(CondRefOf(p910), Local0)
	m1a4(Local0, 470)

	Store(CondRefOf(p911), Local0)
	m1a4(Local0, 471)

	Store(CondRefOf(p912), Local0)
	m1a4(Local0, 472)

	Store(CondRefOf(p913), Local0)
	m1a4(Local0, 473)

	Store(CondRefOf(p914), Local0)
	m1a4(Local0, 474)

	Store(CondRefOf(p915), Local0)
	m1a4(Local0, 475)

	// Elements of Package are NOT Computational Data

	Store(CondRefOf(p916), Local0)
	m1a4(Local0, 476)

	Store(CondRefOf(p917), Local0)
	m1a4(Local0, 477)

	Store(CondRefOf(p918), Local0)
	m1a4(Local0, 478)

	Store(CondRefOf(p919), Local0)
	m1a4(Local0, 479)

	Store(CondRefOf(p91a), Local0)
	m1a4(Local0, 480)

	Store(CondRefOf(p91b), Local0)
	m1a4(Local0, 481)

	Store(CondRefOf(p91c), Local0)
	m1a4(Local0, 482)

	// Elements of Package are Methods

	Store(CondRefOf(p91d), Local0)
	m1a4(Local0, 483)

	Store(CondRefOf(p91e), Local0)
	m1a4(Local0, 484)

	Store(CondRefOf(p91f), Local0)
	m1a4(Local0, 485)

	Store(CondRefOf(p920), Local0)
	m1a4(Local0, 486)

	Store(CondRefOf(p921), Local0)
	m1a4(Local0, 487)

	Store(CondRefOf(p922), Local0)
	m1a4(Local0, 488)

	Store(CondRefOf(p923), Local0)
	m1a4(Local0, 489)

	Store(CondRefOf(p924), Local0)
	m1a4(Local0, 490)

	Store(CondRefOf(p925), Local0)
	m1a4(Local0, 491)

	Store(CondRefOf(p926), Local0)
	m1a4(Local0, 492)

	Store(CondRefOf(p927), Local0)
	m1a4(Local0, 493)

	Store(CondRefOf(p928), Local0)
	m1a4(Local0, 494)

	Store(CondRefOf(p929), Local0)
	m1a4(Local0, 495)

	Store(CondRefOf(p92a), Local0)
	m1a4(Local0, 496)

	Store(CondRefOf(p92b), Local0)
	m1a4(Local0, 497)

	Store(CondRefOf(p92c), Local0)
	m1a4(Local0, 498)

	Store(CondRefOf(p92d), Local0)
	m1a4(Local0, 499)

	Store(CondRefOf(p92e), Local0)
	m1a4(Local0, 500)

	Store(CondRefOf(p92f), Local0)
	m1a4(Local0, 501)

	Store(CondRefOf(p930), Local0)
	m1a4(Local0, 502)

	Store(CondRefOf(p931), Local0)
	m1a4(Local0, 503)

	Store(CondRefOf(p932), Local0)
	m1a4(Local0, 504)

	Store(CondRefOf(p933), Local0)
	m1a4(Local0, 505)

	Store(CondRefOf(p934), Local0)
	m1a4(Local0, 506)

	Store(CondRefOf(p935), Local0)
	m1a4(Local0, 507)

	Store(CondRefOf(p936), Local0)
	m1a4(Local0, 508)

	Store(CondRefOf(p937), Local0)
	m1a4(Local0, 509)

	Store(CondRefOf(p938), Local0)
	m1a4(Local0, 510)

	Store(CondRefOf(p939), Local0)
	m1a4(Local0, 511)

	Store(CondRefOf(p93a), Local0)
	m1a4(Local0, 512)

	Store(CondRefOf(p93b), Local0)
	m1a4(Local0, 513)

	Store(CondRefOf(p93c), Local0)
	m1a4(Local0, 514)

	Store(CondRefOf(p93d), Local0)
	m1a4(Local0, 515)

	Store(CondRefOf(p93e), Local0)
	m1a4(Local0, 516)

	Store(CondRefOf(p93f), Local0)
	m1a4(Local0, 517)

	Store(CondRefOf(p940), Local0)
	m1a4(Local0, 518)

	Store(CondRefOf(p941), Local0)
	m1a4(Local0, 519)

	Store(CondRefOf(p942), Local0)
	m1a4(Local0, 520)

	Store(CondRefOf(p943), Local0)
	m1a4(Local0, 521)

	Store(CondRefOf(p944), Local0)
	m1a4(Local0, 522)

	Store(CondRefOf(p945), Local0)
	m1a4(Local0, 523)

	Store(CondRefOf(p946), Local0)
	m1a4(Local0, 524)

	Store(CondRefOf(p947), Local0)
	m1a4(Local0, 525)

	Store(CondRefOf(p948), Local0)
	m1a4(Local0, 526)

	Store(CondRefOf(p949), Local0)
	m1a4(Local0, 527)

	Store(CondRefOf(p94a), Local0)
	m1a4(Local0, 528)

	Store(CondRefOf(p94b), Local0)
	m1a4(Local0, 529)

	Store(CondRefOf(p94c), Local0)
	m1a4(Local0, 530)

	Store(CondRefOf(p94d), Local0)
	m1a4(Local0, 531)

	Store(CondRefOf(p94e), Local0)
	m1a4(Local0, 532)

	Store(CondRefOf(p94f), Local0)
	m1a4(Local0, 533)

	Store(CondRefOf(p950), Local0)
	m1a4(Local0, 534)

	Store(CondRefOf(p951), Local0)
	m1a4(Local0, 535)

	Store(CondRefOf(p952), Local0)
	m1a4(Local0, 536)

	// Methods

	Store(CondRefOf(m900), Local0)
	m1a4(Local0, 537)

	Store(CondRefOf(m901), Local0)
	m1a4(Local0, 538)

	Store(CondRefOf(m902), Local0)
	m1a4(Local0, 539)

	Store(CondRefOf(m903), Local0)
	m1a4(Local0, 540)

	Store(CondRefOf(m904), Local0)
	m1a4(Local0, 541)

	Store(CondRefOf(m905), Local0)
	m1a4(Local0, 542)

	Store(CondRefOf(m906), Local0)
	m1a4(Local0, 543)

	Store(CondRefOf(m907), Local0)
	m1a4(Local0, 544)

	Store(CondRefOf(m908), Local0)
	m1a4(Local0, 545)

	Store(CondRefOf(m909), Local0)
	m1a4(Local0, 546)

	Store(CondRefOf(m90a), Local0)
	m1a4(Local0, 547)

	Store(CondRefOf(m90b), Local0)
	m1a4(Local0, 548)

	Store(CondRefOf(m90c), Local0)
	m1a4(Local0, 549)

	Store(CondRefOf(m90d), Local0)
	m1a4(Local0, 550)

	Store(CondRefOf(m90e), Local0)
	m1a4(Local0, 551)

	Store(CondRefOf(m90f), Local0)
	m1a4(Local0, 552)

	Store(CondRefOf(m910), Local0)
	m1a4(Local0, 553)

	Store(CondRefOf(m911), Local0)
	m1a4(Local0, 554)

	Store(CondRefOf(m912), Local0)
	m1a4(Local0, 555)

	Store(CondRefOf(m913), Local0)
	m1a4(Local0, 556)

	Store(CondRefOf(m914), Local0)
	m1a4(Local0, 557)

	Store(CondRefOf(m915), Local0)
	m1a4(Local0, 558)

	Store(CondRefOf(m916), Local0)
	m1a4(Local0, 559)

	Store(CondRefOf(m917), Local0)
	m1a4(Local0, 560)

	Store(CondRefOf(m918), Local0)
	m1a4(Local0, 561)

	Store(CondRefOf(m919), Local0)
	m1a4(Local0, 562)

	Store(CondRefOf(m91a), Local0)
	m1a4(Local0, 563)

	Store(CondRefOf(m91b), Local0)
	m1a4(Local0, 564)

	Store(CondRefOf(m91c), Local0)
	m1a4(Local0, 565)

	Store(CondRefOf(m91d), Local0)
	m1a4(Local0, 566)

	Store(CondRefOf(m91e), Local0)
	m1a4(Local0, 567)

	Store(CondRefOf(m91f), Local0)
	m1a4(Local0, 568)

	Store(CondRefOf(m920), Local0)
	m1a4(Local0, 569)

	Store(CondRefOf(m921), Local0)
	m1a4(Local0, 570)

	Store(CondRefOf(m922), Local0)
	m1a4(Local0, 571)

	Store(CondRefOf(m923), Local0)
	m1a4(Local0, 572)

	Store(CondRefOf(m924), Local0)
	m1a4(Local0, 573)

	Store(CondRefOf(m925), Local0)
	m1a4(Local0, 574)

	Store(CondRefOf(m926), Local0)
	m1a4(Local0, 575)

	Store(CondRefOf(m927), Local0)
	m1a4(Local0, 576)

	Store(CondRefOf(m928), Local0)
	m1a4(Local0, 577)

	Store(CondRefOf(m929), Local0)
	m1a4(Local0, 578)

	Store(CondRefOf(m92a), Local0)
	m1a4(Local0, 579)

	Store(CondRefOf(m92b), Local0)
	m1a4(Local0, 580)

	Store(CondRefOf(m92c), Local0)
	m1a4(Local0, 581)

	Store(CondRefOf(m92d), Local0)
	m1a4(Local0, 582)

	Store(CondRefOf(m92e), Local0)
	m1a4(Local0, 583)

	Store(CondRefOf(m92f), Local0)
	m1a4(Local0, 584)

	Store(CondRefOf(m930), Local0)
	m1a4(Local0, 585)

	Store(CondRefOf(m931), Local0)
	m1a4(Local0, 586)

	Store(CondRefOf(m932), Local0)
	m1a4(Local0, 587)

	Store(CondRefOf(m933), Local0)
	m1a4(Local0, 588)

	Store(CondRefOf(m934), Local0)
	m1a4(Local0, 589)

	Store(CondRefOf(m935), Local0)
	m1a4(Local0, 590)

	m000()
	m1a6()
}

// arg0 - writing mode
Method(m16c, 1, Serialized)
{
	if (y100) {
		ts00("m16c")
	} else {
		Store("m16c", Debug)
	}

	// Not Computational Data

	Event(e900)
	Event(e9Z0)
	Mutex(mx90, 0)
	Mutex(mx91, 0)
	Device(d900) { Name(i900, 0xabcd4017) }
	Device(d9Z0) { Name(i900, 0xabcd4017) }
	ThermalZone(tz90) {}
	ThermalZone(tz91) {}
	Processor(pr90, 0, 0xFFFFFFFF, 0) {}
	Processor(pr91, 0, 0xFFFFFFFF, 0) {}
	OperationRegion(r900, SystemMemory, 0x100, 0x100)
	OperationRegion(r9Z0, SystemMemory, 0x100, 0x100)
	PowerResource(pw90, 1, 0) {Method(mmmm){return (0)}}
	PowerResource(pw91, 1, 0) {Method(mmmm){return (0)}}

	// Computational Data

	Name(i900, 0xfe7cb391d65a4000)
	Name(i9Z0, 0xfe7cb391d65a4000)
	Name(i901, 0xc1794001)
	Name(i9Z1, 0xc1794001)
	Name(i902, 0)
	Name(i903, 0xffffffffffffffff)
	Name(i904, 0xffffffff)
	Name(s900, "12344002")
	Name(s9Z0, "12344002")
	Name(s901, "qwrtyu4003")
	Name(s9Z1, "qwrtyu4003")
	Name(b900, Buffer() {0xe0,0xe1,0xe2,0xe3,0xe4})
	Name(b9Z0, Buffer() {0xe0,0xe1,0xe2,0xe3,0xe4})

	CreateField(b9Z0, 0, 8, bf90)
	Field(r9Z0, ByteAcc, NoLock, Preserve) {f900,8,f901,8,f902,8,f903,8}
	BankField(r9Z0, f901, 0, ByteAcc, NoLock, Preserve) {bn90,4}
	IndexField(f902, f903, ByteAcc, NoLock, Preserve) {if90,8,if91,8}

	// Elements of Package are Uninitialized

	Name(p900, Package(1) {})

	// Elements of Package are Computational Data

	Name(p901, Package() {0xabcd4004, 0x1122334455664005})
	Name(p902, Package() {"12344006", "q1w2e3r4t5y6u7i84007"})
	Name(p903, Package() {"qwrtyuiop4008", "1234567890abdef0254009"})
	Name(p904, Package() {Buffer() {0xe5,0xe6,0xe7}, Buffer() {0xe8,0xe9}})
	Name(p905, Package() {Package() {0xabc400a, "0xabc400b", "abc400c"}})
	Name(p906, Package() {Package() {"abc400d"}})
	Name(p907, Package() {Package() {"aqwevbgnm400e"}})
	Name(p908, Package() {Package() {Buffer() {0xea,0xeb,0xec,0xed,0xee}}})
	Name(p909, Package() {Package() {Package() {0xabc400f}}})
	Name(p90a, Package() {Package() {Package() {"12344010"}}})
	Name(p90b, Package() {Package() {Package() {"zxswefas4011"}}})
	Name(p90c, Package() {Package() {Package() {Buffer() {0xef,0x30,0x31}}}})

	Name(p90d, Package() {i900})
	Name(p90e, Package() {i901})
	Name(p90f, Package() {s900})
	Name(p910, Package() {s901})
	Name(p911, Package() {b9Z0})
	Name(p912, Package() {f900})
	Name(p913, Package() {bn90})
	Name(p914, Package() {if90})
	Name(p915, Package() {bf90})

	// Elements of Package are NOT Computational Data

	Name(p916, Package() {d900})
	Name(p917, Package() {e900})
	Name(p918, Package() {mx90})
	Name(p919, Package() {r9Z0})
	Name(p91a, Package() {pw90})
	Name(p91b, Package() {pr90})
	Name(p91c, Package() {tz90})

	// Methods

	Method(m900) {}
	Method(m901) { return (0xabc4012) }
	Method(m902) { return ("zxvgswquiy4013") }
	Method(m903) { return (Buffer() {0x32}) }
	Method(m904) { return (Package() {0xabc4014}) }
	Method(m905) { return (Package() {"lkjhgtre4015"}) }
	Method(m906) { return (Package() {Buffer() {0x33}}) }
	Method(m907) { return (Package() {Package() {0xabc4016}}) }

	Method(m908) { return (i900) }
	Method(m909) { return (i901) }
	Method(m90a) { return (s900) }
	Method(m90b) { return (s901) }
	Method(m90c) { return (b9Z0) }
	Method(m90d) { return (f900) }
	Method(m90e) { return (bn90) }
	Method(m90f) { return (if90) }
	Method(m910) { return (bf90) }

	Method(m911) { return (d900) }
	Method(m912) { return (e900) }
	Method(m913) { return (m901) }
	Method(m914) { return (mx90) }
	Method(m915) { return (r9Z0) }
	Method(m916) { return (pw90) }
	Method(m917) { return (pr90) }
	Method(m918) { return (tz90) }
	Method(m919) { return (p900) }
	Method(m91a) { return (p901) }
	Method(m91b) { return (p902) }
	Method(m91c) { return (p903) }
	Method(m91d) { return (p904) }
	Method(m91e) { return (p905) }
	Method(m91f) { return (p906) }
	Method(m920) { return (p907) }
	Method(m921) { return (p908) }
	Method(m922) { return (p909) }
	Method(m923) { return (p90a) }
	Method(m924) { return (p90b) }
	Method(m925) { return (p90c) }
	Method(m926) { return (p90d) }
	Method(m927) { return (p90e) }
	Method(m928) { return (p90f) }
	Method(m929) { return (p910) }
	Method(m92a) { return (p911) }
	Method(m92b) { return (p912) }
	Method(m92c) { return (p913) }
	Method(m92d) { return (p914) }
	Method(m92e) { return (p915) }
	Method(m92f) { return (p916) }
	Method(m930) { return (p917) }
	Method(m931) { return (p918) }
	Method(m932) { return (p919) }
	Method(m933) { return (p91a) }
	Method(m934) { return (p91b) }
	Method(m935) { return (p91c) }

	// Elements of Package are Methods

	Name(p91d, Package() {m900})
	Name(p91e, Package() {m901})
	Name(p91f, Package() {m902})
	Name(p920, Package() {m903})
	Name(p921, Package() {m904})
	Name(p922, Package() {m905})
	Name(p923, Package() {m906})
	Name(p924, Package() {m907})
	Name(p925, Package() {m908})
	Name(p926, Package() {m909})
	Name(p927, Package() {m90a})
	Name(p928, Package() {m90b})
	Name(p929, Package() {m90c})
	Name(p92a, Package() {m90d})
	Name(p92b, Package() {m90e})
	Name(p92c, Package() {m90f})
	Name(p92d, Package() {m910})
	Name(p92e, Package() {m911})
	Name(p92f, Package() {m912})
	Name(p930, Package() {m913})
	Name(p931, Package() {m914})
	Name(p932, Package() {m915})
	Name(p933, Package() {m916})
	Name(p934, Package() {m917})
	if (y103) {
		Name(p935, Package() {m918})
	}
	Name(p936, Package() {m919})
	Name(p937, Package() {m91a})
	Name(p938, Package() {m91b})
	Name(p939, Package() {m91c})
	Name(p93a, Package() {m91d})
	Name(p93b, Package() {m91e})
	Name(p93c, Package() {m91f})
	Name(p93d, Package() {m920})
	Name(p93e, Package() {m921})
	Name(p93f, Package() {m922})
	Name(p940, Package() {m923})
	Name(p941, Package() {m924})
	Name(p942, Package() {m925})
	Name(p943, Package() {m926})
	Name(p944, Package() {m927})
	Name(p945, Package() {m928})
	Name(p946, Package() {m929})
	Name(p947, Package() {m92a})
	Name(p948, Package() {m92b})
	Name(p949, Package() {m92c})
	Name(p94a, Package() {m92d})
	Name(p94b, Package() {m92e})
	Name(p94c, Package() {m92f})
	Name(p94d, Package() {m930})
	Name(p94e, Package() {m931})
	Name(p94f, Package() {m932})
	Name(p950, Package() {m933})
	Name(p951, Package() {m934})
	Name(p952, Package() {m935})

	Name(p953, Package() {0xabcd4018, 0xabcd4019})
	Name(p954, Package() {0xabcd4018, 0xabcd4019})


	// Check that all the data (local) are not corrupted
	Method(m000)
	{
	// Computational Data

	// Integer

	Store(ObjectType(i900), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x100, 0, 0, Local0, c009)
	}
	if (LNotEqual(i900, 0xfe7cb391d65a4000)) {
		err(c080, z077, 0x101, 0, 0, i900, 0xfe7cb391d65a4000)
	}

	Store(ObjectType(i901), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x102, 0, 0, Local0, c009)
	}
	if (LNotEqual(i901, 0xc1794001)) {
		err(c080, z077, 0x103, 0, 0, i901, 0xc1794001)
	}

	Store(ObjectType(i902), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x104, 0, 0, Local0, c009)
	}
	if (LNotEqual(i902, 0)) {
		err(c080, z077, 0x105, 0, 0, i902, 0)
	}

	Store(ObjectType(i903), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x106, 0, 0, Local0, c009)
	}
	if (LNotEqual(i903, 0xffffffffffffffff)) {
		err(c080, z077, 0x107, 0, 0, i903, 0xffffffffffffffff)
	}

	Store(ObjectType(i904), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x108, 0, 0, Local0, c009)
	}
	if (LNotEqual(i904, 0xffffffff)) {
		err(c080, z077, 0x109, 0, 0, i904, 0xffffffff)
	}

	// String

	Store(ObjectType(s900), Local0)
	if (LNotEqual(Local0, c00a)) {
		err(c080, z077, 0x10a, 0, 0, Local0, c00a)
	}
	if (LNotEqual(s900, "12344002")) {
		err(c080, z077, 0x10b, 0, 0, s900, "12344002")
	}

	Store(ObjectType(s901), Local0)
	if (LNotEqual(Local0, c00a)) {
		err(c080, z077, 0x10c, 0, 0, Local0, c00a)
	}
	if (LNotEqual(s901, "qwrtyu4003")) {
		err(c080, z077, 0x10d, 0, 0, s901, "qwrtyu4003")
	}

	// Buffer

	Store(ObjectType(b900), Local0)
	if (LNotEqual(Local0, c00b)) {
		err(c080, z077, 0x10e, 0, 0, Local0, c00b)
	}
	if (LNotEqual(b900, Buffer() {0xe0,0xe1,0xe2,0xe3,0xe4})) {
		err(c080, z077, 0x10f, 0, 0, b900, Buffer() {0xe0,0xe1,0xe2,0xe3,0xe4})
	}

	// Buffer Field

	Store(ObjectType(bf90), Local0)
	if (LNotEqual(Local0, c016)) {
		err(c080, z077, 0x110, 0, 0, Local0, c016)
	}
	if (LNotEqual(bf90, 0xe0)) {
		err(c080, z077, 0x111, 0, 0, bf90, 0xe0)
	}

	// One level Package

	Store(Index(p900, 0), Local0)
	Store(ObjectType(Local0), Local1)
	if (LNotEqual(Local1, c008)) {
		err(c080, z077, 0x112, 0, 0, Local1, c008)
	}

	Store(Index(p901, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x113, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd4004)) {
		err(c080, z077, 0x114, 0, 0, Local1, 0xabcd4004)
	}

	Store(Index(p901, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x115, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0x1122334455664005)) {
		err(c080, z077, 0x116, 0, 0, Local1, 0x1122334455664005)
	}

	Store(Index(p902, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x117, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "12344006")) {
		err(c080, z077, 0x118, 0, 0, Local1, "12344006")
	}

	Store(Index(p902, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x119, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "q1w2e3r4t5y6u7i84007")) {
		err(c080, z077, 0x11a, 0, 0, Local1, "q1w2e3r4t5y6u7i84007")
	}

	Store(Index(p903, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x11b, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "qwrtyuiop4008")) {
		err(c080, z077, 0x11c, 0, 0, Local1, "qwrtyuiop4008")
	}

	Store(Index(p903, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x11d, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "1234567890abdef0254009")) {
		err(c080, z077, 0x11e, 0, 0, Local1, "1234567890abdef0254009")
	}

	Store(Index(p904, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00b)) {
		err(c080, z077, 0x11f, 0, 0, Local2, c00b)
	}
	if (LNotEqual(Local1, Buffer() {0xe5,0xe6,0xe7})) {
		err(c080, z077, 0x120, 0, 0, Local1, Buffer() {0xe5,0xe6,0xe7})
	}

	Store(Index(p904, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00b)) {
		err(c080, z077, 0x121, 0, 0, Local2, c00b)
	}
	if (LNotEqual(Local1, Buffer() {0xe8,0xe9})) {
		err(c080, z077, 0x122, 0, 0, Local1, Buffer() {0xe8,0xe9})
	}

	// Two level Package

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c009)) {
		err(c080, z077, 0x123, 0, 0, Local4, c009)
	}
	if (LNotEqual(Local3, 0xabc400a)) {
		err(c080, z077, 0x124, 0, 0, Local3, 0xabc400a)
	}

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 1), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x125, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "0xabc400b")) {
		err(c080, z077, 0x126, 0, 0, Local3, "0xabc400b")
	}

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 2), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x127, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "abc400c")) {
		err(c080, z077, 0x128, 0, 0, Local3, "abc400c")
	}

	Store(Index(p906, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x129, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "abc400d")) {
		err(c080, z077, 0x12a, 0, 0, Local3, "abc400d")
	}

	Store(Index(p907, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x12b, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "aqwevbgnm400e")) {
		err(c080, z077, 0x12c, 0, 0, Local3, "aqwevbgnm400e")
	}

	Store(Index(p908, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00b)) {
		err(c080, z077, 0x12d, 0, 0, Local4, c00b)
	}
	if (LNotEqual(Local3, Buffer() {0xea,0xeb,0xec,0xed,0xee})) {
		err(c080, z077, 0x12e, 0, 0, Local3, Buffer() {0xea,0xeb,0xec,0xed,0xee})
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
		err(c080, z077, 0x12f, 0, 0, Local6, c009)
	}
	if (LNotEqual(Local5, 0xabc400f)) {
		err(c080, z077, 0x130, 0, 0, Local5, 0xabc400f)
	}

	Store(Index(p90a, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00a)) {
		err(c080, z077, 0x131, 0, 0, Local6, c00a)
	}
	if (LNotEqual(Local5, "12344010")) {
		err(c080, z077, 0x132, 0, 0, Local5, "12344010")
	}

	Store(Index(p90b, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00a)) {
		err(c080, z077, 0x133, 0, 0, Local6, c00a)
	}
	if (LNotEqual(Local5, "zxswefas4011")) {
		err(c080, z077, 0x134, 0, 0, Local5, "zxswefas4011")
	}

	Store(Index(p90c, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00b)) {
		err(c080, z077, 0x135, 0, 0, Local6, c00b)
	}
	if (LNotEqual(Local5, Buffer() {0xef,0x30,0x31})) {
		err(c080, z077, 0x136, 0, 0, Local5, Buffer() {0xef,0x30,0x31})
	}

	Store(Index(p953, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x137, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd4018)) {
		err(c080, z077, 0x138, 0, 0, Local1, 0xabcd4018)
	}

	Store(Index(p953, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x139, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd4019)) {
		err(c080, z077, 0x13a, 0, 0, Local1, 0xabcd4019)
	}

	// Not Computational Data

	m1aa(c080, e900, c00f, 0, 0x13b)
	m1aa(c080, mx90, c011, 0, 0x13c)
	m1aa(c080, d900, c00e, 0, 0x13d)
	if (y508) {
		m1aa(c080, tz90, c015, 0, 0x13e)
	}
	m1aa(c080, pr90, c014, 0, 0x13f)
	m1aa(c080, r900, c012, 0, 0x140)
	m1aa(c080, pw90, c013, 0, 0x141)

/*
 *	// Field Unit (Field)
 *
 *	if (LNotEqual(f900, 0xd7)) {
 *		err(c080, z077, 0x137, 0, 0, f900, 0xd7)
 *	}
 *
 *	// Field Unit (IndexField)
 *
 *	if (LNotEqual(if90, 0xd7)) {
 *		err(c080, z077, 0x138, 0, 0, if90, 0xd7)
 *	}
 */
	} /* m000 */

	// Check and restore the global data after writing into them
	Method(m001)
	{

	// Computational Data

	m1aa(c080, i900, c009, c08a, 0x144)
	CopyObject(i9Z0, i900)

	m1aa(c080, i901, c009, c08a, 0x145)
	CopyObject(i9Z1, i901)

	m1aa(c080, s900, c009, c08a, 0x146)
	CopyObject(s9Z0, s900)

	m1aa(c080, s901, c009, c08a, 0x147)
	CopyObject(s9Z1, s901)

	m1aa(c080, b900, c009, c08a, 0x148)
	CopyObject(b9Z0, b900)

	// Package

	m1aa(c080, p953, c009, c08a, 0x149)
	CopyObject(p954, p953)

	// Not Computational Data

	m1aa(c080, e900, c009, c08a, 0x14a)
	CopyObject(RefOf (e9Z0), e900)

	m1aa(c080, mx90, c009, c08a, 0x14b)
	CopyObject(RefOf (mx91), mx90)

	m1aa(c080, d900, c009, c08a, 0x14c)
	CopyObject(RefOf (d9Z0), d900)

	if (y508) {
		m1aa(c080, tz90, c009, c08a, 0x14d)
		CopyObject(RefOf (tz91), tz90)
	}

	m1aa(c080, pr90, c009, c08a, 0x14e)
	CopyObject(RefOf (pr91), pr90)

	if (y510) {
		m1aa(c080, r900, c009, c08a, 0x14f)
		CopyObject(RefOf (r9Z0), r900)
	}

	m1aa(c080, pw90, c009, c08a, 0x150)
	CopyObject(RefOf (pw91), pw90)

	m000()
	} /* m001 */


	// T2:CR1-CR14

	// Computational Data

	Store(CondRefOf(i900, Local0), Local1)
	if (m1a4(Local1, 591)) {
		m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a4000, 592)
	}

	Store(CondRefOf(i901, Local0), Local1)
	if (m1a4(Local1, 593)) {
		m1a2(Local0, c009, 0, 0, c009, 0xc1794001, 594)
	}

	Store(CondRefOf(s900, Local0), Local1)
	if (m1a4(Local1, 595)) {
		m1a2(Local0, c00a, 0, 0, c00a, "12344002", 596)
	}

	Store(CondRefOf(s901, Local0), Local1)
	if (m1a4(Local1, 597)) {
		m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu4003", 598)
	}

	Store(CondRefOf(b900, Local0), Local1)
	if (m1a4(Local1, 599)) {
		m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xe0,0xe1,0xe2,0xe3,0xe4}, 600)
	}

	// Not Computational Data

	Store(CondRefOf(e900, Local0), Local1)
	m1a0(Local0, c00f, Local1, 609)

	Store(CondRefOf(mx90, Local0), Local1)
	m1a0(Local0, c011, Local1, 610)

	Store(CondRefOf(d900, Local0), Local1)
	m1a0(Local0, c00e, Local1, 611)

	if (arg0) {
		if (y508) {
			Store(CondRefOf(tz90, Local0), Local1)
			m1a0(Local0, c015, Local1, 612)
		}
	} else {
		Store(CondRefOf(tz90, Local0), Local1)
		m1a0(Local0, c015, Local1, 1004)
	}

	Store(CondRefOf(pr90, Local0), Local1)
	m1a0(Local0, c014, Local1, 613)

	if (arg0) {
		if (y510) {
			Store(CondRefOf(r900, Local0), Local1)
			m1a0(Local0, c012, Local1, 614)
		}
	} else {
		Store(CondRefOf(r900, Local0), Local1)
		m1a0(Local0, c012, Local1, 614)
	}

	Store(CondRefOf(pw90, Local0), Local1)
	m1a0(Local0, c013, Local1, 615)

	// Package

	Store(CondRefOf(p953, Local0), Local1)
	if (m1a4(Local1, 1005)) {
		m1a2(Local0, c00c, 1, 0, c009, 0xabcd4018, 1006)
	}

	if (arg0) {
		m001()
		return
	}

	// Computational Data (Field Unit and Buffer Field)

	Store(CondRefOf(f900, Local0), Local1)
	if (m1a4(Local1, 601)) {
		m1a2(Local0, c00d, 0, 0, c009, 0, 602)
	}

	Store(CondRefOf(bn90, Local0), Local1)
	if (m1a4(Local1, 603)) {
		m1a2(Local0, c00d, 0, 0, c009, 0, 604)
	}

	Store(CondRefOf(if90, Local0), Local1)
	if (m1a4(Local1, 605)) {
		m1a2(Local0, c00d, 0, 0, c009, 0, 606)
	}

	Store(CondRefOf(bf90, Local0), Local1)
	if (m1a4(Local1, 607)) {
		m1a2(Local0, c016, 0, 0, c009, 0xe0, 608)
	}

	// Elements of Package are Uninitialized

	Store(CondRefOf(p900, Local0), Local1)
	m1a0(Local0, c00c, Local1, 616)

	// Elements of Package are Computational Data

	Store(CondRefOf(p901, Local0), Local1)
	if (m1a4(Local1, 617)) {
		m1a2(Local0, c00c, 1, 0, c009, 0xabcd4004, 618)
		m1a2(Local0, c00c, 1, 1, c009, 0x1122334455664005, 619)
	}

	Store(CondRefOf(p902, Local0), Local1)
	if (m1a4(Local1, 620)) {
		m1a2(Local0, c00c, 1, 0, c00a, "12344006", 621)
		m1a2(Local0, c00c, 1, 1, c00a, "q1w2e3r4t5y6u7i84007", 622)
	}

	Store(CondRefOf(p903, Local0), Local1)
	if (m1a4(Local1, 623)) {
		m1a2(Local0, c00c, 1, 0, c00a, "qwrtyuiop4008", 624)
		m1a2(Local0, c00c, 1, 1, c00a, "1234567890abdef0254009", 625)
	}

	Store(CondRefOf(p904, Local0), Local1)
	if (m1a4(Local1, 626)) {
		m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xe5,0xe6,0xe7}, 627)
	}

	Store(CondRefOf(p905, Local0), Local1)
	if (m1a4(Local1, 628)) {
		m1a2(Local0, c00c, 2, 0, c009, 0xabc400a, 629)
		m1a2(Local0, c00c, 2, 1, c00a, "0xabc400b", 630)
	}

	Store(CondRefOf(p906, Local0), Local1)
	if (m1a4(Local1, 631)) {
		m1a2(Local0, c00c, 2, 0, c00a, "abc400d", 632)
	}

	Store(CondRefOf(p907, Local0), Local1)
	if (m1a4(Local1, 633)) {
		m1a2(Local0, c00c, 2, 0, c00a, "aqwevbgnm400e", 634)
	}

	Store(CondRefOf(p908, Local0), Local1)
	if (m1a4(Local1, 635)) {
		m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xea,0xeb,0xec,0xed,0xee}, 636)
	}

	Store(CondRefOf(p909, Local0), Local1)
	if (m1a4(Local1, 637)) {
		m1a2(Local0, c00c, 3, 0, c009, 0xabc400f, 638)
	}

	Store(CondRefOf(p90a, Local0), Local1)
	if (m1a4(Local1, 639)) {
		m1a2(Local0, c00c, 3, 0, c00a, "12344010", 640)
	}

	Store(CondRefOf(p90b, Local0), Local1)
	if (m1a4(Local1, 641)) {
		m1a2(Local0, c00c, 3, 0, c00a, "zxswefas4011", 642)
	}

	Store(CondRefOf(p90c, Local0), Local1)
	if (m1a4(Local1, 643)) {
		m1a2(Local0, c00c, 3, 0, c00b, Buffer() {0xef,0x30,0x31}, 644)
	}

	Store(CondRefOf(p90d, Local0), Local1)
	if (m1a4(Local1, 645)) {
		m1a2(Local0, c00c, 1, 0, c009, 0xfe7cb391d65a4000, 646)
	}

	Store(CondRefOf(p90e, Local0), Local1)
	if (m1a4(Local1, 647)) {
		m1a2(Local0, c00c, 1, 0, c009, 0xc1794001, 648)
	}

	Store(CondRefOf(p90f, Local0), Local1)
	if (m1a4(Local1, 649)) {
		m1a2(Local0, c00c, 1, 0, c00a, "12344002", 650)
	}

	Store(CondRefOf(p910, Local0), Local1)
	if (m1a4(Local1, 651)) {
		m1a2(Local0, c00c, 1, 0, c00a, "qwrtyu4003", 652)
	}

	Store(CondRefOf(p911, Local0), Local1)
	if (m1a4(Local1, 653)) {
		m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xe0,0xe1,0xe2,0xe3,0xe4}, 654)
	}

	if (y118) {
		Store(CondRefOf(p912, Local0), Local1)
		if (m1a4(Local1, 655)) {
			m1a2(Local0, c00c, 1, 0, c00d, 0, 656)
		}

		Store(CondRefOf(p913, Local0), Local1)
		if (m1a4(Local1, 657)) {
			m1a2(Local0, c00c, 1, 0, c00d, 0, 658)
		}

		Store(CondRefOf(p914, Local0), Local1)
		if (m1a4(Local1, 659)) {
			m1a2(Local0, c00c, 1, 0, c00d, 0, 660)
		}

		Store(CondRefOf(p915, Local0), Local1)
		if (m1a4(Local1, 661)) {
			m1a2(Local0, c00c, 1, 0, c016, 0xe0, 662)
		}
	}

	// Elements of Package are NOT Computational Data

	Store(CondRefOf(p916, Local0), Local1)
	m1a0(Local0, c00c, Local1, 663)

	Store(CondRefOf(p917, Local0), Local1)
	m1a0(Local0, c00c, Local1, 664)

	Store(CondRefOf(p918, Local0), Local1)
	m1a0(Local0, c00c, Local1, 6655)

	Store(CondRefOf(p919, Local0), Local1)
	m1a0(Local0, c00c, Local1, 666)

	Store(CondRefOf(p91a, Local0), Local1)
	m1a0(Local0, c00c, Local1, 667)

	Store(CondRefOf(p91b, Local0), Local1)
	m1a0(Local0, c00c, Local1, 668)

	Store(CondRefOf(p91c, Local0), Local1)
	m1a0(Local0, c00c, Local1, 669)

	// Elements of Package are Methods

	Store(CondRefOf(p91d, Local0), Local1)
	m1a0(Local0, c00c, Local1, 670)

	Store(CondRefOf(p91e, Local0), Local1)
	m1a0(Local0, c00c, Local1, 671)

	Store(CondRefOf(p91f, Local0), Local1)
	m1a0(Local0, c00c, Local1, 672)

	Store(CondRefOf(p920, Local0), Local1)
	m1a0(Local0, c00c, Local1, 673)

	Store(CondRefOf(p921, Local0), Local1)
	m1a0(Local0, c00c, Local1, 674)

	Store(CondRefOf(p922, Local0), Local1)
	m1a0(Local0, c00c, Local1, 675)

	Store(CondRefOf(p923, Local0), Local1)
	m1a0(Local0, c00c, Local1, 676)

	Store(CondRefOf(p924, Local0), Local1)
	m1a0(Local0, c00c, Local1, 677)

	Store(CondRefOf(p925, Local0), Local1)
	m1a0(Local0, c00c, Local1, 678)

	Store(CondRefOf(p926, Local0), Local1)
	m1a0(Local0, c00c, Local1, 679)

	Store(CondRefOf(p927, Local0), Local1)
	m1a0(Local0, c00c, Local1, 680)

	Store(CondRefOf(p928, Local0), Local1)
	m1a0(Local0, c00c, Local1, 681)

	Store(CondRefOf(p929, Local0), Local1)
	m1a0(Local0, c00c, Local1, 682)

	Store(CondRefOf(p92a, Local0), Local1)
	m1a0(Local0, c00c, Local1, 683)

	Store(CondRefOf(p92b, Local0), Local1)
	m1a0(Local0, c00c, Local1, 684)

	Store(CondRefOf(p92c, Local0), Local1)
	m1a0(Local0, c00c, Local1, 685)

	Store(CondRefOf(p92d, Local0), Local1)
	m1a0(Local0, c00c, Local1, 686)

	Store(CondRefOf(p92e, Local0), Local1)
	m1a0(Local0, c00c, Local1, 687)

	Store(CondRefOf(p92f, Local0), Local1)
	m1a0(Local0, c00c, Local1, 688)

	Store(CondRefOf(p930, Local0), Local1)
	m1a0(Local0, c00c, Local1, 689)

	Store(CondRefOf(p931, Local0), Local1)
	m1a0(Local0, c00c, Local1, 690)

	Store(CondRefOf(p932, Local0), Local1)
	m1a0(Local0, c00c, Local1, 691)

	Store(CondRefOf(p933, Local0), Local1)
	m1a0(Local0, c00c, Local1, 692)

	Store(CondRefOf(p934, Local0), Local1)
	m1a0(Local0, c00c, Local1, 693)

	Store(CondRefOf(p935, Local0), Local1)
	m1a0(Local0, c00c, Local1, 694)

	Store(CondRefOf(p936, Local0), Local1)
	m1a0(Local0, c00c, Local1, 695)

	Store(CondRefOf(p937, Local0), Local1)
	m1a0(Local0, c00c, Local1, 696)

	Store(CondRefOf(p938, Local0), Local1)
	m1a0(Local0, c00c, Local1, 697)

	Store(CondRefOf(p939, Local0), Local1)
	m1a0(Local0, c00c, Local1, 698)

	Store(CondRefOf(p93a, Local0), Local1)
	m1a0(Local0, c00c, Local1, 699)

	Store(CondRefOf(p93b, Local0), Local1)
	m1a0(Local0, c00c, Local1, 700)

	Store(CondRefOf(p93c, Local0), Local1)
	m1a0(Local0, c00c, Local1, 701)

	Store(CondRefOf(p93d, Local0), Local1)
	m1a0(Local0, c00c, Local1, 702)

	Store(CondRefOf(p93e, Local0), Local1)
	m1a0(Local0, c00c, Local1, 703)

	Store(CondRefOf(p93f, Local0), Local1)
	m1a0(Local0, c00c, Local1, 704)

	Store(CondRefOf(p940, Local0), Local1)
	m1a0(Local0, c00c, Local1, 705)

	Store(CondRefOf(p941, Local0), Local1)
	m1a0(Local0, c00c, Local1, 706)

	Store(CondRefOf(p942, Local0), Local1)
	m1a0(Local0, c00c, Local1, 707)

	Store(CondRefOf(p943, Local0), Local1)
	m1a0(Local0, c00c, Local1, 708)

	Store(CondRefOf(p944, Local0), Local1)
	m1a0(Local0, c00c, Local1, 709)

	Store(CondRefOf(p945, Local0), Local1)
	m1a0(Local0, c00c, Local1, 710)

	Store(CondRefOf(p946, Local0), Local1)
	m1a0(Local0, c00c, Local1, 711)

	Store(CondRefOf(p947, Local0), Local1)
	m1a0(Local0, c00c, Local1, 712)

	Store(CondRefOf(p948, Local0), Local1)
	m1a0(Local0, c00c, Local1, 713)

	Store(CondRefOf(p949, Local0), Local1)
	m1a0(Local0, c00c, Local1, 714)

	Store(CondRefOf(p94a, Local0), Local1)
	m1a0(Local0, c00c, Local1, 715)

	Store(CondRefOf(p94b, Local0), Local1)
	m1a0(Local0, c00c, Local1, 716)

	Store(CondRefOf(p94c, Local0), Local1)
	m1a0(Local0, c00c, Local1, 717)

	Store(CondRefOf(p94d, Local0), Local1)
	m1a0(Local0, c00c, Local1, 718)

	Store(CondRefOf(p94e, Local0), Local1)
	m1a0(Local0, c00c, Local1, 719)

	Store(CondRefOf(p94f, Local0), Local1)
	m1a0(Local0, c00c, Local1, 720)

	Store(CondRefOf(p950, Local0), Local1)
	m1a0(Local0, c00c, Local1, 721)

	Store(CondRefOf(p951, Local0), Local1)
	m1a0(Local0, c00c, Local1, 722)

	Store(CondRefOf(p952, Local0), Local1)
	m1a0(Local0, c00c, Local1, 723)

	// Methods

	Store(CondRefOf(m900, Local0), Local1)
	m1a0(Local0, c010, Local1, 724)

	Store(CondRefOf(m901, Local0), Local1)
	m1a0(Local0, c010, Local1, 725)

	Store(CondRefOf(m902, Local0), Local1)
	m1a0(Local0, c010, Local1, 726)

	Store(CondRefOf(m903, Local0), Local1)
	m1a0(Local0, c010, Local1, 727)

	Store(CondRefOf(m904, Local0), Local1)
	m1a0(Local0, c010, Local1, 728)

	Store(CondRefOf(m905, Local0), Local1)
	m1a0(Local0, c010, Local1, 729)

	Store(CondRefOf(m906, Local0), Local1)
	m1a0(Local0, c010, Local1, 730)

	Store(CondRefOf(m907, Local0), Local1)
	m1a0(Local0, c010, Local1, 731)

	Store(CondRefOf(m908, Local0), Local1)
	m1a0(Local0, c010, Local1, 732)

	Store(CondRefOf(m909, Local0), Local1)
	m1a0(Local0, c010, Local1, 733)

	Store(CondRefOf(m90a, Local0), Local1)
	m1a0(Local0, c010, Local1, 734)

	Store(CondRefOf(m90b, Local0), Local1)
	m1a0(Local0, c010, Local1, 735)

	Store(CondRefOf(m90c, Local0), Local1)
	m1a0(Local0, c010, Local1, 736)

	Store(CondRefOf(m90d, Local0), Local1)
	m1a0(Local0, c010, Local1, 737)

	Store(CondRefOf(m90e, Local0), Local1)
	m1a0(Local0, c010, Local1, 738)

	Store(CondRefOf(m90f, Local0), Local1)
	m1a0(Local0, c010, Local1, 739)

	Store(CondRefOf(m910, Local0), Local1)
	m1a0(Local0, c010, Local1, 740)

	Store(CondRefOf(m911, Local0), Local1)
	m1a0(Local0, c010, Local1, 741)

	Store(CondRefOf(m912, Local0), Local1)
	m1a0(Local0, c010, Local1, 742)

	Store(CondRefOf(m913, Local0), Local1)
	m1a0(Local0, c010, Local1, 743)

	Store(CondRefOf(m914, Local0), Local1)
	m1a0(Local0, c010, Local1, 744)

	Store(CondRefOf(m915, Local0), Local1)
	m1a0(Local0, c010, Local1, 745)

	Store(CondRefOf(m916, Local0), Local1)
	m1a0(Local0, c010, Local1, 746)

	Store(CondRefOf(m917, Local0), Local1)
	m1a0(Local0, c010, Local1, 747)

	Store(CondRefOf(m918, Local0), Local1)
	m1a0(Local0, c010, Local1, 748)

	Store(CondRefOf(m919, Local0), Local1)
	m1a0(Local0, c010, Local1, 749)

	Store(CondRefOf(m91a, Local0), Local1)
	m1a0(Local0, c010, Local1, 750)

	Store(CondRefOf(m91b, Local0), Local1)
	m1a0(Local0, c010, Local1, 751)

	Store(CondRefOf(m91c, Local0), Local1)
	m1a0(Local0, c010, Local1, 752)

	Store(CondRefOf(m91d, Local0), Local1)
	m1a0(Local0, c010, Local1, 753)

	Store(CondRefOf(m91e, Local0), Local1)
	m1a0(Local0, c010, Local1, 754)

	Store(CondRefOf(m91f, Local0), Local1)
	m1a0(Local0, c010, Local1, 755)

	Store(CondRefOf(m920, Local0), Local1)
	m1a0(Local0, c010, Local1, 756)

	Store(CondRefOf(m921, Local0), Local1)
	m1a0(Local0, c010, Local1, 757)

	Store(CondRefOf(m922, Local0), Local1)
	m1a0(Local0, c010, Local1, 758)

	Store(CondRefOf(m923, Local0), Local1)
	m1a0(Local0, c010, Local1, 759)

	Store(CondRefOf(m924, Local0), Local1)
	m1a0(Local0, c010, Local1, 760)

	Store(CondRefOf(m925, Local0), Local1)
	m1a0(Local0, c010, Local1, 761)

	Store(CondRefOf(m926, Local0), Local1)
	m1a0(Local0, c010, Local1, 762)

	Store(CondRefOf(m927, Local0), Local1)
	m1a0(Local0, c010, Local1, 763)

	Store(CondRefOf(m928, Local0), Local1)
	m1a0(Local0, c010, Local1, 764)

	Store(CondRefOf(m929, Local0), Local1)
	m1a0(Local0, c010, Local1, 765)

	Store(CondRefOf(m92a, Local0), Local1)
	m1a0(Local0, c010, Local1, 766)

	Store(CondRefOf(m92b, Local0), Local1)
	m1a0(Local0, c010, Local1, 767)

	Store(CondRefOf(m92c, Local0), Local1)
	m1a0(Local0, c010, Local1, 768)

	Store(CondRefOf(m92d, Local0), Local1)
	m1a0(Local0, c010, Local1, 769)

	Store(CondRefOf(m92e, Local0), Local1)
	m1a0(Local0, c010, Local1, 780)

	Store(CondRefOf(m92f, Local0), Local1)
	m1a0(Local0, c010, Local1, 781)

	Store(CondRefOf(m930, Local0), Local1)
	m1a0(Local0, c010, Local1, 782)

	Store(CondRefOf(m931, Local0), Local1)
	m1a0(Local0, c010, Local1, 783)

	Store(CondRefOf(m932, Local0), Local1)
	m1a0(Local0, c010, Local1, 784)

	Store(CondRefOf(m933, Local0), Local1)
	m1a0(Local0, c010, Local1, 785)

	Store(CondRefOf(m934, Local0), Local1)
	m1a0(Local0, c010, Local1, 786)

	Store(CondRefOf(m935, Local0), Local1)
	m1a0(Local0, c010, Local1, 787)

	m000()
	m1a6()

	return
}

// ///////////////////////////////////////////////////////////////////////////
//
// TABLE 3: all the legal ways to generate references to the
//          immediate images (constants) being elements of Package
//
// ///////////////////////////////////////////////////////////////////////////

Method(m16d)
{

	if (y100) {
		ts00("m16d")
	} else {
		Store("m16d", Debug)
	}

	if (LNot(y900)) {
		Store("Test m16d skipped!", Debug)
		return
	}

	// T3:I0-I4

	if (y104) {
		Store(Index(Package(1){}, 0), Local0)
		m1a0(Local0, c008, Ones, 1281)
	}

	Store(Index(Package(){0xabcdef}, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xabcdef, 1282)

	Store(Index(Package(){"123456789"}, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "123456789", 1283)

	Store(Index(Package(){"qwrtyuiop"}, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyuiop", 1284)

	Store(Index(Package(){Buffer() {1,2,3,4,5,6,7,8}}, 0), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {1,2,3,4,5,6,7,8}, 1285)

	Store(Index(Package(){Package() {0xabcdef}}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabcdef, 1286)

	Store(Index(Package(){Package() {"123456789"}}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "123456789", 1287)

	Store(Index(Package(){Package() {"qwrtyuiop"}}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyuiop", 1288)

	Store(Index(Package(){Package() {Buffer() {1,2,3,4,5,6,7,8,9}}}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {1,2,3,4,5,6,7,8,9}, 1289)

	Store(Index(Package(){Package() {Package() {0xabcdef}}}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabcdef, 1290)

	Store(Index(Package(){Package() {Package() {"123456789"}}}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "123456789", 1291)

	Store(Index(Package(){Package() {Package() {"qwrtyuiop"}}}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "qwrtyuiop", 1292)

	Store(Index(Package(){Package() {Package() {Buffer() {1,2,3,4,5,6,7,8,9}}}}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {1,2,3,4,5,6,7,8,9}, 1293)

	Store(Index(Package(){Package() {Package() {Package() {0xabcdef}}}}, 0), Local0)
	m1a2(Local0, c00c, 3, 0, c009, 0xabcdef, 1294)

	Store(Index(Package(){Package() {Package() {Package() {"123456789"}}}}, 0), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "123456789", 1295)

	Store(Index(Package(){Package() {Package() {Package() {"qwrtyuiop"}}}}, 0), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "qwrtyuiop", 1296)

	Store(Index(Package(){Package() {Package() {Package() {Buffer() {1,2,3,4,5,6,7,8,9}}}}}, 0), Local0)
	m1a2(Local0, c00c, 3, 0, c00b, Buffer() {1,2,3,4,5,6,7,8,9}, 1297)

	// T3:IR0-IR4

	if (y104) {
		Store(Index(Package(1){}, 0, Local1), Local0)
		m1a0(Local0, c008, Ones, 1298)
		m1a0(Local1, c008, Ones, 1299)
	}

	Store(Index(Package(){0xabcdef}, 0, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xabcdef, 1300)
	m1a2(Local1, c009, 0, 0, c009, 0xabcdef, 1301)

	Store(Index(Package(){"123456789"}, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "123456789", 1302)
	m1a2(Local1, c00a, 0, 0, c00a, "123456789", 1303)

	Store(Index(Package(){"qwrtyuiop"}, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyuiop", 1304)
	m1a2(Local1, c00a, 0, 0, c00a, "qwrtyuiop", 1305)

	Store(Index(Package(){Buffer() {1,2,3,4,5,6,7,8}}, 0, Local1), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {1,2,3,4,5,6,7,8}, 1306)
	m1a2(Local1, c00b, 0, 0, c00b, Buffer() {1,2,3,4,5,6,7,8}, 1307)

	Store(Index(Package(){Package() {0xabcdef}}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabcdef, 1308)
	m1a2(Local1, c00c, 1, 0, c009, 0xabcdef, 1309)

	Store(Index(Package(){Package() {"123456789"}}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "123456789", 1310)
	m1a2(Local1, c00c, 1, 0, c00a, "123456789", 1311)

	Store(Index(Package(){Package() {"qwrtyuiop"}}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyuiop", 1312)
	m1a2(Local1, c00c, 1, 0, c00a, "qwrtyuiop", 1313)

	Store(Index(Package(){Package() {Buffer() {1,2,3,4,5,6,7,8,9}}}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {1,2,3,4,5,6,7,8,9}, 1314)
	m1a2(Local1, c00c, 1, 0, c00b, Buffer() {1,2,3,4,5,6,7,8,9}, 1315)

	Store(Index(Package(){Package() {Package() {0xabcdef}}}, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabcdef, 1316)
	m1a2(Local1, c00c, 2, 0, c009, 0xabcdef, 1317)

	Store(Index(Package(){Package() {Package() {"123456789"}}}, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "123456789", 1318)
	m1a2(Local1, c00c, 2, 0, c00a, "123456789", 1319)

	Store(Index(Package(){Package() {Package() {"qwrtyuiop"}}}, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "qwrtyuiop", 1320)
	m1a2(Local1, c00c, 2, 0, c00a, "qwrtyuiop", 1321)

	Store(Index(Package(){Package() {Package() {Buffer() {1,2,3,4,5,6,7,8,9}}}}, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {1,2,3,4,5,6,7,8,9}, 1322)
	m1a2(Local1, c00c, 2, 0, c00b, Buffer() {1,2,3,4,5,6,7,8,9}, 1323)

	Store(Index(Package(){Package() {Package() {Package() {0xabcdef}}}}, 0, Local1), Local0)
	m1a2(Local0, c00c, 3, 0, c009, 0xabcdef, 1324)
	m1a2(Local1, c00c, 3, 0, c009, 0xabcdef, 1325)

	Store(Index(Package(){Package() {Package() {Package() {"123456789"}}}}, 0, Local1), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "123456789", 1326)
	m1a2(Local1, c00c, 3, 0, c00a, "123456789", 1327)

	Store(Index(Package(){Package() {Package() {Package() {"qwrtyuiop"}}}}, 0, Local1), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "qwrtyuiop", 1328)
	m1a2(Local1, c00c, 3, 0, c00a, "qwrtyuiop", 1329)

	Store(Index(Package(){Package() {Package() {Package() {Buffer() {1,2,3,4,5,6,7,8,9}}}}}, 0, Local1), Local0)
	m1a2(Local0, c00c, 3, 0, c00b, Buffer() {1,2,3,4,5,6,7,8,9}, 1330)
	m1a2(Local1, c00c, 3, 0, c00b, Buffer() {1,2,3,4,5,6,7,8,9}, 1331)
}

// ///////////////////////////////////////////////////////////////////////////
//
// TABLE 4: all the legal ways to generate references to the named objects
//          being elements of Package
//
// ///////////////////////////////////////////////////////////////////////////

Method(m16e,, Serialized)
{
	if (y100) {
		ts00("m16e")
	} else {
		Store("m16e", Debug)
	}

	if (LNot(y900)) {
		Store("Test m16e skipped!", Debug)
		return
	}

	// Not Computational Data

	Event(e900)
	Mutex(mx90, 0)
	Device(d900) {}
	ThermalZone(tz90) {}
	Processor(pr90, 0, 0xFFFFFFFF, 0) {}
	OperationRegion(r900, SystemMemory, 0x100, 0x100)
	OperationRegion(r9Z0, SystemMemory, 0x100, 0x100)
	PowerResource(pw90, 1, 0) {Method(mmmm){return (0)}}

	// Computational Data

	Name(i900, 0xfe7cb391d65a5000)
	Name(i901, 0x41795001)
	Name(i902, 0)
	Name(i903, 0xffffffffffffffff)
	Name(i904, 0xffffffff)
	Name(s900, "12345002")
	Name(s901, "qwrtyu5003")
	Name(b900, Buffer() {0xf0,0xf1,0xf2,0xf3,0xf4})
	Name(b9Z0, Buffer() {0xf0,0xf1,0xf2,0xf3,0xf4})

	CreateField(b900, 0, 8, bf90)
	Field(r900, ByteAcc, NoLock, Preserve) {f900,8,f901,8,f902,8,f903,8}
	BankField(r900, f901, 0, ByteAcc, NoLock, Preserve) {bn90,4}
	IndexField(f902, f903, ByteAcc, NoLock, Preserve) {if90,8,if91,8}

	// Elements of Package are Uninitialized

	Name(p900, Package(1) {})

	// Elements of Package are Computational Data

	Name(p901, Package() {0xabcd5004, 0x1122334455665005})
	Name(p902, Package() {"12345006", "q1w2e3r4t5y6u7i85007"})
	Name(p903, Package() {"qwrtyuiop5008", "1234567890abdef0255009"})
	Name(p904, Package() {Buffer() {0xf5,0xf6,0xf7}, Buffer() {0xf8,0xf9}})
	Name(p905, Package() {Package() {0xabc500a, "0xabc500b", "abc500c"}})
	Name(p906, Package() {Package() {"abc500d"}})
	Name(p907, Package() {Package() {"aqwevbgnm500e"}})
	Name(p908, Package() {Package() {Buffer() {0xfa,0xfb,0xfc,0xfd,0xfe}}})
	Name(p909, Package() {Package() {Package() {0xabc500f}}})
	Name(p90a, Package() {Package() {Package() {"12345010"}}})
	Name(p90b, Package() {Package() {Package() {"zxswefas5011"}}})
	Name(p90c, Package() {Package() {Package() {Buffer() {0xff,0x40,0x41}}}})

	Name(p90d, Package() {i900})
	Name(p90e, Package() {i901})
	Name(p90f, Package() {s900})
	Name(p910, Package() {s901})
	Name(p911, Package() {b9Z0})
	Name(p912, Package() {f900})
	Name(p913, Package() {bn90})
	Name(p914, Package() {if90})
	Name(p915, Package() {bf90})

	// Elements of Package are NOT Computational Data

	Name(p916, Package() {d900})
	Name(p917, Package() {e900})
	Name(p918, Package() {mx90})
	Name(p919, Package() {r900})
	Name(p91a, Package() {pw90})
	Name(p91b, Package() {pr90})
	Name(p91c, Package() {tz90})

	// Methods

	Method(m900) {}
	Method(m901) { return (0xabc5012) }
	Method(m902) { return ("zxvgswquiy5013") }
	Method(m903) { return (Buffer() {0x42}) }
	Method(m904) { return (Package() {0xabc5014}) }
	Method(m905) { return (Package() {"lkjhgtre5015"}) }
	Method(m906) { return (Package() {Buffer() {0x43}}) }
	Method(m907) { return (Package() {Package() {0xabc5016}}) }

	Method(m908) { return (i900) }
	Method(m909) { return (i901) }
	Method(m90a) { return (s900) }
	Method(m90b) { return (s901) }
	Method(m90c) { return (b9Z0) }
	Method(m90d) { return (f900) }
	Method(m90e) { return (bn90) }
	Method(m90f) { return (if90) }
	Method(m910) { return (bf90) }

	Method(m911) { return (d900) }
	Method(m912) { return (e900) }
	Method(m913) { return (m901) }
	Method(m914) { return (mx90) }
	Method(m915) { return (r900) }
	Method(m916) { return (pw90) }
	Method(m917) { return (pr90) }
	Method(m918) { return (tz90) }

	Method(m919) { return (p900) }
	Method(m91a) { return (p901) }
	Method(m91b) { return (p902) }
	Method(m91c) { return (p903) }
	Method(m91d) { return (p904) }
	Method(m91e) { return (p905) }
	Method(m91f) { return (p906) }
	Method(m920) { return (p907) }
	Method(m921) { return (p908) }
	Method(m922) { return (p909) }
	Method(m923) { return (p90a) }
	Method(m924) { return (p90b) }
	Method(m925) { return (p90c) }
	Method(m926) { return (p90d) }
	Method(m927) { return (p90e) }
	Method(m928) { return (p90f) }
	Method(m929) { return (p910) }
	Method(m92a) { return (p911) }
	Method(m92b) { return (p912) }
	Method(m92c) { return (p913) }
	Method(m92d) { return (p914) }
	Method(m92e) { return (p915) }
	Method(m92f) { return (p916) }
	Method(m930) { return (p917) }
	Method(m931) { return (p918) }
	Method(m932) { return (p919) }
	Method(m933) { return (p91a) }
	Method(m934) { return (p91b) }
	Method(m935) { return (p91c) }

	// Elements of Package are Methods

	Name(p91d, Package() {m900})
	Name(p91e, Package() {m901})
	Name(p91f, Package() {m902})
	Name(p920, Package() {m903})
	Name(p921, Package() {m904})
	Name(p922, Package() {m905})
	Name(p923, Package() {m906})
	Name(p924, Package() {m907})
	Name(p925, Package() {m908})
	Name(p926, Package() {m909})
	Name(p927, Package() {m90a})
	Name(p928, Package() {m90b})
	Name(p929, Package() {m90c})
	Name(p92a, Package() {m90d})
	Name(p92b, Package() {m90e})
	Name(p92c, Package() {m90f})
	Name(p92d, Package() {m910})
	Name(p92e, Package() {m911})
	Name(p92f, Package() {m912})
	Name(p930, Package() {m913})
	Name(p931, Package() {m914})
	Name(p932, Package() {m915})
	Name(p933, Package() {m916})
	Name(p934, Package() {m917})
	if (y103) {
		Name(p935, Package() {m918})
	}
	Name(p936, Package() {m919})
	Name(p937, Package() {m91a})
	Name(p938, Package() {m91b})
	Name(p939, Package() {m91c})
	Name(p93a, Package() {m91d})
	Name(p93b, Package() {m91e})
	Name(p93c, Package() {m91f})
	Name(p93d, Package() {m920})
	Name(p93e, Package() {m921})
	Name(p93f, Package() {m922})
	Name(p940, Package() {m923})
	Name(p941, Package() {m924})
	Name(p942, Package() {m925})
	Name(p943, Package() {m926})
	Name(p944, Package() {m927})
	Name(p945, Package() {m928})
	Name(p946, Package() {m929})
	Name(p947, Package() {m92a})
	Name(p948, Package() {m92b})
	Name(p949, Package() {m92c})
	Name(p94a, Package() {m92d})
	Name(p94b, Package() {m92e})
	Name(p94c, Package() {m92f})
	Name(p94d, Package() {m930})
	Name(p94e, Package() {m931})
	Name(p94f, Package() {m932})
	Name(p950, Package() {m933})
	Name(p951, Package() {m934})
	Name(p952, Package() {m935})

	Name(p953, Package() {0xabcd5018, 0xabcd5019})
	Name(p954, Package() {0xabcd5018, 0xabcd5019})

	// Check that all the data (local) are not corrupted
	Method(m000)
	{
	// Computational Data

	// Integer

	Store(ObjectType(i900), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x100, 0, 0, Local0, c009)
	}
	if (LNotEqual(i900, 0xfe7cb391d65a5000)) {
		err(c080, z077, 0x101, 0, 0, i900, 0xfe7cb391d65a5000)
	}

	Store(ObjectType(i901), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x102, 0, 0, Local0, c009)
	}
	if (LNotEqual(i901, 0x41795001)) {
		err(c080, z077, 0x103, 0, 0, i901, 0x41795001)
	}

	Store(ObjectType(i902), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x104, 0, 0, Local0, c009)
	}
	if (LNotEqual(i902, 0)) {
		err(c080, z077, 0x105, 0, 0, i902, 0)
	}

	Store(ObjectType(i903), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x106, 0, 0, Local0, c009)
	}
	if (LNotEqual(i903, 0xffffffffffffffff)) {
		err(c080, z077, 0x107, 0, 0, i903, 0xffffffffffffffff)
	}

	Store(ObjectType(i904), Local0)
	if (LNotEqual(Local0, c009)) {
		err(c080, z077, 0x108, 0, 0, Local0, c009)
	}
	if (LNotEqual(i904, 0xffffffff)) {
		err(c080, z077, 0x109, 0, 0, i904, 0xffffffff)
	}

	// String

	Store(ObjectType(s900), Local0)
	if (LNotEqual(Local0, c00a)) {
		err(c080, z077, 0x10a, 0, 0, Local0, c00a)
	}
	if (LNotEqual(s900, "12345002")) {
		err(c080, z077, 0x10b, 0, 0, s900, "12345002")
	}

	Store(ObjectType(s901), Local0)
	if (LNotEqual(Local0, c00a)) {
		err(c080, z077, 0x10c, 0, 0, Local0, c00a)
	}
	if (LNotEqual(s901, "qwrtyu5003")) {
		err(c080, z077, 0x10d, 0, 0, s901, "qwrtyu5003")
	}

	// Buffer

	Store(ObjectType(b900), Local0)
	if (LNotEqual(Local0, c00b)) {
		err(c080, z077, 0x10e, 0, 0, Local0, c00b)
	}
	if (LNotEqual(b900, Buffer() {0xf0,0xf1,0xf2,0xf3,0xf4})) {
		err(c080, z077, 0x10f, 0, 0, b900, Buffer() {0xf0,0xf1,0xf2,0xf3,0xf4})
	}

	// Buffer Field

	Store(ObjectType(bf90), Local0)
	if (LNotEqual(Local0, c016)) {
		err(c080, z077, 0x110, 0, 0, Local0, c016)
	}
	if (LNotEqual(bf90, 0xf0)) {
		err(c080, z077, 0x111, 0, 0, bf90, 0xf0)
	}

	// One level Package

	Store(Index(p900, 0), Local0)
	Store(ObjectType(Local0), Local1)
	if (LNotEqual(Local1, c008)) {
		err(c080, z077, 0x112, 0, 0, Local1, c008)
	}

	Store(Index(p901, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x113, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd5004)) {
		err(c080, z077, 0x114, 0, 0, Local1, 0xabcd5004)
	}

	Store(Index(p901, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x115, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0x1122334455665005)) {
		err(c080, z077, 0x116, 0, 0, Local1, 0x1122334455665005)
	}

	Store(Index(p902, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x117, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "12345006")) {
		err(c080, z077, 0x118, 0, 0, Local1, "12345006")
	}

	Store(Index(p902, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x119, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "q1w2e3r4t5y6u7i85007")) {
		err(c080, z077, 0x11a, 0, 0, Local1, "q1w2e3r4t5y6u7i85007")
	}

	Store(Index(p903, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x11b, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "qwrtyuiop5008")) {
		err(c080, z077, 0x11c, 0, 0, Local1, "qwrtyuiop5008")
	}

	Store(Index(p903, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00a)) {
		err(c080, z077, 0x11d, 0, 0, Local2, c00a)
	}
	if (LNotEqual(Local1, "1234567890abdef0255009")) {
		err(c080, z077, 0x11e, 0, 0, Local1, "1234567890abdef0255009")
	}

	Store(Index(p904, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00b)) {
		err(c080, z077, 0x11f, 0, 0, Local2, c00b)
	}
	if (LNotEqual(Local1, Buffer() {0xf5,0xf6,0xf7})) {
		err(c080, z077, 0x120, 0, 0, Local1, Buffer() {0xf5,0xf6,0xf7})
	}

	Store(Index(p904, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c00b)) {
		err(c080, z077, 0x121, 0, 0, Local2, c00b)
	}
	if (LNotEqual(Local1, Buffer() {0xf8,0xf9})) {
		err(c080, z077, 0x122, 0, 0, Local1, Buffer() {0xf8,0xf9})
	}

	// Two level Package

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c009)) {
		err(c080, z077, 0x123, 0, 0, Local4, c009)
	}
	if (LNotEqual(Local3, 0xabc500a)) {
		err(c080, z077, 0x124, 0, 0, Local3, 0xabc500a)
	}

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 1), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x125, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "0xabc500b")) {
		err(c080, z077, 0x126, 0, 0, Local3, "0xabc500b")
	}

	Store(Index(p905, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 2), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x127, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "abc500c")) {
		err(c080, z077, 0x128, 0, 0, Local3, "abc500c")
	}

	Store(Index(p906, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x129, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "abc500d")) {
		err(c080, z077, 0x12a, 0, 0, Local3, "abc500d")
	}

	Store(Index(p907, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00a)) {
		err(c080, z077, 0x12b, 0, 0, Local4, c00a)
	}
	if (LNotEqual(Local3, "aqwevbgnm500e")) {
		err(c080, z077, 0x12c, 0, 0, Local3, "aqwevbgnm500e")
	}

	Store(Index(p908, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(ObjectType(Local3), Local4)
	if (LNotEqual(Local4, c00b)) {
		err(c080, z077, 0x12d, 0, 0, Local4, c00b)
	}
	if (LNotEqual(Local3, Buffer() {0xfa,0xfb,0xfc,0xfd,0xfe})) {
		err(c080, z077, 0x12e, 0, 0, Local3, Buffer() {0xfa,0xfb,0xfc,0xfd,0xfe})
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
		err(c080, z077, 0x12f, 0, 0, Local6, c009)
	}
	if (LNotEqual(Local5, 0xabc500f)) {
		err(c080, z077, 0x130, 0, 0, Local5, 0xabc500f)
	}

	Store(Index(p90a, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00a)) {
		err(c080, z077, 0x131, 0, 0, Local6, c00a)
	}
	if (LNotEqual(Local5, "12345010")) {
		err(c080, z077, 0x132, 0, 0, Local5, "12345010")
	}

	Store(Index(p90b, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00a)) {
		err(c080, z077, 0x133, 0, 0, Local6, c00a)
	}
	if (LNotEqual(Local5, "zxswefas5011")) {
		err(c080, z077, 0x134, 0, 0, Local5, "zxswefas5011")
	}

	Store(Index(p90c, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(Index(Local1, 0), Local2)
	Store(DerefOf(Local2), Local3)
	Store(Index(Local3, 0), Local4)
	Store(DerefOf(Local4), Local5)
	Store(ObjectType(Local5), Local6)
	if (LNotEqual(Local6, c00b)) {
		err(c080, z077, 0x135, 0, 0, Local6, c00b)
	}
	if (LNotEqual(Local5, Buffer() {0xff,0x40,0x41})) {
		err(c080, z077, 0x136, 0, 0, Local5, Buffer() {0xff,0x40,0x41})
	}

	Store(Index(p953, 0), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x137, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd5018)) {
		err(c080, z077, 0x138, 0, 0, Local1, 0xabcd5018)
	}

	Store(Index(p953, 1), Local0)
	Store(DerefOf(Local0), Local1)
	Store(ObjectType(Local1), Local2)
	if (LNotEqual(Local2, c009)) {
		err(c080, z077, 0x139, 0, 0, Local2, c009)
	}
	if (LNotEqual(Local1, 0xabcd5019)) {
		err(c080, z077, 0x13a, 0, 0, Local1, 0xabcd5019)
	}

	// Not Computational Data

	m1aa(c080, e900, c00f, 0, 0x13b)
	m1aa(c080, mx90, c011, 0, 0x13c)
	m1aa(c080, d900, c00e, 0, 0x13d)
	if (y508) {
		m1aa(c080, tz90, c015, 0, 0x13e)
	}
	m1aa(c080, pr90, c014, 0, 0x13f)
	m1aa(c080, r900, c012, 0, 0x140)
	m1aa(c080, pw90, c013, 0, 0x141)

/*
 *	// Field Unit (Field)
 *
 *	if (LNotEqual(f900, 0xd7)) {
 *		err(c080, z077, 0x137, 0, 0, f900, 0xd7)
 *	}
 *
 *	// Field Unit (IndexField)
 *
 *	if (LNotEqual(if90, 0xd7)) {
 *		err(c080, z077, 0x138, 0, 0, if90, 0xd7)
 *	}
 */
	} /* m000 */


	// T4:x,I1-I14,x,x

	// Computational Data

	Store(Index(Package(){i900}, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a5000, 788)

	Store(Index(Package(){i901}, 0), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0x41795001, 789)

	Store(Index(Package(){s900}, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12345002", 790)

	Store(Index(Package(){s901}, 0), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu5003", 791)

	Store(Index(Package(){b900}, 0), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xf0,0xf1,0xf2,0xf3,0xf4}, 792)

	if (y118) {
		Store(Index(Package(){f900}, 0), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 793)

		Store(Index(Package(){bn90}, 0), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 794)

		Store(Index(Package(){if90}, 0), Local0)
		m1a2(Local0, c00d, 0, 0, c00d, 0, 795)

		Store(Index(Package(){bf90}, 0), Local0)
		m1a2(Local0, c016, 0, 0, c016, 0xf0, 796)
	}

	// Not Computational Data

	Store(Index(Package(){e900}, 0), Local0)
	m1a0(Local0, c00f, Ones, 797)

	Store(Index(Package(){mx90}, 0), Local0)
	m1a0(Local0, c011, Ones, 798)

	Store(Index(Package(){d900}, 0), Local0)
	m1a0(Local0, c00e, Ones, 799)

	Store(Index(Package(){tz90}, 0), Local0)
	m1a0(Local0, c015, Ones, 800)

	Store(Index(Package(){pr90}, 0), Local0)
	m1a0(Local0, c014, Ones, 801)

	Store(Index(Package(){r900}, 0), Local0)
	m1a0(Local0, c012, Ones, 802)

	Store(Index(Package(){pw90}, 0), Local0)
	m1a0(Local0, c013, Ones, 803)

	// Elements of Package are Uninitialized

	Store(Index(Package(){p900}, 0), Local0)
	m1a0(Local0, c00c, Ones, 804)

	// Elements of Package are Computational Data

	Store(Index(Package(){p901}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabcd5004, 805)
	m1a2(Local0, c00c, 1, 1, c009, 0x1122334455665005, 806)

	Store(Index(Package(){p902}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "12345006", 807)
	m1a2(Local0, c00c, 1, 1, c00a, "q1w2e3r4t5y6u7i85007", 808)

	Store(Index(Package(){p903}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyuiop5008", 809)
	m1a2(Local0, c00c, 1, 1, c00a, "1234567890abdef0255009", 810)

	Store(Index(Package(){p904}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xf5,0xf6,0xf7}, 811)

	Store(Index(Package(){p905}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabc500a, 812)
	m1a2(Local0, c00c, 2, 1, c00a, "0xabc500b", 813)

	Store(Index(Package(){p906}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "abc500d", 814)

	Store(Index(Package(){p907}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "aqwevbgnm500e", 815)

	Store(Index(Package(){p908}, 0), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xfa,0xfb,0xfc,0xfd,0xfe}, 816)

	Store(Index(Package(){p909}, 0), Local0)
	m1a2(Local0, c00c, 3, 0, c009, 0xabc500f, 817)

	Store(Index(Package(){p90a}, 0), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "12345010", 818)

	Store(Index(Package(){p90b}, 0), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "zxswefas5011", 819)

	Store(Index(Package(){p90c}, 0), Local0)
	m1a2(Local0, c00c, 3, 0, c00b, Buffer() {0xff,0x40,0x41}, 820)

	Store(Index(Package(){p90d}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xfe7cb391d65a5000, 821)

	Store(Index(Package(){p90e}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0x41795001, 822)

	Store(Index(Package(){p90f}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "12345002", 823)

	Store(Index(Package(){p910}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyu5003", 824)

	Store(Index(Package(){p911}, 0), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xf0,0xf1,0xf2,0xf3,0xf4}, 825)

	if (y118) {
		Store(Index(Package(){p912}, 0), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 826)

		Store(Index(Package(){p913}, 0), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 827)

		Store(Index(Package(){p914}, 0), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 828)

		Store(Index(Package(){p915}, 0), Local0)
		m1a2(Local0, c00c, 1, 0, c016, 0xf0, 829)
	}

	// Elements of Package are NOT Computational Data

	Store(Index(Package(){p916}, 0), Local0)
	m1a0(Local0, c00c, Ones, 830)

	Store(Index(Package(){p917}, 0), Local0)
	m1a0(Local0, c00c, Ones, 831)

	Store(Index(Package(){p918}, 0), Local0)
	m1a0(Local0, c00c, Ones, 832)

	Store(Index(Package(){p919}, 0), Local0)
	m1a0(Local0, c00c, Ones, 833)

	Store(Index(Package(){p91a}, 0), Local0)
	m1a0(Local0, c00c, Ones, 834)

	Store(Index(Package(){p91b}, 0), Local0)
	m1a0(Local0, c00c, Ones, 835)

	Store(Index(Package(){p91c}, 0), Local0)
	m1a0(Local0, c00c, Ones, 836)

	// Elements of Package are Methods

	Store(Index(Package(){p91d}, 0), Local0)
	m1a0(Local0, c00c, Ones, 837)

	Store(Index(Package(){p91e}, 0), Local0)
	m1a0(Local0, c00c, Ones, 838)

	Store(Index(Package(){p91f}, 0), Local0)
	m1a0(Local0, c00c, Ones, 839)

	Store(Index(Package(){p920}, 0), Local0)
	m1a0(Local0, c00c, Ones, 840)

	Store(Index(Package(){p921}, 0), Local0)
	m1a0(Local0, c00c, Ones, 841)

	Store(Index(Package(){p922}, 0), Local0)
	m1a0(Local0, c00c, Ones, 842)

	Store(Index(Package(){p923}, 0), Local0)
	m1a0(Local0, c00c, Ones, 843)

	Store(Index(Package(){p924}, 0), Local0)
	m1a0(Local0, c00c, Ones, 844)

	Store(Index(Package(){p925}, 0), Local0)
	m1a0(Local0, c00c, Ones, 845)

	Store(Index(Package(){p926}, 0), Local0)
	m1a0(Local0, c00c, Ones, 846)

	Store(Index(Package(){p927}, 0), Local0)
	m1a0(Local0, c00c, Ones, 847)

	Store(Index(Package(){p928}, 0), Local0)
	m1a0(Local0, c00c, Ones, 848)

	Store(Index(Package(){p929}, 0), Local0)
	m1a0(Local0, c00c, Ones, 849)

	Store(Index(Package(){p92a}, 0), Local0)
	m1a0(Local0, c00c, Ones, 850)

	Store(Index(Package(){p92b}, 0), Local0)
	m1a0(Local0, c00c, Ones, 851)

	Store(Index(Package(){p92c}, 0), Local0)
	m1a0(Local0, c00c, Ones, 852)

	Store(Index(Package(){p92d}, 0), Local0)
	m1a0(Local0, c00c, Ones, 853)

	Store(Index(Package(){p92e}, 0), Local0)
	m1a0(Local0, c00c, Ones, 854)

	Store(Index(Package(){p92f}, 0), Local0)
	m1a0(Local0, c00c, Ones, 855)

	Store(Index(Package(){p930}, 0), Local0)
	m1a0(Local0, c00c, Ones, 856)

	Store(Index(Package(){p931}, 0), Local0)
	m1a0(Local0, c00c, Ones, 857)

	Store(Index(Package(){p932}, 0), Local0)
	m1a0(Local0, c00c, Ones, 858)

	Store(Index(Package(){p933}, 0), Local0)
	m1a0(Local0, c00c, Ones, 859)

	Store(Index(Package(){p934}, 0), Local0)
	m1a0(Local0, c00c, Ones, 860)

	Store(Index(Package(){p935}, 0), Local0)
	m1a0(Local0, c00c, Ones, 861)

	Store(Index(Package(){p936}, 0), Local0)
	m1a0(Local0, c00c, Ones, 862)

	Store(Index(Package(){p937}, 0), Local0)
	m1a0(Local0, c00c, Ones, 863)

	Store(Index(Package(){p938}, 0), Local0)
	m1a0(Local0, c00c, Ones, 864)

	Store(Index(Package(){p939}, 0), Local0)
	m1a0(Local0, c00c, Ones, 865)

	Store(Index(Package(){p93a}, 0), Local0)
	m1a0(Local0, c00c, Ones, 866)

	Store(Index(Package(){p93b}, 0), Local0)
	m1a0(Local0, c00c, Ones, 867)

	Store(Index(Package(){p93c}, 0), Local0)
	m1a0(Local0, c00c, Ones, 868)

	Store(Index(Package(){p93d}, 0), Local0)
	m1a0(Local0, c00c, Ones, 869)

	Store(Index(Package(){p93e}, 0), Local0)
	m1a0(Local0, c00c, Ones, 870)

	Store(Index(Package(){p93f}, 0), Local0)
	m1a0(Local0, c00c, Ones, 871)

	Store(Index(Package(){p940}, 0), Local0)
	m1a0(Local0, c00c, Ones, 872)

	Store(Index(Package(){p941}, 0), Local0)
	m1a0(Local0, c00c, Ones, 873)

	Store(Index(Package(){p942}, 0), Local0)
	m1a0(Local0, c00c, Ones, 874)

	Store(Index(Package(){p943}, 0), Local0)
	m1a0(Local0, c00c, Ones, 875)

	Store(Index(Package(){p944}, 0), Local0)
	m1a0(Local0, c00c, Ones, 876)

	Store(Index(Package(){p945}, 0), Local0)
	m1a0(Local0, c00c, Ones, 877)

	Store(Index(Package(){p946}, 0), Local0)
	m1a0(Local0, c00c, Ones, 878)

	Store(Index(Package(){p947}, 0), Local0)
	m1a0(Local0, c00c, Ones, 879)

	Store(Index(Package(){p948}, 0), Local0)
	m1a0(Local0, c00c, Ones, 880)

	Store(Index(Package(){p949}, 0), Local0)
	m1a0(Local0, c00c, Ones, 881)

	Store(Index(Package(){p94a}, 0), Local0)
	m1a0(Local0, c00c, Ones, 882)

	Store(Index(Package(){p94b}, 0), Local0)
	m1a0(Local0, c00c, Ones, 883)

	Store(Index(Package(){p94c}, 0), Local0)
	m1a0(Local0, c00c, Ones, 884)

	Store(Index(Package(){p94d}, 0), Local0)
	m1a0(Local0, c00c, Ones, 885)

	Store(Index(Package(){p94e}, 0), Local0)
	m1a0(Local0, c00c, Ones, 886)

	Store(Index(Package(){p94f}, 0), Local0)
	m1a0(Local0, c00c, Ones, 887)

	Store(Index(Package(){p950}, 0), Local0)
	m1a0(Local0, c00c, Ones, 888)

	Store(Index(Package(){p951}, 0), Local0)
	m1a0(Local0, c00c, Ones, 889)

	Store(Index(Package(){p952}, 0), Local0)
	m1a0(Local0, c00c, Ones, 890)

	// Methods

	Store(Index(Package(){m900}, 0), Local0)
	m1a0(Local0, c010, Ones, 891)

	Store(Index(Package(){m901}, 0), Local0)
	m1a0(Local0, c010, Ones, 892)

	Store(Index(Package(){m902}, 0), Local0)
	m1a0(Local0, c010, Ones, 893)

	Store(Index(Package(){m903}, 0), Local0)
	m1a0(Local0, c010, Ones, 894)

	Store(Index(Package(){m904}, 0), Local0)
	m1a0(Local0, c010, Ones, 895)

	Store(Index(Package(){m905}, 0), Local0)
	m1a0(Local0, c010, Ones, 896)

	Store(Index(Package(){m906}, 0), Local0)
	m1a0(Local0, c010, Ones, 897)

	Store(Index(Package(){m907}, 0), Local0)
	m1a0(Local0, c010, Ones, 898)

	Store(Index(Package(){m908}, 0), Local0)
	m1a0(Local0, c010, Ones, 899)

	Store(Index(Package(){m909}, 0), Local0)
	m1a0(Local0, c010, Ones, 900)

	Store(Index(Package(){m90a}, 0), Local0)
	m1a0(Local0, c010, Ones, 901)

	Store(Index(Package(){m90b}, 0), Local0)
	m1a0(Local0, c010, Ones, 902)

	Store(Index(Package(){m90c}, 0), Local0)
	m1a0(Local0, c010, Ones, 903)

	Store(Index(Package(){m90d}, 0), Local0)
	m1a0(Local0, c010, Ones, 904)

	Store(Index(Package(){m90e}, 0), Local0)
	m1a0(Local0, c010, Ones, 905)

	Store(Index(Package(){m90f}, 0), Local0)
	m1a0(Local0, c010, Ones, 906)

	Store(Index(Package(){m910}, 0), Local0)
	m1a0(Local0, c010, Ones, 907)

	Store(Index(Package(){m911}, 0), Local0)
	m1a0(Local0, c010, Ones, 908)

	Store(Index(Package(){m912}, 0), Local0)
	m1a0(Local0, c010, Ones, 909)

	Store(Index(Package(){m913}, 0), Local0)
	m1a0(Local0, c010, Ones, 910)

	Store(Index(Package(){m914}, 0), Local0)
	m1a0(Local0, c010, Ones, 911)

	Store(Index(Package(){m915}, 0), Local0)
	m1a0(Local0, c010, Ones, 912)

	Store(Index(Package(){m916}, 0), Local0)
	m1a0(Local0, c010, Ones, 913)

	Store(Index(Package(){m917}, 0), Local0)
	m1a0(Local0, c010, Ones, 914)

	Store(Index(Package(){m918}, 0), Local0)
	m1a0(Local0, c010, Ones, 915)

	Store(Index(Package(){m919}, 0), Local0)
	m1a0(Local0, c010, Ones, 916)

	Store(Index(Package(){m91a}, 0), Local0)
	m1a0(Local0, c010, Ones, 917)

	Store(Index(Package(){m91b}, 0), Local0)
	m1a0(Local0, c010, Ones, 918)

	Store(Index(Package(){m91c}, 0), Local0)
	m1a0(Local0, c010, Ones, 919)

	Store(Index(Package(){m91d}, 0), Local0)
	m1a0(Local0, c010, Ones, 920)

	Store(Index(Package(){m91e}, 0), Local0)
	m1a0(Local0, c010, Ones, 921)

	Store(Index(Package(){m91f}, 0), Local0)
	m1a0(Local0, c010, Ones, 922)

	Store(Index(Package(){m920}, 0), Local0)
	m1a0(Local0, c010, Ones, 923)

	Store(Index(Package(){m921}, 0), Local0)
	m1a0(Local0, c010, Ones, 924)

	Store(Index(Package(){m922}, 0), Local0)
	m1a0(Local0, c010, Ones, 925)

	Store(Index(Package(){m923}, 0), Local0)
	m1a0(Local0, c010, Ones, 926)

	Store(Index(Package(){m924}, 0), Local0)
	m1a0(Local0, c010, Ones, 927)

	Store(Index(Package(){m925}, 0), Local0)
	m1a0(Local0, c010, Ones, 928)

	Store(Index(Package(){m926}, 0), Local0)
	m1a0(Local0, c010, Ones, 929)

	Store(Index(Package(){m927}, 0), Local0)
	m1a0(Local0, c010, Ones, 930)

	Store(Index(Package(){m928}, 0), Local0)
	m1a0(Local0, c010, Ones, 931)

	Store(Index(Package(){m929}, 0), Local0)
	m1a0(Local0, c010, Ones, 932)

	Store(Index(Package(){m92a}, 0), Local0)
	m1a0(Local0, c010, Ones, 933)

	Store(Index(Package(){m92b}, 0), Local0)
	m1a0(Local0, c010, Ones, 934)

	Store(Index(Package(){m92c}, 0), Local0)
	m1a0(Local0, c010, Ones, 935)

	Store(Index(Package(){m92d}, 0), Local0)
	m1a0(Local0, c010, Ones, 936)

	Store(Index(Package(){m92e}, 0), Local0)
	m1a0(Local0, c010, Ones, 937)

	Store(Index(Package(){m92f}, 0), Local0)
	m1a0(Local0, c010, Ones, 938)

	Store(Index(Package(){m930}, 0), Local0)
	m1a0(Local0, c010, Ones, 939)

	Store(Index(Package(){m931}, 0), Local0)
	m1a0(Local0, c010, Ones, 940)

	Store(Index(Package(){m932}, 0), Local0)
	m1a0(Local0, c010, Ones, 941)

	Store(Index(Package(){m933}, 0), Local0)
	m1a0(Local0, c010, Ones, 942)

	Store(Index(Package(){m934}, 0), Local0)
	m1a0(Local0, c010, Ones, 943)

	Store(Index(Package(){m935}, 0), Local0)
	m1a0(Local0, c010, Ones, 944)

	// T4:x,IR1-IR14,x,x

	// Computational Data

	Store(Index(Package(){i900}, 0, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0xfe7cb391d65a5000, 945)
	m1a2(Local1, c009, 0, 0, c009, 0xfe7cb391d65a5000, 946)

	Store(Index(Package(){i901}, 0, Local1), Local0)
	m1a2(Local0, c009, 0, 0, c009, 0x41795001, 947)
	m1a2(Local1, c009, 0, 0, c009, 0x41795001, 948)

	Store(Index(Package(){s900}, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "12345002", 949)
	m1a2(Local1, c00a, 0, 0, c00a, "12345002", 950)

	Store(Index(Package(){s901}, 0, Local1), Local0)
	m1a2(Local0, c00a, 0, 0, c00a, "qwrtyu5003", 951)
	m1a2(Local1, c00a, 0, 0, c00a, "qwrtyu5003", 952)

	Store(Index(Package(){b900}, 0, Local1), Local0)
	m1a2(Local0, c00b, 0, 0, c00b, Buffer() {0xf0,0xf1,0xf2,0xf3,0xf4}, 953)
	m1a2(Local1, c00b, 0, 0, c00b, Buffer() {0xf0,0xf1,0xf2,0xf3,0xf4}, 954)

	if (y118) {
		Store(Index(Package(){f900}, 0, Local1), Local0)
		m1a2(Local0, c00d, 0, 0, c009, 0, 955)
		m1a2(Local1, c00d, 0, 0, c009, 0, 956)

		Store(Index(Package(){bn90}, 0, Local1), Local0)
		m1a2(Local0, c00d, 0, 0, c009, 0, 957)
		m1a2(Local1, c00d, 0, 0, c009, 0, 958)

		Store(Index(Package(){if90}, 0, Local1), Local0)
		m1a2(Local0, c00d, 0, 0, c009, 0, 959)
		m1a2(Local1, c00d, 0, 0, c009, 0, 960)

		Store(Index(Package(){bf90}, 0, Local1), Local0)
		m1a2(Local0, c016, 0, 0, c009, 0xf0, 961)
		m1a2(Local1, c016, 0, 0, c009, 0xf0, 962)
	}

	// Not Computational Data

	Store(Index(Package(){e900}, 0, Local1), Local0)
	m1a0(Local0, c00f, Ones, 963)
	m1a0(Local1, c00f, Ones, 964)

	Store(Index(Package(){mx90}, 0, Local1), Local0)
	m1a0(Local0, c011, Ones, 965)
	m1a0(Local1, c011, Ones, 966)

	Store(Index(Package(){d900}, 0, Local1), Local0)
	m1a0(Local0, c00e, Ones, 967)
	m1a0(Local1, c00e, Ones, 968)

	Store(Index(Package(){tz90}, 0, Local1), Local0)
	m1a0(Local0, c015, Ones, 969)
	m1a0(Local1, c015, Ones, 970)

	Store(Index(Package(){pr90}, 0, Local1), Local0)
	m1a0(Local0, c014, Ones, 971)
	m1a0(Local1, c014, Ones, 972)

	Store(Index(Package(){r900}, 0, Local1), Local0)
	m1a0(Local0, c012, Ones, 973)
	m1a0(Local1, c012, Ones, 974)

	Store(Index(Package(){pw90}, 0, Local1), Local0)
	m1a0(Local0, c013, Ones, 975)
	m1a0(Local1, c013, Ones, 976)

	// Elements of Package are Uninitialized

	Store(Index(Package(){p900}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 977)
	m1a0(Local1, c00c, Ones, 978)

	// Elements of Package are Computational Data

	Store(Index(Package(){p901}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xabcd5004, 979)
	m1a2(Local0, c00c, 1, 1, c009, 0x1122334455665005, 980)
	m1a2(Local1, c00c, 1, 0, c009, 0xabcd5004, 981)
	m1a2(Local1, c00c, 1, 1, c009, 0x1122334455665005, 982)


	Store(Index(Package(){p902}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "12345006", 983)
	m1a2(Local0, c00c, 1, 1, c00a, "q1w2e3r4t5y6u7i85007", 984)
	m1a2(Local1, c00c, 1, 0, c00a, "12345006", 985)
	m1a2(Local1, c00c, 1, 1, c00a, "q1w2e3r4t5y6u7i85007", 986)

	Store(Index(Package(){p903}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyuiop5008", 987)
	m1a2(Local0, c00c, 1, 1, c00a, "1234567890abdef0255009", 988)
	m1a2(Local1, c00c, 1, 0, c00a, "qwrtyuiop5008", 989)
	m1a2(Local1, c00c, 1, 1, c00a, "1234567890abdef0255009", 990)

	Store(Index(Package(){p904}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xf5,0xf6,0xf7}, 991)
	m1a2(Local1, c00c, 1, 0, c00b, Buffer() {0xf5,0xf6,0xf7}, 992)

	Store(Index(Package(){p905}, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c009, 0xabc500a, 993)
	m1a2(Local0, c00c, 2, 1, c00a, "0xabc500b", 994)
	m1a2(Local1, c00c, 2, 0, c009, 0xabc500a, 995)
	m1a2(Local1, c00c, 2, 1, c00a, "0xabc500b", 996)

	Store(Index(Package(){p906}, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "abc500d", 997)
	m1a2(Local1, c00c, 2, 0, c00a, "abc500d", 998)

	Store(Index(Package(){p907}, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00a, "aqwevbgnm500e", 999)
	m1a2(Local1, c00c, 2, 0, c00a, "aqwevbgnm500e", 1000)

	Store(Index(Package(){p908}, 0, Local1), Local0)
	m1a2(Local0, c00c, 2, 0, c00b, Buffer() {0xfa,0xfb,0xfc,0xfd,0xfe}, 1001)
	m1a2(Local1, c00c, 2, 0, c00b, Buffer() {0xfa,0xfb,0xfc,0xfd,0xfe}, 1002)

	Store(Index(Package(){p909}, 0, Local1), Local0)
	m1a2(Local0, c00c, 3, 0, c009, 0xabc500f, 1003)
	m1a2(Local1, c00c, 3, 0, c009, 0xabc500f, 1004)

	Store(Index(Package(){p90a}, 0, Local1), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "12345010", 1005)
	m1a2(Local1, c00c, 3, 0, c00a, "12345010", 1006)

	Store(Index(Package(){p90b}, 0, Local1), Local0)
	m1a2(Local0, c00c, 3, 0, c00a, "zxswefas5011", 1007)
	m1a2(Local1, c00c, 3, 0, c00a, "zxswefas5011", 1008)

	Store(Index(Package(){p90c}, 0, Local1), Local0)
	m1a2(Local0, c00c, 3, 0, c00b, Buffer() {0xff,0x40,0x41}, 1009)
	m1a2(Local1, c00c, 3, 0, c00b, Buffer() {0xff,0x40,0x41}, 1010)

	Store(Index(Package(){p90d}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0xfe7cb391d65a5000, 1011)
	m1a2(Local1, c00c, 1, 0, c009, 0xfe7cb391d65a5000, 1012)

	Store(Index(Package(){p90e}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c009, 0x41795001, 1013)
	m1a2(Local1, c00c, 1, 0, c009, 0x41795001, 1014)

	Store(Index(Package(){p90f}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "12345002", 1015)
	m1a2(Local1, c00c, 1, 0, c00a, "12345002", 1016)

	Store(Index(Package(){p910}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00a, "qwrtyu5003", 1017)
	m1a2(Local1, c00c, 1, 0, c00a, "qwrtyu5003", 1018)

	Store(Index(Package(){p911}, 0, Local1), Local0)
	m1a2(Local0, c00c, 1, 0, c00b, Buffer() {0xf0,0xf1,0xf2,0xf3,0xf4}, 1019)
	m1a2(Local1, c00c, 1, 0, c00b, Buffer() {0xf0,0xf1,0xf2,0xf3,0xf4}, 1020)

	if (y118) {
		Store(Index(Package(){p912}, 0, Local1), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 1021)
		m1a2(Local1, c00c, 1, 0, c00d, 0, 1022)

		Store(Index(Package(){p913}, 0, Local1), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 1023)
		m1a2(Local1, c00c, 1, 0, c00d, 0, 1024)

		Store(Index(Package(){p914}, 0, Local1), Local0)
		m1a2(Local0, c00c, 1, 0, c00d, 0, 1025)
		m1a2(Local1, c00c, 1, 0, c00d, 0, 1026)

		Store(Index(Package(){p915}, 0, Local1), Local0)
		m1a2(Local0, c00c, 1, 0, c016, 0xf0, 1027)
		m1a2(Local1, c00c, 1, 0, c016, 0xf0, 1028)
	}

	// Elements of Package are NOT Computational Data

	Store(Index(Package(){p916}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1029)
	m1a0(Local1, c00c, Ones, 1030)

	Store(Index(Package(){p917}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1031)
	m1a0(Local1, c00c, Ones, 1032)

	Store(Index(Package(){p918}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1033)
	m1a0(Local1, c00c, Ones, 1034)

	Store(Index(Package(){p919}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1035)
	m1a0(Local1, c00c, Ones, 1036)

	Store(Index(Package(){p91a}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1037)
	m1a0(Local1, c00c, Ones, 1038)

	Store(Index(Package(){p91b}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1039)
	m1a0(Local1, c00c, Ones, 1040)

	Store(Index(Package(){p91c}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1041)
	m1a0(Local1, c00c, Ones, 1042)

	// Elements of Package are Methods

	Store(Index(Package(){p91d}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1043)
	m1a0(Local1, c00c, Ones, 1044)

	Store(Index(Package(){p91e}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1045)
	m1a0(Local1, c00c, Ones, 1046)

	Store(Index(Package(){p91f}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1047)
	m1a0(Local1, c00c, Ones, 1048)

	Store(Index(Package(){p920}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1049)
	m1a0(Local1, c00c, Ones, 1050)

	Store(Index(Package(){p921}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1051)
	m1a0(Local1, c00c, Ones, 1052)

	Store(Index(Package(){p922}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1053)
	m1a0(Local1, c00c, Ones, 1054)

	Store(Index(Package(){p923}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1055)
	m1a0(Local1, c00c, Ones, 1056)

	Store(Index(Package(){p924}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1057)
	m1a0(Local1, c00c, Ones, 1058)

	Store(Index(Package(){p925}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1059)
	m1a0(Local1, c00c, Ones, 1060)

	Store(Index(Package(){p926}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1061)
	m1a0(Local1, c00c, Ones, 1062)

	Store(Index(Package(){p927}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1063)
	m1a0(Local1, c00c, Ones, 1064)

	Store(Index(Package(){p928}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1065)
	m1a0(Local1, c00c, Ones, 1066)

	Store(Index(Package(){p929}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1067)
	m1a0(Local1, c00c, Ones, 1068)

	Store(Index(Package(){p92a}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1069)
	m1a0(Local1, c00c, Ones, 1070)

	Store(Index(Package(){p92b}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1071)
	m1a0(Local1, c00c, Ones, 1072)

	Store(Index(Package(){p92c}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1073)
	m1a0(Local1, c00c, Ones, 1074)

	Store(Index(Package(){p92d}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1075)
	m1a0(Local1, c00c, Ones, 1076)

	Store(Index(Package(){p92e}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1077)
	m1a0(Local1, c00c, Ones, 1078)

	Store(Index(Package(){p92f}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1079)
	m1a0(Local1, c00c, Ones, 1080)

	Store(Index(Package(){p930}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1081)
	m1a0(Local1, c00c, Ones, 1082)

	Store(Index(Package(){p931}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1083)
	m1a0(Local1, c00c, Ones, 1084)

	Store(Index(Package(){p932}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1085)
	m1a0(Local1, c00c, Ones, 1086)

	Store(Index(Package(){p933}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1087)
	m1a0(Local1, c00c, Ones, 1088)

	Store(Index(Package(){p934}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1089)
	m1a0(Local1, c00c, Ones, 1090)

	Store(Index(Package(){p935}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1091)
	m1a0(Local1, c00c, Ones, 1092)

	Store(Index(Package(){p936}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1093)
	m1a0(Local1, c00c, Ones, 1094)

	Store(Index(Package(){p937}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1095)
	m1a0(Local1, c00c, Ones, 1096)

	Store(Index(Package(){p938}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1097)
	m1a0(Local1, c00c, Ones, 1098)

	Store(Index(Package(){p939}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1099)
	m1a0(Local1, c00c, Ones, 1100)

	Store(Index(Package(){p93a}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1101)
	m1a0(Local1, c00c, Ones, 1102)

	Store(Index(Package(){p93b}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1103)
	m1a0(Local1, c00c, Ones, 1104)

	Store(Index(Package(){p93c}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1105)
	m1a0(Local1, c00c, Ones, 1106)

	Store(Index(Package(){p93d}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1107)
	m1a0(Local1, c00c, Ones, 1108)

	Store(Index(Package(){p93e}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1109)
	m1a0(Local1, c00c, Ones, 1110)

	Store(Index(Package(){p93f}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1111)
	m1a0(Local1, c00c, Ones, 1112)

	Store(Index(Package(){p940}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1113)
	m1a0(Local1, c00c, Ones, 1114)

	Store(Index(Package(){p941}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1115)
	m1a0(Local1, c00c, Ones, 1116)

	Store(Index(Package(){p942}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1117)
	m1a0(Local1, c00c, Ones, 1118)

	Store(Index(Package(){p943}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1119)
	m1a0(Local1, c00c, Ones, 1120)

	Store(Index(Package(){p944}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1121)
	m1a0(Local1, c00c, Ones, 1122)

	Store(Index(Package(){p945}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1123)
	m1a0(Local1, c00c, Ones, 1124)

	Store(Index(Package(){p946}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1125)
	m1a0(Local1, c00c, Ones, 1126)

	Store(Index(Package(){p947}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1127)
	m1a0(Local1, c00c, Ones, 1128)

	Store(Index(Package(){p948}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1129)
	m1a0(Local1, c00c, Ones, 1130)

	Store(Index(Package(){p949}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1131)
	m1a0(Local1, c00c, Ones, 1132)

	Store(Index(Package(){p94a}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1133)
	m1a0(Local1, c00c, Ones, 1134)

	Store(Index(Package(){p94b}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1135)
	m1a0(Local1, c00c, Ones, 1136)

	Store(Index(Package(){p94c}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1137)
	m1a0(Local1, c00c, Ones, 1138)

	Store(Index(Package(){p94d}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1139)
	m1a0(Local1, c00c, Ones, 1140)

	Store(Index(Package(){p94e}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1141)
	m1a0(Local1, c00c, Ones, 1142)

	Store(Index(Package(){p94f}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1143)
	m1a0(Local1, c00c, Ones, 1144)

	Store(Index(Package(){p950}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1145)
	m1a0(Local1, c00c, Ones, 1146)

	Store(Index(Package(){p951}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1147)
	m1a0(Local1, c00c, Ones, 1148)

	Store(Index(Package(){p952}, 0, Local1), Local0)
	m1a0(Local0, c00c, Ones, 1149)
	m1a0(Local1, c00c, Ones, 1150)

	// Methods

	Store(Index(Package(){m900}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1151)
	m1a0(Local1, c010, Ones, 1152)

	Store(Index(Package(){m901}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1153)
	m1a0(Local1, c010, Ones, 1154)

	Store(Index(Package(){m902}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1155)
	m1a0(Local1, c010, Ones, 1156)

	Store(Index(Package(){m903}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1157)
	m1a0(Local1, c010, Ones, 1158)

	Store(Index(Package(){m904}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1159)
	m1a0(Local1, c010, Ones, 1160)

	Store(Index(Package(){m905}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1161)
	m1a0(Local1, c010, Ones, 1162)

	Store(Index(Package(){m906}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1163)
	m1a0(Local1, c010, Ones, 1164)

	Store(Index(Package(){m907}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1165)
	m1a0(Local1, c010, Ones, 1166)

	Store(Index(Package(){m908}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1167)
	m1a0(Local1, c010, Ones, 1168)

	Store(Index(Package(){m909}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1169)
	m1a0(Local1, c010, Ones, 1170)

	Store(Index(Package(){m90a}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1171)
	m1a0(Local1, c010, Ones, 1172)

	Store(Index(Package(){m90b}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1173)
	m1a0(Local1, c010, Ones, 1174)

	Store(Index(Package(){m90c}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1175)
	m1a0(Local1, c010, Ones, 1176)

	Store(Index(Package(){m90d}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1177)
	m1a0(Local1, c010, Ones, 1178)

	Store(Index(Package(){m90e}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1179)
	m1a0(Local1, c010, Ones, 1180)

	Store(Index(Package(){m90f}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1181)
	m1a0(Local1, c010, Ones, 1182)

	Store(Index(Package(){m910}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1183)
	m1a0(Local1, c010, Ones, 1184)

	Store(Index(Package(){m911}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1185)
	m1a0(Local1, c010, Ones, 1186)

	Store(Index(Package(){m912}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1187)
	m1a0(Local1, c010, Ones, 1188)

	Store(Index(Package(){m913}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1189)
	m1a0(Local1, c010, Ones, 1190)

	Store(Index(Package(){m914}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1191)
	m1a0(Local1, c010, Ones, 1192)

	Store(Index(Package(){m915}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1193)
	m1a0(Local1, c010, Ones, 1194)

	Store(Index(Package(){m916}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1195)
	m1a0(Local1, c010, Ones, 1196)

	Store(Index(Package(){m917}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1197)
	m1a0(Local1, c010, Ones, 1198)

	Store(Index(Package(){m918}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1199)
	m1a0(Local1, c010, Ones, 1200)

	Store(Index(Package(){m919}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1201)
	m1a0(Local1, c010, Ones, 1202)

	Store(Index(Package(){m91a}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1203)
	m1a0(Local1, c010, Ones, 1204)

	Store(Index(Package(){m91b}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1205)
	m1a0(Local1, c010, Ones, 1206)

	Store(Index(Package(){m91c}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1207)
	m1a0(Local1, c010, Ones, 1208)

	Store(Index(Package(){m91d}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1209)
	m1a0(Local1, c010, Ones, 1210)

	Store(Index(Package(){m91e}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1211)
	m1a0(Local1, c010, Ones, 1212)

	Store(Index(Package(){m91f}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1213)
	m1a0(Local1, c010, Ones, 1214)

	Store(Index(Package(){m920}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1215)
	m1a0(Local1, c010, Ones, 1216)

	Store(Index(Package(){m921}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1217)
	m1a0(Local1, c010, Ones, 1218)

	Store(Index(Package(){m922}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1219)
	m1a0(Local1, c010, Ones, 1220)

	Store(Index(Package(){m923}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1221)
	m1a0(Local1, c010, Ones, 1222)

	Store(Index(Package(){m924}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1223)
	m1a0(Local1, c010, Ones, 1224)

	Store(Index(Package(){m925}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1225)
	m1a0(Local1, c010, Ones, 1226)

	Store(Index(Package(){m926}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1227)
	m1a0(Local1, c010, Ones, 1228)

	Store(Index(Package(){m927}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1229)
	m1a0(Local1, c010, Ones, 1230)

	Store(Index(Package(){m928}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1231)
	m1a0(Local1, c010, Ones, 1232)

	Store(Index(Package(){m929}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1233)
	m1a0(Local1, c010, Ones, 1234)

	Store(Index(Package(){m92a}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1235)
	m1a0(Local1, c010, Ones, 1236)

	Store(Index(Package(){m92b}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1237)
	m1a0(Local1, c010, Ones, 1238)

	Store(Index(Package(){m92c}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1239)
	m1a0(Local1, c010, Ones, 1240)

	Store(Index(Package(){m92d}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1241)
	m1a0(Local1, c010, Ones, 1242)

	Store(Index(Package(){m92e}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1243)
	m1a0(Local1, c010, Ones, 1244)

	Store(Index(Package(){m92f}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1245)
	m1a0(Local1, c010, Ones, 1246)

	Store(Index(Package(){m930}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1247)
	m1a0(Local1, c010, Ones, 1248)

	Store(Index(Package(){m931}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1249)
	m1a0(Local1, c010, Ones, 1250)

	Store(Index(Package(){m932}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1251)
	m1a0(Local1, c010, Ones, 1252)

	Store(Index(Package(){m933}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1253)
	m1a0(Local1, c010, Ones, 1254)

	Store(Index(Package(){m934}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1255)
	m1a0(Local1, c010, Ones, 1256)

	Store(Index(Package(){m935}, 0, Local1), Local0)
	m1a0(Local0, c010, Ones, 1257)
	m1a0(Local1, c010, Ones, 1258)

	m000()
	m1a6()
}

Method(m16f, 7)
{
	Store(z077, c081)		// absolute index of file initiating the checking
	Store(1, c089)		// flag of Reference, object otherwise

	if (arg0) {
		m168()
	}
	if (arg1) {
		m169()
	}
	if (arg2) {
		m16a(c083)
	}
	if (arg3) {
		m16b()
	}
	if (arg4) {
		m16c(c083)
	}
	if (arg5) {
		m16d()
	}
	if (arg6) {
		m16e()
	}
}

// Usual mode
Method(m178)
{
	Store(1, c084)	// run verification of references (reading)
	Store(0, c085)	// create the chain of references to LocalX, then dereference them

	Store("Usual mode:", Debug)

	m16f(1, 1, 1, 1, 1, 1, 1)
}

// The mode with the chain of references to LocalX
Method(m179)
{
	Store(1, c084)	// run verification of references (reading)
	Store(1, c085)	// create the chain of references to LocalX, then dereference them

	Store("The mode with the chain of references to LocalX:", Debug)

	m16f(1, 1, 1, 1, 1, 1, 1)
}

// Run-method
Method(REF1)
{
	Store("TEST: REF1, References", Debug)

	Store("REF1", c080)	// name of test
	Store(0, c082)		// flag of test of exceptions
	Store(0, c083)		// run verification of references (write/read)
	Store(0, c086)		// flag, run test till the first error
	Store(1, c087)		// apply DeRefOf to ArgX-ObjectReference

	m178()
	m179()
}
