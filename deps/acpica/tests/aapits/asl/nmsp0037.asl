DefinitionBlock(
	"nmsp0037.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0037
	 */

	Name(I000, 0)

	External(M001, MethodObj)

	Method(M000)
	{
		M001()
		Increment(I000)
	}
}
