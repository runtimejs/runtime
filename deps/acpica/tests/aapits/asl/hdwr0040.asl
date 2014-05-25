DefinitionBlock(
	"hdwr0040.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Hardware test 0040
	 */

    Method(T040)
	{
        Store(Acquire(\_GL, 0), Local0)

		if (Local0) {
			Return (Local0)
		}

		Sleep(2000)

        Release(\_GL)

        Return (0)
    }
}
