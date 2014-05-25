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


Name(z066, 66)

// Verify result
//
// arg0 - name of test
// arg1 - results Package
// arg2 - index of four results
// arg3 - indication of Result
// arg4 - indication of ComputationalData
// arg5 - Result
// arg6 - ComputationalData
Method(m4c1, 7, Serialized)
{
	Name(tmp0, 0)
	Name(tmp1, 0)
	Name(lpC0, 0)

	Multiply(arg2, 4, lpC0)

	if (arg3) {

		// Result

		// Benchmark of Result
		Store(DeRefOf(Index(arg1, lpC0)), Local0)
		Increment(lpC0)
		Store(DeRefOf(Index(arg1, lpC0)), Local1)

		Store(ObjectType(arg5), tmp0)

		if (F64) {
			Store(ObjectType(Local0), tmp1)
			if (LNotEqual(tmp0, tmp1)) {
				err(arg0, z066, 0, 0, 0, tmp0, tmp1)
			} elseif (LNotEqual(arg5, Local0)) {
				err(arg0, z066, 1, 0, 0, arg5, Local0)
			}
		} else {
			Store(ObjectType(Local1), tmp1)
			if (LNotEqual(tmp0, tmp1)) {
				err(arg0, z066, 2, 0, 0, tmp0, tmp1)
			} elseif (LNotEqual(arg5, Local1)) {
				err(arg0, z066, 3, 0, 0, arg5, Local1)
			}
		}
	} else {
		Increment(lpC0)
	}

	if (arg4) {

		// ComputationalData

		// Benchmark of ComputationalData

		Increment(lpC0)
		Store(DeRefOf(Index(arg1, lpC0)), Local2)
		Increment(lpC0)
		Store(DeRefOf(Index(arg1, lpC0)), Local3)

		Store(ObjectType(arg6), tmp0)

		if (F64) {
			Store(ObjectType(Local2), tmp1)
			if (LNotEqual(tmp0, tmp1)) {
				err(arg0, z066, 4, 0, 0, tmp0, tmp1)
			} elseif (LNotEqual(arg6, Local2)) {
				err(arg0, z066, 5, 0, 0, arg6, Local2)
			}
		} else {
			Store(ObjectType(Local3), tmp1)
			if (LNotEqual(tmp0, tmp1)) {
				err(arg0, z066, 6, 0, 0, tmp0, tmp1)
			} elseif (LNotEqual(arg6, Local3)) {
				err(arg0, z066, 7, 0, 0, arg6, Local3)
			}
		}
	}
}
