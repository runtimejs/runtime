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
 * Load ASL operator functionality
 */

/*
 * This sub-test is intended to comprehensively verify
 * the Load ASL operator functionality.
 *
 * Performs a run-time load of a Definition Block.
 *
 *    17.5.67   Load (Load Definition Block)
 *    Syntax
 * Load (Object, DDBHandle)
 *
 * On testing the following issues should be covered:
 *
 * - loading SSDT from a SystemMemory OpRegion,
 *
 * - loading SSDT from a Region Field in a OpRegion of any type,
 *
 * - "namespace location to load the Definition Block is relative
 *   to the current namespace" scope,
 *
 * - loading a number of different SSDTs,
 *
 * - global and dynamic declarations of OpRegions and the appropriate
 *   _REG Methods invocation for the loaded SSDT,
 *
 * - global and dynamic declarations of OpRegions and Region Fields,
 *   containing the loaded SSDT,
 *
 * - an Object of any type can be used as the DDBHandle argument,
 *
 * - the DDBHandle argument of the Load operator becames an Object
 *   of the DDBHandle type,
 *
 * - the DDBHandle Object returned from the Load operator can be used
 *   to unload the SSDT,
 *
 * - exceptional conditions caused by inappropriate data:
 *   = the Object argument does not refer to an operation region field
 *     or an operation region,
 *   = an OpRegion passed as the Object argument is not of SystemMemory type,
 *   = the table contained in an OpRegion (Field) is not an SSDT,
 *   = the length of the supplied SSDT is greater than the length of the
 *     respective OpRegion or Region Field,
 *   = the length of the supplied SSDT is less than the length the Header
 *   = the checksum of the supplied SSDT is invalid,
 *   = AE_OWNER_ID_LIMIT exception when too many Tables loaded,
 *   = the specified SSDT is already loaded,
 *   = there already is an previously loaded Object referred by the path
 *     in the Namespace.
 *
 * Can not be tested following issues:
 * - providing of the table referenced by Load to be "in memory marked by
 *   AddressRangeReserved or AddressRangeNVS",
 * - overriding the supplied SSDT with "a newer revision Definition Block
 *   of the same OEM Table ID" by the OS,
 * - loading a SSDT to be a synchronous operation ("the control methods
 *   defined in the Definition Block are not executed during load time")
 */

		// Integer
		External(\AUXD.INT0)
		// String
		External(\AUXD.STR0)
		// Buffer
		External(\AUXD.BUF0)
		// Package
		External(\AUXD.PAC0)
		// Device
		External(\AUXD.DEV0)
		// Event
		External(\AUXD.EVE0)
		// Method
		External(\AUXD.MMM0)
		// Mutex
		External(\AUXD.MTX0)
		// Power Resource
		External(\AUXD.PWR0)
		// Processor
		External(\AUXD.CPU0)
		// Thermal Zone
		External(\AUXD.TZN0)
		// Buffer Field
		External(\AUXD.BFL0)
		// Field Unit
		External(\AUXD.FLU0)
		// OpRegion
		External(\AUXD.OPR0)
		
Name(z174, 174)

