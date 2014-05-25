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
 * Methods applied to the Standard Data
 */

Name(z115, 115)

// Check original values

// arg0 - test name
// arg1 - Integer, original object
// arg2 - absolute index of file initiating the checking
// arg3 - index of checking (inside the file)
Method(m380, 4)
{
	Store(ObjectType(arg1), Local0)

	if (LNotEqual(Local0, c009)) {
		err(arg0, z115, 0, arg2, arg3, Local0, c009)
	} elseif (LNotEqual(arg1, 0x77)) {
		err(arg0, z115, 1, arg2, arg3, arg1, 0x77)
	}
}

// arg0 - test name
// arg1 - String, original object
// arg2 - absolute index of file initiating the checking
// arg3 - index of checking (inside the file)
Method(m381, 4)
{
	Store(ObjectType(arg1), Local0)

	if (LNotEqual(Local0, c00a)) {
		err(arg0, z115, 2, arg2, arg3, Local0, c00a)
	} elseif (LNotEqual(arg1, "qwer0000")) {
		err(arg0, z115, 3, arg2, arg3, arg1, "qwer0000")
	}
}

// arg0 - test name
// arg1 - Buffer, original object
// arg2 - absolute index of file initiating the checking
// arg3 - index of checking (inside the file)
Method(m382, 4)
{
	Store(ObjectType(arg1), Local0)

	if (LNotEqual(Local0, c00b)) {
		err(arg0, z115, 4, arg2, arg3, Local0, c00b)
	} elseif (LNotEqual(arg1, Buffer(4) {1,0x77,3,4})) {
		err(arg0, z115, 5, arg2, arg3, arg1, Buffer(4) {1,0x77,3,4})
	}
}

// arg0 - test name
// arg1 - Package, original object
// arg2 - absolute index of file initiating the checking
// arg3 - index of checking (inside the file)
Method(m383, 4)
{
	Store(ObjectType(arg1), Local0)

	if (LNotEqual(Local0, c00c)) {
		err(arg0, z115, 6, arg2, arg3, Local0, c00c)
	} else {
		Index(arg1, 0, Local0)
		Store(DerefOf(Local0), Local1)
		if (LNotEqual(Local1, 5)) {
			err(arg0, z115, 7, arg2, arg3, Local1, 5)
		}

		Index(arg1, 1, Local0)
		Store(DerefOf(Local0), Local1)
		if (LNotEqual(Local1, 0x77)) {
			err(arg0, z115, 8, arg2, arg3, Local1, 0x77)
		}

		Index(arg1, 2, Local0)
		Store(DerefOf(Local0), Local1)
		if (LNotEqual(Local1, 7)) {
			err(arg0, z115, 9, arg2, arg3, Local1, 7)
		}
	}
}

// Check result of writing

// arg0 - test name
// arg1 - Integer, original object
// arg2 - absolute index of file initiating the checking
// arg3 - index of checking (inside the file)
Method(m384, 4)
{
	Store(ObjectType(arg1), Local0)

	if (LNotEqual(Local0, c009)) {
		err(arg0, z115, 10, arg2, arg3, Local0, c009)
	} elseif (LNotEqual(arg1, 0x2b)) {
		err(arg0, z115, 11, arg2, arg3, arg1, 0x2b)
	}
}

// arg0 - test name
// arg1 - String, original object
// arg2 - absolute index of file initiating the checking
// arg3 - index of checking (inside the file)
Method(m385, 4)
{
	Store(ObjectType(arg1), Local0)

	if (LNotEqual(Local0, c00a)) {
		err(arg0, z115, 12, arg2, arg3, Local0, c00a)
	} elseif (LNotEqual(arg1, "q+er0000")) {
		err(arg0, z115, 13, arg2, arg3, arg1, "q+er0000")
	}
}

// arg0 - test name
// arg1 - Buffer, original object
// arg2 - absolute index of file initiating the checking
// arg3 - index of checking (inside the file)
Method(m386, 4)
{
	Store(ObjectType(arg1), Local0)

	if (LNotEqual(Local0, c00b)) {
		err(arg0, z115, 14, arg2, arg3, Local0, c00b)
	} elseif (LNotEqual(arg1, Buffer(4) {1,0x2b,3,4})) {
		err(arg0, z115, 15, arg2, arg3, arg1, Buffer(4) {1,0x2b,3,4})
	}
}

// arg0 - test name
// arg1 - Package, original object
// arg2 - absolute index of file initiating the checking
// arg3 - index of checking (inside the file)
Method(m387, 4)
{
	Store(ObjectType(arg1), Local0)

	if (LNotEqual(Local0, c00c)) {
		err(arg0, z115, 16, arg2, arg3, Local0, c00c)
	} else {
		Index(arg1, 0, Local0)
		Store(DerefOf(Local0), Local1)
		if (LNotEqual(Local1, 5)) {
			err(arg0, z115, 17, arg2, arg3, Local1, 5)
		}

		Index(arg1, 1, Local0)
		Store(DerefOf(Local0), Local1)
		if (LNotEqual(Local1, 0x2b)) {
			err(arg0, z115, 18, arg2, arg3, Local1, 0x2b)
		}

		Index(arg1, 2, Local0)
		Store(DerefOf(Local0), Local1)
		if (LNotEqual(Local1, 7)) {
			err(arg0, z115, 19, arg2, arg3, Local1, 7)
		}
	}
}

// arg0 - original object
// arg1 - type of it
// arg2 - absolute index of file initiating the checking
// arg3 - index of checking (inside the file)
Method(m390, 4, Serialized)
{
	Name(ts, "m390")

	if (LEqual(arg1, c009)) {
		m380(ts, arg0, arg2, arg3)
	} elseif (LEqual(arg1, c00a)) {
		m381(ts, arg0, arg2, arg3)
	} elseif (LEqual(arg1, c00b)) {
		m382(ts, arg0, arg2, arg3)
	} elseif (LEqual(arg1, c00c)) {
		m383(ts, arg0, arg2, arg3)
	}
}

// arg0 - original object
// arg1 - type of it
// arg2 - absolute index of file initiating the checking
// arg3 - index of checking (inside the file)
Method(m391, 4, Serialized)
{
	Name(ts, "m391")

	if (LEqual(arg1, c009)) {
		m384(ts, arg0, arg2, arg3)
	} elseif (LEqual(arg1, c00a)) {
		m385(ts, arg0, arg2, arg3)
	} elseif (LEqual(arg1, c00b)) {
		m386(ts, arg0, arg2, arg3)
	} elseif (LEqual(arg1, c00c)) {
		m387(ts, arg0, arg2, arg3)
	}
}

