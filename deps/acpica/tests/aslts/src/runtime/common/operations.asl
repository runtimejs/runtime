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


//  /////////////////////////////////////////////////////////////////////////
//  0 - Acquire                (arg0, arg1)                         => Local7
//  1 - Add                    (arg0, arg1, RES)                    => Local7
//  2 - And                    (arg0, arg1, RES)                    => Local7
//  3 - Concatenate            (arg0, arg1, RES)                    => Local7
//  4 - ConcatenateResTemplate (arg0, arg1, RES)                    => Local7
//  5 - CondRefOf              (arg0, RES)                          => Local7
//  6 - CopyObject             (arg0, RES)                          => Local7
//  7 - Decrement              (arg0 --> RES)                       => Local7
//  8 - DerefOf                (arg0)                               => Local7
//  9 - Divide                 (arg0, arg1, RES, RES)               => Local7
// 10 - Fatal                  (arg0, arg1, arg2)
// 11 - FindSetLeftBit         (arg0, RES)                          => Local7
// 12 - FindSetRightBit        (arg0, RES)                          => Local7
// 13 - FromBCD                (arg0, RES)                          => Local7
// 14 - Increment              (arg0 --> RES)                       => Local7
// 15 - Index                  (arg0, arg1, RES)                    => Local7
// 16 - LAnd                   (arg0, arg1)                         => Local7
// 17 - LEqual                 (arg0, arg1)                         => Local7
// 18 - LGreater               (arg0, arg1)                         => Local7
// 19 - LGreaterEqual          (arg0, arg1)                         => Local7
// 20 - LLess                  (arg0, arg1)                         => Local7
// 21 - LLessEqual             (arg0, arg1)                         => Local7
// 22 - LNot                   (arg0)                               => Local7
// 23 - LNotEqual              (arg0, arg1)                         => Local7
// 24 - LOr                    (arg0, arg1)                         => Local7
// 25 - Match    <arg1-O1,O2>  (arg0, <O1>, arg2, <O2>, arg3, arg4) => Local7
// 26 - Mid                    (arg0, arg1, arg2, RES)              => Local7
// 27 - Mod                    (arg0, arg1, RES)                    => Local7
// 28 - Multiply               (arg0, arg1, RES)                    => Local7
// 29 - NAnd                   (arg0, arg1, RES)                    => Local7
// 30 - NOr                    (arg0, arg1, RES)                    => Local7
// 31 - Not                    (arg0, RES)                          => Local7
// 32 - ObjectType             (arg0)                               => Local7
// 33 - Or                     (arg0, arg1, RES)                    => Local7
// 34 - RefOf                  (arg0)                               => Local7
// 35 - Release                (arg0)
// 36 - Reset                  (arg0)
// 37 - Return                 (arg0)
// 38 - ShiftLeft              (arg0, arg1, RES)                    => Local7
// 39 - ShiftRight             (arg0, arg1, RES)                    => Local7
// 40 - Signal                 (arg0)
// 41 - SizeOf                 (arg0)                               => Local7
// 42 - Sleep                  (arg0)
// 43 - Stall                  (arg0)
// 44 - Store                  (arg0, RES)                          => Local7
// 45 - Subtract               (arg0, arg1, RES)                    => Local7
// 46 - ToBCD                  (arg0, RES)                          => Local7
// 47 - ToBuffer               (arg0, RES)                          => Local7
// 48 - ToDecimalString        (arg0, RES)                          => Local7
// 49 - ToHexString            (arg0, RES)                          => Local7
// 50 - ToInteger              (arg0, RES)                          => Local7
// 51 - ToString               (arg0, arg1, RES)                    => Local7
// 52 - Wait                   (arg0, arg1)                         => Local7
// 53 - XOr                    (arg0, arg1, RES)                    => Local7
// //////////////////////////////////////////////////////////////////////////

Name(z082, 82)

// Flag - verify result with the contents of Package
Name(FLG2, 0x3859a0d4)

// Flag - it is expected that operation will cause exception
Name(FLG3, 0)

