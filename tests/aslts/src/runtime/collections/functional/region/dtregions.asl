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
 * Data Table Region declarations
 */

/*
 * On testing following issues should be covered:
 * - String objects can be used as DataTableRegion arguments,
 * - global and dynamic DataTableRegion declarations,
 * - check of the Table Length on access to appropriate Fields,
 * - any table referenced in XSDT can be accessed,
 * - computational data is allowed to be DataTableRegion arguments,
 * - possibility to write into appropriate Fields.
 *
 * Can not be tested following issues:
 * - providing of DataTableRegions to be "in memory marked by
 *   AddressRangeReserved or AddressRangeNVS".
 */

Name(z142, 142)

Device(DTR0) {
	DataTableRegion (DR00, "DSDT", "", "")
	DataTableRegion (DR01, "SSDT", "", "")

    /* This SSDT must be identical to SSDT1 in the AcpiExec utility */

	Name(SSDT, Buffer(0x3E){
        0x53,0x53,0x44,0x54,0x3E,0x00,0x00,0x00,  /* 00000000    "SSDT>..." */
        0x02,0x08,0x49,0x6E,0x74,0x65,0x6C,0x00,  /* 00000008    "..Intel." */
        0x73,0x73,0x64,0x74,0x31,0x00,0x00,0x00,  /* 00000010    "ssdt1..." */
        0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
        0x20,0x06,0x12,0x20,0x14,0x19,0x5F,0x54,  /* 00000020    " .. .._T" */
        0x39,0x38,0x01,0x70,0x0D,0x53,0x53,0x44,  /* 00000028    "98.p.SSD" */
        0x54,0x31,0x20,0x2D,0x20,0x5F,0x54,0x39,  /* 00000030    "T1 - _T9" */
        0x38,0x00,0x5B,0x31,0xA4,0x00             /* 00000038    "8.[1.."   */
	})

	Name(NFLG, 2)	// Number of turn on/off Flag values

	Name(IRSK, 0)   // Counter of the Invalid RSKs

	Name(IFLG, 0)   // Counter of the Invalid Flags

	Name(VRSK, 0)	// Counter of the Valid RSK 0x07
	Name(ERSK, 2)	// Expected Counters of the Valid RSK

	Name(VFLG,		// Counters of the Valid Flags
		Package(NFLG){0, 0})

	// Specific DataTable Regions availability notification Method
	// \DTR0._REG(RegionSpaceKeyword, Flag)
    OperationRegion(JUNK, SystemMemory, 0x2000, 0x100)
	Method(_REG, 2, Serialized)
	{
		Name(dbgf, 1)

		if (dbgf) {
		    DNAM (Arg0, Arg1, "\\DTR0._REG")
		}

		/*
		 * 0x7E is the SpaceID for DataTableRegions (subject to change
		 * with new releases of ACPI specification -- because this
		 * ID is an internal-ACPICA-only ID)
		 */
		if (LEqual(arg0, 0x7E)) {
			Increment(VRSK)
		} else {
			Increment(IRSK)
		}

		if (LLess(arg1, NFLG)) {
			Store(Index(VFLG, arg1), Local1)
			Store(Refof(Local1), Local2)
			Add(Derefof(Local1), 1, Derefof(Local2))
		} else {
			Increment(IFLG)
		}
	}
}

// Global DataTableRegions
Method(m7f0, 1)
{
	Concatenate(arg0, "-m7f0", arg0)

	\DTR0._REG(0x101, 2)

	if (LNotEqual(\DTR0.IRSK, 1)) {
		err(arg0, z142, 1, 0, 0, \DTR0.IRSK, 1)
	}
	if (LNotEqual(\DTR0.IFLG, 1)) {
		err(arg0, z142, 2, 0, 0, \DTR0.IFLG, 1)
	}
	if (LNotEqual(\DTR0.VRSK, 2)) {
		err(arg0, z142, 3, 0, 0, \DTR0.VRSK, 2)
	}
	if (LNotEqual(Derefof(Index(\DTR0.VFLG, 1)), 2)) {
		err(arg0, z142, 4, 0, 0, Derefof(Index(\DTR0.VFLG, 1)), 2)
	}
}