Device(DTM0) {

	// Originated from ssdt0.asl: iasl -tc ssdt0.asl
	Name(BUF0, Buffer() {
		0x53,0x53,0x44,0x54,0x34,0x00,0x00,0x00,  /* 00000000    "SSDT4..." */
		0x02,0x98,0x49,0x6E,0x74,0x65,0x6C,0x00,  /* 00000008    "..Intel." */
		0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00,  /* 00000010    "Many...." */
		0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
		0x15,0x12,0x06,0x20,0x14,0x0F,0x5C,0x53,  /* 00000020    "... ..\S" */
		0x53,0x53,0x30,0x00,0xA4,0x0D,0x5C,0x53,  /* 00000028    "SS0...\S" */
		0x53,0x53,0x30,0x00,
	})

	Name (SNML, "0123456789ABCDEF")
	Name (NNML, 16) // <= sizeof (SNML)

	// Take into account AE_OWNER_ID_LIMIT
	Name (HI0M, 256) // <= (NNML * NNML)

	Name (HI0P, Package(HI0M){})
	Name (HI0N, 0)
	Name (INIF, 0x00)

	OperationRegion (IST0, SystemMemory, 0, 0x34)

	Field(IST0, ByteAcc, NoLock, Preserve) {
		RFU0, 0x1a0,
	}

	Field(IST0, ByteAcc, NoLock, Preserve) {
		SIG, 32,
		LENG, 32,
		REV, 8,
		SUM, 8,
		OID, 48,
		OTID, 64,
		OREV, 32,
		CID, 32,
		CREV, 32,
		Offset(39),
		SSNM, 32
	}

	// components/utilities/utmisc.c AcpiUtGenerateChecksum() analog
	Method(CHSM, 2, Serialized)	// buf, len
	{
		Name(lpN0, 0)
		Name(lpC0, 0)

		Store(0, Local0) // sum

		Store(arg1, lpN0)
		Store(0, lpC0)

		While(lpN0) {
			Store(DeRefOf(Index(arg0, lpC0)), Local1)
			Add(Local0, Local1, Local0)
			Mod(Local0, 0x100, Local0)
			Decrement(lpN0)
			Increment(lpC0)
		}

		Subtract(0, Local0, Local0)
		Mod(Local0, 0x100, Local0)

		Store("checksum", Debug)
		Store(Local0, Debug)

		return (Local0)
	}

	// Initializes multiple Tables Load test
	Method(INIT)
	{
		Store(Sizeof(SNML), Local0)
		if (LGreater(NNML, Local0)) {
			Store(Concatenate("INIT: test error, check NNML <= Sizeof(SNML):",
				ToDecimalString(Local0)), Debug)
			Return (1)
		}
		Multiply(Local0, Local0, Local0)
		if (LGreater(HI0M, Local0)) {
			Store(Concatenate("INIT: test error, check HI0M <= 0x",
				Local0), Debug)
			Return (1)
		}

		if (INIF) {
			Store("INIT: OpRegion has been initialized previously", Debug)
			Return (1)
		}

		Store(BUF0, RFU0)
		Store(1, INIF)
		Store("INIT: OpRegion initialized with SSDT", Debug)

		Return (0)
	}

	// Prepares and Loads the next Table of multiple Tables Load test
	Method(LD,, Serialized)
	{
		if (LNot(LLess(HI0N, HI0M))) {
			Store("LD: too many tables loaded", Debug)
			Return (1)
		}
		
		Multiply(HI0N, 0x30, Local2)
		
		OperationRegion (IST0, SystemMemory, Local2, 0x34)

		Field(IST0, ByteAcc, NoLock, Preserve) {
			RFU0, 0x1a0,
		}

		Field(IST0, ByteAcc, NoLock, Preserve) {
			SIG, 32,
			LENG, 32,
			REV, 8,
			SUM, 8,
			OID, 48,
			OTID, 64,
			OREV, 32,
			CID, 32,
			CREV, 32,
			Offset(39),
			SSNM, 32,
			Offset(47),
			SSRT, 32
		}

		Store(BUF0, RFU0)

		// Modify Revision field of SSDT
		Store(Add(CREV, 1), CREV)

		// Modify SSNM Object Name
		Divide(HI0N, NNML, Local0, Local1)
		Store(Derefof(Index(SNML, Local1)), Local1)
		ShiftLeft(Local1, 16, Local1)
		Store(Derefof(Index(SNML, Local0)), Local0)
		ShiftLeft(Local0, 24, Local0)
		Add(Local0, Local1, Local0)
		Add(Local0, 0x5353, Local0)
		Store(Local0, SSNM)
		Store(SSNM, Debug)

		// Modify SSNM Method Return String
		Store(Local0, SSRT)

		// Recalculate and save CheckSum
		Store(RFU0, Local0)
		Store(Add(SUM, CHSM(Local0, SizeOf (Local0))), SUM)

		Load(RFU0, Index(HI0P, HI0N))
		Increment(HI0N)
		Store("LD: SSDT Loaded", Debug)

		Return (0)
	}

	// UnLoads the last Table of multiple Tables Load test
	Method(UNLD)
	{
		if (LEqual(HI0N, 0)) {
			Store("UNLD: there are no SSDT loaded", Debug)
			Return (1)
		}
		Decrement(HI0N)

		UnLoad(DerefOf(Index(HI0P, HI0N)))
		Store("UNLD: SSDT UnLoaded", Debug)

		Return (0)
	}

	External(\SSS0, MethodObj)

	Name(HI0, 0)

	// Simple Load test auxiliary method
	// Arg1: DDBH, 0 - Local Named, 1 - Global Named,
	//             2 - LocalX, 3 - element of Package
	Method(m000, 2, Serialized)
	{
		Name(HI0, 0)
		Name(PHI0, Package(1){})

		Concatenate(arg0, "-m000", arg0)

		Store(BUF0, RFU0)

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z174, 0x000, 0, 0, "\\SSS0", 1)
			return
		}

		// Modify Revision field of SSDT
		Store(Add(CREV, 1), CREV)

		// Recalculate and save CheckSum
		Store(RFU0, Local0)
		Store(Add(SUM, CHSM(Local0, SizeOf (Local0))), SUM)

		if (CH03(arg0, z174, 0x001, 0, 0)) {
			return
		}

		// Load operator execution
		switch (ToInteger (arg1)) {
			case (0) {Load(RFU0, HI0)}
			case (1) {Load(RFU0, \DTM0.HI0)}
			case (2) {Load(RFU0, Local2)}
			case (3) {Load(RFU0, Index(PHI0, 0))}
			default {
				Store("Unexpected parameter of the test", Debug)
				err(arg0, z174, 0x002, 0, 0, "\\SSS0", 1)
				return
			}
		}

		if (CH03(arg0, z174, 0x003, 0, 0)) {
			return
		}

		Store("Table Loaded", Debug)

		// Check DDBHandle ObjectType
		if (y260) {
			switch (ToInteger (arg1)) {
				case (0) {Store(ObjectType(HI0), Local1)}
				case (1) {Store(ObjectType(\DTM0.HI0), Local1)}
				case (2) {Store(ObjectType(Local2), Local1)}
				case (3) {Store(ObjectType(Index(PHI0, 0)), Local1)}
			}
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z174, 0x004, 0, 0, Local1, c017)
			}
		}

		// Check the new Object appears

		if (CondRefof(\SSS0, Local0)) {
		} else {
			err(arg0, z174, 0x005, 0, 0, "\\SSS0", 0)
		}

		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c010)) { // Method
			err(arg0, z174, 0x006, 0, 0, Local1, c010)
		} else {
			Store(\SSS0(), Local0)
			if (CH03(arg0, z174, 0x007, "\\SSS0", 1)) {
				return
			}
			if (LNotEqual("\\SSS0", Local0)) {
				err(arg0, z174, 0x008, 0, 0, Local0, "\\SSS0")
			}
		}

		// UnLoad operator execution
		switch (ToInteger (arg1)) {
			case (0) {UnLoad(HI0)}
			case (1) {UnLoad(\DTM0.HI0)}
			case (2) {UnLoad(Local2)}
			case (3) {UnLoad(DeRefof(Index(PHI0, 0)))}
		}

		if (CH03(arg0, z174, 0x009, 0, 0)) {
			return
		}

		Store("Table Unloaded", Debug)

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z174, 0x00a, 0, 0, "\\SSS0", 1)
		}

		return
	}

	// Simple Load test auxiliary method for ArgX, part1
	// Arg1 - reference to store the DDBHandle
	Method(m001, 2)
	{
		Concatenate(arg0, "-m001", arg0)

		Store(BUF0, RFU0)

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z174, 0x00b, 0, 0, "\\SSS0", 1)
			return (1)
		}

		// Modify Revision field of SSDT
		Store(Add(CREV, 1), CREV)

		// Recalculate and save CheckSum
		Store(RFU0, Local0)
		Store(Add(SUM, CHSM(Local0, SizeOf (Local0))), SUM)

		if (CH03(arg0, z174, 0x00c, 0, 0)) {
			return (1)
		}

		// Load operator execution
		Load(RFU0, Arg1)

		if (CH03(arg0, z174, 0x00d, 0, 0)) {
			return (1)
		}

		Store("SSDT Loaded", Debug)

		return (0)
	}

	// Simple Load test auxiliary method for ArgX, part2
	// Arg1 - DDBHandle
	Method(m002, 2)
	{
		Concatenate(arg0, "-m002", arg0)

		// Check DDBHandle ObjectType
		if (y260) {
			Store(ObjectType(Arg1), Local1)
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z174, 0x00e, 0, 0, Local1, c017)
			}
		}

		// Check the new Object appears

		if (CondRefof(\SSS0, Local0)) {
		} else {
			err(arg0, z174, 0x00f, 0, 0, "\\SSS0", 0)
		}

		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c010)) { // Method
			err(arg0, z174, 0x010, 0, 0, Local1, c010)
		} else {
			Store(\SSS0(), Local0)
			if (CH03(arg0, z174, 0x011, "\\SSS0", 1)) {
				return
			}
			if (LNotEqual("\\SSS0", Local0)) {
				err(arg0, z174, 0x012, 0, 0, Local0, "\\SSS0")
			}
		}

		UnLoad(Arg1)

		if (CH03(arg0, z174, 0x013, 0, 0)) {
			return
		}

		Store("SSDT Unloaded", Debug)

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z174, 0x014, 0, 0, "\\SSS0", 1)
		}

		return
	}

	// Loading SSDT from a SystemMemory OpRegion,
	// different targets for DDBHandle.
	// Check DDBHandle storing into different Object locations:

	// DDBHandle storing into Named Integer
	Method(tst0, 1)
	{
		Concatenate(arg0, "-tst0", arg0)

		// Local Named Integer
		m000(arg0, 0)

		// Global Named Integer
		m000(arg0, 1)
	}

	// DDBHandle storing into LocalX
	Method(tst1, 1)
	{
		Concatenate(arg0, "-tst1", arg0)

		// LocalX
		m000(arg0, 2)
	}

	// DDBHandle storing into Package element
	Method(tst2, 1)
	{
		Concatenate(arg0, "-tst2", arg0)

		// Package element
		// Crash on copying the specific reference Object
		if (y261) {
			m000(arg0, 3)
		}
	}

	// DDBHandle storing into an Object by Reference in Argx
	Method(tst3, 1, Serialized)
	{
		Name(HI0, 0)

		Concatenate(arg0, "-tst3", arg0)

		// Named by Reference in ArgX
		if (m001(arg0, Refof(HI0))) {
			return
		}
		m002(arg0, HI0)

		// LocalX by Reference in ArgX
		if (m001(arg0, Refof(Local2))) {
			return
		}
		m002(arg0, Local2)

		// Package element by Reference in ArgX
		if (y133) {
			Name(PHI0, Package(1){0})
			Store(Index(PHI0, 0), Local0)
			if (m001(arg0, Local0)) {
				return
			}
			m002(arg0, DeRefof(Local0))
		}
		return
	}

	// Combination of the OperationRegion operator arguments

	OperationRegion(RGN0, SystemMemory, 0x00, 0x201)
	OperationRegion(RGN1, SystemIO, 0x200, 0x203)
	OperationRegion(RGN2, PCI_Config, 0x400, 0x205)
	OperationRegion(RGN3, EmbeddedControl, 0x600, 0x207)
	OperationRegion(RGN4, SMBus, 0x800, 0x209)
	OperationRegion(RGN5, SystemCMOS, 0xa00, 0x20b)
	OperationRegion(RGN6, PciBarTarget, 0xc00, 0x20d)

	// UserDefRegionSpace
	OperationRegion(RGN7, 0x80, 0xd00, 0x217)
	OperationRegion(RGN8, 0xcf, 0xe00, 0x218)
	OperationRegion(RGN9, 0xff, 0xf00, 0x219)

	// Loading SSDT from a Field of an OpRegion of any type,
	// different targets for DDBHandle.

	// Check DDBHandle storing into different Object locations:
	// Named Integer, LocalX, by Reference in Argx, etc.
	// m003(CallChain, Index, Region)
	Method(m003, 3)
	{
		Concatenate(arg0, "-m003", arg0)

		// Auxiliary method:
		// Arg1 - choice of a target
		// Arg2 - OpRegion Object of a specified type
		Method(m000, 3, Serialized)
		{
			Name(HI0, 0)
			Name(PHI0, Package(1){})

			OperationRegion(OPRm, 0xff, 0, 0x1000)

			Concatenate(arg0, "-m000", arg0)

			CopyObject(arg2, OPRm)

			Field(OPRm, ByteAcc, NoLock, Preserve) {
				RFU0, 0x1a0,
			}

			Field(OPRm, ByteAcc, NoLock, Preserve) {
				SIG, 32,
				LENG, 32,
				REV, 8,
				SUM, 8,
				OID, 48,
				OTID, 64,
				OREV, 32,
				CID, 32,
				CREV, 32,
				Offset(39),
				SSNM, 32
			}

			Store(BUF0, RFU0)

			if (CondRefof(\SSS0, Local0)) {
				err(arg0, z174, 0x015, 0, 0, "\\SSS0", 1)
				return
			}

			// Modify Revision field of SSDT
			Store(Add(CREV, 1), CREV)

			// Recalculate and save CheckSum
			Store(RFU0, Local0)
			Store(Add(SUM, CHSM(Local0, SizeOf (Local0))), SUM)

			if (CH03(arg0, z174, 0x016, 0, 0)) {
				return
			}

			// Load operator execution
			switch (ToInteger (arg1)) {
				case (0) {Load(RFU0, HI0)}
				case (1) {Load(RFU0, \DTM0.HI0)}
				case (2) {Load(RFU0, Local2)}
				case (3) {Load(RFU0, Index(PHI0, 0))}
				default {
					Store("Unexpected parameter of the test", Debug)
					err(arg0, z174, 0x017, 0, 0, "\\SSS0", 1)
					return
				}
			}

			if (CH03(arg0, z174, 0x018, 0, 0)) {
				return
			}

			Store("SSDT Loaded", Debug)

			// Check DDBHandle ObjectType
			if (y260) {
				switch (ToInteger (arg1)) {
					case (0) {Store(ObjectType(HI0), Local1)}
					case (1) {Store(ObjectType(\DTM0.HI0), Local1)}
					case (2) {Store(ObjectType(Local2), Local1)}
					case (3) {Store(ObjectType(Index(PHI0, 0)), Local1)}
				}
				if (LNotEqual(Local1, c017)) { // DDB Handle
					err(arg0, z174, 0x019, 0, 0, Local1, c017)
				}
			}

			// Check the new Object appears

			if (CondRefof(\SSS0, Local0)) {
			} else {
				err(arg0, z174, 0x01a, 0, 0, "\\SSS0", 0)
			}

			Store(ObjectType(Local0), Local1)
			if (LNotEqual(Local1, c010)) { // Method
				err(arg0, z174, 0x01b, 0, 0, Local1, c010)
			} else {
				Store(\SSS0(), Local0)
				if (CH03(arg0, z174, 0x01c, "\\SSS0", 1)) {
					return
				}
				if (LNotEqual("\\SSS0", Local0)) {
					err(arg0, z174, 0x01d, 0, 0, Local0, "\\SSS0")
				}
			}

			// UnLoad operator execution
			switch (ToInteger (arg1)) {
				case (0) {UnLoad(HI0)}
				case (1) {UnLoad(\DTM0.HI0)}
				case (2) {UnLoad(Local2)}
				case (3) {UnLoad(DeRefof(Index(PHI0, 0)))}
			}

			if (CH03(arg0, z174, 0x01e, 0, 0)) {
				return
			}

			Store("SSDT Unloaded", Debug)

			if (CondRefof(\SSS0, Local0)) {
				err(arg0, z174, 0x01f, 0, 0, "\\SSS0", 1)
			}

			return
		}

		// Auxiliary method for ArgX, part1
		// Arg1 - reference to store the DDBHandle
		// Arg2 - OpRegion Object of a specified type
		Method(m001, 3, Serialized)
		{
			OperationRegion(OPRm, 0xff, 0, 0x1000)

			Concatenate(arg0, "-m001", arg0)

			CopyObject(arg2, OPRm)

			Field(OPRm, ByteAcc, NoLock, Preserve) {
				RFU0, 0x1a0,
			}

			Field(OPRm, ByteAcc, NoLock, Preserve) {
				SIG, 32,
				LENG, 32,
				REV, 8,
				SUM, 8,
				OID, 48,
				OTID, 64,
				OREV, 32,
				CID, 32,
				CREV, 32,
				Offset(39),
				SSNM, 32
			}

			Store(BUF0, RFU0)

			if (CondRefof(\SSS0, Local0)) {
				err(arg0, z174, 0x020, 0, 0, "\\SSS0", 1)
				return (1)
			}

			// Modify Revision field of SSDT
			Store(Add(CREV, 1), CREV)

			// Recalculate and save CheckSum
			Store(RFU0, Local0)
			Store(Add(SUM, CHSM(Local0, SizeOf (Local0))), SUM)

			if (CH03(arg0, z174, 0x021, 0, 0)) {
				return (1)
			}

			// Load operator execution
			Load(RFU0, Arg1)

			if (CH03(arg0, z174, 0x022, 0, 0)) {
				return (1)
			}

			Store("SSDT Loaded", Debug)

			return (0)
		}

		// Arg1 - OpRegion Object of a specified type
		Method(m003, 2, Serialized)
		{
			Concatenate(arg0, "-m003", arg0)

			// Local Named Integer
			m000(arg0, 0, arg1)

			// Global Named Integer
			m000(arg0, 1, arg1)

			// LocalX
			m000(arg0, 2, arg1)

			// Package element
			// Crash on copying the specific reference Object
			if (y261) {
				m000(arg0, 3, arg1)
			}

			// ArgX
			if (m001(arg0, Refof(Local2), arg1)) {
				return
			}
			m002(arg0, Local2)

			// Package element as ArgX
			if (y133) {
				Name(PHI0, Package(1){0})
				Store(Index(PHI0, 0), Local0)
				if (m001(arg0, Local0, arg1)) {
					return
				}
				m002(arg0, DeRefof(Local0))
			}
			return
		}

		// Region type's Address Space Handler installed flags,
		// only those types' OpRegion can be tested.
		Store(
			Buffer(10){
				1,
				1,
				0, /* 0x02 - PCI_Config */
				1,
				0, /* 0x04 - SMBus */
				0, /* 0x05 - SystemCMOS */
				0, /* 0x06 - PciBarTarget */
				1,
				0, /* 0xcf - UserDefRegionSpace */
				0},/* 0xff - UserDefRegionSpace */
			Local2)

		Store(Derefof(Index(Local2, Arg1)), Local3)
		if (Local3) {
			Concatenate(arg0, "-0x", Local4)
			Concatenate(Local4,
				Mid(ToHexString(Arg1), Add(6, Multiply(F64, 8)), 2),
				Local4)
			Store(Local4, Debug)
			m003(Local4, Arg2)
		} else {
			Store("This Region type's AddrSpace Handler not installed", Debug)
			err(arg0, z174, 0x023, 0, 0, Local2, Arg1)
		}
	}

	// SystemMemory Region
	Method(tst4, 1)
	{
		Concatenate(arg0, "-tst4", arg0)

		m003(Arg0, 0, RGN0)
	}

	// SystemIO Region
	Method(tst5, 1)
	{
		Concatenate(arg0, "-tst5", arg0)

		m003(Arg0, 1, RGN1)
	}

	// EmbeddedControl Region
	Method(tst6, 1)
	{
		Concatenate(arg0, "-tst6", arg0)

		m003(Arg0, 3, RGN3)
	}

	// User defined Region
	Method(tst7, 1)
	{
		Concatenate(arg0, "-tst7", arg0)

		m003(Arg0, 7, RGN7)
	}

	// Note: We load the table objects relative to the root of the namespace.
	// This appears to go against the ACPI specification, but we do it for
	// compatibility with other ACPI implementations.

	// Originated from ssdt1.asl: iasl -tc ssdt1.asl
	Name(BUF1, Buffer(){
		0x53,0x53,0x44,0x54,0x5F,0x00,0x00,0x00,  /* 00000000    "SSDT_..." */
		0x02,0x33,0x49,0x6E,0x74,0x65,0x6C,0x00,  /* 00000008    ".3Intel." */
		0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00,  /* 00000010    "Many...." */
		0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
		0x15,0x12,0x06,0x20,0x10,0x1F,0x5C,0x00,  /* 00000020    "... ..\." */
		0x08,0x4E,0x41,0x42,0x53,0x0D,0x61,0x62,  /* 00000028    ".NABS.ab" */
		0x73,0x6F,0x6C,0x75,0x74,0x65,0x20,0x6C,  /* 00000030    "solute l" */
		0x6F,0x63,0x61,0x74,0x69,0x6F,0x6E,0x20,  /* 00000038    "ocation " */
		0x6F,0x62,0x6A,0x00,0x08,0x4E,0x43,0x52,  /* 00000040    "obj..NCR" */
		0x52,0x0D,0x63,0x75,0x72,0x72,0x65,0x6E,  /* 00000048    "R.curren" */
		0x74,0x20,0x6C,0x6F,0x63,0x61,0x74,0x69,  /* 00000050    "t locati" */
		0x6F,0x6E,0x20,0x6F,0x62,0x6A,0x00,
	})

	OperationRegion (IST1, SystemMemory, 0x100, 0x5f)

	Field(IST1, ByteAcc, NoLock, Preserve) {
		RFU1, 0x2f8,
	}

	Method(tst8, 1, Serialized)
	{
		Name(DDBH, 0)

		Concatenate(arg0, "-tst8", arg0)

		// Check absence
		if (CondRefof(NABS, Local0)) {
			err(arg0, z174, 0x024, 0, 0, "NABS", 1)
		}
		if (CondRefof(NCRR, Local0)) {
			err(arg0, z174, 0x025, 0, 0, "NCRR", 1)
		}

		Store(BUF1, RFU1)
		Load(RFU1, DDBH)
		Store("SSDT loaded", Debug)

		// Check existence
		if (CondRefof(NABS, Local0)) {
			if (LNotEqual("absolute location obj", Derefof(Local0))) {
				err(arg0, z174, 0x026, 0, 0, Derefof(Local0),
					"absolute location obj")
			}
		} else {
			err(arg0, z174, 0x027, 0, 0, "NABS", 0)
		}
		if (CondRefof(NCRR, Local0)) {
			if (LNotEqual("current location obj", Derefof(Local0))) {
				err(arg0, z174, 0x028, 0, 0, Derefof(Local0),
					"current location obj")
			}
		} else {
			err(arg0, z174, 0x029, 0, 0, "NCRR", 0)
		}

		// Check location
		if (CondRefof(\NABS, Local0)) {
		} else {
			err(arg0, z174, 0x02a, 0, 0, "NABS", 0)
		}
		//Note: We load the table objects relative to the root of the namespace.
		if (CondRefof(\NCRR, Local0)) {
		} else {
			err(arg0, z174, 0x02b, 0, 0, "\\NCRR", 1)
		}
		if (CondRefof(\DTM0.NCRR, Local0)) {
			err(arg0, z174, 0x02c, 0, 0, "\\DTM0.NCRR", 1)
		}
		if (CondRefof(\DTM0.TST8.NCRR, Local0)) {
			err(arg0, z174, 0x02d, 0, 0, "\\DTM0.TST8.NCRR", 0)
		}

		UnLoad(DDBH)
		Store("SSDT unloaded", Debug)

		// Check absence
		if (CondRefof(NABS, Local0)) {
			err(arg0, z174, 0x02e, 0, 0, "NABS", 1)
		}
		if (CondRefof(NCRR, Local0)) {
			err(arg0, z174, 0x02f, 0, 0, "NCRR", 1)
		}
	}

	// Check global and dynamic declarations of OpRegions
	// and the appropriate _REG Methods invocation for the
	// loaded SSDT

	// Originated from ssdt2.asl: iasl -tc ssdt2.asl
	Name(BUF2, Buffer(){
		0x53,0x53,0x44,0x54,0x17,0x01,0x00,0x00,  /* 00000000    "SSDT...." */
		0x02,0x7B,0x49,0x6E,0x74,0x65,0x6C,0x00,  /* 00000008    ".{Intel." */
		0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00,  /* 00000010    "Many...." */
		0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
		0x15,0x12,0x06,0x20,0x5B,0x82,0x41,0x0F,  /* 00000020    "... [.A." */
		0x41,0x55,0x58,0x44,0x5B,0x80,0x4F,0x50,  /* 00000028    "AUXD[.OP" */
		0x52,0x30,0x80,0x0C,0x00,0x00,0x00,0x01,  /* 00000030    "R0......" */
		0x0A,0x04,0x5B,0x81,0x0B,0x4F,0x50,0x52,  /* 00000038    "..[..OPR" */
		0x30,0x03,0x52,0x46,0x30,0x30,0x20,0x08,  /* 00000040    "0.RF00 ." */
		0x52,0x45,0x47,0x43,0x0C,0xFF,0xFF,0xFF,  /* 00000048    "REGC...." */
		0xFF,0x08,0x52,0x45,0x47,0x50,0x0A,0x00,  /* 00000050    "..REGP.." */
		0x08,0x52,0x45,0x47,0x44,0x0C,0xFF,0xFF,  /* 00000058    ".REGD..." */
		0xFF,0xFF,0x08,0x52,0x45,0x47,0x52,0x0A,  /* 00000060    "...REGR." */
		0x00,0x14,0x33,0x5F,0x52,0x45,0x47,0x02,  /* 00000068    "..3_REG." */
		0x70,0x0D,0x5C,0x41,0x55,0x58,0x44,0x2E,  /* 00000070    "p.\AUXD." */
		0x5F,0x52,0x45,0x47,0x3A,0x00,0x5B,0x31,  /* 00000078    "_REG:.[1" */
		0x70,0x68,0x5B,0x31,0x70,0x69,0x5B,0x31,  /* 00000080    "ph[1pi[1" */
		0xA0,0x14,0x93,0x68,0x0A,0x80,0x70,0x52,  /* 00000088    "...h..pR" */
		0x45,0x47,0x43,0x52,0x45,0x47,0x50,0x70,  /* 00000090    "EGCREGPp" */
		0x69,0x52,0x45,0x47,0x43,0x14,0x49,0x07,  /* 00000098    "iREGC.I." */
		0x4D,0x30,0x30,0x30,0x00,0x14,0x38,0x5F,  /* 000000A0    "M000..8_" */
		0x52,0x45,0x47,0x02,0x70,0x0D,0x5C,0x41,  /* 000000A8    "REG.p.\A" */
		0x55,0x58,0x44,0x2E,0x4D,0x30,0x30,0x30,  /* 000000B0    "UXD.M000" */
		0x2E,0x5F,0x52,0x45,0x47,0x3A,0x00,0x5B,  /* 000000B8    "._REG:.[" */
		0x31,0x70,0x68,0x5B,0x31,0x70,0x69,0x5B,  /* 000000C0    "1ph[1pi[" */
		0x31,0xA0,0x14,0x93,0x68,0x0A,0x80,0x70,  /* 000000C8    "1...h..p" */
		0x52,0x45,0x47,0x44,0x52,0x45,0x47,0x52,  /* 000000D0    "REGDREGR" */
		0x70,0x69,0x52,0x45,0x47,0x44,0x5B,0x80,  /* 000000D8    "piREGD[." */
		0x4F,0x50,0x52,0x31,0x80,0x0C,0x10,0x00,  /* 000000E0    "OPR1...." */
		0x00,0x01,0x0A,0x04,0x5B,0x81,0x0B,0x4F,  /* 000000E8    "....[..O" */
		0x50,0x52,0x31,0x03,0x52,0x46,0x30,0x31,  /* 000000F0    "PR1.RF01" */
		0x20,0x70,0x0D,0x5C,0x41,0x55,0x58,0x44,  /* 000000F8    " p.\AUXD" */
		0x2E,0x4D,0x30,0x30,0x30,0x3A,0x00,0x5B,  /* 00000100    ".M000:.[" */
		0x31,0x70,0x52,0x46,0x30,0x31,0x5B,0x31,  /* 00000108    "1pRF01[1" */
		0x70,0x52,0x45,0x47,0x52,0x5B,0x31,
	})

	OperationRegion (IST2, SystemMemory, 0x200, 0x117)

	Field(IST2, ByteAcc, NoLock, Preserve) {
		RFU2, 0x8b8,
	}

	External(\AUXD.M000, MethodObj)

	Method(tst9, 1, Serialized)
	{
		Name(DDBH, 0)

		Concatenate(arg0, "-tst9", arg0)

		Store(BUF2, RFU2)

		if (CondRefof(\AUXD, Local0)) {
			err(arg0, z174, 0x030, 0, 0, "\\AUXD", 1)
			return
		}

		if (CH03(arg0, 0, 0x031, 0, 0)) {
			return
		}

		Load(RFU2, DDBH)

		if (CH03(arg0, 0, 0x032, 0, 0)) {
			return
		}

		if (CondRefof(\AUXD, Local0)) {
		} else {
			err(arg0, z174, 0x033, 0, 0, "\\AUXD", 0)
			return
		}

		Store (ObjectType(Local0), Local1)

		if (LNotEqual(Local1, 6)) {
			err(arg0, z174, 0x034, 0, 0, Local1, 6)
			return
		}

		if (CondRefof(\AUXD.REGC, Local0)) {
		} else {
			err(arg0, z174, 0x035, 0, 0, "\\AUXD.REGC", 0)
			return
		}

		Store(Derefof(Local0), Local1)

		if (LNotEqual(1, Local1)) {
			err(arg0, z174, 0x036, 0, 0, Local1, 1)
		}

		if (CondRefof(\AUXD.REGD, Local0)) {
		} else {
			err(arg0, z174, 0x037, 0, 0, "\\AUXD.REGD", 0)
			return
		}

		Store(Derefof(Local0), Local1)

		if (LNotEqual(0xFFFFFFFF, Local1)) {
			err(arg0, z174, 0x038, 0, 0, Local1, 0xFFFFFFFF)
		} elseif (CondRefof(\AUXD.M000, Local2)) {

			\AUXD.M000()

			Store(Derefof(Local0), Local1)

			if (LNotEqual(1, Local1)) {
				err(arg0, z174, 0x039, 0, 0, Local1, 1)
			}
		} else {
			err(arg0, z174, 0x03a, 0, 0, "\\AUXD.M000", 0)
		}

		UnLoad(DDBH)

		if (CondRefof(\AUXD, Local0)) {
			err(arg0, z174, 0x03b, 0, 0, "\\AUXD", 1)
		}
		return
	}

	// Checks that only specified Tables objects present in the NS
	Method(LDCH, 1)
	{
		Method(MAUX) {Return ("MAUX")}

		Concatenate(arg0, "-LDCH", arg0)

		if (CH03(arg0, z174, 0x040, 0, 0)) {
			return (1)
		}

		// Specify to check up to 3 successive \SSxx names
		Store(1, Local0)
		if (HI0N) {
			Subtract(HI0N, 1, Local1)
			if (Local1) {
				Decrement(Local1)
			}
		} else {
			Store(0, Local1)
		}
		if (LLess(Add(Local1, 1), HI0M)) {
			Increment(Local0)
			if (LLess(Add(Local1, 2), HI0M)) {
				Increment(Local0)
			}
		}

		while (Local0) {
			Divide(Local1, NNML, Local3, Local4)
			Store("\\SSS0", Local5)
			Store(Derefof(Index(SNML, Local4)), Index(Local5, 3))
			Store(Derefof(Index(SNML, Local3)), Index(Local5, 4))

			Store(Local5, Debug)

			// Access the next \SSxx Object
			CopyObject(Derefof(Local5), MAUX)

			if (LLess(Local1, HI0N)) {
				if (CH03(arg0, z174, 0x041, 0, 0)) {
					return (2)
				}
				Store(MAUX(), Local2)
				if (CH03(arg0, z174, 0x042, 0, 0)) {
					return (3)
				}
				if (LNotEqual(Local5, Local2)) {
					err(arg0, z174, 0x043, 0, 0, Local2, Local5)
				}
			} else {
				if (CH04(arg0, 0, 0xff, z174, 0x044, 0, 0)) {	// AE_NOT_FOUND
					return (4)
				}
			}
			Increment(Local1)
			Decrement(Local0)
		}

		Return (0)
	}

	// Loading a number of different SSDTs
	// Arg1: the number of SSDT to load
	Method(tsta, 2)
	{
		Concatenate(arg0, "-tsta", arg0)

		if (INIT()) {
			err(arg0, z174, 0x045, 0, 0, "INIT", 1)
			return (1)
		}
		if (CH03(arg0, z174, 0x046, 0, 0)) {
			return (1)
		}

		Store(arg1, Local0)
		while (Local0) {
			if (LD()) {
				err(arg0, z174, 0x047, 0, 0, "HI0N", HI0N)
				return (1)
			}
			if (CH03(arg0, z174, 0x048, 0, 0)) {
				return (1)
			}
			Decrement(Local0)

			if (LDCH(arg0)) {
				err(arg0, z174, 0x049, 0, 0, "HI0N", HI0N)
				return (1)
			}
		}

		Store(arg1, Local0)
		while (Local0) {
			if (UNLD()) {
				err(arg0, z174, 0x040a, 0, 0, "HI0N", HI0N)
				return (1)
			}
			if (CH03(arg0, z174, 0x04b, 0, 0)) {
				return (1)
			}
			Decrement(Local0)

			if (LDCH(arg0)) {
				err(arg0, z174, 0x04c, 0, 0, "HI0N", HI0N)
				return (1)
			}
		}

		return (0)
	}

	// Exceptions when the Object argument does not refer to
	// an operation region field or an operation region

	// Originated from ssdt3.asl: iasl -tc ssdt3.asl
	Name(BUF3, Buffer(){
		0x53,0x53,0x44,0x54,0x1F,0x01,0x00,0x00,  /* 00000000    "SSDT...." */
		0x02,0x58,0x49,0x6E,0x74,0x65,0x6C,0x00,  /* 00000008    ".XIntel." */
		0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00,  /* 00000010    "Many...." */
		0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
		0x15,0x12,0x06,0x20,0x5B,0x82,0x49,0x0F,  /* 00000020    "... [.I." */
		0x41,0x55,0x58,0x44,0x08,0x49,0x4E,0x54,  /* 00000028    "AUXD.INT" */
		0x30,0x0E,0x10,0x32,0x54,0x76,0x98,0xBA,  /* 00000030    "0..2Tv.." */
		0xDC,0xFE,0x08,0x53,0x54,0x52,0x30,0x0D,  /* 00000038    "...STR0." */
		0x73,0x6F,0x75,0x72,0x63,0x65,0x20,0x73,  /* 00000040    "source s" */
		0x74,0x72,0x69,0x6E,0x67,0x30,0x00,0x08,  /* 00000048    "tring0.." */
		0x42,0x55,0x46,0x30,0x11,0x0C,0x0A,0x09,  /* 00000050    "BUF0...." */
		0x09,0x08,0x07,0x06,0x05,0x04,0x03,0x02,  /* 00000058    "........" */
		0x01,0x08,0x50,0x41,0x43,0x30,0x12,0x27,  /* 00000060    "..PAC0.'" */
		0x03,0x0E,0x1F,0x32,0x54,0x76,0x98,0xBA,  /* 00000068    "...2Tv.." */
		0xDC,0xFE,0x0D,0x74,0x65,0x73,0x74,0x20,  /* 00000070    "...test " */
		0x70,0x61,0x63,0x6B,0x61,0x67,0x65,0x30,  /* 00000078    "package0" */
		0x00,0x11,0x0C,0x0A,0x09,0x13,0x12,0x11,  /* 00000080    "........" */
		0x10,0x0F,0x0E,0x0D,0x0C,0x0B,0x5B,0x81,  /* 00000088    "......[." */
		0x0B,0x4F,0x50,0x52,0x30,0x01,0x46,0x4C,  /* 00000090    ".OPR0.FL" */
		0x55,0x30,0x20,0x5B,0x82,0x10,0x44,0x45,  /* 00000098    "U0 [..DE" */
		0x56,0x30,0x08,0x53,0x30,0x30,0x30,0x0D,  /* 000000A0    "V0.S000." */
		0x44,0x45,0x56,0x30,0x00,0x5B,0x02,0x45,  /* 000000A8    "DEV0.[.E" */
		0x56,0x45,0x30,0x14,0x09,0x4D,0x4D,0x4D,  /* 000000B0    "VE0..MMM" */
		0x30,0x00,0xA4,0x0A,0x00,0x5B,0x01,0x4D,  /* 000000B8    "0....[.M" */
		0x54,0x58,0x30,0x00,0x5B,0x80,0x4F,0x50,  /* 000000C0    "TX0.[.OP" */
		0x52,0x30,0x00,0x0C,0x21,0x43,0x65,0x07,  /* 000000C8    "R0..!Ce." */
		0x0A,0x98,0x5B,0x84,0x13,0x50,0x57,0x52,  /* 000000D0    "..[..PWR" */
		0x30,0x00,0x00,0x00,0x08,0x53,0x30,0x30,  /* 000000D8    "0....S00" */
		0x30,0x0D,0x50,0x57,0x52,0x30,0x00,0x5B,  /* 000000E0    "0.PWR0.[" */
		0x83,0x16,0x43,0x50,0x55,0x30,0x00,0xFF,  /* 000000E8    "..CPU0.." */
		0xFF,0xFF,0xFF,0x00,0x08,0x53,0x30,0x30,  /* 000000F0    ".....S00" */
		0x30,0x0D,0x43,0x50,0x55,0x30,0x00,0x5B,  /* 000000F8    "0.CPU0.[" */
		0x85,0x10,0x54,0x5A,0x4E,0x30,0x08,0x53,  /* 00000100    "..TZN0.S" */
		0x30,0x30,0x30,0x0D,0x54,0x5A,0x4E,0x30,  /* 00000108    "000.TZN0" */
		0x00,0x5B,0x13,0x42,0x55,0x46,0x30,0x0A,  /* 00000110    ".[.BUF0." */
		0x00,0x0A,0x45,0x42,0x46,0x4C,0x30,
	})

	OperationRegion (IST3, SystemMemory, 0x400, 0x11f)

	Field(IST3, ByteAcc, NoLock, Preserve) {
		RFU3, 0x8f8,
	}

	Method(tstb, 1, Serialized)
	{
		Name(DDB0, 0)
		Name(DDBH, 0)

		Concatenate(arg0, "-tstb", arg0)

		Store(BUF3, RFU3)
		Load(RFU3, DDB0)

		if (CH03(arg0, z174, 0x050, 0, 0)) {
			return (1)
		}

		// Uninitialized: it can not be aplied to Load which
		// allows NameString only to be used as Object parameter

		// Integer
		Load(\AUXD.INT0, DDBH)
		CH04(arg0, 0, 47, z174, 0x051, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.INT0), Local0)
		if (LNotEqual(c009, Local0)) {
			err(arg0, z174, 0x052, 0, 0, Local0, c009)
		}

		// String
		Load(\AUXD.STR0, DDBH)
		CH04(arg0, 0, 47, z174, 0x053, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.STR0), Local0)
		if (LNotEqual(c00a, Local0)) {
			err(arg0, z174, 0x054, 0, 0, Local0, c00a)
		}

		// Buffer
		if (y282) {
			// TBD: LBZ480 update allows Buffer to be Source of Load
			Load(\AUXD.BUF0, DDBH)
			CH04(arg0, 0, 47, z174, 0x055, 0, 0)	// AE_AML_OPERAND_TYPE
			Store(ObjectType(\AUXD.BUF0), Local0)
			if (LNotEqual(c00b, Local0)) {
				err(arg0, z174, 0x056, 0, 0, Local0, c00b)
			}
		}

		// Package
		Load(\AUXD.PAC0, DDBH)
		CH04(arg0, 0, 47, z174, 0x057, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.PAC0), Local0)
		if (LNotEqual(c00c, Local0)) {
			err(arg0, z174, 0x058, 0, 0, Local0, c00c)
		}

		// Field Unit

		// Device
		Load(\AUXD.DEV0, DDBH)
		CH04(arg0, 0, 47, z174, 0x059, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.DEV0), Local0)
		if (LNotEqual(c00e, Local0)) {
			err(arg0, z174, 0x05a, 0, 0, Local0, c00e)
		}

		// Event
		Load(\AUXD.EVE0, DDBH)
		CH04(arg0, 0, 47, z174, 0x05b, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.EVE0), Local0)
		if (LNotEqual(c00f, Local0)) {
			err(arg0, z174, 0x05c, 0, 0, Local0, c00f)
		}

		// Method
		Load(\AUXD.MMM0, DDBH)
		CH04(arg0, 0, 47, z174, 0x05d, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.MMM0), Local0)
		if (LNotEqual(c010, Local0)) {
			err(arg0, z174, 0x05e, 0, 0, Local0, c010)
		}

		// Mutex
		Load(\AUXD.MTX0, DDBH)
		CH04(arg0, 0, 47, z174, 0x05f, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.MTX0), Local0)
		if (LNotEqual(c011, Local0)) {
			err(arg0, z174, 0x060, 0, 0, Local0, c011)
		}

		// OpRegion

		// Power Resource
		Load(\AUXD.PWR0, DDBH)
		CH04(arg0, 0, 47, z174, 0x061, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.PWR0), Local0)
		if (LNotEqual(c013, Local0)) {
			err(arg0, z174, 0x062, 0, 0, Local0, c013)
		}

		// Processor
		Load(\AUXD.CPU0, DDBH)
		CH04(arg0, 0, 47, z174, 0x063, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.CPU0), Local0)
		if (LNotEqual(c014, Local0)) {
			err(arg0, z174, 0x064, 0, 0, Local0, c014)
		}

		// Thermal Zone
		Load(\AUXD.TZN0, DDBH)
		CH04(arg0, 0, 47, z174, 0x065, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.TZN0), Local0)
		if (LNotEqual(c015, Local0)) {
			err(arg0, z174, 0x066, 0, 0, Local0, c015)
		}

		// Buffer Field
		if (y282) {
			// TBD: LBZ480 update allows Buffer Field to be Source of Load
			Load(\AUXD.BFL0, DDBH)
			CH04(arg0, 0, 47, z174, 0x067, 0, 0)	// AE_AML_OPERAND_TYPE
			Store(ObjectType(\AUXD.BFL0), Local0)
			if (LNotEqual(c016, Local0)) {
				err(arg0, z174, 0x068, 0, 0, Local0, c016)
			}
		}

		// DDB Handle
		Load(DDB0, DDBH)
		CH04(arg0, 0, 47, z174, 0x069, 0, 0)	// AE_AML_OPERAND_TYPE
		if (y260) {
			Store(ObjectType(DDB0), Local0)
			if (LNotEqual(c017, Local0)) {
				err(arg0, z174, 0x06a, 0, 0, Local0, c017)
			}
		}
		
		UnLoad(DDB0)

		return (0)
	}

	// Exceptions when an OpRegion passed as the Object
	// parameter of Load is not of SystemMemory type
	Method(tstc, 1, Serialized)
	{
		Name(DDBH, 0)

		Concatenate(arg0, "-tstc", arg0)

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

		if (CH03(arg0, z174, 0x06f, 0, 0)) {
			return (1)
		}

		// SystemIO
		Load(RGN1, DDBH)
		CH04(arg0, 0, 47, z174, 0x220, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(RGN1), Local0)
		if (LNotEqual(c012, Local0)) {
			err(arg0, z174, 0x071, 0, 0, Local0, c012)
		}

		// PCI_Config
		Load(RGN2, DDBH)
		CH04(arg0, 0, 47, z174, 0x072, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(RGN2), Local0)
		if (LNotEqual(c012, Local0)) {
			err(arg0, z174, 0x073, 0, 0, Local0, c012)
		}

		// EmbeddedControl
		Load(RGN3, DDBH)
		CH04(arg0, 0, 47, z174, 0x074, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(RGN3), Local0)
		if (LNotEqual(c012, Local0)) {
			err(arg0, z174, 0x075, 0, 0, Local0, c012)
		}

		// SMBus
		Load(RGN4, DDBH)
		CH04(arg0, 0, 47, z174, 0x076, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(RGN4), Local0)
		if (LNotEqual(c012, Local0)) {
			err(arg0, z174, 0x077, 0, 0, Local0, c012)
		}

		// SystemCMOS
		Load(RGN5, DDBH)
		CH04(arg0, 0, 47, z174, 0x078, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(RGN5), Local0)
		if (LNotEqual(c012, Local0)) {
			err(arg0, z174, 0x079, 0, 0, Local0, c012)
		}

		// PciBarTarget
		Load(RGN6, DDBH)
		CH04(arg0, 0, 47, z174, 0x07a, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(RGN6), Local0)
		if (LNotEqual(c012, Local0)) {
			err(arg0, z174, 0x07b, 0, 0, Local0, c012)
		}

		// UserDefRegionSpace 0x80
		Load(RGN7, DDBH)
		CH04(arg0, 0, 47, z174, 0x07c, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(RGN7), Local0)
		if (LNotEqual(c012, Local0)) {
			err(arg0, z174, 0x07d, 0, 0, Local0, c012)
		}

		// UserDefRegionSpace 0xcf
		Load(RGN8, DDBH)
		CH04(arg0, 0, 47, z174, 0x07e, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(RGN8), Local0)
		if (LNotEqual(c012, Local0)) {
			err(arg0, z174, 0x07f, 0, 0, Local0, c012)
		}

		// UserDefRegionSpace 0xff
		Load(RGN9, DDBH)
		CH04(arg0, 0, 47, z174, 0x080, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(RGN9), Local0)
		if (LNotEqual(c012, Local0)) {
			err(arg0, z174, 0x081, 0, 0, Local0, c012)
		}

		return (0)
	}

	// Exceptions when the table contained in an OpRegion
	// (Field) is not an SSDT
	Method(tstd, 1, Serialized)
	{
		Name(HI0, 0)

		Concatenate(arg0, "-tstd", arg0)

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z174, 0x082, 0, 0, "\\SSS0", 1)
			return (1)
		}

		Store(BUF0, RFU0)

		// Modify the Signature field of the Table Header
		Store(SIG, Local0)
		Increment(Local0)
		Store(Local0, SIG)

		// Recalculate and save CheckSum
		Store(RFU0, Local0)
		Store(Add(SUM, CHSM(Local0, SizeOf (Local0))), SUM)

		if (CH03(arg0, z174, 0x083, 0, 0)) {
			return (1)
		}

		// Load operator execution, OpRegion case
		if (y290) {
			Load(IST0, HI0)
			CH04(arg0, 0, 37, z174, 0x084, 0, 0)	// AE_BAD_SIGNATURE

			if (CondRefof(\SSS0, Local0)) {
				err(arg0, z174, 0x085, 0, 0, "\\SSS0", 1)
				return (1)
			}
		}

		// Load operator execution, OpRegion Field case
		Load(RFU0, HI0)
		CH04(arg0, 0, 37, z174, 0x086, 0, 0)	// AE_BAD_SIGNATURE

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z174, 0x087, 0, 0, "\\SSS0", 1)
		}

		return (0)
	}

	// Exceptions when the length of the supplied SSDT is greater
	// than the length of the respective OpRegion or Region Field,
	// or less than the length of the Table Header
	// Arg1: 0 - the 'greater' case, 1 - the 'less' case
	Method(tste, 2, Serialized)
	{
		Name(HI0, 0)

		Concatenate(arg0, "-tste", arg0)

		if (Arg1) {
			Concatenate(arg0, ".less", arg0)
		}

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z174, 0x090, 0, 0, "\\SSS0", 1)
			return (1)
		}

		Store(BUF0, RFU0)

		// Modify the Length field of the Table Header
		if (Arg1) {
			Store(35, Local0)
		} else {
			Store(Sizeof(BUF0), Local0)
			Increment(Local0)
		}
		Store(Local0, LENG)

		// Recalculate and save CheckSum
		Store(RFU0, Local0)
		Store(Add(SUM, CHSM(Local0, SizeOf (Local0))), SUM)

		if (CH03(arg0, z174, 0x091, 0, 0)) {
			return (1)
		}

		// Load operator execution, OpRegion case
		if (y290) {
			Load(IST0, HI0)
			CH04(arg0, 0, 42, z174, 0x092, 0, 0)	// AE_INVALID_TABLE_LENGTH

			if (CondRefof(\SSS0, Local0)) {
				err(arg0, z174, 0x093, 0, 0, "\\SSS0", 1)

				// CleanUp
				UnLoad(HI0)
				if (CH03(arg0, z174, 0x094, 0, 0)) {
					return (1)
				}
				if (CondRefof(\SSS0, Local0)) {
					err(arg0, z174, 0x095, 0, 0, "\\SSS0", 1)
					return (1)
				}
			}
		}

		// Load operator execution, OpRegion Field case
		Load(RFU0, HI0)
		if(LNot(arg1)){
			// If the table length in the header is larger than the buffer.
			CH04(arg0, 0, 54, z174, 0x096, 0, 0)	// AE_AML_BUFFER_LIMIT
		} else {
			// If the table length is smaller than an ACPI table header.
			CH04(arg0, 0, 42, z174, 0x096, 0, 0)    // AE_INVALID_TABLE_LENGTH
		}

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z174, 0x097, 0, 0, "\\SSS0", 1)
			UnLoad(HI0)
			if (CH03(arg0, z174, 0x098, 0, 0)) {
				return (1)
			}
			if (CondRefof(\SSS0, Local0)) {
				err(arg0, z174, 0x099, 0, 0, "\\SSS0", 1)
				return (1)
			}
		}

		return (0)
	}

	// Exceptions when the checksum of the supplied SSDT is invalid
	Method(tstf, 1, Serialized)
	{
		Name(HI0, 0)

		Concatenate(arg0, "-tstf", arg0)

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z174, 0x0a0, 0, 0, "\\SSS0", 1)
			return (1)
		}

		Store(BUF0, RFU0)

		// Recalculate and save CheckSum
		Store(RFU0, Local0)
		Store(Add(SUM, CHSM(Local0, SizeOf (Local0))), SUM)

		// Spoil the CheckSum
		Store(Add(SUM, 1), SUM)

		if (CH03(arg0, z174, 0x0a1, 0, 0)) {
			return (1)
		}

		// Load operator execution, OpRegion case
		if (y290) {
			Load(IST0, HI0)
			CH04(arg0, 0, 39, z174, 0x0a2, 0, 0)	// AE_BAD_CHECKSUM

			if (CondRefof(\SSS0, Local0)) {
				err(arg0, z174, 0x0a3, 0, 0, "\\SSS0", 1)
				
				//Cleanup
				UnLoad(HI0)
				if (CH03(arg0, z174, 0x0a4, 0, 0)) {
					return (1)
				}
				Store(Add(SUM, 1), SUM)
			}
		}

		// Load operator execution, OpRegion Field case
		Load(RFU0, HI0)
		CH04(arg0, 0, 39, z174, 0x0a5, 0, 0)	// AE_BAD_CHECKSUM

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z174, 0x0a6, 0, 0, "\\SSS0", 1)

			//Cleanup
			UnLoad(HI0)
			if (CH03(arg0, z174, 0x0a7, 0, 0)) {
				return (1)
			}
			if (CH03(arg0, z174, 0x0a8, 0, 0)) {
				return (1)
			}
		}

		return (0)
	}

	// Object of any type (expect Field Units and Buffer Fields)
	// can be used as the DDBHandle argument
	Method(tstg, 1, Serialized)
	{
		Name(DDB0, 0)
		Name(DDB1, 0)
		Name(DDBH, 0)

		Method(m000, 4)
		{
			Concatenate(arg0, "-m000.", arg0)
			Concatenate(arg0, arg1, arg0)

			Store(ObjectType(arg2), Local0)
			if (LNotEqual(arg3, Local0)) {
				err(arg0, z174, 0x0b0, 0, 0, Local0, arg3)
				return (1)
			}

			if (CondRefof(\SSS0, Local0)) {
				err(arg0, z174, 0x0b1, 0, 0, "\\SSS0", 1)
				return (1)
			}

			Load(RFU0, arg2)
			if (LOr(LEqual(arg3, c00d),	// Field Unit
				LEqual(arg3, c016))) {	// Buffer Field

				// AE_AML_OPERAND_TYPE
				if (CH04(arg0, 2, 47, z174, 0x0e9, 0, 0)) {
					return (1)
				} else {
					return (0)
				}
			} else {
				if (CH03(arg0, z174, 0x0b2, 0, 0)) {
					return (1)
				}
			}
			if (y260) {
				Store(ObjectType(arg2), Local0)
				if (LNotEqual(c017, Local0)) {
					err(arg0, z174, 0x0b3, 0, 0, Local0, c017)
				}
			}
			if (CondRefof(\SSS0, Local0)) {
			} else {
				err(arg0, z174, 0x0b4, 0, 0, "\\SSS0", 0)
				return (1)
			}

			UnLoad(Derefof(arg2))
			if (CH03(arg0, z174, 0x0b5, 0, 0)) {
				return (1)
			}
			if (CondRefof(\SSS0, Local0)) {
				err(arg0, z174, 0x0b6, 0, 0, "\\SSS0", 1)
				return (1)
			}

			return (0)
		}

		Concatenate(arg0, "-tstg", arg0)

		// Load Auxiliry table
		Store(BUF3, RFU3)
		Load(RFU3, DDB0)

		Store(BUF0, RFU0)

		// Recalculate and save CheckSum
		Store(RFU0, Local0)
		Store(Add(SUM, CHSM(Local0, SizeOf (Local0))), SUM)
		if (CH03(arg0, z174, 0x0b7, 0, 0)) {
			return (1)
		}

		// Uninitialized
		m000(arg0, "uni", Refof(Local1), c008)

		// Integer
		m000(arg0, "int", Refof(\AUXD.INT0), c009)

		// String
		m000(arg0, "str", Refof(\AUXD.STR0), c00a)

		// Buffer
		m000(arg0, "buf", Refof(\AUXD.BUF0), c00b)

		// Package
		m000(arg0, "pac", Refof(\AUXD.PAC0), c00c)

		// Field Unit
		m000(arg0, "flu", Refof(\AUXD.FLU0), c00d)

		// Device
		m000(arg0, "dev", Refof(\AUXD.DEV0), c00e)

		// Event
		m000(arg0, "evt", Refof(\AUXD.EVE0), c00f)

		// Method
		m000(arg0, "met", Refof(\AUXD.MMM0), c010)

		// Mutex
		m000(arg0, "mtx", Refof(\AUXD.MTX0), c011)

		// OpRegion
		m000(arg0, "opr", Refof(\AUXD.OPR0), c012)

		// Power Resource
		m000(arg0, "pwr", Refof(\AUXD.PWR0), c013)

		// Processor
		m000(arg0, "cpu", Refof(\AUXD.CPU0), c014)

		// Thermal Zone
		m000(arg0, "tzn", Refof(\AUXD.TZN0), c015)

		// Buffer Field
		m000(arg0, "bfl", Refof(\AUXD.BFL0), c016)

		// DDB Handle
		if (y260) {
			CopyObject(DDB0, DDB1)
			m000(arg0, "ddb", Refof(DDB1), c017)
		}
		
		UnLoad(DDB0)

		CH03(arg0, z174, 0x0b8, 0, 0)

		return (0)
	}

	// AE_OWNER_ID_LIMIT exception when too many Tables loaded,
	// Arg1: 0 - Load case, 1 - LoadTable case
	Method(tsth, 2, Serialized)
	{
		Name(MAXT, 0xf6)
		Name(DDB1, 0)
		Name(DDB3, 0)

		Concatenate(arg0, "-tsth", arg0)

		if (INIT()) {
			err(arg0, z174, 0x0c0, 0, 0, "INIT", 1)
			return (1)
		}
		if (CH03(arg0, z174, 0x0c1, 0, 0)) {
			return (1)
		}
		Store(BUF1, RFU1)
		Store(BUF3, RFU3)

		Store(MAXT, Local0)
		while (Local0) {
			Store(HI0N, Debug)
			if (LD()) {
				err(arg0, z174, 0x0c2, 0, 0, "HI0N", HI0N)
				return (1)
			}
			if (CH03(arg0, z174, 0x0c3, 0, 0)) {
				return (1)
			}
			Decrement(Local0)
		}

		// Methods can not be called after the following Load
		// (OWNER_ID is exhausted)
		Load(RFU1, DDB1)

		// The following Load should cause AE_OWNER_ID_LIMIT
		if (Arg1) {
			LoadTable("OEM1", "", "",  ,  , )
		} else {
			Load(RFU3, DDB3)
		}

		// Futher 1 Method can be called
		UnLoad(DDB1)

		CH04(arg0, 0, 86, z174, 0x0c4, 0, 0)	// AE_OWNER_ID_LIMIT

		Store(MAXT, Local0)
		while (Local0) {
			if (UNLD()) {
				err(arg0, z174, 0x0c5, 0, 0, "HI0N", HI0N)
				return (1)
			}
			if (CH03(arg0, z174, 0x0c6, 0, 0)) {
				return (1)
			}
			Decrement(Local0)
		}

		if (LDCH(0)) {
			err(arg0, z174, 0x0c7, 0, 0, "HI0N", HI0N)
			return (1)
		}

		return (0)
	}

	// Exception when SSDT specified as the Object parameter
	// of the Load operator is already loaded
	Method(tsti, 1, Serialized)
	{
		Name(HI0, 0)
		Name(HI1, 0)

		Concatenate(arg0, "-tsti", arg0)

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z174, 0x0d0, 0, 0, "\\SSS0", 1)
			return (1)
		}

		Store(BUF0, RFU0)

		// Recalculate and save CheckSum
		Store(RFU0, Local0)
		Store(Add(SUM, CHSM(Local0, SizeOf (Local0))), SUM)

		if (CH03(arg0, z174, 0x0d1, 0, 0)) {
			return (1)
		}

		// Load operator execution
		Load(RFU0, HI0)
		if (CH03(arg0, z174, 0x0d2, 0, 0)) {
			return (1)
		}

		if (y260) {
			Store(ObjectType(HI0), Local0)
			if (LNotEqual(c017, Local0)) {
				err(arg0, z174, 0x0d3, 0, 0, Local0, c017)
			}
		}

		if (CondRefof(\SSS0, Local0)) {
		} else {
			err(arg0, z174, 0x0d4, 0, 0, "\\SSS0", 0)
			return (1)
		}

		Store(5, Local1)

		while (Local1) {
			// Repeated Load operator execution
			Load(RFU0, HI1)
			CH04(arg0, 0, 7, z174, 0x0d5, 5, Local1) // AE_ALREADY_EXISTS

			Store(ObjectType(HI1), Local0)
			if (LNotEqual(c009, Local0)) {
				err(arg0, z174, 0x0d6, 0, 0, Local0, c009)
			}

			Decrement(Local1)
		}

		UnLoad(HI0)

		if (CH03(arg0, z174, 0x0d7, 0, 0)) {
			return (1)
		}

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z174, 0x0d8, 0, 0, "\\SSS0", 1)
		}

		return (0)
	}

	// Exception when there already is an previously created Object
	// referred by the namepath of the new Object in the Table loaded
	Method(tstj, 1, Serialized)
	{
		Name(HI0, 0)
		Name(HI1, 0)

		Concatenate(arg0, "-tstj", arg0)

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z174, 0x0e0, 0, 0, "\\SSS0", 1)
			return (1)
		}

		Store(BUF0, ^RFU0)

		// Recalculate and save CheckSum
		Store(^RFU0, Local0)
		Store(Add(^SUM, CHSM(Local0, SizeOf (Local0))), ^SUM)

		if (CH03(arg0, z174, 0x0e1, 0, 0)) {
			return (1)
		}

		// Load operator execution
		Load(^RFU0, HI0)
		if (CH03(arg0, z174, 0x0e2, 0, 0)) {
			return (1)
		}

		if (y260) {
			Store(ObjectType(HI0), Local0)
			if (LNotEqual(c017, Local0)) {
				err(arg0, z174, 0x0e3, 0, 0, Local0, c017)
			}
		}

		if (CondRefof(\SSS0, Local0)) {
		} else {
			err(arg0, z174, 0x0e4, 0, 0, "\\SSS0", 0)
			return (1)
		}

		// Load another table, containing declaration of \SSS0

		OperationRegion (IST0, SystemMemory, 0x80000000, 0x34)

		Field(IST0, ByteAcc, NoLock, Preserve) {
			RFU0, 0x1a0,
		}

		Field(IST0, ByteAcc, NoLock, Preserve) {
			SIG, 32,
			LENG, 32,
			REV, 8,
			SUM, 8,
			OID, 48,
			OTID, 64,
			OREV, 32,
			CID, 32,
			CREV, 32,
			Offset(39),
			SSNM, 32,
			Offset(47),
			SSRT, 32
		}

		Store(BUF0, RFU0)

		// Modify Revision field of SSDT
		Store(Add(CREV, 1), CREV)

		// Recalculate and save CheckSum
		Store(RFU0, Local0)
		Store(Add(SUM, CHSM(Local0, SizeOf (Local0))), SUM)

		Store(5, Local1)

		while (Local1) {
			// Any next Load
			Load(RFU0, HI1)
			CH04(arg0, 0, 7, z174, 0x0e5, 5, Local1) // AE_ALREADY_EXISTS

			Store(ObjectType(HI1), Local0)
			if (LNotEqual(c009, Local0)) {
				err(arg0, z174, 0x0e6, 0, 0, Local0, c009)
			}

			Decrement(Local1)
		}

		UnLoad(HI0)

		if (CH03(arg0, z174, 0x0e7, 0, 0)) {
			return (1)
		}

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z174, 0x0e8, 0, 0, "\\SSS0", 1)
		}

		return (0)
	}
}

