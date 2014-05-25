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
 * Bug 281:
 *
 * SUMMARY: Normal strings as the LoadTable parameters can cause
 *          the matching table to be not found
 */

Device (D281) {

	Name(SOID, "Intel ")
	Name(STID, "Many    ")

	Name(PLDT, 0)

	Method(TST0,, Serialized)
	{
		Name(DDB0, 0)
		Name(DDB1, 0)

		// Unhappy case: space-ended strings

		Store(0, PLDT)

		Store(LoadTable("OEM1", SOID, STID, "\\", "\\D281.PLDT", 1), DDB0)

		if (LNotEqual(PLDT, 0)) {
			Store(PLDT, Debug)
			err("", zFFF, 0x000, 0, 0, PLDT, 0)
			return (1)
		}

		if (CondRefof(\_XT2, Local0)) {
			err("", zFFF, 0x001, 0, 0, "\\_XT2", 1)
		}

		// Successful case: spaces is replaced with zeroes

		Store(0, PLDT)

		Store(0, Index(SOID, 5))

		Store(0, Index(STID, 4))
		Store(0, Index(STID, 5))
		Store(0, Index(STID, 6))
		Store(0, Index(STID, 7))

		Store(LoadTable("OEM1", SOID, STID, "\\", "\\D281.PLDT", 1), DDB0)

		if (LNotEqual(PLDT, 1)) {
			Store(PLDT, Debug)
			err("", zFFF, 0x003, 0, 0, PLDT, 1)
			return (1)
		}
		Store("OEM1 loaded", Debug)

		if (CondRefof(\_XT2, Local0)) {
		} else {
			err("", zFFF, 0x004, 0, 0, "\\_XT2", 0)
		}

		UnLoad(DDB0)
		Store("OEM1 unloaded", Debug)

		if (CondRefof(\_XT2, Local0)) {
			err("", zFFF, 0x005, 0, 0, "\\_XT2", 1)
		}

		// Unhappy case: normal strings

		Store(0, PLDT)

		Store(LoadTable("OEM1", "Intel", "Many", "\\", "\\D281.PLDT", 1), DDB1)

		if (LNotEqual(PLDT, 1)) {
			Store(PLDT, Debug)
			err("", zFFF, 0x007, 0, 0, PLDT, 1)
			return (1)
		}
		Store("OEM1 loaded", Debug)

		if (CondRefof(\_XT2, Local0)) {
		} else {
			err("", zFFF, 0x008, 0, 0, "\\_XT2", 0)
		}

		UnLoad(DDB1)
		Store("OEM1 unloaded", Debug)

		if (CondRefof(\_XT2, Local0)) {
			err("", zFFF, 0x009, 0, 0, "\\_XT2", 1)
		}

		return (0)
	}
}

Method(m281)
{
	\D281.TST0()
}
