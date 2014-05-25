DefinitionBlock(
	"nmsp0000.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	Include("../asl/tblm_aux.asl")

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0000
	 */

	// Objects of different types on Global Level

	// Integer
	Name(INT0, 0xfedcba9876543210)

	// String
	Name(STR0, "source string")

	// Buffer
	Name(BUF0, Buffer(9){9,8,7,6,5,4,3,2,1})

	// Base of Buffer Fields
	Name(BUFZ, Buffer(20){
		160,161,162,163,164,165,166,167,168,169,
		170,171,172,173,174,175,176,177,178,179})

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

	// Device
	Device(DEV0) {Name(s000, "DEV0")}

	// Event
	Event(EVE0)

	// Method
	Method(MMM0) {Return ("ff0X")}

	// Mutex
	Mutex(MTX0, 0)

	// Operation Region
	OperationRegion(OPR0, SystemMemory, 0, 20)

	// Power Resource
	PowerResource(PWR0, 0, 0) {Name(s000, "PWR0")}

	// Processor
	Processor(CPU0, 0x0, 0xFFFFFFFF, 0x0) {Name(s000, "CPU0")}

	// Thermal Zone
	ThermalZone(TZN0) {Name(s000, "TZN0")}

	// Buffer Field
	Createfield(\BUFZ,   0, 69, BFL0)

	// Output Integer
	Name(IOUT, 0x1FF)

	// Output Buffer
	Name(BOUT, Buffer(8){})

	// Objects to check access to NS tree

	Name(n0l0, 0x0000)
	Name(n0l1, 0x0001)
	Name(n0l2, 0x0002)
	Name(n0l3, 0x0003)
	Name(l4, 0x0004)

	Device(d1l0) {
		// Objects of different types on Level 1

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

		// Device
		Device(DEV0) {Name(s000, "DEV0")}

		// Event
		Event(EVE0)

		// Method
		Method(MMM0) {Return ("ff0X")}

		// Mutex
		Mutex(MTX0, 0)

		// Operation Region
		OperationRegion(OPR0, SystemMemory, 0, 20)

		// Power Resource
		PowerResource(PWR0, 0, 0) {Name(s000, "PWR0")}

		// Processor
		Processor(CPU0, 0x0, 0xFFFFFFFF, 0x0) {Name(s000, "CPU0")}

		// Thermal Zone
		ThermalZone(TZN0) {Name(s000, "TZN0")}

		// Buffer Field
		Createfield(\BUFZ,   0, 69, BFL0)
	}

	Method(M100)
	{
		Increment(IOUT)
	}

	Method(M000)
	{
		Store(0x200, IOUT)

		Return (IOUT)
	}

	Device(d1l1) {
		Name(_HID, "PNP0A01")
		Name(_UID, 0)
		Name(_CID, "PNP0A21")
		Name(_ADR, 0xF00000001)
		Name(_STA, 0xFFFFFFFFF)
		Name(_S1D, 0x01)

		Method(M000)
		{
			Store(0x201, IOUT)

			Return (IOUT)
		}

		Method(M001, 1)
		{
			Store(Arg0, Index(BOUT, 0))

			Return (BOUT)
		}

		Device(d2l0) {
			Method(_HID) {Return (EISAID("PNP0A02"))}
			Name(_UID, 1)
			Name(_CID, EISAID("PNP0A22"))
			Name(_ADR, 0xF00000002)
			Name(_S2D, 0x02)

			Method(M000)
			{
				Store(0x202, IOUT)

				Return (IOUT)
			}

			Method(M002, 2)
			{
				Store(Arg0, Index(BOUT, 0))
				Store(Arg1, Index(BOUT, 1))

				Return (BOUT)
			}

			Device(d3l0) {
				Name(_HID, "ACPI0A03")
				Method(_UID) {Return ("d3l0_UID")}
				Name(_CID, Package(){"PNP0A23", "PCI\\VEN_1234&DEV_5678"})
				Name(_ADR, 0xF00000003)
				Name(_STA, 0xFFFFFFEF)
				Method(_S3D) {Return (0x03)}

				Method(M000)
				{
					Store(0x203, IOUT)

					Return (IOUT)
				}

				Method(M003, 3)
				{
					Store(Arg0, Index(BOUT, 0))
					Store(Arg1, Index(BOUT, 1))
					Store(Arg2, Index(BOUT, 2))

					Return (BOUT)
				}

				Device(d4l) {
					Name(_HID, EISAID("PNP0A04"))
					Name(_UID, 999999999)
					Method(_CID) {Return ("PNP0A24")}
					Name(_STA, 0xFFFFFF7)
					Name(_S4D, 0x04)

					Method(M000)
					{
						Store(0x204, IOUT)

						Return (IOUT)
					}

					Method(M004, 4)
					{
						Store(Arg0, Index(BOUT, 0))
						Store(Arg1, Index(BOUT, 1))
						Store(Arg2, Index(BOUT, 2))
						Store(Arg3, Index(BOUT, 3))

						Return (BOUT)
					}

					Device(d5l0) {
						Name(_HID, "PNP0A05")
						Name(_UID, 1000000000)
						Name(_CID, EISAID("PNP0A25"))
						Method(_ADR) {Return (0xF00000005)}
						Name(_STA, 0xFFFFFB)

						Method(M000)
						{
							Store(0x205, IOUT)

							Return (IOUT)
						}

						Method(M005, 5)
						{
							Store(Arg0, Index(BOUT, 0))
							Store(Arg1, Index(BOUT, 1))
							Store(Arg2, Index(BOUT, 2))
							Store(Arg3, Index(BOUT, 3))
							Store(Arg4, Index(BOUT, 4))

							Return (BOUT)
						}

						Device(d6l0) {
							Name(_HID, EISAID("PNP0A06"))
							Name(_UID, "d6l0_UID")
							Name(_ADR, 0xF00000006)
							Method(_STA) {Return (0xFFFFD)}
							Name(_S1D, 0x04)
							Name(_S2D, 0x03)
							Name(_S3D, 0x02)
							Name(_S4D, 0x01)

							Method(M000)
							{
								Store(0x206, IOUT)

								Return (IOUT)
							}

							Method(M006, 6)
							{
								Store(Arg0, Index(BOUT, 0))
								Store(Arg1, Index(BOUT, 1))
								Store(Arg2, Index(BOUT, 2))
								Store(Arg3, Index(BOUT, 3))
								Store(Arg4, Index(BOUT, 4))
								Store(Arg5, Index(BOUT, 5))

								Return (BOUT)
							}

							Device(d7l0) {
								Name(_HID, "ACPI0A07")
								Method(_CID) {Return (Package(){
											"PNP0A27",
											EISAID("PNP0A04"),
											"PCI\\VEN_ffff&DEV_dddd&SUBSYS_cccccccc&REV_01"})}
								Name(_ADR, 0xF00000007)
								Name(_STA, 0xFFFF)
								Name(_S1D, 0x01)
								Name(_S3D, 0x02)

								Method(M000)
								{
									Store(0x207, IOUT)

									Return (IOUT)
								}

								Method(M007, 7)
								{
									Store(Arg0, Index(BOUT, 0))
									Store(Arg1, Index(BOUT, 1))
									Store(Arg2, Index(BOUT, 2))
									Store(Arg3, Index(BOUT, 3))
									Store(Arg4, Index(BOUT, 4))
									Store(Arg5, Index(BOUT, 5))
									Store(Arg6, Index(BOUT, 6))

									Return (BOUT)
								}
								Device(d8l0) {
									Name(_UID, "d8l0_UID")
									Name(_CID, "PNP0A28")
									Name(_ADR, 0xF00000008)
									Name(_STA, 0xFFFE)
									Name(_S2D, 0xf3)
									Name(_S3D, 0xe2)
									Method(_S4D) {Return (0xd1)}

									Method(M000)
									{
										Store(0x208, IOUT)

										Return (IOUT)
									}

									Device(d9l0) {
										Name(_HID, EISAID("PNP0A09"))
										Name(_UID, "d9l0_UID")
										Name(_CID, Package(){
											EISAID("PNP0A29"),
											"PCI\\CC_1234",
											"PCI\\CC_546372",
											"PCI\\VEN_ffff&DEV_dddd&SUBSYS_cccccccc&REV_01",
											"PCI\\VEN_eeee&DEV_cccc&SUBSYS_bbbbbbbb",
											"PCI\\VEN_dddd&DEV_bbbb&REV_23",
											"PCI\\VEN_cccc&DEV_aaaa"})
										Name(_ADR, 0xF00000009)
										Name(_STA, 0x0)

										Method(M000)
										{
											Store(0x209, IOUT)

											Return (IOUT)
										}

									}
								}
							}
						}
					}
				}
			}
		}
	}
	Device(d1l2) {
	}
	Scope (d1l0) {
		Name(n0l0, 0x0100)
		Name(n0l1, 0x0101)
		Name(n0l2, 0x0102)
		Name(n0l3, 0x0103)
		Name(l4, 0x0104)
	}
	Scope (d1l1) {
		Name(n0l0, 0x0110)
		Name(n1l1, 0x0111)
		Name(n0l2, 0x0112)
		Name(n1l3, 0x0113)
		Name(l4, 0x0114)
		Scope (d2l0) {
			Name(n0l0, 0x0120)
			Name(n1l1, 0x0121)
			Name(n0l2, 0x0122)
			Name(n1l3, 0x0123)
			Name(l4, 0x0124)
			Scope (d3l0) {
				Name(n0l0, 0x0130)
				Name(n1l1, 0x0131)
				Name(n0l2, 0x0132)
				Name(n1l3, 0x0133)
				Name(l4, 0x0134)
				Scope (d4l) {
					Name(n0l0, 0x0140)
					Name(n1l1, 0x0141)
					Name(n0l2, 0x0142)
					Name(n1l3, 0x0143)
					Name(l4, 0x0144)
					Scope (d5l0) {
						Name(n0l0, 0x0150)
						Name(n1l1, 0x0151)
						Name(n0l2, 0x0152)
						Name(n1l3, 0x0153)
						Name(l4, 0x0154)
						Scope (d6l0) {
							Name(n0l0, 0x0160)
							Name(n1l1, 0x0161)
							Name(n0l2, 0x0162)
							Name(n1l3, 0x0163)
							Name(l4, 0x0164)
							Scope (d7l0) {
								Name(n0l0, 0x0170)
								Name(n1l1, 0x0171)
								Name(n0l2, 0x0172)
								Name(n1l3, 0x0173)
								Name(l4, 0x0174)
								Scope (d8l0) {
									Name(n0l0, 0x0180)
									Name(n1l1, 0x0181)
									Name(n0l2, 0x0182)
									Name(n1l3, 0x0183)
									Name(l4, 0x0184)
									Scope (d9l0) {
										Name(n0l0, 0x0190)
										Name(n1l1, 0x0191)
										Name(n0l2, 0x0192)
										Name(n1l3, 0x0193)
										Name(l4, 0x0194)

	// Objects of different types on Nested Level 9

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

	// Device
	Device(DEV0) {Name(s000, "DEV0")}

	// Event
	Event(EVE0)

	// Method
	Method(MMM0) {Return ("ff0X")}

	// Mutex
	Mutex(MTX0, 0)

	// Operation Region
	OperationRegion(OPR0, SystemMemory, 0, 20)

	// Power Resource
	PowerResource(PWR0, 0, 0) {Name(s000, "PWR0")}

	// Processor
	Processor(CPU0, 0x0, 0xFFFFFFFF, 0x0) {Name(s000, "CPU0")}

	// Thermal Zone
	ThermalZone(TZN0) {Name(s000, "TZN0")}

	// Buffer Field
	Createfield(\BUFZ,   0, 69, BFL0)

										Device(dal0) {

	// Multiple Objects of different types on Nested Level 10

	// Integer
	Name(INT0, 0xfedcba9876543210)
	Name(INT1, 0xfedcba9876543211)
	Name(INT2, 0xfedcba9876543212)
	Name(INT3, 0xfedcba9876543213)
	Name(INT4, 0xfedcba9876543214)
	Name(INT5, 0xfedcba9876543215)
	Name(INT6, 0xfedcba9876543216)
	Name(INT7, 0xfedcba9876543217)
	Name(INT8, 0xfedcba9876543218)
	Name(INT9, 0xfedcba9876543219)

	// String
	Name(STR0, "source string0")
	Name(STR1, "source string1")
	Name(STR2, "source string2")
	Name(STR3, "source string3")
	Name(STR4, "source string4")
	Name(STR5, "source string5")
	Name(STR6, "source string6")
	Name(STR7, "source string7")
	Name(STR8, "source string8")

	// Buffer
	Name(BUF0, Buffer(9){9,8,7,6,5,4,3,2,1})
	Name(BUF1, Buffer(8){8,7,6,5,4,3,2,1})
	Name(BUF2, Buffer(7){7,6,5,4,3,2,1})
	Name(BUF3, Buffer(6){6,5,4,3,2,1})
	Name(BUF4, Buffer(5){5,4,3,2,1})
	Name(BUF5, Buffer(4){4,3,2,1})
	Name(BUF6, Buffer(3){3,2,1})
	Name(BUF7, Buffer(2){2,1})

	// Package
	Name(PAC0, Package(3) {
		0xfedcba987654321f,
		"test package0",
		Buffer(9){19,18,17,16,15,14,13,12,11},
	})
	Name(PAC1, Package(3) {
		0xfedcba987654321f,
		"test package1",
		Buffer(9){19,18,17,16,15,14,13,12,11},
	})
	Name(PAC2, Package(3) {
		0xfedcba987654321f,
		"test package2",
		Buffer(9){19,18,17,16,15,14,13,12,11},
	})

	// Field Unit
	Field(OPR0, ByteAcc, NoLock, Preserve) {
		FLU0, 69,
		FLU1, 68,
		FLU2, 67,
		FLU3, 66,
		FLU4, 65,
		FLU5, 64,
	}

	// Device
	Device(DEV0) {Name(s000, "DEV0")}
	Device(DEV1) {Name(s000, "DEV1")}
	Device(DEV2) {Name(s000, "DEV2")}
	Device(DEV3) {Name(s000, "DEV3")}

	// Event
	Event(EVE0)
	Event(EVE1)
	Event(EVE2)

	// Method
	Method(MMM0) {Return (0)}
	Method(MMM1) {Return (1)}
	Method(MMM2) {Return (2)}

	// Mutex
	Mutex(MTX0, 0)
	Mutex(MTX1, 1)
	Mutex(MTX2, 2)
	Mutex(MTX3, 3)
	Mutex(MTX4, 4)

	// Operation Region
	OperationRegion(OPR0, SystemMemory, 0, 50)
	OperationRegion(OPR1, SystemMemory, 200, 30)

	// Power Resource
	PowerResource(PWR0, 0, 0) {Name(s000, "PWR0")}
	PowerResource(PWR1, 0, 0) {Name(s000, "PWR1")}
	PowerResource(PWR2, 0, 0) {Name(s000, "PWR2")}

	// Processor
	Processor(CPU0, 0x0, 0xFFFFFFFF, 0x0) {Name(s000, "CPU0")}
	Processor(CPU1, 0x0, 0xFFFFFFFF, 0x0) {Name(s000, "CPU1")}
	Processor(CPU2, 0x0, 0xFFFFFFFF, 0x0) {Name(s000, "CPU2")}

	// Thermal Zone
	ThermalZone(TZN0) {Name(s000, "TZN0")}
	ThermalZone(TZN1) {Name(s000, "TZN1")}
	ThermalZone(TZN2) {Name(s000, "TZN2")}

	// Buffer Field
	Createfield(\BUFZ,   0, 69, BFL0)
	Createfield(\BUFZ,   7, 68, BFL1)
	Createfield(\BUFZ,   11, 67, BFL2)
	Createfield(\BUFZ,   13, 66, BFL3)
	Createfield(\BUFZ,   24, 65, BFL4)
	Createfield(\BUFZ,   29, 64, BFL5)
										}
	Include("nmsp0052.asl")
									}
								}
							}
						}
					}
				}
			}
		}
	}
	Scope (d1l2) {
		Name(n0l0, 0x0210)
		Name(n1l1, 0x0211)
		Name(n0l2, 0x0212)
		Name(n2l3, 0x0213)
		Name(l4, 0x0214)
	}

	Device(d1l3) {
		// Objects of different types on Level 1

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

		// Device
		Device(DEV0) {Name(s000, "DEV0")}

		// Event
		Event(EVE0)

		// Method
		Method(MMM0) {Return ("ff0X")}

		// Mutex
		Mutex(MTX0, 0)

		// Operation Region
		OperationRegion(OPR0, SystemMemory, 0, 20)

		// Power Resource
		PowerResource(PWR0, 0, 0) {Name(s000, "PWR0")}

		// Processor
		Processor(CPU0, 0x0, 0xFFFFFFFF, 0x0) {Name(s000, "CPU0")}

		// Thermal Zone
		ThermalZone(TZN0) {Name(s000, "TZN0")}

		// Buffer Field
		Createfield(\BUFZ,   0, 69, BFL0)
	}

	/*
	 * ASSERTION 0006:
	 */

	// Current Control State
	Name(ICCS, 0)

	// Control Values
	Name(I001, 1)
	Name(I101, 1)

	Method(M001)
	{
		Store(0x1, ICCS)
		M002()
		Add(ICCS, 0x1, ICCS)
	}

	Method(M002)
	{
		Add(ICCS, 0x10, ICCS)
		M003()
		Add(ICCS, 0x10, ICCS)
	}

	Method(M003)
	{
		Add(ICCS, 0x100, ICCS)
		Divide(ICCS, I001, , ICCS)
		if (I001) {
			Decrement(I001)
		}
		Add(ICCS, 0x100, ICCS)
	}

	Method(M101)
	{
		Method(M002)
		{
			Method(M003)
			{
				Add(ICCS, 0x10000, ICCS)
				Divide(ICCS, I101, , ICCS)
				if (I101) {
					Decrement(I101)
				}
				Add(ICCS, 0x10000, ICCS)
			}
			Add(ICCS, 0x1000, ICCS)
			M003()
			Add(ICCS, 0x1000, ICCS)
		}
		Store(0x1, ICCS)
		M002()
		Add(ICCS, 0x1, ICCS)
	}

	Method(M120)
	{
		Store("M120 executed", Debug)
		CopyObject("String120", \D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.INT0)
	}

	Event(EBLK)

	Method(BLK0)
	{
		// Device
		Device(DEVA) {Name(s000, "DEVA")}

		Store("Start BLK0", Debug)

		// Block on event
		Wait(EBLK, 0xFFFF)

		Store("Finish BLK0", Debug)
	}

	Method(BLK1)
	{
		Store("Start BLK1", Debug)
//		Store(\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0, Debug)
/*
		Scope (\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0)
		{
			// Device
			Device(DEVA) {Name(s000, "DEVA")}
		}
*/
		Device(\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEVA)
			{Name(s000, "DEVA")}

		Store("Declare DEVA", Debug)

		// Block on event
		Wait(EBLK, 0xFFFF)

		Store("Finish BLK0", Debug)
	}

	Method(REL0)
	{
		// Release threads blocked on event
		Signal (EBLK)

		Store("REL0: EBLK signaled", Debug)
	}

	Method(MAIN)
	{
		Method(m000)
		{
			Name(i000, 0x574)

			Return (i000)
		}

		Store(m000(), Debug)
	}
}
