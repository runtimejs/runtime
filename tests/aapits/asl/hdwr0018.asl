DefinitionBlock(
	"hdwr0018.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Hardware test 0018
	 */

    Name(\_S0,Package(0x01){
        0x00,
    })
    Name(\_S1,Package(0x01){
        0x01,
    })
    Name(\_S2,Package(0x01){
        0x02,
    })
    Name(\_S3,Package(0x01){
        0x03,
    })
    Name(\_S4,Package(0x01){
        0x04,
    })
    Name(\_S5,Package(0x00){
    })
}
