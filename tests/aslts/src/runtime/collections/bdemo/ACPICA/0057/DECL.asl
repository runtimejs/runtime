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
 * Bug 0057:
 *
 * SUMMARY: The standalone Return is processed incorrectly
 */

Method(mdef) {
	Store("mdef", Debug)
}

Method(mdf0) {
	Store("mdf0", Debug)
}

Method(mdf1) {
	Store("mdf1", Debug)
}

Method(mdf2, 1) {
	Store("mdf2", Debug)

	mdef()

	if (arg0) {
		Store("mdf2: before Return", Debug)
		return (0x1234)

		// ASL-compiler report Warning in this case
		// Store("ERROR 0: mdf2, after Return !!!", Debug)
	}

	err("", zFFF, 0x000, 0, 0, 0, 0)

	mdf0()
	mdf1()

	return (0x5678)
}

Method(mdf3, 1) {
	Store("mdf3", Debug)

	mdef()

	if (arg0) {

		Store("mdf3: before Return", Debug)

		return

		// ASL-compiler DOESN'T report Warning in this case!!!
		// And the Store operator below is actually processed!!!

		err("", zFFF, 0x001, 0, 0, 0, 0)
	}

	err("", zFFF, 0x002, 0, 0, 0, 0)

	mdf0()
	mdf1()

	return
}

Method(mdf4) {
	Store(mdf2(1), Local7)
	Store(Local7, Debug)
	mdf3(1)
}

