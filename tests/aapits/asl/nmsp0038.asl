DefinitionBlock(
	"nmsp0038.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0038
	 */

	Name(I000, 0)

	Method(M000)
	{
		Store(M001(M001(M001(M001(1, 2), M001(4, 8)), M001(M001(16, 32), M001(64, 128))),
			M001(M001(M001(256, 512), M001(1024, 2048)),
				M001(M001(4096, 8192), M001(16384, 32768)))), Debug)
		Increment(I000)
	}

	Method(M001, 2)
	{
		Return(Add(Arg0, Arg1))
	}
}
