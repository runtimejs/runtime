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
 * Check Result Object processing in the normal operators
 * providing optional storing (the ones besides Store, CopyObject,
 * explicit conversion operators)
 */

Name(z127, 127)

// m694(<store op>, <exc. conditions>,
//      <Target scale>, <Result scale>, <kind of Source-Target pair>)
Method(m694, 5, Serialized)
{
	Name(ts, "m694")

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
     returned by any normal Operator providing optional storing (Op)):

     = CondRefOf       (any, Result) => Boolean
     = FindSetLeftBit  (int, Result) => Integer
     = FindSetRightBit (int, Result) => Integer
     = Not             (int, Result) => Integer

     = Add             (int, int, Result) => Integer
     = And             (int, int, Result) => Integer
     = Concatenate     ({int|str|buf}, {int|str|buf}, Result) => ComputationalData
     = ConcatenateResTempl  (rtb, rtb, Result) => Buffer
     = Divide          (int, int, Remainder, Result) => Integer
     = Index           ({str|buf|pkg}, int, Destination) => ObjectReference
     = Mod             (int, int, Result) => Integer
     = Multiply        (int, int, Result) => Integer
     = NAnd            (int, int, Result) => Integer
     = NOr             (int, int, Result) => Integer
     = Or              (int, int, Result) => Integer
     = ShiftLeft       (int, int, Result) => Integer
     = ShiftRight      (int, int, Result) => Integer
     = Subtract        (int, int, Result) => Integer
     = XOr             (int, int, Result) => Integer

     = Mid             ({str|buf}, int, int, Result) => Buffer or String

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

	// Package
	Name(PAC0, Package(3) {
		0xfedcba987654321f,
		"test package",
		Buffer(9){19,18,17,16,15,14,13,12,11},
	})
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

	// Specified types of the Source Objects
	Name(BUFS, Buffer(19){1,1,1,1,1,2,3,1,4,1,1,1,1,1,1,1,1,1,2})

	// Expected types of the Result Objects
	Name(BUFR, Buffer(19){1,1,1,1,1,2,3,1,17,1,1,1,1,1,1,1,1,1,2})

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
			Store(Package(INDM) {}, PAC2)
			Store(0, IND2)
			Store(Package(INDM) {}, PAC3)
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
					err(Concatenate(arg0, terr), z127, 1, 0, 0, Local0, 17)
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
				err(Concatenate(arg0, terr), z127, 2, 0, 0, arg1, 0)
				Return (1)
			}
		}
		if (CH03(arg0, z127, 3, arg1, 0)) {
			//Exception during preparing of Target Object
			Return (1)
		}

		if (LEqual(arg1, 17)) {
			// Reference
			Return (0)
		}

		Store(ObjectType(arg2), Local0)
		if (LNotEqual(Local0, arg1)) {
			// ObjectType of Target can not be set up
			err(arg0, z127, 4, 0, 0, Local0, arg1)
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
			Case(4) {
				CopyObject(Derefof(arg3), PAC0)
				CopyObject(PAC0, arg2)
			}
			Default {
				// Unexpected Source Type
				err(Concatenate(arg0, terr), z127, 5, 0, 0, arg1, 0)
				Return (1)
			}
		}
		if (CH03(arg0, z127, 6, arg1, 0)) {
			// Exception during preparing of Source Object
			Return (1)
		}

		Store(ObjectType(arg2), Local0)
		if (LNotEqual(Local0, arg1)) {
			// ObjectType of Source can not be set up
			err(arg0, z127, 7, 0, 0, Local0, arg1)
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
			err(arg0, z127, 8, 0, 0, Local0, arg1)
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
			Case(4) {
				Store(ObjectType(PAC0), Local0)
			}
			Default {
				// Unexpected Source Type
				err(arg0, z127, 9, 0, 0, arg1, 0)
				Return (1)
			}
		}

		if (LNotEqual(Local0, arg1)) {
			// Mismatch of Source Type against specified one
			err(arg0, z127, 10, 0, 0, Local0, arg1)
			if (STCS) {m000(3, 0x1000000, Local0, arg0)}
			Return (1)
		} else {
			// Check equality of the Source value to the Object-initializer one
			Switch(ToInteger(arg1)) {
				Case(1) {
					if (LNotEqual(INT0, Derefof(arg3))) {
						err(arg0, z127, 11, 0, 0, INT0, Derefof(arg3))
						Return (1)
					}
					if (LNotEqual(Derefof(arg2), INT0)) {
						err(arg0, z127, 12, 0, 0, Derefof(arg2), INT0)
						Return (1)
					}
				}
				Case(2) {
					if (LNotEqual(STR0, Derefof(arg3))) {
						err(arg0, z127, 13, 0, 0, STR0, Derefof(arg3))
						Return (1)
					}
					if (LNotEqual(Derefof(arg2), STR0)) {
						err(arg0, z127, 14, 0, 0, Derefof(arg2), STR0)
						Return (1)
					}
				}
				Case(3) {
					if (LNotEqual(BUF0, Derefof(arg3))) {
						err(arg0, z127, 15, 0, 0, BUF0, Derefof(arg3))
						Return (1)
					}
					if (LNotEqual(Derefof(arg2), BUF0)) {
						err(arg0, z127, 16, 0, 0, Derefof(arg2), BUF0)
						Return (1)
					}
				}
			}
		}
		Return (0)
	}

	// Check Target Object to have the expected type and value
	// m006(<msg>, <ref to target>, <target type>, <result object type>,
	//      <op>, <target save type>, <test data package>)
	Method(m006, 7)
	{
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
						//this error report is unnecessary, should be removed.
						//err(arg0, z127, 17, 0, 0, Local2, arg2)
					}
				} else {
					err(arg0, z127, 17, 0, 0, Local2, arg2)
				}

				if (STCS) {m000(3, 0x100, arg2, Local2)}
				Return (1)
			}
		} else {
			// Target must accept type of the Result Object

			if (LNotEqual(Local2, arg3)) {
				if (LEqual(m684(arg3), 6)) {
					// Result object is a reference
					// Check that Target can be used as reference
					Store(Derefof(arg1), Local0)
					Store(Derefof(Local0), Local3)
					if (CH03(arg0, z127, 18, Local2, arg3)) {
						// Derefof caused unexpected exception
						Return (1)
					}
				} elseif (LNotEqual(m684(arg3), 1)) {
					// Types mismatch Result/Target on storing
					err(arg0, z127, 19, 0, 0, Local2, arg3)
					Return (1)
				} elseif (LNotEqual(Local2, 3)) {
					// Types mismatch Result/Target on storing
					// Test fixed type Objects are converted to Buffer
					err(arg0, z127, 20, 0, 0, Local2, 3)
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
			if (LEqual(arg2, c016)) {
				if (X193) {
					err(arg0, z127, 21, 0, 0, Derefof(arg1), Local7)
				}
			} else {
				err(arg0, z127, 21, 0, 0, Derefof(arg1), Local7)
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

		// Retrieve index of the verified Operator
		Store(Derefof(Index(arg6, 0)), Local6)

		Concatenate(arg0, "-", arg0)
		Concatenate(arg0, Concatenate(Mid(Local6,0,2), Concatenate(Mid(arg4,0,2), Concatenate(Mid(arg2,0,2), Mid(arg3,0,2)))), arg0)
		if (STCS) {Store(arg0, Debug)}

		// Target accept type on storing to Named of CopyObject operator is 2
		if (LEqual(arg4, 1)) {
			Store(2, Local0)
		} else {
			Store(0, Local0)
		}

		// Prepare Source of specified type and value
		Store(Index(arg6, 1), Local7)
		if (m004(Concatenate(arg0, "-m004"), arg3, Refof(SRC0), Local7)) {
			// Source Object can not be prepared
			err(Concatenate(arg0, terr), z127, 22, 0, 0, arg3, 0)
			Return (1)
		}

		// Prepare Target of specified type
		Store(Index(Derefof(Index(arg6, 2)), arg2), Local7)
		if (LEqual(arg2, 5)) {		// Field Unit Target
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
			err(Concatenate(arg0, terr), z127, 23, 0, 0, arg2, 0)
			Return (1)
		}

		// Use a Source Object to immediately store into the Target
		if (LEqual(arg2, 5)) {				// Field Unit Target
			if (LEqual(arg4, 0)) {				// Store
				Switch(ToInteger(Local6)) {
					Case(0) {Store(FindSetLeftBit(SRC0), FLU1)}
					Case(1) {Store(FindSetRightBit(SRC0), FLU1)}
					Case(2) {Store(Not(SRC0), FLU1)}
					Case(3) {Store(Add(SRC0, 0), FLU1)}
					Case(4) {Store(And(SRC0, Ones), FLU1)}
					Case(5) {Store(Concatenate(SRC0, ""), FLU1)}
					Case(6) {Store(ConcatenateResTemplate(SRC0, ResourceTemplate(){}), FLU1)}
					Case(7) {Store(Divide(SRC0, 1), FLU1)}
					Case(8) {Store(Index(SRC0, 0), FLU1)}
					Case(9) {Store(Mod(SRC0, Ones), FLU1)}
					Case(10) {Store(Multiply(SRC0, 1), FLU1)}
					Case(11) {Store(NAnd(SRC0, Ones), FLU1)}
					Case(12) {Store(NOr(SRC0, 0), FLU1)}
					Case(13) {Store(Or(SRC0, 0), FLU1)}
					Case(14) {Store(ShiftLeft(SRC0, 0), FLU1)}
					Case(15) {Store(ShiftRight(SRC0, 0), FLU1)}
					Case(16) {Store(Subtract(SRC0, 0), FLU1)}
					Case(17) {Store(XOr(SRC0, 0), FLU1)}
					Case(18) {Store(Mid(SRC0, 0, Ones), FLU1)}
				}
			} elseif (LEqual(arg4, 1)) {		// CopyObject
				Switch(ToInteger(Local6)) {
					Case(0) {CopyObject(FindSetLeftBit(SRC0), FLU1)}
					Case(1) {CopyObject(FindSetRightBit(SRC0), FLU1)}
					Case(2) {CopyObject(Not(SRC0), FLU1)}
					Case(3) {CopyObject(Add(SRC0, 0), FLU1)}
					Case(4) {CopyObject(And(SRC0, Ones), FLU1)}
					Case(5) {CopyObject(Concatenate(SRC0, ""), FLU1)}
					Case(6) {CopyObject(ConcatenateResTemplate(SRC0, ResourceTemplate(){}), FLU1)}
					Case(7) {CopyObject(Divide(SRC0, 1), FLU1)}
					Case(8) {CopyObject(Index(SRC0, 0), FLU1)}
					Case(9) {CopyObject(Mod(SRC0, Ones), FLU1)}
					Case(10) {CopyObject(Multiply(SRC0, 1), FLU1)}
					Case(11) {CopyObject(NAnd(SRC0, Ones), FLU1)}
					Case(12) {CopyObject(NOr(SRC0, 0), FLU1)}
					Case(13) {CopyObject(Or(SRC0, 0), FLU1)}
					Case(14) {CopyObject(ShiftLeft(SRC0, 0), FLU1)}
					Case(15) {CopyObject(ShiftRight(SRC0, 0), FLU1)}
					Case(16) {CopyObject(Subtract(SRC0, 0), FLU1)}
					Case(17) {CopyObject(XOr(SRC0, 0), FLU1)}
					Case(18) {CopyObject(Mid(SRC0, 0, Ones), FLU1)}
				}
			} elseif (LEqual(arg4, 2)) {		// Optional storing
				Switch(ToInteger(Local6)) {
					Case(0) {FindSetLeftBit(SRC0, FLU1)}
					Case(1) {FindSetRightBit(SRC0, FLU1)}
					Case(2) {Not(SRC0, FLU1)}
					Case(3) {Add(SRC0, 0, FLU1)}
					Case(4) {And(SRC0, Ones, FLU1)}
					Case(5) {Concatenate(SRC0, "", FLU1)}
					Case(6) {ConcatenateResTemplate(SRC0, ResourceTemplate(){}, FLU1)}
					Case(7) {Divide(SRC0, 1, , FLU1)}
					Case(8) {Index(SRC0, 0, FLU1)}
					Case(9) {Mod(SRC0, Ones, FLU1)}
					Case(10) {Multiply(SRC0, 1, FLU1)}
					Case(11) {NAnd(SRC0, Ones, FLU1)}
					Case(12) {NOr(SRC0, 0, FLU1)}
					Case(13) {Or(SRC0, 0, FLU1)}
					Case(14) {ShiftLeft(SRC0, 0, FLU1)}
					Case(15) {ShiftRight(SRC0, 0, FLU1)}
					Case(16) {Subtract(SRC0, 0, FLU1)}
					Case(17) {XOr(SRC0, 0, FLU1)}
					Case(18) {Mid(SRC0, 0, Ones, FLU1)}
				}
			} else {
				// Unexpected Kind of Op (0 - Store, ...)
				err(Concatenate(arg0, terr), z127, 24, 0, 0, arg4, 0)
				Return (1)
			}
		} elseif (LEqual(arg2, 14)) {		// Buffer Field Target
			if (LEqual(arg4, 0)) {				// Store
				Switch(ToInteger(Local6)) {
					Case(0) {Store(FindSetLeftBit(SRC0), BFL1)}
					Case(1) {Store(FindSetRightBit(SRC0), BFL1)}
					Case(2) {Store(Not(SRC0), BFL1)}
					Case(3) {Store(Add(SRC0, 0), BFL1)}
					Case(4) {Store(And(SRC0, Ones), BFL1)}
					Case(5) {Store(Concatenate(SRC0, ""), BFL1)}
					Case(6) {Store(ConcatenateResTemplate(SRC0, ResourceTemplate(){}), BFL1)}
					Case(7) {Store(Divide(SRC0, 1), BFL1)}
					Case(8) {Store(Index(SRC0, 0), BFL1)}
					Case(9) {Store(Mod(SRC0, Ones), BFL1)}
					Case(10) {Store(Multiply(SRC0, 1), BFL1)}
					Case(11) {Store(NAnd(SRC0, Ones), BFL1)}
					Case(12) {Store(NOr(SRC0, 0), BFL1)}
					Case(13) {Store(Or(SRC0, 0), BFL1)}
					Case(14) {Store(ShiftLeft(SRC0, 0), BFL1)}
					Case(15) {Store(ShiftRight(SRC0, 0), BFL1)}
					Case(16) {Store(Subtract(SRC0, 0), BFL1)}
					Case(17) {Store(XOr(SRC0, 0), BFL1)}
					Case(18) {Store(Mid(SRC0, 0, Ones), BFL1)}
				}
			} elseif (LEqual(arg4, 1)) {		// CopyObject
				Switch(ToInteger(Local6)) {
					Case(0) {CopyObject(FindSetLeftBit(SRC0), BFL1)}
					Case(1) {CopyObject(FindSetRightBit(SRC0), BFL1)}
					Case(2) {CopyObject(Not(SRC0), BFL1)}
					Case(3) {CopyObject(Add(SRC0, 0), BFL1)}
					Case(4) {CopyObject(And(SRC0, Ones), BFL1)}
					Case(5) {CopyObject(Concatenate(SRC0, ""), BFL1)}
					Case(6) {CopyObject(ConcatenateResTemplate(SRC0, ResourceTemplate(){}), BFL1)}
					Case(7) {CopyObject(Divide(SRC0, 1), BFL1)}
					Case(8) {CopyObject(Index(SRC0, 0), BFL1)}
					Case(9) {CopyObject(Mod(SRC0, Ones), BFL1)}
					Case(10) {CopyObject(Multiply(SRC0, 1), BFL1)}
					Case(11) {CopyObject(NAnd(SRC0, Ones), BFL1)}
					Case(12) {CopyObject(NOr(SRC0, 0), BFL1)}
					Case(13) {CopyObject(Or(SRC0, 0), BFL1)}
					Case(14) {CopyObject(ShiftLeft(SRC0, 0), BFL1)}
					Case(15) {CopyObject(ShiftRight(SRC0, 0), BFL1)}
					Case(16) {CopyObject(Subtract(SRC0, 0), BFL1)}
					Case(17) {CopyObject(XOr(SRC0, 0), BFL1)}
					Case(18) {CopyObject(Mid(SRC0, 0, Ones), BFL1)}
				}
			} elseif (LEqual(arg4, 2)) {		// Optional storing
				Switch(ToInteger(Local6)) {
					Case(0) {FindSetLeftBit(SRC0, BFL1)}
					Case(1) {FindSetRightBit(SRC0, BFL1)}
					Case(2) {Not(SRC0, BFL1)}
					Case(3) {Add(SRC0, 0, BFL1)}
					Case(4) {And(SRC0, Ones, BFL1)}
					Case(5) {Concatenate(SRC0, "", BFL1)}
					Case(6) {ConcatenateResTemplate(SRC0, ResourceTemplate(){}, BFL1)}
					Case(7) {Divide(SRC0, 1, , BFL1)}
					Case(8) {Index(SRC0, 0, BFL1)}
					Case(9) {Mod(SRC0, Ones, BFL1)}
					Case(10) {Multiply(SRC0, 1, BFL1)}
					Case(11) {NAnd(SRC0, Ones, BFL1)}
					Case(12) {NOr(SRC0, 0, BFL1)}
					Case(13) {Or(SRC0, 0, BFL1)}
					Case(14) {ShiftLeft(SRC0, 0, BFL1)}
					Case(15) {ShiftRight(SRC0, 0, BFL1)}
					Case(16) {Subtract(SRC0, 0, BFL1)}
					Case(17) {XOr(SRC0, 0, BFL1)}
					Case(18) {Mid(SRC0, 0, Ones, BFL1)}
				}
			} else {
				// Unexpected Kind of Op (0 - Store, ...)
				err(Concatenate(arg0, terr), z127, 25, 0, 0, arg4, 0)
				Return (1)
			}

		} elseif (LEqual(arg4, 0)) {		// Store
			Switch(ToInteger(Local6)) {
				Case(0) {Store(FindSetLeftBit(SRC0), DST0)}
				Case(1) {Store(FindSetRightBit(SRC0), DST0)}
				Case(2) {Store(Not(SRC0), DST0)}
				Case(3) {Store(Add(SRC0, 0), DST0)}
				Case(4) {Store(And(SRC0, Ones), DST0)}
				Case(5) {Store(Concatenate(SRC0, ""), DST0)}
				Case(6) {Store(ConcatenateResTemplate(SRC0, ResourceTemplate(){}), DST0)}
				Case(7) {Store(Divide(SRC0, 1), DST0)}
				Case(8) {Store(Index(SRC0, 0), DST0)}
				Case(9) {Store(Mod(SRC0, Ones), DST0)}
				Case(10) {Store(Multiply(SRC0, 1), DST0)}
				Case(11) {Store(NAnd(SRC0, Ones), DST0)}
				Case(12) {Store(NOr(SRC0, 0), DST0)}
				Case(13) {Store(Or(SRC0, 0), DST0)}
				Case(14) {Store(ShiftLeft(SRC0, 0), DST0)}
				Case(15) {Store(ShiftRight(SRC0, 0), DST0)}
				Case(16) {Store(Subtract(SRC0, 0), DST0)}
				Case(17) {Store(XOr(SRC0, 0), DST0)}
				Case(18) {Store(Mid(SRC0, 0, Ones), DST0)}
			}
		} elseif (LEqual(arg4, 1)) {		// CopyObject
			Switch(ToInteger(Local6)) {
				Case(0) {CopyObject(FindSetLeftBit(SRC0), DST0)}
				Case(1) {CopyObject(FindSetRightBit(SRC0), DST0)}
				Case(2) {CopyObject(Not(SRC0), DST0)}
				Case(3) {CopyObject(Add(SRC0, 0), DST0)}
				Case(4) {CopyObject(And(SRC0, Ones), DST0)}
				Case(5) {CopyObject(Concatenate(SRC0, ""), DST0)}
				Case(6) {CopyObject(ConcatenateResTemplate(SRC0, ResourceTemplate(){}), DST0)}
				Case(7) {CopyObject(Divide(SRC0, 1), DST0)}
				Case(8) {CopyObject(Index(SRC0, 0), DST0)}
				Case(9) {CopyObject(Mod(SRC0, Ones), DST0)}
				Case(10) {CopyObject(Multiply(SRC0, 1), DST0)}
				Case(11) {CopyObject(NAnd(SRC0, Ones), DST0)}
				Case(12) {CopyObject(NOr(SRC0, 0), DST0)}
				Case(13) {CopyObject(Or(SRC0, 0), DST0)}
				Case(14) {CopyObject(ShiftLeft(SRC0, 0), DST0)}
				Case(15) {CopyObject(ShiftRight(SRC0, 0), DST0)}
				Case(16) {CopyObject(Subtract(SRC0, 0), DST0)}
				Case(17) {CopyObject(XOr(SRC0, 0), DST0)}
				Case(18) {CopyObject(Mid(SRC0, 0, Ones), DST0)}
			}
		} elseif (LEqual(arg4, 2)) {		// Optional storing
			Switch(ToInteger(Local6)) {
				Case(0) {FindSetLeftBit(SRC0, DST0)}
				Case(1) {FindSetRightBit(SRC0, DST0)}
				Case(2) {Not(SRC0, DST0)}
				Case(3) {Add(SRC0, 0, DST0)}
				Case(4) {And(SRC0, Ones, DST0)}
				Case(5) {Concatenate(SRC0, "", DST0)}
				Case(6) {ConcatenateResTemplate(SRC0, ResourceTemplate(){}, DST0)}
				Case(7) {Divide(SRC0, 1, , DST0)}
				Case(8) {Index(SRC0, 0, DST0)}
				Case(9) {Mod(SRC0, Ones, DST0)}
				Case(10) {Multiply(SRC0, 1, DST0)}
				Case(11) {NAnd(SRC0, Ones, DST0)}
				Case(12) {NOr(SRC0, 0, DST0)}
				Case(13) {Or(SRC0, 0, DST0)}
				Case(14) {ShiftLeft(SRC0, 0, DST0)}
				Case(15) {ShiftRight(SRC0, 0, DST0)}
				Case(16) {Subtract(SRC0, 0, DST0)}
				Case(17) {XOr(SRC0, 0, DST0)}
				Case(18) {Mid(SRC0, 0, Ones, DST0)}
			}
		} else {
			// Unexpected Kind of Op (0 - Store, ...)
			err(Concatenate(arg0, terr), z127, 26, 0, 0, arg4, 0)
			Return (1)
		}

		// Choose expected Result type
		Store(Derefof(Index(BUFR, Local6)), Local5)

		if (arg5) {
			// Exception is expected
			if (LNot(CH06(arg0, 27, 0xff))) {
				if (STCS) {m000(2, 0x100, arg2, Local5)}
			}
		} elseif (CH03(arg0, z127, 28, Local5, arg2)) {
			// Storing caused unexpected exception
			if (STCS) {m000(2, 0x100, arg2, Local5)}
		} else {
			// Check Target Object to have the expected type and value
			if (LOr(y127, LNotEqual(Local6, 8))) {
				m006(Concatenate(arg0, "-m006"), Local1, arg2, Local5, arg4, Local0, arg6)
			}
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
		// Target LocalX Object: Local4

		// Retrieve index of the verified Operator
		Store(Derefof(Index(arg6, 0)), Local6)

		Concatenate(arg0, "-", arg0)
		Concatenate(arg0, Concatenate(Mid(Local6,0,2), Concatenate(Mid(arg4,0,2), Concatenate(Mid(arg2,0,2), Mid(arg3,0,2)))), arg0)
		if (STCS) {Store(arg0, Debug)}

		// Prepare Source of specified type and value
		Store(Index(arg6, 1), Local7)
		if (m004(Concatenate(arg0, "-m004"), arg3, Refof(SRC0), Local7)) {
			// Source Object can not be prepared
			err(Concatenate(arg0, terr), z127, 29, 0, 0, arg3, 0)
			Return (1)
		}

		// Prepare Target of specified type and value
		Store(Index(Derefof(Index(arg6, 2)), arg2), Local7)
		if (m003(Concatenate(arg0, "-m003"), arg2, Refof(Local4), Local7)) {
			// Target Object can not be prepared
			err(Concatenate(arg0, terr), z127, 30, 0, 0, arg2, 0)
			Return (1)
		}

		// Use a Source Object to immediately store into the Target
		if (LEqual(arg4, 0)) {		// Store
			Switch(ToInteger(Local6)) {
				Case(0) {Store(FindSetLeftBit(SRC0), Local4)}
				Case(1) {Store(FindSetRightBit(SRC0), Local4)}
				Case(2) {Store(Not(SRC0), Local4)}
				Case(3) {Store(Add(SRC0, 0), Local4)}
				Case(4) {Store(And(SRC0, Ones), Local4)}
				Case(5) {Store(Concatenate(SRC0, ""), Local4)}
				Case(6) {Store(ConcatenateResTemplate(SRC0, ResourceTemplate(){}), Local4)}
				Case(7) {Store(Divide(SRC0, 1), Local4)}
				Case(8) {Store(Index(SRC0, 0), Local4)}
				Case(9) {Store(Mod(SRC0, Ones), Local4)}
				Case(10) {Store(Multiply(SRC0, 1), Local4)}
				Case(11) {Store(NAnd(SRC0, Ones), Local4)}
				Case(12) {Store(NOr(SRC0, 0), Local4)}
				Case(13) {Store(Or(SRC0, 0), Local4)}
				Case(14) {Store(ShiftLeft(SRC0, 0), Local4)}
				Case(15) {Store(ShiftRight(SRC0, 0), Local4)}
				Case(16) {Store(Subtract(SRC0, 0), Local4)}
				Case(17) {Store(XOr(SRC0, 0), Local4)}
				Case(18) {Store(Mid(SRC0, 0, Ones), Local4)}
			}
		} elseif (LEqual(arg4, 1)) {		// CopyObject
			Switch(ToInteger(Local6)) {
				Case(0) {CopyObject(FindSetLeftBit(SRC0), Local4)}
				Case(1) {CopyObject(FindSetRightBit(SRC0), Local4)}
				Case(2) {CopyObject(Not(SRC0), Local4)}
				Case(3) {CopyObject(Add(SRC0, 0), Local4)}
				Case(4) {CopyObject(And(SRC0, Ones), Local4)}
				Case(5) {CopyObject(Concatenate(SRC0, ""), Local4)}
				Case(6) {CopyObject(ConcatenateResTemplate(SRC0, ResourceTemplate(){}), Local4)}
				Case(7) {CopyObject(Divide(SRC0, 1), Local4)}
				Case(8) {CopyObject(Index(SRC0, 0), Local4)}
				Case(9) {CopyObject(Mod(SRC0, Ones), Local4)}
				Case(10) {CopyObject(Multiply(SRC0, 1), Local4)}
				Case(11) {CopyObject(NAnd(SRC0, Ones), Local4)}
				Case(12) {CopyObject(NOr(SRC0, 0), Local4)}
				Case(13) {CopyObject(Or(SRC0, 0), Local4)}
				Case(14) {CopyObject(ShiftLeft(SRC0, 0), Local4)}
				Case(15) {CopyObject(ShiftRight(SRC0, 0), Local4)}
				Case(16) {CopyObject(Subtract(SRC0, 0), Local4)}
				Case(17) {CopyObject(XOr(SRC0, 0), Local4)}
				Case(18) {CopyObject(Mid(SRC0, 0, Ones), Local4)}
			}
		} elseif (LEqual(arg4, 2)) {		// Optional storing
			Switch(ToInteger(Local6)) {
				Case(0) {FindSetLeftBit(SRC0, Local4)}
				Case(1) {FindSetRightBit(SRC0, Local4)}
				Case(2) {Not(SRC0, Local4)}
				Case(3) {Add(SRC0, 0, Local4)}
				Case(4) {And(SRC0, Ones, Local4)}
				Case(5) {Concatenate(SRC0, "", Local4)}
				Case(6) {ConcatenateResTemplate(SRC0, ResourceTemplate(){}, Local4)}
				Case(7) {Divide(SRC0, 1, , Local4)}
				Case(8) {Index(SRC0, 0, Local4)}
				Case(9) {Mod(SRC0, Ones, Local4)}
				Case(10) {Multiply(SRC0, 1, Local4)}
				Case(11) {NAnd(SRC0, Ones, Local4)}
				Case(12) {NOr(SRC0, 0, Local4)}
				Case(13) {Or(SRC0, 0, Local4)}
				Case(14) {ShiftLeft(SRC0, 0, Local4)}
				Case(15) {ShiftRight(SRC0, 0, Local4)}
				Case(16) {Subtract(SRC0, 0, Local4)}
				Case(17) {XOr(SRC0, 0, Local4)}
				Case(18) {Mid(SRC0, 0, Ones, Local4)}
			}
		} else {
			// Unexpected Kind of Op (0 - Store, ...)
			err(Concatenate(arg0, terr), z127, 31, 0, 0, arg4, 0)
			Return (1)
		}

		// Choose expected Result type
		Store(Derefof(Index(BUFR, Local6)), Local5)

		if (arg5) {
			// Exception is expected
			if (LNot(CH06(arg0, 32, 0xff))) {
				if (STCS) {m000(2, 0x100, arg2, Local5)}
			}
		} elseif (CH03(arg0, z127, 33, Local5, arg2)) {
			// Storing caused unexpected exception
			if (STCS) {m000(2, 0x100, arg2, Local5)}
		} else {
			// Check Target Object to have the expected type and value

			// Target accept type on storing to LocalX is 1
			Store(1, Local0)

			if (LOr(y127, LNotEqual(Local6, 8))) {
				m006(Concatenate(arg0, "-m006"), Refof(Local4), arg2, Local5, arg4, Local0, arg6)
			}
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

	// FindSetLeftBit

	Name(p032, Package(18) {
		// index of the Operator
		0,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		31,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			31,
			"0000001F",
			Buffer(17){0x1F,},
			0,
			Buffer(9){0x1F,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x1F,},
			0, 0, 0,},
	})

	Name(p064, Package(18) {
		// index of the Operator
		0,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		64,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			64,
			"0000000000000040",
			Buffer(17){0x40,},
			0,
			Buffer(9){0x40,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x40,},
			0, 0, 0,},
	})

	// FindSetRightBit

	Name(p132, Package(18) {
		// index of the Operator
		1,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		5,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			5,
			"00000005",
			Buffer(17){0x05,},
			0,
			Buffer(9){0x05,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x05,},
			0, 0, 0,},
	})

	Name(p164, Package(18) {
		// index of the Operator
		1,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		5,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			5,
			"0000000000000005",
			Buffer(17){0x05,},
			0,
			Buffer(9){0x05,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x05,},
			0, 0, 0,},
	})

	// Not

	Name(p232, Package(18) {
		// index of the Operator
		2,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0x123456789abcdef,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0x123456789abcdef,
			"89ABCDEF",
			Buffer(17){0xef, 0xcd, 0xab, 0x89,},
			0,
			Buffer(9){0xef, 0xcd, 0xab, 0x89,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0xef, 0xcd, 0xab, 0x89,},
			0, 0, 0,},
	})

	Name(p264, Package(18) {
		// index of the Operator
		2,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0x123456789abcdef,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0x123456789abcdef,
			"0123456789ABCDEF",
			Buffer(17){0xef, 0xcd, 0xab, 0x89, 0x67, 0x45, 0x23, 0x01,},
			0,
			Buffer(9){0xef, 0xcd, 0xab, 0x89, 0x67, 0x45, 0x23, 0x01,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0xef, 0xcd, 0xab, 0x89, 0x67, 0x45, 0x23, 0x01,},
			0, 0, 0,},
	})

	// Add

	Name(p332, Package(18) {
		// index of the Operator
		3,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"76543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0,},
	})

	Name(p364, Package(18) {
		// index of the Operator
		3,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"FEDCBA9876543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0,},
	})

	// And

	Name(p432, Package(18) {
		// index of the Operator
		4,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"76543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0,},
	})

	Name(p464, Package(18) {
		// index of the Operator
		4,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"FEDCBA9876543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0,},
	})

	// Concatenate

	Name(p532, Package(18) {
		// index of the Operator
		5,
		// SRC0 initial value
		"fedcba98 string",
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		"fedcba98 string",
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba98,
			"fedcba98 string",
			Buffer(17){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x20, 0x73, 0x74, 0x72, 0x69, 0x6E, 0x67,},
			0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38,},
			0, 0, 0,},
	})

	Name(p564, Package(18) {
		// index of the Operator
		5,
		// SRC0 initial value
		"fedcba9876543210 string",
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		"fedcba9876543210 string",
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"fedcba9876543210 string",
			Buffer(17){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x37, 0x36, 0x35, 0x34, 0x33, 0x32, 0x31, 0x30, 0x20,},
			0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x17,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x17,},
			0, 0, 0,},
	})

	// ConcatenateResTempl

	Name(p600, Package(18) {
		// index of the Operator
		6,
		// SRC0 initial value
		ResourceTemplate(){},
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		Buffer(2){0x79, 0},
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0x0079,
			"79 00",
			Buffer(17){0x79, 0},
			0,
			Buffer(9){0x79, 0},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x79, 0},
			0, 0, 0,},
	})

	// Divide

	Name(p732, Package(18) {
		// index of the Operator
		7,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"76543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0,},
	})

	Name(p764, Package(18) {
		// index of the Operator
		7,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"FEDCBA9876543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0,},
	})

	// Index

	Name(p832, Package(18) {
		// index of the Operator
		8,
		// SRC0 initial value
		Package(1) {
			0xfedcba9876543210},
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"76543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0,},
	})

	Name(p864, Package(18) {
		// index of the Operator
		8,
		// SRC0 initial value
		Package(1) {
			0xfedcba9876543210},
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"FEDCBA9876543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0,},
	})

	// Mod

	Name(p932, Package(18) {
		// index of the Operator
		9,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"76543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0,},
	})

	Name(p964, Package(18) {
		// index of the Operator
		9,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"FEDCBA9876543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0,},
	})

	// Multiply

	Name(pa32, Package(18) {
		// index of the Operator
		10,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"76543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0,},
	})

	Name(pa64, Package(18) {
		// index of the Operator
		10,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"FEDCBA9876543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0,},
	})

	// NAnd

	Name(pb32, Package(18) {
		// index of the Operator
		11,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0x123456789abcdef,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0x123456789abcdef,
			"89ABCDEF",
			Buffer(17){0xef, 0xcd, 0xab, 0x89,},
			0,
			Buffer(9){0xef, 0xcd, 0xab, 0x89,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0xef, 0xcd, 0xab, 0x89,},
			0, 0, 0,},
	})

	Name(pb64, Package(18) {
		// index of the Operator
		11,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0x123456789abcdef,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0x123456789abcdef,
			"0123456789ABCDEF",
			Buffer(17){0xef, 0xcd, 0xab, 0x89, 0x67, 0x45, 0x23, 0x01,},
			0,
			Buffer(9){0xef, 0xcd, 0xab, 0x89, 0x67, 0x45, 0x23, 0x01,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0xef, 0xcd, 0xab, 0x89, 0x67, 0x45, 0x23, 0x01,},
			0, 0, 0,},
	})

	// NOr

	Name(pc32, Package(18) {
		// index of the Operator
		12,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0x123456789abcdef,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0x123456789abcdef,
			"89ABCDEF",
			Buffer(17){0xef, 0xcd, 0xab, 0x89,},
			0,
			Buffer(9){0xef, 0xcd, 0xab, 0x89,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0xef, 0xcd, 0xab, 0x89,},
			0, 0, 0,},
	})

	Name(pc64, Package(18) {
		// index of the Operator
		12,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0x123456789abcdef,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0x123456789abcdef,
			"0123456789ABCDEF",
			Buffer(17){0xef, 0xcd, 0xab, 0x89, 0x67, 0x45, 0x23, 0x01,},
			0,
			Buffer(9){0xef, 0xcd, 0xab, 0x89, 0x67, 0x45, 0x23, 0x01,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0xef, 0xcd, 0xab, 0x89, 0x67, 0x45, 0x23, 0x01,},
			0, 0, 0,},
	})

	// Or

	Name(pd32, Package(18) {
		// index of the Operator
		13,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"76543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0,},
	})

	Name(pd64, Package(18) {
		// index of the Operator
		13,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"FEDCBA9876543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0,},
	})

	// ShiftLeft

	Name(pe32, Package(18) {
		// index of the Operator
		14,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"76543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0,},
	})

	Name(pe64, Package(18) {
		// index of the Operator
		14,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"FEDCBA9876543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0,},
	})

	// ShiftRight

	Name(pf32, Package(18) {
		// index of the Operator
		15,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"76543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0,},
	})

	Name(pf64, Package(18) {
		// index of the Operator
		15,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"FEDCBA9876543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0,},
	})

	// Subtract

	Name(pg32, Package(18) {
		// index of the Operator
		16,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"76543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0,},
	})

	Name(pg64, Package(18) {
		// index of the Operator
		16,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"FEDCBA9876543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0,},
	})

	// XOr

	Name(ph32, Package(18) {
		// index of the Operator
		17,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"76543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76,},
			0, 0, 0,},
	})

	Name(ph64, Package(18) {
		// index of the Operator
		17,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		0xfedcba9876543210,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"FEDCBA9876543210",
			Buffer(17){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x10, 0x32, 0x54, 0x76, 0x98, 0xBA, 0xDC, 0xFE,},
			0, 0, 0,},
	})

	// Mid

	Name(pi32, Package(18) {
		// index of the Operator
		18,
		// SRC0 initial value
		"fedcba98 string",
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		"fedcba98 string",
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba98,
			"fedcba98 string",
			Buffer(17){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x20, 0x73, 0x74, 0x72, 0x69, 0x6E, 0x67,},
			0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38,},
			0, 0, 0,},
	})

	Name(pi64, Package(18) {
		// index of the Operator
		18,
		// SRC0 initial value
		"fedcba9876543210 string",
		// Target Objects initial values
		Package(18) {
			0,
			0xfedcba9876543211,
			"target string",
			Buffer(17){0xc3},
			Package(1) {
				"target package"},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
		// Benchmark Result object value
		"fedcba9876543210 string",
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xfedcba9876543210,
			"fedcba9876543210 string",
			Buffer(17){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x37, 0x36, 0x35, 0x34, 0x33, 0x32, 0x31, 0x30, 0x20,},
			0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x17,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x66, 0x65, 0x64, 0x63, 0x62, 0x61, 0x39, 0x38, 0x17,},
			0, 0, 0,},
	})

	Name(p320, Package(19) {
		p032, p132, p232, p332, p432, p532, p600, p732, p832, p932,
		pa32, pb32, pc32, pd32, pe32, pf32, pg32, ph32, pi32,})
	Name(p640, Package(19) {
		p064, p164, p264, p364, p464, p564, p600, p764, p864, p964,
		pa64, pb64, pc64, pd64, pe64, pf64, pg64, ph64, pi64,})

	Name(lpN0, 18)
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
		err(Concatenate(ts, terr), z127, 34, 0, 0, arg0, 0)
		Return (1)
	}

	if (LGreater(arg4, 1)) {
		// Unexpected Kind of Source-Target pair
		err(Concatenate(ts, terr), z127, 35, 0, 0, arg4, 0)
		Return (1)
	}

	// Flags of Store from and to Named to check
	// exceptional conditions on storing
	if (LEqual(arg0, 1)) {
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

			Store(19, lpN1)
			Store(0, lpC1)

			// Enumerate the operators
			// which determine expected Result types
			While (lpN1) {
				// Choose expected Result type
				Store(Derefof(Index(BUFR, lpC1)), Local2)

				if (LAnd(Derefof(Index(b671, Local2)), Derefof(Index(arg3, Local2)))) {
					// Not invalid type of the result Object to be stored
					if (F64) {
						Store(Derefof(Index(p640, lpC1)), Local3)
					} else {
						Store(Derefof(Index(p320, lpC1)), Local3)
					}

					if (arg1) {
						// Skip cases without exceptional conditions
						if (LNot(m685(LNotEqual(arg0, 1), lpC0, Local2, Local0, Local1))) {
							Decrement(lpN1)
							Increment(lpC1)
							Continue
						}
					} else {
						// Skip cases with exceptional conditions
						if (m685(LNotEqual(arg0, 1), lpC0, Local2, Local0, Local1)) {
							Decrement(lpN1)
							Increment(lpC1)
							Continue
						}
					}

					if (LEqual(arg4, 0)) {
						// Named Source and Target
						m008(Concatenate(ts, "-m008"), 0, lpC0,
							Derefof(Index(BUFS, lpC1)), arg0, arg1, Local3)
					} elseif (LEqual(arg4, 1)) {
						// LocalX Target
						m009(Concatenate(ts, "-m009"), 0, lpC0,
							Derefof(Index(BUFS, lpC1)), arg0, arg1, Local3)
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
	m002(Concatenate("Storing of the result of normal operator to Named Object with ",
		Derefof(Index(PAC4, arg0))))

	Return (0)
}

// Run-method
Method(RES4)
{
	Store("TEST: RES4, Result Object processing in the normal operators", Debug)

	// Named Source and Target

	// Store the result of the normal operators
	m694(0, 0, b676, b676, 0)
	// CopyObject the result of the normal operators
	m694(1, 0, b676, b676, 0)
	// Optional storing of the result of the normal operators
	m694(2, 0, b676, b676, 0)

	// LocalX Target

	// Store the result of the normal operators
	m694(0, 0, b677, b676, 1)
	// CopyObject the result of the normal operators
	m694(1, 0, b677, b676, 1)
	// Optional storing of the result of the normal operators
	m694(2, 0, b677, b676, 1)
}

