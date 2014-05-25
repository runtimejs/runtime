DefinitionBlock(
	"tblm0058.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite.
	 * Support Table Management test 0058, reproducing bug 34
	 * Implements the following functional ASL Methods:
	 * INIT - preparing for emulation of a initialy loaded SSDT in an OpRegion,
	 * LD - loading the SSDT by Load ASL operator,
	 */

	// SSDT1
	Name(BUF0, Buffer() {
	    0x53,0x53,0x44,0x54,0x30,0x00,0x00,0x00, /* 00000000    "SSDT0..." */
		0x01,0xB8,0x49,0x6E,0x74,0x65,0x6C,0x00, /* 00000008    "..Intel." */
		0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00, /* 00000010    "Many...." */
		0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C, /* 00000018    "....INTL" */
		0x24,0x04,0x03,0x20,0x14,0x0B,0x5F,0x54, /* 00000020    "$.. .._T" */
		0x39,0x38,0x00,0x70,0x0A,0x04,0x60,0xA4, /* 00000028    "98.p..`." */
	})

	Name (HI0, 0x00)
	Name (HI0F, 0x00)
	Name (INIF, 0x00)

	OperationRegion (IST0, SystemMemory, 0, 0x1FA)
	Field(IST0, ByteAcc, NoLock, Preserve) {
		RFU0, 0xFD0,
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
		if (HI0F) {
			Store("LD: SSDT has been loaded previously", Debug)
			Return (1)
		}

//		Load(IST0, HI0)
		Load(RFU0, HI0)
		Store(1, HI0F)
		Store("LD: SSDT Loaded", Debug)
		Return (0)
	}

	Method(UNLD)
	{
		if (LNotEqual(HI0F, 1)) {
			Store("UNLD: SSDT has not been loaded ", Debug)
			Return (1)
		}

		UnLoad(HI0)
		Store("UNLD: SSDT UnLoaded", Debug)
		Store(0, HI0)
		Store(0, HI0F)

		Return (0)
	}

	Method(MAIN)
	{
		INIT()
		LD()
	}
}
