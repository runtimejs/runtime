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
 * Bug 0087:
 *
 * SUMMARY: Exception on Switch operator applied to the result of ToBuffer operator
 */

	Method(me3c, 0, Serialized)
	{
		Name(b000, Buffer(1){10})
		Name(s000, "qwrtyuiop")

		if (1) {

			// This code shows that ToBuffer() works correctly

			Store("======================: ToBuffer(Buffer)", Debug)
			Store(ToBuffer(b000), Local0)
			Store(Local0, Debug)
			Store(ObjectType(Local0), Local1)
			Store(Local1, Debug)
			Store(SizeOf(Local0), Local2)
			Store(Local2, Debug)
			Store("======================: ToBuffer(String)", Debug)
			Store(ToBuffer(s000), Local0)
			Store(Local0, Debug)
			Store(ObjectType(Local0), Local1)
			Store(Local1, Debug)
			Store(SizeOf(Local0), Local2)
			Store(Local2, Debug)
			Store("======================.", Debug)
		}

		// This code shows that ToBuffer() causes exceptions in cases #2, #3

//		if (0) {

			// Case 1

			Switch (Buffer(1){10}) {
				Case ("N") {
					Store("Case     (A)", Debug)
				}
				Default {
					Store("Default  (A)", Debug)
				}
			}
//		} elseif (1) {

			// Case 2

			Switch (ToBuffer(Buffer(1){10})) {
				Case ("N") {
					Store("Case     (B)", Debug)
				}
				Default {
					Store("Default  (B)", Debug)
				}
			}

//		} else {

			// Case 3

			Switch (ToBuffer(b000)) {
				Case ("N") {
					Store("Case     (C)", Debug)
				}
				Default {
					Store("Default  (C)", Debug)
				}
			}
//		}
	}
