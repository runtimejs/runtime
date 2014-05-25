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
 * Bug 300:
 *
 * SUMMARY: Recursive calls to methods with the internal declarations (and Switches) should be provided
 */

Method(m1e9)
{
	Method(m000,, Serialized)
	{
		Name(i000, 0)
		Name(max0, 10)

		Store(max0, i000)

		Method(m100, 1)
		{
			/*
			 * Method m100 contains internal declarations and Switch and
			 * is invoked recursively but no exceptions should be there,
			 * and the proper execution provided.
			 */
			Name(ii00, 0)
			Name(ii01, 0)
			Name(ii02, 0)
			Name(ii03, 0)

			Store(arg0, ii00)
			Store(0, ii01)
			Store(0, ii02)
			Store(0, ii03)
			Store(arg0, Local5)

			Concatenate("================== i000: ", i000, Debug)

			Decrement(i000)

			Switch (i000) {
				Case (0) {
					Store("No more recursive calls", Debug)
				}
				Default {
					m100(i000)
				}
			}

			if (LNotEqual(arg0, ii00)) {
				err("", zFFF, 0x000, 0, 0, arg0, ii00)
			}
			if (LNotEqual(arg0, Local5)) {
				err("", zFFF, 0x001, 0, 0, arg0, Local5)
			}
		}
		m100(0)
	}

	CH03("", 0, 0x002, 0, 0)
	m000()
	CH03("", 0, 0x003, 0, 0)
}


