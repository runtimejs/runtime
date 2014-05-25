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
 * Bug 182:
 *
 * SUMMARY: Exception on a specific declarations of objects of the same name
 *
 *          (no exception is expected here because id23 has already
 *          been defined at the first use of it).
 */

Name(id23, 0xabcd0000)

Method (mf78,, Serialized)
{
	CH03("", 0, 0x000, 0, 0)

	if (LNotEqual(id23, 0xabcd0000)) {
		err("", zFFF, 0x001, 0, 0, id23, 0xabcd0000)
	}

	Name (id23, 0xabcd0001)

	if (LNotEqual(id23, 0xabcd0001)) {
		err("", zFFF, 0x002, 0, 0, id23, 0xabcd0001)
	}

	CH03("", 0, 0x003, 0, 0)
}

/*
 * ATTENTION: i9z8 should be unique in the namespace,
 *            not declared somewhere else in the NS tree.
 */
Method (mf85,, Serialized)
{
	CH03("", 0, 0x004, 0, 0)

	if (LNotEqual(i9z8, 0xabcd0001)) {
		err("", zFFF, 0x005, 0, 0, i9z8, 0xabcd0001)
	}

	Name (i9z8, 0xabcd0001)

	CH04("", 0, 0xff, 0, 0x006, 0, 0)
}
