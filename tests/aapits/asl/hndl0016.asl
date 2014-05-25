DefinitionBlock(
	"hndl0016.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Misc Handlers test 0016
	 */

	Include("../asl/tblm_aux.asl")

	// Operation Region
	OperationRegion(OPR0, SystemMemory, 0, 0x10000)
	OperationRegion(OPR1, SystemIO, 0x21000, 0x11000)
	OperationRegion(OPR2, PCI_Config, 0x32000, 0x12000)
	OperationRegion(OPR3, EmbeddedControl, 0x45000, 0x13000)
	OperationRegion(OPR4, SMBus, 0x69000, 0x14000)
	OperationRegion(OPR5, SystemCMOS, 0x83000, 0x15000)
	OperationRegion(OPR6, PciBarTarget, 0x98000, 0x16000)
//	OperationRegion(OPR7, UserDefRegionSpace, 0x100000, 0x17000)

	// Device
	Device(DEV0) {
		Name(s000, "DEV0")
		OperationRegion(OPR0, SystemMemory, 0, 0x10000)
		OperationRegion(OPR1, SystemIO, 0x21000, 0x11000)
	}

	// Processor
	Processor(CPU0, 0x0, 0xFFFFFFFF, 0x0) {
		Name(s000, "CPU0")
		OperationRegion(OPR2, PCI_Config, 0x32000, 0x12000)
		OperationRegion(OPR3, EmbeddedControl, 0x45000, 0x13000)
		OperationRegion(OPR4, SMBus, 0x69000, 0x14000)
	}


	// Thermal Zone
	ThermalZone(TZN0) {
		Name(s000, "TZN0")
		OperationRegion(OPR5, SystemCMOS, 0x83000, 0x15000)
		OperationRegion(OPR6, PciBarTarget, 0x98000, 0x16000)
	}


	// Device 1: check _REG calls co-ordination
	Device(DEV1) {
		Name(s000, "DEV0")
		OperationRegion(OPR0, SystemMemory, 0xB0000, 0x10000)

		Name(ACTV, 0)
		Name(DACT, 0)
		Name(DIFF, 0)
		Name(NERR, 0)

		Method(_REG, 2)
		{
			Store("_REG:", Debug)
			Store(arg0, Debug)
			Store(arg1, Debug)

			if (arg0) {
				Increment(NERR)
			} elseif (LGreater(arg1, 1)) {
				Increment(NERR)
			} else {
				if (arg1) {
					Increment(ACTV)
				} else {
					Increment(DACT)
				}
				Subtract(ACTV, DACT, DIFF)
			}
		}
	}


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

	// Power Resource
	PowerResource(PWR0, 0, 0) {Name(s000, "PWR0")}

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

		// Field Units
		Field(OPR0, ByteAcc, NoLock, Preserve) {FLU0, 70}
		Field(OPR1, ByteAcc, NoLock, Preserve) {FLU1, 71}
		Field(OPR2, ByteAcc, NoLock, Preserve) {FLU2, 72}
		Field(OPR3, ByteAcc, NoLock, Preserve) {FLU3, 73}
		Field(OPR4, BufferAcc, NoLock, Preserve) {FLU4, 74}
		Field(OPR5, ByteAcc, NoLock, Preserve) {FLU5, 75}
		Field(OPR6, ByteAcc, NoLock, Preserve) {FLU6, 76}

		Store (0xffffffffffffff00, FLU0)
		Store (0xffffffffffffff01, FLU1)
		Store (0xffffffffffffff02, FLU2)
		Store (0xffffffffffffff03, FLU3)

		// SMBus write requires Buffer
		// SMBus bidirectional buffer size
		// ACPI_SMBUS_BUFFER_SIZE          34
		Store (Buffer(34){0x04, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff}, FLU4)

		Store (0xffffffffffffff05, FLU5)
		Store (0xffffffffffffff06, FLU6)

	}

	Method(TST1)
	{

		// Field Units
		Field(\DEV0.OPR0, ByteAcc, NoLock, Preserve) {FLU0, 70}
		Field(\DEV0.OPR1, ByteAcc, NoLock, Preserve) {FLU1, 71}
		Field(\CPU0.OPR2, ByteAcc, NoLock, Preserve) {FLU2, 72}
		Field(\CPU0.OPR3, ByteAcc, NoLock, Preserve) {FLU3, 73}
		Field(\CPU0.OPR4, BufferAcc, NoLock, Preserve) {FLU4, 74}
		Field(\TZN0.OPR5, ByteAcc, NoLock, Preserve) {FLU5, 75}
		Field(\TZN0.OPR6, ByteAcc, NoLock, Preserve) {FLU6, 76}

		Store (0xffffffffffffff00, FLU0)
		Store (0xffffffffffffff01, FLU1)
		Store (0xffffffffffffff02, FLU2)
		Store (0xffffffffffffff03, FLU3)

		// SMBus write requires Buffer
		// SMBus bidirectional buffer size
		// ACPI_SMBUS_BUFFER_SIZE          34
		Store (Buffer(34){0x04, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff}, FLU4)

		Store (0xffffffffffffff05, FLU5)
		Store (0xffffffffffffff06, FLU6)

	}

	Method(TST2)
	{

		// Field Units
		Field(OPR0, ByteAcc, NoLock, Preserve) {FLU0, 70}
		Field(OPR1, ByteAcc, NoLock, Preserve) {FLU1, 71}
		Field(OPR2, ByteAcc, NoLock, Preserve) {FLU2, 72}
//		Field(OPR3, ByteAcc, NoLock, Preserve) {FLU3, 73}
//		Field(OPR4, BufferAcc, NoLock, Preserve) {FLU4, 74}
		Field(OPR5, ByteAcc, NoLock, Preserve) {FLU5, 75}
		Field(OPR6, ByteAcc, NoLock, Preserve) {FLU6, 76}

		Store (0xffffffffffffff00, FLU0)
		Store (0xffffffffffffff01, FLU1)
		Store (0xffffffffffffff02, FLU2)
//		Store (0xffffffffffffff03, FLU3)

		// SMBus write requires Buffer
		// SMBus bidirectional buffer size
		// ACPI_SMBUS_BUFFER_SIZE          34
//		Store (Buffer(34){0x04, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff}, FLU4)

		Store (0xffffffffffffff05, FLU5)
		Store (0xffffffffffffff06, FLU6)
	}

	Method(TST3)
	{
		// Field Units
		Field(\DEV0.OPR0, ByteAcc, NoLock, Preserve) {FLU0, 70}
		Field(\DEV0.OPR1, ByteAcc, NoLock, Preserve) {FLU1, 71}
		Field(\CPU0.OPR2, ByteAcc, NoLock, Preserve) {FLU2, 72}
//		Field(\CPU0.OPR3, ByteAcc, NoLock, Preserve) {FLU3, 73}
//		Field(\CPU0.OPR4, BufferAcc, NoLock, Preserve) {FLU4, 74}
		Field(\TZN0.OPR5, ByteAcc, NoLock, Preserve) {FLU5, 75}
		Field(\TZN0.OPR6, ByteAcc, NoLock, Preserve) {FLU6, 76}

		Store (0xffffffffffffff00, FLU0)
		Store (0xffffffffffffff01, FLU1)
		Store (0xffffffffffffff02, FLU2)
//		Store (0xffffffffffffff03, FLU3)

		// SMBus write requires Buffer
		// SMBus bidirectional buffer size
		// ACPI_SMBUS_BUFFER_SIZE          34
//		Store (Buffer(34){0x04, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff}, FLU4)

		Store (0xffffffffffffff05, FLU5)
		Store (0xffffffffffffff06, FLU6)

	}

	Method(TST4)
	{

		// Field Units
		Field(OPR0, ByteAcc, NoLock, Preserve) {FLU0, 14}

		Store (0x5aa5, FLU0)

	}

	Method(TST5)
	{

		// Field Units
		Field(OPR4, BufferAcc, NoLock, Preserve) {FLU4, 74}

		// SMBus write requires Buffer
		// SMBus bidirectional buffer size
		// ACPI_SMBUS_BUFFER_SIZE          34
		Store (Buffer(34){0x04, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff}, FLU4)

	}

	// For AtHndlrTest0038

	// Access dynamic OpRegions
	Method(TST6)
	{
		OperationRegion(OPR0, SystemMemory, 0x10001, 0x10000)
		OperationRegion(OPR1, SystemIO, 0x32001, 0x11000)
		OperationRegion(OPR2, PCI_Config, 0x44001, 0x12000)
		OperationRegion(OPR3, EmbeddedControl, 0x58001, 0x13000)
		OperationRegion(OPR4, SMBus, 0x7d001, 0x14000)
		OperationRegion(OPR5, SystemCMOS, 0x98001, 0x15000)
		OperationRegion(OPR6, PciBarTarget, 0xae001, 0x16000)

		// Field Units
		Field(OPR0, ByteAcc, NoLock, Preserve) {FLU0, 70}
		Field(OPR1, ByteAcc, NoLock, Preserve) {FLU1, 71}
		Field(OPR2, ByteAcc, NoLock, Preserve) {FLU2, 72}
		Field(OPR3, ByteAcc, NoLock, Preserve) {FLU3, 73}
		Field(OPR4, BufferAcc, NoLock, Preserve) {FLU4, 74}
		Field(OPR5, ByteAcc, NoLock, Preserve) {FLU5, 75}
		Field(OPR6, ByteAcc, NoLock, Preserve) {FLU6, 76}

		Store (0xffffffffffffff00, FLU0)
		Store (0xffffffffffffff01, FLU1)
		Store (0xffffffffffffff02, FLU2)
		Store (0xffffffffffffff03, FLU3)

		// SMBus write requires Buffer
		// SMBus bidirectional buffer size
		// ACPI_SMBUS_BUFFER_SIZE          34
		Store (Buffer(34){0x04, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff}, FLU4)

		Store (0xffffffffffffff05, FLU5)
		Store (0xffffffffffffff06, FLU6)

	}

	// Access both static and dynamic OpRegions
	Method(TST7)
	{
		// Static
		TST1()

		// Dynamic
		TST6()

		// Static, Root located
		TST0()
	}

	Device (PCI1) {
		OperationRegion (IDE1, PCI_Config, 0x00, 0xFF)

		Field (IDE1, DWordAcc, NoLock, Preserve) {
			Offset (0x6C),
			IPDC,   32}

		Name (_HID, EisaId ("PNP0A03"))

		Name (_CID, Package (0x03) {
			0x00102E4F,
			EisaId ("PNP0A01"),
			0x130FD041})

		Name (_ADR, 0x11)
		Name (_BBN, 0x11)

		Name (REGC, 0x00) // Count
		Name (REGE, 0x00) // NumErrors
		Name (REGS, 0xFF) // Status (Activate/DeActivate)

		Method(_REG, 2)
		{
			Store("\\PCI1._REG:", Debug)
			Store(arg0, Debug)
			Store(arg1, Debug)

			Increment(REGC)

			if (LNotEqual(arg0, 2)) { // PCI_Config
				Increment(REGE)
			} elseif (LAnd(LNotEqual(arg1, 1), LNotEqual(arg1, 0))) {
				Increment(REGE)
			} else {
				Store(arg1, REGS)
			}
		}

		// Device
		Device(DEVA) {Name(s000, "DEVA")}

		Method(ACC0)
		{
			Store("\\PCI1.ACC0:", Debug)
			Store(0xABCD, \PCI1.IPDC)
			Store(\PCI1.IPDC, Debug)
		}
	}

	Device (PCI2) {

		Device(DEVA) {
			Name(s000, "DEVA")

			OperationRegion (IDE1, PCI_Config, 0x100, 0xFF)

			Field (IDE1, DWordAcc, NoLock, Preserve) {
				Offset (0x6C),
				IPDC,   32}

			Name (_HID, EisaId ("XXX0A03"))

			Name (_CID, Package (0x03) {
				0x00102E4F,
				EisaId ("PNP0A03"),
				0x130FD041})

			Name (_ADR, 0x22)
			Name (_BBN, 0x22)

			Name (REGC, 0x00) // Count
			Name (REGE, 0x00) // NumErrors
			Name (REGS, 0xFF) // Status (Activate/DeActivate)

			Method(_REG, 2)
			{
				Store("\\PCI2.DEVA._REG:", Debug)
				Store(arg0, Debug)
				Store(arg1, Debug)

				Increment(REGC)

				if (LNotEqual(arg0, 2)) { // PCI_Config
					Increment(REGE)
				} elseif (LAnd(LNotEqual(arg1, 1), LNotEqual(arg1, 0))) {
					Increment(REGE)
				} else {
					Store(arg1, REGS)
				}
			}

			Method(ACC0)
			{
				Store("\\PCI2.DEVA.ACC0:", Debug)
				Store(0xABCD, \PCI2.DEVA.IPDC)
				Store(\PCI2.DEVA.IPDC, Debug)
			}
		}


		Device(DEVB) {
			Name(s000, "DEVB")

			OperationRegion (IDE1, PCI_Config, 0x200, 0xFF)

			Field (IDE1, DWordAcc, NoLock, Preserve) {
				Offset (0x6C),
				IPDC,   32}

			Name (_HID, EisaId ("XXX0A03"))

			Name (_CID, Package (0x03) {
				0x00102E4F,
				EisaId ("XXX0A03"),
				0x130FD041})

			Name (_ADR, 0x33)
			Name (_BBN, 0x33)

			Name (REGC, 0x00) // Count
			Name (REGE, 0x00) // NumErrors
			Name (REGS, 0xFF) // Status (Activate/DeActivate)

			Method(_REG, 2)
			{
				Store("\\PCI2.DEVB._REG:", Debug)
				Store(arg0, Debug)
				Store(arg1, Debug)

				Increment(REGC)

				if (LNotEqual(arg0, 2)) { // PCI_Config
					Increment(REGE)
				} elseif (LAnd(LNotEqual(arg1, 1), LNotEqual(arg1, 0))) {
					Increment(REGE)
				} else {
					Store(arg1, REGS)
				}
			}

			Method(ACC0)
			{
				Store("\\PCI2.DEVB.ACC0:", Debug)
				Store(0xABCD, \PCI2.DEVB.IPDC)
				Store(\PCI2.DEVB.IPDC, Debug)
			}
		}
	}
}
