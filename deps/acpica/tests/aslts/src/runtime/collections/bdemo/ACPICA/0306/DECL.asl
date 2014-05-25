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
 * Bug 306:
 *
 * SUMMARY: Complex indirect storing to a LocalX violates the Writing to LocalX Rule
 */


Method(mff3)
{
	Method(m000, 1)
	{
		Store(0x12345678, arg0)
		Store("87654321", arg0)
	}

	CH03("", 0, 0x000, 0, 0)

	Store(0x12345678, Local0)
	Store("87654321", Local0)

	if (LNotEqual(ObjectType(Local0), 2)) {
		err("", zFFF, 0x001, 0, 0, ObjectType(Local0), 2)
	}

	m000(Refof(Local1))

	if (LNotEqual(ObjectType(Local1), 2)) {
		err("", zFFF, 0x002, 0, 0, ObjectType(Local1), 2)
	}

	Store(Refof(Local2), Local3)
	Store(Refof(Local3), Local4)

	Store(0x12345678, DeRefof(Local4))
	Store("87654321", DeRefof(Local4))

	if (LNotEqual(ObjectType(Local2), 2)) {
		err("", zFFF, 0x003, 0, 0, ObjectType(Local2), 2)
	}

	CH03("", 0, 0x004, 0, 0)
}
