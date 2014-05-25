DefinitionBlock(
	"nmsp0023.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0023
	 */

	Device(DEV0) {
		Name(IBAD, 0)
	}

	Name(I000, 0)

	Method(M000)
	{
		Store(Refof(\DEV0.IBAD), Local0)
		Increment(I000)
	}
}
