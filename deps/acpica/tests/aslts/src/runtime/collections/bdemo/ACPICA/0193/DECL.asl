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
 * Bug 193 (local-bugzilla-354):
 *
 * SUMMARY: storing opt. results of Not/NAnd/NOr into Buffer Field in 32-bit mode can soil the higher bits of BF
 *
 * In 32-bit mode optional storing of the result of any of
 * Not, NAnd, and NOr ASL operators to Buffer Field of more
 * than 4 bytes in length can produce non-zero bits outside
 * the first 32 bits (though zeros are expected):
 */

Method(mfa5, 1, Serialized)
{
	// Source Named Object
	Name(SRC0, 0xfedcba9876543210)

	// Target Buffer Field Object
	Createfield(bd0f, 0, 69, BFL1)

	// Explicit storing
	Store(0, BFL1)
	if (LEqual(arg0, 0)) {
		Store(Not(SRC0), BFL1)
	} elseif (LEqual(arg0, 1)) {
		Store(NAnd(SRC0, Ones), BFL1)
	} elseif (LEqual(arg0, 2)) {
		Store(NOr(SRC0, Zero), BFL1)
	}
	if (LEqual(BFL1, bd10)) {
		Store("Ok 1", Debug)
	} else {
		err("", zFFF, 0x000, 0, 0, BFL1, bd10)
	}

	// Optional storing
	Store(0, BFL1)
	if (LEqual(arg0, 0)) {
		Not(SRC0, BFL1)
	} elseif (LEqual(arg0, 1)) {
		NAnd(SRC0, Ones, BFL1)
	} elseif (LEqual(arg0, 2)) {
		NOr(SRC0, Zero, BFL1)
	}
	if (LEqual(BFL1, bd10)) {
		Store("Ok 2", Debug)
	} else {
		err("", zFFF, 0x001, 0, 0, BFL1, bd10)
	}
}

Method(mfa6)
{
	Store(Not(0xfedcba9876543210), bd10)

	Store("Not operator", Debug)
	mfa5(0)

	Store("NAnd operator", Debug)
	mfa5(1)

	Store("NOr operator", Debug)
	mfa5(1)
}
