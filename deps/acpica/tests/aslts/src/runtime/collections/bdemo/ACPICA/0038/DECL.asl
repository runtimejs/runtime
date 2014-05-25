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
 * Bug 0038:
 *
 * SUMMARY: LGreater passed with Integer and String works incorrectly in 32-bit mode
 */

Method(mdce,, Serialized)
{
	Store(0, Local7)

	// Show that (in 32-bit mode) "FdeAcb0132547698" passed to Name
	// operator is correctly implicitly converted to Integer 0xfdeacb01

	Name(n000, 0)
	Store("FdeAcb0132547698", n000)
	Store(n000, Debug)

	if (LNotEqual(n000, 0xfdeacb01)) {
		err("", zFFF, 0x000, 0, 0, n000, 0xfdeacb01)
	}

	// Show that LGreater operator indicates correctly
	// that 0x42345678 is greater than 0x32547698

	if (LGreater(0x42345678, 0x32547698)) {
		Store(1, Local7)
	} else {
		err("", zFFF, 0x001, 0, 0, 0x42345678, 0x32547698)
	}

	// Show that (in 32-bit mode) "FdeAcb0132547698" passed to Name operator
	// is implicitly converted to some Integer (0xfdeacb01) which is actually
	// treated by LGreater as being greater than 0x42345678

	if (LGreater(n000, 0x42345678)) {
		Store(1, Local7)
	} else {
		err("", zFFF, 0x002, 0, 0, n000, 0x42345678)
	}

	// Show that, nevertheless, (in 32-bit mode) "FdeAcb01Fdeacb03" passed
	// to LGreater operator is implicitly converted to some unexpected value
	// which is NOT equal to the expected correct 0xfdeacb01 value.

	if (LGreater(0xfdeacb02, "FdeAcb01Fdeacb03")) {
		Store(1, Local7)
	} else {
		err("", zFFF, 0x003, 0, 0, 0xfdeacb02, "FdeAcb01Fdeacb03")
	}

	return (Local7)
}
