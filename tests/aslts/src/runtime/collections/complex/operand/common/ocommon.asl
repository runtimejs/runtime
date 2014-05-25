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
 * Implicit Source Operand Conversion, complex test
 *
 *
 * Integer to String implicit conversion Cases.
 * There are following cases when this type of conversion is applied:
 * - to the Integer second operand of Logical operators when the first
 *   operand is evaluated as String (LEqual, LGreater, LGreaterEqual,
 *   LLess, LLessEqual, LNotEqual)
 * - to the Integer second operand of Concatenate operator when the first
 *   operand is evaluated as String
 * - to the Integer elements of a search package of Match operator
 *   when some MatchObject is evaluated as String
 * - to the Integer value of Expression of Case statement when
 *   Expression in Switch is either static String data or explicitly
 *   converted to String by ToDecimalString, ToHexString or ToString
 *
 * Integer to Buffer implicit conversion Cases.
 * There are following cases when this type of conversion is applied:
 * - to the Integer second operand of Logical operators when the first
 *   operand is evaluated as Buffer (LEqual, LGreater, LGreaterEqual,
 *   LLess, LLessEqual, LNotEqual)
 * - to both Integer operands of Concatenate operator
 * - to the Integer second operand of Concatenate operator when the first
 *   operand is evaluated as Buffer
 * - to the Integer Source operand of ToString operator
 * - to the Integer Source operand of Mid operator
 * - to the Integer elements of a search package of Match operator
 *   when some MatchObject is evaluated as Buffer
 * - to the Integer value of Expression of Case statement when
 *   Expression in Switch is either static Buffer data or explicitly
 *   converted to Buffer by ToBuffer
 *
 * String to Integer implicit conversion Cases.
 * There are following cases when this type of conversion is applied:
 * - to the String sole operand of the 1-parameter Integer arithmetic
 *   operators (Decrement, Increment, FindSetLeftBit, FindSetRightBit, Not)
 * - to the String sole operand of the LNot Logical Integer operator
 * - to the String sole operand of the FromBCD and ToBCD conversion operators
 * - to each String operand of the 2-parameter Integer arithmetic
 *   operators (Add, And, Divide, Mod, Multiply, NAnd, NOr, Or,
 *   ShiftLeft, ShiftRight, Subtract, Xor)
 * - to each String operand of the 2-parameter Logical Integer
 *   operators LAnd and LOr
 * - to the String second operand of Logical operators when the first
 *   operand is evaluated as Integer (LEqual, LGreater, LGreaterEqual,
 *   LLess, LLessEqual, LNotEqual)
 * - intermediately to the String second operand of Concatenate operator
 *   in case the first one is Integer
 * - to the String Length (second) operand of ToString operator
 * - to the String Index (second) operand of Index operator
 * - to the String Arg (third) operand of Fatal operator
 *   (it can only be checked an exception does not occur)
 * - to the String Index and Length operands of Mid operator
 * - to the String StartIndex operand of Match operator
 * - to the String elements of a search package of Match operator
 *   when some MatchObject is evaluated as Integer
 * - to the String sole operand of the Method execution control operators
 *   (Sleep, Stall)
 * - to the String TimeoutValue (second) operand of the Acquire operator ???
 * - to the String TimeoutValue (second) operand of the Wait operator
 * - to the String value of Predicate of the Method execution control
 *   statements (If, ElseIf, While)
 * - to the String value of Expression of Case statement when
 *   Expression in Switch is evaluated as Integer
 *
 * String to Buffer implicit conversion Cases.
 * There are following cases when this type of conversion is applied:
 * - to the String second operand of Logical operators when the first
 *   operand is evaluated as Buffer (LEqual, LGreater, LGreaterEqual,
 *   LLess, LLessEqual, LNotEqual)
 * - to the String second operand of Concatenate operator when the first
 *   operand is evaluated as Buffer
 * - to the String Source operand of ToString operator (has a visual
 *   effect in shortening of the String taken the null character.
 * - to the String elements of a search package of Match operator
 *   when some MatchObject is evaluated as Buffer
 * - to the String value of Expression of Case statement when
 *   Expression in Switch is either static Buffer data or explicitly
 *   converted to Buffer by ToBuffer
 *
 * Buffer to Integer implicit conversion Cases.
 * There are following cases when this type of conversion is applied:
 * - to the Buffer sole operand of the 1-parameter Integer arithmetic
 *   operators (Decrement, Increment, FindSetLeftBit, FindSetRightBit, Not)
 * - to the Buffer sole operand of the LNot Logical Integer operator
 * - to the Buffer sole operand of the FromBCD and ToBCD conversion operators
 * - to each Buffer operand of the 2-parameter Integer arithmetic
 *   operators (Add, And, Divide, Mod, Multiply, NAnd, NOr, Or,
 *   ShiftLeft, ShiftRight, Subtract, Xor)
 * - to each Buffer operand of the 2-parameter Logical Integer
 *   operators LAnd and LOr
 * - to the Buffer second operand of Logical operators when the first
 *   operand is evaluated as Integer (LEqual, LGreater, LGreaterEqual,
 *   LLess, LLessEqual, LNotEqual)
 * - intermediately to the Buffer second operand of Concatenate operator
 *   in case the first one is Integer
 * - to the Buffer Length (second) operand of ToString operator
 * - to the Buffer Index (second) operand of Index operator
 * - to the Buffer Arg (third) operand of Fatal operator
 *   (it can only be checked an exception does not occur)
 * - to the Buffer Index and Length operands of Mid operator
 * - to the Buffer StartIndex operand of Match operator
 * - to the Buffer elements of a search package of Match operator
 *   when some MatchObject is evaluated as Integer
 * - to the Buffer sole operand of the Method execution control operators
 *   (Sleep, Stall)
 * - to the Buffer TimeoutValue (second) operand of the Acquire operator ???
 * - to the Buffer TimeoutValue (second) operand of the Wait operator
 * - to the Buffer value of Predicate of the Method execution control
 *   statements (If, ElseIf, While)
 * - to the Buffer value of Expression of Case statement when
 *   Expression in Switch is evaluated as Integer
 *
 * Buffer to String implicit conversion Cases.
 * There are following cases when this type of conversion is applied:
 * - to the Buffer second operand of Logical operators when the first
 *   operand is evaluated as String (LEqual, LGreater, LGreaterEqual,
 *   LLess, LLessEqual, LNotEqual)
 * - to the Buffer second operand of Concatenate operator when the first
 *   operand is evaluated as String
 * - to the Buffer elements of a search package of Match operator
 *   when some MatchObject is evaluated as String
 * - to the Buffer value of Expression of Case statement when
 *   Expression in Switch is either static String data or explicitly
 *   converted to String by ToDecimalString, ToHexString or ToString
 *
 * Note 1: Only an expression that is evaluated to a constant
 *         can be used as the Expression of Case
 *
 * Note 2: So as initial elements of a package are either constant
 *         data or name strings then check of implicit conversion
 *         applied to the elements of the search package of Match
 *         operator is limited to a data images case.
 *
 * Buffer field to Integer implicit conversion Cases.
 * First, Buffer field is evaluated either as Integer or as Buffer.
 * Conversion only takes place for Buffer in which case
 * Buffer to Integer test constructions should be used.
 *
 * Buffer field to Buffer implicit conversion Cases.
 * First, Buffer field is evaluated either as Integer or as Buffer.
 * Conversion only takes place for Integer in which case
 * Integer to Buffer test constructions should be used.
 *
 * Buffer field to String implicit conversion Cases.
 * First, Buffer field is evaluated either as Integer or as Buffer
 * For Integer case Integer to String test constructions should be used.
 * For Buffer case Buffer to String test constructions should be used.
 *
 * Field unit implicit conversion is considered similar to
 * Buffer field one.
 *
 *
 * Cases when there are more than one operand for implicit conversion
 * - when the  first operand of Concatenate operator is Integer,
 *   there are additional conversions besides this Integer to Buffer:
 *    = String to Integer conversion if second operand is String
 *    = Buffer to Integer conversion if second operand is Buffer
 *    = Integer to Buffer conversion of the converted second operand
 *
 *
 * EXCEPTIONAL Conditions during implicit conversion
 *
 * String to Integer implicit conversion Cases.
 *
 * Buffer to String implicit conversion Cases.
 *
 * Buffer field to String implicit conversion Cases.
 *
 * Field unit to String implicit conversion Cases.
 *
 */

Name(z084, 84)

Name(terr, "Test error")

// Test Data by types

// Test Integers

Name(i601, 0321)
Name(i602, 9876543210)
Name(i603, 0xc179b3fe)
Name(i604, 0xfe7cb391d650a284)
Name(i605, 0)
Name(i606, 0xffffffff)
Name(i607, 0xffffffffffffffff)
Name(i608, 0xabcdef)
Name(i609, 0xABCDEF)
Name(i60a, 0xff)
Name(i60b, 0xffffffffff)
Name(i60c, 0x6179534e)
Name(i60d, 0x6e7c534136502214)
Name(i60e, 0x6e00534136002214)
Name(i60f, 0x6e7c534136002214)

Name(pi60, Package() {
	1,
	0321,
	9876543210,
	0xc179b3fe,
	0xfe7cb391d650a284,
	0,
	0xffffffff,
	0xffffffffffffffff,
	0xabcdef,
	0xABCDEF,
	0xff,
	0xffffffffff,
	0x6179534e,
	0x6e7c534136502214,
	0x6e00534136002214,
	0x6e7c534136002214,
})

// Test Strings

Name(s600, "0")
Name(s601, "0321")
Name(s602, "321")
Name(s603, "ba9876")
Name(s604, "C179B3FE")
Name(s605, "FE7CB391D650A284")
Name(s606, "ffffffff")
Name(s607, "ffffffffffffffff")
Name(s608, "fe7cb391d650a2841")
Name(s609, "9876543210")
Name(s60a, "0xfe7cb3")
Name(s60b, "1234q")
Name(s60c, "")
Name(s60d, " ")
// of size 200 chars
Name(s60e, "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*")
// all symbols 0x01-0x7f
Name(s60f, "\x01\x02\x03\x04\x05\x06\a\b\t\n\v\f\r\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\x7f")
Name(s610, "abcdef")
Name(s611, "ABCDEF")
Name(s612, "ff")
Name(s613, "ffffffffff")
Name(s614, "B")
Name(s615, "3789012345678901")
Name(s616, "D76162EE9EC35")
Name(s617, "90123456")
Name(s618, "55F2CC0")
Name(s619, "c179B3FE")
Name(s61a, "fE7CB391D650A284")
Name(s61b, "63")

Name(ps60, Package() {
	"0",
	"0321",
	"321",
	"ba9876",
	"C179B3FE",
	"FE7CB391D650A284",
	"ffffffff",
	"ffffffffffffffff",
	"fe7cb391d650a2841",
	"9876543210",
	"0xfe7cb3",
	"1234q",
	"",
	" ",
	// of size 200 chars
	"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*",
	// all symbols 0x01-0x7f
	"\x01\x02\x03\x04\x05\x06\a\b\t\n\v\f\r\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\x7f",
	"abcdef",
	"ABCDEF",
	"ff",
	"ffffffffff",
	"B",
	"3789012345678901",
	"D76162EE9EC35",
	"90123456",
	"55F2CC0",
	"c179B3FE",
	"fE7CB391D650A284",
	"63",
})

// Test Buffers

Name(b600, Buffer(1){0x00})
Name(b601, Buffer(1){0xa5})
Name(b602, Buffer(2){0x21, 0x03})
Name(b603, Buffer() {0x21, 0x03, 0x5a})
Name(b604, Buffer(2){0x21, 0x03, 0x5a})
Name(b605, Buffer(3){0x21, 0x03})
Name(b606, Buffer(3){0x21, 0x03, 0x00})
Name(b607, Buffer(4){0xFE, 0xB3, 0x79, 0xC1})
Name(b608, Buffer(5){0xFE, 0xB3, 0x79, 0xC1, 0xa5})
Name(b609, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
Name(b60a, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
Name(b60b, Buffer(257){0x00})
Name(b60c, Buffer(67){
	0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
	0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
	0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
	0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
	0x61,0x62,0x63,})
Name(b60d, Buffer(68){
	0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
	0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
	0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
	0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
	0x61,0x62,0x63,0x00,})
Name(b60e, Buffer(1){0xb})
Name(b60f, Buffer() {0x01, 0x89, 0x67, 0x45, 0x23, 0x01, 0x89, 0x37})
Name(b610, Buffer() {0x35, 0xec, 0xe9, 0x2e, 0x16, 0x76, 0x0d})
Name(b611, Buffer() {0x56, 0x34, 0x12, 0x90})
Name(b612, Buffer() {0xc0, 0x2c, 0x5f, 0x05})
Name(b613, Buffer(1){0x3f})

Name(pb60, Package() {
	Buffer() {0x00},
	Buffer(1){0xa5},
	Buffer(2){0x21, 0x03},
	Buffer() {0x21, 0x03, 0x5a},
	Buffer(2){0x21, 0x03, 0x5a},
	Buffer(3){0x21, 0x03},
	Buffer(3){0x21, 0x03, 0x00},
	Buffer(4){0xFE, 0xB3, 0x79, 0xC1},
	Buffer(5){0xFE, 0xB3, 0x79, 0xC1, 0xa5},
	Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE},
	Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5},
	Buffer(257){0x00},
	Buffer(67){
		0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
		0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
		0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
		0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
		0x61,0x62,0x63,},
	Buffer(68){
		0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
		0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
		0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
		0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
		0x61,0x62,0x63,0x00,},
	Buffer(1){0xb},
	Buffer() {0x01, 0x89, 0x67, 0x45, 0x23, 0x01, 0x89, 0x37},
	Buffer() {0x35, 0xec, 0xe9, 0x2e, 0x16, 0x76, 0x0d},
	Buffer() {0x56, 0x34, 0x12, 0x90},
	Buffer() {0xc0, 0x2c, 0x5f, 0x05},
	Buffer(1){0x3f},
})

// Test Buffer Fields

//Name(b630, Buffer(428){})
Name(b630, Buffer(452){})

CreateField(b630,   0, 31, bf61)
CreateField(b630,  31, 32, bf62)
CreateField(b630,  63, 33, bf63)
CreateField(b630,  96, 63, bf64)
CreateField(b630, 159, 64, bf65)
CreateField(b630, 223, 65, bf66)
CreateField(b630, 288, 536, bf69)
CreateField(b630, 824, 544, bf6a)
CreateField(b630, 1368, 2056, bf6b)
// 3424
CreateField(b630, 3424, 31, bf91)
CreateField(b630, 3455, 64, bf95)
CreateField(b630, 3519, 31, bfa1)
CreateField(b630, 3550, 64, bfa5)
// 3614

Name(b631, Buffer(69){})

CreateField(b631, 0, 65, bf6c)
CreateField(b631, 65, 65, bf6d)
CreateField(b631, 130, 33, bf6e)
CreateField(b631, 163, 33, bf6f)
CreateField(b631, 196, 32, bf70)
CreateField(b631, 228, 64, bf71)
CreateField(b631, 292, 64, bf72)
CreateField(b631, 356, 64, bf73)
CreateField(b631, 420, 33, bf74)
CreateField(b631, 453, 33, bf75)
CreateField(b631, 486, 33, bf76)
CreateField(b631, 519, 32, bf77)
// 551

// Test Packages

Name(p601, Package(){0xc179b3fe})
Name(p602, Package(){0xfe7cb391d650a284})


// Auxiliary agents triggering implicit conversion

// Auxiliary Integers

Name(aui0, Ones)
Name(aui1, 0x321)
Name(aui2, 9876543210)
Name(aui3, 0xc179b3fe)
Name(aui4, 0xfe7cb391d650a284)
Name(aui5, 0)
Name(aui6, 1)
Name(aui7, 3)
Name(aui8, 4)
Name(aui9, 5)
Name(auia, 8)
Name(auib, 9)
Name(auic, 0xc179b3ff)
Name(auid, 0xfe7cb391d650a285)
Name(auie, 0xc179b3fd)
Name(auif, 0xfe7cb391d650a283)
Name(auig, 0x322)
Name(auih, 0x320)
Name(auii, 0xffffffff)
Name(auij, 0xffffffffffffffff)
Name(auik, 0xd650a284)
Name(auil, 0xd650a285)
Name(auim, 0xd650a283)

Name(paui, Package() {
	Ones,
	0x321,
	9876543210,
	0xc179b3fe,
	0xfe7cb391d650a284,
	0,
	1,
	3,
	4,
	5,
	8,
	9,
	0xc179b3ff,
	0xfe7cb391d650a285,
	0xc179b3fd,
	0xfe7cb391d650a283,
	0x322,
	0x320,
	0xffffffff,
	0xffffffffffffffff,
	0xd650a284,
	0xd650a285,
	0xd650a283,
})

// Auxiliary Strings

Name(aus0, "")
Name(aus1, "1234q")
Name(aus2, "c179B3FE")
Name(aus3, "C179B3FE")
Name(aus4, "FE7CB391D650A284")
Name(aus5, "fE7CB391D650A284")
Name(aus6, "This is auxiliary String")
Name(aus7, "0321")
Name(aus8, "321")
Name(aus9, "21 03 00")
Name(ausa, "21 03 01")
Name(ausb, "21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63")
Name(ausc, "21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64")

Name(paus, Package() {
	"",
	"1234q",
	"c179B3FE",
	"C179B3FE",
	"FE7CB391D650A284",
	"fE7CB391D650A284",
	"This is auxiliary String",
	"0321",
	"321",
	"21 03 00",
	"21 03 01",
	"21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63",
	"21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 64",
})


// Auxiliary Buffers

Name(aub0, Buffer(){0x5a})
Name(aub1, Buffer(){0x5a, 0x00})
Name(aub2, Buffer() {0xFE, 0xB3, 0x79, 0xC2})
Name(aub3, Buffer() {0xFE, 0xB3, 0x79, 0xC1})
Name(aub4, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
Name(aub5, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF})
Name(aub6, Buffer() {"This is auxiliary Buffer"})
Name(aub7, Buffer() {0x30, 0x33, 0x32, 0x31, 0x00})
Name(aub8, Buffer() {0x30, 0x33, 0x32, 0x31, 0x01})
Name(aub9, Buffer(){0x00})
Name(auba, Buffer(){0x01})
Name(aubb, Buffer(){
	0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
	0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
	0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
	0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
	0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
	0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
	0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
	0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
	0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
	0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
	0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
	0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
	0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x00,})
Name(aubc, Buffer(){
	0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
	0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
	0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
	0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
	0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
	0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
	0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
	0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
	0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
	0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
	0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
	0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
	0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x01,})

Name(paub, Package() {
	Buffer(){0x5a},
	Buffer(){0x5a, 0x00},
	Buffer() {0xFE, 0xB3, 0x79, 0xC2},
	Buffer() {0xFE, 0xB3, 0x79, 0xC1},
	Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE},
	Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF},
	Buffer() {"This is auxiliary Buffer"},
	Buffer() {0x30, 0x33, 0x32, 0x31, 0x00},
	Buffer() {0x30, 0x33, 0x32, 0x31, 0x01},
	Buffer(){0x00},
	Buffer(){0x01},
	Buffer(){
		0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
		0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
		0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
		0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
		0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
		0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
		0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
		0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
		0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
		0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
		0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
		0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
		0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x00,},
	Buffer(){
		0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
		0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
		0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
		0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
		0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
		0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
		0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
		0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
		0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
		0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
		0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
		0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
		0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x01,},
})

