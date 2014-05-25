DefinitionBlock(
	"nmsp0016.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0016
	 */


	Name(I000, 0)

	Method(M000)
	{
		Store(10000000000000000, Local0)
		ToBCD(Local0)
		Increment(I000)
	}
}
