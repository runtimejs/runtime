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
 * Bug 0097:
 *
 * SUMMARY: Crash on ObjectType passed with IRef to Method which is an element of Package
 */

	Method(me4c) {
		return (0)
	}

	Method(me4d, 1)
	{
		Store("============= Run ObjectType:", Debug)
		Store(ObjectType(arg0), Local0)
		Store("============= Print result of ObjectType:", Debug)
		Store(Local0, Debug)
	}

	Method(me4e,, Serialized)
	{

		Name(p000, Package(32) {1,2,me4c,3,4})

		Store("============= Test me4e started:", Debug)

		Store(Index(p000, 2, Local1), Local0)
		me4d(Local1)

		Store("============= Test me4e finished.", Debug)
	}

	Method(me4f,, Serialized)
	{

		Name(p000, Package(32) {1,2,me4c,3,4})

		Store("============= Test me4f started:", Debug)

		Store(Index(p000, 2, Local1), Local0)
		me4d(Local0)

		Store("============= Test me4f finished.", Debug)
	}

	Method(me50)
	{
		me4e()
		me4f()
	}
