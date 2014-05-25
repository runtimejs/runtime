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
 * The common methods of the Reference tests
 *
 *
 * Methods used for to verify particular References:
 *
 *    m1a0, m1a1, m1a2
 */

/*
SEE: Investigate and report all y<XXX>.
SEE: see everywhere "index of checking" and z0XX - through all ref files: corresponds?!!!!!!!!!
SEE: add into m1a6 and all m000 the checking like these:
     Store(\i900, Debug)
     Store(\d900.i900, Debug)
*/

Name(z076, 76)

// Check Boolen (CondRefOf) and the type of value
// arg0 - reference to the value of arbitrary type
// arg1 - expected type of value
// arg2 - returned Boolen
// arg3 - index of checking (inside the file)
Method(m1a0, 4)
{
	Store(m1a4(arg2, arg3), Local7)

	SET0(c081, 0, arg3)

	if (Local7) {

	Store(ObjectType(arg0), Local0)
	if (LNotEqual(Local0, arg1)) {
		err(c080, z076, 0, 0, 0, Local0, arg1)
	} else {
		if (c089) {

			// Flag of Reference, object otherwise
			if (c082) {
				// Test of exceptions
				m1a8(arg0, 0, 0)
			}
			if (c085) {
				// Create the chain of references to LocalX,
				// then dereference them.

				Store(RefOf(arg0), Local0)
				Store(RefOf(Local0), Local1)
				Store(RefOf(Local1), Local2)
				Store(RefOf(Local2), Local3)
				Store(RefOf(Local3), Local4)
				Store(RefOf(Local4), Local5)
				Store(RefOf(Local5), Local6)
				Store(RefOf(Local6), Local7)

				Store(DerefOf(Local7), Local6)
				Store(DerefOf(Local6), Local5)
				Store(DerefOf(Local5), Local4)
				Store(DerefOf(Local4), Local3)
				Store(DerefOf(Local3), Local2)
				Store(DerefOf(Local2), Local1)
				Store(DerefOf(Local1), Local0)
				Store(DerefOf(Local0), Local7)

				// Create the chain of references to LocalX,
				// then dereference them.

				Store(m1a5(Local7), Local0)
			}
		} /* if(c089) */

		// ATTENTION: exactly the same in m1a0 and m1a2
		// (but, dont replace it by call to Method)

		Method(m002, 1)
		{
			Store(0xabcd001a, arg0)
		}

		// Run verification of references (write/read)

		if (LEqual(c083, 1)) {
			Store(0xabcd001a, c08a)
			Store(c08a, Arg0)
		} elseif (LEqual(c083, 2)) {
			Store(0xabcd001b, c08a)
			CopyObject(c08a, Arg0)
		} elseif (LEqual(c083, 3)) {
			Store(0xabcd001c, c08a)
			Store(c08a, Arg0)
			Store(0xabcd001d, c08a)
			CopyObject(c08a, Arg0)
		}

		// Do RefOf(ArgX) checkings

		Store(0, Local7)

		if (LEqual(c08b, 1)) {
			Store(RefOf(arg0), Local0)
			Store(ObjectType(Local0), Local1)
			if (LNotEqual(Local1, arg1)) {
				err(c080, z076, 1, 0, 0, Local1, arg1)
			} else {
				Store(1, Local7)
			}
		} elseif (LEqual(c08b, 2)) {
			Store(CondRefOf(arg0, Local0), Local1)
			if (LNotEqual(Local1, Ones)) {
				err(c080, z076, 2, 0, 0, Local1, arg1)
			} else {
				Store(ObjectType(Local0), Local1)
				if (LNotEqual(Local1, arg1)) {
					err(c080, z076, 3, 0, 0, Local1, arg1)
				} else {
					Store(1, Local7)
				}
			}
		}

		if (Local7) {

			// Obtain RefOf_Reference to ArgX

			Store(RefOf(arg0), Local0)

			Store(ObjectType(Local0), Local1)
			if (LNotEqual(Local1, arg1)) {
				err(c080, z076, 4, 0, 0, Local1, arg1)
			} else {

				// Check DerefOf

				Store(ObjectType(DerefOf(Local0)), Local1)
				if (LNotEqual(Local1, arg1)) {
					err(c080, z076, 5, 0, 0, Local1, arg1)
				}

				// Check that writing into M2-ArgX-RefOf_Reference
				// changes the original object (M1-ArgX):

				m002(Local0)
				Store(ObjectType(arg0), Local1)
				if (LNotEqual(Local1, c009)) {
					err(c080, z076, 6, 0, 0, Local1, c009)
				} elseif (LNotEqual(arg0, 0xabcd001a)) {
					err(c080, z076, 7, 0, 0, arg0, 0xabcd001a)
				} else {

					// Check that M1-LocalX-RefOf_Reference remains
					// up to date after writing into M2-ArgX in M2 and
					// thus updating the contents of the object
					// referenced by M1-LocalX.

					Store(ObjectType(Local0), Local1)
					if (LNotEqual(Local1, c009)) {
						err(c080, z076, 8, 0, 0, Local1, c009)
					} else {
						Store(SizeOf(Local0), Local1)
						if (LNotEqual(Local1, ISZ0)) {
							err(c080, z076, 9, 0, 0, Local1, ISZ0)
						}
					}
				}
			}
		} /* if (c08b) */

		/* ATTENTION: exactly the same in m1a0 and m1a2 */
	}
	} /* if(Local7) */

	RST0()
}

