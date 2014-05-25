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
 * Check implicit conversion being applied to data images
 */

Name(z122, 122)

// Flags of types can be used in Index Operator
Name(b66f, Buffer() {0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0})

// Not invalid types for testing to store in,
// excluded: Field Unit, Op.Region, Thermal Zone,
//           DDB handle, Debug, Reference
Name(b670, Buffer() {1,1,1,1,1,0,1,1,1,1,0,1,1,0,1,0,0,0})

// Not invalid types for testing to be stored,
// excluded: Field Unit, Op.Region, Thermal Zone,
//           DDB handle, Debug, Reference
Name(b671, Buffer() {1,1,1,1,1,0,1,1,1,1,0,1,1,0,1,0,0,0})

// Flags of types of non-Computational Data Objects
Name(b674, Buffer() {1,0,0,0,1,0,1,1,1,1,1,1,1,1,0,1,1,1})

// Possible types of the Named Object
Name(b676, Buffer() {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1})

// Possible types of the LocalX Object
Name(b677, Buffer() {1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,0,1})

// Flags of types of Fixed type Data Objects (Fields)
Name(b678, Buffer() {0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0})

// Flags of types of Computational Data Objects
// (Fields and Integer, String, Buffer)
Name(b679, Buffer() {0,1,1,1,0,1,0,0,0,0,0,0,0,0,1,0,0,0})

// Type group numbers according with the type of an Object
Name(b67a, Buffer() {0,2,2,2,3,1,5,5,4,5,5,5,5,5,1,0,0,6})

// Flags of types not causing exceptins on Increment/Decrement
// (~ Computational Data Objects)
Name(b67b, Buffer() {0,1,1,1,0,1,0,0,0,0,0,0,0,0,1,0,0,0})

// Flags of types that can be verified only by ObjectType
// (Not Computational Data, Package and Method Objects)
Name(b67c, Buffer() {1,0,0,0,0,0,1,1,0,1,1,1,1,1,0,1,1,1})

// Possible types of Package Elements
Name(b67d, Buffer() {1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1})

// Not invalid types for Store taking into
// account the ACPICA exresop restriction:
// Needed Integer/Buffer/String/Package/Ref/Ddb
Name(b67f, Buffer() {0,1,1,1,1,1,0,0,0,0,0,0,0,0,1,0,0,1})

// Testing Destination Named Objects

// Integers

Name(i680, 0xa0a1a2a35f5e5d80)
Name(i681, 0xa0a1a2a35f5e5d81)
Name(i682, 0xa0a1a2a35f5e5d82)
Name(i683, 0xa0a1a2a35f5e5d83)
Name(i684, 0xa0a1a2a35f5e5d84)
Name(i685, 0xa0a1a2a35f5e5d85)
Name(i686, 0xa0a1a2a35f5e5d86)
Name(i687, 0xa0a1a2a35f5e5d87)
Name(i688, 0xa0a1a2a35f5e5d88)
Name(i689, 0xa0a1a2a35f5e5d89)
Name(i68a, 0xa0a1a2a35f5e5d8a)
Name(i68b, 0xa0a1a2a35f5e5d8b)
Name(i68c, 0xa0a1a2a35f5e5d8c)
Name(i68d, 0xa0a1a2a35f5e5d8d)
Name(i68e, 0xa0a1a2a35f5e5d8e)
Name(i68f, 0xa0a1a2a35f5e5d8f)

Name(i690, 0xa0a1a2a35f5e5d90)
Name(i691, 0xa0a1a2a35f5e5d91)
Name(i692, 0xa0a1a2a35f5e5d92)
Name(i693, 0xa0a1a2a35f5e5d93)
Name(i694, 0xa0a1a2a35f5e5d94)
Name(i695, 0xa0a1a2a35f5e5d95)
Name(i696, 0xa0a1a2a35f5e5d96)
Name(i697, 0xa0a1a2a35f5e5d97)
Name(i698, 0xa0a1a2a35f5e5d98)
Name(i699, 0xa0a1a2a35f5e5d99)
Name(i69a, 0xa0a1a2a35f5e5d9a)
Name(i69b, 0xa0a1a2a35f5e5d9b)
Name(i69c, 0xa0a1a2a35f5e5d9c)
Name(i69d, 0xa0a1a2a35f5e5d9d)
Name(i69e, 0xa0a1a2a35f5e5d9e)
Name(i69f, 0xa0a1a2a35f5e5d9f)

// Strings

Name(s680, "initial named string80")
Name(s681, "initial named string81")
Name(s682, "initial named string82")
Name(s683, "initial named string83")
Name(s684, "initial named string84")
Name(s685, "initial named string85")
Name(s686, "initial named string86")
Name(s687, "initial named string87")
Name(s688, "initial named string88")
Name(s689, "initial named string89")
Name(s68a, "initial named string8a")
Name(s68b, "initial named string8b")
Name(s68c, "initial named string8c")
Name(s68d, "initial named string8d")
Name(s68e, "initial named string8e")
Name(s68f, "initial named string8f")

Name(s690, "initial named string90")
Name(s691, "initial named string91")
Name(s692, "initial named string92")
Name(s693, "initial named string93")
Name(s694, "initial named string94")
Name(s695, "initial named string95")
Name(s696, "initial named string96")
Name(s697, "initial named string97")
Name(s698, "initial named string98")
Name(s699, "initial named string99")
Name(s69a, "initial named string9a")
Name(s69b, "initial named string9b")
Name(s69c, "initial named string9c")
Name(s69d, "initial named string9d")
Name(s69e, "initial named string9e")
Name(s69f, "initial named string9f")

// Buffers

Name(b680, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x80})
Name(b681, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x81})
Name(b682, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x82})
Name(b683, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x83})
Name(b684, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x84})
Name(b685, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x85})
Name(b686, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x86})
Name(b687, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x87})
Name(b688, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x88})
Name(b689, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x89})
Name(b68a, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x8a})
Name(b68b, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x8b})
Name(b68c, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x8c})
Name(b68d, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x8d})
Name(b68e, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x8e})
Name(b68f, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x8f})

Name(b690, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x90})
Name(b691, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x91})
Name(b692, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x92})
Name(b693, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x93})
Name(b694, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x94})
Name(b695, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x95})
Name(b696, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x96})
Name(b697, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x97})
Name(b698, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x98})
Name(b699, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x99})
Name(b69a, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x9a})
Name(b69b, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x9b})
Name(b69c, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x9c})
Name(b69d, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x9d})
Name(b69e, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x9e})
Name(b69f, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x9f})

// Packages

Name(p680, Package(1){0})

// Buffer Fields

Name(b675, Buffer(23){})

CreateField(b675,   0, 31, bf80)
CreateField(b675,  35, 63, bf81)
CreateField(b675, 110, 69, bf82)

// Auxiliary Source Named Objects

Name(i6e0, 0xfe7cb391d650a284)
Name(i6e1, 0xfe7cb391d650a284)
Name(i6e2, 0xfe7cb391d650a284)
Name(i6e3, 0xfe7cb391d650a284)
Name(i6e4, 0xfe7cb391d650a284)
Name(i6e5, 0xfe7cb391d650a284)
Name(i6e6, 0xfe7cb391d650a284)
Name(i6e7, 0xfe7cb391d650a284)
Name(i6e8, 0xfe7cb391d650a284)
Name(i6e9, 0xfe7cb391d650a284)

Name(p690, Package(){
	0xfe7cb391d650a284,
	"FE7CB391D650A284",
	Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE},
	0xfe7cb391d650a284,
	"FE7CB391D650A284",
	Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE},
	0xfe7cb391d650a284,
	"FE7CB391D650A284",
	Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE},
	0xfe7cb391d650a284,
	"FE7CB391D650A284",
	Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE},
	0xfe7cb391d650a284,
	"FE7CB391D650A284",
	Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE},
	0xfe7cb391d650a284,
	"FE7CB391D650A284",
	Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE},
})

Name(p691, Package(1){})

Name(s6e0, "FE7CB391D650A284")
Name(s6e1, "FE7CB391D650A284")
Name(s6e2, "FE7CB391D650A284")
Name(s6e3, "FE7CB391D650A284")
Name(s6e4, "FE7CB391D650A284")
Name(s6e5, "FE7CB391D650A284")
Name(s6e6, "FE7CB391D650A284")
Name(s6e7, "FE7CB391D650A284")
Name(s6e8, "FE7CB391D650A284")
Name(s6e9, "FE7CB391D650A284")

