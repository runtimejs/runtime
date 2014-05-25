DefinitionBlock(
	"nmsp0014.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0014
	 */


	Name(I000, 0)
	Name(IFLG, 0)

	Method(M000)
	{
		if (IFLG) {
			Store(1, Local0)
		}
		Store(Local0, Local1)

		Increment(I000)
	}
}