// Auxiliary Packages

Name(aup0, Package(){
	0xa50, 0xa51, 0xa52, 0xa53, 0xa54, 0xa55, 0xa56, 0xa57,
	0xa58, 0xa59, 0xa5a, 0xa5b, 0xa5c, 0xa5d, 0xa5e,})
Name(aup1, Package(){0xfe7cb391d650a284})
Name(aup2, Package(){0xc179b3fe})

Name(paup, Package() {
	Package(){
		0xa50, 0xa51, 0xa52, 0xa53, 0xa54, 0xa55, 0xa56, 0xa57,
		0xa58, 0xa59, 0xa5a, 0xa5b, 0xa5c, 0xa5d, 0xa5e,},
	Package(){0xfe7cb391d650a284},
	Package(){0xc179b3fe},
})


// Benchmark Data

// Benchmark Integer Values in case conversion
// Derefof(Index(..., String->Integer))

Name(bi10, 0x69)
Name(bi11, 0xa5b)

// Benchmark Integer Values in case conversion
// Decrement/Increment(String/Buffer->Integer))

Name(bi12, 0x320)
Name(bi13, 0x321)
Name(bi14, 0xc179b3fd)
Name(bi15, 0xc179b3fe)
Name(bi16, 0xfe7cb391d650a283)
Name(bi17, 0xfe7cb391d650a284)
Name(bi18, 0xd650a283)
Name(bi19, 0xd650a284)
Name(bi23, 0x322)
Name(bi27, 0xfe7cb391d650a285)
Name(bi29, 0xd650a285)

