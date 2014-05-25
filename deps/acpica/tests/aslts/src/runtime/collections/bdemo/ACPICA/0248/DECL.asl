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
 * Bug 248:
 *
 * SUMMARY: Incorrect ReferenceCount on Switch operation
 */

Method(m02d)
{
	/*
	 * NoOp -
	 * all them are for tracking only - to simplify debugging
	 */

	Method(m003, 1, Serialized)
	{
		NoOp

		Switch (ToInteger (arg0)) {
			Case (0) {
				Store("m003", debug)
			}
		}

		NoOp
	}

	Method(m004, 1)
	{
		NoOp

		if (arg0) {
			Store("m004", debug)
		}

		NoOp
	}

	Method(m1a8, 2)
	{
		if (arg1) {
			m003(arg0)
		} else {
			m004(arg0)
		}
	}

	Method(m1a9,, Serialized)
	{
		Name(sw00, 1)
		Name(hg00, 0) // if non-zero - the test hangs

		Name(p91e, Package() {0xabcd0000})

		if (1) {
			Store(Index(p91e, 0, Local1), Local0)
		} else {
			Store(0xabcd0000, Local0)
			Store(0xabcd0001, Local1)
		}

		if (LNotEqual(DerefOf(Local0), 0xabcd0000)) {
			err("", zFFF, 0x000, 0, 0, DerefOf(Local0), 0xabcd0000)
		}

		Store("============== sit 0 (Local0):", debug)
		m1a8(Local0, sw00)

		/*
		 * At this point, after returning from m1a8
		 * for the non-zero sw00, the object attached
		 * to Local0 has been deleted. It is the essence
		 * of the bug.
		 */

		if (hg00) {

			/*
			 * To show visually the consequences of the anomaly
			 * run this code. It causes hang.
			 */

			Store("============== sit 1 (Local1):", debug)
			m1a8(Local1, sw00)

			Store("============== sit 2:", debug)

			Store(ObjectType(Local0), Local7)
			Store(Local7, debug)

			Store(ObjectType(Local1), Local7)
			Store(Local7, debug)

			Store(Local0, debug)
			Store(Local1, debug)
		}

		Store("============== before checking:", debug)

		if (LNotEqual(DerefOf(Local0), 0xabcd0000)) {
			err("", zFFF, 0x001, 0, 0, DerefOf(Local0), 0xabcd0000)
		}

		Store("============== end of test", debug)
	}

	Method(mm00) {
		m1a9()
	}

	CH03("", 0, 0x002, 0, 0)
	mm00()

	/* Check opcode of the last exception */
	CH04("", 2, 47, 0, 0x003, 0, 0) // AE_AML_OPERAND_TYPE
}

/*
 * It is Functional:Reference:ref07.asl:Method(m1d5)
 */
Method(m03d,, Serialized)
{
	Name(i001, 0)
	Name(p000, Package(2) {0x77, 0x88})

	Name(sw00, 1)

	Name(hg00, 1) // if non-zero - the test hangs
	Name(hg01, 1) // if non-zero - the test hangs
	Name(hg02, 1) // if non-zero - the test hangs

	CH03("", 0, 184, 0, 0)

	CopyObject(Index(p000, 1, Local0), i001)

	CH03("", 0, 185, 0, 0)

	// Type of i001 should be already IRef here,
	// so, don't expect exception.

	Store(Index(p000, 0, Local0), i001)

	CH03("", 0, 186, 0, 0)

	Add(Local0, 1, Local7)

	if (y248) {
		Store(1, hg00)
		Store(1, hg01)
		Store(1, hg02)
	}

	/*
	 * To show visually the consequences of the anomaly
	 * run one of code below. They cause hang.
	 */
	if (hg00) {
		// Infinite loop of printing
		Store(0, Local1)
		Store(Local0, debug)
	}
	if (hg01) {
		// Infinite loop of printing
		Store(Local0, debug)
		Store(Local0, debug)
	}
	if (hg02) {
		Store(0, Local1)

		Store("============== sit 2:", debug)

		Store(ObjectType(Local0), Local7)
		Store(Local7, debug)
	}

	CH04("", 0, 0xff, 0, 187, 0, 0)

	Add(i001, 1, Local7)

	CH04("", 0, 0xff, 0, 188, 0, 0)

	/*
	 * Looks identical to b248: "Incorrect ReferenceCount on Switch operation"
	 * (though there is no Switch operation)
	 *
	 * Reference count of Local0 is mistakenly zeroed there too.
	 *
	 * [ACPI Debug]  String: [0x0F] "<-------- 0000>"
	 * [ACPI Debug]  Reference: [Debug]
	 * [ACPI Debug]  String: [0x0F] "<-------- 1111>"
	 *
	 * [ACPI Debug]  String: [0x0F] "<-------- 0000>"
	 * [ACPI Debug]  [ACPI Debug]  String: [0x0F] "<-------- 1111>"
	 */
	Store("<-------- 0000>", debug)
	Store(Local0, debug)
	Store("<-------- 1111>", debug)
}
