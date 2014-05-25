DefinitionBlock(
	"hdwr0019.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Hardware test 0015
	 */

    Name(\INT5, 0x15)

	Name(\_S0, Package(0x02){
        "0",
        0x00,
    })
    Name(\_S1, Package(0x02){
        0x01,
        "11",
    })
    Name(\_S2, Package(0x02){
        Buffer(1){2},
        0x12,
    })
    Name(\_S3, Package(0x02){
        0x03,
        Buffer(1){0x13},
    })
    Name(\_S4, Package(0x02){
		Package(0x01){0x04},
        0x14,
    })
    Name(\_S5, Package(0x02){
        0x05,
		INT5,
    })
}
