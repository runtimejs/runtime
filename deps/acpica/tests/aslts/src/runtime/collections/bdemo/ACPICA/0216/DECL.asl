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
 * Bug 216(local-bugzilla-341):
 *
 * SUMMARY: exception AE_NOT_FOUND on CreateField under specific conditions
 *
 * Failed to find Buffer for CreateField both declared inside
 * some of these types: Device/ThermalZone/Processor/PowerResource
 * which in turn are declared inside some method thus created
 * dynamically.
 *
 * APPEARANCE:
 * Call method which declares object of any of these types:
 *    Device
 *    ThermalZone
 *    Processor
 *    PowerResource
 * which contains internal declarations of Buffer of name which
 * there are no in the higher levels and run CreateField for that
 * Buffer. If run method then get mentioned exception.
 *
 * May suspect, at first glance, that if the name of that Buffer fit
 * the name of some higher level Buffer (no exception in that case)
 * then CreateField deals with that higher level Buffer. Though, the
 * example with dd12 doesn't count in favour of that reason.
 *
 * Note: add verifications while fixing the bug (access to Buffer Fields..).
 */

/* ======== 0 ======= */

Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
Name(bd12, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
Device(dd12) {}


Device(dd0e) {
	Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	CreateField(bd13, 0, 8, bf00)
	}

ThermalZone(tzd3) {
	Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	CreateField(bd13, 0, 8, bf00)
	}

Processor(prd3, 0, 0xFFFFFFFF, 0) {
	Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	CreateField(bd13, 0, 8, bf00)
	}

PowerResource(pwd3, 1, 0) {
	Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	CreateField(bd13, 0, 8, bf00)
	}

Method(m81e,, Serialized) {
	Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	CreateField(bd13, 0, 8, bf00)
	}

/* ======== 1 ======= */

Device(dd0f) {
	Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	CreateField(bd11, 0, 8, bf00)
	}

ThermalZone(tzd4) {
	Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	CreateField(bd11, 0, 8, bf00)
	}

Processor(prd4, 0, 0xFFFFFFFF, 0) {
	Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	CreateField(bd11, 0, 8, bf00)
	}

PowerResource(pwd4, 1, 0) {
	Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	CreateField(bd11, 0, 8, bf00)
	}

Method(m81f,, Serialized) {
	Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	CreateField(bd11, 0, 8, bf00)
	}

/* ======== 2 ======= */

Device(dd10) {
	CreateField(bd11, 0, 8, bf00)
	}

ThermalZone(tzd5) {
	CreateField(bd11, 0, 8, bf00)
	}

Processor(prd5, 0, 0xFFFFFFFF, 0) {
	CreateField(bd11, 0, 8, bf00)
	}

PowerResource(pwd5, 1, 0) {
	CreateField(bd11, 0, 8, bf00)
	}

Method(m820) {
	CreateField(bd11, 0, 8, bf00)
	}

/* ======== 3 ======= */

Device(dd11) {

	/* ======== 0 ======= */

	Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	CreateField(bd13, 0, 8, bf00)

	Device(dd0e) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	ThermalZone(tzd3) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	Processor(prd3, 0, 0xFFFFFFFF, 0) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	PowerResource(pwd3, 1, 0) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	Method(m81e,, Serialized) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	/* ======== 1 ======= */

	Device(dd0f) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	ThermalZone(tzd4) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	Processor(prd4, 0, 0xFFFFFFFF, 0) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	PowerResource(pwd4, 1, 0) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	Method(m81f,, Serialized) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	/* ======== 2 ======= */

	Device(dd10) {
		CreateField(bd11, 0, 8, bf00)
		}

	ThermalZone(tzd5) {
		CreateField(bd11, 0, 8, bf00)
		}

	Processor(prd5, 0, 0xFFFFFFFF, 0) {
		CreateField(bd11, 0, 8, bf00)
		}

	PowerResource(pwd5, 1, 0) {
		CreateField(bd11, 0, 8, bf00)
		}

	Method(m820) {
		CreateField(bd11, 0, 8, bf00)
		}
}

ThermalZone(tzd6) {

	/* ======== 0 ======= */

	Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	CreateField(bd13, 0, 8, bf00)

	Device(dd0e) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	ThermalZone(tzd3) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	Processor(prd3, 0, 0xFFFFFFFF, 0) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	PowerResource(pwd3, 1, 0) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	Method(m81e,, Serialized) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	/* ======== 1 ======= */

	Device(dd0f) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	ThermalZone(tzd4) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	Processor(prd4, 0, 0xFFFFFFFF, 0) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	PowerResource(pwd4, 1, 0) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	Method(m81f,, Serialized) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	/* ======== 2 ======= */

	Device(dd10) {
		CreateField(bd11, 0, 8, bf00)
		}

	ThermalZone(tzd5) {
		CreateField(bd11, 0, 8, bf00)
		}

	Processor(prd5, 0, 0xFFFFFFFF, 0) {
		CreateField(bd11, 0, 8, bf00)
		}

	PowerResource(pwd5, 1, 0) {
		CreateField(bd11, 0, 8, bf00)
		}

	Method(m820) {
		CreateField(bd11, 0, 8, bf00)
		}
}

Processor(prd6, 0, 0xFFFFFFFF, 0) {

	/* ======== 0 ======= */

	Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	CreateField(bd13, 0, 8, bf00)

	Device(dd0e) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	ThermalZone(tzd3) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	Processor(prd3, 0, 0xFFFFFFFF, 0) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	PowerResource(pwd3, 1, 0) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	Method(m81e,, Serialized) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	/* ======== 1 ======= */

	Device(dd0f) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	ThermalZone(tzd4) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	Processor(prd4, 0, 0xFFFFFFFF, 0) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	PowerResource(pwd4, 1, 0) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	Method(m81f,, Serialized) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	/* ======== 2 ======= */

	Device(dd10) {
		CreateField(bd11, 0, 8, bf00)
		}

	ThermalZone(tzd5) {
		CreateField(bd11, 0, 8, bf00)
		}

	Processor(prd5, 0, 0xFFFFFFFF, 0) {
		CreateField(bd11, 0, 8, bf00)
		}

	PowerResource(pwd5, 1, 0) {
		CreateField(bd11, 0, 8, bf00)
		}

	Method(m820) {
		CreateField(bd11, 0, 8, bf00)
		}
}

PowerResource(pwd6, 1, 0) {

	/* ======== 0 ======= */

	Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	CreateField(bd13, 0, 8, bf00)

	Device(dd0e) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	ThermalZone(tzd3) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	Processor(prd3, 0, 0xFFFFFFFF, 0) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	PowerResource(pwd3, 1, 0) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	Method(m81e,, Serialized) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	/* ======== 1 ======= */

	Device(dd0f) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	ThermalZone(tzd4) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	Processor(prd4, 0, 0xFFFFFFFF, 0) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	PowerResource(pwd4, 1, 0) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	Method(m81f,, Serialized) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	/* ======== 2 ======= */

	Device(dd10) {
		CreateField(bd11, 0, 8, bf00)
		}

	ThermalZone(tzd5) {
		CreateField(bd11, 0, 8, bf00)
		}

	Processor(prd5, 0, 0xFFFFFFFF, 0) {
		CreateField(bd11, 0, 8, bf00)
		}

	PowerResource(pwd5, 1, 0) {
		CreateField(bd11, 0, 8, bf00)
		}

	Method(m820) {
		CreateField(bd11, 0, 8, bf00)
		}
}

Method(m821,, Serialized)
{
	/* ======== 0 ======= */

	Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
	CreateField(bd13, 0, 8, bf00)

	Device(dd0e) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	ThermalZone(tzd3) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	Processor(prd3, 0, 0xFFFFFFFF, 0) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	PowerResource(pwd3, 1, 0) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	Method(m81e,, Serialized) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}

	/* ======== 1 ======= */

	Device(dd0f) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	ThermalZone(tzd4) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	Processor(prd4, 0, 0xFFFFFFFF, 0) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	PowerResource(pwd4, 1, 0) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	Method(m81f,, Serialized) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}

	/* ======== 2 ======= */

	Device(dd10) {
		CreateField(bd11, 0, 8, bf00)
		}

	ThermalZone(tzd5) {
		CreateField(bd11, 0, 8, bf00)
		}

	Processor(prd5, 0, 0xFFFFFFFF, 0) {
		CreateField(bd11, 0, 8, bf00)
		}

	PowerResource(pwd5, 1, 0) {
		CreateField(bd11, 0, 8, bf00)
		}

	Method(m820) {
		CreateField(bd11, 0, 8, bf00)
		}
	m81e()
	m81f()
	m820()
}

