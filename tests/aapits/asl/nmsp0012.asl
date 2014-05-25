DefinitionBlock(
	"nmsp0012.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0012
	 */

	// Device
	Device(DEV0) {Name(s000, "DEV0")}

	Name(I000, 0)
	Name(I001, 0)

	Method(M000)
	{
		M001(DEV0)
		Increment(I000)
	}

	Method(M001, 1)
	{
		Add(Arg0, 1, Local0)
		Increment(I001)
	}
}
