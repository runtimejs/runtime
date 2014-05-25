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
 * Check Result Object proccessing on optional storing
 * in the explicit conversion operators
 */

Name(z126, 126)

// m693(<store op>, <exc. conditions>,
//      <Target scale>, <Result scale>, <kind of Source-Target pair>)
Method(m693, 5, Serialized)
{
	Name(ts, "m693")

/*
   - choose a type of the Object to store into:
     = Uninitialized
     = Integer
     = String
     = Buffer
     = Package
	 ...

   - choose a value of the Object to store into

   - choose kind of the Object to store into:
     = Named Object
     = Method LocalX Object

   - determine the destination Object to store into: it should exist
     and be initialized with the chosen value (Dst0)

   - choose a way to obtain some result object (Expr ~ Result Object
     returned by any Explicit conversion Operator (Op)):
	 = ToInteger
	 = ToBCD
	 = FromBCD
	 = ToString
	 = ToHexString
	 = ToDecimalString
	 = ToBuffer

   - choose storing expression:
     = Store(Op(Src0, ...), Dst0)
     = CopyObject(Op(Src0, ...), Dst0)
     = Op(Src0, ..., Dst0)

   - the type of the result Object depend on the Operator

   - choose specific source objects to obtain the result Object of
     the specified type: it should exist and be initialized (Src0, ...)

   - choose a benchmark value according to a storing expression,
     chosen source objects, the value of the target object and
	 relevant result conversion rule (if any) - Bval

   - check that the destination Object Dst0 is properly initialized

   - perform storing expression:
       Store(Expr(Src0, ...), Dst0)
       CopyObject(Expr(Src0, ...), Dst0)
       Op(Expr(Src0, ...), Dst0)

   - check that the benchmark value Bval is equal to the updated
     destination Object Dst0:

   - check that the source objects are not updated:

   - update the destination Object again and check that the source
     objects are not updated
*/

	// Object-initializers are used either with Source or Target
	// (names ended by 0 and 1 respectively)

	// Integer
	Name(INT0, 0xfedcba9876543210)
	Name(INT1, 0xfedcba9876543211)

	// String
	Name(STR0, "source string")
	Name(STR1, "target string")

	// Buffer
	Name(BUF0, Buffer(9){9,8,7,6,5,4,3,2,1})
	Name(BUF1, Buffer(17){0xc3})

	// Base of Buffer Fields
	Name(BUFZ, Buffer(20){})

	Name(PAC1, Package(1) {"target package"})

	// Device
	Device(DEV1) {Name(s000, "DEV1")}

	// Event
	Event(EVE1)

	// Method
	Name(MM01, "ff1Y")	// Value, returned from MMMY
	Name(MMM1, 0)	// Method as Target Object
	Method(MMMY) {Return (MM01)}

	// Mutex
	Mutex(MTX1, 0)

	if (y361) {
		// Operation Region
		OperationRegion(OPR0, SystemMemory, 0, 20)
		OperationRegion(OPR1, SystemMemory, 0, 20)
	}

	// Power Resource
	PowerResource(PWR1, 0, 0) {Name(s000, "PWR1")}

	// Processor
	Processor(CPU1, 0x0, 0xFFFFFFFF, 0x0) {Name(s000, "CPU1")}

	// Thermal Zone
	ThermalZone(TZN1) {Name(s000, "TZN1")}

	// Reference
	Name(REF0, Package(1){})
	Name(REF1, Package(1){})

	// Data to gather statistics

	Name(STCS, 0)

	Name(INDM, 255)

	Name(PAC2, Package(1) {})
	Name(IND2, 0)

	Name(PAC3, Package(1) {})
	Name(IND3, 0)

	Name(PAC4, Package(3) {
		"Store",
		"Copyobject",
		"Optional",
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

	// Prepare Target of specified type
	Method(m003, 4, Serialized)
	{
		Switch(ToInteger(arg1)) {
			Case(0) {	// Only check
			}
			Case(1) {
				CopyObject(Derefof(arg3), INT1)
				CopyObject(INT1, arg2)
			}
			Case(2) {
				CopyObject(Derefof(arg3), STR1)
				CopyObject(STR1, arg2)
			}
			Case(3) {
				CopyObject(Derefof(arg3), BUF1)
				Store(Sizeof(BUF1), Local0)
				if (LNotEqual(Local0, 17)) {
					err(Concatenate(arg0, terr), z126, 1, 0, 0, Local0, 17)
					Return (1)
				}
				CopyObject(BUF1, arg2)
			}
			Case(4) {
				CopyObject(Derefof(arg3), PAC1)
				CopyObject(PAC1, arg2)
			}
			Case(5) {	// Check only
			}
			Case(6) {
				CopyObject(DEV1, arg2)
			}
			Case(7) {
				CopyObject(EVE1, arg2)
			}
			Case(8) {
				CopyObject(Derefof(Refof(MMMY)), MMM1)
				CopyObject(Derefof(Refof(MMM1)), arg2)
			}
			Case(9) {
				CopyObject(MTX1, arg2)
			}
			Case(10) {
				CopyObject(OPR1, arg2)
			}
			Case(11) {
				CopyObject(PWR1, arg2)
			}
			Case(12) {
				CopyObject(CPU1, arg2)
			}
			Case(13) {
				CopyObject(TZN1, arg2)
			}
			Case(14) {	// Check only
			}
			Case(17) {
				CopyObject(Refof(REF0), REF1)
				if (y522) {
					CopyObject(REF1, arg2)
				} else {
					CopyObject(DeRefof(REF1), arg2)
				}
			}
			Default {
				// Unexpected Target Type
				err(Concatenate(arg0, terr), z126, 2, 0, 0, arg1, 0)
				Return (1)
			}
		}
		if (CH03(arg0, z126, 3, arg1, 0)) {
			//Exception during preparing of Target Object
			Return (1)
		}

		Store(ObjectType(arg2), Local0)
		if (LNotEqual(Local0, arg1)) {
			// ObjectType of Target can not be set up
			err(arg0, z126, 4, 0, 0, Local0, arg1)
			Return (1)
		}

		Return (0)
	}

	// Prepare Source of specified type
	Method(m004, 4, Serialized)
	{
		Switch(ToInteger(arg1)) {
			Case(1) {
				CopyObject(Derefof(arg3), INT0)
				CopyObject(INT0, arg2)
			}
			Case(2) {
				CopyObject(Derefof(arg3), STR0)
				CopyObject(STR0, arg2)
			}
			Case(3) {
				if (y136) {
					CopyObject(Derefof(arg3), BUF0)
				} else {
					m687(Derefof(arg3), Refof(BUF0))
				}
				CopyObject(BUF0, arg2)
			}
			Default {
				// Unexpected Source Type
				err(Concatenate(arg0, terr), z126, 5, 0, 0, arg1, 0)
				Return (1)
			}
		}
		if (CH03(arg0, z126, 6, arg1, 0)) {
			// Exception during preparing of Source Object
			Return (1)
		}

		Store(ObjectType(arg2), Local0)
		if (LNotEqual(Local0, arg1)) {
			// ObjectType of Source can not be set up
			err(arg0, z126, 7, 0, 0, Local0, arg1)
			Return (1)
		}

		Return (0)
	}

	// Check Source Object type is not corrupted after storing,
	// for the computational data types verify its value against
	// the Object-initializer value
	Method(m005, 4, Serialized)
	{
		Store(ObjectType(arg2), Local0)
		if (LNotEqual(Local0, arg1)) {
			// ObjectType of Source object is corrupted
			err(arg0, z126, 8, 0, 0, Local0, arg1)
			Return (1)
		}

		Switch(ToInteger(arg1)) {
			Case(1) {
				Store(ObjectType(INT0), Local0)
			}
			Case(2) {
				Store(ObjectType(STR0), Local0)
			}
			Case(3) {
				Store(ObjectType(BUF0), Local0)
			}
			Default {
				// Unexpected Result Type
				err(arg0, z126, 9, 0, 0, arg1, 0)
				Return (1)
			}
		}

		if (LNotEqual(Local0, arg1)) {
			// Mismatch of Source Type against specified one
			err(arg0, z126, 10, 0, 0, Local0, arg1)
			if (STCS) {m000(3, 0x1000000, Local0, arg0)}
			Return (1)
		} else {
			// Check equality of the Source value to the Object-initializer one
			Switch(ToInteger(arg1)) {
				Case(1) {
					if (LNotEqual(INT0, Derefof(arg3))) {
						err(arg0, z126, 11, 0, 0, INT0, Derefof(arg3))
						Return (1)
					}
					if (LNotEqual(Derefof(arg2), INT0)) {
						err(arg0, z126, 12, 0, 0, Derefof(arg2), INT0)
						Return (1)
					}
				}
				Case(2) {
					if (LNotEqual(STR0, Derefof(arg3))) {
						err(arg0, z126, 13, 0, 0, STR0, Derefof(arg3))
						Return (1)
					}
					if (LNotEqual(Derefof(arg2), STR0)) {
						err(arg0, z126, 14, 0, 0, Derefof(arg2), STR0)
						Return (1)
					}
				}
				Case(3) {
					if (LNotEqual(BUF0, Derefof(arg3))) {
						err(arg0, z126, 15, 0, 0, BUF0, Derefof(arg3))
						Return (1)
					}
					if (LNotEqual(Derefof(arg2), BUF0)) {
						err(arg0, z126, 16, 0, 0, Derefof(arg2), BUF0)
						Return (1)
					}
				}
			}
		}
		Return (0)
	}

	// Check Target Object to have the expected type and value
	// m006(<msg>, <ref to target>, <target type>, <source type>,
	//      <op>, <target save type>, <test data package>)
	Method(m006, 7, Serialized)
	{
		Name(MMM2, 0) // The auxiliary Object to invoke Method

		Store(ObjectType(arg1), Local2)

		if (LNotEqual(Local2, arg2)) {
			if (STCS) {m000(3, 0x10000, arg2, Local2)}
		}

		if (m686(arg5, arg2, arg3)) {
			// Target must save type
			if (LNotEqual(Local2, arg2)) {
				// Types mismatch Target/Target on storing
				if (LEqual(arg2, c016)) {
					if (X170) {
						err(arg0, z126, 17, 0, 0, Local2, arg2)
					}
				} else {
					err(arg0, z126, 17, 0, 0, Local2, arg2)
				}
				if (STCS) {m000(3, 0x100, arg2, Local2)}
				Return (1)
			}
		} else {
			// Target must accept type of the Result Object

			if (LNotEqual(Local2, arg3)) {
				if (LNotEqual(m684(arg3), 1)) {
					// Types mismatch Result/Target on storing
					err(arg0, z126, 18, 0, 0, Local2, arg3)
					Return (1)
				} elseif (LNotEqual(Local2, 3)) {
					// Types mismatch Result/Target on storing
					// Test fixed type Objects are converted to Buffer
					err(arg0, z126, 19, 0, 0, Local2, 3)
					Return (1)
				}
				if (STCS) {m000(3, 0x100, arg3, Local2)}
			}
		}

		// Retrieve the benchmark value
		if (m686(arg5, arg2, arg3)) {
			// Save type of Target

			// Retrieve the benchmark value
			Store(Derefof(Index(Derefof(Index(arg6, 4)), arg2)), Local7)
		} else {
			Store(Derefof(Index(arg6, 3)), Local7)
		}

		if (LNotEqual(Derefof(arg1), Local7)) {
			if (LAnd(LEqual(arg2, c00b), LEqual(arg3, c00b))) {
				if (X194) {
					err(arg0, z126, 20, 0, 0, Derefof(arg1), Local7)
				}
			} else {
				err(arg0, z126, 20, 0, 0, Derefof(arg1), Local7)
			}
			Return (1)
		}

		Return (0)
	}

	// Check processing of an Source Named Object of the specified type
	// on immediate storing to a Target Named Object of the specified type
	// m008(<msg>, <aux>, <target type>, <source type>,
	//      <op>, <exc. condition>, <test data package>)
	Method(m008, 7, Serialized)
	{
		// Source Named Object
		Name(SRC0, 0)
		// Target Named Object
		Name(DST0, 0)

		// Retrieve index of the verified Explicit conversion Operator
		Store(Derefof(Index(arg6, 0)), Local6)

		Concatenate(arg0, "-", arg0)
		Concatenate(arg0, Concatenate(Mid(Local6,0,2), Concatenate(Mid(arg4,0,2), Concatenate(Mid(arg2,0,2), Mid(arg3,0,2)))), arg0)
		if (STCS) {Store(arg0, Debug)}

		// Prepare Source of specified type and value
		Store(Index(arg6, 1), Local7)
		if (m004(Concatenate(arg0, "-m004"), arg3, Refof(SRC0), Local7)) {
			// Source Object can not be prepared
			err(Concatenate(arg0, terr), z126, 21, 0, 0, arg3, 0)
			Return (1)
		}

		// Prepare Target of specified type
		Store(Index(Derefof(Index(arg6, 2)), arg2), Local7)
		if (LEqual(arg2, 5)) {				// Field Unit Target
			Field(OPR0, ByteAcc, NoLock, Preserve) {FLUX, 69, FLU1, 69}
			Store(Refof(FLU1), Local1)
		} elseif (LEqual(arg2, 14)) {		// Buffer Field Target
			Createfield(BUFZ, 80, 69, BFL1)
			Store(Refof(BFL1), Local1)
		} else {
			Store(Refof(DST0), Local1)
		}
		if (m003(Concatenate(arg0, "-m003"), arg2, Local1, Local7)) {
			// Target Object can not be prepared
			err(Concatenate(arg0, terr), z126, 22, 0, 0, arg2, 0)
			Return (1)
		}

		// Use a Source Object to immediately store into the Target
		if (LEqual(arg2, 5)) {				// Field Unit Target
			if (LEqual(arg4, 0)) {				// Store
				Switch(ToInteger(Local6)) {
					Case(0) {Store(ToInteger(SRC0), FLU1)}
					Case(1) {Store(ToBCD(SRC0), FLU1)}
					Case(2) {Store(FromBCD(SRC0), FLU1)}
					Case(3) {Store(ToString(SRC0), FLU1)}
					Case(4) {Store(ToHexString(SRC0), FLU1)}
					Case(5) {Store(ToDecimalString(SRC0), FLU1)}
					Case(6) {Store(ToBuffer(SRC0), FLU1)}
				}
			} elseif (LEqual(arg4, 1)) {		// CopyObject
				Switch(ToInteger(Local6)) {
					Case(0) {CopyObject(ToInteger(SRC0), FLU1)}
					Case(1) {CopyObject(ToBCD(SRC0), FLU1)}
					Case(2) {CopyObject(FromBCD(SRC0), FLU1)}
					Case(3) {CopyObject(ToString(SRC0), FLU1)}
					Case(4) {CopyObject(ToHexString(SRC0), FLU1)}
					Case(5) {CopyObject(ToDecimalString(SRC0), FLU1)}
					Case(6) {CopyObject(ToBuffer(SRC0), FLU1)}
				}
			} elseif (LEqual(arg4, 2)) {		// Optional storing
				Switch(ToInteger(Local6)) {
					Case(0) {ToInteger(SRC0, FLU1)}
					Case(1) {ToBCD(SRC0, FLU1)}
					Case(2) {FromBCD(SRC0, FLU1)}
					Case(3) {ToString(SRC0, Ones, FLU1)}
					Case(4) {ToHexString(SRC0, FLU1)}
					Case(5) {ToDecimalString(SRC0, FLU1)}
					Case(6) {ToBuffer(SRC0, FLU1)}
				}
			} else {
				// Unexpected Kind of Op (0 - Store, ...)
				err(Concatenate(arg0, terr), z126, 23, 0, 0, arg4, 0)
				Return (1)
			}
		} elseif (LEqual(arg2, 14)) {		// Buffer Field Target
			if (LEqual(arg4, 0)) {				// Store
				Switch(ToInteger(Local6)) {
					Case(0) {Store(ToInteger(SRC0), BFL1)}
					Case(1) {Store(ToBCD(SRC0), BFL1)}
					Case(2) {Store(FromBCD(SRC0), BFL1)}
					Case(3) {Store(ToString(SRC0), BFL1)}
					Case(4) {Store(ToHexString(SRC0), BFL1)}
					Case(5) {Store(ToDecimalString(SRC0), BFL1)}
					Case(6) {Store(ToBuffer(SRC0), BFL1)}
				}
			} elseif (LEqual(arg4, 1)) {		// CopyObject
				Switch(ToInteger(Local6)) {
					Case(0) {CopyObject(ToInteger(SRC0), BFL1)}
					Case(1) {CopyObject(ToBCD(SRC0), BFL1)}
					Case(2) {CopyObject(FromBCD(SRC0), BFL1)}
					Case(3) {CopyObject(ToString(SRC0), BFL1)}
					Case(4) {CopyObject(ToHexString(SRC0), BFL1)}
					Case(5) {CopyObject(ToDecimalString(SRC0), BFL1)}
					Case(6) {CopyObject(ToBuffer(SRC0), BFL1)}
				}
			} elseif (LEqual(arg4, 2)) {		// Optional storing
				Switch(ToInteger(Local6)) {
					Case(0) {ToInteger(SRC0, BFL1)}
					Case(1) {ToBCD(SRC0, BFL1)}
					Case(2) {FromBCD(SRC0, BFL1)}
					Case(3) {ToString(SRC0, Ones, BFL1)}
					Case(4) {ToHexString(SRC0, BFL1)}
					Case(5) {ToDecimalString(SRC0, BFL1)}
					Case(6) {ToBuffer(SRC0, BFL1)}
				}
			} else {
				// Unexpected Kind of Op (0 - Store, ...)
				err(Concatenate(arg0, terr), z126, 24, 0, 0, arg4, 0)
				Return (1)
			}

		} elseif (LEqual(arg4, 0)) {		// Store
			Switch(ToInteger(Local6)) {
				Case(0) {Store(ToInteger(SRC0), DST0)}
				Case(1) {Store(ToBCD(SRC0), DST0)}
				Case(2) {Store(FromBCD(SRC0), DST0)}
				Case(3) {Store(ToString(SRC0), DST0)}
				Case(4) {Store(ToHexString(SRC0), DST0)}
				Case(5) {Store(ToDecimalString(SRC0), DST0)}
				Case(6) {Store(ToBuffer(SRC0), DST0)}
			}
		} elseif (LEqual(arg4, 1)) {		// CopyObject
			Switch(ToInteger(Local6)) {
				Case(0) {CopyObject(ToInteger(SRC0), DST0)}
				Case(1) {CopyObject(ToBCD(SRC0), DST0)}
				Case(2) {CopyObject(FromBCD(SRC0), DST0)}
				Case(3) {CopyObject(ToString(SRC0), DST0)}
				Case(4) {CopyObject(ToHexString(SRC0), DST0)}
				Case(5) {CopyObject(ToDecimalString(SRC0), DST0)}
				Case(6) {CopyObject(ToBuffer(SRC0), DST0)}
			}
		} elseif (LEqual(arg4, 2)) {		// Optional storing
			Switch(ToInteger(Local6)) {
				Case(0) {ToInteger(SRC0, DST0)}
				Case(1) {ToBCD(SRC0, DST0)}
				Case(2) {FromBCD(SRC0, DST0)}
				Case(3) {ToString(SRC0, Ones, DST0)}
				Case(4) {ToHexString(SRC0, DST0)}
				Case(5) {ToDecimalString(SRC0, DST0)}
				Case(6) {ToBuffer(SRC0, DST0)}
			}
		} else {
			// Unexpected Kind of Op (0 - Store, ...)
			err(Concatenate(arg0, terr), z126, 25, 0, 0, arg4, 0)
			Return (1)
		}

		if (arg5) {
			// Exception is expected
			if (LNot(CH06(arg0, 26, 0xff))) {
				if (STCS) {m000(2, 0x100, arg2, arg3)}
			}
		} elseif (CH03(arg0, z126, 27, arg3, arg2)) {
			// Storing caused unexpected exception
			if (STCS) {m000(2, 0x100, arg2, arg3)}
		} else {
			// Check Target Object to have the expected type and value

			// Target accept type on storing to Named of Store operator is 0
			if (LEqual(arg4, 0)) {
				Store(0, Local0)
			} else {
				Store(2, Local0)
			}

			m006(Concatenate(arg0, "-m006"), Local1, arg2, arg3, arg4, Local0, arg6)
		}

		// Check Source Object type is not corrupted after storing
		Store(Index(arg6, 1), Local7)
		if (m005(Concatenate(arg0, "-m005"), arg3, Refof(SRC0), Local7)) {
			if (STCS) {
				Store("m008, Source Object has been corrupted during storing", Debug)
			}
		}

		Return (0)
	}

	// Check processing of an Source Named Object of the specified type
	// on immediate storing to a Target LocalX Object of the specified type
	// m009(<msg>, <aux>, <target type>, <source type>,
	//      <op>, <exc. condition>, <test data package>)
	Method(m009, 7, Serialized)
	{
		// Source Named Object
		Name(SRC0, 0)
		// Target Named Object: Local4

		// Retrieve index of the verified Explicit conversion Operator
		Store(Derefof(Index(arg6, 0)), Local6)

		Concatenate(arg0, "-", arg0)
		Concatenate(arg0, Concatenate(Mid(Local6,0,2), Concatenate(Mid(arg4,0,2), Concatenate(Mid(arg2,0,2), Mid(arg3,0,2)))), arg0)
		if (STCS) {Store(arg0, Debug)}

		// Prepare Source of specified type and value
		Store(Index(arg6, 1), Local7)
		if (m004(Concatenate(arg0, "-m004"), arg3, Refof(SRC0), Local7)) {
			// Source Object can not be prepared
			err(Concatenate(arg0, terr), z126, 28, 0, 0, arg3, 0)
			Return (1)
		}

		// Prepare Target of specified type
		Store(Index(Derefof(Index(arg6, 2)), arg2), Local7)
		if (m003(Concatenate(arg0, "-m003"), arg2, Refof(Local4), Local7)) {
			// Target Object can not be prepared
			err(Concatenate(arg0, terr), z126, 29, 0, 0, arg2, 0)
			Return (1)
		}

		// Use a Source Object to immediately store into the Target
		if (LEqual(arg4, 0)) {				// Store
			Switch(ToInteger(Local6)) {
				Case(0) {Store(ToInteger(SRC0), Local4)}
				Case(1) {Store(ToBCD(SRC0), Local4)}
				Case(2) {Store(FromBCD(SRC0), Local4)}
				Case(3) {Store(ToString(SRC0), Local4)}
				Case(4) {Store(ToHexString(SRC0), Local4)}
				Case(5) {Store(ToDecimalString(SRC0), Local4)}
				Case(6) {Store(ToBuffer(SRC0), Local4)}
			}
		} elseif (LEqual(arg4, 1)) {		// CopyObject
			Switch(ToInteger(Local6)) {
				Case(0) {CopyObject(ToInteger(SRC0), Local4)}
				Case(1) {CopyObject(ToBCD(SRC0), Local4)}
				Case(2) {CopyObject(FromBCD(SRC0), Local4)}
				Case(3) {CopyObject(ToString(SRC0), Local4)}
				Case(4) {CopyObject(ToHexString(SRC0), Local4)}
				Case(5) {CopyObject(ToDecimalString(SRC0), Local4)}
				Case(6) {CopyObject(ToBuffer(SRC0), Local4)}
			}
		} elseif (LEqual(arg4, 2)) {		// Optional storing
			Switch(ToInteger(Local6)) {
				Case(0) {ToInteger(SRC0, Local4)}
				Case(1) {ToBCD(SRC0, Local4)}
				Case(2) {FromBCD(SRC0, Local4)}
				Case(3) {ToString(SRC0, Ones, Local4)}
				Case(4) {ToHexString(SRC0, Local4)}
				Case(5) {ToDecimalString(SRC0, Local4)}
				Case(6) {ToBuffer(SRC0, Local4)}
			}
		} else {
			// Unexpected Kind of Op (0 - Store, ...)
			err(Concatenate(arg0, terr), z126, 30, 0, 0, arg4, 0)
			Return (1)
		}

		if (arg5) {
			// Exception is expected
			if (LNot(CH06(arg0, 31, 0xff))) {
				if (STCS) {m000(2, 0x100, arg2, arg3)}
			}
		} elseif (CH03(arg0, z126, 32, arg3, arg2)) {
			// Storing caused unexpected exception
			if (STCS) {m000(2, 0x100, arg2, arg3)}
		} else {
			// Check Target Object to have the expected type and value

			// Target accept type on storing to LocalX is 1
			Store(1, Local0)

			m006(Concatenate(arg0, "-m006"), Refof(Local4), arg2, arg3, arg4, Local0, arg6)
		}

		// Check Source Object type is not corrupted after storing
		Store(Index(arg6, 1), Local7)
		if (m005(Concatenate(arg0, "-m005"), arg3, Refof(SRC0), Local7)) {
			if (STCS) {
				Store("m009, Source Object has been corrupted during storing", Debug)
			}
		}

		Return (0)
	}

	// Test data packages

	// ToInteger

	Name(p032, Package(17) {
		// index of the Operator
		0,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(17) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(17) {
			0,
			0xfedcba9876543210,
			"76543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0,},
	})

	Name(p064, Package(17) {
		// index of the Operator
		0,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(17) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(17) {
			0,
			0xfedcba9876543210,
			"FEDCBA9876543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0,},
	})

	// ToBCD

	Name(p132, Package(17) {
		// index of the Operator
		1,
		// SRC0 initial value
		90123456,
		// Target Objects initial values
		Package(17) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0,},
		// Benchmark Result object value
		0x90123456,
		// Benchmark Result object converted to Target type values
		Package(17) {
			0,
			0x90123456,
			"90123456",
			Buffer(17){0x56, 0x34, 0x12, 0x90,},
			0,
			Buffer(9){0x56, 0x34, 0x12, 0x90,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x56, 0x34, 0x12, 0x90,},
			0, 0,},
	})

	Name(p164, Package(17) {
		// index of the Operator
		1,
		// SRC0 initial value
		3789012345678901,
		// Target Objects initial values
		Package(17) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0,},
		// Benchmark Result object value
		0x3789012345678901,
		// Benchmark Result object converted to Target type values
		Package(17) {
			0,
			0x3789012345678901,
			"3789012345678901",
			Buffer(17){0x01, 0x89, 0x67, 0x45, 0x23, 0x01, 0x89, 0x37,},
			0,
			Buffer(9){0x01, 0x89, 0x67, 0x45, 0x23, 0x01, 0x89, 0x37,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x01, 0x89, 0x67, 0x45, 0x23, 0x01, 0x89, 0x37,},
			0, 0,},
	})

	// FromBCD

	Name(p232, Package(17) {
		// index of the Operator
		2,
		// SRC0 initial value
		0x90123456,
		// Target Objects initial values
		Package(17) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0,},
		// Benchmark Result object value
		90123456,
		// Benchmark Result object converted to Target type values
		Package(17) {
			0,
			90123456,
			"055F2CC0",
			Buffer(17){0xC0, 0x2C, 0x5F, 0x05,},
			0,
			Buffer(9){0xC0, 0x2C, 0x5F, 0x05,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0xC0, 0x2C, 0x5F, 0x05,},
			0, 0,},
	})

	Name(p264, Package(17) {
		// index of the Operator
		2,
		// SRC0 initial value
		0x3789012345678901,
		// Target Objects initial values
		Package(17) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0,},
		// Benchmark Result object value
		3789012345678901,
		// Benchmark Result object converted to Target type values
		Package(17) {
			0,
			3789012345678901,
			"000D76162EE9EC35",
			Buffer(17){0x35, 0xEC, 0xE9, 0x2E, 0x16, 0x76, 0x0D,},
			0,
			Buffer(9){0x35, 0xEC, 0xE9, 0x2E, 0x16, 0x76, 0x0D,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x35, 0xEC, 0xE9, 0x2E, 0x16, 0x76, 0x0D,},
			0, 0,},
	})

	// ToString

	Name(p332, Package(17) {
		// index of the Operator
		3,
		// SRC0 initial value
		"fedcba98 string",
		// Target Objects initial values
		Package(17) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0,},
		// Benchmark Result object value
		"fedcba98 string",
		// Benchmark Result object converted to Target type values
		Package(17) {
			0,
			0xfedcba98,
			"fedcba98 string",
			Buffer(17){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x20, 0x73, 0x74, 0x72, 0x69, 0x6E, 0x67,},
			0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38,},
			0, 0,},
	})

	Name(p364, Package(17) {
		// index of the Operator
		3,
		// SRC0 initial value
		"fedcba9876543210 string",
		// Target Objects initial values
		Package(17) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0,},
		// Benchmark Result object value
		"fedcba9876543210 string",
		// Benchmark Result object converted to Target type values
		Package(17) {
			0,
			0xfedcba9876543210,
			"fedcba9876543210 string",
			Buffer(17){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x37, 0x36, 0x35, 0x34, 0x33, 0x32, 0x31, 0x30, 0x20,},
			0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x17,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x17,},
			0, 0,},
	})

	// ToHexString

	Name(p432, Package(17) {
		// index of the Operator
		4,
		// SRC0 initial value
		"fedcba98 string",
		// Target Objects initial values
		Package(17) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0,},
		// Benchmark Result object value
		"fedcba98 string",
		// Benchmark Result object converted to Target type values
		Package(17) {
			0,
			0xfedcba98,
			"fedcba98 string",
			Buffer(17){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x20, 0x73, 0x74, 0x72, 0x69, 0x6E, 0x67,},
			0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38,},
			0, 0,},
	})

	Name(p464, Package(17) {
		// index of the Operator
		4,
		// SRC0 initial value
		"fedcba9876543210 string",
		// Target Objects initial values
		Package(17) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0,},
		// Benchmark Result object value
		"fedcba9876543210 string",
		// Benchmark Result object converted to Target type values
		Package(17) {
			0,
			0xfedcba9876543210,
			"fedcba9876543210 string",
			Buffer(17){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x37, 0x36, 0x35, 0x34, 0x33, 0x32, 0x31, 0x30, 0x20,},
			0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x17,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x17,},
			0, 0,},
	})

	// ToDecimalString

	Name(p532, Package(17) {
		// index of the Operator
		5,
		// SRC0 initial value
		"fedcba98 string",
		// Target Objects initial values
		Package(17) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0,},
		// Benchmark Result object value
		"fedcba98 string",
		// Benchmark Result object converted to Target type values
		Package(17) {
			0,
			0xfedcba98,
			"fedcba98 string",
			Buffer(17){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x20, 0x73, 0x74, 0x72, 0x69, 0x6E, 0x67,},
			0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38,},
			0, 0,},
	})

	Name(p564, Package(17) {
		// index of the Operator
		5,
		// SRC0 initial value
		"fedcba9876543210 string",
		// Target Objects initial values
		Package(17) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0,},
		// Benchmark Result object value
		"fedcba9876543210 string",
		// Benchmark Result object converted to Target type values
		Package(17) {
			0,
			0xfedcba9876543210,
			"fedcba9876543210 string",
			Buffer(17){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x37, 0x36, 0x35, 0x34, 0x33, 0x32, 0x31, 0x30, 0x20,},
			0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x17,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x17,},
			0, 0,},
	})

	// ToBuffer

	Name(p632, Package(17) {
		// index of the Operator
		6,
		// SRC0 initial value
		Buffer(7){7,6,5,4,3,2,1},
		// Target Objects initial values
		Package(17) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0,},
		// Benchmark Result object value
		Buffer(7){7,6,5,4,3,2,1},
		// Benchmark Result object converted to Target type values
		Package(17) {
			0,
			0x4050607,
			"07 06 05 04 03 02 01",
			Buffer(17){7,6,5,4,3,2,1},
			0,
			Buffer(9){7,6,5,4,3,2,1},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){7,6,5,4,3,2,1},
			0, 0,},
	})

	Name(p664, Package(17) {
		// index of the Operator
		6,
		// SRC0 initial value
		Buffer(7){7,6,5,4,3,2,1},
		// Target Objects initial values
		Package(17) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0,},
		// Benchmark Result object value
		Buffer(7){7,6,5,4,3,2,1},
		// Benchmark Result object converted to Target type values
		Package(17) {
			0,
			0x1020304050607,
			"07 06 05 04 03 02 01",
			Buffer(17){7,6,5,4,3,2,1},
			0,
			Buffer(9){7,6,5,4,3,2,1},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){7,6,5,4,3,2,1},
			0, 0,},
	})

	Name(p320, Package(7) {p032, p132, p232, p332, p432, p532, p632})
	Name(p640, Package(7) {p064, p164, p264, p364, p464, p564, p664})

	Name(scl0, Buffer(){1,1,1,2,2,2,3})

	Name(lpN0, 17)
	Name(lpC0, 0)

	Name(lpN1, 0)
	Name(lpC1, 0)

	if (LEqual(arg0, 0)) {
		Concatenate(ts, "-S", ts)
	} elseif (LEqual(arg0, 1)){
		Concatenate(ts, "-C", ts)
	} elseif (LEqual(arg0, 2)){
		Concatenate(ts, "-O", ts)
	}

	if (LEqual(arg4, 0)) {
		Concatenate(ts, "-N", ts)
	} else {
		Concatenate(ts, "-L", ts)
	}

	if (arg1) {
		Concatenate(ts, "-Exc", ts)
	}

	SRMT(ts)

	// Initialize statistics
	m001()

	if (LGreater(arg0, 2)) {
		// Unexpected Kind of Op (0 - Store, ...)
		err(Concatenate(ts, terr), z126, 33, 0, 0, arg0, 0)
		Return (1)
	}

	if (LGreater(arg4, 1)) {
		// Unexpected Kind of Source-Target pair
		err(Concatenate(ts, terr), z126, 34, 0, 0, arg4, 0)
		Return (1)
	}

	// Flags of Store from and to Named to check
	// exceptional conditions on storing
	if (LNotEqual(arg0, 0)) {
		Store(0, Local0)
		Store(0, Local1)
	} else {
		Store(1, Local0)
		Store(LEqual(arg4, 0), Local1)
	}

	// Enumerate Target types
	While (lpN0) {
		if (LAnd(Derefof(Index(b670, lpC0)), Derefof(Index(arg2, lpC0)))) {
			// Not invalid type of the Target Object to store in

			Store(7, lpN1)
			Store(0, lpC1)

			// Enumerate the Explicit conversion operators
			// which determine expected Result types
			While (lpN1) {
				// Choose expected Result type

				if (y900) {
					Store(Derefof(Index(Buffer(){1,1,1,2,2,2,3}, lpC1)), Local2)
				} else {
					Store(Derefof(Index(scl0, lpC1)), Local2)
				}

				if (LAnd(Derefof(Index(b671, Local2)), Derefof(Index(arg3, Local2)))) {
					// Not invalid type of the result Object to be stored
					if (F64) {
						Store(Derefof(Index(p640, lpC1)), Local3)
					} else {
						Store(Derefof(Index(p320, lpC1)), Local3)
					}

					if (arg1) {
						// Skip cases without exceptional conditions
						if (LNot(m685(LNotEqual(arg0, 0), lpC0, Local2, Local0, Local1))) {
							Decrement(lpN1)
							Increment(lpC1)
							Continue
						}
					} else {
						// Skip cases with exceptional conditions
						if (m685(LNotEqual(arg0, 0), lpC0, Local2, Local0, Local1)) {
							Decrement(lpN1)
							Increment(lpC1)
							Continue
						}
					}

					if (LEqual(arg4, 0)) {
						// Named Source and Target
						m008(Concatenate(ts, "-m008"), 0, lpC0, Local2, arg0, arg1,	Local3)
					} elseif (LEqual(arg4, 1)) {
						// LocalX Target
						m009(Concatenate(ts, "-m009"), 0, lpC0, Local2, arg0, arg1,	Local3)
					}
				}
				Decrement(lpN1)
				Increment(lpC1)
			}
		}
		Decrement(lpN0)
		Increment(lpC0)
	}

	// Output statistics
	m002(Concatenate("Storing of the result of Explicit conversion to Named Object with ",
		Derefof(Index(PAC4, arg0))))

	Return (0)
}

// Run-method
Method(RES3)
{
	Store("TEST: RES3, Result Object optional storing in the explicit conversion operators", Debug)

	// Named Source and Target

	// Store the result of the explicit conversion operators
	m693(0, 0, b676, b676, 0)
	// CopyObject the result of the explicit conversion operators
	m693(1, 0, b676, b676, 0)
	// Optional storing of the result of the explicit conversion operators
	m693(2, 0, b676, b676, 0)

	// LocalX Target

	// Store the result of the explicit conversion operators
	m693(0, 0, b677, b676, 1)
	// CopyObject the result of the explicit conversion operators
	m693(1, 0, b677, b676, 1)
	// Optional storing of the result of the explicit conversion operators
	m693(2, 0, b677, b676, 1)
}