/* ======== 4 ======= */

Method(m822,, Serialized)
{
	Device(dd0e) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}
}

Method(m823,, Serialized)
{
	ThermalZone(tzd3) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}
}

Method(m824,, Serialized)
{
	Processor(prd3, 0, 0xFFFFFFFF, 0) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}
}

Method(m825,, Serialized)
{
	PowerResource(pwd3, 1, 0) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}
}

Method(m826)
{
	Method(m000,, Serialized) {
		Name(bd13, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd13, 0, 8, bf00)
		}
}

/* ======== 5 ======= */

Method(m827,, Serialized)
{
	Device(dd0e) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}
}

Method(m828,, Serialized)
{
	ThermalZone(tzd3) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}
}

Method(m829,, Serialized)
{
	Processor(prd3, 0, 0xFFFFFFFF, 0) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}
}

Method(m82a,, Serialized)
{
	PowerResource(pwd3, 1, 0) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}
}

Method(m82b)
{
	Method(m000,, Serialized) {
		Name(bd11, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(bd11, 0, 8, bf00)
		}
}

/* ======== 6 ======= */

Method(m82c,, Serialized)
{
	Device(dd0e) {
		CreateField(bd12, 0, 8, bf00)
		}
}

Method(m82d,, Serialized)
{
	ThermalZone(tzd3) {
		CreateField(bd12, 0, 8, bf00)
		}
}

Method(m82e,, Serialized)
{
	Processor(prd3, 0, 0xFFFFFFFF, 0) {
		CreateField(bd12, 0, 8, bf00)
		}
}

Method(m82f,, Serialized)
{
	PowerResource(pwd3, 1, 0) {
		CreateField(bd12, 0, 8, bf00)
		}
}

Method(m830)
{
	Method(m000) {
		CreateField(bd12, 0, 8, bf00)
		}
}

/* ======== 7 ======= */

Method(m832,, Serialized)
{
	Device(dd0e) {
		Name(dd12, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(dd12, 0, 8, bf00)
		}
}

Method(m833,, Serialized)
{
	ThermalZone(tzd3) {
		Name(dd12, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(dd12, 0, 8, bf00)
		}
}

Method(m834,, Serialized)
{
	Processor(prd3, 0, 0xFFFFFFFF, 0) {
		Name(dd12, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(dd12, 0, 8, bf00)
		}
}

Method(m835,, Serialized)
{
	PowerResource(pwd3, 1, 0) {
		Name(dd12, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(dd12, 0, 8, bf00)
		}
}

Method(m836)
{
	Method(m000,, Serialized) {
		Name(dd12, Buffer() {0xb0,0xb1,0xb2,0xb3,0xb4})
		CreateField(dd12, 0, 8, bf00)
		}
}


Method(m831)
{
	CH03("", 0, 0x000, 0, 0)

	SRMT("m831-0")
	if (1) {
		m81e()
		m81f()
		m820()
		m821()
	}

	CH03("", 0, 0x001, 0, 0)

	SRMT("m831-1")
	if (1) {
		m822()
		CH03("", 0, 0x002, 0, 0)
		m823()
		CH03("", 0, 0x003, 0, 0)
		m824()
		CH03("", 0, 0x004, 0, 0)
		m825()
		CH03("", 0, 0x005, 0, 0)
		m826()
		CH03("", 0, 0x006, 0, 0)
	}

	CH03("", 0, 0x007, 0, 0)

	SRMT("m831-2")
	if (1) {
		m827()
		m828()
		m829()
		m82a()
		m82b()
	}

	CH03("", 0, 0x008, 0, 0)

	SRMT("m831-3")
	if (1) {
		m82c()
		m82d()
		m82e()
		m82f()
		m830()
	}

	CH03("", 0, 0x009, 0, 0)

	SRMT("m831-4")
	if (1) {
		m832()
		m833()
		m834()
		m835()
		m836()
	}

	CH03("", 0, 0x00a, 0, 0)
}
