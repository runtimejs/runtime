DefinitionBlock(
	"ssdt1.aml",   // Output filename
	"SSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * SSDT table #1
	 */

	Name(i901, 0x9010)
	Name(s901, "String SSDT1")
	Name(p901, Package(1){"Package SSDT1"})

	Method(m901)
	{
		Method(m000)
		{
			Name(i000, 0x9011)

			Return (i000)
		}

		Store(p901, Debug)
		Store("String replace Package SSDT1", p901)
		Store(p901, Debug)

		Store(m000(), Debug)
	}
}