// Benchmark Strings in case conversion
// Concatenate(String, Integer->String)

Name(bs10, "FE7CB391D650A284")
Name(bs11, "1234qFE7CB391D650A284")
Name(bs12, "C179B3FE")
Name(bs13, "1234qC179B3FE")
Name(bs14, "D650A284")
Name(bs15, "1234qD650A284")

// Benchmark Strings in case conversion
// ToString(Integer->Buffer, ...)

Name(bs16, "\x4e\x53\x79\x61")
Name(bs17, "\x4e\x53\x79")
Name(bs18, "\x14\x22\x50\x36\x41\x53\x7C\x6E")
Name(bs19, "\x14\x22\x50")
Name(bs1a, "\x14\x22")

// Benchmark Strings in case conversion
// ToString(..., String->Integer)

Name(bs1b, "This is aux")
Name(bs1c, "This is auxiliary Buffer")

// Benchmark Strings in case conversion
// Mid(String, String->Integer, Integer)

Name(bs1d, "iliary Str")
Name(bs1e, "This is auxiliary String")
Name(bs1f, "iliary String")

// Benchmark Strings in case conversion
// ToString(String->Buffer, ...)

Name(bs20, "0321")
Name(bs21, "032")
Name(bs22, "")
Name(bs23, "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*")
Name(bs24, "!\"#")

