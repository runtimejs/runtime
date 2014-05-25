DefinitionBlock(
	"nmsp0010.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0010
	 */

	Name(I000, 0)
	Name(I001, 0)

	Method(M000, 1)
	{
		Method(M001)
		{
			Mutex(MTX1, 0x0100)

			Stall(1)

			Increment(I001)
		}

		M001()

		Increment(I000)
	}
}
