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
 *
 * Different type data for different needs
 *
 */

/*
SEE: uncomment m918 after fixing bug (?) of ACPICA
SEE: uncomment below:
//	Method(m918) { return (tz90) }
*/

Name(z113, 113)

	// Not Computational Data

	Event(e900)
	Event(e9Z0)
	Mutex(mx90, 0)
	Mutex(mx91, 0)
	Device(d900) { Name(i900, 0xabcd0017) }
	Device(d9Z0) { Name(i900, 0xabcd0017) }
	ThermalZone(tz90) {}
	ThermalZone(tz91) {}
	Processor(pr90, 0, 0xFFFFFFFF, 0) {}
	Processor(pr91, 0, 0xFFFFFFFF, 0) {}
	OperationRegion(r900, SystemMemory, 0x100, 0x100)
	OperationRegion(r9Z0, SystemMemory, 0x100, 0x100)
	PowerResource(pw90, 1, 0) {Method(mmmm){return (0)}}
	PowerResource(pw91, 1, 0) {Method(mmmm){return (0)}}

	// Computational Data

	Name(i900, 0xfe7cb391d65a0000)
	Name(i9Z0, 0xfe7cb391d65a0000)
	Name(i901, 0xc1790001)
	Name(i9Z1, 0xc1790001)
	Name(i902, 0)
	Name(i903, 0xffffffffffffffff)
	Name(i904, 0xffffffff)
	Name(s900, "12340002")
	Name(s9Z0, "12340002")
	Name(s901, "qwrtyu0003")
	Name(s9Z1, "qwrtyu0003")
	Name(b900, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	Name(b9Z0, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})

	CreateField(b9Z0, 0, 8, bf90)
	Field(r9Z0, ByteAcc, NoLock, Preserve) {f900,8,f901,8,f902,8,f903,8}
	BankField(r9Z0, f901, 0, ByteAcc, NoLock, Preserve) {bn90,4}
	IndexField(f902, f903, ByteAcc, NoLock, Preserve) {if90,8,if91,8}

	// Elements of Package are Uninitialized

	Name(p900, Package(1) {})

	// Elements of Package are Computational Data

	Name(p901, Package() {0xabcd0004, 0x1122334455660005})
	Name(p902, Package() {"12340006", "q1w2e3r4t5y6u7i80007"})
	Name(p903, Package() {"qwrtyuiop0008", "1234567890abdef0250009"})
	Name(p904, Package() {Buffer() {0xb5,0xb6,0xb7}, Buffer() {0xb8,0xb9}})
	Name(p905, Package() {Package() {0xabc000a, "0xabc000b", "abc000c"}})
	Name(p906, Package() {Package() {"abc000d"}})
	Name(p907, Package() {Package() {"aqwevbgnm000e"}})
	Name(p908, Package() {Package() {Buffer() {0xba,0xbb,0xbc,0xbd,0xbe}}})
	Name(p909, Package() {Package() {Package() {0xabc000f}}})
	Name(p90a, Package() {Package() {Package() {"12340010"}}})
	Name(p90b, Package() {Package() {Package() {"zxswefas0011"}}})
	Name(p90c, Package() {Package() {Package() {Buffer() {0xbf,0xc0,0xc1}}}})

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
	Method(m901) { return (0xabc0012) }
	Method(m902) { return ("zxvgswquiy0013") }
	Method(m903) { return (Buffer() {0xc2}) }
	Method(m904) { return (Package() {0xabc0014}) }
	Method(m905) { return (Package() {"lkjhgtre0015"}) }
	Method(m906) { return (Package() {Buffer() {0xc3}}) }
	Method(m907) { return (Package() {Package() {0xabc0016}}) }

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
//	Method(m918) { return (tz90) }
 Method(m918) { return (0) }

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

	Name(p953, Package() {0xabcd0018, 0xabcd0019})
	Name(p954, Package() {0xabcd0018, 0xabcd0019})

	Name(i905, 0xabcd001a)
	Name(i9Z5, 0xabcd001a)

	Method(m936) {
		Store(0, i905)
		return (mx90)
	}

	Name(p955, Package(18) {
		0,i900,s900,b900,p953,f900,d900,e900,
		m936,mx90,r900,pw90,pr90,tz90,bf90,15,16})
	Name(p956, Package(18) {
		0,i900,s900,b900,p953,f900,d900,e900,
		m936,mx90,r900,pw90,pr90,tz90,bf90,15,16})

	// Global Standard Data

	Name(ia00, 0x77)
	Name(sa00, "qwer0000")
	Name(ba00, Buffer(4) {1,0x77,3,4})
	Name(pa00, Package(3) {5,0x77,7})

	Name(ia10, 0x77)
	Name(sa10, "qwer0000")
	Name(ba10, Buffer(4) {1,0x77,3,4})
	Name(pa10, Package(3) {5,0x77,7})

	Name(ia01, 0x2b)
	Name(sa01, "qw+r0000")
	Name(ba01, Buffer(4) {1,0x2b,3,4})
	Name(pa01, Package(3) {5,0x2b,7})

	Name(ia11, 0x2b)
	Name(sa11, "qw+r0000")
	Name(ba11, Buffer(4) {1,0x2b,3,4})
	Name(pa11, Package(3) {5,0x2b,7})