// Verifying reference to the Object nested inside Packages
// arg0 - reference to the Object (may be to Package)
// arg1 - type of the value referred by arg0
// arg2 - nesting level of the Packages
//        (Package always is a 0-th element
//         of previous Package)
// arg3 - index of the Object inside the last Package
// arg4 - type of the Object
// arg5 - the benchmark value of Object for verification
// arg6 - index of checking (inside the file)
Method(m1a2, 7, Serialized)
{
	SET0(c081, 0, arg6)

	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(ObjectType(arg0), Local0)
	if (LNotEqual(Local0, arg1)) {
		err(c080, z076, 10, 0, 0, Local0, arg1)
	} else {

		if (c089) {
			// Flag of Reference, object otherwise
			if (c082) {
				// Test of exceptions
				m1a8(arg0, 0, 0)
			}
			if (c085) {
				// Create the chain of references to LocalX,
				// then dereference them.

				Store(RefOf(arg0), Local0)
				Store(RefOf(Local0), Local1)
				Store(RefOf(Local1), Local2)
				Store(RefOf(Local2), Local3)
				Store(RefOf(Local3), Local4)
				Store(RefOf(Local4), Local5)
				Store(RefOf(Local5), Local6)
				Store(RefOf(Local6), Local7)

				Store(DerefOf(Local7), Local6)
				Store(DerefOf(Local6), Local5)
				Store(DerefOf(Local5), Local4)
				Store(DerefOf(Local4), Local3)
				Store(DerefOf(Local3), Local2)
				Store(DerefOf(Local2), Local1)
				Store(DerefOf(Local1), Local0)
				Store(DerefOf(Local0), Local7)

				// Create the chain of references to LocalX,
				// then dereference them.

				Store(m1a5(Local7), Local0)

			} else {
				Store(arg0, Local0)
			}
		} else {
			Store(arg0, Local0)
		} /* if(c089) */

		if (c084) {

			// run verification of references (reading)

			if (c089) {
				// Flag of Reference, object otherwise

				/*
				 * 17.2.5.9.1   ArgX Objects
				 *
				 * 1) Read from ArgX parameters
				 *    ObjectReference - Automatic dereference, return
				 *                      the target of the reference.
				 *                      Use of DeRefOf returns the same.
				 */
				if (c087) {
					// "Use of DeRefOf returns the same"
					Store(DerefOf(Local0), Local2)
				} else {
					// Automatic dereference
					Store(Local0, Local2)
				}
			} else {
				Store(Local0, Local2)
			} /* if(c089) */

			Store(arg2, lpN0)

			While (lpN0) {

				if (LEqual(lpN0, 1)) {
					Store(Index(Local2, arg3), Local1)
				} else {
					Store(Index(Local2, 0), Local1)
				}
				Store(DerefOf(Local1), Local2)

				Decrement(lpN0)
				Increment(lpC0)
			}

			Store(ObjectType(Local2), Local0)

			if (LNotEqual(Local0, arg4)) {
				err(c080, z076, 11, 0, 0, Local0, arg4)
			} else {
				if (LNotEqual(Local2, arg5)) {
					err(c080, z076, 12, 0, 0, Local2, arg5)
				}
			}
		} /* if(c084) */

		// ATTENTION: exactly the same in m1a0 and m1a2
		// (but, dont replace it by call to Method)

		Method(m002, 1)
		{
			Store(0xabcd001a, arg0)
		}

		// Run verification of references (write/read)

		if (LEqual(c083, 1)) {
			Store(0xabcd001a, c08a)
			Store(c08a, Arg0)
		} elseif (LEqual(c083, 2)) {
			Store(0xabcd001b, c08a)
			CopyObject(c08a, Arg0)
		} elseif (LEqual(c083, 3)) {
			Store(0xabcd001c, c08a)
			Store(c08a, Arg0)
			Store(0xabcd001d, c08a)
			CopyObject(c08a, Arg0)
		}

		// Do RefOf(ArgX) checkings

		Store(0, Local7)

		if (LEqual(c08b, 1)) {
			Store(RefOf(arg0), Local0)
			Store(ObjectType(Local0), Local1)
			if (LNotEqual(Local1, arg1)) {
				err(c080, z076, 13, 0, 0, Local1, arg1)
			} else {
				Store(1, Local7)
			}
		} elseif (LEqual(c08b, 2)) {
			Store(CondRefOf(arg0, Local0), Local1)
			if (LNotEqual(Local1, Ones)) {
				err(c080, z076, 14, 0, 0, Local1, arg1)
			} else {
				Store(ObjectType(Local0), Local1)
				if (LNotEqual(Local1, arg1)) {
					err(c080, z076, 15, 0, 0, Local1, arg1)
				} else {
					Store(1, Local7)
				}
			}
		}

		if (Local7) {

			// Obtain RefOf_Reference to ArgX

			Store(RefOf(arg0), Local0)

			Store(ObjectType(Local0), Local1)
			if (LNotEqual(Local1, arg1)) {
				err(c080, z076, 16, 0, 0, Local1, arg1)
			} else {

				// Check DerefOf

				Store(ObjectType(DerefOf(Local0)), Local1)
				if (LNotEqual(Local1, arg1)) {
					err(c080, z076, 17, 0, 0, Local1, arg1)
				}

				// Check that writing into M2-ArgX-RefOf_Reference
				// changes the original object (M1-ArgX):

				m002(Local0)
				Store(ObjectType(arg0), Local1)
				if (LNotEqual(Local1, c009)) {
					err(c080, z076, 18, 0, 0, Local1, c009)
				} elseif (LNotEqual(arg0, 0xabcd001a)) {
					err(c080, z076, 19, 0, 0, arg0, 0xabcd001a)
				} else {

					// Check that M1-LocalX-RefOf_Reference remains
					// up to date after writing into M2-ArgX in M2 and
					// thus updating the contents of the object
					// referenced by M1-LocalX.

					Store(ObjectType(Local0), Local1)
					if (LNotEqual(Local1, c009)) {
						err(c080, z076, 20, 0, 0, Local1, c009)
					} else {
						Store(SizeOf(Local0), Local1)
						if (LNotEqual(Local1, ISZ0)) {
							err(c080, z076, 21, 0, 0, Local1, ISZ0)
						}
					}
				}
			}
		} /* if (c08b) */

		/* ATTENTION: exactly the same in m1a0 and m1a2 */

	}

	RST0()
}

