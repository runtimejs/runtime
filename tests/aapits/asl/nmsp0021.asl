DefinitionBlock(
	"nmsp0021.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0021
	 */


	Name(I000, 0)

	Method(M000)
	{
		Divide(1, I000)
		Increment(I000)
	}
}
