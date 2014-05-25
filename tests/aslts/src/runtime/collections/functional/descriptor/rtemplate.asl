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
 * Resource Descriptor macros
 */

Name(z029, 29)
Name(lpN0, 0)
Name(lpC0, 0)

Method(m330, 5)	// ts, len, msg, op, res
{

	Store(arg1, lpN0)
	Store(0, lpC0)

	While(lpN0) {

		// Operand

		Store(DeRefOf(Index(arg3, lpC0)), Local0)

		// Expected result

		Store(DeRefOf(Index(arg4, lpC0)), Local1)

		if (LNotEqual(Local0, Local1)) {
			err(arg0, z029, 0, 0, 0, lpC0, arg2)
		}

		Decrement(lpN0)
		Increment(lpC0)
	}
	return (0)
}

Method(m331, 7)	// ts, grerr, val0, ver0, val1, ver1, msg
{
	if (LNotEqual(arg2, arg3)) {
		err(arg0, z029, arg1, arg6, arg6, arg2, arg3)
	}
	if (LNotEqual(arg4, arg5)) {
		err(arg0, z029, arg1, arg6, arg6, arg4, arg5)
	}
}

Method(m332, 6, Serialized)	// ts, len, msg, op1, op2, res
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(arg1, lpN0)
	Store(0, lpC0)

	While(lpN0) {

		// Operand 1

		Store(DeRefOf(Index(arg3, lpC0)), Local0)

		// Operand 2

		Store(DeRefOf(Index(arg4, lpC0)), Local1)

		// Expected result

		Store(DeRefOf(Index(arg5, lpC0)), Local2)

		Store(ConcatenateResTemplate(Local0, Local1), Local3)


		if (LNotEqual(Local3, Local2)) {
			Store(Local3, Debug)
			Store(Local2, Debug)
			err(arg0, z029, 3, 0, 0, lpC0, arg2)
		}

		Decrement(lpN0)
		Increment(lpC0)
	}
	return (0)
}

// components/utilities/utmisc.c AcpiUtGenerateChecksum() analog
Method(m335, 2, Serialized)	// buf, len
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(0, Local0) // sum

	Store(arg1, lpN0)
	Store(0, lpC0)

	While(lpN0) {
		Store(DeRefOf(Index(arg0, lpC0)), Local1)
		Add(Local0, Local1, Local0)
		Mod(Local0, 0x100, Local0)
		Decrement(lpN0)
		Increment(lpC0)
	}

	Subtract(0, Local0, Local0)
	Mod(Local0, 0x100, Local0)

	Store("checksum", Debug)
	Store(Local0, Debug)

	return (Local0)
}

// Updates the last byte of each buffer in package with checksum
Method(m334, 2, Serialized)	// pkg, len
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(arg1, lpN0)
	Store(0, lpC0)

	While(lpN0) {

		Store(DeRefOf(Index(arg0, lpC0)), Local1)
		Store(SizeOf(Local1), Local2)

		if (Local2) {
			Decrement(Local2)
			Store(m335(Local1, Local2), Local3)
			Store(Local3, Index(Local1, Local2))
			Store(Local1, Index(arg0, lpC0))
		}

		Decrement(lpN0)
		Increment(lpC0)
	}

	return (0)
}
