DefinitionBlock(
	"dsdt0.aml", // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * DSDT table
	 */

	Name(i900, 0x9000)
	Name(s900, "String DSDT")
	Name(p900, Package(1){"Package DSDT"})

	Method(m900)
	{
		Method(m000)
		{
			Name(i000, 0x9001)

			Return (i000)
		}

		Store(p900, Debug)
		Store("String replace Package DSDT", p900)
		Store(p900, Debug)

		Store(m000(), Debug)
	}
}