// Benchmark Strings in case conversion
// Concatenate(String, Buffer->String)

Name(bs25, "21 03 00")
Name(bs26, "1234q21 03 00")
Name(bs27, "21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E 4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63")


// Benchmark Buffers in case conversion
// Concatenate(Buffer, Integer->Buffer)

Name(bb10, Buffer() {0x5A, 0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
Name(bb11, Buffer() {0x5A, 0x00, 0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
Name(bb12, Buffer() {0x5A, 0xFE, 0xB3, 0x79, 0xC1})
Name(bb13, Buffer() {0x5A, 0x00, 0xFE, 0xB3, 0x79, 0xC1})
Name(bb14, Buffer() {0x5A, 0x84, 0xA2, 0x50, 0xD6})
Name(bb15, Buffer() {0x5A, 0x00, 0x84, 0xA2, 0x50, 0xD6})

Name(bb16, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x5A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00})
Name(bb17, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x5A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00})
Name(bb18, Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x5A, 0x00, 0x00, 0x00})
Name(bb19, Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x5A, 0x00, 0x00, 0x00})
Name(bb1a, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x5A, 0x00, 0x00, 0x00})
Name(bb1b, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x5A, 0x00, 0x00, 0x00})

// Benchmark Integer->Buffer Buffers
// If no buffer object exists, a new buffer
// object is created based on the size of
// the integer (4 bytes for 32-bit integers
// and 8 bytes for 64-bit integers).

Name(bb1c, Buffer() {0xFE, 0xB3, 0x79, 0xC1})
Name(bb1d, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})

// Benchmark Buffers in case conversion
// Mid(Buffer Field->Integer->Buffer, 0, n, ...)
Name(bb1e, Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x01})
Name(bb1f, Buffer() {0x21, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01})

// Benchmark Buffers in case conversion
// Concatenate(Integer->Buffer, Integer->Buffer)

