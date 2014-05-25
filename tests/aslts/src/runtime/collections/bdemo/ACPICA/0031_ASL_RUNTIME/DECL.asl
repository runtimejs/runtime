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
 * Bug 0031:
 *
 * SUMMARY: The ASL Compiler doesn't try to detect and reject attempts to use object before its declaration is evaluated
 *
 * ASL-compiler doesnt result in Error
 *
 * ATTENTION:
 *
 * Note 1: This test now is a run-time test because the ASL compiler doesn't
 *         actually detect and prohibit (my mistake) use of object before its
 *         declaration. After this bug of ASL compiler is fixed move this bdemo
 *         to non-run-time bug tests but dont forget to move all positive checkings
 *         of it in other run-time tests.
 *
 * Note 2: Since the ability itself to tun this test is error
 *         the test returns Error inconditionally (Method m1dc).
 *         But only one that error is expected. When the bug is
 *         fixed we will encounter that the test is no more
 *         compiled and fix it (see Note 1).
 */

Name(id28, 0)

Method(mdc7,, Serialized)
{
	CH03("", 0, 0x000, 0, 0)
	Store(0x12345678, i000)
	Name(i000, 0)
	CH04("", 0, 0xff, 0, 0x001, 0, 0)
}

Method (m800,, Serialized)
{
	Name(i000, 0)
	Method (m000,, Serialized)
	{
		Store(i000, Debug)
		Name(i000, 0xffffffff)
	}
}

Method (m801)
{
	Method (m000,, Serialized)
	{
		Store(id28, Debug)
		Name(id28, 0xffffffff)
	}
}

Method(m802,, Serialized)
{
	Name(i000, 0)
	Store(0xabcd0000, i000)

	CH03("", 0, 0x002, 0, 0)

	Name(i001, 0)
	Store(0xabcd0001, i001)

	CH03("", 0, 0x003, 0, 0)

	Name(i002, 0xabcd0002)

	CH03("", 0, 0x003, 0, 0)

	if (y084) {

		CH03("", 0, 0x004, 0, 0)

		Method(m000,, Serialized)
		{
			Name(i000, 0xabcd0003)
			if (LNotEqual(i000, 0xabcd0003)) {
				err("", zFFF, 0x006, 0, 0, i000, 0xabcd0003)
			}
		}

		CH03("", 0, 0x005, 0, 0)

		Method(m001,, Serialized)
		{
			Name(i000, 0xabcd0004)
			Store(0xabcd0005, i000)
			if (LNotEqual(i000, 0xabcd0005)) {
				err("", zFFF, 0x006, 0, 0, i000, 0xabcd0005)
			}
		}

		CH03("", 0, 0x006, 0, 0)

		Method(m002,, Serialized)
		{
			Store(i000, Debug)
			Name(i000, 0xabcd0006)
			Store(0xabcd0007, i000)
			if (LNotEqual(i000, 0xabcd0007)) {
				err("", zFFF, 0x006, 0, 0, i000, 0xabcd0007)
			}
		}

		CH03("", 0, 0x007, 0, 0)

		Method (m003,, Serialized)
		{
			Store("------------------------------ 000000000", Debug)
			Store(id28, Debug)
			Name(id28, 0xabcd0008)
			if (LNotEqual(id28, 0xabcd0008)) {
				err("", zFFF, 0x006, 0, 0, id28, 0xabcd0008)
			}
		}

		CH03("", 0, 0x008, 0, 0)
	}

	CH03("", 0, 0x009, 0, 0)

	if (LNotEqual(i000, 0xabcd0000)) {
		err("", zFFF, 0x00a, 0, 0, i000, 0xabcd0000)
	}
	if (LNotEqual(i001, 0xabcd0001)) {
		err("", zFFF, 0x00b, 0, 0, i001, 0xabcd0001)
	}
	if (LNotEqual(i002, 0xabcd0002)) {
		err("", zFFF, 0x00c, 0, 0, i002, 0xabcd0002)
	}

	if (y084) {
		CH03("", 0, 0x00d, 0, 0)
		m000()
		CH03("", 0, 0x00e, 0, 0)
		m001()
		CH03("", 0, 0x00f, 0, 0)
		m002()
		CH03("", 0, 0x010, 0, 0)
		m003()
		CH03("", 0, 0x011, 0, 0)
	} else {
		SRMT("sub-tests-of-m802")
		BLCK()
	}

	CH03("", 0, 0x012, 0, 0)

	Store(0xabcd0009, ii99)
	Name(ii99, 0)

	CH04("", 0, 0xff, 0, 0x013, 0, 0)
}

Method(m1dc)
{
	/* Successful compilation itself of this test is error */
	err("", zFFF, 0x014, 0, 0, 0, 0)
}

Method(mdc6)
{
	SRMT("mdc7")
	mdc7()
	SRMT("m800")
	m800()
	SRMT("m801")
	m801()
	SRMT("m802")
	m802()
	SRMT("m1dc")
	m1dc()
}
