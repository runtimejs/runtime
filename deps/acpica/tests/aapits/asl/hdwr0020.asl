DefinitionBlock(
	"hdwr0020.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Hardware test 0020
	 */

    Name(\_S0, Package(0x02){
        0x00,
        0x01,
    })

    Name(\_S1, Package(0x02){
        0x01,
        0x02,
    })

    Name(\_S2, Package(0x02){
        0x02,
        0x03,
    })

    Name(\_S3, Package(0x02){
        0x03,
        0x04,
    })

    Name(\_S4, Package(0x02){
        0x04,
        0x05,
    })

    Name(\_S5, Package(0x02){
        0x05,
        0x06,
    })

    Name(ORDR, 0)
    Name(PTSA, 0)
    Name(PTS0, 0)
    Name(GTSA, 0)
    Name(GTS0, 0)

    Method(\_PTS, 1){
		if (LEqual(ORDR, 0)) {
			Increment (ORDR)
		}
		Store(Arg0, PTSA)
		Increment (PTS0)
    }

    Method(\_GTS, 1){
		if (LEqual(ORDR, 1)) {
			Increment (ORDR)
		}
		Store(Arg0, GTSA)
		Increment (PTS0)
    }
}
