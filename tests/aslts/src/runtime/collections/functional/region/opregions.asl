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
 * Operation Region declarations
 */

/*
 * On testing following issues should be covered:
 * - application of any allowed RegionSpace Keywords,
 * - Devices' _REG methods invocation during setup of Regions,
 * - global and dynamic Operation Region declarations,
 * - check of the Region Length on access to appropriate Fields,
 * - check that Region Offset and Length can be computational data.
 *
 * Can not be tested following issues:
 * - emulated Access to SystemCMOS, PciBarTarget, and UserDefRegionSpace
 *   (except 0x80) Operation Regions (there are no appropriate setup of them),
 * - Operation Region address range mapping to given Offset and Length,
 * - large values as Region Length,
 * - host OS providing of exclusive use of hardware registers in global
 *   Operation Region address range by ACPI control methods only.
 */

Name(z141, 141)

Name(NRSK, 11)	// Number of the specific RegionSpaceKeywords
Name(IRSK, 0)   // Counter of the Invalid RSKs

Name(NFLG, 2)	// Number of turn on/off Flag values
Name(IFLG, 0)   // Counter of the Invalid Flags

Name(FRSK, 0x101)	// Some false RegionSpace Keyword

Name(PRSK, Package(NRSK){
	0x100 /* UserDefRegionSpace 0x80-0xFF: auxiliary */,
	0x00 /* SystemMemory */,
	0x01 /* SystemIO */,
	0x02 /* PCI_Config */,
	0x03 /* EmbeddedControl */,
	0x04 /* SMBus */,
	0x05 /* SystemCMOS */,
	0x06 /* PciBarTarget */,
	0x07 /* IPMI */,
	0x08 /* GeneralPurposeIo */,
	0x09 /* GenericSerialBus */
})

// DefaultAddressSpaces
Name(DRSK, Package(3){
	0x00 /* SystemMemory */,
	0x01 /* SystemIO */,
	0x02 /* PCI_Config */,
})

Name(VRSK,		// Counters of the Valid RSKs
	Package(NRSK){0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})

// Expected Counters of the Valid RSKs
// actually, not only default spaces are initialized
// by ACPICA, but AcpiExec provided ones also,
// from aeexec.c:
/*
static ACPI_ADR_SPACE_TYPE  SpaceIdList[] =
{
    ACPI_ADR_SPACE_EC,
    ACPI_ADR_SPACE_SMBUS,
    ACPI_ADR_SPACE_GSBUS,
    ACPI_ADR_SPACE_GPIO,
    ACPI_ADR_SPACE_PCI_BAR_TARGET,
    ACPI_ADR_SPACE_IPMI,
    ACPI_ADR_SPACE_FIXED_HARDWARE,
    ACPI_ADR_SPACE_USER_DEFINED1,
    ACPI_ADR_SPACE_USER_DEFINED2
};
*/

Name(ERSK,
	// 2 for \RGN0, \OPRK; 3 for \RGN0, \OPRI, and \OPRJ
	Package(NRSK){1, 2, 3, 1, 1, 1, 0, 0, 0, 0, 0})

Name(VFLG,		// Counters of the Valid Flags
	Package(NFLG){0, 0})