Name(bb20, Buffer() {
	0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE,
	0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
Name(bb21, Buffer() {
	0x21, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
Name(bb22, Buffer() {
	0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE,
	0x21, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00})
Name(bb23, Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0xFE, 0xB3, 0x79, 0xC1})
Name(bb24, Buffer() {0x21, 0x03, 0x00, 0x00, 0xFE, 0xB3, 0x79, 0xC1})
Name(bb25, Buffer() {0xFE, 0xB3, 0x79, 0xC1, 0x21, 0x03, 0x00, 0x00})

// Benchmark Buffers in case conversion
// Concatenate(Integer->Buffer, String->Integer->Buffer)
// Concatenate(Integer->Buffer, Buffer->Integer->Buffer)

Name(bb26, Buffer() {
	0x21, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x21, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00})
Name(bb27, Buffer() {
	0x21, 0x03, 0x00, 0x00,
	0x21, 0x03, 0x00, 0x00})
Name(bb28, Buffer() {0x21, 0x03, 0x00, 0x00, 0x84, 0xA2, 0x50, 0xD6})

// Benchmark Buffers in case conversion
// Concatenate(Buffer, String->Buffer)

Name(bb29, Buffer() {0x5A, 0x30, 0x33, 0x32, 0x31, 0x00})
Name(bb2a, Buffer() {0x5A, 0x00, 0x30, 0x33, 0x32, 0x31, 0x00})
Name(bb2b, Buffer() {0x5A, 0x00})
Name(bb2c, Buffer() {0x5A, 0x00, 0x00})
Name(bb2d, Buffer(){
	0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
	0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
	0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
	0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
	0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,
	0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,
	0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,
	0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,0x41,
	0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,
	0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,0x61,
	0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x70,0x71,
	0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x20,0x21,0x22,
	0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x00,})

// Benchmark Buffers in case conversion
// Mid(Integer->Buffer, 1, n, ...)

Name(bb30, Buffer() {0x22, 0x00, 0x36, 0x41, 0x53, 0x7C, 0x6E})
Name(bb31, Buffer() {0x22, 0x00, 0x36})

// Benchmark Buffers in case conversion
// Mid(Buffer, String->Integer, Integer)

Name(bb32, Buffer() {0x69, 0x6C, 0x69, 0x61, 0x72, 0x79, 0x20, 0x42, 0x75, 0x66})
Name(bb33, Buffer() {0x54, 0x68, 0x69, 0x73, 0x20, 0x69, 0x73, 0x20, 0x61, 0x75, 0x78})
Name(bb34, Buffer() {"This is auxiliary Buffer"})
Name(bb35, Buffer() {"iliary Buffer"})

// Check Result of operation on equal to Benchmark value
// m600(<method name>,
//	<internal type of error if it occurs>,
//	<Result>,
//	<Benchmark value>)
Method(m600, 4)
{
	Store(ObjectType(arg2), Local0)
	Store(ObjectType(arg3), Local1)
	if (LNotEqual(Local0, Local1)) {
		err(Concatenate(arg0, "-OType"), z084, arg1, 0, 0, Local0, Local1)
	} elseif (LNotEqual(arg2, arg3)) {
		err(arg0, z084, arg1, 0, 0, arg2, arg3)
	}
}

// Obtain specified Constant Auxiliary Object
// as result of a Method invocation (by Return)
// m601(<type>,
//	<opcode>)
Method(m601, 2, Serialized)
{
	Switch(ToInteger (arg0)) {
		Case(1) {	// Integer
			Switch(ToInteger (arg1)) {
				Case(0) {
					Store(0, Local0)
					Return (Ones)
				}
				Case(1) {
					Return (0x321)
				}
				Case(2) {
					Return (9876543210)
				}
				Case(3) {
					Return (0xc179b3fe)
				}
				Case(4) {
					Return (0xfe7cb391d650a284)
				}
				Case(5) {
					Return (0)
				}
				Case(6) {
					Return (1)
				}
				Case(7) {
					Return (3)
				}
				Case(8) {
					Return (4)
				}
				Case(9) {
					Return (5)
				}
				Case(10) {
					Return (8)
				}
				Case(11) {
					Return (9)
				}
				Case(12) {
					Return (0xc179b3ff)
				}
				Case(13) {
					Return (0xfe7cb391d650a285)
				}
				Case(14) {
					Return (0xc179b3fd)
				}
				Case(15) {
					Return (0xfe7cb391d650a283)
				}
				Case(16) {
					Return (0x322)
				}
				Case(17) {
					Return (0x320)
				}
				Case(18) {
					Return (0xffffffff)
				}
				Case(19) {
					Return (0xffffffffffffffff)
				}
				Case(20) {
					Return (0xd650a284)
				}
				Case(21) {
					Return (0xd650a285)
				}
				Case(22) {
					Return (0xd650a283)
				}
				Default {
					err(terr, z084, 11, 0, 0, arg0, arg1)
				}
			}
		}
		Case(2) {	// String
			Switch(ToInteger (arg1)) {
				Case(0) {
					Return ("")
				}
				Case(1) {
					Return ("1234q")
				}
				Case(2) {
					Return ("c179B3FE")
				}
				Case(3) {
					Return ("C179B3FE")
				}
				Case(4) {
					Return ("FE7CB391D650A284")
				}
				Case(5) {
					Return ("fE7CB391D650A284")
				}
				Case(6) {
					Return ("This is auxiliary String")
				}
				Case(7) {
					Return ("0321")
				}
				Case(8) {
					Return ("321")
				}
				Case(9) {
					Return ("21 03 00")
				}
				Case(10) {
					Return ("21 03 01")
				}
				Default {
					err(terr, z084, 12, 0, 0, arg0, arg1)
				}
			}
		}
		Case(3) {	// Buffer
			Switch(ToInteger (arg1)) {
				Case(0) {
					Return (Buffer(){0x5a})
				}
				Case(1) {
					Return (Buffer(){0x5a, 0x00})
				}
				Case(2) {
					Return (Buffer() {0xFE, 0xB3, 0x79, 0xC2})
				}
				Case(3) {
					Return (Buffer() {0xFE, 0xB3, 0x79, 0xC1})
				}
				Case(4) {
					Return (Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {
					Return (Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFF})
				}
				Case(6) {
					Return (Buffer() {"This is auxiliary Buffer"})
				}
				Case(7) {
					Return (Buffer() {0x30, 0x33, 0x32, 0x31, 0x00})
				}
				Case(8) {
					Return (Buffer() {0x30, 0x33, 0x32, 0x31, 0x01})
				}
				Default {
					err(terr, z084, 13, 0, 0, arg0, arg1)
				}
			}
		}
		Case(4) {	// Package
			Switch(ToInteger (arg1)) {
				Case(0) {
					Return (Package(){
						0xa50, 0xa51, 0xa52, 0xa53, 0xa54, 0xa55, 0xa56, 0xa57,
						0xa58, 0xa59, 0xa5a, 0xa5b, 0xa5c, 0xa5d, 0xa5e,})
				}
				Default {
					err(terr, z084, 14, 0, 0, arg0, arg1)
				}
			}
		}
		Default {
			err(terr, z084, 15, 0, 0, arg0, arg1)
		}
	}
	Return(Local0)
}

// Obtain specified Auxiliary Global Named Object
// or reference to it as result of a Method invocation
// (by Return)
// m602(<type>,
//	<opcode>,
//	<ref_key>)
Method(m602, 3, Serialized)
{
	if (LLess(arg2, 3)) {
		Switch(ToInteger (arg0)) {
			Case(1) {	// Integer
				Switch(ToInteger (arg1)) {
					Case(0) {
						if (LEqual(arg2, 0)) {
							Return (aui0)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aui0))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aui0, Local0)
							Return (Local0)
						}
					}
					Case(1) {
						if (LEqual(arg2, 0)) {
							Return (aui1)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aui1))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aui1, Local0)
							Return (Local0)
						}
					}
					Case(2) {
						if (LEqual(arg2, 0)) {
							Return (aui2)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aui2))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aui2, Local0)
							Return (Local0)
						}
					}
					Case(3) {
						if (LEqual(arg2, 0)) {
							Return (aui3)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aui3))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aui3, Local0)
							Return (Local0)
						}
					}
					Case(4) {
						if (LEqual(arg2, 0)) {
							Return (aui4)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aui4))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aui4, Local0)
							Return (Local0)
						}
					}
					Case(5) {
						if (LEqual(arg2, 0)) {
							Return (aui5)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aui5))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aui5, Local0)
							Return (Local0)
						}
					}
					Case(6) {
						if (LEqual(arg2, 0)) {
							Return (aui6)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aui6))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aui6, Local0)
							Return (Local0)
						}
					}
					Case(7) {
						if (LEqual(arg2, 0)) {
							Return (aui7)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aui7))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aui7, Local0)
							Return (Local0)
						}
					}
					Case(8) {
						if (LEqual(arg2, 0)) {
							Return (aui8)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aui8))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aui8, Local0)
							Return (Local0)
						}
					}
					Case(9) {
						if (LEqual(arg2, 0)) {
							Return (aui9)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aui9))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aui9, Local0)
							Return (Local0)
						}
					}
					Case(10) {
						if (LEqual(arg2, 0)) {
							Return (auia)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(auia))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(auia, Local0)
							Return (Local0)
						}
					}
					Case(11) {
						if (LEqual(arg2, 0)) {
							Return (auib)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(auib))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(auib, Local0)
							Return (Local0)
						}
					}
					Case(12) {
						if (LEqual(arg2, 0)) {
							Return (auic)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(auic))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(auic, Local0)
							Return (Local0)
						}
					}
					Case(13) {
						if (LEqual(arg2, 0)) {
							Return (auid)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(auid))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(auid, Local0)
							Return (Local0)
						}
					}
					Case(14) {
						if (LEqual(arg2, 0)) {
							Return (auie)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(auie))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(auie, Local0)
							Return (Local0)
						}
					}
					Case(15) {
						if (LEqual(arg2, 0)) {
							Return (auif)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(auif))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(auif, Local0)
							Return (Local0)
						}
					}
					Case(16) {
						if (LEqual(arg2, 0)) {
							Return (auig)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(auig))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(auig, Local0)
							Return (Local0)
						}
					}
					Case(17) {
						if (LEqual(arg2, 0)) {
							Return (auih)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(auih))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(auih, Local0)
							Return (Local0)
						}
					}
					Case(18) {
						if (LEqual(arg2, 0)) {
							Return (auii)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(auii))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(auii, Local0)
							Return (Local0)
						}
					}
					Case(19) {
						if (LEqual(arg2, 0)) {
							Return (auij)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(auij))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(auij, Local0)
							Return (Local0)
						}
					}
					Case(20) {
						if (LEqual(arg2, 0)) {
							Return (auik)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(auik))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(auik, Local0)
							Return (Local0)
						}
					}
					Case(21) {
						if (LEqual(arg2, 0)) {
							Return (auil)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(auil))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(auil, Local0)
							Return (Local0)
						}
					}
					Case(22) {
						if (LEqual(arg2, 0)) {
							Return (auim)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(auim))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(auim, Local0)
							Return (Local0)
						}
					}
					Default {
						err(terr, z084, 16, 0, 0, arg0, arg1)
					}
				}
			}
			Case(2) {	// String
				Switch(ToInteger (arg1)) {
					Case(0) {
						if (LEqual(arg2, 0)) {
							Return (aus0)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aus0))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aus0, Local0)
							Return (Local0)
						}
					}
					Case(1) {
						if (LEqual(arg2, 0)) {
							Return (aus1)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aus1))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aus1, Local0)
							Return (Local0)
						}
					}
					Case(2) {
						if (LEqual(arg2, 0)) {
							Return (aus2)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aus2))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aus2, Local0)
							Return (Local0)
						}
					}
					Case(3) {
						if (LEqual(arg2, 0)) {
							Return (aus3)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aus3))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aus3, Local0)
							Return (Local0)
						}
					}
					Case(4) {
						if (LEqual(arg2, 0)) {
							Return (aus4)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aus4))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aus4, Local0)
							Return (Local0)
						}
					}
					Case(5) {
						if (LEqual(arg2, 0)) {
							Return (aus5)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aus5))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aus5, Local0)
							Return (Local0)
						}
					}
					Case(6) {
						if (LEqual(arg2, 0)) {
							Return (aus6)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aus6))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aus6, Local0)
							Return (Local0)
						}
					}
					Case(7) {
						if (LEqual(arg2, 0)) {
							Return (aus7)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aus7))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aus7, Local0)
							Return (Local0)
						}
					}
					Case(8) {
						if (LEqual(arg2, 0)) {
							Return (aus8)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aus8))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aus8, Local0)
							Return (Local0)
						}
					}
					Case(9) {
						if (LEqual(arg2, 0)) {
							Return (aus9)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aus9))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aus9, Local0)
							Return (Local0)
						}
					}
					Case(10) {
						if (LEqual(arg2, 0)) {
							Return (ausa)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(ausa))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(ausa, Local0)
							Return (Local0)
						}
					}
					Default {
						err(terr, z084, 17, 0, 0, arg0, arg1)
					}
				}
			}
			Case(3) {	// Buffer
				Switch(ToInteger (arg1)) {
					Case(0) {
						if (LEqual(arg2, 0)) {
							Return (aub0)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aub0))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aub0, Local0)
							Return (Local0)
						}
					}
					Case(1) {
						if (LEqual(arg2, 0)) {
							Return (aub1)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aub1))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aub1, Local0)
							Return (Local0)
						}
					}
					Case(2) {
						if (LEqual(arg2, 0)) {
							Return (aub2)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aub2))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aub2, Local0)
							Return (Local0)
						}
					}
					Case(3) {
						if (LEqual(arg2, 0)) {
							Return (aub3)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aub3))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aub3, Local0)
							Return (Local0)
						}
					}
					Case(4) {
						if (LEqual(arg2, 0)) {
							Return (aub4)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aub4))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aub4, Local0)
							Return (Local0)
						}
					}
					Case(5) {
						if (LEqual(arg2, 0)) {
							Return (aub5)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aub5))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aub5, Local0)
							Return (Local0)
						}
					}
					Case(6) {
						if (LEqual(arg2, 0)) {
							Return (aub6)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aub6))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aub6, Local0)
							Return (Local0)
						}
					}
					Case(7) {
						if (LEqual(arg2, 0)) {
							Return (aub7)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aub7))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aub7, Local0)
							Return (Local0)
						}
					}
					Case(8) {
						if (LEqual(arg2, 0)) {
							Return (aub8)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aub8))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aub8, Local0)
							Return (Local0)
						}
					}
					Default {
						err(terr, z084, 18, 0, 0, arg0, arg1)
					}
				}
			}
			Case(4) {	// Package
				Switch(ToInteger (arg1)) {
					Case(0) {
						if (LEqual(arg2, 0)) {
							Return (aup0)
						} elseif (LEqual(arg2, 1)) {
							Return (Refof(aup0))
						} elseif (LEqual(arg2, 2)) {
							CondRefof(aup0, Local0)
							Return (Local0)
						}
					}
					Default {
						err(terr, z084, 19, 0, 0, arg0, arg1)
					}
				}
			}
			Default {
				err(terr, z084, 20, 0, 0, arg0, arg1)
			}
		}
	} else {
		err(terr, z084, 21, 0, 0, arg1, arg2)
	}
	Return(Local0)
}