// Flag - dont do further checkings
Name(FLG4, 0)

// Collect calls to all operators
//
// arg0-arg4 - parameters of operators
// arg5      - miscellaneous
// arg6      - opcode of operation
Method(m480, 7, Serialized)
{
	Name(ts, "m480")

	Name(pr00, 0)
	Name(pr01, 0)

	Name(chk0, 1)
	Name(res0, 0)
	Name(res1, 0)
	Name(res2, 0)

	if (LEqual(arg5, FLG2)) {
		Store(0, chk0)
	}

	if (chk0) {

	Name(tmp0, 0)
	Name(tmp1, 0)

	Name(OT00, 0)
	Name(OT01, 0)
	Name(OT02, 0)
	Name(OT03, 0)
	Name(OT04, 0)
	Name(OT05, 0)
	Name(OT06, 0)

	Store(ObjectType(arg0), OT00)
	Store(ObjectType(arg1), OT01)
	Store(ObjectType(arg2), OT02)
	Store(ObjectType(arg3), OT03)
	Store(ObjectType(arg4), OT04)
	Store(ObjectType(arg5), OT05)
	Store(ObjectType(arg6), OT06)

	Store(arg0, Local0)
	Store(arg1, Local1)
	Store(arg2, Local2)
	Store(arg3, Local3)
	Store(arg4, Local4)
	Store(arg5, Local5)
	Store(arg6, Local6)

	Name(OT10, 0)
	Name(OT11, 0)
	Name(OT12, 0)
	Name(OT13, 0)
	Name(OT14, 0)
	Name(OT15, 0)
	Name(OT16, 0)

	Store(ObjectType(Local0), OT10)
	Store(ObjectType(Local1), OT11)
	Store(ObjectType(Local2), OT12)
	Store(ObjectType(Local3), OT13)
	Store(ObjectType(Local4), OT14)
	Store(ObjectType(Local5), OT15)
	Store(ObjectType(Local6), OT16)

	} // if(chk0)

	Store(0, Local7)

	if (pr00) {
		Store("===================== m480, Start:", Debug)
		Store(arg0, Debug)
		Store(arg1, Debug)
		Store(arg2, Debug)
		Store(arg3, Debug)
		Store(arg4, Debug)
		Store(arg5, Debug)
		Store(arg6, Debug)
		if (chk0) {
			Store("--------", Debug)
			Store(Local0, Debug)
			Store(Local1, Debug)
			Store(Local2, Debug)
			Store(Local3, Debug)
			Store(Local4, Debug)
			Store(Local5, Debug)
			Store(Local6, Debug)
			Store(Local7, Debug)
		}
		Store("=====================.", Debug)
	}

	switch (ToInteger (Arg6)) {
		case (0) {
			Store(Acquire(arg0, 100), Local7)
		}
		case (1) {
			Store(1, res0)
			Store(Add(arg0, arg1, arg5), Local7)
		}
		case (2) {
			Store(1, res0)
			Store(And(arg0, arg1, arg5), Local7)
		}
		case (3) {
			Store(1, res0)
			Store(Concatenate(arg0, arg1, arg5), Local7)
		}
		case (4) {
			Store(1, res0)
			Store(ConcatenateResTemplate(arg0, arg1, arg5), Local7)
		}
		case (5) {
			Store(1, res2)
			Store(CondRefOf(arg0, arg5), Local7)
		}
		case (6) {
			Store(1, res0)
			Store(CopyObject(arg0, arg5), Local7)
		}
		case (7) {
			Store(1, res0)
			Store(arg0, arg5)
			Store(Decrement(arg5), Local7)
		}
		case (8) {
			Store(DerefOf(arg0), Local7)
		}
		case (9) {
			Store(1, res0)
			Store(1, res1)
			Store(Divide(arg0, arg1, arg2, arg5), Local7)
		}
		case (10) {
			Fatal(0xff, 0xffffffff, arg0)
		}
		case (11) {
			Store(1, res0)
			Store(FindSetLeftBit(arg0, arg5), Local7)
		}
		case (12) {
			Store(1, res0)
			Store(FindSetRightBit(arg0, arg5), Local7)
		}
		case (13) {
			Store(1, res0)
			Store(FromBCD(arg0, arg5), Local7)
		}
		case (14) {
			Store(1, res0)
			Store(arg0, arg5)
			Store(Increment(arg5), Local7)
		}
		case (15) {
			Store(1, res0)
			Store(Index(arg0, arg1, arg5), Local7)
		}
		case (16) {
			Store(LAnd(arg0, arg1), Local7)
		}
		case (17) {
			Store(LEqual(arg0, arg1), Local7)
		}
		case (18) {
			Store(LGreater(arg0, arg1), Local7)
		}
		case (19) {
			Store(LGreaterEqual(arg0, arg1), Local7)
		}
		case (20) {
			Store(LLess(arg0, arg1), Local7)
		}
		case (21) {
			Store(LLessEqual(arg0, arg1), Local7)
		}
		case (22) {
			Store(LNot(arg0), Local7)
		}
		case (23) {
			Store(LNotEqual(arg0, arg1), Local7)
		}
		case (24) {
			Store(LOr(arg0, arg1), Local7)
		}
		case (25) {
			// arg1 - determine OP1 and OP2
			Store(Match(arg0, MTR, arg2, MTR, arg3, arg4), Local7)
		}
		case (26) {
			Store(1, res0)
			Store(Mid(arg0, arg1, arg2, arg5), Local7)
		}
		case (27) {
			Store(1, res0)
			Store(Mod(arg0, arg1, arg5), Local7)
		}
		case (28) {
			Store(1, res0)
			Store(Multiply(arg0, arg1, arg5), Local7)
		}
		case (29) {
			Store(1, res0)
			Store(NAnd(arg0, arg1, arg5), Local7)
		}
		case (30) {
			Store(1, res0)
			Store(NOr(arg0, arg1, arg5), Local7)
		}
		case (31) {
			Store(1, res0)
			Store(Not(arg0, arg5), Local7)
		}
		case (32) {
			Store(ObjectType(arg0), Local7)
		}
		case (33) {
			Store(1, res0)
			Store(Or(arg0, arg1, arg5), Local7)
		}
		case (34) {
			Store(RefOf(arg0), Local7)
		}
		case (35) {
			Release(arg0)
		}
		case (36) {
			Reset(arg0)
		}
		case (37) {
			Return(arg0)
		}
		case (38) {
			Store(1, res0)
			Store(ShiftLeft(arg0, arg1, arg5), Local7)
		}
		case (39) {
			Store(1, res0)
			Store(ShiftRight(arg0, arg1, arg5), Local7)
		}
		case (40) {
			Signal(arg0)
		}
		case (41) {
			Store(SizeOf(arg0), Local7)
		}
		case (42) {
			Sleep(arg0)
		}
		case (43) {
			Stall(arg0)
		}
		case (44) {
			Store(1, res0)
			Store(Store(arg0, arg5), Local7)
		}
		case (45) {
			Store(1, res0)
			Store(Subtract(arg0, arg1, arg5), Local7)
		}
		case (46) {
			Store(1, res0)
			Store(ToBCD(arg0, arg5), Local7)
		}
		case (47) {
			Store(1, res0)
			Store(ToBuffer(arg0, arg5), Local7)
		}
		case (48) {
			Store(1, res0)
			Store(ToDecimalString(arg0, arg5), Local7)
		}
		case (49) {
			Store(1, res0)
			Store(ToHexString(arg0, arg5), Local7)
		}
		case (50) {
			Store(1, res0)
			Store(ToInteger(arg0, arg5), Local7)
		}
		case (51) {
			Store(1, res0)
			Store(ToString(arg0, arg1, arg5), Local7)
		}
		case (52) {
			Store(Wait(arg0, arg1), Local7)
		}
		case (53) {
			Store(1, res0)
			Store(XOr(arg0, arg1, arg5), Local7)
		}
		Default {
			Store("Param error 0", Debug)
			Store(1, Local0)
			Store(0, Local1)
			Divide(Local0, Local1, Local2, Local3)
		}
	}

	if (FLG3) {

		// It was expected that operation will cause exception.
		// We verify only the presence of exception.
		// Nothing to do more.

		return (1)
	}

	if (FLG4) {

		// Dont do further checkings.

		return (1)
	}

	if (chk0) {

	// Types of ArgX are save

	Store(ObjectType(arg0), tmp0)
	if (LNotEqual(tmp0, OT00)) {
		err(ts, z082, 0, 0, 0, tmp0, OT00)
	}
	Store(ObjectType(arg1), tmp0)
	if (LNotEqual(tmp0, OT01)) {
		err(ts, z082, 1, 0, 0, tmp0, OT01)
	}
	Store(ObjectType(arg2), tmp0)
	if (LNotEqual(tmp0, OT02)) {
		err(ts, z082, 2, 0, 0, tmp0, OT02)
	}
	Store(ObjectType(arg3), tmp0)
	if (LNotEqual(tmp0, OT03)) {
		err(ts, z082, 3, 0, 0, tmp0, OT03)
	}
	Store(ObjectType(arg4), tmp0)
	if (LNotEqual(tmp0, OT04)) {
		err(ts, z082, 4, 0, 0, tmp0, OT04)
	}

	if (res0) {
		Store(ObjectType(arg5), tmp0)
		if (LNotEqual(tmp0, OT05)) {
			err(ts, z082, 5, 0, 0, tmp0, OT05)
		}
	}
	Store(ObjectType(arg6), tmp0)
	if (LNotEqual(tmp0, OT06)) {
		err(ts, z082, 6, 0, 0, tmp0, OT06)
	}

	// Types of LocalX are save, and data of LocalX and ArgX are identical

	Store(ObjectType(Local0), tmp0)
	if (LNotEqual(tmp0, OT10)) {
		err(ts, z082, 7, 0, 0, tmp0, OT10)
	} else {
		m481(ts, 8, tmp0, Local0, arg0)
	}
	Store(ObjectType(Local1), tmp0)
	if (LNotEqual(tmp0, OT11)) {
		err(ts, z082, 9, 0, 0, tmp0, OT11)
	} else {
		m481(ts, 10, tmp0, Local1, arg1)
	}

	if (res1) {
		Store(ObjectType(Local2), tmp0)
		if (LNotEqual(tmp0, OT12)) {
			err(ts, z082, 11, 0, 0, tmp0, OT12)
		} else {
			m481(ts, 12, tmp0, Local2, arg2)
		}
	}

	Store(ObjectType(Local3), tmp0)
	if (LNotEqual(tmp0, OT13)) {
		err(ts, z082, 13, 0, 0, tmp0, OT13)
	} else {
		m481(ts, 14, tmp0, Local3, arg3)
	}
	Store(ObjectType(Local4), tmp0)
	if (LNotEqual(tmp0, OT14)) {
		err(ts, z082, 15, 0, 0, tmp0, OT14)
	} else {
		m481(ts, 16, tmp0, Local4, arg4)
	}
	Store(ObjectType(Local5), tmp0)
	if (LNotEqual(tmp0, OT15)) {
		err(ts, z082, 17, 0, 0, tmp0, OT15)
	} elseif (res0) {
		m481(ts, 18, tmp0, Local5, arg5)
	}
	Store(ObjectType(Local6), tmp0)
	if (LNotEqual(tmp0, OT16)) {
		err(ts, z082, 19, 0, 0, tmp0, OT16)
	} else {
		m481(ts, 20, tmp0, Local6, arg6)
	}

	if (res2) {
		if (LNotEqual(Local7, Ones)) {
			err(ts, z082, 21, 0, 0, Local7, Ones)
		}
	} elseif (res0) {
		Store(ObjectType(Local7), tmp0)
		Store(ObjectType(arg5), tmp1)
		if (LNotEqual(tmp0, tmp1)) {
			err(ts, z082, 22, 0, 0, tmp0, tmp1)
		} else {
			m481(ts, 23, tmp0, Local7, arg5)
		}
	}

	} // if(chk0)

	if (pr01) {
		Store("===================== m480, Finish:", Debug)
		Store(arg0, Debug)
		Store(arg1, Debug)
		Store(arg2, Debug)
		Store(arg3, Debug)
		Store(arg4, Debug)
		Store(arg5, Debug)
		Store(arg6, Debug)
		if (chk0) {
			Store("--------", Debug)
			Store(Local0, Debug)
			Store(Local1, Debug)
			Store(Local2, Debug)
			Store(Local3, Debug)
			Store(Local4, Debug)
			Store(Local5, Debug)
			Store(Local6, Debug)
			Store(Local7, Debug)
		}
		Store("=====================.", Debug)
	}

	Return(Local7)
}

