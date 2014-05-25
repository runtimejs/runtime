DefinitionBlock(
	"tblm0037.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite.
	 * Support Table Management test 0037.
	 * Implements the following functional ASL Methods:
	 * INIT - preparing for emulation of a initialy loaded SSDT in an OpRegion,
	 * LD - loading the next modified SSDT by Load ASL operator,
	 */

	Name(BUF0, Buffer() {
	    0x53,0x53,0x44,0x54,0x30,0x00,0x00,0x00, /* 00000000    "SSDT0..." */
		0x01,0xB8,0x49,0x6E,0x74,0x65,0x6C,0x00, /* 00000008    "..Intel." */
		0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00, /* 00000010    "Many...." */
		0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C, /* 00000018    "....INTL" */
		0x24,0x04,0x03,0x20,0x14,0x0B,0x53,0x53, /* 00000020    "$.. ..SS" */
		0x30,0x30,0x00,0x70,0x0A,0x04,0x60,0xA4, /* 00000028    "00.p..`." */
	})

	Name (HI0M, 100)
	Name (HI0P, Package(HI0M){})
	Name (HI0N, 0)
	Name (INIF, 0x00)

	OperationRegion (IST0, SystemMemory, 0, 0x1FA)

	Field(IST0, ByteAcc, NoLock, Preserve) {
		RFU0, 0xFD0,
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
		Offset(38),
		SSNM, 32
	}

	// components/utilities/utmisc.c AcpiUtGenerateChecksum() analog
	Method(CHSM, 2)	// buf, len
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

	Method(INIT)
	{
		if (INIF) {
			Store("INIT: OpRegion has been initialized previously", Debug)
			Return (1)
		}
		Store(BUF0, RFU0)
		Store(1, INIF)
		Store("INIT: OpRegion initialized with SSDT", Debug)

		Return (0)
	}

	Method(LD)
	{
		Name(HI0, 0)

		if (LNot(LLess(Add(HI0N, 1), HI0M))) {
			Store("LD: too many tables loaded", Debug)
			Return (1)
		}
		Increment(HI0N)

		// Modify Revision field of SSDT
		Store(Add(CREV, 1), CREV)

		// Modify SSNM Object Name
		Divide(HI0N, 10, Local0, Local1)
		ShiftLeft(Local1, 16, Local1)
		ShiftLeft(Local0, 24, Local0)
		Add(Local0, Local1, Local0)
		Add(Local0, 0x30305353, Local0)
		Store(Local0, SSNM)
		Store(SSNM, Debug)

		// Recalculate and save CheckSum
		Store(RFU0, Local0)
		Store(Add(SUM, CHSM(Local0, SizeOf (Local0))), SUM)

//		Load(IST0, HI0)
		Load(RFU0, HI0)
		Store("LD: SSDT Loaded", Debug)
//		Store(HI0, Index(HI0P, HI0N))

		Return (0)
	}

	Method(UNLD)
	{
		Name(HI0, 0)

		if (LEqual(HI0N, 0)) {
			Store("UNLD: there are no SSDT loaded", Debug)
			Return (1)
		}
		Decrement(HI0N)

		Store(DerefOf(Index(HI0P, HI0N)), HI0)

		UnLoad(HI0)
		Store("UNLD: SSDT UnLoaded", Debug)

		Return (0)
	}

	Method(MAIN)
	{
		INIT()
		LD()
		LD()
//		UNLD()
//		UNLD()
	}
}
