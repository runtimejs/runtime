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
 * Bug 262:
 *
 * SUMMARY: Unexpected AE_STACK_OVERFLOW for a method call expression with nested calls
 */

Method(m027,, Serialized)
{
	Name(iad1, 0x1)
	Name(iad2, 0x10)
	Name(iad3, 0x100)
	Name(iad4, 0x1000)
	Name(iad5, 0x10000)
	Name(iad6, 0x100000)
	Name(iad7, 0x1000000)

	Method(mad1, 1) {Return(Arg0)}
	Method(mad7, 7) {Return(Add(Add(Add(Add(Add(Add(Arg0, Arg1), Arg2), Arg3), Arg4), Arg5), Arg6))}

	Method(m000)
	{
		Store(mad7(mad1(iad1), mad1(iad2), mad1(iad3), mad1(iad4), mad1(iad5), mad1(iad6),
			mad7(mad1(iad1), mad1(iad2), mad1(iad3), mad1(iad4), mad1(iad5), mad1(iad6),
			mad7(mad1(iad1), mad1(iad2), mad1(iad3), mad1(iad4), mad1(iad5), mad1(iad6),
			mad7(mad1(iad1), mad1(iad2), mad1(iad3), mad1(iad4), mad1(iad5), mad1(iad6),
			mad7(mad1(iad1), mad1(iad2), mad1(iad3), mad1(iad4), mad1(iad5), mad1(iad6),
			mad7(mad1(iad1), mad1(iad2), mad1(iad3), mad1(iad4), mad1(iad5), mad1(iad6),
			mad7(mad1(iad1), mad1(iad2), mad1(iad3), mad1(iad4), mad1(iad5), mad1(iad6),
			mad1(iad7)))))))), Local0)

		Store (Local0, Debug)

		if (LNotEqual(Local0, 0x1777777)) {
			err("", zFFF, 0x000, 0, 0, Local0, 0x1777777)
		}
	}

	CH03("", 0, 0x001, 0, 0)
	m000()
	CH03("", 0, 0x002, 0, 0)
}

