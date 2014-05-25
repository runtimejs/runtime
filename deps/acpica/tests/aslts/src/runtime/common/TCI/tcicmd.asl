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
 * The Test Command Interface with the ACPICA (_TCI)
 *
 * Note: _TCI and TCI mean the same in comments below.
 *       But, actually the name of the relevant predefined
 *       Method is _TCI.
 */

Name(z128, 128)

Name(DE00, 0) // Disable reporting errors from m3a4, needed in m3aa (not enough params)
Name(FOPT, 0) // Flag of optimization


/*
 * Constants
 */

// Opcodes of the Test Commands provided by _TCI

Name(c200, 0xcd0000)	// _TCI-end statistics
Name(c201, 0xcd0001)	// _TCI-begin statistics
Name(c202, 0xcd0002)	// TCI_CMD_CHECK_SUPPORTED
Name(c203, 0xcd0003)	// TCI_CMD_GET_ID_OF_THREADS

// Tags of commands (to be filled into TCI Package by aslts)

Name(c208, 0xeeee0596)	// TCI_TAG_GET_MC_STAT_AFTER_TCI_TERM
Name(c209, 0xbbbb063a)	// TCI_TAG_GET_MC_STAT_BEFORE_TCI_RUN
Name(c20a, 0xcccc07b9)	// TCI_TAG_CHECK_SUPPORTED
Name(c20b, 0xdddd01f5)	// TCI_TAG_GET_ID_OF_THREADS

/*
 * The layout of the Package for Memory Consumption Statistics
 * applied for TCI commands:
 *   _TCI-end statistics (command TCI_CMD_GET_MC_STAT_AFTER_TCI_TERM)
 *   _TCI-begin statistics (command TCI_CMD_GET_MC_STAT_BEFORE_TCI_RUN)
 */
Name(c210,   0) // Tittle
Name(c211,   4) // acq0
Name(c212,   9) // acq1 (-)
Name(c213,  14) // acq2 (-)
Name(c214,  19) // acq3
Name(c215,  24) // acq4 (-)
Name(c216,  29) // acq5
Name(c217,  34) // rel0
Name(c218,  39) // rel1
Name(c219,  44) // rel2 (-)
Name(c21a,  49) // rel3
Name(c21b,  54) // Created Objects
Name(c21c,  84) // Deleted Objects
Name(c21d, 114) // Miscellaneous Stat

Name(c220, 121)	// the length of the Package for
			// Memory Consumption Statistics.

// The layout of header of the common _TCI Package

// Input, data of header passed to ACPICA
Name(c222, 0)	// Tag of command (to be set up by aslts)

// Output, data of header returned to aslts from ACPICA
Name(c223, 1)	// Size (number of elements actually packed into TCI package,
                  // to be filled by ACPICA)
Name(c224, 2)	// Cmd (command has been executed, to be filled by ACPICA)
Name(c225, 3)	// CACHE_ENABLED (object cache is enabled info flag,
                  // to be filled by ACPICA)
Name(c22b, 4)	// length of the common _TCI Package header


// The layout of header of TCI_CMD_GET_ID_OF_THREADS command
// (returned to aslts from ACPICA)
Name(c22c, 4)	// TCI_PACKAGE_THR_NUM
Name(c22d, 5)	// TCI_PACKAGE_THR_NUM_REAL
Name(c22e, 6)	// TCI_PACKAGE_THR_ID
Name(c22f, 7)	// length TCI_PACKAGE_THR_HEADER_SIZE


Name(c221, 5)	// CACHE_LISTS_NUMBER (Object Caches):
			//   CLIST_ID_NAMESPACE     0 /* Acpi-Namespace */
			//   CLIST_ID_STATE         1 /* Acpi-State */
			//   CLIST_ID_OPERAND       2 /* Acpi-Operand */
			//   CLIST_ID_PSNODE        3 /* Acpi-Parse */
			//   CLIST_ID_PSNODE_EXT    4 /* Acpi-ParseExt */

Name(c226, 0)	// CLIST_ID_NAMESPACE
Name(c227, 1)	// CLIST_ID_STATE
Name(c228, 2)	// CLIST_ID_OPERAND
Name(c229, 3)	// CLIST_ID_PSNODE
Name(c22a, 4)	// CLIST_ID_PSNODE_EXT


