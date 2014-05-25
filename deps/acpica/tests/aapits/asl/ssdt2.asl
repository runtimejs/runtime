DefinitionBlock(
	"ssdt2.aml",   // Output filename
	"SSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * SSDT table #2
	 */

	Name(i902, 0x9020)
	Name(s902, "String SSDT2")
	Name(p902, Package(1){"Package SSDT2"})

	Method(m902)
	{
		Method(m000)
		{
			Name(i000, 0x9021)

			Return (i000)
		}

		Store(p902, Debug)
		Store("String replace Package SSDT2", p902)
		Store(p902, Debug)

		Store(m000(), Debug)
	}
}