// Obtain specified Auxiliary Element of Package
// or reference to it as result of a Method invocation
// (by Return)
// m603(<type>,
//	<opcode>,
//	<ref_key>)
Method(m603, 3, Serialized)
{
	Switch(ToInteger (arg0)) {
		Case(1) {	// Integer
			if (LLess(arg1, 23)) {
				Switch(ToInteger (arg2)) {
					Case(0) {
						Return (Derefof(Index(paui, arg1)))
					}
					Case(1) {
						Return (Index(paui, arg1))
					}
					Case(2) {
						Index(paui, arg1, Local0)
						Return (Local0)
					}
					Default {
						err(terr, z084, 22, 0, 0, arg1, arg2)
					}
				}
			} else {
				err(terr, z084, 23, 0, 0, arg0, arg1)
			}
		}
		Case(2) {	// String
			if (LLess(arg1, 11)) {
				Switch(ToInteger (arg2)) {
					Case(0) {
						Return (Derefof(Index(paus, arg1)))
					}
					Case(1) {
						Return (Index(paus, arg1))
					}
					Case(2) {
						Index(paus, arg1, Local0)
						Return (Local0)
					}
					Default {
						err(terr, z084, 24, 0, 0, arg1, arg2)
					}
				}
			} else {
				err(terr, z084, 25, 0, 0, arg0, arg1)
			}
		}
		Case(3) {	// Buffer
			if (LLess(arg1, 9)) {
				Switch(ToInteger (arg2)) {
					Case(0) {
						Return (Derefof(Index(paub, arg1)))
					}
					Case(1) {
						Return (Index(paub, arg1))
					}
					Case(2) {
						Index(paub, arg1, Local0)
						Return (Local0)
					}
					Default {
						err(terr, z084, 26, 0, 0, arg1, arg2)
					}
				}
			} else {
				err(terr, z084, 27, 0, 0, arg0, arg1)
			}
		}
		Case(4) {	// Package
			if (LLess(arg1, 6)) {
				Switch(ToInteger (arg2)) {
					Case(0) {
						Return (Derefof(Index(paup, arg1)))
					}
					Case(1) {
						Return (Index(paup, arg1))
					}
					Case(2) {
						Index(paup, arg1, Local0)
						Return (Local0)
					}
					Default {
						err(terr, z084, 28, 0, 0, arg1, arg2)
					}
				}
			} else {
				err(terr, z084, 29, 0, 0, arg0, arg1)
			}
		}
		Default {
			err(terr, z084, 30, 0, 0, arg0, arg1)
		}
	}
	Return(Local0)
}