/*
 * The main Test Command interface with the ACPICA
 *
 * arg0 - opcode of the Test Command
 * arg1 - Package for different needs depending on the command.
 *        So, in case of the Memory Consumption Statistics commands it
 *        is filled by ACPICA with the Memory Consumption Statistics.
 *        The length of package in this case should be not less than c220,
 *        otherwise, no any failure arises but not all data are returned
 *        by Package just only the relevant part of it. It is true for all
 *        commands.
 * Note: use m3a0 or m165 to prepare the arg1-package.
 */
Method(_TCI, 2)
{
	/*
	 * Before to run this method reset location
	 * of Command which is to be filled by ACPICA
	 * to acknowledge the interconnection.
	 * It is performed in m3a0 and m3a4.
	 */
	return (arg1)
}

/*
 * Create and initialize the Package for _TCI
 *
 * arg0 - opcode of the Test Command.
 *        Use 0 for allocation without initialization.
 * arg1 - number of element of Package (for some of commands)
 *
 * Return the resulting Package:
 *
 *   - if arg0 is zero - the Package of c220 length
 *   - otherwise - the Package of length depending on
 *     the command is additionally initialized
 */
Method(m165, 2, Serialized)
{
	Name(num, 0)
	Name(tag, 0)

	if (arg0) {

		Switch (ToInteger (arg0)) {
			Case (0xcd0000) {
				// _TCI-end statistics
				Store(c208, tag)
				Store(c220, num)
			}
			Case (0xcd0001) {
				// _TCI-begin statistics
				Store(c209, tag)
				Store(c220, num)
			}
			Case (0xcd0002) {
				// TCI_CMD_CHECK_SUPPORTED
				Store(c20a, tag)
				Store(c22b, num)
			}
			Case (0xcd0003) {
				// TCI_CMD_GET_ID_OF_THREADS
				Store(c20b, tag)
				Store(arg1, num)
			}
			Default {
				err("m165", z128, 0, 0, 0, arg0, 0)
			}
		}

		if (LLess(num, c22b)) {
			err("m165", z128, 0, 0, 0, num, c22b)
		} else {
			Name(p000, Package(num) {})
			Name(lpN0, 0)
			Name(lpC0, 0)
			Store(num, lpN0)
			Store(0, lpC0)
			While (lpN0) {
				Store(0, Index(p000, lpC0))
				Decrement(lpN0)
				Increment(lpC0)
			}
			Store(tag, Index(p000, 0))
			Return (p000)
		}
	} else {
		Name(p001, Package(c220) {})
		Return (p001)
	}

	Return (0)
}

/*
 * Create and initialize the Package for simple cases
 * entirely specified by the opcode of command.
 *
 * a. for Memory Consumption Statistics
 *    (_TCI-begin or _TCI-end statistics).
 *
 * b. TCI_CMD_CHECK_SUPPORTED
 *
 * arg0 - opcode of the Test Command.
 *        Use 0 for allocation without initialization.
 *
 * Returns the TCI Package
 */
Method(m3a0, 1)
{
	Store(m165(arg0, 0), Local0)

	Return (Local0)
}

Method(m3a1, 2)
{
	Store(DeRefOf(Index(NMTP, arg1)), Local0)
	Concatenate("", arg0, Local2)
	Concatenate(Local2, " ", Local1)
	Concatenate(Local1, Local0, Debug)
}

/*
 * Print out the Memory Consumption Statistics Package
 *
 * arg0 - Memory Consumption Statistics Package
 * arg1 - opcode of the tittle message
 */
