/*
 * Some or all of this work - Copyright (c) 2006 - 2014, Intel Corp.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 * Neither the name of Intel Corporation nor the names of its contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 * Check Result Object proccessing on Increment/Decrement
 */

Name(z125, 125)

// Test verifying Result Object processing on storing of the resilt
// into different kinds of Target Objects by means of the specified
// either Increment or Decrement operator
// m692(<op (Increment/Decrement)>, <exc. conditions>)
Method(m692, 2, Serialized)
{
	Name(ts, "m692")

/*
   - choose a type of the destination operand Object (Dst0):
     = Uninitialized
     = Integer
     = String
     = Buffer
     = Package
	 ...

   - choose kind of the operand Object:
     = Named Object
     = Method ArgX Object
     = Method LocalX Object

   - choose a value to initialize Dst0,

   - choose a benchmark value according to the initialized value - Bval

   - check that the Dst0 is properly initialized

   - perform storing expression:
       Increment(Expr(Dst0))
       Decrement(Expr(Dst0))

   - check that the benchmark value Bval is equal to the updated
     destination operand Object Dst0

*/
	// Object-initializers are used with Source~Target

	// Integer
	Name(INT0, 0xfedcba9876543210)

	// String
	Name(STR0, "76543210")
	Name(STR1, "76543210")

	// Buffer
	Name(BUF0, Buffer(9){9,8,7,6,5,4,3,2,1})
	Name(BUF1, Buffer(9){9,8,7,6,5,4,3,2,1})

	// Initializer of Fields
	Name(BUF2, Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,0x15})

	// Base of Buffer Fields
	Name(BUFZ, Buffer(20){})

	// Package
	Name(PAC0, Package(3) {
		0xfedcba987654321f,
		"test package",
		Buffer(9){19,18,17,16,15,14,13,12,11},
	})

	if (y361) {
		// Field Unit
		Field(OPR0, ByteAcc, NoLock, Preserve) {
			FLU0, 69,
			FLU1, 69,
		}
	}

	// Device
	Device(DEV0) {Name(s000, "DEV0")}

	// Event
	Event(EVE0)

	// Method
	Name(MMM0, 0)	// Method as Source Object
	Method(MMMX) {Return ("abcd")}

	// Mutex
	Mutex(MTX0, 0)

	if (y361) {
		// Operation Region
		OperationRegion(OPR0, SystemMemory, 0, 20)
	}

	// Power Resource
	PowerResource(PWR0, 0, 0) {Name(s000, "PWR0")}

	// Processor
	Processor(CPU0, 0x0, 0xFFFFFFFF, 0x0) {Name(s000, "CPU0")}

	// Thermal Zone
	ThermalZone(TZN0) {Name(s000, "TZN0")}

	// Buffer Field
	Createfield(BUFZ,   0, 69, BFL0)
	Createfield(BUFZ,   0, 69, BFL1)

	// Data to gather statistics

	Name(STCS, 0)

	Name(INDM, 255)

	Name(PAC2, Package(1) {})
	Name(IND2, 0)

	Name(PAC3, Package(1) {})
	Name(IND3, 0)

	Name(PAC4, Package(2) {
		"Increment",
		"Decrement",
	})

	Name(terr, "-test error")

	// Update statistics
	// m000(<type>, <shift>, <low>, <up>)
	Method(m000, 4)
	{
		if (LEqual(arg0, 2)) {
			if (LLess(IND2, INDM)) {
				Store(Add(Multiply(arg3, arg1), arg2), Index(PAC2, IND2))
				Increment(IND2)
			}
		} elseif (LEqual(arg0, 3)) {
			if (LLess(IND3, INDM)) {
				Store(Add(Multiply(arg3, arg1), arg2), Index(PAC3, IND3))
				Increment(IND3)
			}
		}
	}

	// Initialize statistics
	Method(m001)
	{
		if (STCS) {
			Store(Package(255) {}, PAC2)
			Store(0, IND2)
			Store(Package(255) {}, PAC3)
			Store(0, IND3)
		}
	}

	// Output statistics
	Method(m002, 1, Serialized)
	{
		Name(lpN0, 0)
		Name(lpC0, 0)

		if (STCS) {
			Store(arg0, Debug)

			if (IND2) {
				Store("Run-time exceptions:", Debug)
				Store(IND2, Debug)
				Store("Types:", Debug)

				Store(IND2, lpN0)
				Store(0, lpC0)

				While (lpN0) {
					Store(Derefof(Index(PAC2, lpC0)), Debug)
					Decrement(lpN0)
					Increment(lpC0)
				}
			}

			if (IND3) {
				Store("Type mismatch:", Debug)
				Store(IND3, Debug)

				Store(IND3, lpN0)
				Store(0, lpC0)

				While (lpN0) {
					Store(Derefof(Index(PAC3, lpC0)), Debug)
					Decrement(lpN0)
					Increment(lpC0)
				}
			}
		}
	}

	// Prepare Source of specified type
	Method(m004, 3, Serialized)
	{
		Switch(ToInteger(arg1)) {
			Case(0) {
			}
			Case(1) {
				CopyObject(INT0, arg2)
			}
			Case(2) {
				CopyObject(STR0, arg2)
			}
			Case(3) {
				CopyObject(BUF0, arg2)
			}
			Case(4) {
				CopyObject(PAC0, arg2)
			}
			Case(5) {
				Store(BUF2, FLU0)
			}
			Case(6) {
				CopyObject(DEV0, arg2)
			}
			Case(7) {
				CopyObject(EVE0, arg2)
			}
			Case(8) {
				CopyObject(Derefof(Refof(MMMX)), MMM0)
				CopyObject(Derefof(Refof(MMM0)), arg2)
			}
			Case(9) {
				CopyObject(MTX0, arg2)
			}
			Case(10) {
				CopyObject(OPR0, arg2)
			}
			Case(11) {
				CopyObject(PWR0, arg2)
			}
			Case(12) {
				CopyObject(CPU0, arg2)
			}
			Case(13) {
				CopyObject(TZN0, arg2)
			}
			Case(14) {
				Store(BUF2, BFL0)
			}
			Default {
				// Unexpected Source Type
				err(Concatenate(arg0, terr), z125, 1, 0, 0, arg1, 0)
				Return (1)
			}
		}
		if (CH03(arg0, z125, 2, arg1, 0)) {
			// Exception during preparing of Source Object
			Return (1)
		}

		Store(ObjectType(arg2), Local0)
		if (LNotEqual(Local0, arg1)) {
			// ObjectType of Source can not be set up
			err(arg0, z125, 3, 0, 0, Local0, arg1)
			Return (1)
		}

		Return (0)
	}

	// Check Target Object to have the expected type and value
	// m006(<msg>, <ref to target>, <target type>, <source type>,
	//      <op>, <target save type>)
	Method(m006, 6, Serialized)
	{
		Name(MMM2, 0) // The auxiliary Object to invoke Method

		Store(ObjectType(arg1), Local2)

		// Target must save type
		if (LNotEqual(Local2, arg2)) {
			// Types mismatch Target/Target on storing
			// Target (Result) type should keep the original type
			if (LOr(LEqual(arg3, c00a), LEqual(arg3, c00b))) {
				if (X195) {
					err(arg0, z125, 4, 0, 0, Local2, arg2)
				}
			} else {
				err(arg0, z125, 4, 0, 0, Local2, arg2)
			}
			if (STCS) {m000(3, 0x100, arg2, Local2)}
			Return (1)
		}

			Switch(ToInteger(arg2)) {
				Case(1) {
					Switch(ToInteger(arg3)) {
						Case(1) {
							if (LEqual(arg4, 0)) {
								// Increment
								Add(INT0, 1, Local0)
							} elseif (LEqual(arg4, 1)) {
								Subtract(INT0, 1, Local0)
							} else {
								Store(INT0, Local0)
							}
							if (LNotEqual(Derefof(arg1), Local0)) {
								err(arg0, z125, 5, 0, 0, Derefof(arg1), Local0)
								Return (1)
							}
						}
						Case(2) {
							if (LEqual(arg4, 0)) {
								// Increment
								Add(STR0, 1, Local0)
							} elseif (LEqual(arg4, 1)) {
								Subtract(STR0, 1, Local0)
							} else {
								Store(STR0, Local0)
							}
							if (LNotEqual(Derefof(arg1), Local0)) {
								err(arg0, z125, 6, 0, 0, Derefof(arg1), Local0)
								Return (1)
							}
						}
						Case(3) {
							if (LEqual(arg4, 0)) {
								// Increment
								Add(BUF0, 1, Local0)
							} elseif (LEqual(arg4, 1)) {
								Subtract(BUF0, 1, Local0)
							} else {
								Store(BUF0, Local0)
							}
							if (LNotEqual(Derefof(arg1), Local0)) {
								err(arg0, z125, 7, 0, 0, Derefof(arg1), Local0)
								Return (1)
							}
						}
						Default{
							err(Concatenate(arg0, terr), z125, 8, 0, 0, arg1, arg3)
							Return (1)
						}
					}
				}
				Case(2) {
					Switch(ToInteger(arg3)) {
						Case(2) {
							if (LEqual(arg4, 0)) {
								// Increment
								Add(STR0, 1, STR1)
							} elseif (LEqual(arg4, 1)) {
								Subtract(STR0, 1, STR1)
							} else {
								Store(STR0, STR1)
							}
							if (LNotEqual(Derefof(arg1), STR1)) {
								err(arg0, z125, 9, 0, 0, Derefof(arg1), STR1)
								Return (1)
							}
						}
						Default{
							err(Concatenate(arg0, terr), z125, 10, 0, 0, arg1, arg3)
							Return (1)
						}
					}
				}
				Case(3) {
					Switch(ToInteger(arg3)) {
						Case(3) {
							if (LEqual(arg4, 0)) {
								// Increment
								Add(BUF0, 1, BUF1)
							} elseif (LEqual(arg4, 1)) {
								Subtract(BUF0, 1, BUF1)
							} else {
								Store(BUF0, BUF1)
							}
							if (LNotEqual(Derefof(arg1), BUF1)) {
								err(arg0, z125, 11, 0, 0, Derefof(arg1), BUF1)
								Return (1)
							}
						}
						Default{
							err(Concatenate(arg0, terr), z125, 12, 0, 0, arg1, arg3)
							Return (1)
						}
					}
				}
				Case(5) {
					Switch(ToInteger(arg3)) {
						Case(5) {
							if (LEqual(arg4, 0)) {
								// Increment
								Add(FLU0, 1, FLU1)
							} elseif (LEqual(arg4, 1)) {
								Subtract(FLU0, 1, FLU1)
							} else {
								Store(FLU0, FLU1)
							}
							if (LNotEqual(Derefof(arg1), FLU1)) {
								err(arg0, z125, 13, 0, 0, Derefof(arg1), FLU1)
								Return (1)
							}
						}
						Default{
							err(Concatenate(arg0, terr), z125, 14, 0, 0, arg1, arg3)
							Return (1)
						}
					}
				}
				Case(14) {
					Switch(ToInteger(arg3)) {
						Case(14) {
							if (LEqual(arg4, 0)) {
								// Increment
								Add(BFL0, 1, BFL1)
							} elseif (LEqual(arg4, 1)) {
								Subtract(BFL0, 1, BFL1)
							} else {
								Store(BFL0, BFL1)
							}
							if (LNotEqual(Derefof(arg1), BFL1)) {
								err(arg0, z125, 15, 0, 0, Derefof(arg1), BFL1)
								Return (1)
							}
						}
						Default{
							err(Concatenate(arg0, terr), z125, 16, 0, 0, arg1, arg3)
							Return (1)
						}
					}
				}
				Default{
					err(Concatenate(arg0, terr), z125, 17, 0, 0, arg1, arg3)
					Return (1)
				}
			}
		Return (0)
	}

	// Check processing of an Source Named Object of the specified type
	// as an immediate operand in Increment/Decrement operators
	// m008(<msg>, <aux>, <target type>, <source type>,
	//      <op>, <exc. condition>)
	Method(m008, 6, Serialized)
	{
		// Source Named Object
		Name(SRC0, 0)

		Concatenate(arg0, "-", arg0)
		Concatenate(arg0, Concatenate(Mid(arg4,0,2), Concatenate(Mid(arg2,0,2), Mid(arg3,0,2))), arg0)
		if (STCS) {Store(arg0, Debug)}

		// Target save type of Increment/Decrement operators is 0
		// (Target should take a type of Integer)
		Store(0, Local0)

		if (LEqual(arg3, 5)) {				// Field Unit Source/Target
			Store(Refof(FLU0), Local3)
		} elseif (LEqual(arg3, 14)) {		// Buffer Field Source/Target
			Store(Refof(BFL0), Local3)
		} else {
			Store(Refof(SRC0), Local3)
		}

		// Prepare Source of specified type
		if (m004(Concatenate(arg0, "-m004"), arg3, Local3)) {
			// Source Object can not be prepared
			err(Concatenate(arg0, terr), z125, 18, 0, 0, arg3, 0)
			Return (1)
		}

		// Use a Source Object immediately in the Operator
		if (LEqual(arg3, 5)) {				// Field Unit Source/Target
			if (LEqual(arg4, 0)) {				// Increment
				Increment(FLU0)
			} elseif (LEqual(arg4, 1)) {		// Decrement
				Decrement(FLU0)
			} else {
				// Unexpected Kind of Op (0 - Increment, 1 - Decrement)
				err(Concatenate(arg0, terr), z125, 19, 0, 0, arg4, 0)
				Return (1)
			}
		} elseif (LEqual(arg3, 14)) {		// Buffer Source/Field Target
			if (LEqual(arg4, 0)) {				// Increment
				Increment(BFL0)
			} elseif (LEqual(arg4, 1)) {		// Decrement
				Decrement(BFL0)
			} else {
				// Unexpected Kind of Op (0 - Increment, 1 - Decrement)
				err(Concatenate(arg0, terr), z125, 20, 0, 0, arg4, 0)
				Return (1)
			}
		} elseif (LEqual(arg4, 0)) {		// Increment
				Increment(SRC0)
		} elseif (LEqual(arg4, 1)) {		// Decrement
				Decrement(SRC0)
		} else {
			// Unexpected Kind of Op (0 - Increment, 1 - Decrement)
			err(Concatenate(arg0, terr), z125, 21, 0, 0, arg4, 0)
			Return (1)
		}

		if (arg5) {
			// Exception is expected
			if (LNot(CH06(arg0, 22, 0xff))) {
				if (STCS) {m000(2, 0x100, arg2, arg3)}
			}
		} elseif (CH03(arg0, z125, 23, arg3, arg2)) {
			// Processing caused unexpected exception
			if (STCS) {m000(2, 0x100, arg2, arg3)}
		} else {
			// Check Target Object to have the expected type and value
			m006(Concatenate(arg0, "-m006"), Local3, arg2, arg3, arg4, Local0)
		}
		Return (0)
	}

	// Check processing of an Source LocalX Object of the specified type
	// as an immediate operand in Increment/Decrement operators
	// m009(<msg>, <aux>, <target type>, <source type>,
	//      <op>, <exc. condition>)
	Method(m009, 6)
	{
		// Source LocalX Object: Local1

		Concatenate(arg0, "-", arg0)
		Concatenate(arg0, Concatenate(Mid(arg4,0,2), Concatenate(Mid(arg2,0,2), Mid(arg3,0,2))), arg0)
		if (STCS) {Store(arg0, Debug)}

		// Target save type of Increment/Decrement operators is 0
		// (Target should take a type of Integer)
		Store(0, Local0)

		if (m004(Concatenate(arg0, "-m004"), arg3, Refof(Local1))) {
			// Source Object can not be prepared
			err(Concatenate(arg0, terr), z125, 24, 0, 0, arg3, 0)
			Return (1)
		}

		if (LEqual(arg4, 0)) {		// Increment
			Increment(Local1)
		} elseif (LEqual(arg4, 1)) {	// Decrement
			Decrement(Local1)
		} else {
			// Unexpected Kind of Op (0 - Increment, 1 - Decrement)
			err(Concatenate(arg0, terr), z125, 25, 0, 0, arg4, 0)
			Return (1)
		}

		if (arg5) {
			if (LAnd(SLCK, LAnd(LEqual(ToInteger(arg3), 0),
					    LEqual(ToInteger(arg2), 1)))) {
				// In slack mode, [Uninitialized] object
				// will be converted to Integer 0, thus no
				// exception caused by implicit source
				// conversion.
				if (CH03(arg0, z125, 26, arg3, arg2)) {
					if (STCS) {m000(2, 0x100, arg2, arg3)}
				}
			} else {
				// Exception is expected
				if (LNot(CH06(arg0, 26, 0xff))) {
					if (STCS) {m000(2, 0x100, arg2, arg3)}
				}
			}
		} elseif (CH03(arg0, z125, 27, arg3, arg2)) {
			// Processing caused unexpected exception
			if (STCS) {m000(2, 0x100, arg2, arg3)}
		} else {
			// Check Target Object to have the expected type and value
			m006(Concatenate(arg0, "-m006"), Refof(Local1), arg2, arg3, arg4, Local0)
		}
		Return (0)
	}

	// Check processing of an Source LocalX Object of the specified type
	// as an immediate argument of the Method in which it is used
	// as an immediate operand in Increment/Decrement operators
	// m00a(<msg>, <aux>, <target type>, <source type>,
	//      <op>, <exc. condition>)
	Method(m00a, 6)
	{
		// Source LocalX Object: Local1

		Method(m100, 1)
		{
			Increment(arg0)
			Return (arg0)
		}

		Method(m101, 1)
		{
			Decrement(arg0)
			Return (arg0)
		}

		Concatenate(arg0, "-", arg0)
		Concatenate(arg0, Concatenate(Mid(arg4,0,2), Concatenate(Mid(arg2,0,2), Mid(arg3,0,2))), arg0)
		if (STCS) {Store(arg0, Debug)}

		// Target save type of Increment/Decrement operators is 0
		// (Target should take a type of Integer)
		Store(0, Local0)

		if (m004(Concatenate(arg0, "-m004"), arg3, Refof(Local1))) {
			// Source Object can not be prepared
			err(Concatenate(arg0, terr), z125, 28, 0, 0, arg3, 0)
			Return (1)
		}

		if (LEqual(arg4, 0)) {		// Increment
			Store(m100(Local1), Local2)
		} elseif (LEqual(arg4, 1)) {	// Decrement
			Store(m101(Local1), Local2)
		} else {
			// Unexpected Kind of Op (0 - Increment, 1 - Decrement)
			err(Concatenate(arg0, terr), z125, 29, 0, 0, arg4, 0)
			Return (1)
		}

		if (arg5) {
			if (LAnd(SLCK, LAnd(LEqual(ToInteger(arg3), 0),
					    LEqual(ToInteger(arg2), 1)))) {
				// In slack mode, [Uninitialized] object
				// will be converted to Integer 0, thus no
				// exception caused by implicit source
				// conversion.
				if (CH03(arg0, z125, 30, arg3, arg2)) {
					if (STCS) {m000(2, 0x100, arg2, arg3)}
				}
			} else {
				// Exception is expected
				if (LNot(CH06(arg0, 30, 0xff))) {
					if (STCS) {m000(2, 0x100, arg2, arg3)}
				}
			}
		} elseif (CH03(arg0, z125, 31, arg3, arg2)) {
			// Processing caused unexpected exception
			if (STCS) {m000(2, 0x100, arg2, arg3)}
		} else {
			// Check Target Object to have the expected type and value
			m006(Concatenate(arg0, "-m006"), Refof(Local2), arg2, arg3, arg4, Local0)
			m006(Concatenate(arg0, "-m006"), Refof(Local1), arg2, arg3, 2, Local0)
		}
		Return (0)
	}

	// Check processing of an Source Named Object of the specified type
	// passed by a reference as an argument of the Method in which it is used
	// as an immediate operand in Increment/Decrement operators
	// m00b(<msg>, <aux>, <target type>, <source type>,
	//      <op>, <exc. condition>)
	Method(m00b, 6, Serialized)
	{
		// Source Named Object
		Name(SRC0, 0)

		Method(m100, 1)
		{
			Increment(arg0)
		}

		Method(m101, 1)
		{
			Decrement(arg0)
		}

		Concatenate(arg0, "-", arg0)
		Concatenate(arg0, Concatenate(Mid(arg4,0,2), Concatenate(Mid(arg2,0,2), Mid(arg3,0,2))), arg0)
		if (STCS) {Store(arg0, Debug)}

		// Target save type of Increment/Decrement operators is 0
		// (Target should take a type of Integer)
		Store(0, Local0)

		if (LEqual(arg3, 5)) {				// Field Unit Source/Target
			Store(Refof(FLU0), Local3)
		} elseif (LEqual(arg3, 14)) {		// Buffer Field Source/Target
			Store(Refof(BFL0), Local3)
		} else {
			Store(Refof(SRC0), Local3)
		}

		// Prepare Source of specified type
		if (m004(Concatenate(arg0, "-m004"), arg3, Local3)) {
			// Source Object can not be prepared
			err(Concatenate(arg0, terr), z125, 32, 0, 0, arg3, 0)
			Return (1)
		}

		// Use a reference to Source Object in the Operator
		if (LEqual(arg4, 0)) {			// Increment
				m100(Local3)
		} elseif (LEqual(arg4, 1)) {	// Decrement
				m101(Local3)
		} else {
			// Unexpected Kind of Op (0 - Increment, 1 - Decrement)
			err(Concatenate(arg0, terr), z125, 33, 0, 0, arg4, 0)
			Return (1)
		}

		if (arg5) {
			// Exception is expected
			if (LNot(CH06(arg0, 34, 0xff))) {
				if (STCS) {m000(2, 0x100, arg2, arg3)}
			}
		} elseif (CH03(arg0, z125, 35, arg3, arg2)) {
			// Processing caused unexpected exception
			if (STCS) {m000(2, 0x100, arg2, arg3)}
		} else {
			// Check Target Object to have the expected type and value
			m006(Concatenate(arg0, "-m006"), Local3, arg2, arg3, arg4, Local0)
		}
		Return (0)
	}

	Name(lpC0, 1)

	Name(lpN1, 17)
	Name(lpC1, 0)

	if (LEqual(arg0, 0)) {
		Concatenate(ts, "-Inc", ts)
	} else {
		Concatenate(ts, "-Dec", ts)
	}

	if (arg1) {
		Concatenate(ts, "-Exc", ts)
	}

	SRMT(ts)

	// Initialize statistics
	m001()

	if (LGreater(arg0, 1)) {
		// Unexpected Kind of Op (0 - Increment, 1 - Decrement)
		err(Concatenate(ts, terr), z125, 36, 0, 0, arg0, 0)
		Return (1)
	}

	// Enumerate Result types
	While (lpN1) {

		if (LAnd(Derefof(Index(b677, lpC1)),
				Derefof(Index(b671, lpC1)))) {
			// Not invalid type of the result Object

			// Determine Target type
			Store(lpC1, lpC0)

			if (LNot(y501)) {
				// The question: should Increment/Decrement save the Target type?
				if (LNot(Derefof(Index(b678, lpC0)))) {
					// Not fixed type, Target type is Integer
					Store(1, lpC0)
				}
			}

			if (arg1) {
				// Skip cases without exceptional conditions
				if (Derefof(Index(b67b, lpC1))) {
					Decrement(lpN1)
					Increment(lpC1)
					Continue
				}
			} else {
				// Skip cases with exceptional conditions
				if (LNot(Derefof(Index(b67b, lpC1)))) {
					Decrement(lpN1)
					Increment(lpC1)
					Continue
				}
			}
			// Named Source
			if (LNotEqual(lpC1, c008)) {
				// Named can not be set up to Uninitialized
				m008(Concatenate(ts, "-m008"), 0, lpC0, lpC1, arg0, arg1)
			}

			// LocalX Source
			if (LNot(Derefof(Index(b678, lpC1)))) {
				// LocalX can not be set up to Fixed types
				m009(Concatenate(ts, "-m009"), 0, lpC0, lpC1, arg0, arg1)
				m00a(Concatenate(ts, "-m00a"), 0, lpC0, lpC1, arg0, arg1)
			}

			// Reference to Named
			if (y367) {
				if (LNotEqual(lpC1, c008)) {
					// Named can not be set up to Uninitialized
					m00b(Concatenate(ts, "-m00b"), 0, lpC0, lpC1, arg0, arg1)
				}
			}
		}
		Decrement(lpN1)
		Increment(lpC1)
	}

	// Output statistics
	m002(Concatenate("Result Object proccessing with ", Derefof(Index(PAC4, arg0))))

	Return (0)
}

// Run-method
Method(RES2)
{
	Store("TEST: RES2, Result Object proccessing on Increment/Decrement", Debug)

	// Increment
	m692(0, 0)

	// Decrement
	m692(1, 0)
}