Name(b6e0, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
Name(b6e1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
Name(b6e2, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
Name(b6e3, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
Name(b6e4, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
Name(b6e5, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
Name(b6e6, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
Name(b6e7, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
Name(b6e8, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
Name(b6e9, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})

// Matrixes of exceptions expected during an attempt to make
// a copy of the Result Object by some storing operator,
// a raw relies to the type group of a Target Object,
// a column relies to the type group of a Result Object
// (uninitialized, fixed, other computational data types,
// Package, Method, others, reference)

// Store to Named Object
Name(p6a0, Package(){
	Buffer() {1,0,0,0,1,1,0},
	Buffer() {1,0,0,1,1,1,1},
	Buffer() {1,0,0,1,1,1,1},
	Buffer() {1,0,0,0,1,1,0},
	Buffer() {1,0,0,0,1,1,0},
	Buffer() {1,0,0,0,1,1,0},
	Buffer() {1,0,0,0,1,1,0},
})

// Store in other cases and CopyObject
Name(p6a1, Package(){
	Buffer() {1,0,0,0,0,0,0},
	Buffer() {1,0,0,1,1,1,1},
	Buffer() {1,0,0,0,0,0,0},
	Buffer() {1,0,0,0,0,0,0},
	Buffer() {1,0,0,0,0,0,0},
	Buffer() {1,0,0,0,0,0,0},
	Buffer() {1,0,0,0,0,0,0},
})

// Matrixes of saving Target type storings
// (have sense in absence of exceptions)

// Store to Named Object
Name(p6a2, Package(){
	Buffer() {0,0,0,0,0,0,0},
	Buffer() {0,1,1,0,1,0,0},
	Buffer() {0,1,1,0,1,0,0},
	Buffer() {0,0,0,1,0,0,0},
	Buffer() {0,0,0,0,0,0,0},
	Buffer() {0,0,0,0,0,0,0},
	Buffer() {0,0,0,0,0,0,0},
})

// Store in other cases and CopyObject
Name(p6a3, Package(){
	Buffer() {0,0,0,0,0,0,0},
	Buffer() {0,1,1,0,0,0,0},
	Buffer() {0,0,0,0,0,0,0},
	Buffer() {0,0,0,0,0,0,0},
	Buffer() {0,0,0,0,0,0,0},
	Buffer() {0,0,0,0,0,0,0},
	Buffer() {0,0,0,0,0,0,0},
})

// Check Result of operation on equal to Benchmark value
// m680(<method name>,
//	<internal type of error if it occurs>,
//	<internal subtype>,
//	<Result>,
//	<Benchmark value>)
Method(m680, 5)
{
	Store(ObjectType(arg3), Local0)
	Store(ObjectType(arg4), Local1)
	if (LNotEqual(Local0, Local1)) {
		err(Concatenate(arg0, "-OType"), z122, arg1, arg2, 0, Local0, Local1)
		Return (1)
	} elseif (Derefof(Index(b679, Local0))) {
		if (LNotEqual(arg3, arg4)) {
			err(arg0, z122, arg1, arg2, 0, arg3, arg4)
			Return (1)
		}
	}
	Return (0)
}

// Return Indexed reference
// m681(<source>, <index>)
Method(m681, 2)
{
	Return (Index(arg0, arg1))
}

// Return the value of an Auxiliary Source Named Object
// m682(<type>, <index>)
Method(m682, 2, Serialized)
{
	Switch(ToInteger(arg0)) {
		Case(1) {
			Switch(ToInteger(arg1)) {
				Case(0) {Return (i6e0)}
				Case(1) {Return (i6e1)}
				Case(2) {Return (i6e2)}
				Case(3) {Return (i6e3)}
				Case(4) {Return (i6e4)}
				Case(5) {Return (i6e5)}
				Case(6) {Return (i6e6)}
				Case(7) {Return (i6e7)}
				Case(8) {Return (i6e8)}
				Case(9) {Return (i6e9)}
			}
		}
		Case(2) {
			Switch(ToInteger(arg1)) {
				Case(0) {Return (s6e0)}
				Case(1) {Return (s6e1)}
				Case(2) {Return (s6e2)}
				Case(3) {Return (s6e3)}
				Case(4) {Return (s6e4)}
				Case(5) {Return (s6e5)}
				Case(6) {Return (s6e6)}
				Case(7) {Return (s6e7)}
				Case(8) {Return (s6e8)}
				Case(9) {Return (s6e9)}
			}
		}
		Case(3) {
			Switch(ToInteger(arg1)) {
				Case(0) {Return (b6e0)}
				Case(1) {Return (b6e1)}
				Case(2) {Return (b6e2)}
				Case(3) {Return (b6e3)}
				Case(4) {Return (b6e4)}
				Case(5) {Return (b6e5)}
				Case(6) {Return (b6e6)}
				Case(7) {Return (b6e7)}
				Case(8) {Return (b6e8)}
				Case(9) {Return (b6e9)}
			}
		}
		Case(0xff) {Store(0, Local0)}
	}
	Return (Local0)
}

// Initialize the bytes of the buffer in the range of bits
// m683(<buffer>, <bit1>, <length>, <byte>)
Method(m683, 4)
{
	// First byte
	Divide(arg1, 8,,Local1)

	//Last byte
	Divide(Subtract(Add(arg1, arg2), 1), 8,,Local2)

	Subtract(Add(Local2, 1), Local1 ,Local0)

	While (Local0) {
		Store(arg3, Index(arg0, Local1))
		Increment(Local1)
		Decrement(Local0)
	}
}

// Return the number of the type group
Method(m684, 1)
{
	Return (Derefof(Index(b67a, arg0)))
}

// Return flag of exception on storing
// m685(<opcode>, <target type>, <result type>,
//      <flag of being Named Source>, <flag of being Named Target>)
Method(m685, 5)
{	
	if (arg0) {
		// CopyObject issue
		Return (Derefof(Index(Derefof(Index(p6a1, m684(arg1))), m684(arg2))))
	} else {
		// Store issue
		if (LAnd(arg3, LEqual(arg2, 8))) {
			// Store Named of type Method causes invocation of the Method
			// which returns a String in the test
			Store(2, arg2)
		}
		if (Derefof(Index(b67f, arg2))) {
			// Data can be stored
			if (Lor(arg4, Derefof(Index(b678, arg1)))) {
				// Store to Named or to Fixed Type
				// Result Object Conversion issue
				Return (Derefof(Index(Derefof(Index(p6a0, m684(arg1))), m684(arg2))))
			} else {
				Return (0)
			}
		} else {
			Return (1)
		}
	}
}

// Return flag of type saving on storing
// m686(<opcode>, <target type>, <result type>)
Method(m686, 3)
{	
	if (arg0) {
		if (LEqual(arg0, 2)) {
			// CopyObject to Named Object issue
			Return (Derefof(Index(Derefof(Index(p6a3, m684(arg1))), m684(arg2))))
		} else {
			Return (0)
		}
	} else {
		// Store to Named Object issue
		Return (Derefof(Index(Derefof(Index(p6a2, m684(arg1))), m684(arg2))))
	}
}

// Store the Object by the reference
// m687(<source>, <reference>)
Method(m687, 2)
{
	Store(arg0, arg1)
}

// Gathers simple statistics of Store/CopyObject operators
// m688(<name>)
Method(m688, 1, Serialized)
{
	// Objects are used as Source

	// Integer
	Name(INT0, 0xfedcba9876543210)

	// String
	Name(STR0, "source string")

	// Buffer
	Name(BUF0, Buffer(9){9,8,7,6,5,4,3,2,1})

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
	}
}

	// Device
	Device(DEV0) {Name(s000, "DEV0")}

	// Event
	Event(EVE0)

	// Method
	Name(MM00, "ff0X")	// Value, returned from MMMX
	Method(MMM0) {Return (MM00)}

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

	// Data to gather statistics

	Name(STCS, 0)

	Name(INDM, 255)

	Name(PAC2, Package(1) {})
	Name(IND2, 0)

	Name(PAC3, Package(1) {})
	Name(IND3, 0)


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

	// Check exceptions
	Method(m003, 1)
	{
		if (CH03(arg0, z122, 1, arg0, 0)) {
			if (STCS) {
				if (LLess(IND2, INDM)) {
					Store(arg0, Index(PAC2, IND2))
					Increment(IND2)
				}
			}
		}
	}

	// Check equality
	Method(m004, 3)
	{
		if (LNotEqual(arg0, arg1)) {
			err(arg0, z122, 2, 0, 0, arg0, arg1)
			if (STCS) {m000(3, 0x100, arg2, arg1)}
		}
	}


	// Gathers statistics of Store to Local
	Method(m010, 2)
	{
		// Initialize statistics
		m001()

		if (arg1) {Store(0, Local1)}

		Store(Local1, Local0)
		m003(ObjectType(Local1))

		Store(INT0, Local0)
		m003(ObjectType(INT0))

		Store(STR0, Local0)
		m003(ObjectType(STR0))

		Store(BUF0, Local0)
		m003(ObjectType(BUF0))

		Store(PAC0, Local0)
		m003(ObjectType(PAC0))

		Store(FLU0, Local0)
		m003(ObjectType(FLU0))

		Store(DEV0, Local0)
		m003(ObjectType(DEV0))

		Store(EVE0, Local0)
		m003(ObjectType(EVE0))

		Store(MTX0, Local0)
		m003(ObjectType(MTX0))

		Store(OPR0, Local0)
		m003(ObjectType(OPR0))

		Store(PWR0, Local0)
		m003(ObjectType(PWR0))

		Store(CPU0, Local0)
		m003(ObjectType(CPU0))

		Store(TZN0, Local0)
		m003(ObjectType(TZN0))

		Store(BFL0, Local0)
		m003(ObjectType(BFL0))

		// Output statistics
		m002("Store to LocalX")
	}

	// Gathers statistics of CopyObject to Local
	Method(m011, 2)
	{
		// Initialize statistics
		m001()

		if (arg1) {Store(0, Local1)}

		CopyObject(Local1, Local0)
		m003(ObjectType(Local1))

		CopyObject(INT0, Local0)
		m003(ObjectType(INT0))

		CopyObject(STR0, Local0)
		m003(ObjectType(STR0))

		CopyObject(BUF0, Local0)
		m003(ObjectType(BUF0))

		CopyObject(PAC0, Local0)
		m003(ObjectType(PAC0))

		CopyObject(FLU0, Local0)
		m003(ObjectType(FLU0))

		CopyObject(DEV0, Local0)
		m003(ObjectType(DEV0))

		CopyObject(EVE0, Local0)
		m003(ObjectType(EVE0))

		CopyObject(MMM0, Local0)
		m003(ObjectType(MMM0))

		CopyObject(MTX0, Local0)
		m003(ObjectType(MTX0))

		CopyObject(OPR0, Local0)
		m003(ObjectType(OPR0))

		CopyObject(PWR0, Local0)
		m003(ObjectType(PWR0))

		CopyObject(CPU0, Local0)
		m003(ObjectType(CPU0))

		CopyObject(TZN0, Local0)
		m003(ObjectType(TZN0))

		CopyObject(BFL0, Local0)
		m003(ObjectType(BFL0))

		// Output statistics
		m002("CopyObject to LocalX")
	}

	// Gathers statistics of CopyObject to Integer
	Method(m012, 2, Serialized)
	{
		// Integer
		Name(INT1, 0xfedcba9876543211)
		Name(INT2, 0xfedcba9876543212)
		Name(INT3, 0xfedcba9876543213)
		Name(INT4, 0xfedcba9876543214)
		Name(INT5, 0xfedcba9876543215)
		Name(INT6, 0xfedcba9876543216)
		Name(INT7, 0xfedcba9876543217)
		Name(INT8, 0xfedcba9876543218)
		Name(INT9, 0xfedcba9876543219)
		Name(INTa, 0xfedcba987654321a)
		Name(INTb, 0xfedcba987654321b)
		Name(INTc, 0xfedcba987654321c)
		Name(INTd, 0xfedcba987654321d)
		Name(INTe, 0xfedcba987654321e)
		Name(INTf, 0xfedcba987654321f)

		// Initialize statistics
		m001()

		if (arg1) {Store(0, Local1)}

		CopyObject(Local1, INTf)
		m003(ObjectType(Local1))
		m004(arg0, ObjectType(INTf), 0)

		CopyObject(INT0, INT1)
		m003(ObjectType(INT0))
		m004(arg0, ObjectType(INT1), 1)

		CopyObject(STR0, INT2)
		m003(ObjectType(STR0))
		m004(arg0, ObjectType(INT2), 2)

		CopyObject(BUF0, INT3)
		m003(ObjectType(BUF0))
		m004(arg0, ObjectType(INT3), 3)

		CopyObject(PAC0, INT4)
		m003(ObjectType(PAC0))
		m004(arg0, ObjectType(INT4), 4)

		CopyObject(FLU0, INT5)
		m003(ObjectType(FLU0))
		m004(arg0, ObjectType(INT5), 5)

		CopyObject(DEV0, INT6)
		m003(ObjectType(DEV0))
		m004(arg0, ObjectType(INT6), 6)

		CopyObject(EVE0, INT7)
		m003(ObjectType(EVE0))
		m004(arg0, ObjectType(INT7), 7)

		CopyObject(MMM0, INT8)
		m003(ObjectType(MMM0))
		m004(arg0, ObjectType(INT8), 8)

		CopyObject(MTX0, INT9)
		m003(ObjectType(MTX0))
		m004(arg0, ObjectType(INT9), 9)

		CopyObject(OPR0, INTa)
		m003(ObjectType(OPR0))
		m004(arg0, ObjectType(INTa), 10)

		CopyObject(PWR0, INTb)
		m003(ObjectType(PWR0))
		m004(arg0, ObjectType(INTb), 11)

		CopyObject(CPU0, INTc)
		m003(ObjectType(CPU0))
		m004(arg0, ObjectType(INTc), 12)

		CopyObject(TZN0, INTd)
		m003(ObjectType(TZN0))
		m004(arg0, ObjectType(INTd), 13)

		CopyObject(BFL0, INTe)
		m003(ObjectType(BFL0))
		m004(arg0, ObjectType(INTe), 14)

		// Output statistics
		m002("CopyObject to Integer Named Object")
	}

	m010(Concatenate(arg0, "-m010"), 0)
	m011(Concatenate(arg0, "-m011"), 0)
	m012(Concatenate(arg0, "-m012"), 0)
}

// Verify storing of an immediate Source Object into different kinds
// of Target Objects by means of the specified operator (Store/CopyObject)
// m689(<name>, <store op>, <exc. conditions>)
Method(m689, 3, Serialized)
{
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

	// Initializer of Fields
	Name(BUF2, Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,0x15})

	// Base of Buffer Fields
	Name(BUFZ, Buffer(48){})

	// Package
	Name(PAC0, Package(3) {
		0xfedcba987654321f,
		"test package",
		Buffer(9){19,18,17,16,15,14,13,12,11},
	})

	Name(PAC1, Package(1) {"target package"})

if (y361) {
	// Field Unit
	Field(OPR0, ByteAcc, NoLock, Preserve) {
		FLU0, 69,
		FLU2, 64,
		FLU4, 32,
	}
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

if (y361) {
	// Operation Region
	OperationRegion(OPR0, SystemMemory, 0, 48)
	OperationRegion(OPR1, SystemMemory, 0, 24)
}
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
	Createfield(BUFZ,  80, 64, BFL2)
	Createfield(BUFZ, 160, 32, BFL4)

	// Reference
	Name(ORF0, "ORF0")
	Name(REF0, Package(1){})
	Name(ORF1, "ORF0")
	Name(REF1, Package(1){})

	// Data to gather statistics

	Name(STCS, 0)

	Name(INDM, 255)

	Name(PAC2, Package(1) {})
	Name(IND2, 0)

	Name(PAC3, Package(1) {})
	Name(IND3, 0)

	Name(PAC4, Package(2) {
		"Store",
		"Copyobject",
	})

	Name(PAC5, Package(7) {
		"Storing Named-Named with ",
		"Storing Named-LocalX with ",
		"Storing LocalX-Named with ",
		"Storing LocalX-LocalX with ",
		"Storing Named-ArgX(Named on read-only argument rule) with ",
		"Storing Named-ArgX(Named by reference) with ",
		"Storing LocalX-Element of Package with ",
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
				if (y136) {
					CopyObject(Derefof(arg3), BUF1)
				} else {
					m687(Derefof(arg3), Refof(BUF1))
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
				CopyObject(Derefof(Index(Derefof(arg3), 0)), MMM1)
				CopyObject(Derefof(Index(Derefof(arg3), 1)), MM01)
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
				CopyObject(Refof(ORF1), REF1)
				if (y522) {
					CopyObject(REF1, arg2)
				} else {
					CopyObject(DeRefof(REF1), arg2)
				}
			}
			Default {
				// Unexpected Target Type
				err(Concatenate(arg0, terr), z122, 4, 0, 0, arg1, 0)
				Return (1)
			}
		}
		if (CH03(arg0, z122, 5, arg1, 0)) {
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
			err(arg0, z122, 6, 0, 0, Local0, arg1)
			Return (1)
		}

		Return (0)
	}

	// Prepare Source of specified type
	Method(m004, 4, Serialized)
	{
		Switch(ToInteger(arg1)) {
			Case(0) {
			}
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
			Case(5) {
				Store(Derefof(Index(Derefof(arg3), 0)), Local0)
				if (LEqual(Local0, 0)) {
					Store(Derefof(Index(Derefof(arg3), 1)), FLU0)
				} elseif (LEqual(Local0, 1)) {
					Store(Derefof(Index(Derefof(arg3), 1)), FLU2)
				} else {
					Store(Derefof(Index(Derefof(arg3), 1)), FLU4)
				}
			}
			Case(6) {
				CopyObject(DEV0, arg2)
			}
			Case(7) {
				CopyObject(EVE0, arg2)
			}
			Case(8) {
				CopyObject(Derefof(Index(Derefof(arg3), 0)), MMM0)
				CopyObject(Derefof(Index(Derefof(arg3), 1)), MM00)
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
				Store(Derefof(Index(Derefof(arg3), 0)), Local0)
				if (LEqual(Local0, 0)) {
					Store(Derefof(Index(Derefof(arg3), 1)), BFL0)
				} elseif (LEqual(Local0, 1)) {
					Store(Derefof(Index(Derefof(arg3), 1)), BFL2)
				} else {
					Store(Derefof(Index(Derefof(arg3), 1)), BFL4)
				}
			}
			Case(17) {
				CopyObject(Refof(ORF0), REF0)
				if (y522) {
					CopyObject(REF0, arg2)
				} else {
					CopyObject(DeRefof(REF0), arg2)
				}
			}
			Default {
				// Unexpected Source Type
				err(Concatenate(arg0, terr), z122, 7, 0, 0, arg1, 0)
				Return (1)
			}
		}
		if (CH03(arg0, z122, 8, arg1, 0)) {
			// Exception during preparing of Source Object
			Return (1)
		}

		if (LEqual(arg1, 17)) {
			// Reference
			Return (0)
		}

		Store(ObjectType(arg2), Local0)
		if (LNotEqual(Local0, arg1)) {
			// ObjectType of Source can not be set up
			err(arg0, z122, 9, 0, 0, Local0, arg1)
			Return (1)
		}

		Return (0)
	}

	// Check Source Object type is not corrupted after storing,
	// for the computational data types verify its value against
	// the Object-initializer value
	Method(m005, 4, Serialized)
	{
		Name(MMM2, 0) // An auxiliary Object to invoke Method

		if (LEqual(arg1, 17)) {
			// Source object is a reference
			// Check that it can be used as reference
			Store(Derefof(arg2), Local0)
			Store(Derefof(Local0) ,Local3)
			if (CH03(arg0, z122, 10, arg1, Local0)) {
				// Derefof caused unexpected exception
				Return (1)
			}
			Return (0)
		}

		Store(ObjectType(arg2), Local0)
		if (LNotEqual(Local0, arg1)) {
			// ObjectType of Source object is corrupted
			err(arg0, z122, 11, 0, 0, Local0, arg1)
			Return (1)
		}

		Switch(ToInteger(arg1)) {
			Case(0) {
				Return (0)
			}
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
			Case(5) {
				Store(Derefof(Index(Derefof(arg3), 0)), Local0)
				if (LEqual(Local0, 0)) {
					Store(ObjectType(FLU0), Local0)
				} elseif (LEqual(Local0, 1)) {
					Store(ObjectType(FLU2), Local0)
				} else {
					Store(ObjectType(FLU4), Local0)
				}
			}
			Case(6) {
				Store(ObjectType(DEV0), Local0)
			}
			Case(7) {
				Store(ObjectType(EVE0), Local0)
			}
			Case(8) {
				Store(ObjectType(MMM0), Local0)
			}
			Case(9) {
				Store(ObjectType(MTX0), Local0)
			}
			Case(10) {
				Store(ObjectType(OPR0), Local0)
			}
			Case(11) {
				Store(ObjectType(PWR0), Local0)
			}
			Case(12) {
				Store(ObjectType(CPU0), Local0)
			}
			Case(13) {
				Store(ObjectType(TZN0), Local0)
			}
			Case(14) {
				Store(Derefof(Index(Derefof(arg3), 0)), Local0)
				if (LEqual(Local0, 0)) {
					Store(ObjectType(BFL0), Local0)
				} elseif (LEqual(Local0, 1)) {
					Store(ObjectType(BFL2), Local0)
				} else {
					Store(ObjectType(BFL4), Local0)
				}
			}
			Default {
				// Unexpected Result Type
				err(arg0, z122, 12, 0, 0, arg1, 0)
				Return (1)
			}
		}

		if (LNotEqual(Local0, arg1)) {
			// Mismatch of Source Type against specified Result Type
			err(arg0, z122, 13, 0, 0, Local0, arg1)

			if (STCS) {m000(3, 0x1000000, Local0, arg1)}

			Return (1)
		} else {
			// Check equality of the Source value to the Object-initializer one
			Switch(ToInteger(arg1)) {
				Case(1) {
					if (LNotEqual(INT0, Derefof(arg3))) {
						err(arg0, z122, 14, 0, 0, INT0, Derefof(arg3))
						Return (1)
					}
					if (LNotEqual(Derefof(arg2), INT0)) {
						err(arg0, z122, 15, 0, 0, Derefof(arg2), INT0)
						Return (1)
					}
				}
				Case(2) {
					if (LNotEqual(STR0, Derefof(arg3))) {
						err(arg0, z122, 16, 0, 0, STR0, Derefof(arg3))
						Return (1)
					}
					if (LNotEqual(Derefof(arg2), STR0)) {
						err(arg0, z122, 17, 0, 0, Derefof(arg2), STR0)
						Return (1)
					}
				}
				Case(3) {
					if (LNotEqual(BUF0, Derefof(arg3))) {
						err(arg0, z122, 18, 0, 0, BUF0, Derefof(arg3))
						Return (1)
					}
					if (LNotEqual(Derefof(arg2), BUF0)) {
						err(arg0, z122, 19, 0, 0, Derefof(arg2), BUF0)
						Return (1)
					}
				}
				Case(4) {

					Store(Sizeof(PAC0), Local0)
					if (LNotEqual(Sizeof(arg3), Local0)) {
						err(arg0, z122, 20, 0, 0, Sizeof(arg3), Local0)
						Return (1)
					}
					While (Local0) {
						Decrement(Local0)
						Store(ObjectType(Derefof(Index(Derefof(arg3), Local0))), Local1)
						Store(ObjectType(Derefof(Index(PAC0, Local0))), Local2)
						if (LNotEqual(Local1, Local2)) {
							// ObjectType is corrupted
							err(arg0, z122, 21, 0, 0, Local1, Local2)
							Return (1)
						} elseif (Derefof(Index(b679, Local1))) {
							// the computational data type
							if (LNotEqual(
									Derefof(Index(Derefof(arg3), Local0)),
									Derefof(Index(PAC0, Local0)))) {
								// The value is corrupted
								err(arg0, z122, 22, 0, 0, Derefof(Index(Derefof(arg3), Local0)), Local0)
								Return (1)
							}
						}
					}

					Store(Sizeof(PAC0), Local0)
					if (LNotEqual(Sizeof(arg2), Local0)) {
						err(arg0, z122, 23, 0, 0, Sizeof(arg2), Local0)
						Return (1)
					}
					While (Local0) {
						Decrement(Local0)
						Store(ObjectType(Derefof(Index(Derefof(arg2), Local0))), Local1)
						Store(ObjectType(Derefof(Index(PAC0, Local0))), Local2)
						if (LNotEqual(Local1, Local2)) {
							// ObjectType is corrupted
							err(arg0, z122, 24, 0, 0, Local1, Local2)
							Return (1)
						} elseif (Derefof(Index(b679, Local1))) {
							// the computational data type
							if (LNotEqual(
									Derefof(Index(Derefof(arg2), Local0)),
									Derefof(Index(PAC0, Local0)))) {
								// The value is corrupted
								err(arg0, z122, 25, 0, 0, Derefof(Index(Derefof(arg2), Local0)), Local0)
								Return (1)
							}
						}
					}
				}
				Case(5) {
					Store(Derefof(Index(Derefof(arg3), 0)), Local0)
					if (LEqual(Local0, 0)) {
						if (LNotEqual(FLU0, Derefof(Index(Derefof(arg3), 1)))) {
							err(arg0, z122, 26, 0, 0, FLU0, Derefof(Index(Derefof(arg3), 1)))
							Return (1)
						}
						if (LNotEqual(Derefof(arg2), FLU0)) {
							err(arg0, z122, 27, 0, 0, Derefof(arg2), FLU0)
							Return (1)
						}
					} elseif (LEqual(Local0, 1)) {
						if (LNotEqual(FLU2, Derefof(Index(Derefof(arg3), 1)))) {
							err(arg0, z122, 28, 0, 0, FLU2, Derefof(Index(Derefof(arg3), 1)))
							Return (1)
						}
						if (LNotEqual(Derefof(arg2), FLU2)) {
							err(arg0, z122, 29, 0, 0, Derefof(arg2), FLU2)
							Return (1)
						}
					} else {
						if (LNotEqual(FLU4, Derefof(Index(Derefof(arg3), 1)))) {
							err(arg0, z122, 30, 0, 0, FLU4, Derefof(Index(Derefof(arg3), 1)))
							Return (1)
						}
						if (LNotEqual(Derefof(arg2), FLU4)) {
							err(arg0, z122, 31, 0, 0, Derefof(arg2), FLU4)
							Return (1)
						}
					}
				}
				Case(8) {
					CopyObject(Derefof(arg2), MMM2)
					if (LNotEqual(MMM2, MMM0)) {
						err(arg0, z122, 32, 0, 0, MMM2, MMM0)
						Return (1)
					}
				}
				Case(14) {
					Store(Derefof(Index(Derefof(arg3), 0)), Local0)
					if (LEqual(Local0, 0)) {
						if (LNotEqual(BFL0, Derefof(Index(Derefof(arg3), 1)))) {
							err(arg0, z122, 33, 0, 0, BFL0, Derefof(Index(Derefof(arg3), 1)))
							Return (1)
						}
						if (LNotEqual(Derefof(arg2), BFL0)) {
							err(arg0, z122, 34, 0, 0, Derefof(arg2), BFL0)
							Return (1)
						}
					} elseif (LEqual(Local0, 1)) {
						if (LNotEqual(BFL2, Derefof(Index(Derefof(arg3), 1)))) {
							err(arg0, z122, 35, 0, 0, BFL2, Derefof(Index(Derefof(arg3), 1)))
							Return (1)
						}
						if (LNotEqual(Derefof(arg2), BFL2)) {
							err(arg0, z122, 36, 0, 0, Derefof(arg2), BFL2)
							Return (1)
						}
					} else {
						if (LNotEqual(BFL4, Derefof(Index(Derefof(arg3), 1)))) {
							err(arg0, z122, 37, 0, 0, BFL4, Derefof(Index(Derefof(arg3), 1)))
							Return (1)
						}
						if (LNotEqual(Derefof(arg2), BFL4)) {
							err(arg0, z122, 38, 0, 0, Derefof(arg2), BFL4)
							Return (1)
						}
					}
				}
			}
		}
		Return (0)
	}

	// Check Target Object to have the expected type and value
	// m006(<msg>, <ref to target>, <target type>, <result object type>,
	//      <op>, <target save type>, <test data package>)
	Method(m006, 7, Serialized)
	{
		Name(MMM2, 0) // An auxiliary Object to invoke Method

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
						//this sentence is for m00d and invalid, removed.
						//err(arg0, z122, 39, 0, 0, Local2, arg2)
					}
				} else {
					err(arg0, z122, 39, 0, 0, Local2, arg2)
				}

				if (STCS) {m000(3, 0x100, arg2, Local2)}

				Return (1)
			}
		} else {
			// Target if it is not of fixed type
			// must accept type of the Result Object

			if (LNotEqual(Local2, arg3)) {
				if (LEqual(m684(arg3), 6)) {
					// Result object is a reference
					// Check that Target can be used as reference
					Store(Derefof(arg1), Local0)
					Store(Derefof(Local0), Local3)
					if (CH03(arg0, z122, 40, Local2, arg3)) {
						// Derefof caused unexpected exception
						Return (1)
					}
				} elseif (LNotEqual(m684(arg3), 1)) {
					// Types mismatch Result/Target on storing
					err(arg0, z122, 41, 0, 0, Local2, arg3)
					Return (1)
				} elseif (LNotEqual(Local2, 3)) {
					// Types mismatch Result/Target on storing
					// Test fixed type Objects are converted to Buffer
					err(arg0, z122, 42, 0, 0, Local2, 3)
					Return (1)
				}
				if (STCS) {m000(3, 0x100, arg3, Local2)}
			}
		}

		// Retrieve the benchmark value
		if (m686(arg5, arg2, arg3)) {
			// Save type of Target

			if (Derefof(Index(b67c, arg2))) {
				// Types that can be verified only by ObjectType
				Return (0)
			}

			// Retrieve the benchmark value
			Store(Derefof(Index(Derefof(Index(arg6, 5)), arg2)), Local7)

		} else {
			// Accept type of Result

			if (Derefof(Index(b67c, arg3))) {
				// Types that can be verified only by ObjectType
				Return (0)
			}

			Store(Derefof(Index(arg6, 4)), Local7)
		}

		if (LEqual(arg3, 8)) {				// Method
			CopyObject(Derefof(arg1), MMM2)
			if (LNotEqual(MMM2, Local7)) {
				err(arg0, z122, 43, 0, 0, MMM2, Local7)
				Return (1)
			}
		} elseif (LNotEqual(arg3, 4)) {		// Not Package
			if (LNotEqual(Derefof(arg1), Local7)) {
				err(arg0, z122, 44, 0, 0, Derefof(arg1), Local7)
				Return (1)
			}
		} else {							// Package
			Store(Sizeof(Local7), Local0)
			if (LNotEqual(Sizeof(arg1), Local0)) {
				err(arg0, z122, 45, 0, 0, Sizeof(arg1), Local0)
				Return (1)
			}
			While (Local0) {
				Decrement(Local0)
				Store(ObjectType(Derefof(Index(Derefof(arg1), Local0))), Local1)
				Store(ObjectType(Derefof(Index(Local7, Local0))), Local2)
				if (LNotEqual(Local1, Local2)) {
					// ObjectType is corrupted
					err(arg0, z122, 46, 0, 0, Local1, Local2)
					Return (1)
				} elseif (Derefof(Index(b679, Local1))) {
					// the computational data type
					if (LNotEqual(
							Derefof(Index(Derefof(arg1), Local0)),
							Derefof(Index(Local7, Local0)))) {
						// The value is corrupted
						err(arg0, z122, 47, 0, 0, Derefof(Index(Derefof(arg1), Local0)), Derefof(Index(Local7, Local0)))
						Return (1)
					}
				}
			}
		}
		Return (0)
	}


	// Update specified Object
	// m007(<msg>, <ref to target>)
	Method(m007, 2)
	{
		Store(ObjectType(arg1), Local0)

		if (Derefof(Index(b66f, Local0))) {
			// Can be used in Index Operator
			Store(Sizeof(arg1), Local1)
			if (Local1) {
				// Update the last Member Object
				Decrement(Local1)
				Index(Derefof(arg1), Local1, Local2)
				Store(Refof(Local2), Local3)
				Store(Derefof(Local2), Local4)
				if (LEqual(ObjectType(Local4), 1)) {
					// Integer
					Store(Not(Local4), Derefof(Local3))
				} else {
					Store(Ones, Derefof(Local3))
					if (CH03(arg0, z122, 48, Local1, arg1)) {
						// Store caused unexpected exception
						Return (1)
					}
				}
				if (Local1) {
					// Update the First Member Object
					Index(Derefof(arg1), 0, Local2)
					Store(Derefof(Local2), Local4)
					if (LEqual(ObjectType(Local4), 1)) {
						// Integer
						Store(Not(Local4), Derefof(Local3))
					} else {
						Store(Ones, Derefof(Local3))
						if (CH03(arg0, z122, 49, Local1, arg1)) {
							// Store caused unexpected exception
							Return (1)
						}
					}
				}
			} elseif (LEqual(Local0, 4)) {
				// Empty Package
				Store(Package(1){"update string"}, arg1)
			} else {
				// Empty String/Buffer
				Store("update string", arg1)
			}
		} elseif (Derefof(Index(b674, Local0))) {
			// Non-Computational Data Objects
			CopyObject("update string", arg1)
		} else {
			Store(Not(ToInteger(Derefof(arg1))), arg1)
		}

		if (CH03(arg0, z122, 50, Local0, arg1)) {
			// Update caused unexpected exception
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

		Name(scl0, Buffer() {0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0})
		Name(scl1, Buffer() {0,0,0,0,1,0,1,1,1,1,0,1,1,0,0,0,0,0})

		Concatenate(arg0, "-", arg0)
		Concatenate(arg0, Concatenate(Mid(arg4,0,2), Concatenate(Mid(arg2,0,2), Mid(arg3,0,2))), arg0)
		if (STCS) {Store(arg0, Debug)}

		// Choose expected Result Object type
//		if (LAnd(LEqual(arg4, 0), LEqual(arg3, 8))) {
		if (LEqual(arg3, 8)) {
			// Method expected to be invoked and result in String
			Store(2, Local5)
		} else {
			Store(arg3, Local5)
		}

		// Prepare Source of specified type
		Store(Index(arg6, 2), Local7)
		if (LEqual(arg3, 5)) {				// Field Unit Source
			Store(Derefof(Index(Derefof(Local7), 0)), Local0)
			if (LEqual(Local0, 0)) {
				Store(Refof(FLU0), Local6)
				Store(3, Local5)
			} elseif (LEqual(Local0, 1)) {
				Store(Refof(FLU2), Local6)
				if (F64) {
					Store(1, Local5)
				} else {
					Store(3, Local5)
				}
			} else {
				Store(Refof(FLU4), Local6)
				Store(1, Local5)
			}
		} elseif (LEqual(arg3, 14)) {		// Buffer Field Source
			Store(Derefof(Index(Derefof(Local7), 0)), Local0)
			if (LEqual(Local0, 0)) {
				Store(Refof(BFL0), Local6)
				Store(3, Local5)
			} elseif (LEqual(Local0, 1)) {
				Store(Refof(BFL2), Local6)
				if (F64) {
					Store(1, Local5)
				} else {
					Store(3, Local5)
				}
			} else {
				Store(Refof(BFL4), Local6)
				Store(1, Local5)
			}
		} else {
			Store(Refof(SRC0), Local6)
		}
		if (m004(Concatenate(arg0, "-m004"), arg3, Local6, Local7)) {
			// Source Object can not be prepared
			err(Concatenate(arg0, terr), z122, 51, 0, 0, arg3, 0)
			Return (1)
		}

		// Prepare Target of specified type
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (LEqual(arg2, 5)) {				// Field Unit Target
			Field(OPR0, ByteAcc, NoLock, Preserve) {FLUX, 192, FLU1, 69}
			Store(Refof(FLU1), Local1)
		} elseif (LEqual(arg2, 14)) {		// Buffer Field Target
			Createfield(BUFZ, 192, 69, BFL1)
			Store(Refof(BFL1), Local1)
		} else {
			Store(Refof(DST0), Local1)
		}
		if (m003(Concatenate(arg0, "-m003"), arg2, Local1, Local7)) {
			// Target Object can not be prepared
			err(Concatenate(arg0, terr), z122, 52, 0, 0, arg2, 0)
			Return (1)
		}

		if (CH03(arg0, z122, 53, arg3, arg2)) {
			// Unexpected exception during preparation
			Return (1)
		}

		// Use a Source Object to immediately store into the Target
		Store(Index(arg6, 2), Local7)
		if (LEqual(arg2, 5)) {				// Field Unit Target
			if (LEqual(arg4, 0)) {				// Store
				if (LEqual(arg3, 5)) {			// Field Unit Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						Store(FLU0, FLU1)
					} elseif (LEqual(Local0, 1)) {
						Store(FLU2, FLU1)
					} else {
						Store(FLU4, FLU1)
					}
				} elseif (LEqual(arg3, 14)) {	// Buffer Field Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						Store(BFL0, FLU1)
					} elseif (LEqual(Local0, 1)) {
						Store(BFL2, FLU1)
					} else {
						Store(BFL4, FLU1)
					}
				} else {
					Store(SRC0, FLU1)
				}
			} elseif (LEqual(arg4, 1)) {		// CopyObject
				if (LEqual(arg3, 5)) {			// Field Unit Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						CopyObject(FLU0, FLU1)
					} elseif (LEqual(Local0, 1)) {
						CopyObject(FLU2, FLU1)
					} else {
						CopyObject(FLU4, FLU1)
					}
				} elseif (LEqual(arg3, 14)) {	// Buffer Field Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						CopyObject(BFL0, FLU1)
					} elseif (LEqual(Local0, 1)) {
						CopyObject(BFL2, FLU1)
					} else {
						CopyObject(BFL4, FLU1)
					}
				} else {
					CopyObject(SRC0, FLU1)
				}
			} else {
				// Unexpected Kind of Op (0 - Store, ...)
				err(Concatenate(arg0, terr), z122, 54, 0, 0, arg4, 0)
				Return (1)
			}
		} elseif (LEqual(arg2, 14)) {		// Buffer Field Target
			if (LEqual(arg4, 0)) {				// Store
				if (LEqual(arg3, 5)) {			// Field Unit Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						Store(FLU0, BFL1)
					} elseif (LEqual(Local0, 1)) {
						Store(FLU2, BFL1)
					} else {
						Store(FLU4, BFL1)
					}
				} elseif (LEqual(arg3, 14)) {	// Buffer Field Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						Store(BFL0, BFL1)
					} elseif (LEqual(Local0, 1)) {
						Store(BFL2, BFL1)
					} else {
						Store(BFL4, BFL1)
					}
				} else {
					Store(SRC0, BFL1)
				}
			} elseif (LEqual(arg4, 1)) {		// CopyObject
				if (LEqual(arg3, 5)) {			// Field Unit Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						CopyObject(FLU0, BFL1)
					} elseif (LEqual(Local0, 1)) {
						CopyObject(FLU2, BFL1)
					} else {
						CopyObject(FLU4, BFL1)
					}
				} elseif (LEqual(arg3, 14)) {	// Buffer Field Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						CopyObject(BFL0, BFL1)
					} elseif (LEqual(Local0, 1)) {
						CopyObject(BFL2, BFL1)
					} else {
						CopyObject(BFL4, BFL1)
					}
				} else {
					CopyObject(SRC0, BFL1)
				}
			} else {
				// Unexpected Kind of Op (0 - Store, ...)
				err(Concatenate(arg0, terr), z122, 55, 0, 0, arg4, 0)
				Return (1)
			}

		} elseif (LEqual(arg4, 0)) {		// Store
			if (LEqual(arg3, 5)) {				// Field Unit Source
				Store(Derefof(Index(Derefof(Local7), 0)), Local0)
				if (LEqual(Local0, 0)) {
					Store(FLU0, DST0)
				} elseif (LEqual(Local0, 1)) {
					Store(FLU2, DST0)
				} else {
					Store(FLU4, DST0)
				}
			} elseif (LEqual(arg3, 14)) {		// Buffer Field Source
				Store(Derefof(Index(Derefof(Local7), 0)), Local0)
				if (LEqual(Local0, 0)) {
					Store(BFL0, DST0)
				} elseif (LEqual(Local0, 1)) {
					Store(BFL2, DST0)
				} else {
					Store(BFL4, DST0)
				}
			} else {
				Store(SRC0, DST0)
			}

		} elseif (LEqual(arg4, 1)) {		// CopyObject
			if (LEqual(arg3, 5)) {				// Field Unit Source
				Store(Derefof(Index(Derefof(Local7), 0)), Local0)
				if (LEqual(Local0, 0)) {
					CopyObject(FLU0, DST0)
				} elseif (LEqual(Local0, 1)) {
					CopyObject(FLU2, DST0)
				} else {
					CopyObject(FLU4, DST0)
				}
			} elseif (LEqual(arg3, 14)) {		// Buffer Field Source
				Store(Derefof(Index(Derefof(Local7), 0)), Local0)
				if (LEqual(Local0, 0)) {
					CopyObject(BFL0, DST0)
				} elseif (LEqual(Local0, 1)) {
					CopyObject(BFL2, DST0)
				} else {
					CopyObject(BFL4, DST0)
				}
			} else {
				CopyObject(SRC0, DST0)
			}

		} else {
			// Unexpected Kind of Op (0 - Store, ...)
			err(Concatenate(arg0, terr), z122, 56, 0, 0, arg4, 0)
			Return (1)
		}

		if (arg5) {
			// Exception is expected
			if (LAnd(LEqual(arg4, 1), LEqual(arg2, c016))) {
				if (X170) {
					if (LNot(CH06(arg0, 57, 0xff))) {
						if (STCS) {m000(2, 0x100, arg2, arg3)}
					}
				} else {
					CH03(arg0, z122, 57, arg3, arg2)
				}
			} else {
				if (LNot(CH06(arg0, 57, 0xff))) {
					if (STCS) {m000(2, 0x100, arg2, arg3)}
				}
			}
		} elseif (CH03(arg0, z122, 58, arg3, arg2)) {
			// Storing caused unexpected exception
			if (STCS) {m000(2, 0x100, arg2, arg3)}
		} else {
			// Check Target Object to have the expected type and value

			// Target accept type on storing to Named by Store operator is 0
			if (arg4) {
				Store(2, Local0)
			} else {
				Store(0, Local0)
			}

			m006(Concatenate(arg0, "-m006"), Local1, arg2, Local5, arg4, Local0, arg6)
		}

		// Check Source Object value and type is not corrupted after storing
		Store(Index(arg6, 2), Local7)
		if (m005(Concatenate(arg0, "-m005"), arg3, Local6, Local7)) {
			if (STCS) {
				Store("m008, Source Object has been corrupted during storing", Debug)
			}
			Return (1)
		}

		// Check auxiliary Target Object to have the initial type and value
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (m016(Concatenate(arg0, "-m016"), arg2, 0, Local7)) {
			if (STCS) {
				Store("m008, auxiliary Target Object has been corrupted during storing", Debug)
			}
			Return (1)
		}

		// Update Target Object
		if (m007(Concatenate(arg0, "-m007"), Local1)) {
			if (STCS) {
				Store("m008, Error during update of Target", Debug)
			}
			Return (1)
		}

		// Check Source Object value and type is not corrupted after updating the copy

		Store(Index(arg6, 2), Local7)

		if (y900) {
		    if (LAnd(LEqual(arg4, 0), LAnd(	// Store
				// Source type is 2-4
				Derefof(Index(Buffer() {0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0}, arg3)),
				// Target type is 4, 6-9, 11-12
				Derefof(Index(Buffer() {0,0,0,0,1,0,1,1,1,1,0,1,1,0,0,0,0,0}, arg2))))) {
			    if (X153) {
				    if (m005(Concatenate(arg0, "-m005"), arg3, Local6, Local7)) {
					    if (STCS) {
						    Store("m008, Source Object has been corrupted during update of Target", Debug)
					    }
				    }
			    }
		    } else {
			    if (m005(Concatenate(arg0, "-m005"), arg3, Local6, Local7)) {
				    if (STCS) {
					    Store("m008, Source Object has been corrupted during update of Target", Debug)
				    }
			    }
		    }
		} else {
		    if (LAnd(LEqual(arg4, 0), LAnd(	// Store
				// Source type is 2-4
				Derefof(Index(scl0, arg3)),
				// Target type is 4, 6-9, 11-12
				Derefof(Index(scl1, arg2))))) {
			    if (X153) {
				    if (m005(Concatenate(arg0, "-m005"), arg3, Local6, Local7)) {
					    if (STCS) {
						    Store("m008, Source Object has been corrupted during update of Target", Debug)
					    }
				    }
			    }
		    } else {
			    if (m005(Concatenate(arg0, "-m005"), arg3, Local6, Local7)) {
				    if (STCS) {
					    Store("m008, Source Object has been corrupted during update of Target", Debug)
				    }
			    }
		    }
		}

		// Check auxiliary Target Object to have the initial type and value
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (m016(Concatenate(arg0, "-m016"), arg2, 0, Local7)) {
			if (STCS) {
				Store("m008, auxiliary Target Object has been corrupted during update of Target", Debug)
			}
			Return (1)
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

		Concatenate(arg0, "-", arg0)
		Concatenate(arg0, Concatenate(Mid(arg4,0,2), Concatenate(Mid(arg2,0,2), Mid(arg3,0,2))), arg0)
		if (STCS) {Store(arg0, Debug)}

		// Choose expected Result Object type
//		if (LAnd(LEqual(arg4, 0), LEqual(arg3, 8))) {
		if (LEqual(arg3, 8)) {
			// Method expected to be invoked and result in String
			Store(2, Local5)
		} else {
			Store(arg3, Local5)
		}

		// Prepare Source of specified type
		Store(Index(arg6, 2), Local7)
		if (LEqual(arg3, 5)) {				// Field Unit Source
			Store(Derefof(Index(Derefof(Local7), 0)), Local0)
			if (LEqual(Local0, 0)) {
				Store(Refof(FLU0), Local6)
			} elseif (LEqual(Local0, 1)) {
				Store(Refof(FLU2), Local6)
				Store(3, Local5)
				if (F64) {
					Store(1, Local5)
				} else {
					Store(3, Local5)
				}
			} else {
				Store(Refof(FLU4), Local6)
				Store(1, Local5)
			}
		} elseif (LEqual(arg3, 14)) {		// Buffer Field Source
			Store(Derefof(Index(Derefof(Local7), 0)), Local0)
			if (LEqual(Local0, 0)) {
				Store(Refof(BFL0), Local6)
				Store(3, Local5)
			} elseif (LEqual(Local0, 1)) {
				Store(Refof(BFL2), Local6)
				if (F64) {
					Store(1, Local5)
				} else {
					Store(3, Local5)
				}
			} else {
				Store(Refof(BFL4), Local6)
				Store(1, Local5)
			}
		} else {
			Store(Refof(SRC0), Local6)
		}
		if (m004(Concatenate(arg0, "-m004"), arg3, Local6, Local7)) {
			// Source Object can not be prepared
			err(Concatenate(arg0, terr), z122, 59, 0, 0, arg3, 0)
			Return (1)
		}

		// Prepare Target of specified type
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (m003(Concatenate(arg0, "-m003"), arg2, Refof(Local4), Local7)) {
			// Target Object can not be prepared
			err(Concatenate(arg0, terr), z122, 60, 0, 0, arg2, 0)
			Return (1)
		}

		if (CH03(arg0, z122, 61, arg3, arg2)) {
			// Unexpected exception during preparation
			Return (1)
		}

		// Use a Source Object to immediately store into the Target
		Store(Index(arg6, 2), Local7)
		if (LEqual(arg4, 0)) {				// Store
			if (LEqual(arg3, 5)) {				// Field Unit Source
				Store(Derefof(Index(Derefof(Local7), 0)), Local0)
				if (LEqual(Local0, 0)) {
					Store(FLU0, Local4)
				} elseif (LEqual(Local0, 1)) {
					Store(FLU2, Local4)
				} else {
					Store(FLU4, Local4)
				}
			} elseif (LEqual(arg3, 14)) {		// Buffer Field Source
				Store(Derefof(Index(Derefof(Local7), 0)), Local0)
				if (LEqual(Local0, 0)) {
					Store(BFL0, Local4)
				} elseif (LEqual(Local0, 1)) {
					Store(BFL2, Local4)
				} else {
					Store(BFL4, Local4)
				}
			} else {
				Store(SRC0, Local4)
			}
		} elseif (LEqual(arg4, 1)) {		// CopyObject
			if (LEqual(arg3, 5)) {				// Field Unit Source
				Store(Derefof(Index(Derefof(Local7), 0)), Local0)
				if (LEqual(Local0, 0)) {
					CopyObject(FLU0, Local4)
				} elseif (LEqual(Local0, 1)) {
					CopyObject(FLU2, Local4)
				} else {
					CopyObject(FLU4, Local4)
				}
			} elseif (LEqual(arg3, 14)) {		// Buffer Field Source
				Store(Derefof(Index(Derefof(Local7), 0)), Local0)
				if (LEqual(Local0, 0)) {
					CopyObject(BFL0, Local4)
				} elseif (LEqual(Local0, 1)) {
					CopyObject(BFL2, Local4)
				} else {
					CopyObject(BFL4, Local4)
				}
			} else {
				CopyObject(SRC0, Local4)
			}
		} else {
			// Unexpected Kind of Op (0 - Store, ...)
			err(Concatenate(arg0, terr), z122, 62, 0, 0, arg4, 0)
			Return (1)
		}

		if (arg5) {
			// Exception is expected
			if (LNot(CH06(arg0, 15, 0xff))) {
				if (STCS) {m000(2, 0x100, arg2, arg3)}
			}
		} elseif (CH03(arg0, z122, 63, arg3, arg2)) {
			// Storing caused unexpected exception
			if (STCS) {m000(2, 0x100, arg2, arg3)}
		} else {
			// Check Target Object to have the expected type and value

			// Target accept type on storing to LocalX is 1
			Store(1, Local0)

			m006(Concatenate(arg0, "-m006"), Refof(Local4), arg2, Local5, arg4, Local0, arg6)
		}

		// Check Source Object value and type is not corrupted after storing
		Store(Index(arg6, 2), Local7)
		if (m005(Concatenate(arg0, "-m005"), arg3, Local6, Local7)) {
			if (STCS) {
				Store("m009, Source Object has been corrupted during storing", Debug)
			}
		}

		// Check auxiliary Target Object to have the initial type and value
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (m016(Concatenate(arg0, "-m016"), arg2, 0, Local7)) {
			if (STCS) {
				Store("m009, auxiliary Target Object has been corrupted during storing", Debug)
			}
			Return (1)
		}

		// Update Target Object
		if (m007(Concatenate(arg0, "-m007"), Refof(Local4))) {
			if (STCS) {
				Store("m009, Error during update of Target", Debug)
			}
			Return (1)
		}

		// Check Source Object value and type is not corrupted after updating the copy
		Store(Index(arg6, 2), Local7)
		if (m005(Concatenate(arg0, "-m005"), arg3, Local6, Local7)) {
			if (STCS) {
				Store("m009, Source Object has been corrupted during update of Target", Debug)
			}
		}

		// Check auxiliary Target Object to have the initial type and value
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (m016(Concatenate(arg0, "-m016"), arg2, 0, Local7)) {
			if (STCS) {
				Store("m009, auxiliary Target Object has been corrupted during update of Target", Debug)
			}
			Return (1)
		}

		Return (0)
	}

	// Check processing of an Source LocalX Object of the specified type
	// on immediate storing to a Target Named Object of the specified type
	// m00a(<msg>, <aux>, <target type>, <source type>,
	//      <op>, <exc. condition>, <test data package>)
	Method(m00a, 7, Serialized)
	{
		// Source Object: Local1
		// Target Named Object (or the reference to it in case of Fields)
		Name(DST0, 0)

		Name(scl0, Buffer() {0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0})
		Name(scl1, Buffer() {0,0,0,0,1,0,1,1,1,1,0,1,1,0,0,0,0,0})

		Concatenate(arg0, "-", arg0)
		Concatenate(arg0, Concatenate(Mid(arg4,0,2), Concatenate(Mid(arg2,0,2), Mid(arg3,0,2))), arg0)
		if (STCS) {Store(arg0, Debug)}

		// Prepare Source of specified type
		Store(Index(arg6, 2), Local7)
		if (m004(Concatenate(arg0, "-m004"), arg3, Refof(Local1), Local7)) {
			// Source Object can not be prepared
			err(Concatenate(arg0, terr), z122, 64, 0, 0, arg3, 0)
			Return (1)
		}

		// Prepare Target of specified type
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (LEqual(arg2, 5)) {				// Field Unit Target
			Field(OPR0, ByteAcc, NoLock, Preserve) {FLUX, 192, FLU1, 69}
			Store(Refof(FLU1), Local4)
		} elseif (LEqual(arg2, 14)) {		// Buffer Field Target
			Createfield(BUFZ, 192, 69, BFL1)
			Store(Refof(BFL1), Local4)
		} else {
			Store(Refof(DST0), Local4)
		}
		if (m003(Concatenate(arg0, "-m003"), arg2, Local4, Local7)) {
			// Target Object can not be prepared
			err(Concatenate(arg0, terr), z122, 65, 0, 0, arg2, 0)
			Return (1)
		}

		if (CH03(arg0, z122, 66, arg3, arg2)) {
			// Unexpected exception during preparation
			Return (1)
		}

		// Use a Source Object to immediately store into the Target
		if (LEqual(arg2, 5)) {		// Field Unit Target
			if (LEqual(arg4, 0)) {				// Store
				Store(Local1, FLU1)
			} elseif (LEqual(arg4, 1)) {		// CopyObject
				CopyObject(Local1, FLU1)
			} else {
				// Unexpected Kind of Op (0 - Store, ...)
				err(Concatenate(arg0, terr), z122, 67, 0, 0, arg4, 0)
				Return (1)
			}
		} elseif (LEqual(arg2, 14)) {		// Buffer Field Target
			if (LEqual(arg4, 0)) {				// Store
				Store(Local1, BFL1)
			} elseif (LEqual(arg4, 1)) {		// CopyObject
				CopyObject(Local1, BFL1)
			} else {
				// Unexpected Kind of Op (0 - Store, ...)
				err(Concatenate(arg0, terr), z122, 68, 0, 0, arg4, 0)
				Return (1)
			}

		} elseif (LEqual(arg4, 0)) {		// Store
			Store(Local1, DST0)

		} elseif (LEqual(arg4, 1)) {		// CopyObject
				CopyObject(Local1, DST0)

		} else {
			// Unexpected Kind of Op (0 - Store, ...)
			err(Concatenate(arg0, terr), z122, 69, 0, 0, arg4, 0)
			Return (1)
		}

		if (arg5) {
			// Exception is expected
			if (LAnd(LEqual(arg4, 1), LAnd(LEqual(arg2, c016), LNotEqual(arg3, c008)))) {
				if (X170) {
					if (LNot(CH06(arg0, 70, 0xff))) {
						if (STCS) {m000(2, 0x100, arg2, arg3)}
					}
				} else {
					CH03(arg0, z122, 70, arg3, arg2)
				}
			} else {
				if (LNot(CH06(arg0, 70, 0xff))) {
					if (STCS) {m000(2, 0x100, arg2, arg3)}
				}
			}
		} elseif (CH03(arg0, z122, 71, arg3, arg2)) {
			// Storing caused unexpected exception
			if (STCS) {m000(2, 0x100, arg2, arg3)}
		} else {
			// Check Target Object to have the expected type and value

			// Target accept type on storing to Named of Store operator is 0
			if (arg4) {
				Store(2, Local0)
			} else {
				Store(0, Local0)
			}

			m006(Concatenate(arg0, "-m006"), Local4, arg2, arg3, arg4, Local0, arg6)
		}

		// Check Source Object value and type is not corrupted after storing
		Store(Index(arg6, 2), Local7)
		if (m005(Concatenate(arg0, "-m005"), arg3, Refof(Local1), Local7)) {
			if (STCS) {
				Store("m00a, Source Object has been corrupted during storing", Debug)
			}
		}

		// Check auxiliary Target Object to have the initial type and value
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (m016(Concatenate(arg0, "-m016"), arg2, 0, Local7)) {
			if (STCS) {
				Store("m00a, auxiliary Target Object has been corrupted during storing", Debug)
			}
			Return (1)
		}

		// Update Target Object
		if (m007(Concatenate(arg0, "-m007"), Local4)) {
			if (STCS) {
				Store("m00a, Error during update of Target", Debug)
			}
			Return (1)
		}

		// Check Source Object value and type is not corrupted after updating the copy

		Store(Index(arg6, 2), Local7)

		if (y900) {

		if (LAnd(LEqual(arg4, 0), LAnd(	// Store
				// Source type is 2-4
				Derefof(Index(Buffer() {0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0}, arg3)),
				// Target type is 4, 6-9, 11-12
				Derefof(Index(Buffer() {0,0,0,0,1,0,1,1,1,1,0,1,1,0,0,0,0,0}, arg2))))) {
			if (X153) {
				if (m005(Concatenate(arg0, "-m005"), arg3, Refof(Local1), Local7)) {
					if (STCS) {
						Store("m00a, Source Object has been corrupted during update of Target", Debug)
					}
				}
			}
		} else {
			if (m005(Concatenate(arg0, "-m005"), arg3, Refof(Local1), Local7)) {
				if (STCS) {
					Store("m00a, Source Object has been corrupted during update of Target", Debug)
				}
			}
		}

		} else { // if (y900)

		if (LAnd(LEqual(arg4, 0), LAnd(	// Store
				// Source type is 2-4
				Derefof(Index(scl0, arg3)),
				// Target type is 4, 6-9, 11-12
				Derefof(Index(scl1, arg2))))) {
			if (X153) {
				if (m005(Concatenate(arg0, "-m005"), arg3, Refof(Local1), Local7)) {
					if (STCS) {
						Store("m00a, Source Object has been corrupted during update of Target", Debug)
					}
				}
			}
		} else {
			if (m005(Concatenate(arg0, "-m005"), arg3, Refof(Local1), Local7)) {
				if (STCS) {
					Store("m00a, Source Object has been corrupted during update of Target", Debug)
				}
			}
		}
		} // if (y900)

		// Check auxiliary Target Object to have the initial type and value
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (m016(Concatenate(arg0, "-m016"), arg2, 0, Local7)) {
			if (STCS) {
				Store("m00a, auxiliary Target Object has been corrupted during update of Target", Debug)
			}
			Return (1)
		}

		Return (0)
	}

	// Check processing of an Source LocalX Object of the specified type
	// on immediate storing to a Target LocalX Object of the specified type
	// m00b(<msg>, <aux>, <target type>, <source type>,
	//      <op>, <exc. condition>, <test data package>)
	Method(m00b, 7)
	{
		// Source LocalX Object: Local1
		// Target LocalX Object: Local4

		Concatenate(arg0, "-", arg0)
		Concatenate(arg0, Concatenate(Mid(arg4,0,2), Concatenate(Mid(arg2,0,2), Mid(arg3,0,2))), arg0)
		if (STCS) {Store(arg0, Debug)}

		// Prepare Source of specified type
		Store(Index(arg6, 2), Local7)
		if (m004(Concatenate(arg0, "-m004"), arg3, Refof(Local1), Local7)) {
			// Source Object can not be prepared
			err(Concatenate(arg0, terr), z122, 72, 0, 0, arg3, 0)
			Return (1)
		}

		// Prepare Target of specified type
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (m003(Concatenate(arg0, "-m003"), arg2, Refof(Local4), Local7)) {
			// Target Object can not be prepared
			err(Concatenate(arg0, terr), z122, 73, 0, 0, arg2, 0)
			Return (1)
		}

		if (CH03(arg0, z122, 74, arg3, arg2)) {
			// Unexpected exception during preparation
			Return (1)
		}

		// Use a Source Object to immediately store into the Target
		if (LEqual(arg4, 0)) {			// Store
				Store(Local1, Local4)
		} elseif (LEqual(arg4, 1)) {	// CopyObject
				CopyObject(Local1, Local4)
		} else {
			// Unexpected Kind of Op (0 - Store, ...)
			err(Concatenate(arg0, terr), z122, 75, 0, 0, arg4, 0)
			Return (1)
		}

		if (arg5) {
			// Exception is expected
			if (LNot(CH06(arg0, 15, 0xff))) {
				if (STCS) {m000(2, 0x100, arg2, arg3)}
			}
		} elseif (CH03(arg0, z122, 76, arg3, arg2)) {
			// Storing caused unexpected exception
			if (STCS) {m000(2, 0x100, arg2, arg3)}
		} else {
			// Check Target Object to have the expected type and value

			// Target accept type on storing to LocalX is 1
			Store(1, Local0)

			m006(Concatenate(arg0, "-m006"), Refof(Local4), arg2, arg3, arg4, Local0, arg6)
		}

		// Check Source Object value and type is not corrupted after storing
		Store(Index(arg6, 2), Local7)
		if (m005(Concatenate(arg0, "-m005"), arg3, Refof(Local1), Local7)) {
			if (STCS) {
				Store("m00b, Source Object has been corrupted during storing", Debug)
			}
		}

		// Check auxiliary Target Object to have the initial type and value
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (m016(Concatenate(arg0, "-m016"), arg2, 0, Local7)) {
			if (STCS) {
				Store("m00b, auxiliary Target Object has been corrupted during storing", Debug)
			}
			Return (1)
		}

		// Update Target Object
		if (m007(Concatenate(arg0, "-m007"), Refof(Local4))) {
			if (STCS) {
				Store("m00b, Error during update of Target", Debug)
			}
			Return (1)
		}

		// Check Source Object value and type is not corrupted after updating the copy
		Store(Index(arg6, 2), Local7)
		if (m005(Concatenate(arg0, "-m005"), arg3, Refof(Local1), Local7)) {
			if (STCS) {
				Store("m00b, Source Object has been corrupted during update of Target", Debug)
			}
		}

		// Check auxiliary Target Object to have the initial type and value
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (m016(Concatenate(arg0, "-m016"), arg2, 0, Local7)) {
			if (STCS) {
				Store("m00b, auxiliary Target Object has been corrupted during update of Target", Debug)
			}
			Return (1)
		}

		Return (0)
	}

	// Check processing of an Source Named Object of the specified type
	// on immediate storing to an argument of Method passed to as immediate
	// Named Object of another specified type
	// m00c(<msg>, <aux>, <target type>, <source type>,
	//      <op>, <exc. condition>, <test data package>)
	Method(m00c, 7, Serialized)
	{
		Method(m10c, 7, Serialized)
		{
			// Source Named Object
			Name(SRC0, 0)
			// Target Named Object: ARG1

			// Choose expected Result Object type
//			if (LAnd(LEqual(arg4, 0), LEqual(arg3, 8))) {
			if (LEqual(arg3, 8)) {
				// Method expected to be invoked and result in String
				Store(2, Local5)
			} else {
				Store(arg3, Local5)
			}

			// Prepare Source of specified type
			Store(Index(arg6, 2), Local7)
			if (LEqual(arg3, 5)) {				// Field Unit Source
				Store(Derefof(Index(Derefof(Local7), 0)), Local0)
				if (LEqual(Local0, 0)) {
					Store(Refof(FLU0), Local6)
					Store(3, Local5)
				} elseif (LEqual(Local0, 1)) {
					Store(Refof(FLU2), Local6)
					if (F64) {
						Store(1, Local5)
					} else {
						Store(3, Local5)
					}
				} else {
					Store(Refof(FLU4), Local6)
					Store(1, Local5)
				}
			} elseif (LEqual(arg3, 14)) {		// Buffer Field Source
				Store(Derefof(Index(Derefof(Local7), 0)), Local0)
				if (LEqual(Local0, 0)) {
					Store(Refof(BFL0), Local6)
					Store(3, Local5)
				} elseif (LEqual(Local0, 1)) {
					Store(Refof(BFL2), Local6)
					if (F64) {
						Store(1, Local5)
					} else {
						Store(3, Local5)
					}
				} else {
					Store(Refof(BFL4), Local6)
					Store(1, Local5)
				}
			} else {
				Store(Refof(SRC0), Local6)
			}
			if (m004(Concatenate(arg0, "-m004"), arg3, Local6, Local7)) {
				// Source Object can not be prepared
				err(Concatenate(arg0, terr), z122, 77, 0, 0, arg3, 0)
				Return (1)
			}

			Store(Refof(ARG1), Local1)

			if (CH03(arg0, z122, 78, arg3, arg2)) {
				// Unexpected exception during preparation
				Return (1)
			}

			// Use a Source Object to immediately store into the Target
			Store(Index(arg6, 2), Local7)
			if (LEqual(arg4, 0)) {		// Store
				if (LEqual(arg3, 5)) {				// Field Unit Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						Store(FLU0, ARG1)
					} elseif (LEqual(Local0, 1)) {
						Store(FLU2, ARG1)
					} else {
						Store(FLU4, ARG1)
					}
				} elseif (LEqual(arg3, 14)) {		// Buffer Field Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						Store(BFL0, ARG1)
					} elseif (LEqual(Local0, 1)) {
						Store(BFL2, ARG1)
					} else {
						Store(BFL4, ARG1)
					}
				} else {
					Store(SRC0, ARG1)
				}

			} elseif (LEqual(arg4, 1)) {		// CopyObject
				if (LEqual(arg3, 5)) {				// Field Unit Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						CopyObject(FLU0, ARG1)
					} elseif (LEqual(Local0, 1)) {
						CopyObject(FLU2, ARG1)
					} else {
						CopyObject(FLU4, ARG1)
					}
				} elseif (LEqual(arg3, 14)) {		// Buffer Field Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						CopyObject(BFL0, ARG1)
					} elseif (LEqual(Local0, 1)) {
						CopyObject(BFL2, ARG1)
					} else {
						CopyObject(BFL4, ARG1)
					}
				} else {
					CopyObject(SRC0, ARG1)
				}

			} else {
				// Unexpected Kind of Op (0 - Store, ...)
				err(Concatenate(arg0, terr), z122, 79, 0, 0, arg4, 0)
				Return (1)
			}

			if (arg5) {
				// Exception is expected
				if (LOr(
						LAnd(LEqual(arg4, 0), LAnd(LEqual(arg2, c016), LEqual(arg3, c00c))),
						LAnd(LEqual(arg4, 1), LAnd(LEqual(arg2, c016), LNotEqual(arg3, c008))))) {
					if (X170) {
						if (LNot(CH06(arg0, 80, 0xff))) {
							if (STCS) {m000(2, 0x100, arg2, arg3)}
						}
					} else {
						CH03(arg0, z122, 80, arg3, arg2)
					}
				} else {
					if (LNot(CH06(arg0, 80, 0xff))) {
						if (STCS) {m000(2, 0x100, arg2, arg3)}
					}
				}
			} elseif (CH03(arg0, z122, 81, arg3, arg2)) {
				// Storing caused unexpected exception
				if (STCS) {m000(2, 0x100, arg2, arg3)}
			} else {
				// Check Target Object to have the expected type and value

				// Target accept type on storing to read-only ArgX is 1
				Store(1, Local0)

				m006(Concatenate(arg0, "-m006"), Local1, arg2, Local5, arg4, Local0, arg6)
			}

			// Check Source Object value and type is not corrupted after storing
			Store(Index(arg6, 2), Local7)
			if (m005(Concatenate(arg0, "-m005"), arg3, Local6, Local7)) {
				if (STCS) {
					Store("m00c, Source Object has been corrupted during storing", Debug)
				}
				Return (1)
			}

			// Check auxiliary Target Object to have the initial type and value
			Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
			if (m016(Concatenate(arg0, "-m016"), arg2, 0, Local7)) {
				if (STCS) {
					Store("m00c, auxiliary Target Object has been corrupted during storing", Debug)
				}
				Return (1)
			}

			// Update Target Object
			if (m007(Concatenate(arg0, "-m007"), Local1)) {
				if (STCS) {
					Store("m00c, Error during update of Target", Debug)
				}
				Return (1)
			}

			// Check Source Object value and type is not corrupted after updating the copy
			Store(Index(arg6, 2), Local7)
			if (m005(Concatenate(arg0, "-m005"), arg3, Local6, Local7)) {
				if (STCS) {
					Store("m00c, Source Object has been corrupted during update of Target", Debug)
				}
			}

			// Check auxiliary Target Object to have the initial type and value
			Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
			if (m016(Concatenate(arg0, "-m016"), arg2, 0, Local7)) {
				if (STCS) {
					Store("m00c, auxiliary Target Object has been corrupted during update of Target", Debug)
				}
				Return (1)
			}

			Return (0)
		}

		// Target Named Object
		Name(DST0, 0)

		Concatenate(arg0, "-", arg0)
		Concatenate(arg0, Concatenate(Mid(arg4,0,2), Concatenate(Mid(arg2,0,2), Mid(arg3,0,2))), arg0)
		if (STCS) {Store(arg0, Debug)}

		// Prepare Target of specified type
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (LEqual(arg2, 5)) {				// Field Unit Target
			Field(OPR0, ByteAcc, NoLock, Preserve) {FLUX, 192, FLU1, 69}
			Store(Refof(FLU1), Local1)
			Store(Derefof(Local7), FLU1)
		} elseif (LEqual(arg2, 14)) {		// Buffer Field Target
			Createfield(BUFZ, 192, 69, BFL1)
			Store(Refof(BFL1), Local1)
			Store(Derefof(Local7), BFL1)
		} else {
			Store(Refof(DST0), Local1)
		}
		if (m003(Concatenate(arg0, "-m003"), arg2, Local1, Local7)) {
			// Target Object can not be prepared
			err(Concatenate(arg0, terr), z122, 82, 0, 0, arg2, 0)
			Return (1)
		}

		if (CH03(arg0, z122, 83, arg3, arg2)) {
			// Unexpected exception during preparation
			Return (1)
		}

		// Use the Target Object to be the ArgX Object
		if (m10c(Concatenate(arg0, "-m10c"), DST0, arg2, arg3, arg4, arg5, arg6)) {
			if (STCS) {
				Store("m00c, error on using the Target Object as the ArgX Object", Debug)
			}
			Return (1)
		}

		if (arg5) {
			// Exception is expected
			Return (0)
		}

		// Check Target Object to be saving the initial type and value
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (m015(Concatenate(arg0, "-m015"), arg2, Local1, Local7)) {
			if (STCS) {
				Store("m00c, Target Object has been corrupted during storing to ArgX", Debug)
			}
			Return (1)
		}

		Return (0)
	}

	// Check processing of an Source Named Object of the specified type
	// on immediate storing to an argument of Method passed to as reference
	// to the Named Object of another specified type
	// m00d(<msg>, <aux>, <target type>, <source type>,
	//      <op>, <exc. condition>, <test data package>)
	Method(m00d, 7, Serialized)
	{
		Method(m10d, 7, Serialized)
		{
			// Source Named Object
			Name(SRC0, 0)
			// Target Named Object: ARG1

			// Choose expected Result Object type
//			if (LAnd(LEqual(arg4, 0), LEqual(arg3, 8))) {
			if (LEqual(arg3, 8)) {
				// Method expected to be invoked and result in String
				Store(2, Local5)
			} else {
				Store(arg3, Local5)
			}

			// Prepare Source of specified type
			Store(Index(arg6, 2), Local7)
			if (LEqual(arg3, 5)) {				// Field Unit Source
				Store(Derefof(Index(Derefof(Local7), 0)), Local0)
				if (LEqual(Local0, 0)) {
					Store(Refof(FLU0), Local6)
					Store(3, Local5)
				} elseif (LEqual(Local0, 1)) {
					Store(Refof(FLU2), Local6)
					if (F64) {
						Store(1, Local5)
					} else {
						Store(3, Local5)
					}
				} else {
					Store(Refof(FLU4), Local6)
					Store(1, Local5)
				}
			} elseif (LEqual(arg3, 14)) {		// Buffer Field Source
				Store(Derefof(Index(Derefof(Local7), 0)), Local0)
				if (LEqual(Local0, 0)) {
					Store(Refof(BFL0), Local6)
					Store(3, Local5)
				} elseif (LEqual(Local0, 1)) {
					Store(Refof(BFL2), Local6)
					if (F64) {
						Store(1, Local5)
					} else {
						Store(3, Local5)
					}
				} else {
					Store(Refof(BFL4), Local6)
					Store(1, Local5)
				}
			} else {
				Store(Refof(SRC0), Local6)
			}
			if (m004(Concatenate(arg0, "-m004"), arg3, Local6, Local7)) {
				// Source Object can not be prepared
				err(Concatenate(arg0, terr), z122, 84, 0, 0, arg3, 0)
				Return (1)
			}

			if (CH03(arg0, z122, 85, arg3, arg2)) {
				// Unexpected exception during preparation
				Return (1)
			}

			// Use a Source Object to immediately store into the Target
			Store(Index(arg6, 2), Local7)
			if (LEqual(arg4, 0)) {		// Store
				if (LEqual(arg3, 5)) {				// Field Unit Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						Store(FLU0, ARG1)
					} elseif (LEqual(Local0, 1)) {
						Store(FLU2, ARG1)
					} else {
						Store(FLU4, ARG1)
					}
				} elseif (LEqual(arg3, 14)) {		// Buffer Field Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						Store(BFL0, ARG1)
					} elseif (LEqual(Local0, 1)) {
						Store(BFL2, ARG1)
					} else {
						Store(BFL4, ARG1)
					}
				} else {
					Store(SRC0, ARG1)
				}

			} elseif (LEqual(arg4, 1)) {		// CopyObject
				if (LEqual(arg3, 5)) {				// Field Unit Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						CopyObject(FLU0, ARG1)
					} elseif (LEqual(Local0, 1)) {
						CopyObject(FLU2, ARG1)
					} else {
						CopyObject(FLU4, ARG1)
					}
				} elseif (LEqual(arg3, 14)) {		// Buffer Field Source
					Store(Derefof(Index(Derefof(Local7), 0)), Local0)
					if (LEqual(Local0, 0)) {
						CopyObject(BFL0, ARG1)
					} elseif (LEqual(Local0, 1)) {
						CopyObject(BFL2, ARG1)
					} else {
						CopyObject(BFL4, ARG1)
					}
				} else {
					CopyObject(SRC0, ARG1)
				}

			} else {
				// Unexpected Kind of Op (0 - Store, ...)
				err(Concatenate(arg0, terr), z122, 86, 0, 0, arg4, 0)
				Return (1)
			}

			if (arg5) {
				// Exception is expected
				if (LAnd(LEqual(arg4, 1), LEqual(arg2, c016))) {
					if (X170) {
						if (LNot(CH06(arg0, 87, 0xff))) {
							if (STCS) {m000(2, 0x100, arg2, arg3)}
						}
					} else {
						CH03(arg0, z122, 87, arg3, arg2)
					}
				} else {
					if (LNot(CH06(arg0, 87, 0xff))) {
						if (STCS) {m000(2, 0x100, arg2, arg3)}
					}
				}
			} elseif (CH03(arg0, z122, 88, arg3, arg2)) {
				// Storing caused unexpected exception
				if (STCS) {m000(2, 0x100, arg2, arg3)}
			} else {
				// Check Target Object to have the expected type and value

				// Target accept type on storing to ArgX containing reference is 1
				// (besides Store() to fixed types)
				if (LAnd(LEqual(arg4, 0), Derefof(Index(b678, arg2)))) {
					Store(0, Local0)
				} else {
					Store(1, Local0)
				}

				m006(Concatenate(arg0, "-m006"), ARG1, arg2, Local5, arg4, Local0, arg6)
			}

			// Check Source Object value and type is not corrupted after storing
			Store(Index(arg6, 2), Local7)
			if (m005(Concatenate(arg0, "-m005"), arg3, Local6, Local7)) {
				if (STCS) {
					Store("m00d, Source Object has been corrupted during storing", Debug)
				}
				Return (1)
			}

			// Check auxiliary Target Object to have the initial type and value
			Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
			if (m016(Concatenate(arg0, "-m016"), arg2, 0, Local7)) {
				if (STCS) {
					Store("m00d, auxiliary Target Object has been corrupted during storing", Debug)
				}
				Return (1)
			}

			// Update Target Object
			if (m007(Concatenate(arg0, "-m007"), ARG1)) {
				if (STCS) {
					Store("m00d, Error during update of Target", Debug)
				}
				Return (1)
			}

			// Check Source Object value and type is not corrupted after updating the copy
			Store(Index(arg6, 2), Local7)
			if (m005(Concatenate(arg0, "-m005"), arg3, Local6, Local7)) {
				if (STCS) {
					Store("m00d, Source Object has been corrupted during update of Target", Debug)
				}
			}

			// Check auxiliary Target Object to have the initial type and value
			Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
			if (m016(Concatenate(arg0, "-m016"), arg2, 0, Local7)) {
				if (STCS) {
					Store("m00d, auxiliary Target Object has been corrupted during update of Target", Debug)
				}
				Return (1)
			}

			Return (0)
		}

		// Target Named Object
		Name(DST0, 0)

		Concatenate(arg0, "-", arg0)
		Concatenate(arg0, Concatenate(Mid(arg4,0,2), Concatenate(Mid(arg2,0,2), Mid(arg3,0,2))), arg0)
		if (STCS) {Store(arg0, Debug)}

		// Prepare Target of specified type
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (LEqual(arg2, 5)) {				// Field Unit Target
			Field(OPR0, ByteAcc, NoLock, Preserve) {FLUX, 192, FLU1, 69}
			Store(Refof(FLU1), Local1)
			Store(Derefof(Local7), FLU1)
		} elseif (LEqual(arg2, 14)) {		// Buffer Field Target
			Createfield(BUFZ, 192, 69, BFL1)
			Store(Refof(BFL1), Local1)
			Store(Derefof(Local7), BFL1)
		} else {
			Store(Refof(DST0), Local1)
		}
		if (m003(Concatenate(arg0, "-m003"), arg2, Local1, Local7)) {
			// Target Object can not be prepared
			err(Concatenate(arg0, terr), z122, 89, 0, 0, arg2, 0)
			Return (1)
		}

		if (CH03(arg0, z122, 90, arg3, arg2)) {
			// Unexpected exception during preparation
			Return (1)
		}

		// Use the reference to Target Object to be the ArgX Object
		if (m10d(Concatenate(arg0, "-m10d"), Refof(DST0), arg2, arg3, arg4, arg5, arg6)) {
			if (STCS) {
				Store("m00d, error on using the Target Object as the ArgX Object", Debug)
			}
			Return (1)
		}

		Return (0)
	}

	// Check processing of an Source LocalX Object of the specified type
	// on immediate storing to an Element of Package of the specified type
	// m00e(<msg>, <aux>, <target type>, <source type>,
	//      <op>, <exc. condition>, <test data package>)
	Method(m00e, 7, Serialized)
	{
		// Source LocalX Object: Local1
		// Target Package
		Name(DST0, Package(1){})

		Concatenate(arg0, "-", arg0)
		Concatenate(arg0, Concatenate(Mid(arg4,0,2), Concatenate(Mid(arg2,0,2), Mid(arg3,0,2))), arg0)
		if (STCS) {Store(arg0, Debug)}

		// Prepare Source of specified type
		Store(Index(arg6, 2), Local7)
		if (m004(Concatenate(arg0, "-m004"), arg3, Refof(Local1), Local7)) {
			// Source Object can not be prepared
			err(Concatenate(arg0, terr), z122, 91, 0, 0, arg3, 0)
			Return (1)
		}

		// Prepare Target of specified type
		Index(DST0, 0, Local4)
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (m013(Concatenate(arg0, "-m003"), arg2, DST0, Local7)) {
			// Target Object can not be prepared
			err(Concatenate(arg0, terr), z122, 92, 0, 0, arg2, 0)
			Return (1)
		}

		if (CH03(arg0, z122, 93, arg3, arg2)) {
			// Unexpected exception during preparation
			Return (1)
		}

		// Check Target Object to have the initial type and value
		if (m015(Concatenate(arg0, "-m015"), arg2, Local4, Local7)) {
			// Target Object can not be prepared
			err(Concatenate(arg0, terr), z122, 94, 0, 0, arg2, 0)
			Return (1)
		}

		// Use a Source Object to immediately store into the Target
		if (LEqual(arg4, 0)) {			// Store
				Store(Local1, Index(DST0, 0))
		//} elseif (LEqual(arg4, 1)) {	// CopyObject
		//		CopyObject(Local1, Index(DST0, 0))
		} else {
			// Unexpected Kind of Op (0 - Store, ...)
			err(Concatenate(arg0, terr), z122, 95, 0, 0, arg4, 0)
			Return (1)
		}

		if (arg5) {
			// Exception is expected
			if (LNot(CH06(arg0, 96, 0xff))) {
				if (STCS) {m000(2, 0x100, arg2, arg3)}
			}
		} elseif (CH03(arg0, z122, 97, arg3, arg2)) {
			// Storing caused unexpected exception
			if (STCS) {m000(2, 0x100, arg2, arg3)}
		} else {
			// Check Target Object to have the expected type and value

			// Target accept type on storing to an Element of Package is 1
			Store(1, Local0)

			m006(Concatenate(arg0, "-m006"), Local4, arg2, arg3, arg4, Local0, arg6)
		}

		// Check Source Object value and type is not corrupted after storing
		Store(Index(arg6, 2), Local7)
		if (m005(Concatenate(arg0, "-m005"), arg3, Refof(Local1), Local7)) {
			if (STCS) {
				Store("m00e, Source Object has been corrupted during storing", Debug)
			}
		}

		// Check auxiliary Target Object to have the initial type and value
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (m016(Concatenate(arg0, "-m016"), arg2, 0, Local7)) {
			if (STCS) {
				Store("m00e, auxiliary Target Object has been corrupted during storing", Debug)
			}
			Return (1)
		}

		// Update Target Object
		if (m017(Concatenate(arg0, "-m007"), DST0)) {
			if (STCS) {
				Store("m00e, Error during update of Target", Debug)
			}
			Return (1)
		}

		// Check Source Object value and type is not corrupted after updating the copy
		Store(Index(arg6, 2), Local7)
		if (m005(Concatenate(arg0, "-m005"), arg3, Refof(Local1), Local7)) {
			if (STCS) {
				Store("m00e, Source Object has been corrupted during update of Target", Debug)
			}
		}

		// Check auxiliary Target Object to have the initial type and value
		Store(Index(Derefof(Index(arg6, 3)), arg2), Local7)
		if (m016(Concatenate(arg0, "-m016"), arg2, 0, Local7)) {
			if (STCS) {
				Store("m00e, auxiliary Target Object has been corrupted during update of Target", Debug)
			}
			Return (1)
		}

		Return (0)
	}

	// Prepare Target as Package Element of specified type
	Method(m013, 4, Serialized)
	{
		Switch(ToInteger(arg1)) {
			Case(0) {	// Only check
			}
			Case(1) {
				CopyObject(Derefof(arg3), INT1)
				Store(INT1, Index(arg2, 0))
			}
			Case(2) {
				CopyObject(Derefof(arg3), STR1)
				Store(STR1, Index(arg2, 0))
			}
			Case(3) {
				if (y136) {
					CopyObject(Derefof(arg3), BUF1)
				} else {
					m687(Derefof(arg3), Refof(BUF1))
				}
				Store(BUF1, Index(arg2, 0))
			}
			Case(4) {
				CopyObject(Derefof(arg3), PAC1)
				Store(PAC1, Index(arg2, 0))
			}
			Case(17) {
				CopyObject(Refof(ORF1), REF1)
				if (y522) {
					Store(REF1, Index(arg2, 0))
				} else {
					Store(DeRefof(REF1), Index(arg2, 0))
				}
			}
			Default {
				// Unexpected Target Type
				err(Concatenate(arg0, terr), z122, 98, 0, 0, arg1, 0)
				Return (1)
			}
		}
		if (CH03(arg0, z122, 99, arg1, 0)) {
			//Exception during preparing of Target Object
			Return (1)
		}

		if (LEqual(arg1, 17)) {
			// Reference
			Return (0)
		}

		Store(ObjectType(Index(arg2, 0)), Local0)
		if (LNotEqual(Local0, arg1)) {
			// ObjectType of Target can not be set up
			err(arg0, z122, 100, 0, 0, Local0, arg1)
			Return (1)
		}

		Return (0)
	}

	// Check Target Object type is not corrupted after storing,
	// for the computational data types verify its value against
	// the Object-initializer value
	Method(m015, 4, Serialized)
	{
		Name(MMM2, 0) // An auxiliary Object to invoke Method

		if (LEqual(arg1, 17)) {
			// Target object is a reference
			// Check that it can be used as reference
			Store(Derefof(arg2), Local0)
			Store(Derefof(Local0), Local3)
			if (CH03(arg0, z122, 101, arg1, Local0)) {
				// Derefof caused unexpected exception
				Return (1)
			}
		} else {
			Store(ObjectType(arg2), Local0)
			if (LNotEqual(Local0, arg1)) {
				// ObjectType of Target object is corrupted
				err(arg0, z122, 102, 0, 0, Local0, arg1)
				Return (1)
			}
		}

		Switch(ToInteger(arg1)) {
			Case(0) {
				Return (0)
			}
			Case(1) {
				Store(ObjectType(INT1), Local0)
			}
			Case(2) {
				Store(ObjectType(STR1), Local0)
			}
			Case(3) {
				Store(ObjectType(BUF1), Local0)
			}
			Case(4) {
				Store(ObjectType(PAC1), Local0)
			}
			Case(5) {
				Store(5, Local0)
			}
			Case(6) {
				Store(ObjectType(DEV1), Local0)
			}
			Case(7) {
				Store(ObjectType(EVE1), Local0)
			}
			Case(8) {
				Store(ObjectType(MMM1), Local0)
			}
			Case(9) {
				Store(ObjectType(MTX1), Local0)
			}
			Case(10) {
				Store(ObjectType(OPR1), Local0)
			}
			Case(11) {
				Store(ObjectType(PWR1), Local0)
			}
			Case(12) {
				Store(ObjectType(CPU1), Local0)
			}
			Case(13) {
				Store(ObjectType(TZN1), Local0)
			}
			Case(14) {
				Store(14, Local0)
			}
			Case(17) {
				Store(Derefof(REF1), Local3)
				if (CH03(arg0, z122, 103, arg1, Local0)) {
					// Derefof caused unexpected exception
					Return (1)
				}
				Return (0)
			}
			Default {
				// Unexpected Result Type
				err(arg0, z122, 104, 0, 0, arg1, 0)
				Return (1)
			}
		}

		if (LNotEqual(Local0, arg1)) {
			// Mismatch of Target Type against the specified one
			err(arg0, z122, 105, 0, 0, Local0, arg1)

			if (STCS) {m000(3, 0x1000000, Local0, arg1)}

			Return (1)
		} else {
			// Check equality of the Source value to the Object-initializer one
			Switch(ToInteger(arg1)) {
				Case(1) {
					if (LNotEqual(INT1, Derefof(arg3))) {
						err(arg0, z122, 106, 0, 0, INT1, Derefof(arg3))
						Return (1)
					}
					if (LNotEqual(Derefof(arg2), INT1)) {
						err(arg0, z122, 107, 0, 0, Derefof(arg2), INT1)
						Return (1)
					}
				}
				Case(2) {
					if (LNotEqual(STR1, Derefof(arg3))) {
						err(arg0, z122, 108, 0, 0, STR1, Derefof(arg3))
						Return (1)
					}
					if (LNotEqual(Derefof(arg2), STR1)) {
						err(arg0, z122, 109, 0, 0, Derefof(arg2), STR1)
						Return (1)
					}
				}
				Case(3) {
					if (LNotEqual(BUF1, Derefof(arg3))) {
						err(arg0, z122, 110, 0, 0, BUF1, Derefof(arg3))
						Return (1)
					}
					if (LNotEqual(Derefof(arg2), BUF1)) {
						err(arg0, z122, 111, 0, 0, Derefof(arg2), BUF1)
						Return (1)
					}
				}
				Case(4) {

					Store(Sizeof(PAC1), Local0)
					if (LNotEqual(Sizeof(arg3), Local0)) {
						err(arg0, z122, 112, 0, 0, Sizeof(arg3), Local0)
						Return (1)
					}
					While (Local0) {
						Decrement(Local0)
						Store(ObjectType(Derefof(Index(Derefof(arg3), Local0))), Local1)
						Store(ObjectType(Derefof(Index(PAC1, Local0))), Local2)
						if (LNotEqual(Local1, Local2)) {
							// ObjectType is corrupted
							err(arg0, z122, 113, 0, 0, Local1, Local2)
							Return (1)
						} elseif (Derefof(Index(b679, Local1))) {
							// the computational data type
							if (LNotEqual(
									Derefof(Index(Derefof(arg3), Local0)),
									Derefof(Index(PAC1, Local0)))) {
								// The value is corrupted
								err(arg0, z122, 114, 0, 0, Derefof(Index(Derefof(arg3), Local0)), Local0)
								Return (1)
							}
						}
					}

					Store(Sizeof(PAC1), Local0)
					if (LNotEqual(Sizeof(arg2), Local0)) {
						err(arg0, z122, 115, 0, 0, Sizeof(arg2), Local0)
						Return (1)
					}
					While (Local0) {
						Decrement(Local0)
						Store(ObjectType(Derefof(Index(Derefof(arg2), Local0))), Local1)
						Store(ObjectType(Derefof(Index(PAC1, Local0))), Local2)
						if (LNotEqual(Local1, Local2)) {
							// ObjectType is corrupted
							err(arg0, z122, 116, 0, 0, Local1, Local2)
							Return (1)
						} elseif (Derefof(Index(b679, Local1))) {
							// the computational data type
							if (LNotEqual(
									Derefof(Index(Derefof(arg2), Local0)),
									Derefof(Index(PAC1, Local0)))) {
								// The value is corrupted
								err(arg0, z122, 117, 0, 0, Derefof(Index(Derefof(arg2), Local0)), Local0)
								Return (1)
							}
						}
					}
				}
				Case(5) {
					if (LNotEqual(Derefof(arg2), Derefof(arg3))) {
						err(arg0, z122, 118, 0, 0, Derefof(arg2), Derefof(arg3))
						Return (1)
					}
				}
				Case(8) {
					CopyObject(Derefof(arg2), MMM2)
					if (LNotEqual(MMM2, MMM1)) {
						err(arg0, z122, 119, 0, 0, MMM2, MMM1)
						Return (1)
					}
				}
				Case(14) {
					if (LNotEqual(Derefof(arg2), Derefof(arg3))) {
						err(arg0, z122, 120, 0, 0, Derefof(arg2), Derefof(arg3))
						Return (1)
					}
				}
			}
		}
		Return (0)
	}

	// Check auxiliary Target Named Object type is not corrupted,
	// for the computational data types verify its value against
	// the Object-initializer value
	Method(m016, 4, Serialized)
	{
		Switch(ToInteger(arg1)) {
			Case(0) {
				Return (0)
			}
			Case(1) {
				Store(ObjectType(INT1), Local0)
			}
			Case(2) {
				Store(ObjectType(STR1), Local0)
			}
			Case(3) {
				Store(ObjectType(BUF1), Local0)
			}
			Case(4) {
				Store(ObjectType(PAC1), Local0)
			}
			Case(5) {
				Store(5, Local0)
			}
			Case(6) {
				Store(ObjectType(DEV1), Local0)
			}
			Case(7) {
				Store(ObjectType(EVE1), Local0)
			}
			Case(8) {
				Store(ObjectType(MMM1), Local0)
			}
			Case(9) {
				Store(ObjectType(MTX1), Local0)
			}
			Case(10) {
				Store(ObjectType(OPR1), Local0)
			}
			Case(11) {
				Store(ObjectType(PWR1), Local0)
			}
			Case(12) {
				Store(ObjectType(CPU1), Local0)
			}
			Case(13) {
				Store(ObjectType(TZN1), Local0)
			}
			Case(14) {
				Store(14, Local0)
			}
			Case(17) {
				Store(Derefof(REF1), Local3)
				if (CH03(arg0, z122, 121, arg1, 0)) {
					// Derefof caused unexpected exception
					Return (1)
				}
				Return (0)
			}
			Default {
				// Unexpected Result Type
				err(arg0, z122, 122, 0, 0, arg1, 0)
				Return (1)
			}
		}

		if (LNotEqual(Local0, arg1)) {
			// Mismatch of Target Type against the specified one
			err(arg0, z122, 123, 0, 0, Local0, arg1)

			if (STCS) {m000(3, 0x1000000, Local0, arg1)}

			Return (1)
		} else {
			// Check equality of the Source value to the Object-initializer one
			Switch(ToInteger(arg1)) {
				Case(1) {
					if (LNotEqual(INT1, Derefof(arg3))) {
						err(arg0, z122, 124, 0, 0, INT1, Derefof(arg3))
						Return (1)
					}
				}
				Case(2) {
					if (LNotEqual(STR1, Derefof(arg3))) {
						err(arg0, z122, 125, 0, 0, STR1, Derefof(arg3))
						Return (1)
					}
				}
				Case(3) {
					if (LNotEqual(BUF1, Derefof(arg3))) {
						err(arg0, z122, 126, 0, 0, BUF1, Derefof(arg3))
						Return (1)
					}
				}
				Case(4) {

					Store(Sizeof(PAC1), Local0)
					if (LNotEqual(Sizeof(arg3), Local0)) {
						err(arg0, z122, 127, 0, 0, Sizeof(arg3), Local0)
						Return (1)
					}
					While (Local0) {
						Decrement(Local0)
						Store(ObjectType(Derefof(Index(Derefof(arg3), Local0))), Local1)
						Store(ObjectType(Derefof(Index(PAC1, Local0))), Local2)
						if (LNotEqual(Local1, Local2)) {
							// ObjectType is corrupted
							err(arg0, z122, 128, 0, 0, Local1, Local2)
							Return (1)
						} elseif (Derefof(Index(b679, Local1))) {
							// the computational data type
							if (LNotEqual(
									Derefof(Index(Derefof(arg3), Local0)),
									Derefof(Index(PAC1, Local0)))) {
								// The value is corrupted
								err(arg0, z122, 129, 0, 0, Derefof(Index(Derefof(arg3), Local0)), Local0)
								Return (1)
							}
						}
					}
				}
			}
		}
		Return (0)
	}

	// Update the first element of specified Package
	// m017(<msg>, <Package>)
	Method(m017, 2)
	{
		Store(ObjectType(Index(arg1, 0)), Local0)

		if (Derefof(Index(b66f, Local0))) {
			// Can be used in Index Operator
			Store(Sizeof(Index(arg1, 0)), Local1)
			if (Local1) {
				// Update the last Member Object
				Decrement(Local1)
				Index(Derefof(Index(arg1, 0)), Local1, Local2)
				Store(Refof(Local2), Local3)
				Store(Derefof(Local2), Local4)
				if (LEqual(ObjectType(Local4), 1)) {
					// Integer
					Store(Not(Local4), Derefof(Local3))
				} else {
					Store(Ones, Derefof(Local3))
					if (CH03(arg0, z122, 130, Local1, Index(arg1, 0))) {
						// Store caused unexpected exception
						Return (1)
					}
				}
				if (Local1) {
					// Update the First Member Object
					Index(Derefof(Index(arg1, 0)), 0, Local2)
					Store(Derefof(Local2), Local4)
					if (LEqual(ObjectType(Local4), 1)) {
						// Integer
						Store(Not(Local4), Derefof(Local3))
					} else {
						Store(Ones, Derefof(Local3))
						if (CH03(arg0, z122, 131, Local1, Index(arg1, 0))) {
							// Store caused unexpected exception
							Return (1)
						}
					}
				}
			} elseif (LEqual(Local0, 4)) {
				// Empty Package
				Store(Package(1){"update string"}, Index(arg1, 0))
			} else {
				// Empty String/Buffer
				Store("update string", Index(arg1, 0))
			}
		} elseif (Derefof(Index(b674, Local0))) {
			// Non-Computational Data Objects
			Store("update string", Index(arg1, 0))
		} else {
			Store(Not(ToInteger(Derefof(Index(arg1, 0)))), Index(arg1, 0))
		}

		if (CH03(arg0, z122, 132, Local0, Index(arg1, 0))) {
			// Update caused unexpected exception
			Return (1)
		}

		Return (0)
	}

	// Test data packages for each type of the Result Object

	// Empty Package
	Name(p000, Package(18){})

	// Target Objects initial values for common use
	Name(p001, Package(18) {
		0,
		0xfedcba9876543211,
		"target string",
		Buffer(17){0xc3,0xc4,0xc5,0x00,0xc6,0xc7,0xc8,0xc9,0xca,0xcb,0xcc,0xcd,0xce,0xcf,0xc0,0xc1,0xc2,},
		Package(2) {
			"target package",
			0xfedcba9876543210,
		},
		Buffer(9){0x9a,0x8a,0x7a,0x6a,0x5a,0x4a,0x3a,0x2a,0x1a,},
		0, 0,
		Package() {MMMY, "ff0Y"},
		0, 0, 0, 0, 0,
		Buffer(9){0x9a,0x8a,0x7a,0x6a,0x5a,0x4a,0x3a,0x2a,0x1a,},
		0, 0, 0,})

	// Uninitialized

	Name(p002, Package() {
		// Type of the Result(Source) Object
		0,
		// Number of different initial values
		1,
		// SRC0 initial value
		0,
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		0,
		// Benchmark Result object converted to Target type values
		p000,
	})

	// Integer

	Name(p132, Package() {
		// Type of the Result(Source) Object
		1,
		// Number of different initial values
		1,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		p001,
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

	Name(p164, Package() {
		// Type of the Result(Source) Object
		1,
		// Number of different initial values
		1,
		// SRC0 initial value
		0xfedcba9876543210,
		// Target Objects initial values
		p001,
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

	// String

	Name(p201, Package() {
		// Type of the Result(Source) Object
		2,
		// Number of different initial values
		1,
		// SRC0 initial value
		"\x01",
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		"\x01",
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0,
			"\x01",
			Buffer(17){1,},
			0,
			Buffer(9){1,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){1,},
			0, 0, 0,},
	})

	Name(p202, Package() {
		// Type of the Result(Source) Object
		2,
		// Number of different initial values
		2,
		// SRC0 initial value
		"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*",
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*",
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0,
			"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*",
			Buffer(17){0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,0x30,0x31,},
			0,
			Buffer(9){0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x09,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x09,},
			0, 0, 0,},
	})

	Name(p232, Package() {
		// Type of the Result(Source) Object
		2,
		// Number of different initial values
		2,
		Package() {
			// Type of the Result(Source) Object
			3,
			// Number of different initial values
			0,
			// SRC0 initial value
			"fedcba98 string",
			// Target Objects initial values
			p001,
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
		},
		p201,
		p202,
	})

	Name(p264, Package() {
		// Type of the Result(Source) Object
		2,
		// Number of different initial values
		3,
		Package() {
			// Type of the Result(Source) Object
			2,
			// Number of different initial values
			0,
			// SRC0 initial value
			"fedcba9876543210 string",
			// Target Objects initial values
			p001,
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
		},
		p201,
		p202,
	})

	// Buffer

	Name(p301, Package() {
		// Type of the Result(Source) Object
		3,
		// Number of different initial values
		1,
		// SRC0 initial value
		Buffer(67) {
			 1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
			17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
			33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
			49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
			65, 66, 67},
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		Buffer(67) {
			 1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
			17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
			33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
			49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
			65, 66, 67},
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0x0807060504030201,
			"01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 10 11 12 13 14 15 16 17 18 19 1A 1B 1C 1D 1E 1F 20 21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43",
			Buffer(17) {1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17,},
			0,
			Buffer(9){1,  2,  3,  4,  5,  6,  7,  8,  9},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){1,  2,  3,  4,  5,  6,  7,  8,  9},
			0, 0, 0,},
	})

	Name(p300, Package() {
		// Type of the Result(Source) Object
		3,
		// Number of different initial values
		2,
		Package() {
			// Type of the Result(Source) Object
			3,
			// Number of different initial values
			0,
			// SRC0 initial value
			Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x88},
			// Target Objects initial values
			p001,
			// Benchmark Result object value
			Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x88},
			// Benchmark Result object converted to Target type values
			Package(18) {
				0,
				0xf1f2f3f4f5f6f7f8,
				"F8 F7 F6 F5 F4 F3 F2 F1 88",
				Buffer(17){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x88},
				0,
				Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x08},
				0, 0, 0, 0, 0, 0, 0, 0,
				Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x08},
				0, 0, 0,},
		},
		p301,
	})

	// Package

	Name(p401, Package() {
		// Type of the Result(Source) Object
		4,
		// Number of different initial values
		1,
		// SRC0 initial value
		Package(1) {
			"test p401 package",
		},
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		Package(1) {
			"test p401 package",
		},
		// Benchmark Result object converted to Target type values
		Package(18) {
			0, 0, 0, 0,
			Package(1) {
				"test p401 package",
			},
			0,
			0, 0, 0, 0, 0, 0, 0, 0,
			0,
			0, 0, 0,},
	})

	Name(p400, Package() {
		// Type of the Result(Source) Object
		4,
		// Number of different initial values
		2,
		Package() {
			// Type of the Result(Source) Object
			4,
			// Number of different initial values
			0,
			// SRC0 initial value
			Package(3) {
				0xfedcba987654321f,
				"test package",
				Buffer(9){19,18,17,16,15,14,13,12,11},},
			// Target Objects initial values
			p001,
			// Benchmark Result object value
			Package(3) {
				0xfedcba987654321f,
				"test package",
				Buffer(9){19,18,17,16,15,14,13,12,11},},
			// Benchmark Result object converted to Target type values
			Package(18) {
				0, 0, 0, 0,
				Package(3) {
					0xfedcba987654321f,
					"test package",
					Buffer(9){19,18,17,16,15,14,13,12,11},},
				0,
				0, 0, 0, 0, 0, 0, 0, 0,
				0,
				0, 0, 0,},
		},
		p401,
	})

	// Field Unit

	Name(p500, Package() {
		// Type of the Result(Source) Object
		5,
		// Number of different initial values
		1,
		// SRC0 initial value
		Package(2){0, Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,0x15,}},
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,0x15,},
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0x2535455565758595,
			"95 85 75 65 55 45 35 25 15",
			Buffer(17){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,0x15,},
			0,
			Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,0x15,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,0x15,},
			0, 0, 0,},
	})

	// Device

	Name(p600, Package() {
		// Type of the Result(Source) Object
		6,
		// Number of different initial values
		1,
		// SRC0 initial value
		ResourceTemplate(){},
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		0,
		// Benchmark Result object converted to Target type values
		p000,
	})

	// Event

	Name(p700, Package() {
		// Type of the Result(Source) Object
		7,
		// Number of different initial values
		1,
		// SRC0 initial value
		0,
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		0,
		// Benchmark Result object converted to Target type values
		p000,
	})

	// Method

	Name(p800, Package() {
		// Type of the Result(Source) Object
		8,
		// Number of different initial values
		1,
		// SRC0 initial value
		Package() {MMMX, "ff0X"},
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		"ff0X",
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0xff0,
			"ff0X",
			Buffer(17){0x66, 0x66, 0x30, 0x58,},
			0,
			Buffer(9){0x66, 0x66, 0x30, 0x58,},
			0, 0,
			"ff0X",
			0, 0, 0, 0, 0,
			Buffer(9){0x66, 0x66, 0x30, 0x58,},
			0, 0, 0,},
	})

	// Mutex

	Name(p900, Package() {
		// Type of the Result(Source) Object
		9,
		// Number of different initial values
		1,
		// SRC0 initial value
		0,
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		0,
		// Benchmark Result object converted to Target type values
		p000,
	})

	// Operation Region

	Name(pa00, Package() {
		// Type of the Result(Source) Object
		10,
		// Number of different initial values
		1,
		// SRC0 initial value
		0,
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		0,
		// Benchmark Result object converted to Target type values
		p000,
	})

	// Power Resource

	Name(pb00, Package() {
		// Type of the Result(Source) Object
		11,
		// Number of different initial values
		1,
		// SRC0 initial value
		0,
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		0,
		// Benchmark Result object converted to Target type values
		p000,
	})

	// Processor

	Name(pc00, Package() {
		// Type of the Result(Source) Object
		12,
		// Number of different initial values
		1,
		// SRC0 initial value
		0,
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		0,
		// Benchmark Result object converted to Target type values
		p000,
	})

	// Thermal Zone

	Name(pd00, Package() {
		// Type of the Result(Source) Object
		13,
		// Number of different initial values
		1,
		// SRC0 initial value
		0,
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		0,
		// Benchmark Result object converted to Target type values
		p000,
	})

	// Buffer Field

	Name(pe00, Package() {
		// Type of the Result(Source) Object
		14,
		// Number of different initial values
		0,
		// SRC0 initial value
		Package(2){0, Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,0x15,}},
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,0x15,},
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0x2535455565758595,
			"95 85 75 65 55 45 35 25 15",
			Buffer(17){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,0x15,},
			0,
			Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,0x15,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,0x15,},
			0, 0, 0,},
	})

	Name(pe01, Package() {
		// Type of the Result(Source) Object
		14,
		// Number of different initial values
		1,
		// SRC0 initial value
		Package(2){1, Buffer(8){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,}},
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		Buffer(8){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25},
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0x2535455565758595,
			"95 85 75 65 55 45 35 25",
			Buffer(17){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,},
			0,
			Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,},
			0, 0, 0,},
	})

	Name(pe02, Package() {
		// Type of the Result(Source) Object
		14,
		// Number of different initial values
		1,
		// SRC0 initial value
		Package(2){1, Buffer(8){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,}},
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		0x2535455565758595,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0x2535455565758595,
			"2535455565758595",
			Buffer(17){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,},
			0,
			Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x95,0x85,0x75,0x65,0x55,0x45,0x35,0x25,},
			0, 0, 0,},
	})

	Name(pe03, Package() {
		// Type of the Result(Source) Object
		14,
		// Number of different initial values
		2,
		// SRC0 initial value
		Package(2){2, Buffer(4){0x95,0x85,0x75,0x65,}},
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		0x65758595,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0x65758595,
			"65758595",
			Buffer(17){0x95,0x85,0x75,0x65,},
			0,
			Buffer(9){0x95,0x85,0x75,0x65,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x95,0x85,0x75,0x65,},
			0, 0, 0,},
	})

	Name(pe04, Package() {
		// Type of the Result(Source) Object
		14,
		// Number of different initial values
		2,
		// SRC0 initial value
		Package(2){2, Buffer(4){0x95,0x85,0x75,0x65,}},
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		0x65758595,
		// Benchmark Result object converted to Target type values
		Package(18) {
			0,
			0x65758595,
			"0000000065758595",
			Buffer(17){0x95,0x85,0x75,0x65,},
			0,
			Buffer(9){0x95,0x85,0x75,0x65,},
			0, 0, 0, 0, 0, 0, 0, 0,
			Buffer(9){0x95,0x85,0x75,0x65,},
			0, 0, 0,},
	})

	Name(pe32, Package() {
		// Type of the Result(Source) Object
		14,
		// Number of different initial values
		3,
		// Data
		pe00,
		pe01,
		pe03,
	})

	Name(pe64, Package() {
		// Type of the Result(Source) Object
		14,
		// Number of different initial values
		3,
		// Data
		pe00,
		pe02,
		pe04,
	})

	// DDB Handle

	Name(pf00, Package() {
		// Type of the Result(Source) Object
		15,
		// Number of different initial values
		1,
		// SRC0 initial value
		0,
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		0,
		// Benchmark Result object converted to Target type values
		p000,
	})

	// Debug

	Name(pg00, Package() {
		// Type of the Result(Source) Object
		16,
		// Number of different initial values
		1,
		// SRC0 initial value
		0,
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		0,
		// Benchmark Result object converted to Target type values
		p000,
	})

	// Reference

	Name(ph00, Package() {
		// Type of the Result(Source) Object
		17,
		// Number of different initial values
		1,
		// SRC0 initial value
		0,
		// Target Objects initial values
		p001,
		// Benchmark Result object value
		0,
		// Benchmark Result object converted to Target type values
		p000,
	})

	Name(p320, Package(18) {
		p002, p132, p232, p300, p400, p500, p600, p700, p800, p900,
		pa00, pb00, pc00, pd00, pe32, pf00, pg00, ph00,})
	Name(p640, Package(18) {
		p002, p164, p264, p300, p400, p500, p600, p700, p800, p900,
		pa00, pb00, pc00, pd00, pe64, pf00, pg00, ph00,})

	// m020(<msg>, <store op>, <exc. conditions>,
	//      <Target scale>, <Result scale>, <kind of Source-Target pair>)
	Method(m020, 6, Serialized)
	{
		// Initialize statistics
		m001()
		Name(scl0, Buffer() {0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0})

		Name(lpN0, 18)
		Name(lpC0, 0)

		Name(lpN1, 0)
		Name(lpC1, 0)
		Name(lpN2, 0)
		Name(lpC2, 0)

		SRMT(arg0)

		if (LGreater(arg1, 1)) {
			// Unexpected Kind of Op (0 - Store, ...)
			err(Concatenate(arg0, terr), z122, 133, 0, 0, arg1, 0)
			Return (1)
		}

		if (LGreater(arg5, 6)) {
			// Unexpected Kind of Source-Target pair
			err(Concatenate(arg0, terr), z122, 134, 0, 0, arg5, 0)
			Return (1)
		}

		// Flags of Store from and to Named to check
		// exceptional conditions on storing
		if (arg1) {
			Store(0, Local0)
			Store(0, Local1)
		} else {
			Store(Lor(LEqual(arg5, 0), LEqual(arg5, 1)), Local0)
			Store(Lor(Local0, LEqual(arg5, 4)), Local0)
			Store(Lor(Local0, LEqual(arg5, 5)), Local0)
			Store(Lor(LEqual(arg5, 0), LEqual(arg5, 2)), Local1)
		}

		// Enumerate Target types
		While (lpN0) {
			if (LAnd(Derefof(Index(b670, lpC0)), Derefof(Index(arg3, lpC0)))) {
				// Not invalid type of the Target Object to store in

				Store(18, lpN1)
				Store(0, lpC1)

				// Enumerate Source types
				While (lpN1) {
					if (LAnd(Derefof(Index(b671, lpC1)), Derefof(Index(arg4, lpC1)))) {
						// Not invalid type of the result Object to be stored
						if (arg2) {
							// Skip cases without exceptional conditions
							if (LNot(m685(arg1, lpC0, lpC1, Local0, Local1))) {
								Decrement(lpN1)
								Increment(lpC1)
								Continue
							}
						} else {
							// Skip cases with exceptional conditions
							if (m685(arg1, lpC0, lpC1, Local0, Local1)) {
								Decrement(lpN1)
								Increment(lpC1)
								Continue
							}
						}
						if (F64) {
							Store(Derefof(Index(p640, lpC1)), Local2)
						} else {
							Store(Derefof(Index(p320, lpC1)), Local2)
						}
						Store(Derefof(Index(Local2, 0)), Local3)
						if (LNotEqual(Local3, lpC1)) {
							// Unexpected data package
							err(Concatenate(arg0, terr), z122, 135, 0, 0, arg1, lpC1)
							Return (1)
						}
						Store(Derefof(Index(Local2, 1)), Local3)
						
						Store(Local3, lpN2)
						Store(0, lpC2)

						// Enumerate Result values
						While (lpN2) {
							if (LGreater(Local3, 1)) {
								// Complex test data
								Index(Local2, Add(lpC2, 2), Local4)
							} else {
								Store(Refof(Local2), Local4)
							}

							if (LEqual(arg5, 0)) {
								// Named-Named
								m008(Concatenate(arg0, "-m008"), 0, lpC0, lpC1, arg1, arg2, Derefof(Local4))
							} elseif (LEqual(arg5, 1)) {
								// Named-LocalX
								m009(Concatenate(arg0, "-m009"), 0, lpC0, lpC1, arg1, arg2, Derefof(Local4))
							} elseif (LEqual(arg5, 2)) {
								// LocalX-Named
								m00a(Concatenate(arg0, "-m00a"), 0, lpC0, lpC1, arg1, arg2, Derefof(Local4))
							} elseif (LEqual(arg5, 3)) {
								// LocalX-LocalX
								m00b(Concatenate(arg0, "-m00b"), 0, lpC0, lpC1, arg1, arg2, Derefof(Local4))
							} elseif (LEqual(arg5, 4)) {
								// Named-ArgX(Named read-only)
								m00c(Concatenate(arg0, "-m00c"), 0, lpC0, lpC1, arg1, arg2, Derefof(Local4))
							} elseif (LEqual(arg5, 5)) {
								// Named-ArgX(Named by reference)
								if (y900) {
								if (LAnd(LEqual(lpC1, 4),	// Source type is 4
										// Target type is 1-3
										Derefof(Index(Buffer() {0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, lpC0)))) {
									if (y366) {
										m00d(Concatenate(arg0, "-m00d"), 0, lpC0, lpC1, arg1, arg2, Derefof(Local4))
									}
								} else {
									m00d(Concatenate(arg0, "-m00d"), 0, lpC0, lpC1, arg1, arg2, Derefof(Local4))
								}
								} else { // if (y900)
								if (LAnd(LEqual(lpC1, 4),	// Source type is 4
										// Target type is 1-3
										Derefof(Index(scl0, lpC0)))) {
									if (y366) {
										m00d(Concatenate(arg0, "-m00d"), 0, lpC0, lpC1, arg1, arg2, Derefof(Local4))
									}
								} else {
									m00d(Concatenate(arg0, "-m00d"), 0, lpC0, lpC1, arg1, arg2, Derefof(Local4))
								}
								} // if (y900)

							} elseif (LEqual(arg5, 6)) {
								// LocalX-Element of Package
								m00e(Concatenate(arg0, "-m00e"), 0, lpC0, lpC1, arg1, arg2, Derefof(Local4))
							}
							Decrement(lpN2)
							Increment(lpC2)
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
		m002(Concatenate(Derefof(Index(PAC5, arg5)), Derefof(Index(PAC4, arg1))))

		Return (0)
	}

	Concatenate(arg0, "-m020", arg0)

	// Named-Named
	m020(Concatenate(arg0, "-NN"), arg1, arg2, b676, b676, 0)

	// Named-LocalX
	m020(Concatenate(arg0, "-NL"), arg1, arg2, b677, b676, 1)

	// LocalX-Named
	m020(Concatenate(arg0, "-LN"), arg1, arg2, b676, b677, 2)

	// LocalX-LocalX
	m020(Concatenate(arg0, "-LL"), arg1, arg2, b677, b677, 3)

	// Named-ArgX(Named read-only)
	m020(Concatenate(arg0, "-NA-RO"), arg1, arg2, b676, b676, 4)

	// Named-ArgX(Named by reference)
	m020(Concatenate(arg0, "-NA-REF"), arg1, arg2, b676, b676, 5)

	// LocalX-Element of Package
	if (LEqual(arg1, 0)) {
		m020(Concatenate(arg0, "-LP"), arg1, arg2, b67d, b677, 6)
	}
}
