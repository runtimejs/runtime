DefinitionBlock(
	"init0034.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Init tests 0034 ... supporting code
	 */

	// Integer
	Name(INT0, 0)
	Name(INT1, 0xfedcba9876543211)
	Name(INT2, 257)
	Name(INT3, 65)

	// String
	Name(STR0, "source string")
	Name(STR1, "target string")

	// Buffer

	Name(INTB, 9)

	Name(BUF0, Buffer(Increment(INTB)){9,8,7,6,5,4,3,2,1})

	Name(BUF1, Buffer(17){0xc3})

	// Initializer of Fields
	Name(BUF2, Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,0x15})

	// Base of Buffer Fields
	Name(BUFX, Buffer(17){16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0})
	Name(BUFY, Buffer(INT2){})
	Name(BUFZ, Buffer(9){0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0xff})

	// Package

	Name(INTP, 3)

	Name(PAC0, Package(Increment(INTP)) {
		0xfedcba987654321f,
		"test package",
		Buffer(9){19,18,17,16,15,14,13,12,11},
	})

	Name(PAC1, Package(1) {"target package"})

	Name(PACO, Package(2) {"OPR0", "OPR1"})
	Name(PACB, Package(4) {"BFL0", "BFL2", "BFL4", "BFL6"})

	// Field Unit
	Field(OPR0, ByteAcc, NoLock, Preserve) {
		FLU0, 69,
		FLU2, 64,
		FLU4, 32,
	}

	// Device
	Device(DEV0) {Name(s000, "DEV0")}
	Device(DEV1) {Name(s000, "DEV1")}

	// Event
	Event(EVE0)
	Event(EVE1)

	// Method
	Name(MM00, "ff0X")	// Value, returned from MMMX
	Name(MM01, "ff1Y")	// Value, returned from MMMY
	Name(MMM0, 0)	// Method as Source Object
	Name(MMM1, 0)	// Method as Target Object
	Method(MMMX) {Return (MM00)}
	Method(MMMY) {Return (MM01)}

	// Mutex
	Mutex(MTX0, 0)
	Mutex(MTX1, 0)

	// Operation Region

	Name(INTR, 49)

	OperationRegion(OPR0, SystemMemory, 0, Increment(INTR))

	OperationRegion(OPR1, SystemMemory, 0, 24)

	// Power Resource
	PowerResource(PWR0, 0, 0) {Name(s000, "PWR0")}
	PowerResource(PWR1, 0, 0) {Name(s000, "PWR1")}

	// Processor
	Processor(CPU0, 0x0, 0xFFFFFFFF, 0x0) {Name(s000, "CPU0")}
	Processor(CPU1, 0x0, 0xFFFFFFFF, 0x0) {Name(s000, "CPU1")}

	// Thermal Zone
	ThermalZone(TZN0) {Name(s000, "TZN0")}
	ThermalZone(TZN1) {Name(s000, "TZN1")}

	// Buffer Field

	Name(INTF, 64)

	CreateField(BUFZ, 0, Increment(INTF), BFL0)

	Name(INTG, 6)

	CreateByteField(BUFZ, Increment(INTG), BFL1)

	Name(INTH, 4)

	CreateWordField(BUFZ, Increment(INTH), BFL2)

	Name(INTI, 2)

	CreateDWordField(BUFZ, Increment(INTI), BFL3)

	Name(INTJ, 0)

	CreateQWordField(BUFX, Increment(INTJ), BFL4)

	Method(M000)
	{
		Increment(INT0)
	}

	Method(M001)
	{
		Return(BFL0)
	}

	Method(M002)
	{
		Name(INTB, 63)
		Createfield(BUFZ, 0, Increment(INTB), BFL0)

		Return(BFL0)
	}
}
