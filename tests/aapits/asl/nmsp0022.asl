DefinitionBlock(
	"nmsp0022.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0022
	 */

	Device(DEV0) {
		Name(IBAD, 0)
	}

	Name(I000, 0)

	Method(M000)
	{
		Store(1, Local0)
		Store(Local0, \DEV0.IBAD)
		Increment(I000)
	}
}