// Check only Boolen (CondRefOf)
// arg0 - returned Boolen
// arg1 - index of checking (inside the file)
Method(m1a4, 2)
{
	SET0(c081, 0, arg1)

	Store(1, Local7)

	Store(ObjectType(arg0), Local0)

	if (LNotEqual(Local0, c009)) {
		err(c080, z076, 22, 0, 0, Local0, c009)
		Store(0, Local7)
	} elseif (LNotEqual(arg0, Ones)) {
		err(c080, z076, 23, 0, 0, arg0, Ones)
		Store(0, Local7)
	}

	RST0()

	return (Local7)
}

// Create the chain of references to LocalX, then dereference them
Method(m1a5, 1)
{
	Store(RefOf(arg0), Local0)
	Store(RefOf(Local0), Local1)
	Store(RefOf(Local1), Local2)
	Store(RefOf(Local2), Local3)
	Store(RefOf(Local3), Local4)
	Store(RefOf(Local4), Local5)
	Store(RefOf(Local5), Local6)
	Store(RefOf(Local6), Local7)

	Store(DerefOf(Local7), Local6)
	Store(DerefOf(Local6), Local5)
	Store(DerefOf(Local5), Local4)
	Store(DerefOf(Local4), Local3)
	Store(DerefOf(Local3), Local2)
	Store(DerefOf(Local2), Local1)
	Store(DerefOf(Local1), Local0)
	Store(DerefOf(Local0), Local7)

	return (Local7)
}

/*
 * Set Global variables assignment applied in the tests
 *
 * arg0 - c080 - name of test
 * arg1 - c083 - run verification of references (write/read)
 * arg2 - c084 - run verification of references (reading)
 * arg3 - c085 - create the chain of references to LocalX, then dereference them
 * arg4 - c087 - apply DeRefOf to ArgX-ObjectReference
 * arg5 - c081 - absolute index of file initiating the checking
 */
Method(m1ad, 6)
{
	Store(ObjectType(arg0), Local0)
	if (LEqual(Local0, c00a)) {
		Store(arg0, c080)
	}
	Store(arg1, c083)
	Store(arg2, c084)
	Store(arg3, c085)
	Store(arg4, c087)
	if (arg5) {
		Store(arg5, c081)
	}
}

// Test skipped message
Method(m1ae, 3)
{
	Concatenate("Test ", arg0, Local0)
	Concatenate(Local0, " skipped due to the following issue:", Debug)

	Concatenate("   ", arg1, Debug)

	Store(ObjectType(arg2), Local0)
	if (LEqual(Local0, c00a)) {
		Concatenate("   ", arg2, Debug)
	}
}


