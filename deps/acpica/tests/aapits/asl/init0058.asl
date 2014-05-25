DefinitionBlock(
	"init0058.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Init test 0058 supporting code
	 */

	// Integer
	Name(INT0, 0)
	Name(INT1, 0xfedcba9876543211)
	Name(INT2, 257)
	Name(INT3, 65)

	// String
	Name(STR0, "source string")
	Name(STR1, "target string")
	Name(STR2, "string")

	// Buffer
	Name(BUF0, Buffer(9){9,8,7,6,5,4,3,2,1})
	Name(BUF1, Buffer(17){0xc3})

	// Initializer of Fields
	Name(BUF2, Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,0x15})

	// Base of Buffer Fields
	Name(BUFY, Buffer(INT2){})
	Name(BUFZ, Buffer(9){0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88})

	// Package
	Name(PAC0, Package(3) {
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

	Name(INVC, 0)	// Counter of Devices' _INI and _STA methods invocations
	Name(INVM, 0)	// Mask of Devices' _INI and _STA methods invocations

	// Without the _STA or _INI methods
	Device(DEV0) {Name(s000, "DEV0")}

	// With the _INI method only (default _STA)
	Device(DEV1) {
		Name(s000, "DEV1")
		Method(_INI) {
			Increment(INVC)
			Or(INVM, 0x01, INVM)
		}
	}

	// With the _STA method only
	Device(\_SB.DEV2) {
		Name(s000, "DEV2")
		Method(_STA) {
			Increment(INVC)
			Or(INVM, 0x02, INVM)
			Return(0xf)
		}
	}

	// With the both _INI and _STA methods
	Device(\DEV0.DEV3) {
		Name(s000, "DEV3")
		Method(_INI) {
			Increment(INVC)
			Or(INVM, 0x04, INVM)
		}
		Method(_STA) {
			Increment(INVC)
			Or(INVM, 0x08, INVM)
			Return(0xf)
		}
	}

	// With the both _INI and _STA methods
	Device(\DEV0.DEV3.DEV4) {
		Name(s000, "DEV4")
		Method(_INI) {
			Increment(INVC)
			Or(INVM, 0x10, INVM)
		}
		Method(_STA) {
			Increment(INVC)
			Or(INVM, 0x20, INVM)
			Return(0xf)
		}
	}

	// With the both _INI and _STA methods
	Device(\DEV0.DEV5) {
		Name(s000, "DEV5")
		Method(_INI) {
			Increment(INVC)
			Or(INVM, 0x40, INVM)
		}
		Method(_STA) {
			Increment(INVC)
			Or(INVM, 0x80, INVM)
			Return(0xf)
		}
	}

	// With the both _INI and _STA methods,
	// but the last indicates that device:
	// - is not present,
	// - is not enabled.
	Device(\DEV0.DEV6) {
		Name(s000, "DEV6")
		Method(_INI) {
			Increment(INVC)
			Or(INVM, 0x100, INVM)
		}
		Method(_STA) {
			Increment(INVC)
			Or(INVM, 0x200, INVM)
			Return(0xc)
		}
	}

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
	OperationRegion(OPR0, SystemMemory, 0, 48)
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
	Createfield(BUFZ,   0, 69, BFL0)

	Method(M000, 7)
	{
		Increment(INT0)
	}

	Method(M001)
	{
		Return(BFL0)
	}

	Method(fact, 1)
	{
		if (Arg0) {
			Subtract(Arg0, 1, Local0)
			if (Local0) {
				Store (fact(Local0), Local1)
				Return (Multiply(Arg0, Local1))
			} else {
				Return (1)
			}
		} else {
			Return (1)
		}

	}

	Method(MAIN)
	{
		Return (fact(6))
	}
}
