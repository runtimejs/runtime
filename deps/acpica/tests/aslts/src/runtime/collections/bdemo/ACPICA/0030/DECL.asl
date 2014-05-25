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
 * Bug 0030:
 *
 * SUMMARY: Crash of ObjectType for the particular Fields
 *
 * Crash. Test remained as is (due to crash as a main symptom).
 */

Method(mdc3,, Serialized)
{
	// Field Unit
	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	Field(r000, ByteAcc, NoLock, Preserve) {
		f000, 8,
		f001, 16,
		f002, 32,
		f003, 33,
		f004, 1,
		f005, 64,
	}

	Store("------------ Fields:", Debug)
	Store(f000, Debug)
	Store(f001, Debug)
	Store(f002, Debug)
	Store(f003, Debug)
	Store(f004, Debug)
	Store(f005, Debug)
	Store("------------.", Debug)

	return (0)
}

Method(mdc4,, Serialized)
{
	// Field Unit
	OperationRegion(r000, SystemMemory, 0x100, 0x100)
	Field(r000, ByteAcc, NoLock, Preserve) {
		f000, 8,
		f001, 16,
		f002, 32,
		f003, 33,
		f004, 7,
		f005, 64,
	}

	Store("------------ Fields:", Debug)
	Store(f000, Debug)
	Store(f001, Debug)
	Store(f002, Debug)
	Store(f003, Debug)
	Store(f004, Debug)
	Store(f005, Debug)
	Store("------------.", Debug)

	return (0)
}

Method(mdc5)
{
	mdc3()
	mdc4()

	return (0)
}