Method(TLD0,, Serialized)
{
	Name(ts, "TLD0")

	// Loading SSDT from a SystemMemory OpRegion,
	// different targets for DDBHandle

	CH03(ts, z174, 0x200, 0, 0)

	// Named Objects
	SRMT("TLD0.tst0")
	\DTM0.tst0(ts)

	CH03(ts, z174, 0x201, 0, 0)

	// LocalX Object
	SRMT("TLD0.tst1")
	\DTM0.tst1(ts)

	CH03(ts, z174, 0x202, 0, 0)

	// Package element
	SRMT("TLD0.tst2")
	\DTM0.tst2(ts)

	CH03(ts, z174, 0x203, 0, 0)

	// By Reference in ArgX
	SRMT("TLD0.tst3")
	\DTM0.tst3(ts)

	// Loading SSDT from a Field of an OpRegion of any type,
	// different targets for DDBHandle

	CH03(ts, z174, 0x204, 0, 0)

	// SystemMemory Region
	SRMT("TLD0.tst4")
	\DTM0.tst4(ts)

	CH03(ts, z174, 0x205, 0, 0)

	// SystemIO Region
	SRMT("TLD0.tst5")
	\DTM0.tst5(ts)

	CH03(ts, z174, 0x206, 0, 0)

	// EmbeddedControl Region
	SRMT("TLD0.tst6")
	\DTM0.tst6(ts)

	CH03(ts, z174, 0x207, 0, 0)

	// User defined Region
	SRMT("TLD0.tst7")
	\DTM0.tst7(ts)

	CH03(ts, z174, 0x208, 0, 0)

	// Check that "namespace location to load the Definition Block
	// is relative to the current namespace" scope,
	SRMT("TLD0.tst8")
	\DTM0.tst8(ts)

	CH03(ts, z174, 0x209, 0, 0)

	// Check global and dynamic declarations of OpRegions
	// and the appropriate _REG Methods invocation for the
	// loaded SSDT
	SRMT("TLD0.tst9")
	\DTM0.tst9(ts)

	CH03(ts, z174, 0x20a, 0, 0)

	// Object of any type can be used as the DDBHandle argument
	SRMT("TLD0.tstg")
	\DTM0.tstg(ts)

	CH03(ts, z174, 0x20b, 0, 0)

	// Loading a number of different SSDTs
	SRMT("TLD0.tsta")
	if (y261) {
		\DTM0.tsta(ts, 240)
	} else {
		BLCK()
	}

	CH03(ts, z174, 0x20c, 0, 0)
}

