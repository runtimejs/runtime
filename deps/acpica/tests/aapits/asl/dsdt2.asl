DefinitionBlock(
	"dsdt2.aml", // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * DSDT table #1
	 */

	Name(ia00, 0xa002)
	Name(sa02, "String DSDT2")
	Name(p902, Package(1){"Package DSDT2"})

	Method(ma02)
	{
		Method(m000)
		{
			Name(i000, 0xffffa002)

			Return (i000)
		}

		Store(p902, Debug)
		Store("String replace Package DSDT2", p902)
		Store(p902, Debug)

		Store(m000(), Debug)
	}
}
