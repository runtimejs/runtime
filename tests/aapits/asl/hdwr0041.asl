DefinitionBlock(
	"hdwr0041.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Hardware test 0041
	 */

	OperationRegion (OPR0, SystemMemory, 0x00, 0xFF)

	Field (OPR0, ByteAcc, Lock, Preserve) {FLU0,   8,}

	Field (OPR0, ByteAcc, NoLock, Preserve) {FLU1,   8,}

	Name(STEP, 0)

    Method(TNOL)
	{
		Increment(STEP)
		Store(STEP, FLU1)
		Return(STEP)
    }

    Method(TLCK)
	{
		Store(FLU0, Local0)
		Return(Local0)
    }
}
