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
 * All the Packages are declared dynamically
 * (NumElements specified by arg0) as locals
 * of Methods.
 */

Method(md6e, 1, Serialized)
{
	Name(p504, Package(arg0) {})

	md6a(
		p504,              // Package
		0x10000,           // size of Package
		0,                 // size of pre-initialized area
		0x9345,            // index of area to be written
		57,                // size of area to be written
		10,                // maximal number of pre-initialized elements to be verified
		10)                // maximal number of written elements to be verified
}

Method(md6f, 1, Serialized)
{
	Name(p505, Package(arg0) {})

	md6a(
		p505,              // Package
		100,               // size of Package
		0,                 // size of pre-initialized area
		73,                // index of area to be written
		19,                // size of area to be written
		10,                // maximal number of pre-initialized elements to be verified
		10)                // maximal number of written elements to be verified
}

Method(md70, 1, Serialized)
{
	Name(p506, Package(arg0) {})

	md6a(
		p506,              // Package
		255,               // size of Package
		0,                 // size of pre-initialized area
		17,                // index of area to be written
		19,                // size of area to be written
		10,                // maximal number of pre-initialized elements to be verified
		10)                // maximal number of written elements to be verified
}

Method(md71, 1, Serialized)
{
	Name(p000, Package(arg0) {})

	md6a(
		p000,              // Package
		256,               // size of Package
		0,                 // size of pre-initialized area
		17,                // index of area to be written
		19,                // size of area to be written
		10,                // maximal number of pre-initialized elements to be verified
		10)                // maximal number of written elements to be verified
}

Method(md72, 1, Serialized)
{
	Name(p000, Package(arg0) {})

	md6a(
		p000,              // Package
		257,               // size of Package
		0,                 // size of pre-initialized area
		Subtract(257, 55), // index of area to be written
		55,                // size of area to be written
		10,                // maximal number of pre-initialized elements to be verified
		55)                // maximal number of written elements to be verified
}

Method(md73)
{
	md6e(0x10000)
	md6f(100)
	md70(255)
	md71(256)
	md72(257)
}