// Compare the contents of arg3 and arg4, arg2 - the type of objects
Method(m481, 5, Serialized)
{
	Store(0, Local0)

	switch (ToInteger (arg2)) {
		case (1) {
			if (LNotEqual(arg3, arg4)) {
				err(arg0, z082, 24, 0, 0, arg1, 0)
				Store(1, Local0)
			}
		}
		case (2) {
			if (LNotEqual(arg3, arg4)) {
				err(arg0, z082, 25, 0, 0, arg1, 0)
				Store(1, Local0)
			}
		}
		case (3) {
			if (LNotEqual(arg3, arg4)) {
				err(arg0, z082, 26, 0, 0, arg1, 0)
				Store(1, Local0)
			}
		}
	}

	if (Local0) {
		Store(arg3, Debug)
		Store(arg4, Debug)
	}

}

// Layer for checking referencies
//
// arg0-arg4 - parameters of operators
// arg5      - miscellaneous
// arg6      - opcode of operation
Method(m482, 7, Serialized)
{
///////////////////
//
// !!!!!!!!!!!!!!  ??????????????????????????????????????
//
// Looks like a bug - why this construction is impossible:
//
//	Name(OT11, ObjectType(arg0))
//	Name(a000, arg0)
///////////////////

	Name(ts, "m482")

	Name(pk06, 0)

	Name(tmp0, 0)

	Name(OT00, 0)
	Name(OT01, 0)
	Name(OT02, 0)
	Name(OT03, 0)
	Name(OT04, 0)
	Name(OT05, 0)
	Name(OT06, 0)

	Store(ObjectType(arg0), OT00)
	Store(ObjectType(arg1), OT01)
	Store(ObjectType(arg2), OT02)
	Store(ObjectType(arg3), OT03)
	Store(ObjectType(arg4), OT04)
	Store(ObjectType(arg5), OT05)
	Store(ObjectType(arg6), OT06)

	// Operation

	Store(ObjectType(arg6), OT06)
	if (LEqual(OT06, 4)) {
		Store(DeRefOf(Index(arg6, 0)), Local6)
		Store(1, pk06)
	} else {
		Store(arg6, Local6)
	}

	Store(arg0, Local0)
	Store(arg1, Local1)
	Store(arg2, Local2)
	Store(arg3, Local3)
	Store(arg4, Local4)
	Store(arg5, Local5)
//	Store(arg6, Local6)
	Store(arg6, Local7)

	Name(OT10, 0)
	Name(OT11, 0)
	Name(OT12, 0)
	Name(OT13, 0)
	Name(OT14, 0)
	Name(OT15, 0)
	Name(OT16, 0)

	Store(ObjectType(Local0), OT10)
	Store(ObjectType(Local1), OT11)
	Store(ObjectType(Local2), OT12)
	Store(ObjectType(Local3), OT13)
	Store(ObjectType(Local4), OT14)
	Store(ObjectType(Local5), OT15)
	Store(ObjectType(Local6), OT16)

	Store(m480(Local0, Local1, Local2, Local3, Local4, Local5, Local6), Local7)

	// Types of ArgX are save

	Store(ObjectType(arg0), tmp0)
	if (LNotEqual(tmp0, OT00)) {
		err(ts, z082, 27, 0, 0, tmp0, OT00)
	}
	Store(ObjectType(arg1), tmp0)
	if (LNotEqual(tmp0, OT01)) {
		err(ts, z082, 28, 0, 0, tmp0, OT01)
	}
	Store(ObjectType(arg2), tmp0)
	if (LNotEqual(tmp0, OT02)) {
		err(ts, z082, 29, 0, 0, tmp0, OT02)
	}
	Store(ObjectType(arg3), tmp0)
	if (LNotEqual(tmp0, OT03)) {
		err(ts, z082, 30, 0, 0, tmp0, OT03)
	}
	Store(ObjectType(arg4), tmp0)
	if (LNotEqual(tmp0, OT04)) {
		err(ts, z082, 31, 0, 0, tmp0, OT04)
	}
	Store(ObjectType(arg5), tmp0)
	if (LNotEqual(tmp0, OT05)) {
		err(ts, z082, 32, 0, 0, tmp0, OT05)
	}
	Store(ObjectType(arg6), tmp0)
	if (LNotEqual(tmp0, OT06)) {
		err(ts, z082, 33, 0, 0, tmp0, OT06)
	}

	// Types of LocalX are save, and data of LocalX and ArgX are identical

	Store(ObjectType(Local0), tmp0)
	if (LNotEqual(tmp0, OT10)) {
		err(ts, z082, 34, 0, 0, tmp0, OT10)
	} else {
		m481(ts, 35, tmp0, Local0, arg0)
	}
	Store(ObjectType(Local1), tmp0)
	if (LNotEqual(tmp0, OT11)) {
		err(ts, z082, 36, 0, 0, tmp0, OT11)
	} else {
		m481(ts, 37, tmp0, Local1, arg1)
	}
	Store(ObjectType(Local2), tmp0)
	if (LNotEqual(tmp0, OT12)) {
		err(ts, z082, 38, 0, 0, tmp0, OT12)
	} else {
		m481(ts, 39, tmp0, Local2, arg2)
	}
	Store(ObjectType(Local3), tmp0)
	if (LNotEqual(tmp0, OT13)) {
		err(ts, z082, 40, 0, 0, tmp0, OT13)
	} else {
		m481(ts, 41, tmp0, Local3, arg3)
	}
	Store(ObjectType(Local4), tmp0)
	if (LNotEqual(tmp0, OT14)) {
		err(ts, z082, 42, 0, 0, tmp0, OT14)
	} else {
		m481(ts, 43, tmp0, Local4, arg4)
	}
	Store(ObjectType(Local5), tmp0)
	if (LNotEqual(tmp0, OT15)) {
		err(ts, z082, 44, 0, 0, tmp0, OT15)
	} else {
		m481(ts, 45, tmp0, Local5, arg5)
	}

	Store(ObjectType(Local6), tmp0)
	if (LNotEqual(tmp0, OT16)) {
		err(ts, z082, 46, 0, 0, tmp0, OT16)
	} else {
		// Package is passed by arg6
		// m481(ts, 47, tmp0, Local6, arg6)
	}

	if (pk06) {

// SEE: either to remove this ability???????????????????

	// Presence of result
	Store(DeRefOf(Index(arg6, 1)), Local0)

	if (Local0) {

		// Type of result
		Store(DeRefOf(Index(arg6, 2)), Local0)

		// Result
		Store(DeRefOf(Index(arg6, 3)), Local1)

		Store(ObjectType(Local7), Local2)

		Store(0, Local3)

		if (LNotEqual(Local2, Local0)) {
			err(ts, z082, 48, 0, 0, 0, 0)
			Store("Expected type of result:", Debug)
			Store(Local0, Debug)
			Store("The type of obtained result:", Debug)
			Store(Local2, Debug)
			Store(1, Local3)
		} elseif (LNotEqual(Local7, Local1)) {
			err(ts, z082, 49, 0, 0, 0, 0)
			Store(1, Local3)
		}
		if (Local3) {
			Store("Expected result:", Debug)
			Store(Local1, Debug)
			Store("Actual result:", Debug)
			Store(Local7, Debug)
		}
	}
	}

	Return(Local7)
}
