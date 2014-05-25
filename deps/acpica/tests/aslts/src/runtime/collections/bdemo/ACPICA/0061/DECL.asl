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
 * Bug 0061:
 *
 * SUMMARY: Crash on Store the OperationRegion result returned by Method
 *
 * Methods return the object of type OperationRegion
 * and just this causes the problems.
 */

Method(m206, 2)
{
	if (SLCK) {
		CH03("", 0, arg0, 0, 0)
	} else {
		CH04("", 0, 47, 0, arg1, 0, 0)
	}
}

Method(me02)
{
	Store(0, Local0)

	// Store directly a region should not be allowed.

	CH03("", 0, 0x000, 0, 0)
	Store(rd01, Local7)
	m206(0x001, 0x002)
	return (Local0)
}

Method(me03)
{
	Store("============= Start of test", Debug)
	Store(me02(), Local0)
	Store("============= Finish of test", Debug)
}

Method(me04)
{
	Store(0, Local0)

	// Store directly a region should not be allowed.

	CH03("", 0, 0x003, 0, 0)
	Store(rd02, Local7)
	m206(0x004, 0x005)
	return (Local0)
}

Method(me05)
{
	Store("me05, point 0", Debug)
	Store(me04(), Local0)

	Store("me05, point 1", Debug)
	Store(me04(), Local1)

	Store("me05, point 2", Debug)
}

Method(me06)
{
	Store("============= me05 0", Debug)
	me05()
	Store("============= me05 1", Debug)
	me05()
	Store("============= me05 2", Debug)
	me05()

	// The message below doesn't appear

	Store("============= me05 3", Debug)

	Store(1, id09)
}

Method(me07)
{
	Store(0, id09)

	me03()
	me06()
	if (LNotEqual(id09, 1)) {
		err("", zFFF, 0x002, 0, 0, id09, 1)
	}
}