// Obtain specified Test Object or reference to it by Return
// m604(<carrier>
//  <type>,
//	<opcode>,
//	<ref_key>)
Method(m604, 4, Serialized)
{
	Switch(ToInteger (arg0)) {
		Case(0) {	// Constant
			if (arg3) {
				err(terr, z084, 0, 0, 0, arg1, arg2)
			}
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					Switch(ToInteger (arg2)) {
						Case(3) {
							Return (0xc179b3fe)
						}
						Case(4) {
							Return (0xfe7cb391d650a284)
						}
						Case(12) {
							Return (0x6179534e)
						}
						Case(13) {
							Return (0x6e7c534136502214)
						}
						Case(14) {
							Return (0x6e00534136002214)
						}
						Case(15) {
							Return (0x6e7c534136002214)
						}
						Default {
							err(terr, z084, 1, 0, 0, arg1, arg2)
						}
					}
				}
				Case(2) {	// String
					Switch(ToInteger (arg2)) {
						Case(0) {
							Return ("0")
						}
						Case(1) {
							Return ("0321")
						}
						Case(4) {
							Return ("C179B3FE")
						}
						Case(5) {
							Return ("FE7CB391D650A284")
						}
						Case(12) {
							Return ("")
						}
						Case(14) {
							Return ("!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*")
						}
						Case(20) {
							Return ("B")
						}
						Case(21) {
							Return ("3789012345678901")
						}
						Case(22) {
							Return ("D76162EE9EC35")
						}
						Case(23) {
							Return ("90123456")
						}
						Case(24) {
							Return ("55F2CC0")
						}
						Case(27) {
							Return ("63")
						}
						Default {
							err(terr, z084, 1, 0, 0, arg1, arg2)
						}
					}
				}
				Case(3) {	// Buffer
					Switch(ToInteger (arg2)) {
						Case(0) {
							Return (Buffer(1){0x00})
						}
						Case(6) {
							Return (Buffer(3){0x21, 0x03, 0x00})
						}
						Case(10) {
							Return (Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
						}
						Case(12) {
							Return (Buffer(67){
								0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
								0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
								0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
								0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
								0x61,0x62,0x63,})
						}
						Case(14) {
							Return (Buffer(1){0xb})
						}
						Case(15) {
							Return (Buffer() {0x01, 0x89, 0x67, 0x45, 0x23, 0x01, 0x89, 0x37})
						}
						Case(16) {
							Return (Buffer() {0x35, 0xec, 0xe9, 0x2e, 0x16, 0x76, 0x0d})
						}
						Case(17) {
							Return (Buffer() {0x56, 0x34, 0x12, 0x90})
						}
						Case(18) {
							Return (Buffer() {0xc0, 0x2c, 0x5f, 0x05})
						}
						Case(19) {
							Return (Buffer(1){0x3f})
						}
						Default {
							err(terr, z084, 1, 0, 0, arg1, arg2)
						}
					}
				}
				Default {
					err(terr, z084, 2, 0, 0, arg1, arg2)
				}
			}
		}
		Case(1) {	// Global Named Object
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					Switch(ToInteger (arg2)) {
						Case(3) {
							Switch(ToInteger (arg3)) {
								Case(0) {
									Return (i603)
								}
								Case(1) {
									Return (Refof(i603))
								}
								Case(2) {
									CondRefof(i603, Local0)
									Return (Local0)
								}
								Default {
									err(terr, z084, 3, 0, 0, arg2, arg3)
								}
							}
						}
						Case(4) {
							Switch(ToInteger (arg3)) {
								Case(0) {
									Return (i604)
								}
								Case(1) {
									Return (Refof(i604))
								}
								Case(2) {
									CondRefof(i604, Local0)
									Return (Local0)
								}
								Default {
									err(terr, z084, 4, 0, 0, arg2, arg3)
								}
							}
						}
						Default {
							err(terr, z084, 5, 0, 0, arg1, arg2)
						}
					}
				}
				Default {
					err(terr, z084, 6, 0, 0, arg1, arg2)
				}
			}
		}
		Case(2) {	// Element of Package
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					if (LLess(arg2, 16)) {
						Switch(ToInteger (arg3)) {
							Case(0) {
								Return (Derefof(Index(pi60, arg2)))
							}
							Case(1) {
								Return (Index(pi60, arg2))
							}
							Case(2) {
								Index(pi60, arg2, Local0)
								Return (Local0)
							}
							Default {
								err(terr, z084, 7, 0, 0, arg2, arg3)
							}
						}
					} else {
						err(terr, z084, 8, 0, 0, arg1, arg2)
					}
				}
				Case(2) {	// String
					if (LLess(arg2, 28)) {
						Switch(ToInteger (arg3)) {
							Case(0) {
								Return (Derefof(Index(ps60, arg2)))
							}
							Case(1) {
								Return (Index(ps60, arg2))
							}
							Case(2) {
								Index(ps60, arg2, Local0)
								Return (Local0)
							}
							Default {
								err(terr, z084, 7, 0, 0, arg2, arg3)
							}
						}
					} else {
						err(terr, z084, 8, 0, 0, arg1, arg2)
					}
				}
				Case(3) {	// Buffer
					if (LLess(arg2, 20)) {
						Switch(ToInteger (arg3)) {
							Case(0) {
								Return (Derefof(Index(pb60, arg2)))
							}
							Case(1) {
								Return (Index(pb60, arg2))
							}
							Case(2) {
								Index(pb60, arg2, Local0)
								Return (Local0)
							}
							Default {
								err(terr, z084, 7, 0, 0, arg2, arg3)
							}
						}
					} else {
						err(terr, z084, 8, 0, 0, arg1, arg2)
					}
				}
				Default {
					err(terr, z084, 9, 0, 0, arg1, arg2)
				}
			}
		}
		Default {
			err(terr, z084, 10, 0, 0, arg0, arg1)
		}
	}
	Return(Local0)
}

