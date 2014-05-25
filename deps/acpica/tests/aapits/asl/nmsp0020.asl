DefinitionBlock(
	"nmsp0020.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0020
	 */


	Name(STR0, "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*")

	Name(I000, 0)
	Name(ILIM, 199)

	Method(M000)
	{
		// 100 characters
		Store("0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789", Local0)

		// 101 characters
		Store("01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890", Local1)

		Concatenate(Local0, Local0)
		Increment(I000)

		Concatenate(Local0, Local1)
		Increment(I000)
	}

	Method(M001)
	{
		Store(0xffffffff1, Index(STR0, ILIM))
		Increment(ILIM)
		Increment(I000)

		Store(0xffffffff2, Index(STR0, ILIM))
		Increment(I000)
	}
}
