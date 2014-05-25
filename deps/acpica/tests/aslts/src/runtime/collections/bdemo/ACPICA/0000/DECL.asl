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
 * Bug 0000:
 *
 * SUMMARY: Logical operators return True equal to One but not Ones
 */

Method(md9a,, Serialized)
{
	Name(ON00, 0xffffffffffffffff)

	/*
	 * Additional checking to prevent errors unrelated to this test.
	 *
	 * Check that exceptions initiated by some bdemo tests on the
	 * global level are all actually handled and reset at this point.
	 */
	CH03("", 0, 0x999, 0, 0)

	Store(LAnd(1, 1), Local0)
	if (LNotEqual(Local0, ON00)) {
		err("", zFFF, 0x000, 0, 0, Local0, ON00)
	}

	Store(LEqual(0, 0), Local0)
	if (LNotEqual(Local0, ON00)) {
		err("", zFFF, 0x001, 0, 0, Local0, ON00)
	}

	Store(LGreater(1, 0), Local0)
	if (LNotEqual(Local0, ON00)) {
		err("", zFFF, 0x002, 0, 0, Local0, ON00)
	}

	Store(LGreaterEqual(1, 1), Local0)
	if (LNotEqual(Local0, ON00)) {
		err("", zFFF, 0x003, 0, 0, Local0, ON00)
	}

	Store(LLess(0, 1), Local0)
	if (LNotEqual(Local0, ON00)) {
		err("", zFFF, 0x004, 0, 0, Local0, ON00)
	}

	Store(LLessEqual(1, 1), Local0)
	if (LNotEqual(Local0, ON00)) {
		err("", zFFF, 0x005, 0, 0, Local0, ON00)
	}

	Store(LNot(0), Local0)
	if (LNotEqual(Local0, ON00)) {
		err("", zFFF, 0x006, 0, 0, Local0, ON00)
	}

	Store(LNotEqual(1, 0), Local0)
	if (LNotEqual(Local0, ON00)) {
		err("", zFFF, 0x007, 0, 0, Local0, ON00)
	}

	Store(LOr(0, 1), Local0)
	if (LNotEqual(Local0, ON00)) {
		err("", zFFF, 0x008, 0, 0, Local0, ON00)
	}
}
