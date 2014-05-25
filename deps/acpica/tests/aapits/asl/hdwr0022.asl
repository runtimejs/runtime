DefinitionBlock(
	"hdwr0022.aml",   // Output filename
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

    Name(SST0, 0)
    Name(SSA0, 0)
    Name(SSO0, 0)
    Name(SSA1, 0)
    Name(SSO1, 0)

    Name(BFS0, 0)
    Name(BFSA, 0)
    Name(BFSO, 0)

    Name(WAK0, 0)
    Name(WAKA, 0)
    Name(WAKO, 0)

    Scope(\_SI) {
		Method(_SST, 1){
			Increment(ORDR)
			Increment(SST0)
			if (LLess(SST0, 3)) {
				if (LEqual(SST0, 1)) {
					Store(Arg0, SSA0)
					Store(ORDR, SSO0)
				} else {
					Store(Arg0, SSA1)
					Store(ORDR, SSO1)
				}
			}
		}
    }

    Method(\_BFS, 1){
		Increment(ORDR)
		Increment(BFS0)
		Store(Arg0, BFSA)
		Store(ORDR, BFSO)
    }

    Method(\_WAK, 1){
		Increment(ORDR)
		Increment(WAK0)
		Store(Arg0, WAKA)
		Store(ORDR, WAKO)

		Return (Package(0x2){0x0, 0x1})
    }
}
