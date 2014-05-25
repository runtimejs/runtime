DefinitionBlock(
	"nmsp0025.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0025
	 */

	Name(I000, 0)

	Method(M000)
	{
		Store(1, Local0)
		Store(Index(Local0, 0), Local1)
		Increment(I000)
	}
}
