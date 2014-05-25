DefinitionBlock(
	"init0121.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Init tests 0121
	 */

	// Operation Region
	OperationRegion(OPR0, SystemMemory, 0, 48)

	// Device
	Device(DEV0) {
		Name(s000, "DEV0")
//		Name (_PRW, Package(2) {0x11, 3})

///*
		Name(WAKR, 1)

		// Field Unit
		Field(OPR0, ByteAcc, Lock, Preserve) {
			WOR0, 69,
			WOR3, 32,
		}

		Method (_PRW, 0, NotSerialized)
		{
			If (WAKR) {
				Return (WOR0)
			} Else {
				Return (WOR3)
			}
		}
//*/
	}

	Method(fact, 1)
	{
		if (Arg0) {
			Subtract(Arg0, 1, Local0)
			if (Local0) {
				Store (fact(Local0), Local1)
				Return (Multiply(Arg0, Local1))
			} else {
				Return (1)
			}
		} else {
			Return (1)
		}

	}

	Method(MAIN)
	{
		Return (fact(6))
	}
}
