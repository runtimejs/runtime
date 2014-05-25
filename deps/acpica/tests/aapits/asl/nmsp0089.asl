DefinitionBlock(
	"nmsp0089.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0089
	 */

	Name(p000, Package(1){})
	Name(p000, Package(1){})

	Method(MAIN)
	{
		Method(m000)
		{
			Name(i000, 1)

			Return (i000)
		}

		Store(p000, Debug)
		Store(0, p000)
		Store(p000, Debug)

		Store(m000(), Debug)
	}
}
