DefinitionBlock(
	"nmsp0015.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0015
	 */


	Name(I000, 0)
	Name(I001, 0)
	Name(I002, 0)

	Method(M000, 1)
	{
		Store(Arg0, Local0)
		Increment(I000)
	}

	Method(M001)
	{
		M002()
		Increment(I001)
	}

	Method(M002)
	{
		Increment(I002)
		Store(Arg0, Local0)
		Increment(I002)
	}
}
