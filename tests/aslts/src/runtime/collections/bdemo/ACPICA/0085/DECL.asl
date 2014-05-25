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
 * Bug 0085:
 *
 * SUMMARY: Exception on DeRefOf operator applied to IRef to Uninitialized element of Package
 */

	// Uninitialized element of Package

	Method(me37,, Serialized)
	{
		// Ref #1

		Name(p000, Package(1){})


		Store(DeRefOf(Index(p000, 0)), Local1)


		Index(p000, 0, Local0)
		Store(Local0, Debug)
		Store(DeRefOf(Local0), Local1)


		Index(p000, 0, Local0)
		Store(Local0, Debug)
	}

	// Reference to Uninitialized Local

	Method(me38, 1)
	{
		if (1) {

			// Ref #2

			Store(arg0, Debug)
			Store(DeRefOf(arg0), Local1)
			CH04("", 2 , 62, 1, 0, 0 ,0)
		} else {
			Increment(DeRefOf(arg0))
		}
	}

	Method(me39, 1)
	{
		if (arg0) {
			Store(0, Local0)
		}
		me38(RefOf(Local0))
	}

	Method(me3a)
	{
		me37()
		me39(0)
	}
