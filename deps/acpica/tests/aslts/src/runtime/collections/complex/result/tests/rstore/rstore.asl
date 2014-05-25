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
 * Check Result Object processing (simultaneously verifying
 * the Implicit Result Object Conversion Rules) in the Store operator
 */

Name(z123, 123)

// Store to Global Named Objects, Constant and LocalX
Method(m690,, Serialized)
{
	Name(ts, "m690")

	Name(terr, "test error")

	Name(i000, 0)

	// Common testing control
	Method(m100, 3, Serialized)
	{
		Name(lpN0, 0)
		Name(lpC0, 0)
		Name(lpN1, 0)
		Name(lpC1, 0)

		SRMT(arg0)

		Store(9, lpN0)
		Store(0, lpC0)

		// Enumerate ways to obtain some result object
		While (lpN0) {

		  Store(3, lpN1)
		  Store(1, lpC1)

		  // Enumerate types of the result Object
		  While (lpN1) {
			// Choose a type and a value of the Object to store into
		 	Switch (ToInteger (arg1)) {
				Case(0) {	// Uninitialized
					// Store(Src0, Local0)
				}
				Case(1) {	// Integer
					// Choose kind of the Object to store into:
					if (LEqual(arg2, 0)) {
						// Constant (like Store(Src0, Zero))
						m010(Concatenate(ts, "-m010"), lpC0, lpC1)
					} elseif (LEqual(arg2, 1)) {
						// Named Object
						m011(Concatenate(ts, "-m011"), lpC0, lpC1)
					} elseif (LEqual(arg2, 2)) {
						// ArgX Object
	 					// Store(Src0, arg3)
						Store("Not implemented", Debug)
						err(terr, z123, 1, 0, 0, arg1, arg2)
						Return (1)
					} elseif (LEqual(arg2, 3)) {
						// LocalX Object
						m013(Concatenate(ts, "-m013"), lpC0, lpC1)
					} elseif (LEqual(arg2, 4)) {
						// Reference in ArgX Object
	 					// Store(Src0, arg4)
						Store("Not implemented", Debug)
						err(terr, z123, 2, 0, 0, arg1, arg2)
						Return (1)
					} elseif (LEqual(arg2, 5)) {
						// Elemenf of a Package
	 					// Store(Src0, Index(p680, 0))
						Store("Not implemented", Debug)
						err(terr, z123, 3, 0, 0, arg1, arg2)
						Return (1)
					} else {
						Store("Unexpected Kind of the Object to store into", Debug)
						err(terr, z123, 4, 0, 0, arg1, arg2)
						Return (1)
					}
				}
				Case(2) {	// String
					// choose kind of the Object to store into:
					if (LEqual(arg2, 0)) {
						// Constant
 						// Store(Src0, "")
						Store("Not implemented", Debug)
						err(terr, z123, 5, 0, 0, arg1, arg2)
						Return (1)
					} elseif (LEqual(arg2, 1)) {
						// Named Object
						m021(Concatenate(ts, "-m021"), lpC0, lpC1)
					} elseif (LEqual(arg2, 2)) {
						// ArgX Object
	 					// Store(Src0, arg3)
						Store("Not implemented", Debug)
						err(terr, z123, 6, 0, 0, arg1, arg2)
						Return (1)
					} elseif (LEqual(arg2, 3)) {
						// LocalX Object
						m023(Concatenate(ts, "-m023"), lpC0, lpC1)
					} elseif (LEqual(arg2, 4)) {
						// Reference in ArgX Object
	 					// Store(Src0, arg4)
						Store("Not implemented", Debug)
						err(terr, z123, 7, 0, 0, arg1, arg2)
						Return (1)
					} elseif (LEqual(arg2, 5)) {
						// Elemenf of a Package
	 					// Store(Src0, Index(p680, 0))
						Store("Not implemented", Debug)
						err(terr, z123, 8, 0, 0, arg1, arg2)
						Return (1)
					} else {
						Store("Unexpected Kind of the Object to store into", Debug)
						err(terr, z123, 9, 0, 0, arg1, arg2)
						Return (1)
					}
				}
				Case(3) {	// Buffer
					// choose kind of the Object to store into:
					if (LEqual(arg2, 0)) {
						// Constant
 						// Store(Src0, Buffer(1){})
						Store("Not implemented", Debug)
						err(terr, z123, 10, 0, 0, arg1, arg2)
						Return (1)
					} elseif (LEqual(arg2, 1)) {
						// Named Object
						m031(Concatenate(ts, "-m031"), lpC0, lpC1)
					} elseif (LEqual(arg2, 2)) {
						// ArgX Object
	 					// Store(Src0, arg3)
						Store("Not implemented", Debug)
						err(terr, z123, 11, 0, 0, arg1, arg2)
						Return (1)
					} elseif (LEqual(arg2, 3)) {
						// LocalX Object
	 					// Store(Src0, Local2)
						Store("Not implemented", Debug)
						err(terr, z123, 12, 0, 0, arg1, arg2)
						Return (1)
					} elseif (LEqual(arg2, 4)) {
						// Reference in ArgX Object
	 					// Store(Src0, arg4)
						Store("Not implemented", Debug)
						err(terr, z123, 13, 0, 0, arg1, arg2)
						Return (1)
					} elseif (LEqual(arg2, 5)) {
						// Elemenf of a Package
	 					// Store(Src0, Index(p680, 0))
						Store("Not implemented", Debug)
						err(terr, z123, 14, 0, 0, arg1, arg2)
						Return (1)
					} else {
						Store("Unexpected Kind of the Object to store into", Debug)
						err(terr, z123, 15, 0, 0, arg1, arg2)
						Return (1)
					}
				}
				Case(4) {	// Package
					// Store(Src0, p680)
					Store("Not implemented", Debug)
					err(terr, z123, 16, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer field
					// Choose kind of the Object to store into:
					if (LEqual(arg2, 0)) {
						// Constant (like Store(Src0, Zero))
						Store("Not implemented", Debug)
						err(terr, z123, 17, 0, 0, arg1, arg2)
						Return (1)
					} elseif (LEqual(arg2, 1)) {
						// Named Object
						m0e0(Concatenate(ts, "-m0e0"), lpC0, lpC1)
						m0e1(Concatenate(ts, "-m0e1"), lpC0, lpC1)
						m0e2(Concatenate(ts, "-m0e2"), lpC0, lpC1)
					} elseif (LEqual(arg2, 2)) {
						// ArgX Object
	 					// Store(Src0, arg3)
						Store("Not implemented", Debug)
						err(terr, z123, 18, 0, 0, arg1, arg2)
						Return (1)
					} elseif (LEqual(arg2, 3)) {
						// LocalX Object
	 					// Store(Src0, Local2)
						Store("Not implemented", Debug)
						err(terr, z123, 19, 0, 0, arg1, arg2)
						Return (1)
					} elseif (LEqual(arg2, 4)) {
						// Reference in ArgX Object
	 					// Store(Src0, arg4)
						Store("Not implemented", Debug)
						err(terr, z123, 20, 0, 0, arg1, arg2)
						Return (1)
					} elseif (LEqual(arg2, 5)) {
						// Elemenf of a Package
	 					// Store(Src0, Index(p680, 0))
						Store("Not implemented", Debug)
						err(terr, z123, 21, 0, 0, arg1, arg2)
						Return (1)
					} else {
						Store("Unexpected Kind of the Object to store into", Debug)
						err(terr, z123, 22, 0, 0, arg1, arg2)
						Return (1)
					}
				}
				Default {
					Store("Unexpected type of the Object to store into", Debug)
					err(terr, z123, 23, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Decrement(lpN1)
			Increment(lpC1)
		  }
		  Decrement(lpN0)
		  Increment(lpC0)
		}
		Return (0)
	}

	// Store() Result Object to Integer Constant
	Method(m010, 3, Serialized)
	{
		Name(p000, Package(){Zero, One, Ones, 0xfe7cb391d650a284})

		// Return Indexed reference to ASL constant specified
		// by Name as an element of the Package for next applying
		// through Derefof operator as Destination in Store operator
		Method(m200, 1)
		{
			if (y900) {
				Return(Index(Package(){Zero, One, Ones, 0xfe7cb391d650a284}, arg0))
			}
			Return(Index(p000, arg0))
		}

		// ArgX as a way to obtain some result object
		Method(m000, 5, Serialized)
		{
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					Store(arg2, Derefof(m200(1)))
					m680(arg0, 24, 0, Derefof(m200(1)), 1)
					m680(arg0, 25, 0, arg2, 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					Store(arg3, Derefof(m200(1)))
					m680(arg0, 26, 0, Derefof(m200(1)), 1)
					m680(arg0, 27, 0, arg3, "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					Store(arg4, Derefof(m200(1)))
					m680(arg0, 28, 0, Derefof(m200(1)), 1)
					m680(arg0, 29, 0, arg4, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 30, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 31, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}
		// Reference in ArgX as a way to obtain some result object
		Method(m001, 5, Serialized)
		{
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					Store(Derefof(arg2), Derefof(m200(1)))
					m680(arg0, 32, 0, Derefof(m200(1)), 1)
					m680(arg0, 33, 0, Derefof(arg2), 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					Store(Derefof(arg3), Derefof(m200(1)))
					m680(arg0, 34, 0, Derefof(m200(1)), 1)
					m680(arg0, 35, 0, Derefof(arg3), "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					Store(Derefof(arg4), Derefof(m200(1)))
					m680(arg0, 36, 0, Derefof(m200(1)), 1)
					m680(arg0, 37, 0, Derefof(arg4), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 38, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 39, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		m680(arg0, 40, 0, Derefof(m200(1)), 1)

		// Choose a way to obtain some result object
		Switch(ToInteger (arg1)) {
			Case(0) {	// Data Image

				// Choose a type of the result Object and specific source
				// objects to obtain the result Object of the specified type.
				// Check that the destination Object is properly initialized.
				// Perform storing expression and check result.
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(0xfe7cb391d650a284, Derefof(m200(1)))
						m680(arg0, 41, 0, Derefof(m200(1)), 1)
					}
					Case(2) {	// String
	 					Store("FE7CB391D650A284", Derefof(m200(1)))
						m680(arg0, 42, 0, Derefof(m200(1)), 1)
					}
					Case(3) {	// Buffer
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, Derefof(m200(1)))
						m680(arg0, 43, 0, Derefof(m200(1)), 1)
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 44, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 45, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(1) {	// Named Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(i6e0, Derefof(m200(1)))
						m680(arg0, 46, 0, Derefof(m200(1)), 1)
						m680(arg0, 47, 0, i6e0, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(s6e0, Derefof(m200(1)))
						m680(arg0, 48, 0, Derefof(m200(1)), 1)
						m680(arg0, 49, 0, s6e0, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(b6e0, Derefof(m200(1)))
						m680(arg0, 50, 0, Derefof(m200(1)), 1)
						m680(arg0, 51, 0, b6e0, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 52, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 53, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(2) {	// Method ArgX Object
				m000(Concatenate(arg0, "-m000"), arg2,
					0xfe7cb391d650a284, "FE7CB391D650A284", Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
			}
			Case(3) {	// Method LocalX Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(0xfe7cb391d650a284, Local0)
					}
					Case(2) {	// String
	 					Store("FE7CB391D650A284", Local0)
					}
					Case(3) {	// Buffer
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, Local0)
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 54, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 55, 0, 0, arg1, arg2)
						Return (1)
					}
				}
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Local0, Derefof(m200(1)))
						m680(arg0, 56, 0, Derefof(m200(1)), 1)
						m680(arg0, 57, 0, Local0, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Local0, Derefof(m200(1)))
						m680(arg0, 58, 0, Derefof(m200(1)), 1)
						m680(arg0, 59, 0, Local0, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Local0, Derefof(m200(1)))
						m680(arg0, 60, 0, Derefof(m200(1)), 1)
						m680(arg0, 61, 0, Local0, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 62, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 63, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(4) {	// Derefof of intermediate Object (Method ArgX Object)
				m001(Concatenate(arg0, "-m001"), arg2, Refof(i6e1), Refof(s6e1), Refof(b6e1))
			}
			Case(5) {	// Derefof of immediate Index(...)
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Derefof(Index(p690, 0)), Derefof(m200(1)))
						m680(arg0, 64, 0, Derefof(m200(1)), 1)
						m680(arg0, 65, 0, Derefof(Index(p690, 0)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Derefof(Index(p690, 1)), Derefof(m200(1)))
						m680(arg0, 66, 0, Derefof(m200(1)), 1)
						m680(arg0, 67, 0, Derefof(Index(p690, 1)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Derefof(Index(p690, 2)), Derefof(m200(1)))
						m680(arg0, 68, 0, Derefof(m200(1)), 1)
						m680(arg0, 69, 0, Derefof(Index(p690, 2)), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 70, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 71, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(6) {	// Derefof of Indexed Reference returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Derefof(m681(p690, 3)), Derefof(m200(1)))
						m680(arg0, 72, 0, Derefof(m200(1)), 1)
						m680(arg0, 73, 0, Derefof(Index(p690, 3)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Derefof(m681(p690, 4)), Derefof(m200(1)))
						m680(arg0, 74, 0, Derefof(m200(1)), 1)
						m680(arg0, 75, 0, Derefof(Index(p690, 4)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Derefof(m681(p690, 5)), Derefof(m200(1)))
						m680(arg0, 76, 0, Derefof(m200(1)), 1)
						m680(arg0, 77, 0, Derefof(Index(p690, 5)), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 78, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 79, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(7) {	// Result Object returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(m682(arg2, 2), Derefof(m200(1)))
						m680(arg0, 80, 0, Derefof(m200(1)), 1)
						m680(arg0, 81, 0, i6e2, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(m682(arg2, 2), Derefof(m200(1)))
						m680(arg0, 82, 0, Derefof(m200(1)), 1)
						m680(arg0, 83, 0, s6e2, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(m682(arg2, 2), Derefof(m200(1)))
						m680(arg0, 84, 0, Derefof(m200(1)), 1)
						m680(arg0, 85, 0, b6e2, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 86, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 87, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(8) {	// Result Object returned by any Operator (Op)
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Add(i6e3, 0), Derefof(m200(1)))
						m680(arg0, 88, 0, Derefof(m200(1)), 1)
						m680(arg0, 89, 0, i6e3, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Mid(s6e3, 2, 14), Derefof(m200(1)))
						m680(arg0, 90, 0, Derefof(m200(1)), 1)
						m680(arg0, 91, 0, s6e3, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Mid(b6e3, 1, 7), Derefof(m200(1)))
						m680(arg0, 92, 0, Derefof(m200(1)), 1)
						m680(arg0, 93, 0, b6e3, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 94, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 95, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			// Additionally can be implemented cases:
			// Derefof of immediate Refof
			// Derefof of intermediate Object
			// Derefof of Reference returned by called Method
			Default {
				Store("Unexpected way to obtain some result Object", Debug)
				err(terr, z123, 96, 0, 0, arg1, arg2)
				Return (1)
			}
		}
		Return (0)
	}

	// Store() Result Object to Integer Named Object
	Method(m011, 3, Serialized)
	{
		// ArgX as a way to obtain some result object
		Method(m000, 5, Serialized)
		{
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					m680(arg0, 97, 0, i680, 0xa0a1a2a35f5e5d80)
					Store(arg2, i680)
					m680(arg0, 98, 0, i680, 0xfe7cb391d650a284)
					Store(0xc179b3fe, i680)
					m680(arg0, 99, 0, i680, 0xc179b3fe)
					m680(arg0, 100, 0, arg2, 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					m680(arg0, 101, 0, i681, 0xa0a1a2a35f5e5d81)
					Store(arg3, i681)

					if (y602) {
						if (F64) {
							Store(0xfe7cb391d650a284, i000)
						} else {
							Store(0xfe7cb391, i000)
						}
					} else {
						Store(0xfe7cb391d650a284, i000)
					}

					m680(arg0, 102, 0, i681, i000)

	 				Store("C179B3FE", i681)
					m680(arg0, 103, 0, i681, 0xc179b3fe)
					m680(arg0, 104, 0, arg3, "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					m680(arg0, 105, 0, i682, 0xa0a1a2a35f5e5d82)
					Store(arg4, i682)
					m680(arg0, 106, 0, i682, 0xfe7cb391d650a284)
	 				Store(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, i682)
					m680(arg0, 107, 0, i682, 0xc179b3fe)
					m680(arg0, 108, 0, arg4, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 109, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 110, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		// Reference in ArgX as a way to obtain some result object
		Method(m001, 5, Serialized)
		{
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					m680(arg0, 111, 0, i683, 0xa0a1a2a35f5e5d83)
					Store(Derefof(arg2), i683)
					m680(arg0, 112, 0, i683, 0xfe7cb391d650a284)
					Store(0xc179b3fe, i683)
					m680(arg0, 113, 0, i683, 0xc179b3fe)
					m680(arg0, 114, 0, Derefof(arg2), 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					m680(arg0, 115, 0, i684, 0xa0a1a2a35f5e5d84)
					Store(Derefof(arg3), i684)

					if (y602) {
						if (F64) {
							Store(0xfe7cb391d650a284, i000)
						} else {
							Store(0xfe7cb391, i000)
						}
					} else {
						Store(0xfe7cb391d650a284, i000)
					}

					m680(arg0, 116, 0, i684, i000)

	 				Store("C179B3FE", i684)
					m680(arg0, 117, 0, i684, 0xc179b3fe)
					m680(arg0, 118, 0, Derefof(arg3), "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					m680(arg0, 119, 0, i685, 0xa0a1a2a35f5e5d85)
					Store(Derefof(arg4), i685)
					m680(arg0, 120, 0, i685, 0xfe7cb391d650a284)
	 				Store(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, i685)
					m680(arg0, 121, 0, i685, 0xc179b3fe)
					m680(arg0, 122, 0, Derefof(arg4), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 123, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 124, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		// Choose a way to obtain some result object
		Switch(ToInteger (arg1)) {
			Case(0) {	// Data Image

				// Choose a type of the result Object and specific source
				// objects to obtain the result Object of the specified type.
				// Check that the destination Object is properly initialized.
				// Perform storing expression and check result.
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 125, 0, i686, 0xa0a1a2a35f5e5d86)
						Store(0xfe7cb391d650a284, i686)
						m680(arg0, 126, 0, i686, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 127, 0, i687, 0xa0a1a2a35f5e5d87)
	 					Store("FE7CB391D650A284", i687)

						if (y602) {
							if (F64) {
								Store(0xfe7cb391d650a284, i000)
							} else {
								Store(0xfe7cb391, i000)
							}
						} else {
							Store(0xfe7cb391d650a284, i000)
						}

						m680(arg0, 128, 0, i687, i000)

					}
					Case(3) {	// Buffer
						m680(arg0, 129, 0, i688, 0xa0a1a2a35f5e5d88)
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, i688)
						m680(arg0, 130, 0, i688, 0xfe7cb391d650a284)
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 131, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 132, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(1) {	// Named Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 133, 0, i689, 0xa0a1a2a35f5e5d89)
						Store(i6e0, i689)
						m680(arg0, 134, 0, i689, 0xfe7cb391d650a284)
						Store(0xc179b3fe, i689)
						m680(arg0, 135, 0, i689, 0xc179b3fe)
						m680(arg0, 136, 0, i6e0, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 137, 0, i68a, 0xa0a1a2a35f5e5d8a)
	 					Store(s6e0, i68a)

						if (y602) {
							if (F64) {
								Store(0xfe7cb391d650a284, i000)
							} else {
								Store(0xfe7cb391, i000)
							}
						} else {
							Store(0xfe7cb391d650a284, i000)
						}

						m680(arg0, 138, 0, i68a, i000)

	 					Store("C179B3FE", i68a)
						m680(arg0, 139, 0, i68a, 0xc179b3fe)
						m680(arg0, 140, 0, s6e0, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 141, 0, i68b, 0xa0a1a2a35f5e5d8b)
	 					Store(b6e0, i68b)
						m680(arg0, 142, 0, i68b, 0xfe7cb391d650a284)
	 					Store(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, i68b)
						m680(arg0, 143, 0, i68b, 0xc179b3fe)
						m680(arg0, 144, 0, b6e0, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(4) {	// Package
	 					Store(Package(){0xfe7cb391d650a284}, i684)
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 145, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 146, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(2) {	// Method ArgX Object
				m000(Concatenate(arg0, "-m000"), arg2,
					0xfe7cb391d650a284, "FE7CB391D650A284", Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
			}
			Case(3) {	// Method LocalX Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(0xfe7cb391d650a284, Local0)
					}
					Case(2) {	// String
	 					Store("FE7CB391D650A284", Local0)
					}
					Case(3) {	// Buffer
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, Local0)
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 147, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 148, 0, 0, arg1, arg2)
						Return (1)
					}
				}
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 149, 0, i68c, 0xa0a1a2a35f5e5d8c)
						Store(Local0, i68c)
						m680(arg0, 150, 0, i68c, 0xfe7cb391d650a284)
						Store(0xc179b3fe, i68c)
						m680(arg0, 151, 0, i68c, 0xc179b3fe)
						m680(arg0, 152, 0, Local0, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 153, 0, i68d, 0xa0a1a2a35f5e5d8d)
	 					Store(Local0, i68d)

						if (y602) {
							if (F64) {
								Store(0xfe7cb391d650a284, i000)
							} else {
								Store(0xfe7cb391, i000)
							}
						} else {
							Store(0xfe7cb391d650a284, i000)
						}

						m680(arg0, 154, 0, i68d, i000)

	 					Store("C179B3FE", i68d)
						m680(arg0, 155, 0, i68d, 0xc179b3fe)
						m680(arg0, 156, 0, Local0, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 157, 0, i68e, 0xa0a1a2a35f5e5d8e)
	 					Store(Local0, i68e)
						m680(arg0, 158, 0, i68e, 0xfe7cb391d650a284)
	 					Store(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, i68e)
						m680(arg0, 159, 0, i68e, 0xc179b3fe)
						m680(arg0, 160, 0, Local0, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
				}
			}
			Case(4) {	// Derefof of intermediate Object (Method ArgX Object)
				m001(Concatenate(arg0, "-m001"), arg2, Refof(i6e1), Refof(s6e1), Refof(b6e1))
			}
			Case(5) {	// Derefof of immediate Index(...)
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 161, 0, i68f, 0xa0a1a2a35f5e5d8f)
						Store(Derefof(Index(p690, 0)), i68f)
						m680(arg0, 162, 0, i68f, 0xfe7cb391d650a284)
						Store(0xc179b3fe, i68f)
						m680(arg0, 163, 0, i68f, 0xc179b3fe)
						m680(arg0, 164, 0, Derefof(Index(p690, 0)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 165, 0, i690, 0xa0a1a2a35f5e5d90)
	 					Store(Derefof(Index(p690, 1)), i690)

						if (y602) {
							if (F64) {
								Store(0xfe7cb391d650a284, i000)
							} else {
								Store(0xfe7cb391, i000)
							}
						} else {
							Store(0xfe7cb391d650a284, i000)
						}

						m680(arg0, 166, 0, i690, i000)

	 					Store("C179B3FE", i690)
						m680(arg0, 167, 0, i690, 0xc179b3fe)
						m680(arg0, 168, 0, Derefof(Index(p690, 1)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 169, 0, i691, 0xa0a1a2a35f5e5d91)
	 					Store(Derefof(Index(p690, 2)), i691)
						m680(arg0, 170, 0, i691, 0xfe7cb391d650a284)
	 					Store(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, i691)
						m680(arg0, 171, 0, i691, 0xc179b3fe)
						m680(arg0, 172, 0, Derefof(Index(p690, 2)), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 173, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 174, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(6) {	// Derefof of Indexed Reference returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 175, 0, i692, 0xa0a1a2a35f5e5d92)
						Store(Derefof(m681(p690, 3)), i692)
						m680(arg0, 176, 0, i692, 0xfe7cb391d650a284)
						Store(0xc179b3fe, i692)
						m680(arg0, 177, 0, i692, 0xc179b3fe)
						m680(arg0, 178, 0, Derefof(Index(p690, 3)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 179, 0, i693, 0xa0a1a2a35f5e5d93)
	 					Store(Derefof(m681(p690, 4)), i693)

						if (y602) {
							if (F64) {
								Store(0xfe7cb391d650a284, i000)
							} else {
								Store(0xfe7cb391, i000)
							}
						} else {
							Store(0xfe7cb391d650a284, i000)
						}

						m680(arg0, 180, 0, i693, i000)

	 					Store("C179B3FE", i693)
						m680(arg0, 181, 0, i693, 0xc179b3fe)
						m680(arg0, 182, 0, Derefof(Index(p690, 4)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 183, 0, i694, 0xa0a1a2a35f5e5d94)
	 					Store(Derefof(m681(p690, 5)), i694)
						m680(arg0, 184, 0, i694, 0xfe7cb391d650a284)
	 					Store(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, i694)
						m680(arg0, 185, 0, i694, 0xc179b3fe)
						m680(arg0, 186, 0, Derefof(Index(p690, 5)), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 187, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 188, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(7) {	// Result Object returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 189, 0, i695, 0xa0a1a2a35f5e5d95)
						Store(m682(arg2, 2), i695)
						m680(arg0, 190, 0, i695, 0xfe7cb391d650a284)
						Store(0xc179b3fe, i695)
						m680(arg0, 191, 0, i695, 0xc179b3fe)
						m680(arg0, 192, 0, i6e2, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 193, 0, i696, 0xa0a1a2a35f5e5d96)
	 					Store(m682(arg2, 2), i696)

						if (y602) {
							if (F64) {
								Store(0xfe7cb391d650a284, i000)
							} else {
								Store(0xfe7cb391, i000)
							}
						} else {
							Store(0xfe7cb391d650a284, i000)
						}

						m680(arg0, 194, 0, i696, i000)

	 					Store("C179B3FE", i696)
						m680(arg0, 195, 0, i696, 0xc179b3fe)
						m680(arg0, 196, 0, s6e2, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 197, 0, i697, 0xa0a1a2a35f5e5d97)
	 					Store(m682(arg2, 2), i697)
						m680(arg0, 198, 0, i697, 0xfe7cb391d650a284)
	 					Store(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, i697)
						m680(arg0, 199, 0, i697, 0xc179b3fe)
						m680(arg0, 200, 0, b6e2, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 201, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 202, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(8) {	// Result Object returned by any Operator (Op)
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 203, 0, i698, 0xa0a1a2a35f5e5d98)
						Store(Add(i6e3, 0), i698)
						m680(arg0, 204, 0, i698, 0xfe7cb391d650a284)
						Store(0xc179b3fe, i698)
						m680(arg0, 205, 0, i698, 0xc179b3fe)
						m680(arg0, 206, 0, i6e3, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 207, 0, i699, 0xa0a1a2a35f5e5d99)
	 					Store(Mid(s6e3, 2, 14), i699)

						if (y602) {
							if (F64) {
								Store(0x7cb391d650a284, i000)
							} else {
								Store(0x7cb391d6, i000)
							}
						} else {
							Store(0x7cb391d650a284, i000)
						}

						m680(arg0, 208, 0, i699, i000)

	 					Store("C179B3FE", i699)
						m680(arg0, 209, 0, i699, 0xc179b3fe)
						m680(arg0, 210, 0, s6e3, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 211, 0, i69a, 0xa0a1a2a35f5e5d9a)
	 					Store(Mid(b6e3, 1, 7), i69a)
						m680(arg0, 212, 0, i69a, 0xfe7cb391d650a2)
	 					Store(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, i69a)
						m680(arg0, 213, 0, i69a, 0xc179b3fe)
						m680(arg0, 214, 0, b6e3, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 215, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 216, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			// Additionally can be implemented cases:
			// Derefof of immediate Refof
			// Derefof of intermediate Object
			// Derefof of Reference returned by called Method
			Default {
				Store("Unexpected way to obtain some result Object", Debug)
				err(terr, z123, 217, 0, 0, arg1, arg2)
				Return (1)
			}
		}
		Return (0)
	}

	// Store() Result Object to Integer Method LocalX Object
	Method(m013, 3, Serialized)
	{
		// ArgX as a way to obtain some result object
		Method(m000, 5, Serialized)
		{
			Store(0xa0a1a2a35f5e5d5c, Local1)

			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					m680(arg0, 218, 0, Local1, 0xa0a1a2a35f5e5d5c)
					Store(arg2, Local1)
					if (F64) {
						m680(arg0, 219, 0, Local1, 0xfe7cb391d650a284)
					} else {
						m680(arg0, 220, 0, Local1, 0xd650a284)
					}
					Store(0xc179b3fe, Local1)
					m680(arg0, 221, 0, Local1, 0xc179b3fe)
					m680(arg0, 222, 0, arg2, 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					m680(arg0, 223, 0, Local1, 0xa0a1a2a35f5e5d5c)
					Store(arg3, Local1)
					m680(arg0, 224, 0, Local1, "FE7CB391D650A284")
					Store(0xb, Index(Local1, 3))
					m680(arg0, 225, 0, Local1, "FE7\x0BB391D650A284")
					m680(arg0, 226, 0, arg3, "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					m680(arg0, 227, 0, Local1, 0xa0a1a2a35f5e5d5c)
					Store(arg4, Local1)
					m680(arg0, 228, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					Store(0xb, Index(Local1, 3))
					m680(arg0, 229, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE})
					m680(arg0, 230, 0, arg4, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 231, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 232, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		// Reference in ArgX as a way to obtain some result object
		Method(m001, 5, Serialized)
		{
			Store(0xa0a1a2a35f5e5d5c, Local1)

			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					m680(arg0, 233, 0, Local1, 0xa0a1a2a35f5e5d5c)
					Store(Derefof(arg2), Local1)
					if (F64) {
						m680(arg0, 234, 0, Local1, 0xfe7cb391d650a284)
					} else {
						m680(arg0, 235, 0, Local1, 0xd650a284)
					}
					Store(0xc179b3fe, Local1)
					m680(arg0, 236, 0, Local1, 0xc179b3fe)
					m680(arg0, 237, 0, Derefof(arg2), 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					m680(arg0, 238, 0, Local1, 0xa0a1a2a35f5e5d5c)
					Store(Derefof(arg3), Local1)
					m680(arg0, 239, 0, Local1, "FE7CB391D650A284")
					Store(0xb, Index(Local1, 3))
					m680(arg0, 240, 0, Local1, "FE7\x0BB391D650A284")
					m680(arg0, 241, 0, Derefof(arg3), "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					m680(arg0, 242, 0, Local1, 0xa0a1a2a35f5e5d5c)
					Store(Derefof(arg4), Local1)
					m680(arg0, 243, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					Store(0xb, Index(Local1, 3))
					m680(arg0, 244, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE})
					m680(arg0, 245, 0, Derefof(arg4), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 246, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 247, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		Store(0xa0a1a2a35f5e5d5c, Local1)

		// Choose a way to obtain some result object
		Switch(ToInteger (arg1)) {
			Case(0) {	// Data Image

				// Choose a type of the result Object and specific source
				// objects to obtain the result Object of the specified type.
				// Check that the destination Object is properly initialized.
				// Perform storing expression and check result.
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 248, 0, Local1, 0xa0a1a2a35f5e5d5c)
						Store(0xfe7cb391d650a284, Local1)
						if (F64) {
							m680(arg0, 249, 0, Local1, 0xfe7cb391d650a284)
						} else {
							m680(arg0, 250, 0, Local1, 0xd650a284)
						}
					}
					Case(2) {	// String
						m680(arg0, 251, 0, Local1, 0xa0a1a2a35f5e5d5c)
	 					Store("FE7CB391D650A284", Local1)
						m680(arg0, 252, 0, Local1, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 253, 0, Local1, 0xa0a1a2a35f5e5d5c)
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, Local1)
						m680(arg0, 254, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 255, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 256, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(1) {	// Named Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 257, 0, Local1, 0xa0a1a2a35f5e5d5c)
						Store(i6e4, Local1)
						if (F64) {
							m680(arg0, 258, 0, Local1, 0xfe7cb391d650a284)
						} else {
							m680(arg0, 259, 0, Local1, 0xd650a284)
						}
						Store(0xc179b3fe, Local1)
						m680(arg0, 260, 0, Local1, 0xc179b3fe)
						m680(arg0, 261, 0, i6e4, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 262, 0, Local1, 0xa0a1a2a35f5e5d5c)
	 					Store(s6e4, Local1)
						m680(arg0, 263, 0, Local1, "FE7CB391D650A284")
						Store(0xb, Index(Local1, 3))
						m680(arg0, 264, 0, Local1, "FE7\x0BB391D650A284")
						m680(arg0, 265, 0, s6e4, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 266, 0, Local1, 0xa0a1a2a35f5e5d5c)
	 					Store(b6e4, Local1)
						m680(arg0, 267, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
						Store(0xb, Index(Local1, 3))
						m680(arg0, 268, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE})
						m680(arg0, 269, 0, b6e4, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Default {
						Store("Unexpected type of the result Object to be stored", Debug)
						err(terr, z123, 270, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(2) {	// Method ArgX Object
				m000(Concatenate(arg0, "-m000"), arg2,
					0xfe7cb391d650a284, "FE7CB391D650A284", Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
			}
			Case(3) {	// Method LocalX Object
				Switch(ToInteger (arg2)) {
					Case(0) {	// Stuff
						Return (0)
					}
					Case(1) {	// Integer
						Store(0xfe7cb391d650a284, Local0)
					}
					Case(2) {	// String
	 					Store("FE7CB391D650A284", Local0)
					}
					Case(3) {	// Buffer
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, Local0)
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 271, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 272, 0, 0, arg1, arg2)
						Return (1)
					}
				}
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 273, 0, Local1, 0xa0a1a2a35f5e5d5c)
						Store(Local0, Local1)
						if (F64) {
							m680(arg0, 274, 0, Local1, 0xfe7cb391d650a284)
						} else {
							m680(arg0, 275, 0, Local1, 0xd650a284)
						}
						Store(0xc179b3fe, Local1)
						m680(arg0, 276, 0, Local1, 0xc179b3fe)
						m680(arg0, 277, 0, Local0, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 278, 0, Local1, 0xa0a1a2a35f5e5d5c)
	 					Store(Local0, Local1)
						m680(arg0, 279, 0, Local1, "FE7CB391D650A284")
						Store(0xb, Index(Local1, 3))
						m680(arg0, 280, 0, Local1, "FE7\x0BB391D650A284")
						m680(arg0, 281, 0, Local0, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 282, 0, Local1, 0xa0a1a2a35f5e5d5c)
	 					Store(Local0, Local1)
						m680(arg0, 283, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
						Store(0xb, Index(Local1, 3))
						m680(arg0, 284, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE})
						m680(arg0, 285, 0, Local0, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
				}
			}
			Case(4) {	// Derefof of intermediate Object (Method ArgX Object)
				m001(Concatenate(arg0, "-m001"), arg2, Refof(i6e5), Refof(s6e5), Refof(b6e5))
			}
			Case(5) {	// Derefof of immediate Index(...)
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 286, 0, Local1, 0xa0a1a2a35f5e5d5c)
						Store(Derefof(Index(p690, 6)), Local1)
						if (F64) {
							m680(arg0, 287, 0, Local1, 0xfe7cb391d650a284)
						} else {
							m680(arg0, 288, 0, Local1, 0xd650a284)
						}
						Store(0xc179b3fe, Local1)
						m680(arg0, 289, 0, Local1, 0xc179b3fe)
						m680(arg0, 290, 0, Derefof(Index(p690, 6)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 291, 0, Local1, 0xa0a1a2a35f5e5d5c)
	 					Store(Derefof(Index(p690, 7)), Local1)
						m680(arg0, 292, 0, Local1, "FE7CB391D650A284")
						Store(0xb, Index(Local1, 3))
						m680(arg0, 293, 0, Local1, "FE7\x0BB391D650A284")
						m680(arg0, 294, 0, Derefof(Index(p690, 7)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 295, 0, Local1, 0xa0a1a2a35f5e5d5c)
	 					Store(Derefof(Index(p690, 8)), Local1)
						m680(arg0, 296, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
						Store(0xb, Index(Local1, 3))
						m680(arg0, 297, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE})
						m680(arg0, 298, 0, Derefof(Index(p690, 8)), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 299, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 300, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(6) {	// Derefof of Indexed Reference returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 301, 0, Local1, 0xa0a1a2a35f5e5d5c)
						Store(Derefof(m681(p690, 9)), Local1)
						if (F64) {
							m680(arg0, 302, 0, Local1, 0xfe7cb391d650a284)
						} else {
							m680(arg0, 303, 0, Local1, 0xd650a284)
						}
						Store(0xc179b3fe, Local1)
						m680(arg0, 304, 0, Local1, 0xc179b3fe)
						m680(arg0, 305, 0, Derefof(Index(p690, 9)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 306, 0, Local1, 0xa0a1a2a35f5e5d5c)
	 					Store(Derefof(m681(p690, 10)), Local1)
						m680(arg0, 307, 0, Local1, "FE7CB391D650A284")
						Store(0xb, Index(Local1, 3))
						m680(arg0, 308, 0, Local1, "FE7\x0BB391D650A284")
						m680(arg0, 309, 0, Derefof(Index(p690, 10)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 310, 0, Local1, 0xa0a1a2a35f5e5d5c)
	 					Store(Derefof(m681(p690, 11)), Local1)
						m680(arg0, 311, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
						Store(0xb, Index(Local1, 3))
						m680(arg0, 312, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE})
						m680(arg0, 313, 0, Derefof(Index(p690, 11)), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
				}
			}
			Case(7) {	// Result Object returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 314, 0, Local1, 0xa0a1a2a35f5e5d5c)
						Store(m682(arg2, 6), Local1)
						if (F64) {
							m680(arg0, 315, 0, Local1, 0xfe7cb391d650a284)
						} else {
							m680(arg0, 316, 0, Local1, 0xd650a284)
						}
						Store(0xc179b3fe, Local1)
						m680(arg0, 317, 0, Local1, 0xc179b3fe)
						m680(arg0, 318, 0, i6e6, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 319, 0, Local1, 0xa0a1a2a35f5e5d5c)
	 					Store(m682(arg2, 6), Local1)
						m680(arg0, 320, 0, Local1, "FE7CB391D650A284")
						Store(0xb, Index(Local1, 3))
						m680(arg0, 321, 0, Local1, "FE7\x0BB391D650A284")
						m680(arg0, 322, 0, s6e6, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 323, 0, Local1, 0xa0a1a2a35f5e5d5c)
	 					Store(m682(arg2, 6), Local1)
						m680(arg0, 324, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
						Store(0xb, Index(Local1, 3))
						m680(arg0, 325, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE})
						m680(arg0, 326, 0, b6e6, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 327, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 328, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(8) {	// Result Object returned by any Operator (Op):
						// Add, Mid
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 329, 0, Local1, 0xa0a1a2a35f5e5d5c)
						Store(Add(i6e7, 0), Local1)
						if (F64) {
							m680(arg0, 330, 0, Local1, 0xfe7cb391d650a284)
						} else {
							m680(arg0, 331, 0, Local1, 0xd650a284)
						}
						Store(0xc179b3fe, Local1)
						m680(arg0, 332, 0, Local1, 0xc179b3fe)
						m680(arg0, 333, 0, i6e7, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 334, 0, Local1, 0xa0a1a2a35f5e5d5c)
	 					Store(Mid(s6e7, 2, 14), Local1)
						m680(arg0, 335, 0, Local1, "7CB391D650A284")
						Store(0xb, Index(Local1, 3))
						m680(arg0, 336, 0, Local1, "7CB\x0B91D650A284")
						m680(arg0, 337, 0, s6e7, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 338, 0, Local1, 0xa0a1a2a35f5e5d5c)
	 					Store(Mid(b6e7, 1, 7), Local1)
						m680(arg0, 339, 0, Local1, Buffer() {0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
						Store(0xb, Index(Local1, 3))
						m680(arg0, 340, 0, Local1, Buffer() {0xA2, 0x50, 0xD6, 0x0B, 0xB3, 0x7C, 0xFE})
						m680(arg0, 341, 0, b6e7, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 342, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 343, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			// Additionally can be implemented cases:
			// Derefof of immediate Refof
			// Derefof of intermediate Object
			// Derefof of Reference returned by called Method
			Default {
				Store("Unexpected way to obtain some result Object", Debug)
				err(terr, z123, 344, 0, 0, arg1, arg2)
				Return (1)
			}
		}
		Return (0)
	}

	// Store() Result Object to String Named Object
	Method(m021, 3, Serialized)
	{
		// ArgX as a way to obtain some result object
		Method(m000, 5, Serialized)
		{
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					m680(arg0, 345, 0, s680, "initial named string80")
					Store(arg2, s680)
						if (F64) {
							m680(arg0, 346, 0, s680, "FE7CB391D650A284")
						} else {
							m680(arg0, 347, 0, s680, "D650A284")
						}
						Store(0xb, Index(s680, 3))
						if (F64) {
							m680(arg0, 348, 0, s680, "FE7\x0BB391D650A284")
						} else {
							m680(arg0, 349, 0, s680, "D65\x0BA284")
						}
					m680(arg0, 350, 0, arg2, 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					m680(arg0, 351, 0, s681, "initial named string81")
					Store(arg3, s681)
					m680(arg0, 352, 0, s681, "FE7CB391D650A284")
					Store(0xb, Index(s681, 3))
					m680(arg0, 353, 0, s681, "FE7\x0BB391D650A284")
					m680(arg0, 354, 0, arg3, "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					m680(arg0, 355, 0, s682, "initial named string82")
					Store(arg4, s682)
					m680(arg0, 356, 0, s682, "84 A2 50 D6 91 B3 7C FE")
					Store(0xb, Index(s682, 3))
					m680(arg0, 357, 0, s682, "84 \x0B2 50 D6 91 B3 7C FE")
					m680(arg0, 358, 0, arg4, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 359, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 360, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		// Reference in ArgX as a way to obtain some result object
		Method(m001, 5, Serialized)
		{
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					m680(arg0, 361, 0, s683, "initial named string83")
					Store(Derefof(arg2), s683)
						if (F64) {
							m680(arg0, 362, 0, s683, "FE7CB391D650A284")
						} else {
							m680(arg0, 363, 0, s683, "D650A284")
						}
						Store(0xb, Index(s683, 3))
						if (F64) {
							m680(arg0, 364, 0, s683, "FE7\x0BB391D650A284")
						} else {
							m680(arg0, 365, 0, s683, "D65\x0BA284")
						}
					m680(arg0, 366, 0, Derefof(arg2), 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					m680(arg0, 367, 0, s684, "initial named string84")
					Store(Derefof(arg3), s684)
					m680(arg0, 368, 0, s684, "FE7CB391D650A284")
					Store(0xb, Index(s684, 3))
					m680(arg0, 369, 0, s684, "FE7\x0BB391D650A284")
					m680(arg0, 370, 0, Derefof(arg3), "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					m680(arg0, 371, 0, s685, "initial named string85")
					Store(Derefof(arg4), s685)
					m680(arg0, 372, 0, s685, "84 A2 50 D6 91 B3 7C FE")
					Store(0xb, Index(s685, 3))
					m680(arg0, 373, 0, s685, "84 \x0B2 50 D6 91 B3 7C FE")
					m680(arg0, 374, 0, Derefof(arg4), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 375, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 376, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		// Choose a way to obtain some result object
		Switch(ToInteger (arg1)) {
			Case(0) {	// Data Image

				// Choose a type of the result Object and specific source
				// objects to obtain the result Object of the specified type.
				// Check that the destination Object is properly initialized.
				// Perform storing expression and check result.
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 377, 0, s686, "initial named string86")
						Store(0xfe7cb391d650a284, s686)
						if (F64) {
							m680(arg0, 378, 0, s686, "FE7CB391D650A284")
						} else {
							m680(arg0, 379, 0, s686, "D650A284")
						}
					}
					Case(2) {	// String
						m680(arg0, 380, 0, s687, "initial named string87")
	 					Store("FE7CB391D650A284", s687)
						m680(arg0, 381, 0, s687, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 382, 0, s688, "initial named string88")
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, s688)
						m680(arg0, 383, 0, s688, "84 A2 50 D6 91 B3 7C FE")
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 384, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 385, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(1) {	// Named Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 386, 0, s689, "initial named string89")
						Store(i6e4, s689)
						if (F64) {
							m680(arg0, 387, 0, s689, "FE7CB391D650A284")
						} else {
							m680(arg0, 388, 0, s689, "D650A284")
						}
						Store(0xb, Index(s689, 3))
						if (F64) {
							m680(arg0, 389, 0, s689, "FE7\x0BB391D650A284")
						} else {
							m680(arg0, 390, 0, s689, "D65\x0BA284")
						}
						m680(arg0, 391, 0, i6e4, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 392, 0, s68a, "initial named string8a")
	 					Store(s6e4, s68a)
						m680(arg0, 393, 0, s68a, "FE7CB391D650A284")
						Store(0xb, Index(s68a, 3))
						m680(arg0, 394, 0, s68a, "FE7\x0BB391D650A284")
						m680(arg0, 395, 0, s6e4, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 396, 0, s68b, "initial named string8b")
	 					Store(b6e4, s68b)
						m680(arg0, 397, 0, s68b, "84 A2 50 D6 91 B3 7C FE")
						Store(0xb, Index(s68b, 3))
						m680(arg0, 398, 0, s68b, "84 \x0B2 50 D6 91 B3 7C FE")
						m680(arg0, 399, 0, b6e4, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 400, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 401, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(2) {	// Method ArgX Object
				m000(Concatenate(arg0, "-m000"), arg2,
					0xfe7cb391d650a284, "FE7CB391D650A284", Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
			}
			Case(3) {	// Method LocalX Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(0xfe7cb391d650a284, Local0)
					}
					Case(2) {	// String
	 					Store("FE7CB391D650A284", Local0)
					}
					Case(3) {	// Buffer
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, Local0)
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 402, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 403, 0, 0, arg1, arg2)
						Return (1)
					}
				}
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 404, 0, s68c, "initial named string8c")
						Store(Local0, s68c)
						if (F64) {
							m680(arg0, 405, 0, s68c, "FE7CB391D650A284")
						} else {
							m680(arg0, 406, 0, s68c, "D650A284")
						}
						Store(0xb, Index(s68c, 3))
						if (F64) {
							m680(arg0, 407, 0, s68c, "FE7\x0BB391D650A284")
						} else {
							m680(arg0, 408, 0, s68c, "D65\x0BA284")
						}
						m680(arg0, 409, 0, Local0, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 410, 0, s68d, "initial named string8d")
	 					Store(Local0, s68d)
						m680(arg0, 411, 0, s68d, "FE7CB391D650A284")
						Store(0xb, Index(s68d, 3))
						m680(arg0, 412, 0, s68d, "FE7\x0BB391D650A284")
						m680(arg0, 413, 0, Local0, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 414, 0, s68e, "initial named string8e")
	 					Store(Local0, s68e)
						m680(arg0, 415, 0, s68e, "84 A2 50 D6 91 B3 7C FE")
						Store(0xb, Index(s68e, 3))
						m680(arg0, 416, 0, s68e, "84 \x0B2 50 D6 91 B3 7C FE")
						m680(arg0, 417, 0, Local0, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
				}
			}
			Case(4) {	// Derefof of intermediate Object (Method ArgX Object)
				m001(Concatenate(arg0, "-m001"), arg2, Refof(i6e5), Refof(s6e5), Refof(b6e5))
			}
			Case(5) {	// Derefof of immediate Index(...)
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 418, 0, s68f, "initial named string8f")
						Store(Derefof(Index(p690, 6)), s68f)
						if (F64) {
							m680(arg0, 419, 0, s68f, "FE7CB391D650A284")
						} else {
							m680(arg0, 420, 0, s68f, "D650A284")
						}
						Store(0xb, Index(s68f, 3))
						if (F64) {
							m680(arg0, 421, 0, s68f, "FE7\x0BB391D650A284")
						} else {
							m680(arg0, 422, 0, s68f, "D65\x0BA284")
						}
						m680(arg0, 423, 0, Derefof(Index(p690, 6)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 424, 0, s690, "initial named string90")
	 					Store(Derefof(Index(p690, 7)), s690)
						m680(arg0, 425, 0, s690, "FE7CB391D650A284")
						Store(0xb, Index(s690, 3))
						m680(arg0, 426, 0, s690, "FE7\x0BB391D650A284")
						m680(arg0, 427, 0, Derefof(Index(p690, 7)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 428, 0, s691, "initial named string91")
	 					Store(Derefof(Index(p690, 8)), s691)
						m680(arg0, 429, 0, s691, "84 A2 50 D6 91 B3 7C FE")
						Store(0xb, Index(s691, 3))
						m680(arg0, 430, 0, s691, "84 \x0B2 50 D6 91 B3 7C FE")
						m680(arg0, 431, 0, Derefof(Index(p690, 8)), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 432, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 433, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(6) {	// Derefof of Indexed Reference returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 434, 0, s692, "initial named string92")
						Store(Derefof(m681(p690, 9)), s692)
						if (F64) {
							m680(arg0, 435, 0, s692, "FE7CB391D650A284")
						} else {
							m680(arg0, 436, 0, s692, "D650A284")
						}
						Store(0xb, Index(s692, 3))
						if (F64) {
							m680(arg0, 437, 0, s692, "FE7\x0BB391D650A284")
						} else {
							m680(arg0, 438, 0, s692, "D65\x0BA284")
						}
						m680(arg0, 439, 0, Derefof(Index(p690, 9)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 440, 0, s693, "initial named string93")
	 					Store(Derefof(m681(p690, 10)), s693)
						m680(arg0, 441, 0, s693, "FE7CB391D650A284")
						Store(0xb, Index(s693, 3))
						m680(arg0, 442, 0, s693, "FE7\x0BB391D650A284")
						m680(arg0, 443, 0, Derefof(Index(p690, 10)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 444, 0, s694, "initial named string94")
	 					Store(Derefof(m681(p690, 11)), s694)
						m680(arg0, 445, 0, s694, "84 A2 50 D6 91 B3 7C FE")
						Store(0xb, Index(s694, 3))
						m680(arg0, 446, 0, s694, "84 \x0B2 50 D6 91 B3 7C FE")
						m680(arg0, 447, 0, Derefof(Index(p690, 11)), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 448, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 449, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(7) {	// Result Object returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 450, 0, s695, "initial named string95")
						Store(m682(arg2, 6), s695)
						if (F64) {
							m680(arg0, 451, 0, s695, "FE7CB391D650A284")
						} else {
							m680(arg0, 452, 0, s695, "D650A284")
						}
						Store(0xb, Index(s695, 3))
						if (F64) {
							m680(arg0, 453, 0, s695, "FE7\x0BB391D650A284")
						} else {
							m680(arg0, 454, 0, s695, "D65\x0BA284")
						}
						m680(arg0, 455, 0, i6e6, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 456, 0, s696, "initial named string96")
	 					Store(m682(arg2, 6), s696)
						m680(arg0, 457, 0, s696, "FE7CB391D650A284")
						Store(0xb, Index(s696, 3))
						m680(arg0, 458, 0, s696, "FE7\x0BB391D650A284")
						m680(arg0, 459, 0, s6e6, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 460, 0, s697, "initial named string97")
	 					Store(m682(arg2, 6), s697)
						m680(arg0, 461, 0, s697, "84 A2 50 D6 91 B3 7C FE")
						Store(0xb, Index(s697, 3))
						m680(arg0, 462, 0, s697, "84 \x0B2 50 D6 91 B3 7C FE")
						m680(arg0, 463, 0, b6e6, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 464, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 465, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(8) {	// Result Object returned by any Operator (Op):
						// Add, Mid
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 466, 0, s698, "initial named string98")
						Store(Add(i6e7, 0), s698)
						if (F64) {
							m680(arg0, 467, 0, s698, "FE7CB391D650A284")
						} else {
							m680(arg0, 468, 0, s698, "D650A284")
						}
						Store(0xb, Index(s698, 3))
						if (F64) {
							m680(arg0, 469, 0, s698, "FE7\x0BB391D650A284")
						} else {
							m680(arg0, 470, 0, s698, "D65\x0BA284")
						}
						m680(arg0, 471, 0, i6e7, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 472, 0, s699, "initial named string99")
	 					Store(Mid(s6e7, 2, 14), s699)
						m680(arg0, 473, 0, s699, "7CB391D650A284")
						Store(0xb, Index(s699, 3))
						m680(arg0, 474, 0, s699, "7CB\x0B91D650A284")
						m680(arg0, 475, 0, s6e7, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 476, 0, s69a, "initial named string9a")
	 					Store(Mid(b6e7, 1, 7), s69a)
						m680(arg0, 477, 0, s69a, "A2 50 D6 91 B3 7C FE")
						Store(0xb, Index(s69a, 3))
						m680(arg0, 478, 0, s69a, "A2 \x0B0 D6 91 B3 7C FE")
						m680(arg0, 479, 0, b6e7, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 480, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 481, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			// Additionally can be implemented cases:
			// Derefof of immediate Refof
			// Derefof of intermediate Object
			// Derefof of Reference returned by called Method
			Default {
				Store("Unexpected way to obtain some result Object", Debug)
				err(terr, z123, 482, 0, 0, arg1, arg2)
				Return (1)
			}
		}
		Return (0)
	}

	// Store() Result Object to Buffer Named Object
	Method(m031, 3, Serialized)
	{
		// ArgX as a way to obtain some result object
		Method(m000, 5, Serialized)
		{
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					m680(arg0, 483, 0, b680, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x80})
					Store(arg2, b680)
					if (F64) {
						m680(arg0, 484, 0, b680, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
					} else {
						m680(arg0, 485, 0, b680, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x00, 0x00, 0x00, 0x00, 0x00})
					}
					Store(0xb, Index(b680, 3))
					if (F64) {
						m680(arg0, 486, 0, b680, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
					} else {
						m680(arg0, 487, 0, b680, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x00, 0x00, 0x00, 0x00, 0x00})
					}
					m680(arg0, 488, 0, arg2, 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					m680(arg0, 489, 0, b681, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x81})
					Store(arg3, b681)
					m680(arg0, 490, 0, b681, Buffer(9){0x46, 0x45, 0x37, 0x43, 0x42, 0x33, 0x39, 0x31, 0x44})
					Store(0xb, Index(b681, 3))
					m680(arg0, 491, 0, b681, Buffer(9){0x46, 0x45, 0x37, 0x0B, 0x42, 0x33, 0x39, 0x31, 0x44})
					m680(arg0, 492, 0, arg3, "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					m680(arg0, 493, 0, b682, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x82})
					Store(arg4, b682)
					m680(arg0, 494, 0, b682, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
					Store(0xb, Index(b682, 3))
					m680(arg0, 495, 0, b682, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
					m680(arg0, 496, 0, arg4, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 497, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 498, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		// Reference in ArgX as a way to obtain some result object
		Method(m001, 5, Serialized)
		{
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					m680(arg0, 499, 0, b683, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x83})
					Store(Derefof(arg2), b683)
					if (F64) {
						m680(arg0, 500, 0, b683, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
					} else {
						m680(arg0, 501, 0, b683, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x00, 0x00, 0x00, 0x00, 0x00})
					}
					Store(0xb, Index(b683, 3))
					if (F64) {
						m680(arg0, 502, 0, b683, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
					} else {
						m680(arg0, 503, 0, b683, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x00, 0x00, 0x00, 0x00, 0x00})
					}
					m680(arg0, 504, 0, Derefof(arg2), 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					m680(arg0, 505, 0, b684, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x84})
					Store(Derefof(arg3), b684)
					m680(arg0, 506, 0, b684, Buffer(9){0x46, 0x45, 0x37, 0x43, 0x42, 0x33, 0x39, 0x31, 0x44})
					Store(0xb, Index(b684, 3))
					m680(arg0, 507, 0, b684, Buffer(9){0x46, 0x45, 0x37, 0x0B, 0x42, 0x33, 0x39, 0x31, 0x44})
					m680(arg0, 508, 0, Derefof(arg3), "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					m680(arg0, 509, 0, b685, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x85})
					Store(Derefof(arg4), b685)
					m680(arg0, 510, 0, b685, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
					Store(0xb, Index(b685, 3))
					m680(arg0, 511, 0, b685, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
					m680(arg0, 512, 0, Derefof(arg4), Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 513, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 514, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

// Store(Concatenate(Concatenate(arg0, arg1), arg2), Debug)

		// Choose a way to obtain some result object
		Switch(ToInteger (arg1)) {
			Case(0) {	// Data Image

				// Choose a type of the result Object and specific source
				// objects to obtain the result Object of the specified type.
				// Check that the destination Object is properly initialized.
				// Perform storing expression and check result.
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 515, 0, b686, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x86})
						Store(0xfe7cb391d650a284, b686)
						if (F64) {
							m680(arg0, 516, 0, b686, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						} else {
							m680(arg0, 517, 0, b686, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x00, 0x00, 0x00, 0x00, 0x00})
						}
					}
					Case(2) {	// String
						m680(arg0, 518, 0, b687, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x87})
	 					Store("FE7CB391D650A284", b687)
						m680(arg0, 519, 0, b687, Buffer(9){0x46, 0x45, 0x37, 0x43, 0x42, 0x33, 0x39, 0x31, 0x44})
					}
					Case(3) {	// Buffer
						m680(arg0, 520, 0, b688, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x88})
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, b688)
						m680(arg0, 521, 0, b688, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 522, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 523, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(1) {	// Named Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 524, 0, b689, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x89})
						Store(i6e4, b689)
						if (F64) {
							m680(arg0, 525, 0, b689, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						} else {
							m680(arg0, 526, 0, b689, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x00, 0x00, 0x00, 0x00, 0x00})
						}
						Store(0xb, Index(b689, 3))
						if (F64) {
							m680(arg0, 527, 0, b689, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						} else {
							m680(arg0, 528, 0, b689, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x00, 0x00, 0x00, 0x00, 0x00})
						}
						m680(arg0, 529, 0, i6e4, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 530, 0, b68a, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x8a})
	 					Store(s6e4, b68a)
						m680(arg0, 531, 0, b68a, Buffer(9){0x46, 0x45, 0x37, 0x43, 0x42, 0x33, 0x39, 0x31, 0x44})
						Store(0xb, Index(b68a, 3))
						m680(arg0, 532, 0, b68a, Buffer(9){0x46, 0x45, 0x37, 0x0B, 0x42, 0x33, 0x39, 0x31, 0x44})
						m680(arg0, 533, 0, s6e4, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 534, 0, b68b, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x8b})
	 					Store(b6e4, b68b)
						m680(arg0, 535, 0, b68b, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						Store(0xb, Index(b68b, 3))
						m680(arg0, 536, 0, b68b, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						m680(arg0, 537, 0, b6e4, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 538, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 539, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(2) {	// Method ArgX Object
				m000(Concatenate(arg0, "-m000"), arg2,
					0xfe7cb391d650a284, "FE7CB391D650A284", Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
			}
			Case(3) {	// Method LocalX Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(0xfe7cb391d650a284, Local0)
					}
					Case(2) {	// String
	 					Store("FE7CB391D650A284", Local0)
					}
					Case(3) {	// Buffer
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, Local0)
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 540, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 541, 0, 0, arg1, arg2)
						Return (1)
					}
				}
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 542, 0, b68c, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x8c})
						Store(Local0, b68c)
						if (F64) {
							m680(arg0, 543, 0, b68c, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						} else {
							m680(arg0, 544, 0, b68c, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x00, 0x00, 0x00, 0x00, 0x00})
						}
						Store(0xb, Index(b68c, 3))
						if (F64) {
							m680(arg0, 545, 0, b68c, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						} else {
							m680(arg0, 546, 0, b68c, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x00, 0x00, 0x00, 0x00, 0x00})
						}
						m680(arg0, 547, 0, Local0, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 548, 0, b68d, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x8d})
	 					Store(Local0, b68d)
						m680(arg0, 549, 0, b68d, Buffer(9){0x46, 0x45, 0x37, 0x43, 0x42, 0x33, 0x39, 0x31, 0x44})
						Store(0xb, Index(b68d, 3))
						m680(arg0, 550, 0, b68d, Buffer(9){0x46, 0x45, 0x37, 0x0B, 0x42, 0x33, 0x39, 0x31, 0x44})
						m680(arg0, 551, 0, Local0, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 552, 0, b68e, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x8e})
	 					Store(Local0, b68e)
						m680(arg0, 553, 0, b68e, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						Store(0xb, Index(b68e, 3))
						m680(arg0, 554, 0, b68e, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						m680(arg0, 555, 0, Local0, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
				}
			}
			Case(4) {	// Derefof of intermediate Object (Method ArgX Object)
				m001(Concatenate(arg0, "-m001"), arg2, Refof(i6e5), Refof(s6e5), Refof(b6e5))
			}
			Case(5) {	// Derefof of immediate Index(...)
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 556, 0, b68f, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x8f})
						Store(Derefof(Index(p690, 6)), b68f)
						if (F64) {
							m680(arg0, 557, 0, b68f, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						} else {
							m680(arg0, 558, 0, b68f, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x00, 0x00, 0x00, 0x00, 0x00})
						}
						Store(0xb, Index(b68f, 3))
						if (F64) {
							m680(arg0, 559, 0, b68f, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						} else {
							m680(arg0, 560, 0, b68f, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x00, 0x00, 0x00, 0x00, 0x00})
						}
						m680(arg0, 561, 0, Derefof(Index(p690, 6)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 562, 0, b690, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x90})
	 					Store(Derefof(Index(p690, 7)), b690)
						m680(arg0, 563, 0, b690, Buffer(9){0x46, 0x45, 0x37, 0x43, 0x42, 0x33, 0x39, 0x31, 0x44})
						Store(0xb, Index(b690, 3))
						m680(arg0, 564, 0, b690, Buffer(9){0x46, 0x45, 0x37, 0x0B, 0x42, 0x33, 0x39, 0x31, 0x44})
						m680(arg0, 565, 0, Derefof(Index(p690, 7)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 566, 0, b691, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x91})
	 					Store(Derefof(Index(p690, 8)), b691)
						m680(arg0, 567, 0, b691, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						Store(0xb, Index(b691, 3))
						m680(arg0, 568, 0, b691, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						m680(arg0, 569, 0, Derefof(Index(p690, 8)), Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 570, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 571, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(6) {	// Derefof of Indexed Reference returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 572, 0, b692, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x92})
						Store(Derefof(m681(p690, 9)), b692)
						if (F64) {
							m680(arg0, 573, 0, b692, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						} else {
							m680(arg0, 574, 0, b692, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x00, 0x00, 0x00, 0x00, 0x00})
						}
						Store(0xb, Index(b692, 3))
						if (F64) {
							m680(arg0, 575, 0, b692, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						} else {
							m680(arg0, 576, 0, b692, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x00, 0x00, 0x00, 0x00, 0x00})
						}
						m680(arg0, 577, 0, Derefof(Index(p690, 9)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 578, 0, b693, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x93})
	 					Store(Derefof(m681(p690, 10)), b693)
						m680(arg0, 579, 0, b693, Buffer(9){0x46, 0x45, 0x37, 0x43, 0x42, 0x33, 0x39, 0x31, 0x44})
						Store(0xb, Index(b693, 3))
						m680(arg0, 580, 0, b693, Buffer(9){0x46, 0x45, 0x37, 0x0B, 0x42, 0x33, 0x39, 0x31, 0x44})
						m680(arg0, 581, 0, Derefof(Index(p690, 10)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 582, 0, b694, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x94})
	 					Store(Derefof(m681(p690, 11)), b694)
						m680(arg0, 583, 0, b694, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						Store(0xb, Index(b694, 3))
						m680(arg0, 584, 0, b694, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						m680(arg0, 585, 0, Derefof(Index(p690, 11)), Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 586, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 587, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(7) {	// Result Object returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 588, 0, b695, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x95})
						Store(m682(arg2, 6), b695)
						if (F64) {
							m680(arg0, 589, 0, b695, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						} else {
							m680(arg0, 590, 0, b695, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x00, 0x00, 0x00, 0x00, 0x00})
						}
						Store(0xb, Index(b695, 3))
						if (F64) {
							m680(arg0, 591, 0, b695, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						} else {
							m680(arg0, 592, 0, b695, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x00, 0x00, 0x00, 0x00, 0x00})
						}
						m680(arg0, 593, 0, i6e6, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 594, 0, b696, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x96})
	 					Store(m682(arg2, 6), b696)
						m680(arg0, 595, 0, b696, Buffer(9){0x46, 0x45, 0x37, 0x43, 0x42, 0x33, 0x39, 0x31, 0x44})
						Store(0xb, Index(b696, 3))
						m680(arg0, 596, 0, b696, Buffer(9){0x46, 0x45, 0x37, 0x0B, 0x42, 0x33, 0x39, 0x31, 0x44})
						m680(arg0, 597, 0, s6e6, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 598, 0, b697, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x97})
	 					Store(m682(arg2, 6), b697)
						m680(arg0, 599, 0, b697, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						Store(0xb, Index(b697, 3))
						m680(arg0, 600, 0, b697, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						m680(arg0, 601, 0, b6e6, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 602, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 603, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(8) {	// Result Object returned by any Operator (Op):
						// Add, Mid
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 604, 0, b698, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x98})
						Store(Add(i6e7, 0), b698)
						if (F64) {
							m680(arg0, 605, 0, b698, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						} else {
							m680(arg0, 606, 0, b698, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x00, 0x00, 0x00, 0x00, 0x00})
						}
						Store(0xb, Index(b698, 3))
						if (F64) {
							m680(arg0, 607, 0, b698, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						} else {
							m680(arg0, 608, 0, b698, Buffer(9){0x84, 0xA2, 0x50, 0x0B, 0x00, 0x00, 0x00, 0x00, 0x00})
						}
						m680(arg0, 609, 0, i6e7, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 610, 0, b699, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x99})
	 					Store(Mid(s6e7, 2, 14), b699)
						m680(arg0, 611, 0, b699, Buffer(9){0x37, 0x43, 0x42, 0x33, 0x39, 0x31, 0x44, 0x36, 0x35})
						Store(0xb, Index(b699, 3))
						m680(arg0, 612, 0, b699, Buffer(9){0x37, 0x43, 0x42, 0x0B, 0x39, 0x31, 0x44, 0x36, 0x35})
						m680(arg0, 613, 0, s6e7, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 614, 0, b69a, Buffer(9){0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0x9a})
	 					Store(Mid(b6e7, 1, 7), b69a)
						m680(arg0, 615, 0, b69a, Buffer() {0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00, 0x00})
						Store(0xb, Index(b69a, 3))
						m680(arg0, 616, 0, b69a, Buffer() {0xA2, 0x50, 0xD6, 0x0B, 0xB3, 0x7C, 0xFE, 0x00, 0x00})
						m680(arg0, 617, 0, b6e7, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 618, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 619, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			// Additionally can be implemented cases:
			// Derefof of immediate Refof
			// Derefof of intermediate Object
			// Derefof of Reference returned by called Method
			Default {
				Store("Unexpected way to obtain some result Object", Debug)
				err(terr, z123, 620, 0, 0, arg1, arg2)
				Return (1)
			}
		}
		Return (0)
	}

	// Store() Result Object to Buffer Field Named Object,
	// case of the field, which is 31-bit long (bf80)
	Method(m0e0, 3, Serialized)
	{
		// ArgX as a way to obtain some result object
		Method(m000, 5, Serialized)
		{
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					Store(arg2, bf80)
					m010(arg0, 130, 1)
					m680(arg0, 621, 0, arg2, 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					Store(arg3, bf80)
					m020(arg0, 137, 1)
					m680(arg0, 622, 0, arg3, "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					Store(arg4, bf80)
					m030(arg0, 144, 1)
					m680(arg0, 623, 0, arg4, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 624, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 625, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		// Reference in ArgX as a way to obtain some result object
		Method(m001, 5, Serialized)
		{
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					Store(Derefof(arg2), bf80)
					m010(arg0, 153, 1)
					m680(arg0, 626, 0, Derefof(arg2), 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					Store(Derefof(arg3), bf80)
					m020(arg0, 160, 1)
					m680(arg0, 627, 0, Derefof(arg3), "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					Store(Derefof(arg4), bf80)
					m030(arg0, 167, 1)
					m680(arg0, 628, 0, Derefof(arg4), Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 629, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 630, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		// Check storing of 0xfe7cb391d650a284 to bf80,
		// optionally perform an additional update and check
		// m010(<errmsg>, <errnum>, <flag>)
		Method(m010, 3)
		{
		m680(arg0, arg1, 0, ObjectType(bf80), 14)
			m680(arg0, arg1, 1, bf80, 0x5650a284)
			Store(0xc179b3fe, bf80)
			m680(arg0, arg1, 2, ObjectType(bf80), 14)
			m680(arg0, arg1, 3, bf80, 0x4179b3fe)
		}

		// Check storing of "FE7CB391D650A284" to bf80,
		// optionally perform an additional update and check
		// m020(<errmsg>, <errnum>, <flag>)
		Method(m020, 3)
		{
			m680(arg0, arg1, 0, ObjectType(bf80), 14)
			m680(arg0, arg1, 1, bf80, 0x43374546)
			Store("C179B3FE", bf80)
			m680(arg0, arg1, 2, ObjectType(bf80), 14)
			m680(arg0, arg1, 3, bf80, 0x39373143)
		}

		// Check storing of Buffer(){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}
		// to bf80, optionally perform an additional update and check
		// m030(<errmsg>, <errnum>, <flag>)
		Method(m030, 3)
		{
			m680(arg0, arg1, 0, ObjectType(bf80), 14)
			m680(arg0, arg1, 1, bf80, 0x5650a284)
	 		Store(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, bf80)
			m680(arg0, arg1, 2, ObjectType(bf80), 14)
			m680(arg0, arg1, 3, bf80, 0x4179b3fe)
		}

		// Fill the bytes range of the Buffer Field in the SourceBuffer
		m683(b675, 35, 63, 0xa5)

		// Choose a way to obtain some result object
		Switch(ToInteger (arg1)) {
			Case(0) {	// Data Image

				// Choose a type of the result Object and specific source
				// objects to obtain the result Object of the specified type.
				// Check that the destination Object is properly initialized.
				// Perform storing expression and check result.
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(0xfe7cb391d650a284, bf80)
						m010(arg0, 176, 0)
					}
					Case(2) {	// String
	 					Store("FE7CB391D650A284", bf80)
						m020(arg0, 182, 0)
					}
					Case(3) {	// Buffer
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf80)
						m030(arg0, 188, 0)
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 631, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 632, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(1) {	// Named Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(i6e4, bf80)
						m010(arg0, 196, 1)
						m680(arg0, 633, 0, i6e4, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(s6e4, bf80)
						m020(arg0, 203, 1)
						m680(arg0, 634, 0, s6e4, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(b6e4, bf80)
						m030(arg0, 210, 1)
						m680(arg0, 635, 0, b6e4, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 636, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 637, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(2) {	// Method ArgX Object
				m000(Concatenate(arg0, "-m000"), arg2,
					0xfe7cb391d650a284, "FE7CB391D650A284", Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
			}
			Case(3) {	// Method LocalX Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(0xfe7cb391d650a284, Local0)
					}
					Case(2) {	// String
	 					Store("FE7CB391D650A284", Local0)
					}
					Case(3) {	// Buffer
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, Local0)
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 638, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 639, 0, 0, arg1, arg2)
						Return (1)
					}
				}
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Local0, bf80)
						m010(arg0, 221, 1)
						m680(arg0, 640, 0, Local0, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Local0, bf80)
						m020(arg0, 228, 1)
						m680(arg0, 641, 0, Local0, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Local0, bf80)
						m030(arg0, 235, 1)
						m680(arg0, 642, 0, Local0, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
				}
			}
			Case(4) {	// Derefof of intermediate Object (Method ArgX Object)
				m001(Concatenate(arg0, "-m001"), arg2, Refof(i6e5), Refof(s6e5), Refof(b6e5))
			}
			Case(5) {	// Derefof of immediate Index(...)
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Derefof(Index(p690, 6)), bf80)
						m010(arg0, 242, 1)
						m680(arg0, 643, 0, Derefof(Index(p690, 6)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Derefof(Index(p690, 7)), bf80)
						m020(arg0, 249, 1)
						m680(arg0, 644, 0, Derefof(Index(p690, 7)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Derefof(Index(p690, 8)), bf80)
						m030(arg0, 256, 1)
						m680(arg0, 645, 0, Derefof(Index(p690, 8)), Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 646, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 647, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(6) {	// Derefof of Indexed Reference returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Derefof(m681(p690, 9)), bf80)
						m010(arg0, 265, 1)
						m680(arg0, 648, 0, Derefof(Index(p690, 9)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Derefof(m681(p690, 10)), bf80)
						m020(arg0, 272, 1)
						m680(arg0, 649, 0, Derefof(Index(p690, 10)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Derefof(m681(p690, 11)), bf80)
						m030(arg0, 284, 1)
						m680(arg0, 650, 0, Derefof(Index(p690, 11)), Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 651, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 652, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(7) {	// Result Object returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(m682(arg2, 6), bf80)
						m010(arg0, 293, 1)
						m680(arg0, 653, 0, i6e6, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(m682(arg2, 6), bf80)
						m020(arg0, 305, 1)
						m680(arg0, 654, 0, s6e6, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(m682(arg2, 6), bf80)
						m030(arg0, 312, 1)
						m680(arg0, 655, 0, b6e6, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 656, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 657, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(8) {	// Result Object returned by any Operator (Op):
						// Add, Mid
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Add(i6e7, 0), bf80)
						m010(arg0, 316, 1)
						m680(arg0, 658, 0, i6e7, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Mid(s6e7, 2, 14), bf80)
						m680(arg0, 659, 0, ObjectType(bf80), 14)
						m680(arg0, 660, 0, bf80, 0x33424337)
	 					Store("C179B3FE", bf80)
						m680(arg0, 661, 0, ObjectType(bf80), 14)
						m680(arg0, 662, 0, bf80, 0x39373143)
						m680(arg0, 663, 0, s6e7, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Mid(b6e7, 1, 7), bf80)
						m680(arg0, 664, 0, ObjectType(bf80), 14)
						m680(arg0, 665, 0, bf80, 0x11D650A2)
	 					Store(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, bf80)
						m680(arg0, 666, 0, ObjectType(bf80), 14)
						m680(arg0, 667, 0, bf80, 0x4179b3fe)
						m680(arg0, 668, 0, b6e7, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 669, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 670, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			// Additionally can be implemented cases:
			// Derefof of immediate Refof
			// Derefof of intermediate Object
			// Derefof of Reference returned by called Method
			Default {
				Store("Unexpected way to obtain some result Object", Debug)
				err(terr, z123, 671, 0, 0, arg1, arg2)
				Return (1)
			}
		}
		Return (0)
	}

	// Store() Result Object to Buffer Field Named Object
	// case of the field, which is 63-bit long (bf81)
	Method(m0e1, 3, Serialized)
	{
		// ArgX as a way to obtain some result object
		Method(m000, 5, Serialized)
		{
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					Store(arg2, bf81)
					m010(arg0, 130, 1)
					m680(arg0, 672, 0, arg2, 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					Store(arg3, bf81)
					m020(arg0, 137, 1)
					m680(arg0, 673, 0, arg3, "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					Store(arg4, bf81)
					m030(arg0, 144, 1)
					m680(arg0, 674, 0, arg4, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 675, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 676, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		// Reference in ArgX as a way to obtain some result object
		Method(m001, 5, Serialized)
		{
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					Store(Derefof(arg2), bf81)
					m010(arg0, 153, 1)
					m680(arg0, 677, 0, Derefof(arg2), 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					Store(Derefof(arg3), bf81)
					m020(arg0, 160, 1)
					m680(arg0, 678, 0, Derefof(arg3), "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					Store(Derefof(arg4), bf81)
					m030(arg0, 167, 1)
					m680(arg0, 679, 0, Derefof(arg4), Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 680, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 681, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		// Check storing of 0xfe7cb391d650a284 to bf81,
		// optionally perform an additional update and check
		// m010(<errmsg>, <errnum>, <flag>)
		Method(m010, 3)
		{
			m680(arg0, arg1, 0, ObjectType(bf81), 14)
			if (F64) {
				m680(arg0, arg1, 1, bf81, 0x7e7cb391d650a284)
			} else {
				m680(arg0, arg1, 2, bf81, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x00, 0x00, 0x00, 0x00})
			}
			if (arg2) {
				Store(0xc179b3fe, bf81)
				m680(arg0, arg1, 3, ObjectType(bf81), 14)
				if (F64) {
					m680(arg0, arg1, 4, bf81, 0xc179b3fe)
				} else {
					m680(arg0, arg1, 5, bf81, Buffer(8){0xFE, 0xB3, 0x79, 0xC1, 0x00, 0x00, 0x00, 0x00})
				}
			}
		}

		// Check storing of "FE7CB391D650A284" to bf81,
		// optionally perform an additional update and check
		// m020(<errmsg>, <errnum>, <flag>)
		Method(m020, 3)
		{
			m680(arg0, arg1, 0, ObjectType(bf81), 14)
			if (F64) {
				m680(arg0, arg1, 1, bf81, 0x3139334243374546)
			} else {
				m680(arg0, arg1, 2, bf81, Buffer(8){0x46, 0x45, 0x37, 0x43, 0x42, 0x33, 0x39, 0x31})
			}
			if (arg2) {
	 			Store("C179B3FE", bf81)
				m680(arg0, arg1, 3, ObjectType(bf81), 14)
				if (F64) {
					m680(arg0, arg1, 4, bf81, 0x4546334239373143)
				} else {
					m680(arg0, arg1, 5, bf81, Buffer(8){0x43, 0x31, 0x37, 0x39, 0x42, 0x33, 0x46, 0x45})
				}
			}
		}

		// Check storing of Buffer(){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}
		// to bf81, optionally perform an additional update and check
		// m030(<errmsg>, <errnum>, <flag>)
		Method(m030, 3)
		{
			m680(arg0, arg1, 0, ObjectType(bf81), 14)
			if (F64) {
				m680(arg0, arg1, 1, bf81, 0x7e7cb391d650a284)
			} else {
				m680(arg0, arg1, 2, bf81, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0x7E})
			}
			if (arg2) {
	 			Store(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, bf81)
				m680(arg0, arg1, 3, ObjectType(bf81), 14)
				if (F64) {
					m680(arg0, arg1, 4, bf81, 0xc179b3fe)
				} else {
					m680(arg0, arg1, 5, bf81, Buffer(8){0xFE, 0xB3, 0x79, 0xC1, 0x00, 0x00, 0x00, 0x00})
				}
			}
		}

		// Fill the bytes range of the Buffer Field in the SourceBuffer
		m683(b675, 35, 63, 0xa5)

		// Choose a way to obtain some result object
		Switch(ToInteger (arg1)) {
			Case(0) {	// Data Image

				// Choose a type of the result Object and specific source
				// objects to obtain the result Object of the specified type.
				// Check that the destination Object is properly initialized.
				// Perform storing expression and check result.
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(0xfe7cb391d650a284, bf81)
						m010(arg0, 176, 0)
					}
					Case(2) {	// String
	 					Store("FE7CB391D650A284", bf81)
						m020(arg0, 182, 0)
					}
					Case(3) {	// Buffer
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf81)
						m030(arg0, 188, 0)
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 682, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 683, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(1) {	// Named Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(i6e4, bf81)
						m010(arg0, 196, 1)
						m680(arg0, 684, 0, i6e4, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(s6e4, bf81)
						m020(arg0, 203, 1)
						m680(arg0, 685, 0, s6e4, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(b6e4, bf81)
						m030(arg0, 210, 1)
						m680(arg0, 686, 0, b6e4, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 687, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 688, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(2) {	// Method ArgX Object
				m000(Concatenate(arg0, "-m000"), arg2,
					0xfe7cb391d650a284, "FE7CB391D650A284", Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
			}
			Case(3) {	// Method LocalX Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(0xfe7cb391d650a284, Local0)
					}
					Case(2) {	// String
	 					Store("FE7CB391D650A284", Local0)
					}
					Case(3) {	// Buffer
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, Local0)
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 689, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 690, 0, 0, arg1, arg2)
						Return (1)
					}
				}
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Local0, bf81)
						m010(arg0, 221, 1)
						m680(arg0, 691, 0, Local0, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Local0, bf81)
						m020(arg0, 228, 1)
						m680(arg0, 692, 0, Local0, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Local0, bf81)
						m030(arg0, 235, 1)
						m680(arg0, 693, 0, Local0, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
				}
			}
			Case(4) {	// Derefof of intermediate Object (Method ArgX Object)
				m001(Concatenate(arg0, "-m001"), arg2, Refof(i6e5), Refof(s6e5), Refof(b6e5))
			}
			Case(5) {	// Derefof of immediate Index(...)
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Derefof(Index(p690, 6)), bf81)
						m010(arg0, 242, 1)
						m680(arg0, 694, 0, Derefof(Index(p690, 6)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Derefof(Index(p690, 7)), bf81)
						m020(arg0, 249, 1)
						m680(arg0, 695, 0, Derefof(Index(p690, 7)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Derefof(Index(p690, 8)), bf81)
						m030(arg0, 256, 1)
						m680(arg0, 696, 0, Derefof(Index(p690, 8)), Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 697, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 698, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(6) {	// Derefof of Indexed Reference returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Derefof(m681(p690, 9)), bf81)
						m010(arg0, 265, 1)
						m680(arg0, 699, 0, Derefof(Index(p690, 9)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Derefof(m681(p690, 10)), bf81)
						m020(arg0, 272, 1)
						m680(arg0, 700, 0, Derefof(Index(p690, 10)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Derefof(m681(p690, 11)), bf81)
						m030(arg0, 284, 1)
						m680(arg0, 701, 0, Derefof(Index(p690, 11)), Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 702, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 703, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(7) {	// Result Object returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(m682(arg2, 6), bf81)
						m010(arg0, 293, 1)
						m680(arg0, 704, 0, i6e6, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(m682(arg2, 6), bf81)
						m020(arg0, 305, 1)
						m680(arg0, 705, 0, s6e6, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(m682(arg2, 6), bf81)
						m030(arg0, 312, 1)
						m680(arg0, 706, 0, b6e6, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 707, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 708, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(8) {	// Result Object returned by any Operator (Op):
						// Add, Mid
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Add(i6e7, 0), bf81)
						m010(arg0, 316, 1)
						m680(arg0, 709, 0, i6e7, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Mid(s6e7, 2, 14), bf81)
						m680(arg0, 710, 0, ObjectType(bf81), 14)
						if (F64) {
							m680(arg0, 711, 0, bf81, 0x3644313933424337)
						} else {
							m680(arg0, 712, 0, bf81, Buffer(8){0x37, 0x43, 0x42, 0x33, 0x39, 0x31, 0x44, 0x36})
						}
	 					Store("C179B3FE", bf81)
						m680(arg0, 713, 0, ObjectType(bf81), 14)
						if (F64) {
							m680(arg0, 714, 0, bf81, 0x4546334239373143)
						} else {
							m680(arg0, 715, 0, bf81, Buffer(8){0x43, 0x31, 0x37, 0x39, 0x42, 0x33, 0x46, 0x45})
						}
						m680(arg0, 716, 0, s6e7, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Mid(b6e7, 1, 7), bf81)
						m680(arg0, 717, 0, ObjectType(bf81), 14)
						if (F64) {
							m680(arg0, 718, 0, bf81, 0xfe7cb391d650a2)
						} else {
							m680(arg0, 719, 0, bf81, Buffer(8){0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
						}
	 					Store(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, bf81)
						m680(arg0, 720, 0, ObjectType(bf81), 14)
						if (F64) {
							m680(arg0, 721, 0, bf81, 0xc179b3fe)
						} else {
							m680(arg0, 722, 0, bf81, Buffer(8){0xFE, 0xB3, 0x79, 0xC1, 0x00, 0x00, 0x00, 0x00})
						}
						m680(arg0, 723, 0, b6e7, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 724, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 725, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			// Additionally can be implemented cases:
			// Derefof of immediate Refof
			// Derefof of intermediate Object
			// Derefof of Reference returned by called Method
			Default {
				Store("Unexpected way to obtain some result Object", Debug)
				err(terr, z123, 726, 0, 0, arg1, arg2)
				Return (1)
			}
		}
		Return (0)
	}

	// Store() Result Object to Buffer Field Named Object
	// case of the field, which is 69-bit long (bf82)
	Method(m0e2, 3, Serialized)
	{
		// ArgX as a way to obtain some result object
		Method(m000, 5, Serialized)
		{
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					Store(arg2, bf82)
					m010(arg0, 130, 1)
					m680(arg0, 727, 0, arg2, 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					Store(arg3, bf82)
					m020(arg0, 137, 1)
					m680(arg0, 728, 0, arg3, "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					Store(arg4, bf82)
					m030(arg0, 144, 1)
					m680(arg0, 729, 0, arg4, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 730, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 731, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		// Reference in ArgX as a way to obtain some result object
		Method(m001, 5, Serialized)
		{
			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					Store(Derefof(arg2), bf82)
					m010(arg0, 153, 1)
					m680(arg0, 732, 0, Derefof(arg2), 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					Store(Derefof(arg3), bf82)
					m020(arg0, 160, 1)
					m680(arg0, 733, 0, Derefof(arg3), "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					Store(Derefof(arg4), bf82)
					m030(arg0, 167, 1)
					m680(arg0, 734, 0, Derefof(arg4), Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 735, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 736, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		// Check storing of 0xfe7cb391d650a284 to bf82,
		// optionally perform an additional update and check
		// m010(<errmsg>, <errnum>, <flag>)
		Method(m010, 3)
		{
			m680(arg0, arg1, 0, ObjectType(bf82), 14)
			if (F64) {
				m680(arg0, arg1, 1, bf82, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xb3, 0x7c, 0xfe, 0x00})
			} else {
				m680(arg0, arg1, 2, bf82, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x00, 0x00, 0x00, 0x00, 0x00})
			}
			if (arg2) {
				Store(0xc179b3fe, bf82)
				m680(arg0, arg1, 3, ObjectType(bf82), 14)
				m680(arg0, arg1, 4, bf82, Buffer(9){0xFE, 0xB3, 0x79, 0xC1, 0x00, 0x00, 0x00, 0x00, 0x00})
			}
		}

		// Check storing of "FE7CB391D650A284" to bf82,
		// optionally perform an additional update and check
		// m020(<errmsg>, <errnum>, <flag>)
		Method(m020, 3)
		{
			m680(arg0, arg1, 0, ObjectType(bf82), 14)
			m680(arg0, arg1, 1, bf82, Buffer(9){0x46, 0x45, 0x37, 0x43, 0x42, 0x33, 0x39, 0x31, 0x04})
			if (arg2) {
	 			Store("C179B3FE", bf82)
				m680(arg0, arg1, 2, ObjectType(bf82), 14)
				m680(arg0, arg1, 3, bf82, Buffer(9){0x43, 0x31, 0x37, 0x39, 0x42, 0x33, 0x46, 0x45, 0x00})
			}
		}

		// Check storing of Buffer(){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}
		// to bf82, optionally perform an additional update and check
		// m030(<errmsg>, <errnum>, <flag>)
		Method(m030, 3)
		{
			m680(arg0, arg1, 0, ObjectType(bf82), 14)
			m680(arg0, arg1, 1, bf82, Buffer(9){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00})
			if (arg2) {
	 			Store(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, bf82)
				m680(arg0, arg1, 2, ObjectType(bf82), 14)
				m680(arg0, arg1, 3, bf82, Buffer(9){0xFE, 0xB3, 0x79, 0xC1, 0x00, 0x00, 0x00, 0x00, 0x00})
			}
		}

		// Fill the bytes range of the Buffer Field in the SourceBuffer
		m683(b675, 110, 69, 0xa5)

		// Choose a way to obtain some result object
		Switch(ToInteger (arg1)) {
			Case(0) {	// Data Image

				// Choose a type of the result Object and specific source
				// objects to obtain the result Object of the specified type.
				// Check that the destination Object is properly initialized.
				// Perform storing expression and check result.
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(0xfe7cb391d650a284, bf82)
						m010(arg0, 176, 0)
					}
					Case(2) {	// String
	 					Store("FE7CB391D650A284", bf82)
						m020(arg0, 182, 0)
					}
					Case(3) {	// Buffer
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, bf82)
						m030(arg0, 188, 0)
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 737, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 738, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(1) {	// Named Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(i6e4, bf82)
						m010(arg0, 196, 1)
						m680(arg0, 739, 0, i6e4, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(s6e4, bf82)
						m020(arg0, 203, 1)
						m680(arg0, 740, 0, s6e4, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(b6e4, bf82)
						m030(arg0, 210, 1)
						m680(arg0, 741, 0, b6e4, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 742, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 743, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(2) {	// Method ArgX Object
				m000(Concatenate(arg0, "-m000"), arg2,
					0xfe7cb391d650a284, "FE7CB391D650A284", Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
			}
			Case(3) {	// Method LocalX Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(0xfe7cb391d650a284, Local0)
					}
					Case(2) {	// String
	 					Store("FE7CB391D650A284", Local0)
					}
					Case(3) {	// Buffer
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, Local0)
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 744, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 745, 0, 0, arg1, arg2)
						Return (1)
					}
				}
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Local0, bf82)
						m010(arg0, 221, 1)
						m680(arg0, 746, 0, Local0, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Local0, bf82)
						m020(arg0, 228, 1)
						m680(arg0, 747, 0, Local0, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Local0, bf82)
						m030(arg0, 235, 1)
						m680(arg0, 748, 0, Local0, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
				}
			}
			Case(4) {	// Derefof of intermediate Object (Method ArgX Object)
				m001(Concatenate(arg0, "-m001"), arg2, Refof(i6e5), Refof(s6e5), Refof(b6e5))
			}
			Case(5) {	// Derefof of immediate Index(...)
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Derefof(Index(p690, 6)), bf82)
						m010(arg0, 242, 1)
						m680(arg0, 749, 0, Derefof(Index(p690, 6)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Derefof(Index(p690, 7)), bf82)
						m020(arg0, 249, 1)
						m680(arg0, 750, 0, Derefof(Index(p690, 7)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Derefof(Index(p690, 8)), bf82)
						m030(arg0, 256, 1)
						m680(arg0, 751, 0, Derefof(Index(p690, 8)), Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 752, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 753, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(6) {	// Derefof of Indexed Reference returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Derefof(m681(p690, 9)), bf82)
						m010(arg0, 265, 1)
						m680(arg0, 754, 0, Derefof(Index(p690, 9)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Derefof(m681(p690, 10)), bf82)
						m020(arg0, 272, 1)
						m680(arg0, 755, 0, Derefof(Index(p690, 10)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Derefof(m681(p690, 11)), bf82)
						m030(arg0, 284, 1)
						m680(arg0, 756, 0, Derefof(Index(p690, 11)), Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 757, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 758, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(7) {	// Result Object returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(m682(arg2, 6), bf82)
						m010(arg0, 293, 1)
						m680(arg0, 759, 0, i6e6, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(m682(arg2, 6), bf82)
						m020(arg0, 305, 1)
						m680(arg0, 760, 0, s6e6, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(m682(arg2, 6), bf82)
						m030(arg0, 312, 1)
						m680(arg0, 761, 0, b6e6, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 762, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 763, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(8) {	// Result Object returned by any Operator (Op):
						// Add, Mid
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						Store(Add(i6e7, 0), bf82)
						m010(arg0, 316, 1)
						m680(arg0, 764, 0, i6e7, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
	 					Store(Mid(s6e7, 2, 14), bf82)
						m680(arg0, 765, 0, ObjectType(bf82), 14)
						m680(arg0, 766, 0, bf82, Buffer(9){0x37, 0x43, 0x42, 0x33, 0x39, 0x31, 0x44, 0x36, 0x15})
	 					Store("C179B3FE", bf82)
						m680(arg0, 767, 0, ObjectType(bf82), 14)
						m680(arg0, 768, 0, bf82, Buffer(9){0x43, 0x31, 0x37, 0x39, 0x42, 0x33, 0x46, 0x45, 0x00})
						m680(arg0, 769, 0, s6e7, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
	 					Store(Mid(b6e7, 1, 7), bf82)
						m680(arg0, 770, 0, ObjectType(bf82), 14)
						m680(arg0, 771, 0, bf82, Buffer(9){0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE, 0x00, 0x00})
	 					Store(Buffer() {0xFE, 0xB3, 0x79, 0xC1}, bf82)
						m680(arg0, 772, 0, ObjectType(bf82), 14)
						m680(arg0, 773, 0, bf82, Buffer(9){0xFE, 0xB3, 0x79, 0xC1, 0x00, 0x00, 0x00, 0x00, 0x00})
						m680(arg0, 774, 0, b6e7, Buffer(8){0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 775, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 776, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			// Additionally can be implemented cases:
			// Derefof of immediate Refof
			// Derefof of intermediate Object
			// Derefof of Reference returned by called Method
			Default {
				Store("Unexpected way to obtain some result Object", Debug)
				err(terr, z123, 777, 0, 0, arg1, arg2)
				Return (1)
			}
		}
		Return (0)
	}

	// Store() Result Object to String Method LocalX Object
	Method(m023, 3, Serialized)
	{
		// ArgX as a way to obtain some result object
		Method(m000, 5, Serialized)
		{
			Store("initial named string", Local1)

			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					m680(arg0, 778, 0, Local1, "initial named string")
					Store(arg2, Local1)
					if (F64) {
						m680(arg0, 779, 0, Local1, 0xfe7cb391d650a284)
					} else {
						m680(arg0, 780, 0, Local1, 0xd650a284)
					}
					Store(0xc179b3fe, Local1)
					m680(arg0, 781, 0, Local1, 0xc179b3fe)
					m680(arg0, 782, 0, arg2, 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					m680(arg0, 783, 0, Local1, "initial named string")
					Store(arg3, Local1)
					m680(arg0, 784, 0, Local1, "FE7CB391D650A284")
					Store(0xb, Index(Local1, 3))
					m680(arg0, 785, 0, Local1, "FE7\x0BB391D650A284")
					m680(arg0, 786, 0, arg3, "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					m680(arg0, 787, 0, Local1, "initial named string")
					Store(arg4, Local1)
					m680(arg0, 788, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					Store(0xb, Index(Local1, 3))
					m680(arg0, 789, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE})
					m680(arg0, 790, 0, arg4, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 791, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 792, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		// Reference in ArgX as a way to obtain some result object
		Method(m001, 5, Serialized)
		{
			Store("initial named string", Local1)

			Switch(ToInteger (arg1)) {
				Case(1) {	// Integer
					m680(arg0, 793, 0, Local1, "initial named string")
					Store(Derefof(arg2), Local1)
					if (F64) {
						m680(arg0, 794, 0, Local1, 0xfe7cb391d650a284)
					} else {
						m680(arg0, 795, 0, Local1, 0xd650a284)
					}
					Store(0xc179b3fe, Local1)
					m680(arg0, 796, 0, Local1, 0xc179b3fe)
					m680(arg0, 797, 0, Derefof(arg2), 0xfe7cb391d650a284)
				}
				Case(2) {	// String
					m680(arg0, 798, 0, Local1, "initial named string")
					Store(Derefof(arg3), Local1)
					m680(arg0, 799, 0, Local1, "FE7CB391D650A284")
					Store(0xb, Index(Local1, 3))
					m680(arg0, 800, 0, Local1, "FE7\x0BB391D650A284")
					m680(arg0, 801, 0, Derefof(arg3), "FE7CB391D650A284")
				}
				Case(3) {	// Buffer
					m680(arg0, 802, 0, Local1, "initial named string")
					Store(Derefof(arg4), Local1)
					m680(arg0, 803, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					Store(0xb, Index(Local1, 3))
					m680(arg0, 804, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE})
					m680(arg0, 805, 0, Derefof(arg4), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
				}
				Case(5) {	// Field Unit
					Store("Not implemented", Debug)
					err(terr, z123, 806, 0, 0, arg1, arg2)
					Return (1)
				}
				Case(14) {	// Buffer Field
					Store("Not implemented", Debug)
					err(terr, z123, 807, 0, 0, arg1, arg2)
					Return (1)
				}
			}
			Return (0)
		}

		Store("initial named string", Local1)

		// Choose a way to obtain some result object
		Switch(ToInteger (arg1)) {
			Case(0) {	// Data Image

				// Choose a type of the result Object and specific source
				// objects to obtain the result Object of the specified type.
				// Check that the destination Object is properly initialized.
				// Perform storing expression and check result.
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 808, 0, Local1, "initial named string")
						Store(0xfe7cb391d650a284, Local1)
						if (F64) {
							m680(arg0, 809, 0, Local1, 0xfe7cb391d650a284)
						} else {
							m680(arg0, 810, 0, Local1, 0xd650a284)
						}
					}
					Case(2) {	// String
						m680(arg0, 811, 0, Local1, "initial named string")
	 					Store("FE7CB391D650A284", Local1)
						m680(arg0, 812, 0, Local1, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 813, 0, Local1, "initial named string")
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, Local1)
						m680(arg0, 814, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 815, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 816, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(1) {	// Named Object
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 817, 0, Local1, "initial named string")
						Store(i6e4, Local1)
						if (F64) {
							m680(arg0, 818, 0, Local1, 0xfe7cb391d650a284)
						} else {
							m680(arg0, 819, 0, Local1, 0xd650a284)
						}
						Store(0xc179b3fe, Local1)
						m680(arg0, 820, 0, Local1, 0xc179b3fe)
						m680(arg0, 821, 0, i6e4, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 822, 0, Local1, "initial named string")
	 					Store(s6e4, Local1)
						m680(arg0, 823, 0, Local1, "FE7CB391D650A284")
						Store(0xb, Index(Local1, 3))
						m680(arg0, 824, 0, Local1, "FE7\x0BB391D650A284")
						m680(arg0, 825, 0, s6e4, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 826, 0, Local1, "initial named string")
	 					Store(b6e4, Local1)
						m680(arg0, 827, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
						Store(0xb, Index(Local1, 3))
						m680(arg0, 828, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE})
						m680(arg0, 829, 0, b6e4, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Default {
						Store("Unexpected type of the result Object to be stored", Debug)
						err(terr, z123, 830, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(2) {	// Method ArgX Object
				m000(Concatenate(arg0, "-m000"), arg2,
					0xfe7cb391d650a284, "FE7CB391D650A284", Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
			}
			Case(3) {	// Method LocalX Object
				Switch(ToInteger (arg2)) {
					Case(0) {	// Stuff
						Return (0)
					}
					Case(1) {	// Integer
						Store(0xfe7cb391d650a284, Local0)
					}
					Case(2) {	// String
	 					Store("FE7CB391D650A284", Local0)
					}
					Case(3) {	// Buffer
	 					Store(Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE}, Local0)
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 831, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 832, 0, 0, arg1, arg2)
						Return (1)
					}
				}
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 833, 0, Local1, "initial named string")
						Store(Local0, Local1)
						if (F64) {
							m680(arg0, 834, 0, Local1, 0xfe7cb391d650a284)
						} else {
							m680(arg0, 835, 0, Local1, 0xd650a284)
						}
						Store(0xc179b3fe, Local1)
						m680(arg0, 836, 0, Local1, 0xc179b3fe)
						m680(arg0, 837, 0, Local0, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 838, 0, Local1, "initial named string")
	 					Store(Local0, Local1)
						m680(arg0, 839, 0, Local1, "FE7CB391D650A284")
						Store(0xb, Index(Local1, 3))
						m680(arg0, 840, 0, Local1, "FE7\x0BB391D650A284")
						m680(arg0, 841, 0, Local0, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 842, 0, Local1, "initial named string")
	 					Store(Local0, Local1)
						m680(arg0, 843, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
						Store(0xb, Index(Local1, 3))
						m680(arg0, 844, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE})
						m680(arg0, 845, 0, Local0, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
				}
			}
			Case(4) {	// Derefof of intermediate Object (Method ArgX Object)
				m001(Concatenate(arg0, "-m001"), arg2, Refof(i6e5), Refof(s6e5), Refof(b6e5))
			}
			Case(5) {	// Derefof of immediate Index(...)
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 846, 0, Local1, "initial named string")
						Store(Derefof(Index(p690, 6)), Local1)
						if (F64) {
							m680(arg0, 847, 0, Local1, 0xfe7cb391d650a284)
						} else {
							m680(arg0, 848, 0, Local1, 0xd650a284)
						}
						Store(0xc179b3fe, Local1)
						m680(arg0, 849, 0, Local1, 0xc179b3fe)
						m680(arg0, 850, 0, Derefof(Index(p690, 6)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 851, 0, Local1, "initial named string")
	 					Store(Derefof(Index(p690, 7)), Local1)
						m680(arg0, 852, 0, Local1, "FE7CB391D650A284")
						Store(0xb, Index(Local1, 3))
						m680(arg0, 853, 0, Local1, "FE7\x0BB391D650A284")
						m680(arg0, 854, 0, Derefof(Index(p690, 7)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 855, 0, Local1, "initial named string")
	 					Store(Derefof(Index(p690, 8)), Local1)
						m680(arg0, 856, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
						Store(0xb, Index(Local1, 3))
						m680(arg0, 857, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE})
						m680(arg0, 858, 0, Derefof(Index(p690, 8)), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 859, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 860, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(6) {	// Derefof of Indexed Reference returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 861, 0, Local1, "initial named string")
						Store(Derefof(m681(p690, 9)), Local1)
						if (F64) {
							m680(arg0, 862, 0, Local1, 0xfe7cb391d650a284)
						} else {
							m680(arg0, 863, 0, Local1, 0xd650a284)
						}
						Store(0xc179b3fe, Local1)
						m680(arg0, 864, 0, Local1, 0xc179b3fe)
						m680(arg0, 865, 0, Derefof(Index(p690, 9)), 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 866, 0, Local1, "initial named string")
	 					Store(Derefof(m681(p690, 10)), Local1)
						m680(arg0, 867, 0, Local1, "FE7CB391D650A284")
						Store(0xb, Index(Local1, 3))
						m680(arg0, 868, 0, Local1, "FE7\x0BB391D650A284")
						m680(arg0, 869, 0, Derefof(Index(p690, 10)), "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 870, 0, Local1, "initial named string")
	 					Store(Derefof(m681(p690, 11)), Local1)
						m680(arg0, 871, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
						Store(0xb, Index(Local1, 3))
						m680(arg0, 872, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE})
						m680(arg0, 873, 0, Derefof(Index(p690, 11)), Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
				}
			}
			Case(7) {	// Result Object returned by called Method
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 874, 0, Local1, "initial named string")
						Store(m682(arg2, 6), Local1)
						if (F64) {
							m680(arg0, 875, 0, Local1, 0xfe7cb391d650a284)
						} else {
							m680(arg0, 876, 0, Local1, 0xd650a284)
						}
						Store(0xc179b3fe, Local1)
						m680(arg0, 877, 0, Local1, 0xc179b3fe)
						m680(arg0, 878, 0, i6e6, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 879, 0, Local1, "initial named string")
	 					Store(m682(arg2, 6), Local1)
						m680(arg0, 880, 0, Local1, "FE7CB391D650A284")
						Store(0xb, Index(Local1, 3))
						m680(arg0, 881, 0, Local1, "FE7\x0BB391D650A284")
						m680(arg0, 882, 0, s6e6, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 883, 0, Local1, "initial named string")
	 					Store(m682(arg2, 6), Local1)
						m680(arg0, 884, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
						Store(0xb, Index(Local1, 3))
						m680(arg0, 885, 0, Local1, Buffer() {0x84, 0xA2, 0x50, 0x0B, 0x91, 0xB3, 0x7C, 0xFE})
						m680(arg0, 886, 0, b6e6, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 887, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 888, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			Case(8) {	// Result Object returned by any Operator (Op):
						// Add, Mid
				Switch(ToInteger (arg2)) {
					Case(1) {	// Integer
						m680(arg0, 889, 0, Local1, "initial named string")
						Store(Add(i6e7, 0), Local1)
						if (F64) {
							m680(arg0, 890, 0, Local1, 0xfe7cb391d650a284)
						} else {
							m680(arg0, 891, 0, Local1, 0xd650a284)
						}
						Store(0xc179b3fe, Local1)
						m680(arg0, 892, 0, Local1, 0xc179b3fe)
						m680(arg0, 893, 0, i6e7, 0xfe7cb391d650a284)
					}
					Case(2) {	// String
						m680(arg0, 894, 0, Local1, "initial named string")
	 					Store(Mid(s6e7, 2, 14), Local1)
						m680(arg0, 895, 0, Local1, "7CB391D650A284")
						Store(0xb, Index(Local1, 3))
						m680(arg0, 896, 0, Local1, "7CB\x0B91D650A284")
						m680(arg0, 897, 0, s6e7, "FE7CB391D650A284")
					}
					Case(3) {	// Buffer
						m680(arg0, 898, 0, Local1, "initial named string")
	 					Store(Mid(b6e7, 1, 7), Local1)
						m680(arg0, 899, 0, Local1, Buffer() {0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
						Store(0xb, Index(Local1, 3))
						m680(arg0, 900, 0, Local1, Buffer() {0xA2, 0x50, 0xD6, 0x0B, 0xB3, 0x7C, 0xFE})
						m680(arg0, 901, 0, b6e7, Buffer() {0x84, 0xA2, 0x50, 0xD6, 0x91, 0xB3, 0x7C, 0xFE})
					}
					Case(5) {	// Field Unit
						Store("Not implemented", Debug)
						err(terr, z123, 902, 0, 0, arg1, arg2)
						Return (1)
					}
					Case(14) {	// Buffer Field
						Store("Not implemented", Debug)
						err(terr, z123, 903, 0, 0, arg1, arg2)
						Return (1)
					}
				}
			}
			// Additionally can be implemented cases:
			// Derefof of immediate Refof
			// Derefof of intermediate Object
			// Derefof of Reference returned by called Method
			Default {
				Store("Unexpected way to obtain some result Object", Debug)
				err(terr, z123, 904, 0, 0, arg1, arg2)
				Return (1)
			}
		}
		Return (0)
	}

	m100(Concatenate(ts, "-m100-S-IntC"),
		1, 0)

	m100(Concatenate(ts, "-m100-S-IntN"),
		1, 1)

	m100(Concatenate(ts, "-m100-S-IntL"),
		1, 3)

	m100(Concatenate(ts, "-m100-S-StrN"),
		2, 1)

	m100(Concatenate(ts, "-m100-S-StrL"),
		2, 3)

	m100(Concatenate(ts, "-m100-S-BufN"),
		3, 1)

	m100(Concatenate(ts, "-m100-S-BFldN"),
		14, 1)
}

// Run-method
Method(RES0)
{
	Store("TEST: RES0, Result Object processing in Store operator", Debug)

	// Check storing of immediate Source Objects by Store()
	m689("RES0-m689", 0, 0)

	// Store() to Global Named Objects, Constant and LocalX
	m690()
}

