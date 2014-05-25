DefinitionBlock(
	"hndl0115.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Misc Handlers test 0015
	 */

	OperationRegion(OPR4, SMBus, 0x69000, 0x14000)

	Method(TST5)
	{

		// Field Units
		Field(OPR4, BufferAcc, NoLock, Preserve) {FLU4, 74}

		// SMBus write requires Buffer
		// SMBus bidirectional buffer size
		// ACPI_SMBUS_BUFFER_SIZE          34
		Store (Buffer(34){0x04, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff}, FLU4)

	}
}
