DefinitionBlock(
	"nmsp0017.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0017
	 */

	Name(ILEN, 7)

	// Operation Region
	OperationRegion(OPR0, SystemMemory, 0, ILEN)

	Field(OPR0, ByteAcc, NoLock, Preserve) {
		FLU0, 56,
	}
	Field(OPR0, ByteAcc, NoLock, Preserve) {
		FLU1, 64,
	}

	Name(I000, 0)

	Method(M000)
	{
		Store(0xfedcba987654321, FLU0)
		Increment(I000)

		Store(0x1fedcba987654321, FLU1)
		Increment(I000)
	}
}