// Dynamic DataTableRegions
// m7f1(CallChain)
// CallChain: String
Method(m7f1, 1, Serialized)
{
	Name(NFLG, 2)	// Number of turn on/off Flag values

	Name(IRSK, 0)   // Counter of the Invalid RSKs

	Name(IFLG, 0)   // Counter of the Invalid Flags

	Name(VRSK, 0)	// Counter of the Valid RSK 0x7E (DataTableRegion)
	Name(ERSK, 2)	// Expected Counters of the Valid RSK

	Name(VFLG,		// Counters of the Valid Flags
		Package(NFLG){0, 0})

	// Specific DataTable Regions availability notification Method
	// \m7f1._REG(RegionSpaceKeyword, Flag)
    OperationRegion(JUNK, SystemMemory, 0x2000, 0x100)
	Method(_REG, 2, Serialized)
	{
		Name(dbgf, 1)

		if (dbgf) {
		    DNAM (Arg0, Arg1, "\\m7f1._REG")
		}

        // DataTableRegion is SpaceID 0x7E
		if (LEqual(arg0, 0x7E)) {
			Increment(VRSK)
		} else {
			Increment(IRSK)
		}

		if (LLess(arg1, NFLG)) {
			Store(Index(VFLG, arg1), Local1)
			Store(Refof(Local1), Local2)
			Add(Derefof(Local1), 1, Derefof(Local2))
		} else {
			Increment(IFLG)
		}
	}

	Concatenate(arg0, "-m7f1", arg0)

	if (LNotEqual(VRSK, 0)) {
		err(arg0, z142, 5, 0, 0, VRSK, 0)
	}
	if (LNotEqual(Derefof(Index(VFLG, 1)), 0)) {
		err(arg0, z142, 6, 0, 0, Derefof(Index(VFLG, 1)), 0)
	}

	DataTableRegion (DR00, "SSDT", "", "")

	if (LNotEqual(IRSK, 0)) {
		err(arg0, z142, 8, 0, 0, IRSK, 0)
	}
	if (LNotEqual(IFLG, 0)) {
		err(arg0, z142, 9, 0, 0, IFLG, 0)
	}

	_REG(0x101, 2)

	if (LNotEqual(IRSK, 1)) {
		err(arg0, z142, 10, 0, 0, IRSK, 1)
	}
	if (LNotEqual(IFLG, 1)) {
		err(arg0, z142, 11, 0, 0, IFLG, 1)
	}
	if (LNotEqual(VRSK, 1)) {
		err(arg0, z142, 12, 0, 0, VRSK, 1)
	}
	if (LNotEqual(Derefof(Index(VFLG, 1)), 1)) {
		err(arg0, z142, 13, 0, 0, Derefof(Index(VFLG, 1)), 1)
	}
}

// DataTableRegion Lengths
// m7f2(CallChain)
// CallChain: String
Method(m7f2, 1, Serialized)
{
	Concatenate(arg0, "-m7f2", arg0)

	Field(\DTR0.DR01, AnyAcc, NoLock, Preserve) {
		FU01, 0x1F0}            /* 0x1F0 == length of SSDT */
	Store(Refof(FU01), Local0)

	Store(Refof(Local0), Local1)

	Store(Derefof(Local0), Local2)

	CH03(arg0, z142, 16, 0, 0)

	Store(\DTR0.SSDT, Local3)

	if (LNotEqual(Local2, Local3)) {
		err(arg0, z142, 17, 0, 0, Local2, Local3)
	}
}

