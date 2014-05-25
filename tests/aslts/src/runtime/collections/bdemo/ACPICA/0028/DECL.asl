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
 * Bug 0028:
 *
 * SUMMARY: No exception on Create*Field for out of Buffer range
 */

Method(mdbc,, Serialized)
{
	Name(b000, Buffer(16) {})

	CreateBitField(b000, 127, f000)
	CreateByteField(b000, 15, f001)
	CreateWordField(b000, 14, f002)
	CreateDWordField(b000, 12, f003)
	CreateQWordField(b000, 8, f004)
	CreateField(b000, 127, 1, f005)
	CreateField(b000, 120, 8, f006)
}

Method(mdbd,, Serialized)
{
	Name(b000, Buffer(16) {})

	CH03("", 0, 0x000, 0, 0)
	CreateBitField(b000, 128, f000)
	CH04("", 0, 54, 0, 0x001, 0, 0) // AE_AML_BUFFER_LIMIT

	CH03("", 0, 0x002, 0, 0)
	CreateByteField(b000, 16, f001)
	CH04("", 0, 54, 0, 0x003, 0, 0) // AE_AML_BUFFER_LIMIT

	CH03("", 0, 0x004, 0, 0)
	CreateWordField(b000, 15, f002)
	CH04("", 0, 54, 0, 0x005, 0, 0) // AE_AML_BUFFER_LIMIT

	CH03("", 0, 0x006, 0, 0)
	CreateDWordField(b000, 13, f003)
	CH04("", 0, 54, 0, 0x007, 0, 0) // AE_AML_BUFFER_LIMIT

	CH03("", 0, 0x008, 0, 0)
	CreateQWordField(b000, 9, f004)
	CH04("", 0, 54, 0, 0x009, 0, 0) // AE_AML_BUFFER_LIMIT

	CH03("", 0, 0x00a, 0, 0)
	CreateField(b000, 127, 2, f005)
	CH04("", 0, 54, 0, 0x00b, 0, 0) // AE_AML_BUFFER_LIMIT

	CH03("", 0, 0x00c, 0, 0)
	CreateField(b000, 120, 9, f006)
	CH04("", 0, 54, 0, 0x00d, 0, 0) // AE_AML_BUFFER_LIMIT

	CH03("", 0, 0x00e, 0, 0)
	CreateField(b000, 128, 1, f007)
	CH04("", 0, 54, 0, 0x00f, 0, 0) // AE_AML_BUFFER_LIMIT

	CH03("", 0, 0x010, 0, 0)
	CreateField(b000, 121, 8, f008)
	CH04("", 0, 54, 0, 0x011, 0, 0) // AE_AML_BUFFER_LIMIT
}

Method(mdbe)
{
	mdbc()
	mdbd()
}
