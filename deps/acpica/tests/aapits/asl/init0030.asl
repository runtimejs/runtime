DefinitionBlock(
	"init0030.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Init tests 0030
	 */

	// Device
	Device(DEV0) {
		Name(s000, "DEV0")
		Name(i000, 0)

		Method (_INI, 0, NotSerialized)
		{
			Decrement (i000)
		}

		Method (_STA, 0, NotSerialized)
		{
			Return (0xf)
		}
	}
}
