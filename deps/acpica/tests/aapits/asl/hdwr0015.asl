DefinitionBlock(
	"hdwr0015.aml",   // Output filename
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

    Name(\_S0, Package(0x04){
        0x00,
        0x10,
        0x20,
        0x30
    })

    Name(\_S1, Package(0x04){
        0x01,
        0x11,
        0x21,
        0x31
    })

    Name(\_S2, Package(0x04){
        0x02,
        0x12,
        0x22,
        0x32
    })

    Name(\_S3, Package(0x04){
        0x03,
        0x13,
        0x23,
        0x33
    })

    Name(\_S4, Package(0x04){
        0x04,
        0x14,
        0x24,
        0x34
    })

    Name(\_S5, Package(0x04){
        0x05,
        0x15,
        0x25,
        0x35
    })
}
