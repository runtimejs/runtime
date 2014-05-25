DefinitionBlock(
	"nmsp0018.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0018
	 */


	Name(BUF0, Buffer(513){})

	Name(I000, 0)
	Name(ILIM, 512)

	Method(M000)
	{
		Store(0x81, Index(BUF0, ILIM))
		Increment(ILIM)
		Increment(I000)

		Store(0x82, Index(BUF0, ILIM))
		Increment(I000)
	}
}