// Exceptional conditions
Method(TLD1,, Serialized)
{
	Name(ts, "TLD1")

	// Exceptions when the Object argument does not refer to
	// an operation region field or an operation region
	SRMT("TLD1.tstb")
	\DTM0.tstb(ts)

	// Exceptions when the an OpRegion passed as the Object
	// parameter of Load is not of SystemMemory type
	SRMT("TLD1.tstc")
	\DTM0.tstc(ts)

	// Exceptions when the table contained in an OpRegion
	// (Field) is not an SSDT
	SRMT("TLD1.tstd")
	\DTM0.tstd(ts)

	// Exceptions when the length of the supplied SSDT is greater
	// than the length of the respective OpRegion or Region Field,
	SRMT("TLD1.tste.0")
	if (y284) {
		\DTM0.tste(ts, 0)
	} else {
		BLCK()
	}

	// Exceptions when the length of the supplied SSDT is
	// less than the length of the Table Header
	SRMT("TLD1.tste.1")
	\DTM0.tste(ts, 1)

	// Exceptions when the checksum of the supplied SSDT is invalid
	SRMT("TLD1.tstf")
	\DTM0.tstf(ts)

	// AE_OWNER_ID_LIMIT exception when too many Tables loaded
	SRMT("TLD1.tsth")
	if (y294) {
		\DTM0.tsth(ts, 0)
	} else {
		BLCK()
	}

	// Exception when SSDT specified as the Object parameter
	// of the Load operator is already loaded
	SRMT("TLD1.tsti")
	\DTM0.tsti(ts)

	// Exception when there already is an previously created Object
	// referred by the namepath of the new Object in the Table loaded
	SRMT("TLD1.tstj")
	\DTM0.tstj(ts)
}
