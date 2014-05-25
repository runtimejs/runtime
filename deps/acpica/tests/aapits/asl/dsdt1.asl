DefinitionBlock(
	"dsdt1.aml", // Output filename
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

	Name(ia00, 0xa001)
	Name(sa01, "String DSDT1")
	Name(p901, Package(1){"Package DSDT1"})

	Method(ma01)
	{
		Method(m000)
		{
			Name(i000, 0xffffa001)

			Return (i000)
		}

		Store(p901, Debug)
		Store("String replace Package DSDT1", p901)
		Store(p901, Debug)

		Store(m000(), Debug)
	}
}
