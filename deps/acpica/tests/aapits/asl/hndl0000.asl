DefinitionBlock(
	"hndl0000.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Misc Handlers test 0000
	 */

	Include("../asl/tblm_aux.asl")

	// Device
	Device(DEV0) {Name(s000, "DEV0")}

	Device(\_SB_.DEV0) {Name(s000, "_SB_.DEV0")}

	// Power Resource
	PowerResource(PWR0, 0, 0) {Name(s000, "PWR0")}

	// Processor
	Processor(CPU0, 0x0, 0xFFFFFFFF, 0x0) {Name(s000, "CPU0")}

	// Thermal Zone
	ThermalZone(TZN0) {Name(s000, "TZN0")}

	/*
	 * unsupported object types
	 */

	// Integer
	Name(INT0, 0xfedcba9876543210)

	// String
	Name(STR0, "source string")

	// Buffer
	Name(BUF0, Buffer(9){9,8,7,6,5,4,3,2,1})

	// Package
	Name(PAC0, Package(3) {
		0xfedcba987654321f,
		"test package",
		Buffer(9){19,18,17,16,15,14,13,12,11},
	})

	// Field Unit
	Field(OPR0, ByteAcc, NoLock, Preserve) {
		FLU0, 69,
	}

	// Event
	Event(EVE0)

	// Method
	Method(MMM0) {Return ("ff0X")}

	// Mutex
	Mutex(MTX0, 0)

	// Operation Region
	OperationRegion(OPR0, SystemMemory, 0, 20)

	// Buffer Field
	Createfield(BUF0,   0, 69, BFL0)


	Method(M000, 2)
	{
		Store (Sizeof (Arg1), Local0)

		while (Local0) {
			Decrement (Local0)
			Notify (Arg0, Derefof(Index(Arg1, Local0)))
		}
	}

	Method(TST0)
	{
		Notify (DEV0, 0x00)
		Notify (DEV0, 0x20)
		Notify (DEV0, 0x7F)
		Notify (DEV0, 0x80)
		Notify (DEV0, 0xFF)

		Notify (\_SB_.DEV0, 0x01)
		Notify (\_SB_.DEV0, 0x21)
		Notify (\_SB_.DEV0, 0x7E)
		Notify (\_SB_.DEV0, 0x81)
		Notify (\_SB_.DEV0, 0xFE)

		Notify (CPU0, 0x02)
		Notify (CPU0, 0x22)
		Notify (CPU0, 0x7D)
		Notify (CPU0, 0x82)
		Notify (CPU0, 0xFD)

		Notify (TZN0, 0x03)
		Notify (TZN0, 0x23)
		Notify (TZN0, 0x7C)
		Notify (TZN0, 0x83)
		Notify (TZN0, 0xFC)

//		M000(PWR0, Package() {0x01, 0x21, 0x7E, 0x81, 0xFE})

		// Delay to allow the Events be dispatched
		Sleep (1000)
	}
}