// Check non-constant DataTableRegion *String arguments
// m7f3(CallChain)
// CallChain: String
Method(m7f3, 1, Serialized)
{
	Name(s000, "SSDT")
	Name(s001, "")
	Name(s002, "")

	Method(m000, 1, Serialized) {
		DataTableRegion (DR00, "SSDT", "", "")

		Field(DR00, AnyAcc, NoLock, Preserve) {
			FU01, 0x1F0}            /* 0x1F0 == length of SSDT */

		Store(FU01, Local0)
		Store(\DTR0.SSDT, Local1)

		if (LNotEqual(Local0, Local1)) {
			err(arg0, z142, 18, 0, 0, Local0, Local1)
		}
	}

	// ArgX
	Method(m001, 4, Serialized) {
		DataTableRegion (DR00, arg1, arg2, arg3)

		Field(DR00, AnyAcc, NoLock, Preserve) {
			FU01, 0x1F0}            /* 0x1F0 == length of SSDT */

		Store(FU01, Local0)
		Store(\DTR0.SSDT, Local1)

		if (LNotEqual(Local0, Local1)) {
			err(arg0, z142, 19, 0, 0, Local0, Local1)
		}
	}

	// Named
	Method(m002, 1, Serialized) {
		DataTableRegion (DR00, s000, s001, s002)

		Field(DR00, AnyAcc, NoLock, Preserve) {
			FU01, 0x1F0}            /* 0x1F0 == length of SSDT */

		Store(FU01, Local0)
		Store(\DTR0.SSDT, Local1)

		if (LNotEqual(Local0, Local1)) {
			err(arg0, z142, 20, 0, 0, Local0, Local1)
		}
	}

	// LocalX
	Method(m003, 1, Serialized) {
		Store(s000, Local2)
		Store(s001, Local3)
		Store(s002, Local4)

		DataTableRegion (DR00, Local2, Local3, Local4)

		Field(DR00, AnyAcc, NoLock, Preserve) {
			FU01, 0x1F0}            /* 0x1F0 == length of SSDT */

		Store(FU01, Local0)
		Store(\DTR0.SSDT, Local1)

		if (LNotEqual(Local0, Local1)) {
			err(arg0, z142, 21, 0, 0, Local0, Local1)
		}
	}

	// Expression
	Method(m004, 1, Serialized) {
		Store("SS", Local2)
		Store("DT", Local3)

		DataTableRegion (DR00, Concatenate(Local2, Local3), Mid(s000, 1, 0), s002)

		Field(DR00, AnyAcc, NoLock, Preserve) {
			FU01, 0x1F0}            /* 0x1F0 == length of SSDT */

		Store(FU01, Local0)
		Store(\DTR0.SSDT, Local1)

		if (LNotEqual(Local0, Local1)) {
			err(arg0, z142, 22, 0, 0, Local0, Local1)
		}
	}

	Concatenate(arg0, "-m7f1", arg0)

	m000(arg0)
	m001(arg0, "SSDT", "", "")
	m002(arg0)
	m003(arg0)
	m004(arg0)
}

// Check different Table signatures
// m7f4(CallChain)
// CallChain: String
Method(m7f4, 1)
{
	Method(m000, 3, Serialized) {
		DataTableRegion (DR00, arg1, "", "")

		Field(DR00, AnyAcc, NoLock, Preserve) {
			FU00, 32}

		Store(ToString(FU00, 4), Local0)

		if (LNotEqual(Local0, arg1)) {
			err(arg0, z142, arg2, 0, 0, Local0, arg1)
		}
	}

	Concatenate(arg0, "-m7f4", arg0)

	m000(arg0, "DSDT", 27)
	m000(arg0, "SSDT", 28)
	/* no RSDT in simulator */
	//m000(arg0, "RSDT", 29)
	m000(arg0, "TEST", 30)
	m000(arg0, "BAD!", 31)
	m000(arg0, "FACP", 32)
	m000(arg0, "SSDT", 33)
	m000(arg0, "OEM1", 34)
}

Method(DRC0,, Serialized)
{
	Name(ts, "DRC0")

	// Global DataTableRegions
	SRMT("m7f0")
	m7f0(ts)

	// Dynamic DataTableRegions
	SRMT("m7f1")
    m7f1(ts)

	// DataTableRegion Lengths
	SRMT("m7f2")
	m7f2(ts)

	// Non-constant DataTableRegion *String arguments
	SRMT("m7f3")
	if (y223) {
		m7f3(ts)
	} else {
		BLCK()
	}

	// Different Table signatures
	SRMT("m7f4")
	if (y223) {
		m7f4(ts)
	} else {
		BLCK()
	}
}
