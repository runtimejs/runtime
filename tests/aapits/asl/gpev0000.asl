DefinitionBlock(
	"gpev0000.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Gpe test 0000
	 */

	Include("../asl/tblm_aux.asl")

	Device(DGPE) {
		Name(_HID, "ACPI0006")
		Name(_STA, 0x0F)
		Name(_CRS, ResourceTemplate() {
			IRQ(Level, ActiveLow, Shared){13}})
	}

	Processor(NGPE, 0, 0, 0) {
		Name(_HID, "ACPI0006")
		Name(_STA, 0x0F)
		Name(_CRS, ResourceTemplate() {
			IRQ(Level, ActiveLow, Shared){13}})
	}
}
