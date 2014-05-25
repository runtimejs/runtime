DefinitionBlock(
	"init0066.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	Name(INT0, 64)

	// Base of Buffer Field
	Name(BUFY, Buffer(9){1,2,3,4,5,6,7,8,0xff})

	Createfield(BUFY, 0, INT0, BFL0)
//	Createfield(BUFY, 0, Add(INT0, 1), BFL1)
	Method(MBF0)
	{
		Return (BFL0)
	}

/*
	Method(MBF1)
	{
		Return (BFL1)
	}
*/
}