Method(m3a2, 2, Serialized)
{
	if (LEqual(arg1, 0)) {
		Store("==== _TCI-end statistics", Debug)
	} elseif (LEqual(arg1, 1)) {
		Store("==== _TCI-begin statistics", Debug)
	} elseif (LEqual(arg1, 2)) {
		Store("==== _TCI-end-begin difference", Debug)
	} else {
		Store("???", Debug)
	}

	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(c220, lpN0)
	Store(0, lpC0)

	Store(0, Local1)
	Store(0, Local2)

	While (lpN0) {

		if (LEqual(lpC0, c210)) {
			Store("Tittle:", Debug)
		} elseif (LEqual(lpC0, c211)) {
			Store("acq0:  all calls to AcpiUtAcquireFromCache", Debug)
		} elseif (LEqual(lpC0, c212)) {
			Store("acq1: +AcpiUtAcquireMutex", Debug)
		} elseif (LEqual(lpC0, c213)) {
			Store("acq2: +there is a cache object available", Debug)
		} elseif (LEqual(lpC0, c214)) {
			Store("acq3: +AcpiUtReleaseMutex", Debug)
		} elseif (LEqual(lpC0, c215)) {
			Store("acq4: +otherwise, the cache is empty, create a new object", Debug)
		} elseif (LEqual(lpC0, c216)) {
			Store("acq5: +AcpiUtReleaseMutex", Debug)
		} elseif (LEqual(lpC0, c217)) {
			Store("rel0:  all calls to AcpiUtReleaseToCache", Debug)
		} elseif (LEqual(lpC0, c218)) {
			Store("rel1: +walk cache is full, just free this object", Debug)
		} elseif (LEqual(lpC0, c219)) {
			Store("rel2: +otherwise, put this object back into the cache", Debug)
		} elseif (LEqual(lpC0, c21a)) {
			Store("rel3: +AcpiUtAcquireMutex", Debug)
		} elseif (LEqual(lpC0, c21b)) {
			Store("Created Objects:", Debug)
		} elseif (LEqual(lpC0, c21c)) {
			Store("Deleted Objects:", Debug)
		} elseif (LEqual(lpC0, c21d)) {
			Store("Miscellaneous Stat:", Debug)
		}

		if (LGreaterEqual(lpC0, c21d)) {
			Store(DerefOf(Index(arg0, lpC0)), Debug)
		} elseif (LGreaterEqual(lpC0, c21c)) {
			Store(DerefOf(Index(arg0, lpC0)), Local0)
			m3a1(Local0, Local1)
			Increment(Local1)
		} elseif (LGreaterEqual(lpC0, c21b)) {
			Store(DerefOf(Index(arg0, lpC0)), Local0)
			m3a1(Local0, Local2)
			Increment(Local2)
		} else {
			Store(DerefOf(Index(arg0, lpC0)), Debug)
		}

		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * Calculate the difference between the two
 * Memory Consumption Statistics Packages.
 *
 * arg0 - Package of _TCI-end statistics
 * arg1 - Package of _TCI-begin statistics
 * arg2 - Package for _TCI-end-begin difference
 */
Method(m3a3, 3, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(c220, lpN0)
	Store(0, lpC0)

	While (lpN0) {
		Store(DerefOf(Index(arg0, lpC0)), Local0)
		Store(DerefOf(Index(arg1, lpC0)), Local1)
		Subtract(Local1, Local0, Local2)
		Store(Local2, Index(arg2, lpC0))

		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * Verify difference of Memory Consumption Statistics between
 * two points: _TCI-end statistics and _TCI-begin statistics
 * (and reset locations of Command of arg0 and arg1 Packages
 * for the following run).
 *
 * Check that the Memory Consumption Statistics measured at the first point
 * as '_TCI-end statistics' was then changed as expected to the second point
 * where statistics was measured as '_TCI-begin statistics'. Between these
 * two points we initiate some AML activity which involves the memory
 * consumption acquire/release to be then analyzed and verified.
 *
 *
 * arg0 - Package of _TCI-end statistics
 * arg1 - Package of _TCI-begin statistics
 * arg2 - Package for _TCI-end-begin difference
 * arg3 - Package with the benchmark information on Created Objects
 * arg4 - Package with the benchmark information on Deleted Objects
 *        (if non-Package, then arg3 is used)
 * arg5 - Package with the benchmark information on memory acq0 and rel0
 *        (if non-Package, then compare acq0 and rel0 of arg2,
 *         otherwise, arg5 is a Package with the expected per-memory
 *         type differencies, expected: acq0[i] - rel0[i] = arg5[i])
 * arg6 - index of checking (inside the file)
 *
 * Return:
 *           0 - success
 *           1 - incorrect Memory Consumption Statistics encountered
 *   otherwise - failed to determine the Memory Consumption Statistics
 *
 * See: the time of execution can be reduced (design and use additional flags):
 * - exclude initialization before each operation
 *   (ACPICA writes all elements, benchmarks for the
 *   following sub-test mostly differ previous ones)
 * - restrict checkings (use flag) by the acq0 & rel0,
 *   and add & del.
 */
Method(m3a4, 7, Serialized)
{

	// Flag of printing
	Name(pr1, 0)
	Name(pr2, 0)

	Name(lpN0, 0)
	Name(lpC0, 0)

	if (pr1) {
		m3a2(arg0, 0)
		m3a2(arg1, 1)
	}

	if (pr2) {
		m3a2(arg2, 2)
	}

	Store(0, Local7)


	// Check headers of Packages


	if (m3a6(arg0, 0, arg6)) {
		Store(2, Local7)
	}

	if (m3a6(arg1, 1, arg6)) {
		Store(2, Local7)
	}


	// Check statistics specified by index


	if (m3a7(arg0, 0, arg6)) {
		Store(2, Local7)
	}

	if (m3a7(arg1, 0, arg6)) {
		Store(2, Local7)
	}

	if (m3a7(arg2, 1, arg6)) {
		Store(2, Local7)
	}


	/*
	 * acq0 and rel0 of arg2-difference
	 * are to be equal each to another
	 * (or correspond to arg5):
	 */


	if (LEqual(ObjectType(arg5), c00c)) {
		Store(c211, Local0)
		Store(c217, Local1)
		Store(0, Local4)

		Store(c221, lpN0)
		Store(0, lpC0)
		While (lpN0) {
			Store(DerefOf(Index(arg2, Local0)), Local2)
			Store(DerefOf(Index(arg2, Local1)), Local3)
			Store(DerefOf(Index(arg5, Local4)), Local5)

			Subtract(Local2, Local3, Local6)

			if (LNotEqual(Local6, Local5)) {
				if (LNot(DE00)) {
					err("m3a4", z128, 1, 0, arg6, Local6, Local5)
					Store(lpC0, Debug)
					Store(Local0, Debug)
					Store(Local1, Debug)
					Store(Local4, Debug)
					Store(Local2, Debug)
					Store(Local3, Debug)
					Store(Local5, Debug)
					Store(Local6, Debug)
				}
				Store(1, Local7)
			}

			Increment(Local0)
			Increment(Local1)
			Increment(Local4)

			Decrement(lpN0)
			Increment(lpC0)
		}
	} else {
		Store(c211, Local0)
		Store(c217, Local1)
		Store(c221, lpN0)
		Store(0, lpC0)
		While (lpN0) {
			Store(DerefOf(Index(arg2, Local0)), Local2)
			Store(DerefOf(Index(arg2, Local1)), Local3)
			if (LNotEqual(Local2, Local3)) {
				if (LNot(DE00)) {
					err("m3a4", z128, 2, 0, arg6, Local2, Local3)
				}
				Store(1, Local7)
			}
			Increment(Local0)
			Increment(Local1)
			Decrement(lpN0)
			Increment(lpC0)
		}
	}


	// arg2-difference: acq0 == acq3 + acq5


	Store(c211, Local0)
	Store(c214, Local1)
	Store(c216, Local2)

	Store(c221, lpN0)
	Store(0, lpC0)

	While (lpN0) {
		Store(DerefOf(Index(arg2, Local0)), Local3)
		Store(DerefOf(Index(arg2, Local1)), Local4)
		Store(DerefOf(Index(arg2, Local2)), Local5)
		Add(Local4, Local5, Local6)
		if (LNotEqual(Local3, Local6)) {
			if (LNot(DE00)) {
				err("m3a4", z128, 3, 0, arg6, Local3, Local6)
			}
			Store(1, Local7)
		}
		Increment(Local0)
		Increment(Local1)
		Increment(Local2)

		Decrement(lpN0)
		Increment(lpC0)
	}


	// arg2-difference: rel0 == rel1 + rel3


	Store(c217, Local0)
	Store(c218, Local1)
	Store(c21a, Local2)

	Store(c221, lpN0)
	Store(0, lpC0)

	While (lpN0) {
		Store(DerefOf(Index(arg2, Local0)), Local3)
		Store(DerefOf(Index(arg2, Local1)), Local4)
		Store(DerefOf(Index(arg2, Local2)), Local5)
		Add(Local4, Local5, Local6)
		if (LNotEqual(Local3, Local6)) {
			if (LNot(DE00)) {
				err("m3a4", z128, 4, 0, arg6, Local3, Local6)
			}
			Store(1, Local7)
		}
		Increment(Local0)
		Increment(Local1)
		Increment(Local2)

		Decrement(lpN0)
		Increment(lpC0)
	}


	// Check, created Objects are identical to the benchmark ones


	if (LEqual(ObjectType(arg3), c00c)) {

		Store(c027, lpN0)
		Store(c21b, Local0)
		Store(0, Local1)
		While (lpN0) {
			Store(DerefOf(Index(arg2, Local0)), Local2)
			Store(DerefOf(Index(arg3, Local1)), Local3)
			if (LNotEqual(Local2, Local3)) {
				if (LNot(DE00)) {
					err("m3a4", z128, 5, 0, arg6, Local2, Local3)
				}
				Store(1, Local7)
			}

			Increment(Local0)
			Increment(Local1)

			Decrement(lpN0)
		}
	}


	// Check, deleted Objects are identical to the benchmark ones


	Store(c027, lpN0)

	Store(c21c, Local0)
	Store(0, Local1)
	Store(0, Local4)

	if (Lequal(ObjectType(arg4), c00c)) {
		Store(arg4, Local4)
	} elseif (Lequal(ObjectType(arg3), c00c)) {
		Store(arg3, Local4)
	}

	if (Lequal(ObjectType(Local4), c00c)) {
		While (lpN0) {
			Store(DerefOf(Index(arg2, Local0)), Local2)
			Store(DerefOf(Index(Local4, Local1)), Local3)
			if (LNotEqual(Local2, Local3)) {
				if (LNot(DE00)) {
					err("m3a4", z128, 6, 0, arg6, Local2, Local3)
				}
				Store(1, Local7)
			}

			Increment(Local0)
			Increment(Local1)

			Decrement(lpN0)
		}
	}

	/*
	 * Reset locations of Command of arg0 and arg1
	 * Packages for the following run.
	 * Store(0, Index(arg0, c224))
	 * Store(0, Index(arg1, c224))
	 */

	return (Local7)
}

/*
 * Return non-zero in case the Test Command interface
 * with the ACPICA (_TCI) is supported.
 */
Method(m3a5)
{
	Store(m3a0(c202), Local0)	// TCI_CMD_CHECK_SUPPORTED

	_TCI(c202, Local0)

	Store(DerefOf(Index(Local0, c224)), Local1)

	if (LNotEqual(Local1, c202)) {
		return (0)
	}

	return (1)
}

/*
 * Check header of Memory Consumption Statistics Package
 * arg0 - Memory Consumption Statistics Package
 * arg1 - Means:
 *        0         - _TCI-end statistics
 *        otherwise - _TCI-begin statistics
 * arg2 - index of checking (inside the file)
 */
Method(m3a6, 3)
{
	Store(0, Local7)

	// Tag of command

	if (arg1) {
		Store(c209, Local0)
	} else {
		Store(c208, Local0)
	}

	Store(DerefOf(Index(arg0, 0)), Local1)
	if (LNotEqual(Local1, Local0)) {
		err("m3a6", z128, 7, 0, arg2, Local1, Local0)
		Store(1, Local7)
	}

	// Number of elements actually packed

	Store(DerefOf(Index(arg0, 1)), Local1)
	if (LNotEqual(Local1, c220)) {
		err("m3a6", z128, 8, 0, arg2, Local1, c220)
		Store(1, Local7)
	}

	// Command has been executed

	if (arg1) {
		Store(c201, Local0)
	} else {
		Store(c200, Local0)
	}

	Store(DerefOf(Index(arg0, 2)), Local1)
	if (LNotEqual(Local1, Local0)) {
		err("m3a6", z128, 9, 0, arg2, Local1, Local0)
		Store(1, Local7)
	}

	// Object cache is enabled

	Store(DerefOf(Index(arg0, 3)), Local1)
	if (LNot(Local1)) {
		err("m3a6", z128, 10, 0, arg2, Local1, 1)
		Store(1, Local7)
	}

	return (Local7)
}

/*
 * Check statistics specified by index
 *
 * arg0 - Memory Consumption Statistics Package
 * arg1 - Means:
 *        non-zero  - _TCI-end-begin difference Package
 *        otherwise - usual Memory Consumption Statistics Package
 * arg2 - index of checking (inside the file)
 */
Method(m3a7, 3)
{
	Store(0, Local7)

	if (arg1) {

/*
		// ACPI_STAT_SUCCESS_FREE == ACPI_STAT_SUCCESS_ALLOC

		Add(c21d, 5, Local0)
		Store(DerefOf(Index(arg0, Local0)), Local1)
		Increment(Local0)
		Store(DerefOf(Index(arg0, Local0)), Local2)

		if (LNotEqual(Local2, Local1)) {
			err("m3a7", z128, 11, 0, arg2, Local2, Local1)
			Store(1, Local7)
		}
*/

	} else {

		// ACPI_STAT_INVALID_EXBUF

		Store(c21d, Local0)
		Store(DerefOf(Index(arg0, Local0)), Local1)
		if (Local1) {
			err("m3a7", z128, 12, 0, arg2, Local1, 0)
			Store(1, Local7)
		}

		// ACPI_STAT_ZONE0_CORRUPTED

		Increment(Local0)
		Store(DerefOf(Index(arg0, Local0)), Local1)
		if (Local1) {
			err("m3a7", z128, 13, 0, arg2, Local1, 0)
			Store(1, Local7)
		}

		// ACPI_STAT_ZONE1_CORRUPTED

		Increment(Local0)
		Store(DerefOf(Index(arg0, Local0)), Local1)
		if (Local1) {
			err("m3a7", z128, 14, 0, arg2, Local1, 0)
			Store(1, Local7)
		}

		// ACPI_STAT_FAILED_ALLOC

		Increment(Local0)
		Store(DerefOf(Index(arg0, Local0)), Local1)
		if (Local1) {
			err("m3a7", z128, 15, 0, arg2, Local1, 0)
			Store(1, Local7)
		}

		// ACPI_STAT_NULL_FREE

		Increment(Local0)
		Store(DerefOf(Index(arg0, Local0)), Local1)
		if (Local1) {
			err("m3a7", z128, 16, 0, arg2, Local1, 0)
			Store(1, Local7)
		}
	}

	return (Local7)
}

/*
 * Create and initialize the sample Package for the
 * per-object type benchmark Memory Consumption Statistics
 */
Method(m3a8,, Serialized)
{
	Name(p000, Package() {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0})

	return (p000)
}

/*
 * Create and initialize the sample Package for the
 * per-memory type benchmark Memory Consumption Statistics
 */
Method(m3a9,, Serialized)
{
	Name(p000, Package() {0,0,0,0,0,0,0})

	return (p000)
}

/*
 * Determine the flag of optimization: check that
 * processing of the Add operation corresponds to
 * the expectation: optimized/non-optimized.
 *
 * Mode of run, optimized/non-optimized, is essential
 * for this kind tests (memory consumption).
 *
 * arg0 - Means:
 *           0 - check for Optimization is tuned off
 *   otherwise - check for Optimization is tuned on
 */
Method(m3aa,, Serialized)
{
	Name(i000, 0)
	Name(p000, Package(1) {})
	Name(p00b, Package(1) {})

	Store(0xff, FOPT)

	Store(m3a0(c200), Local0)	// _TCI-end statistics
	Store(m3a0(c201), p00b)		// _TCI-begin statistics
	Store(m3a0(0), Local1)		// difference

	_TCI(c200, Local0)
	Store(Add(3, 4), i000)
	_TCI(c201, p00b)

	m3a3(Local0, p00b, Local1)

	// Statistics expected in case Optimization is tuned off
	Store(m3a8(), p000)
	Store(4, Index(p000, c009)) // Integer

	Store(1, DE00)
	Store(m3a4(Local0, p00b, Local1, p000, 0, 0, 0), Local6)
	Store(0, DE00)

	if (LEqual(Local6, 2)) {
		Store("Failed to determine the flag of optimization", Debug)
		return
	} else {
		// Statistics expected in case Optimization is tuned on
		Store(m3a8(), p000)
		Store(1, Index(p000, c009)) // Integer

		Store(1, DE00)
		Store(m3a4(Local0, p00b, Local1, p000, 0, 0, 1), Local7)
		Store(0, DE00)

		if (LEqual(Local7, 2)) {
			Store("Failed to determine the flag of optimization", Debug)
			return
		}
	}

	if (LEqual(Local6, Local7)) {
		Store("Internal error 0", Debug)
		err("m3aa", z128, 17, 0, 0, Local6, Local7)
	} elseif (Local6) {
		Store(1, FOPT)
	} else {
		Store(0, FOPT)
	}
}

/*
 * Return Package with the array of thread indexes
 * otherwise Integer 0.
 *
 * arg0 - number of threads
 */
Method(m163, 1, Serialized)
{
	Name(size, 0)

	Add(c22f, arg0, size)

	Store(m165(c203, size), Local0)	// TCI_CMD_GET_ID_OF_THREADS

	_TCI(c203, Local0)

	Store(DerefOf(Index(Local0, c224)), Local1)

	if (LNotEqual(Local1, c203)) {
		return (0)
	}

	return (Local0)
}
