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
 * Check operators under the known critical conditions
 *
 * Collection of the tests which exersice the operators under the
 * known conditions. If some operator was observed failing under some
 * conditions, do the similar checkings for other operators under the
 * similar conditions too.
 */

Name(z055, 55)

// Meaningless zero valued parameter

Method(m130, 1, Serialized)
{
	Name(B000, Buffer(2) {0x21, 0x21})

	Store(0, Local0)

	Store(ToString(B000, Local0), Local2)

	if (LNotequal(Local0, 0)) {
		err(arg0, z055, 0, 0, 0, Local0, 0)
	}

	CH03(arg0, z055, 1, 0, 0)
}

// Store-like actions affect the source objects passed as parameter

Method(m131, 1)
{
	Decrement(arg0)
	// Store(9, arg0)
}

// Operator updates the source object passed to method directly,
// NOT as a reference to it.
Method(m132, 1)
{
	Store(10, Local0)
	m131(Local0)
	if (LNotEqual(Local0, 10)){
		err(arg0, z055, 2, 0, 0, Local0, 10)
	}

	CH03(arg0, z055, 3, 0, 0)
}

// Operator doesn't update the source object passed to method as a REFERENCE
// to the object.
Method(m133, 1)
{
	Store(10, Local0)
	Store(RefOf(Local0), Local1)
	m131(Local1)
	if (LNotEqual(Local0, 9)){
		err(arg0, z055, 4, 0, 0, Local0, 9)
	}

	CH03(arg0, z055, 5, 0, 0)
}

Method(m134, 1)
{
	Store(10, Local0)
	m131(RefOf(Local0))
	if (LNotEqual(Local0, 9)){
		err(arg0, z055, 6, 0, 0, Local0, 9)
	}

	CH03(arg0, z055, 7, 0, 0)
}

Method(m135, 1)
{
	Store(5, arg0)
}

Method(m136, 1)
{
	Store(10, Local0)
	m135(RefOf(Local0))
	if (LNotEqual(Local0, 5)){
		err(arg0, z055, 8, 0, 0, Local0, 5)
	}

	CH03(arg0, z055, 9, 0, 0)
}

// Run-method
Method(PRV0,, Serialized)
{
	Name(ts, "PRV0")

	SRMT("m130")
	m130(ts)
	SRMT("m132")
	m132(ts)
	SRMT("m133")
	m133(ts)
	SRMT("m134")
	m134(ts)
	SRMT("m136")
	m136(ts)
}
