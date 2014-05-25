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
 * Bug 120:
 *
 * SUMMARY: Unexpected exception on Store of Device and ThermalZone elements of Package to Debug operation
 */

	Method(mf64,, Serialized)
	{
		Name(pp00, Package(){prd2})
		Index(pp00, 0, Local0)
		Store(ObjectType(Local0), Debug)
		Store(Derefof(Local0), Debug)

		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c014)) {
			err("", zFFF, 0x000, 0, 0, Local1, c014)
		}
	}

	Method(mf65,, Serialized)
	{
		Name(pp00, Package(){rd07})
		Index(pp00, 0, Local0)
		Store(ObjectType(Local0), Debug)
		Store(Derefof(Local0), Debug)

		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c012)) {
			err("", zFFF, 0x001, 0, 0, Local1, c012)
		}
	}

	Method(mf66,, Serialized)
	{
		Name(pp00, Package(){pwd2})
		Index(pp00, 0, Local0)
		Store(ObjectType(Local0), Debug)
		Store(Derefof(Local0), Debug)

		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c013)) {
			err("", zFFF, 0x002, 0, 0, Local1, c013)
		}
	}

	Method(mf67,, Serialized)
	{
		Name(pp00, Package(){ed05})
		Index(pp00, 0, Local0)
		Store(ObjectType(Local0), Debug)
		Store(Derefof(Local0), Debug)

		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c00f)) {
			err("", zFFF, 0x003, 0, 0, Local1, c00f)
		}
	}

	Method(mf68,, Serialized)
	{
		Name(pp00, Package(){mxd3})
		Index(pp00, 0, Local0)
		Store(ObjectType(Local0), Debug)
		Store(Derefof(Local0), Debug)

		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c011)) {
			err("", zFFF, 0x004, 0, 0, Local1, c011)
		}
	}

	Method(mf69,, Serialized)
	{
		Name(pp00, Package(){dd0d})

		Index(pp00, 0, Local0)

		CH03("", 0, 0x005, 0, 0)
		Store(ObjectType(Local0), Debug)
		CH03("", 0, 0x006, 0, 0)
		Store(Derefof(Local0), Debug)
		CH03("", 0, 0x007, 0, 0)

		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c00e)) {
			err("", zFFF, 0x008, 0, 0, Local1, c00e)
		}
	}

	Method(mf6a,, Serialized)
	{
		Name(pp00, Package(){tzd2})

		Index(pp00, 0, Local0)

		CH03("", 0, 0x009, 0, 0)
		Store(ObjectType(Local0), Debug)
		CH03("", 0, 0x00a, 0, 0)
		Store(Derefof(Local0), Debug)
		CH03("", 0, 0x00b, 0, 0)

		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c015)) {
			err("", zFFF, 0x00c, 0, 0, Local1, c015)
		}
	}

