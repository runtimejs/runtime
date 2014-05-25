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
 * Bug 66: CANCELED
 *
 * SUMMARY: FieldUnit type object should be passed to Methods without any conversion (to Buffer or Integer)
 *
 * EXAMPLES:
 *
 * ROOT CAUSE:
 *
 * SEE ALSO:     bugs 65,66,67,68,118
 */


Method(md81, 1)
{
	// ObjectType of the value passed to Method
	// (FieldUnit is converted to Integer).
	Store(ObjectType(arg0), Local0)
	if (LNotEqual(Local0, c009)) {
		err("", zFFF, 0x000, 0, 0, Local0, c009)
	}
}

Method(md82, 1)
{
	// ObjectType of the value passed to Method
	// (FieldUnit is converted to Buffer).
	Store(ObjectType(arg0), Local0)
	if (LNotEqual(Local0, c00b)) {
		err("", zFFF, 0x001, 0, 0, Local0, c00b)
	}
}

Method(md83)
{
	// ObjectType of the FieldUnit immediately

	Store(ObjectType(fd00), Local0)
	if (LNotEqual(Local0, c00d)) {
		err("", zFFF, 0x002, 0, 0, Local0, c00d)
	}

	Store(ObjectType(fd01), Local0)
	if (LNotEqual(Local0, c00d)) {
		err("", zFFF, 0x003, 0, 0, Local0, c00d)
	}

	md81(fd00)
	md82(fd01)
}