// Check consistency of the test Named Objects
// in the root Scope of the Global ACPI namespace
// m605(<msg>,
//	<type>,
//	<pack_flag>)
Method(m605, 3)
{
	if (LEqual(arg1, 1)) {
		if (arg2) {
			// Test Integers Package
			m600(arg0,  1, Derefof(Index(pi60, 1)), 0321)
			m600(arg0,  2, Derefof(Index(pi60, 2)), 9876543210)
			m600(arg0,  3, Derefof(Index(pi60, 3)), 0xc179b3fe)
			m600(arg0,  4, Derefof(Index(pi60, 4)), 0xfe7cb391d650a284)
			m600(arg0,  5, Derefof(Index(pi60, 5)), 0)
			m600(arg0,  6, Derefof(Index(pi60, 6)), 0xffffffff)
			m600(arg0,  7, Derefof(Index(pi60, 7)), 0xffffffffffffffff)
			m600(arg0,  8, Derefof(Index(pi60, 8)), 0xabcdef)
			m600(arg0,  9, Derefof(Index(pi60, 9)), 0xABCDEF)
			m600(arg0, 10, Derefof(Index(pi60, 10)), 0xff)
			m600(arg0, 11, Derefof(Index(pi60, 11)), 0xffffffffff)
			m600(arg0, 12, Derefof(Index(pi60, 12)), 0x6179534e)
			m600(arg0, 13, Derefof(Index(pi60, 13)), 0x6e7c534136502214)
			m600(arg0, 14, Derefof(Index(pi60, 14)), 0x6e00534136002214)
			m600(arg0, 15, Derefof(Index(pi60, 15)), 0x6e7c534136002214)
		} else {
			// Test Integers
			m600(arg0, 16, i601, 0321)
			m600(arg0, 17, i602, 9876543210)
			m600(arg0, 18, i603, 0xc179b3fe)
			m600(arg0, 19, i604, 0xfe7cb391d650a284)
			m600(arg0, 20, i605, 0)
			m600(arg0, 21, i606, 0xffffffff)
			m600(arg0, 22, i607, 0xffffffffffffffff)
			m600(arg0, 23, i608, 0xabcdef)
			m600(arg0, 24, i609, 0xABCDEF)
			m600(arg0, 25, i60a, 0xff)
			m600(arg0, 26, i60b, 0xffffffffff)
			m600(arg0, 27, i60c, 0x6179534e)
			m600(arg0, 28, i60d, 0x6e7c534136502214)
			m600(arg0, 29, i60e, 0x6e00534136002214)
			m600(arg0, 30, i60f, 0x6e7c534136002214)
		}
	} elseif (LEqual(arg1, 2)) {
		if (arg2) {
			// Test Strings Package
			m600(arg0, 31, Derefof(Index(ps60, 0)), "0")
			m600(arg0, 32, Derefof(Index(ps60, 1)), "0321")
			m600(arg0, 33, Derefof(Index(ps60, 2)), "321")
			m600(arg0, 34, Derefof(Index(ps60, 3)), "ba9876")
			m600(arg0, 35, Derefof(Index(ps60, 4)), "C179B3FE")
			m600(arg0, 36, Derefof(Index(ps60, 5)), "FE7CB391D650A284")
			m600(arg0, 37, Derefof(Index(ps60, 6)), "ffffffff")
			m600(arg0, 38, Derefof(Index(ps60, 7)), "ffffffffffffffff")
			m600(arg0, 39, Derefof(Index(ps60, 8)), "fe7cb391d650a2841")
			m600(arg0, 40, Derefof(Index(ps60, 9)), "9876543210")
			m600(arg0, 41, Derefof(Index(ps60, 10)), "0xfe7cb3")
			m600(arg0, 42, Derefof(Index(ps60, 11)), "1234q")
			m600(arg0, 43, Derefof(Index(ps60, 12)), "")
			m600(arg0, 44, Derefof(Index(ps60, 13)), " ")
			m600(arg0, 45, Derefof(Index(ps60, 14)), "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*")
			m600(arg0, 46, Derefof(Index(ps60, 15)), "\x01\x02\x03\x04\x05\x06\a\b\t\n\v\f\r\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\x7f")
			m600(arg0, 47, Derefof(Index(ps60, 16)), "abcdef")
			m600(arg0, 48, Derefof(Index(ps60, 17)), "ABCDEF")
			m600(arg0, 49, Derefof(Index(ps60, 18)), "ff")
			m600(arg0, 50, Derefof(Index(ps60, 19)), "ffffffffff")
			m600(arg0, 51, Derefof(Index(ps60, 20)), "B")
			m600(arg0, 52, Derefof(Index(ps60, 21)), "3789012345678901")
			m600(arg0, 53, Derefof(Index(ps60, 22)), "D76162EE9EC35")
			m600(arg0, 54, Derefof(Index(ps60, 23)), "90123456")
			m600(arg0, 55, Derefof(Index(ps60, 24)), "55F2CC0")
			m600(arg0, 56, Derefof(Index(ps60, 25)), "c179B3FE")
			m600(arg0, 57, Derefof(Index(ps60, 26)), "fE7CB391D650A284")
			m600(arg0, 58, Derefof(Index(ps60, 27)), "63")
		} else {
			// Test Strings
			m600(arg0, 59, s600, "0")
			m600(arg0, 60, s601, "0321")
			m600(arg0, 61, s602, "321")
			m600(arg0, 62, s603, "ba9876")
			m600(arg0, 63, s604, "C179B3FE")
			m600(arg0, 64, s605, "FE7CB391D650A284")
			m600(arg0, 65, s606, "ffffffff")
			m600(arg0, 66, s607, "ffffffffffffffff")
			m600(arg0, 67, s608, "fe7cb391d650a2841")
			m600(arg0, 68, s609, "9876543210")
			m600(arg0, 69, s60a, "0xfe7cb3")
			m600(arg0, 70, s60b, "1234q")
			m600(arg0, 71, s60c, "")
			m600(arg0, 72, s60d, " ")
			m600(arg0, 73, s60e, "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*")
			m600(arg0, 74, s60f, "\x01\x02\x03\x04\x05\x06\a\b\t\n\v\f\r\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\x7f")
			m600(arg0, 75, s610, "abcdef")
			m600(arg0, 76, s611, "ABCDEF")
			m600(arg0, 77, s612, "ff")
			m600(arg0, 78, s613, "ffffffffff")
			m600(arg0, 79, s614, "B")
			m600(arg0, 80, s615, "3789012345678901")
			m600(arg0, 81, s616, "D76162EE9EC35")
			m600(arg0, 82, s617, "90123456")
			m600(arg0, 83, s618, "55F2CC0")
			m600(arg0, 84, s619, "c179B3FE")
			m600(arg0, 85, s61a, "fE7CB391D650A284")
			m600(arg0, 86, s61b, "63")
		}
	} elseif (LEqual(arg1, 3)) {
		if (arg2) {
			// Test Buffers Package
			m600(arg0, 87, Derefof(Index(pb60, 0)), Buffer(1){0x00})
			m600(arg0, 88, Derefof(Index(pb60, 1)), Buffer(1){0xa5})
			m600(arg0, 89, Derefof(Index(pb60, 2)), Buffer(2){0x21, 0x03})
			m600(arg0, 90, Derefof(Index(pb60, 3)), Buffer() {0x21, 0x03, 0x5a})
			m600(arg0, 91, Derefof(Index(pb60, 4)), Buffer(2){0x21, 0x03, 0x5a})
			m600(arg0, 92, Derefof(Index(pb60, 5)), Buffer(3){0x21, 0x03})
			m600(arg0, 93, Derefof(Index(pb60, 6)), Buffer(3){0x21, 0x03, 0x00})
			m600(arg0, 94, Derefof(Index(pb60, 7)), Buffer(4){0xFE, 0xB3, 0x79, 0xC1})
			m600(arg0, 95, Derefof(Index(pb60, 8)), Buffer(5){0xFE, 0xB3, 0x79, 0xC1, 0xa5})
			m600(arg0, 96, Derefof(Index(pb60, 9)), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
			m600(arg0, 97, Derefof(Index(pb60, 10)), Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
			m600(arg0, 98, Derefof(Index(pb60, 11)), Buffer(257){0x00})
			m600(arg0, 99, Derefof(Index(pb60, 12)), Buffer(67){
				0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
				0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
				0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
				0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
				0x61,0x62,0x63,})
			m600(arg0, 100, Derefof(Index(pb60, 13)), Buffer(68){
				0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
				0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
				0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
				0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
				0x61,0x62,0x63,0x00,})
			m600(arg0, 101, Derefof(Index(pb60, 14)), Buffer(1){0xb})
			m600(arg0, 102, Derefof(Index(pb60, 15)), Buffer() {0x01, 0x89, 0x67, 0x45, 0x23, 0x01, 0x89, 0x37})
			m600(arg0, 103, Derefof(Index(pb60, 16)), Buffer() {0x35, 0xec, 0xe9, 0x2e, 0x16, 0x76, 0x0d})
			m600(arg0, 104, Derefof(Index(pb60, 17)), Buffer() {0x56, 0x34, 0x12, 0x90})
			m600(arg0, 105, Derefof(Index(pb60, 18)), Buffer() {0xc0, 0x2c, 0x5f, 0x05})
			m600(arg0, 106, Derefof(Index(pb60, 19)), Buffer(1){0x3f})
		} else {
			// Test Buffers
			m600(arg0, 107, b600, Buffer(1){0x00})
			m600(arg0, 108, b601, Buffer(1){0xa5})
			m600(arg0, 109, b602, Buffer(2){0x21, 0x03})
			m600(arg0, 110, b603, Buffer() {0x21, 0x03, 0x5a})
			m600(arg0, 111, b604, Buffer(2){0x21, 0x03, 0x5a})
			m600(arg0, 112, b605, Buffer(3){0x21, 0x03})
			m600(arg0, 113, b606, Buffer(3){0x21, 0x03, 0x00})
			m600(arg0, 114, b607, Buffer(4){0xFE, 0xB3, 0x79, 0xC1})
			m600(arg0, 115, b608, Buffer(5){0xFE, 0xB3, 0x79, 0xC1, 0xa5})
			m600(arg0, 116, b609, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
			m600(arg0, 117, b60a, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0xa5})
			m600(arg0, 118, b60b, Buffer(257){0x00})
			m600(arg0, 119, b60c, Buffer(67){
				0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
				0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
				0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
				0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
				0x61,0x62,0x63,})
			m600(arg0, 120, b60d, Buffer(68){
				0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,
				0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,0x40,
				0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,
				0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,0x60,
				0x61,0x62,0x63,0x00,})
			m600(arg0, 121, b60e, Buffer(1){0xb})
			m600(arg0, 122, b60f, Buffer() {0x01, 0x89, 0x67, 0x45, 0x23, 0x01, 0x89, 0x37})
			m600(arg0, 123, b610, Buffer() {0x35, 0xec, 0xe9, 0x2e, 0x16, 0x76, 0x0d})
			m600(arg0, 124, b611, Buffer() {0x56, 0x34, 0x12, 0x90})
			m600(arg0, 125, b612, Buffer() {0xc0, 0x2c, 0x5f, 0x05})
			m600(arg0, 126, b613, Buffer(1){0x3f})
		}
	}
}

// Check consistency of the test Named Objects
// in the root Scope of the Global ACPI namespace
Method(m606, 1)
{
	m605(arg0, 1, 0)
	m605(arg0, 1, 1)
	m605(arg0, 2, 0)
	m605(arg0, 2, 1)
	m605(arg0, 3, 0)
	m605(arg0, 3, 1)
}
