DefinitionBlock(
	"init1065.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Init tests 0038 and 0039 supporting code
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

	Name (POUT, Package(1) {})
	Name (IMAX, 0)
	Name (IOUT, 0)

	// Useful for indirect storing

	Method(RSTO, 2) {Store(arg0, arg1)}

	Method(DSTO, 2) {Store(Derefof(arg0), arg1)}

	// Init the output package data
	Method(INIP, 2)
	{
		Store (0, IOUT)
		Store (arg0, IMAX)

		if (LLess(IMAX, 1)) {
			Store (1, IMAX)
		}

		if (LGreater(IMAX, 16)) {
			Store (16, IMAX)
		}

		Switch (IMAX) {
			Case (1) {RSTO(Package(1){}, Refof(POUT))}
			Case (2) {RSTO(Package(2){}, Refof(POUT))}
			Case (3) {RSTO(Package(3){}, Refof(POUT))}
			Case (4) {RSTO(Package(4){}, Refof(POUT))}
			Case (5) {RSTO(Package(5){}, Refof(POUT))}
			Case (6) {RSTO(Package(6){}, Refof(POUT))}
			Case (7) {RSTO(Package(7){}, Refof(POUT))}
			Case (8) {RSTO(Package(8){}, Refof(POUT))}
			Case (9) {RSTO(Package(9){}, Refof(POUT))}
			Case (10) {RSTO(Package(10){}, Refof(POUT))}
			Case (11) {RSTO(Package(11){}, Refof(POUT))}
			Case (12) {RSTO(Package(12){}, Refof(POUT))}
			Case (13) {RSTO(Package(13){}, Refof(POUT))}
			Case (14) {RSTO(Package(14){}, Refof(POUT))}
			Case (15) {RSTO(Package(15){}, Refof(POUT))}
			Case (16) {RSTO(Package(16){}, Refof(POUT))}
			Default   {RSTO(Package(32){}, Refof(POUT))}
		}

		OUTP(arg1)
	}

	Method(OUTP, 1)
	{
		if (LLess(IOUT, IMAX)) {
			Store (arg0, Index(POUT, IOUT))
			Increment(IOUT)
		}
	}

	Method(m134, 1)
	{
		Name(i000, 0x11)
		Name(i001, 0x22)
		Name(i002, 0x33)
		Name(i003, 0x44)
		Name(i004, 0x55)
		Name(i005, 0x66)
		Name(i006, 0x77)

		Method(m000, 7)
		{
			OUTP("LocalX case of Method started:")
	
			Store(RefOf(i000), Local0)
			Store(Local0, Local1)
			Store(Local1, Local2)
			Store(Local2, Local3)
			Store(Local3, Local4)
			Store(Local4, Local5)
			Store(Local5, Local6)

			Store(0x88, Local6)

			if (LNotEqual(i000, 0x11)) {
				OUTP("Error 0:")
				OUTP(i000)
			} else {
				if (LNotEqual(Local6, 0x88)) {
					OUTP("Error 10:")
				} else {
					OUTP("Ok 0:")
				}
				OUTP(Local6)
			}

			OUTP("LocalX case of Method finished")
		}

		Method(m001, 7)
		{
			OUTP("ArgX case of Method started:")

			Store(RefOf(i000), arg0)
			Store(arg0, arg1)
			Store(arg1, arg2)
			Store(arg2, arg3)
			Store(arg3, arg4)
			Store(arg4, arg5)
			Store(arg5, arg6)

			Store(0x88, arg6)

			if (LNotEqual(i000, 0x11)) {
				OUTP("Error 1:")
				OUTP(i000)
			} else {
				if (LNotEqual(arg6, 0x88)) {
					OUTP("Error 11:")
				} else {
					OUTP("Ok 1:")
				}
				OUTP(arg6)
			}

			OUTP("ArgX case of Method finished")
		}

		Method(m002, 7)
		{
			OUTP("references in ArgX case of Method started:")

//			Store(RefOf(i000), arg0)
			Store(arg0, arg1)
			Store(arg1, arg2)
			Store(arg2, arg3)
			Store(arg3, arg4)
			Store(arg4, arg5)
			Store(arg5, arg6)

			Store(0x88, arg6)

			if (LNotEqual(i000, 0x11)) {
				OUTP("Error 1:")
				OUTP(i000)
			} else {
				if (LNotEqual(arg6, 0x88)) {
					OUTP("Error 11:")
				} else {
					OUTP("Ok 1:")
				}
				OUTP(arg6)
			}

			OUTP("ArgX case of Method finished")
		}

		INIP(5, "Bug 134: ArgX term effectively becomes a LocalX term")

		if (LEqual(arg0, 0)) {
			m000(i000,i001,i002,i003,i004,i005,i006)
		} elseif (LEqual(arg0, 1)) {
			m001(i000,i001,i002,i003,i004,i005,i006)
		} elseif (LEqual(arg0, 2)) {
			m002(Refof(i000),Refof(i001),Refof(i002),Refof(i003),Refof(i004),
				Refof(i005),Refof(i006))
		}

		Return (POUT)
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
