DefinitionBlock(
	"nmsp0011.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0011
	 */

	Name(I000, 0)
	Name(I001, 0)
	Name(I002, 0)
	Name(I003, 0)

	Method(M000)
	{
		M001(RefOf(M002))

		Store(M003(), Local0)

		Increment(I000)
	}

	Method(M001, 1)
	{

		CopyObject(DeRefOf(Arg0), M003)

		Increment(I001)
	}

	Method(M002)
	{
		Increment(I002)
	}

	Method(M003)
	{
		Increment(I003)
		Return(0x3)
	}
}