// Global Operation Regions availability notification Method
// _REG(RegionSpaceKeyword, Flag)
// RegionSpaceKeyword:
//	     UserDefRegionSpace | SystemIO | SystemMemory | PCI_Config |
//	     EmbeddedControl | SMBus | SystemCMOS | PciBarTarget |
//       IPMI | GeneralPurposeIo | GenericSerialBus
// Flag: 1/0 - turn on/off accessing operation regions of that Space
Method(_REG, 2, Serialized)
{
	Name(dbgf, 1)

	if (dbgf) {
	    DNAM (Arg0, Arg1, "\\_REG")
	}

	Store(Match(PRSK, MEQ, arg0, MTR, 0, 1), Local0)

	if (LAnd(LGreater(arg0, 0x7f), LLess(arg0, 0x100))) {
		Store(0, Local0)
	}

	if (LLess(Local0, NRSK)) {
		Store(Index(VRSK, Local0), Local1)
		Store(Refof(Local1), Local2)
		Add(Derefof(Local1), 1, Derefof(Local2))
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

// Combination of the OperationRegion operator arguments

OperationRegion(RGN0, SystemMemory,     0x0000, 0x101)
OperationRegion(RGN1, SystemIO,         0x0200, 0x103)
OperationRegion(RGN2, PCI_Config,       0x0400, 0x105)
OperationRegion(RGN3, EmbeddedControl,  0x0600, 0x107)
OperationRegion(RGN4, SMBus,            0x0800, 0x109)
OperationRegion(RGN5, SystemCMOS,       0x0a00, 0x10b)
OperationRegion(RGN6, PciBarTarget,     0x0c00, 0x10d)

// UserDefRegionSpace

OperationRegion(RGN7, 0x80,             0x0d00, 0x117)
OperationRegion(RGN8, 0xcf,             0x0e00, 0x118)
OperationRegion(RGN9, 0xff,             0x0f00, 0x119)

// ACPI 4/5 new space IDs
OperationRegion(RGNa, GeneralPurposeIo, 0x1100, 0x11a)

// NOTE: These spaces have special buffer protocols, can't be tested here
//OperationRegion(RGNb, IPMI,             0x1000, 528)
//OperationRegion(RGNc, GenericSerialBus, 0x1200, 272)


// OpRegion Lengths checking task package: Name, SpaceID, Length
Name(p702, Package(){
	RGN0, 0x00, 0x101,
	RGN1, 0x01, 0x103,
	RGN2, 0x02, 0x105,
	RGN3, 0x03, 0x107,
	RGN4, 0x04, 0x109,
	RGN5, 0x05, 0x10b,
	RGN6, 0x06, 0x10d,
	RGN7, 0x80, 0x117,
	RGN8, 0xcf, 0x118,
	RGN9, 0xff, 0x119,
	RGNa, 0x08, 0x11a,
})

// Region Space keyword strings
Name(NNAM, 10)
Name(RNAM, Package(NNAM){
	/* 0x00 */ "SystemMemory",
	/* 0x01 */ "SystemIO",
	/* 0x02 */ "PCI_Config",
	/* 0x03 */ "EmbeddedControl",
	/* 0x04 */ "SMBus",
	/* 0x05 */ "SystemCMOS",
	/* 0x06 */ "PciBarTarget",
	/* 0x07 */ "IPMI",
	/* 0x08 */ "GeneralPurposeIo",
	/* 0x09 */ "GenericSerialBus"
})

/*
 * Display _REG method info
 */

// Arg0: SpaceID
// Arg1: Enable/Disable flag
// Arg2: _REG method name
Method (DNAM, 3)
{
    Concatenate ("Executing _REG method: ", Arg2, Local1)
    Concatenate (Local1, "  (", Local1)

    if (LGreaterEqual (Arg0, NNAM)) {
        if (LEqual (Arg0, 0x7E)) {
            Concatenate (Local1, "Data Table", Local2)
        }
        else {
            Concatenate (Local1, "User-defined or unknown SpaceId", Local2)
        }
    }
    else {
        Concatenate (Local1, DeRefOf (Index (RNAM, Arg0)), Local2)
    }

    Concatenate (Local2, ")", Local2)
    Store (Local2, Debug)
    Store(arg0, Debug)
    Store(arg1, Debug)
}

Device(DOR0) {
	Name(IRSK, 0)   // Counter of the Invalid RSKs

	Name(IFLG, 0)   // Counter of the Invalid Flags

	Name(VRSK,		// Counters of the Valid RSKs
		Package(NRSK){0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
	Name(ERSK,		// Expected Counters of the Valid RSKs
		Package(NRSK){1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0})

	Name(VFLG,		// Counters of the Valid Flags
		Package(NFLG){0, 0})

	// Specific Operation Regions availability notification Method
	// \DOR0._REG(RegionSpaceKeyword, Flag)
	Method(_REG, 2, Serialized)
	{
		Name(dbgf, 1)

		if (dbgf) {
		    DNAM (Arg0, Arg1, "\\DOR0._REG")
		}

		Store(Match(PRSK, MEQ, arg0, MTR, 0, 1), Local0)

		if (LAnd(LGreater(arg0, 0x7f), LLess(arg0, 0x100))) {
			Store(0, Local0)
		}

		if (LLess(Local0, NRSK)) {
			Store(Index(VRSK, Local0), Local1)
			Store(Refof(Local1), Local2)
			Add(Derefof(Local1), 1, Derefof(Local2))
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

	// Combination of the OperationRegion operator arguments

	OperationRegion(RGN0, SystemMemory,     0x1000, 0x102)
	OperationRegion(RGN1, SystemIO,         0x1200, 0x104)
	OperationRegion(RGN2, PCI_Config,       0x1400, 0x106)
	OperationRegion(RGN3, EmbeddedControl,  0x1600, 0x108)
	OperationRegion(RGN4, SMBus,            0x1800, 0x10a)
	OperationRegion(RGN5, SystemCMOS,       0x1a00, 0x10c)
	OperationRegion(RGN6, PciBarTarget,     0x1c00, 0x10d)

	// UserDefRegionSpace

	OperationRegion(RGN7, 0x80,             0, 0x127)
	OperationRegion(RGN8, 0xa5,             0, 0x128)
	OperationRegion(RGN9, 0xff,             0, 0x129)

    // ACPI 4/5 new space IDs

    OperationRegion(RGNa, IPMI,             0x1e00, 0x10e)
    OperationRegion(RGNb, GeneralPurposeIo, 0x2000, 0x10f)
    OperationRegion(RGNc, GenericSerialBus, 0x2200, 0x110)
}

Device(DOR1) {
	Name(IRSK, 0)   // Counter of the Invalid RSKs

	Name(IFLG, 0)   // Counter of the Invalid Flags

	Name(VRSK,		// Counters of the Valid RSKs
		Package(NRSK){0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
	Name(ERSK,		// Expected Counters of the Valid RSKs
		Package(NRSK){1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0})

	Name(VFLG,		// Counters of the Valid Flags
		Package(NFLG){0, 0})

	Name(IREG, 0)	// Counter of the Invalid Calls to DOR1._REG

	// Specific Operation Regions availability notification Method
	// \DOR1._REG(RegionSpaceKeyword, Flag)
    OperationRegion(JUNK, SystemMemory, 0x2000, 0x100)
	Method(_REG, 2, Serialized)
	{
		Name(dbgf, 1)

		if (dbgf) {
	        DNAM (Arg0, Arg1, "\\DOR1._REG")
		}

		Increment(IREG)
	}

	Method(M000,, Serialized) {
		// Dynamic Operation Regions availability notification Method
		// \DOR1.M000._REG(RegionSpaceKeyword, Flag)
		Method(_REG, 2, Serialized)
		{
			Name(dbgf, 1)

			if (dbgf) {
	            DNAM (Arg0, Arg1, "\\m701._REG")
			}

			Store(Match(PRSK, MEQ, arg0, MTR, 0, 1), Local0)

			if (LAnd(LGreater(arg0, 0x7f), LLess(arg0, 0x100))) {
				Store(0, Local0)
			}

			if (LLess(Local0, NRSK)) {
				Store(Index(VRSK, Local0), Local1)
				Store(Refof(Local1), Local2)
				Add(Derefof(Local1), 1, Derefof(Local2))
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

		// Combination of the OperationRegion operator arguments

		OperationRegion(RGN0, SystemMemory,     0x2000, 0x100)
		OperationRegion(RGN1, SystemIO,         0x2200, 0x300)
		OperationRegion(RGN2, PCI_Config,       0x2400, 0x500)
		OperationRegion(RGN3, EmbeddedControl,  0x2600, 0x700)
		OperationRegion(RGN4, SMBus,            0x2800, 0x900)
		OperationRegion(RGN5, SystemCMOS,       0x2a00, 0xb00)
		OperationRegion(RGN6, PciBarTarget,     0x2c00, 0xd00)

		// UserDefRegionSpace

		OperationRegion(RGN7, 0x80,             0, 0x100)
		OperationRegion(RGN8, 0xa5,             0, 0x100)
		OperationRegion(RGN9, 0xff,             0, 0x100)

        // ACPI 4/5 new space IDs

        OperationRegion(RGNa, IPMI,             0x2e00, 0xf00)
        OperationRegion(RGNb, GeneralPurposeIo, 0x3000, 0x1100)
        OperationRegion(RGNc, GenericSerialBus, 0x3200, 0x1300)

		// Incorrect call
		_REG(FRSK, 2)
	}
}

// Check Global OpRegions initialization
// m700(CallChain)
// CallChain: String
Method(m700, 1)
{
	Concatenate(arg0, "-m700", arg0)

	// Check incorrect calls

	if (LNotEqual(IRSK, 0)) {
		err(arg0, z141, 1, 0, 0, IRSK, 0)
	}
	if (LNotEqual(IFLG, 0)) {
		err(arg0, z141, 2, 0, 0, IFLG, 0)
	}

	if (LNotEqual(\DOR0.IRSK, 0)) {
		err(arg0, z141, 3, 0, 0, IRSK, 0)
	}
	if (LNotEqual(\DOR0.IFLG, 0)) {
		err(arg0, z141, 4, 0, 0, IFLG, 0)
	}

	// Emulate and verify incorrect calls

	_REG(FRSK, 2)
	\DOR0._REG(FRSK, 2)

	if (LNotEqual(IRSK, 1)) {
		err(arg0, z141, 5, 0, 0, IRSK, 1)
	}
	if (LNotEqual(IFLG, 1)) {
		err(arg0, z141, 6, 0, 0, IFLG, 1)
	}
	if (LNotEqual(\DOR0.IRSK, 1)) {
		err(arg0, z141, 7, 0, 0, IRSK, 1)
	}
	if (LNotEqual(\DOR0.IFLG, 1)) {
		err(arg0, z141, 8, 0, 0, IFLG, 1)
	}

	// Check total calls to \_REG

	if (LNotEqual(Derefof(Index(VFLG, 1)), 9)) {
		err(arg0, z141, 9, 0, 0, Derefof(Index(VFLG, 1)), 9)
	}
	m70e(arg0, 1, VRSK, ERSK, 10)

	// Check total calls to \DOR0._REG

	if (LNotEqual(Derefof(Index(\DOR0.VFLG, 1)), 6)) {
		err(arg0, z141, 11, 0, 0, Derefof(Index(\DOR0.VFLG, 1)), 6)
	}
	m70e(arg0, 1, \DOR0.VRSK, \DOR0.ERSK, 12)
}

// Check Dynamic OpRegions initialization
// m701(CallChain)
// CallChain: String
Method(m701, 1)
{
	Concatenate(arg0, "-m701", arg0)

	if (LNotEqual(\DOR1.IREG, 0)) {
		err(arg0, z141, 13, 0, 0, \DOR1.IREG, 0)
	}
	if (LNotEqual(\DOR1.IRSK, 0)) {
		err(arg0, z141, 14, 0, 0, \DOR1.IRSK, 0)
	}
	if (LNotEqual(\DOR1.IFLG, 0)) {
		err(arg0, z141, 15, 0, 0, \DOR1.IFLG, 0)
	}
	if (LNotEqual(Derefof(Index(\DOR1.VFLG, 1)), 0)) {
		err(arg0, z141, 16, 0, 0, Derefof(Index(\DOR1.VFLG, 1)), 0)
	}
	m70e(arg0, 2, \DOR1.VRSK, 0, 17)

	\DOR1.M000()

	if (LNotEqual(\DOR1.IREG, 0)) {
		err(arg0, z141, 18, 0, 0, \DOR1.IREG, 1)
	}
	if (LNotEqual(\DOR1.IRSK, 1)) {
		err(arg0, z141, 19, 0, 0, \DOR1.IRSK, 1)
	}
	if (LNotEqual(\DOR1.IFLG, 1)) {
		err(arg0, z141, 20, 0, 0, \DOR1.IFLG, 1)
	}

	// Check total calls to \DOR1._REG

	if (LNotEqual(Derefof(Index(\DOR1.VFLG, 1)), 6)) {
		err(arg0, z141, 21, 0, 0, Derefof(Index(\DOR1.VFLG, 1)), 6)
	}
	m70e(arg0, 1, \DOR1.VRSK, \DOR1.ERSK, 22)
}

// Check OpRegion Length restrictions
// m702(CallChain)
// CallChain: String
Method(m702, 1)
{
	Concatenate(arg0, "-m702", arg0)

	Store(Sizeof(p702), Local0)
	Store(Divide(Local0, 3), Local0)
	Store(0, Local1)

	Store(2, Local1)
	Subtract(Local0, 2, Local0)

	While (Local0) {
		m70c(arg0, p702, Local1)
		Decrement(Local0)
		Increment(Local1)
	}
}

// Check Overlapping of OpRegions
// m703(CallChain)
// CallChain: String
Method(m703, 1, Serialized)
{
	Concatenate(arg0, "-m703", arg0)

	// Overlap \RGN0 - \RGN9

	OperationRegion(RGN0, SystemMemory, 0x80, 0x121)
	OperationRegion(RGN1, SystemIO, 0x280, 0x123)
	OperationRegion(RGN2, PCI_Config, 0x480, 0x125)
	OperationRegion(RGN3, EmbeddedControl, 0x680, 0x127)
	OperationRegion(RGN4, SMBus, 0x880, 0x109)
	OperationRegion(RGN5, SystemCMOS, 0xa80, 0x12b)
	OperationRegion(RGN6, PciBarTarget, 0xc80, 0x12d)

	// UserDefRegionSpace
	OperationRegion(RGN7, 0x80, 0xd80, 0x137)
	OperationRegion(RGN8, 0xcf, 0xe80, 0x138)
	OperationRegion(RGN9, 0xff, 0xf80, 0x139)

	OperationRegion(RGNa, SystemMemory, 0x1090, 0x14a)

	// Unsupported cases commented

	m70f(arg0, \RGN0, RGN0, 1, 0)
	m70f(arg0, \RGN1, RGN1, 1, 1)

	//  m70f(arg0, \RGN2, RGN2, 1, 2)
	//  m70f(arg0, \RGN3, RGN3, 1, 3)
	//  m70f(arg0, \RGN4, RGN4, 1, 4)
	//  m70f(arg0, \RGN5, RGN5, 1, 5)
	//  m70f(arg0, \RGN6, RGN6, 1, 6)

	m70f(arg0, \RGN7, RGN7, 1, 7)

	//  m70f(arg0, \RGN8, RGN8, 1, 8)
	//  m70f(arg0, \RGN9, RGN9, 1, 9)

	m70f(arg0, \DOR0.RGN0, RGNa, 0, 10)
}

// Create Region Field about Region Length in length
// and check possible exception
// m70c(CallChain, Task, Index)
Method(m70c, 3, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x1000)

	Concatenate(arg0, "-m70c", arg0)

	Multiply(arg2, 3, Local4)

	Add(Local4, 1, Local0)
	Store(Derefof(Index(arg1, Local0)), Local3)

	Increment(Local0)
	Store(Derefof(Index(arg1, Local0)), Local2)
	Multiply(Local2, 8, Local1)

	Name(b000, Buffer(0x100){})

	CopyObject(Derefof(Index(arg1, Local4)), OPRm)

	Field(OPRm, ByteAcc, NoLock, Preserve) {
		FU01, 0x800}
	Store(Refof(FU01), Local6)

	Store(Refof(Local6), Local5)

	m70d(arg2, b000)

	if (LEqual(Local3, 0x02 /* PCI_Config */)) {}
	elseif (LEqual(Local3, 0x03 /* EmbbededControl */)) {}
	elseif (LEqual(Local3, 0x04 /* SMBus */)) {}
	elseif (LEqual(Local3, 0x05 /* SystemCMOS */)) {}
	elseif (LEqual(Local3, 0x06 /* PciBarTarget */)) {}
	elseif (LGreater(Local3, 0x80 /* UserDefRegionSpace <> 0x80 */)) {}

	else {
		Store(b000, Derefof(Local5))

		CH03(arg0, z141, 24, arg2, Local3)

		Store(ObjectType(Derefof(Local6)), Local0)
		Store(c00b, Local1)
		if (LNotEqual(Local0, Local1)) {
			err(arg0, z141, 25, 0, 0, Local0, Local1)
		} else {
			Store(Derefof(Local6), Local0)
			if (LNotEqual(Local0, b000)) {
				err(arg0, z141, 26, z141, arg2, Local0, b000)
			}
		}
	}
}

// Fill the buffer
// m70d(Source, Target)
// Source: 0x100 - index, else - this byte
// Target: buffer for filling
Method(m70d, 2, Serialized)
{
	Store(Sizeof(arg1), Local0)

	while(Local0) {
		Decrement(Local0)

		switch (ToInteger (arg0)) {
			case (0x100) {
				Store(Local0, Index(arg1, Local0))
			}
			default {
				Store(arg0, Index(arg1, Local0))
			}
		}
	}
}

// Processes the VRSK
// m70e(CallChain, ToDo, Results, Benchmark, ErrId)
// CallChain: String
// ToDo:      0 - nullify, 1 - Check Values, 2 - check if null
// Results:   actual VRSK Values
// Benchmark: expected VRSK Values
// ErrId:     index of the error
Method(m70e, 5, Serialized)
{
	Concatenate(arg0, "-m70e", arg0)

	Store(NRSK, Local0)

	while (Local0) {
		Decrement(Local0)
		Store(Index(arg2, Local0), Local1)
		Store(Refof(Local1), Local2)

		switch(ToInteger (arg1)) {
			case (0) {
				Store (0, Derefof(Local2))
			}
			case (1) {
				Store(Index(arg3, Local0), Local3)
				if (LNotEqual(DeRefof(Local1), DeRefof(Local3))) {
					err(arg0, z141, arg4, z141, Local0, DeRefof(Local1), DeRefof(Local3))
				}
			}
			case (2) {
				if (LNotEqual(DeRefof(Local1), 0)) {
					err(arg0, z141, arg4, z141, Local0, DeRefof(Local1), 0)
				}
			}
		}
	}
}

// Create Region Fields in two overlapping Regions
// and check overlapping parts to be shared
// m70f(CallChain, OpRegion0, OpRegion1, RangeNum, ErrNum)
Method(m70f, 5, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x1000)
	OperationRegion(OPRn, 0xff, 0, 0x1000)

	CopyObject(arg1, OPRm)
	CopyObject(arg2, OPRn)

	Field(OPRm, ByteAcc, NoLock, Preserve) {
		Offset(0x7d), FU00, 0x50,
		Offset(0x8d), FU02, 0x50}

	Field(OPRn, ByteAcc, NoLock, Preserve) {
		FU01, 0x50}

	Concatenate(arg0, "-m70f", arg0)

	Name(b000, Buffer(0xa){})


	m70d(1, b000)
	if (arg3) {
		Store(b000, FU00)
	} else {
		Store(b000, FU02)
	}

	m70d(2, b000)
	Store(b000, FU01)

	if (arg3) {
		Store(FU00, Local0)
	} else {
		Store(FU02, Local0)
	}

	Store(Buffer(){1,1,1,2,2,2,2,2,2,2}, Local1)

	if (LNotEqual(Local0, Local1)) {
		err(arg0, z141, 27, z141, arg4, Local0, Local1)
	}
}

// Check that the same ranges of different Address Spaces
// actually refer the different locations
// m704(CallChain)
// CallChain: String
Method(m704, 1, Serialized)
{
	Method(CHCK, 4)
	{
		if (LNotEqual(arg1, arg2)) {
			err(arg0, z141, 28, z141, arg3, arg1, arg2)
		}
	}

	OperationRegion(OPR0, SystemMemory, 0x00, 0x01)
	OperationRegion(OPR1, SystemIO, 0x00, 0x01)
	OperationRegion(OPR7, 0x80, 0x00, 0x01)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		f000, 8,
	}
	Field(OPR1, ByteAcc, NoLock, Preserve) {
		f001, 8,
	}
	Field(OPR7, ByteAcc, NoLock, Preserve) {
		f002, 8,
	}

	Concatenate(arg0, "-m704", arg0)

	Store(0x5a, f000)
	CHCK(arg0, f000, 0x5a, 0)

	Store(0xc3, f001)
	CHCK(arg0, f001, 0xc3, 1)

	Store(0x96, f002)
	CHCK(arg0, f002, 0x96, 2)

	CHCK(arg0, f000, 0x5a, 3)

	CHCK(arg0, f001, 0xc3, 4)

	CHCK(arg0, f002, 0x96, 5)
}

// Check non-constant OpRegion arguments
// m705(CallChain)
// CallChain: String
Method(m705, 1, Serialized)
{
	Name(i000, 0x56)
	Name(i001, 0x78)
	Name(i002, 0x89abcdef)

	// ArgX
	Method(m000, 4, Serialized) {
		switch(ToInteger (arg1)) {
			case(0) {
				OperationRegion(OPR0, SystemMemory, arg2, arg3)
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					f000, 32,
				}
				Store(Refof(f000), Local5)
			}
			case(1) {
				OperationRegion(OPR1, SystemIO, arg2, arg3)
				Field(OPR1, ByteAcc, NoLock, Preserve) {
					f001, 32,
				}
				Store(Refof(f001), Local5)
			}
			case(2) {
				OperationRegion(OPR7, 0x80, arg2, arg3)
				Field(OPR7, ByteAcc, NoLock, Preserve) {
					f007, 32,
				}
				Store(Refof(f007), Local5)
			}
		}

		Store(Refof(Local5), Local6)

		Store(i002, Derefof(Local6))
		Store(DeRefof(Local5), Local7)
		if (LNotEqual(i002, Local7)) {
			err(arg0, z141, 29, z141, arg1, Local7, i002)
		}
	}

	// Named
	Method(m001, 2, Serialized) {
		switch(ToInteger (arg1)) {
			case(0) {
				OperationRegion(OPR0, SystemMemory, i000, i001)
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					f000, 32,
				}
				Store(Refof(f000), Local5)
			}
			case(1) {
				OperationRegion(OPR1, SystemIO, i000, i001)
				Field(OPR1, ByteAcc, NoLock, Preserve) {
					f001, 32,
				}
				Store(Refof(f001), Local5)
			}
			case(2) {
				OperationRegion(OPR7, 0x80, i000, i001)
				Field(OPR7, ByteAcc, NoLock, Preserve) {
					f007, 32,
				}
				Store(Refof(f007), Local5)
			}
		}

		Store(Refof(Local5), Local6)

		Store(i002, Derefof(Local6))
		Store(DeRefof(Local5), Local7)
		if (LNotEqual(i002, Local7)) {
			err(arg0, z141, 30, z141, arg1, Local7, i002)
		}
	}

	// LocalX
	Method(m002, 2, Serialized) {
		Store(i000, Local0)
		Store(i001, Local1)

		switch(ToInteger (arg1)) {
			case(0) {
				OperationRegion(OPR0, SystemMemory, Local0, Local1)
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					f000, 32,
				}
				Store(Refof(f000), Local5)
			}
			case(1) {
				OperationRegion(OPR1, SystemIO, Local0, Local1)
				Field(OPR1, ByteAcc, NoLock, Preserve) {
					f001, 32,
				}
				Store(Refof(f001), Local5)
			}
			case(2) {
				OperationRegion(OPR7, 0x80, Local0, Local1)
				Field(OPR7, ByteAcc, NoLock, Preserve) {
					f007, 32,
				}
				Store(Refof(f007), Local5)
			}
		}

		Store(Refof(Local5), Local6)

		Store(i002, Derefof(Local6))
		Store(DeRefof(Local5), Local7)
		if (LNotEqual(i002, Local7)) {
			err(arg0, z141, 31, z141, arg1, Local7, i002)
		}
	}


	// Expression
	Method(m003, 2, Serialized) {
		Store(i001, Local1)

		switch(ToInteger (arg1)) {
			case(0) {
				OperationRegion(OPR0, SystemMemory, Add(i000, 1), Subtract(Local1, 1))
				Field(OPR0, ByteAcc, NoLock, Preserve) {
					f000, 32,
				}
				Store(Refof(f000), Local5)
			}
			case(1) {
				OperationRegion(OPR1, SystemIO, Add(i000, 1), Subtract(Local1, 1))
				Field(OPR1, ByteAcc, NoLock, Preserve) {
					f001, 32,
				}
				Store(Refof(f001), Local5)
			}
			case(2) {
				OperationRegion(OPR7, 0x80, Add(i000, 1), Subtract(Local1, 1))
				Field(OPR7, ByteAcc, NoLock, Preserve) {
					f007, 32,
				}
				Store(Refof(f007), Local5)
			}
		}

		Store(Refof(Local5), Local6)

		Store(i002, Derefof(Local6))
		Store(DeRefof(Local5), Local7)
		if (LNotEqual(i002, Local7)) {
			err(arg0, z141, 32, z141, arg1, Local7, i002)
		}
	}

	Concatenate(arg0, "-m705", arg0)

	m000(arg0, 0, 0x12, 0x34)
	m000(arg0, 1, 0x12, 0x34)
	m000(arg0, 2, 0x12, 0x34)

	m001(arg0, 0)
	m001(arg0, 1)
	m001(arg0, 2)

	m002(arg0, 0)
	m002(arg0, 1)
	m002(arg0, 2)

	m003(arg0, 0)
	m003(arg0, 1)
	m003(arg0, 2)
}

// Check non-Integer OpRegion arguments
// m706(CallChain)
// CallChain: String
Method(m706, 1, Serialized)
{
	Name(off0, 0xfedcba987654321f)
	Name(offb, Buffer(8){0x1f, 0x32,, 0x54, 0x76, 0x98, 0xba, 0xdc, 0xfe})
	Name(offs, "7654321f")

	if (F64) {
		Store("fedcba987654321f", offs)
	}

	Name(len0, 0x123)
	Name(lenb, Buffer(2){0x23, 0x01})
	Name(lens, "123")

	OperationRegion(OPR0, SystemMemory, 0xfedcba987654321f, 0x123)
	OperationRegion(OPR1, SystemMemory, off0, len0)
	OperationRegion(OPR2, SystemMemory, offb, lenb)
	OperationRegion(OPR3, SystemMemory, offs, lens)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		Offset(0x11f),
		FU00, 0x20}
	Field(OPR1, ByteAcc, NoLock, Preserve) {
		Offset(0x11f),
		FU01, 0x20}
	Field(OPR2, ByteAcc, NoLock, Preserve) {
		Offset(0x11f),
		FU02, 0x20}
	Field(OPR3, ByteAcc, NoLock, Preserve) {
		Offset(0x11f),
		FU03, 0x20}

	Name(i000, 0x12345678)

	Method(m000, 4, Serialized) {
		OperationRegion(OPR4, SystemMemory, arg1, arg2)

		Field(OPR4, AnyAcc, NoLock, Preserve) {
			Offset(0x11f),
			FU04, 0x20}

		if (LNotEqual(FU04, i000)) {
			err(arg0, z141, arg3, 0, 0, FU04, i000)
		}
	}

	Concatenate(arg0, "-m706", arg0)

	Store(i000, FU00)

	if (LNotEqual(FU00, i000)) {
		err(arg0, z141, 33, 0, 0, FU00, i000)
	}

	if (LNotEqual(0xfedcba987654321f, off0)) {
		err(arg0, z141, 34, 0, 0, off0, 0xfedcba987654321f)
	} elseif (LNotEqual(0x123, len0)) {
		err(arg0, z141, 35, 0, 0, len0, 0x123)
	} elseif (LNotEqual(FU01, i000)) {
		err(arg0, z141, 36, 0, 0, FU00, i000)
	}

	if (LNotEqual(0xfedcba987654321f, offb)) {
		err(arg0, z141, 37, 0, 0, offb, 0xfedcba987654321f)
	} elseif (LNotEqual(0x123, lenb)) {
		err(arg0, z141, 38, 0, 0, lenb, 0x123)
	} elseif (LNotEqual(FU02, i000)) {
		err(arg0, z141, 39, 0, 0, FU00, i000)
	}

	if (LNotEqual(0xfedcba987654321f, offs)) {
		Add(offs, 0, Local0)
		err(arg0, z141, 40, 0, 0, Local0, 0xfedcba987654321f)
	} elseif (LNotEqual(0x123, lens)) {
		Add(lens, 0, Local0)
		err(arg0, z141, 41, 0, 0, Local0, 0x123)
	} elseif (LNotEqual(FU03, i000)) {
		err(arg0, z141, 42, 0, 0, FU00, i000)
	}

	m000(arg0, off0, len0, 43)
	m000(arg0, offb, lenb, 44)
	m000(arg0, offs, lens, 45)
}

// Overlapping Operation Regions algorithm test
// Test the 3 conditional cases of overlap
// Test done only in SystemMemory
Method(m707, 1, Serialized)
{
	OperationRegion(RGN0, SystemMemory, 0x100, 0x8)
	OperationRegion(RGN1, SystemMemory, 0xFB, 0x8)
	OperationRegion(RGN2, SystemMemory, 0x105, 0x8)
	OperationRegion(RGN3, SystemMemory, 0xF9, 0x16)
	OperationRegion(RGN4, SystemMemory, 0xF9, 0x16)

	// Starting Field
	Field (RGN0, ByteAcc, NoLock, Preserve) {
		Offset(0x1), FU00, 0x30
	}

	// Overlap start of RGN0
	Field (RGN1, ByteAcc, NoLock, Preserve) {
		Offset(0x2), FU10, 0x30
	}

	// Overlap end of RGN0
	Field (RGN2, ByteAcc, NoLock, Preserve) {
		FU20, 0x30
	}

	// Overlap both start of RGN1 and end of RGN2
	Field (RGN3, ByteAcc, NoLock, Preserve) {
		FU30, 0x30,
		Offset(0x8), FU31, 0x10,
		Offset(0xC), FU32, 0x10,
		Offset(0x10), FU33, 0x30
	}

	// Single Field spanning RGN3 area
	Field (RGN4, ByteAcc, NoLock, Preserve) {
		FU40, 0xB0
	}

	Name(b000, Buffer(0x6){})
	Name(b001, Buffer(0x2){})

	// Starting region write
	m70d(1, b000)
	Store(b000, FU00)

	// New region overlapping the left
	m70d(2, b000)
	Store(b000, FU10)

	// New region overlapping the right
	m70d(3, b000)
	Store(b000, FU20)

	// New region overlapping left and right with writes
	// at various locations
	m70d(4, b000)
	Store(b000, FU30)

	m70d(5, b001)
	Store(b001, FU31)

	m70d(6, b001)
	Store(b001, FU32)

	m70d(7, b000)
	Store(b000, FU33)

	Store(FU40, Local0)
	Store(Buffer(){4,4,4,4,4,4,2,2,5,5,1,1,6,6,3,3,7,7,7,7,7,7}, Local1)

	if (LNotEqual(Local0, Local1)) {
		err(arg0, z141, 43, 0, 0, Local0, Local1)
	}
}

Method(ORC0,, Serialized)
{
	Name(ts, "ORC0")

	// Global OpRegions
	SRMT("m700")
	if (y220) {
		m700(ts)
	} else {
		BLCK()
	}

	// Dynamic OpRegions
	SRMT("m701")
	if (y217) {
		m701(ts)
	} else {
		BLCK()
	}

	// OpRegion Lengths
	SRMT("m702")
	m702(ts)


	// Overlapping of OpRegions
	SRMT("m703")
	if (y221) {
		m703(ts)
	} else {
		BLCK()
	}

	// The same ranges of different Address Spaces
	SRMT("m704")
	if (y222) {
		m704(ts)
	} else {
		BLCK()
	}

	// Non-constant OpRegion arguments
	SRMT("m705")
	m705(ts)

	// Non-Integer OpRegion arguments
	SRMT("m706")
	m706(ts)

	// Overlapping OpRegions algorithm test
	SRMT("m707")
	m707(ts)
}
