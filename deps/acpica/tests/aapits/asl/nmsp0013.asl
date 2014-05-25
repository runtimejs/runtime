DefinitionBlock(
	"nmsp0013.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0013
	 */

	// Base of Buffer Fields
	Name(BUFZ, Buffer(20){
		160,161,162,163,164,165,166,167,168,169,
		170,171,172,173,174,175,176,177,178,179})

	Name(I000, 0)
	Name(ILEN, 0)

	Method(M000)
	{
		// Buffer Field
		Createfield(BUFZ, 0, ILEN, BFL0)

		Increment(I000)
	}
}
