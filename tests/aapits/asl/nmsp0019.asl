DefinitionBlock(
	"nmsp0019.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0019
	 */


	Name(PAC0, Package(257){})

	Name(I000, 0)
	Name(ILIM, 256)

	Method(M000)
	{
		Store(0xffffffff1, Index(PAC0, ILIM))
		Increment(ILIM)
		Increment(I000)

		Store(0xffffffff2, Index(PAC0, ILIM))
		Increment(I000)
	}
}
