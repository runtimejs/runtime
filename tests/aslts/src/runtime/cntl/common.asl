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
 * Objects of common use to provide the common control of test run,
 * provide the uniform structure of all run-time tests.
 *
 * The full applied hierarchy of test-concepts follows:
 * - test suite       (aslts)
 * - test collection  (functional, complex, exceptions,...)
 * - test case        (arithmetic, bfield, exc, opackageel,..)
 * - test (or root method) simplest test unit supplied with the
 *         status line and evaluated as [PASS|FAIL|BLOCKED|SKIPPED].
 */

Name(z062, 62)

Name(ff32, 0xffffffff)         // -1, 32-bit
Name(ff64, 0xffffffffffffffff) // -1, 64-bit

// Test execution trace

Name(TRCF, 0)            // Trace enabling flag
Name(TRCH, "ASLTS")      // Head of trace message
Name(STST, "STST")	 // Head of summary status message of test run
Name(CTST, "CTST")	 // Head of curent status message of test run

Name(pr01, 1)            // Printing starts of sub-tests
Name(pr02, 1)            // More detailed printing

// Start time (Timer-time) of running test
Name(tmt0, 0)

// Flag of multi-threading mode
Name(MTHR, 0)

/* Set the multi-threading mode flag */
Method(SET3, 1)
{
	Store(arg0, MTHR)
}

// From Integer arithmetic
Name(c000, 10)
Name(c001, 5)

// From Logical operators
Name(c002, 13)
Name(c003, 12)
Name(c004, 6)
Name(c005, 4)
Name(c006, 31)
Name(c007, 51)

// Types, as returned by ObjectType
Name(c008, 0)	// Uninitialized
Name(c009, 1)	// Integer
Name(c00a, 2)	// String
Name(c00b, 3)	// Buffer
Name(c00c, 4)	// Package
Name(c00d, 5)	// Field Unit
Name(c00e, 6)	// Device
Name(c00f, 7)	// Event
Name(c010, 8)	// Method
Name(c011, 9)	// Mutex
Name(c012, 10)	// Operation Region
Name(c013, 11)	// Power Resource
Name(c014, 12)	// Processor
Name(c015, 13)	// Thermal Zone
Name(c016, 14)	// Buffer Field
Name(c017, 15)	// DDB Handle
Name(c018, 16)	// Debug Object
Name(c019, 17)	// LOCAL_REGION_FIELD
Name(c01a, 18)	// LOCAL_BANK_FIELD
Name(c01b, 19)	// LOCAL_INDEX_FIELD
Name(c01c, 20)	// LOCAL_REFERENCE
Name(c01d, 21)	// LOCAL_ALIAS
Name(c01e, 22)	// LOCAL_METHOD_ALIAS
Name(c01f, 23)	// LOCAL_NOTIFY
Name(c020, 24)	// LOCAL_ADDRESS_HANDLER
Name(c021, 25)	// LOCAL_RESOURCE
Name(c022, 26)	// LOCAL_RESOURCE_FIELD
Name(c023, 27)	// LOCAL_SCOPE
Name(c024, 28)	// LOCAL_EXTRA
Name(c025, 29)	// LOCAL_DATA
Name(c027, 30)	// Number of different types

Name(c028, 0)	// Reserved (first)

// The name of type Package
Name(NMTP, Package() {
	"Uninitialized",
	"Integer",
	"String",
	"Buffer",
	"Package",
	"Field Unit",
	"Device",
	"Event",
	"Method",
	"Mutex",
	"Operation Region",
	"Power Resource",
	"Processor",
	"Thermal Zone",
	"Buffer Field",
	"DDB Handle",
	"Debug Object",
	"LOCAL_REGION_FIELD",
	"LOCAL_BANK_FIELD",
	"LOCAL_INDEX_FIELD",
	"LOCAL_REFERENCE",
	"LOCAL_ALIAS",
	"LOCAL_METHOD_ALIAS",
	"LOCAL_NOTIFY",
	"LOCAL_ADDRESS_HANDLER",
	"LOCAL_RESOURCE",
	"LOCAL_RESOURCE_FIELD",
	"LOCAL_SCOPE",
	"LOCAL_EXTRA",
	"LOCAL_DATA",
	"--",
	"--"})

// Global variables for an arbitrary use inside the particular Run-methods
Name(c080, 0)
Name(c081, 0)
Name(c082, 0)
Name(c083, 0)
Name(c084, 0)
Name(c085, 0)
Name(c086, 0)
Name(c087, 0)
Name(c088, 0)
Name(c089, 0)
Name(c08a, 0)
Name(c08b, 0)
Name(c08c, 7900000) // used in operand tests (801 - 2 msec)

/*
 * Flag:
 *    non-zero - prohibits non-precise opcode exceptions
 *               (one particular opcode of exception is verified).
 *    0 - only presence of some exception(s) is verified.
 */
Name(EXCV, 0)


/*
 * An "absolute index of file reporting error" used for reporting errors
 * from the bug-demo files (only!). It is the same for all the bug-demo files
 * (files of TCLD type tests). It is not even an index of file as such in this
 * case but only designation of reporting error from some bug-demo file. The
 * actual number of bug (NNN) in this case is taken from TIND and the same file
 * name like this "*NNN.asl" is reported for all the bug-demo files corresponding
 * to the same bug where NNN is the number of bug. So, "indexes of errors
 * (inside the file)" corresponding to the same bug should differ through
 * all files of that bug.
 */
Name(zFFF, 0x7FF)

/*
 * Flag: 0 - 32, 1 - 64
 */
Name(F64, 0)

/*
 * Byte and character size of Integer
 */
Name(ISZ0, 0)
Name(ISZC, 0)

/*
 * The tests execution trace.
 *
 * ETR0 - the size of trace Packages
 * ETR1 - the number of units (ETR0/3) in trace Packages
 * ERRP - Package for summary information about the first ETR1 errors
 * RP0P - Package to store the first ETR0 status lines of the
 *        root Methods run results.
 * RMRC - current number of root Methods runs
 */
Name(ETR0, 1200)
Name(ETR1, 400)
Name(ERRP, Package(ETR0) {})
Name(RP0P, Package(ETR0) {})
Name(RMRC, 0)

/*
 * Errors handling
 * (ERR0 & ERR2) overwrite (arg3 & arg4) of err()
 * (but there is no remained ArgX for ERR1 in err()).
 */
Name(ERRS, 0)	// Errors counter
Name(ERRB, 0)	// Error opcode base
Name(ERR0, 0)	// Absolute index of file initiating the checking
Name(ERR1, 0)	// Name of Method initiating the checking
Name(ERR2, 0)	// Index of checking
Name(ERR3, 0)	// Current indicator of errors
Name(ERR4, 0)	// Full print out of ERRORS SUMMARY
Name(ERR5, 0)	// Used to calculate the number of errors of root Method
Name(ERR6, 0)	// The number of failed root Methods (tests)
Name(ERR7, 0)	// The number of errors detected during the loading stage

Name(FNAM, 0)   // Test filename

/*
 * Set parameters of current checking
 *
 * arg0 - absolute index of file initiating the checking
 * arg1 - name of Method initiating the checking
 * arg2 - index of checking (inside the file)
 *
 * ATTENTION:
 * These globals are introduced due to the lack of
 * parameters of ASL-Method (7).
 * Sometimes these parameters may mislead, because
 * may be redirected by the following more deeper
 * calls. We don't restore the previous values - it
 * would be too complicated.
 *
 * Apply it when the common Methods are used and
 * the initial Method which initialized the checking
 * is somewhere in another file and there is no remained
 * ArgX to pass that information.
 *
 * Apply it also when there are many entries with the
 * "index of checking" in the same file. It is more
 * convenient to arrange them inside the particular
 * Methods than to update all them inside the entire
 * file each time when it is needed to change any
 * or add some new.
 *
 * Note:
 * Due to the lack of ArgX the direct call to err()
 * doesn't allow to print the "Name of Method initiating
 * the checking". This is possible due to SET0 as well.
 *
 * Note:
 * Dont attempt to set up the zero "index of checking"
 * by this Method. It will be ignored and overwritten
 * by arg4 of err().
 *
 * Note:
 * Nevertheless, in any case, the err() provides
 * not exact address of error but only hints where
 * to seek the actual source Method of error.
 */
Method(SET0, 3) {
	if (ERR0) {
		err("SET0", z062, 0, 0, 0, ERR0, 0)
	} else {
		CopyObject(arg0, ERR0)
		CopyObject(arg1, ERR1)
		CopyObject(arg2, ERR2)
	}
}

// Reset parameters of current checking
Method(RST0) {
	CopyObject(0, ERR0)
	CopyObject(0, ERR1)
	CopyObject(0, ERR2)
	CopyObject(0, FNAM)
}

// Reset current indicator of errors
Method(RST2) {
	Store(0, ERR3)
}

// Get current indicator of errors
Method(GET2) {
	Return (ERR3)
}

// Collections of tests
Name(TCLA, 0)	// compilation
Name(TCLF, 1)	// functional
Name(TCLC, 2)	// complex
Name(TCLE, 3)	// exceptions
Name(TCLD, 4)	// bug-demo (bdemo)
Name(TCLS, 5)	// service
Name(TCLM, 6)	// mt
Name(TCLT, 7)	// Identity2MS
Name(TCLI, 8)	// implementation dependent
Name(MAXC, 8)	// equal to last maximal

// Current index of tests collection
Name(TCLL, 0)

// Index of current test inside the collection
Name(TIND, 0x12345678)

// Name of test
Name(TSNM, "NAME_OF_TEST")

// Name of root method
Name(NRMT, "")

/*
 * Flag, execution of root-method was skipped.
 *
 * It means that there where no conditions to run the test,
 * the test was not run and the reported status is 'skipped'.
 * The relevant assertion specified by the test is not to be
 * verified under the particular conditions at all.
 *
 * For example, the test can be run only in 64-bit mode, in
 * 32-bit mode the result of the test is undefined, so in
 * 32-bit mode, dont run it but only report the status of
 * test as skipped.
 */
Name(FLG5, 0)

/*
 * Flag, execution of root-method was blocked.
 *
 * It means that for some reason the test at present can not be run.
 * The tests was not run and the relevant assertion was not verified.
 * The test will be run when the conditions are changed. Up to that
 * moment, the status of such test is reported as 'blocked'.
 *
 * For example, some tests temporarily cause abort of testing,
 * thus preventing normal completion of all the tests of aslts
 * and generating the summary status of run of aslts.
 * To provide the normal conditions for other tests of aslts
 * we block the tests which prevent normal work
 * until the relevant causes are fixed in ACPICA.
 */
Name(FLG6, 0)

/*
 * Flag, compiler the test in the abbu layout
 */
Name(ABUU, 0)

// Set global test filename
Method(SETF, 1) {
    CopyObject(arg0, FNAM)
}

/*
 * Test Header - Display common test header
 *
 * Arg0 - Name of test (RT25, etc)
 * Arg1 - Full Name of test ("Resource Descriptor Macro", etc.)
 * Arg2 - Test filename (via __FILE__ macro)
 */
Method (THDR, 3)
{
    // Save the test filename in the FNAM global
	SETF (Arg2)

	// Build output string and store to debug object
    Concatenate ("TEST: ", Arg0, Local1)
    Concatenate (Local1, ", ", Local2)
    Concatenate (Local2, Arg1, Local3)
    Concatenate (Local3, " (", Local4)
    Concatenate (Local4, Arg2, Local5)
    Concatenate (Local5, ")", Local6)

    Store (Local6, Debug)
}


// Report completion of root Method
Method(RPT0) {

	// To get the same view in both 32-bit and 64-bit modes
	Name(b000, Buffer(4) {})

	if (SizeOf(NRMT)) {

		// Analize previous run of root Method

		Concatenate(":", TCN0(TCLL), Local1)
		Concatenate(Local1, ":", Local0)
		Concatenate(Local0, TNIC(TCLL, TIND), Local1)
		Concatenate(Local1, ":", Local0)
		Concatenate(Local0, NRMT, Local1)
		Concatenate(Local1, ":", Local0)

		Subtract(ERRS, ERR5, Local7)

		if (FLG5) {
			Concatenate(Local0, "SKIPPED:", Local1)
		} elseif (FLG6) {
			Concatenate(Local0, "BLOCKED:", Local1)
		} elseif (Local7) {
			Concatenate(Local0, "FAIL:Errors # ", Local2)
			Store(Local7, b000)
			Concatenate(Local2, b000, Local0)
			Concatenate(Local0, ":", Local1)
			Increment(ERR6)
		} else {
			Concatenate(Local0, "PASS:", Local1)
		}

		Concatenate(":", CTST, Local0)
		Concatenate(Local0, Local1, Local2)

		Store(Local2, Debug)

		if (LLess(RMRC, ETR0)) {
			Concatenate(":", STST, Local2)
			Concatenate(Local2, Local1, Local0)
			Store(Local0, Index(RP0P, RMRC))
		}

		Increment(RMRC)
	}
	Store(0, ERR5)
	Store(0, FLG5)
	Store(0, FLG6)
}

// Set the name of current root method
Method(SRMT, 1) {

	// Report completion of previous root Method
	RPT0()

	// Current number of errors
	Store(ERRS, ERR5)

	if (1) {
		Concatenate(arg0, " test started", Debug)
	}

	Store(arg0, NRMT)
}

/*
 * Set 'skipped' status of execution of root method.
 * Used only to report that the root-method was not
 * run but skipped.
 */
Method(SKIP) {
	Store(1, FLG5)
}

/*
 * Set 'blocked' status of execution of root method.
 * Used only to report that the root-method was not
 * run, it was blocked.
 */
Method(BLCK) {
	Store(1, FLG6)
}

/*
 * Open sub-test
 *
 * arg0 - absolute index of file initiating the checking
 * arg1 - the name of Method initiating the checking
 */
Method(BEG0, 2) {
	SET0(arg0, arg1, 0)
}

// Close sub-test
Method(END0) {
	RST0()
}

/*
 * Current test start
 * arg0 - name of test
 * arg1 - index of tests collection
 * arg2 - index of test inside the collection
 * arg3 - run mode parameter of test
 */
Method(STTT, 4) {
	Store(arg0, TSNM)
	Store(arg1, TCLL)
	Store(arg2, TIND)

	Store("", NRMT)
	Store(0, FLG5)
	Store(0, FLG6)
	Store(0, ERR5)

	// Pack up ID of test case to use it in err()
	Store(PK00(arg1, arg2), ERRB)

	// Initial work for any test

	Concatenate("TEST (", TCN0(TCLL), Local1)
	Concatenate(Local1, "), ", Local0)
	Concatenate(Local0, TSNM, Local1)

	if (RTPT) {

		// Run Tests Parameters Technique (RTPT)
		// When running a group of tests (collections), full*

		Store(0, Local7)
		if (LEqual(RUN0, 0)) {
			Store(1, Local7)
		} elseif (LEqual(RUN0, 1)) {
			if (arg3) {
				Store(1, Local7)
			}
		} elseif (LEqual(RUN0, 2)) {
			if (LEqual(arg3, 0)) {
				Store(1, Local7)
			}
		} elseif (LEqual(RUN0, 3)) {
			if (LEqual(arg3, RUN1)) {
				Store(1, Local7)
			}
		} elseif (LEqual(RUN0, 4)) {
			if (LEqual(arg1, RUN2)) {
				if (LEqual(arg2, RUN3)) {
					Store(1, Local7)
				}
			}
		}
	} else {
		Store(1, Local7)
	}

	if (LNot(Local7)) {
		Concatenate(Local1, ", SKIPPED", Local0)
		Store(Local0, Local1)
	}

	Store(Local1, Debug)

	return (Local7)
}

// Current test finish
Method(FTTT) {
	CH03("FTTT", 0, 0, 0, 0)

	// Report completion of previous root Method
	RPT0()

	Store("NAME_OF_TEST", TSNM)
	Store(0, TCLL)
	Store(0x12345678, TIND)
	Store("", NRMT)
	Store(0, FLG5)
	Store(0, FLG6)
	Store(0, ERR5)
}

/*
 * Pack up ID of test case
 *
 * arg0 - index of tests collection
 * arg1 - index of test inside the collection
 */
Method(PK00, 2)
{
	And(arg0, 0x0f, Local0)
	And(arg1, 0x1f, Local1)
	ShiftLeft(Local0, 5, Local2)
	Or(Local2, Local1, Local0)
	ShiftLeft(Local0, 23, Local7)
	return (Local7)
}

/*
 * Pack up information of checking
 *
 * arg0 - absolute index of file initiating the checking
 * arg1 - index of checking (inside the file)
 */
Method(PK01, 2)
{
	And(arg0, 0x07ff, Local0)
	And(arg1, 0x0fff, Local1)
	ShiftLeft(Local0, 12, Local2)
	Or(Local2, Local1, Local7)

	return (Local7)
}

/*
 * Pack up index of bug
 *
 * arg0 - index of bug
 */
Method(PK02, 1)
{
	And(arg0, 0x1ff, Local0)
	ShiftLeft(Local0, 23, Local7)

	return (Local7)
}

/*
 * Pack up information of error
 *
 * arg0 - absolute index of file reporting the error
 * arg1 - index of error (inside the file)
 */
Method(PK03, 2)
{
	And(arg0, 0x07ff, Local0)
	And(arg1, 0x0fff, Local1)
	ShiftLeft(Local0, 12, Local2)
	Or(Local2, Local1, Local7)
	return (Local7)
}


/*
 * Errors processing
 *
 * NOTE: looks we have exceeded some of the fields below
 *       but don't actually use them though pack them up.
 *
 * The layout of opcode of error (three 32-bit words)
 *
 * Word 0) 0xctfffeee (information of error)
 *
 * [31:28,4]   - c   0xf0000000
 * [27:23,5]   - t   0x0f800000
 * [22:12,11]  - fff 0x007ff000
 * [11:0,12]   - eee 0x00000fff
 *
 * Word 1) 0xmmzzzuuu (information of checking)
 *
 * [31:23,9]   - m   0xff800000
 * [22:12,11]  - zzz 0x007ff000
 * [11:0,12]   - uuu 0x00000fff
 *
 * Word 2) 0xnnnnnnnn (name of method)
 *
 *   c - index of tests collection
 *   t - index of test inside the collection
 *   f - absolute index of file reporting the error
 *   e - index of error (inside the file)
 *
 *   z - absolute index of file initiating the checking
 *   u - index of checking
 *   m - miscellaneous:
 *       1) in case of TCLD tests there is an index of bug
 *
 *   n - name of Method initiating the checking
 *
 * arg0 - diagnostic message (usually, the name of method conglomeration of tests)
 * arg1 - absolute index of file reporting the error
 * arg2 - index of error (inside the file)
 * arg3 - absolute index of file initiating the checking
 * arg4 - index of checking (inside the file)
 * arg5 - first value (usually, received value)
 * arg6 - second value (usually, expected value)
 */

Method(err, 7)
{
	Store(0, Local3)
	Store(0, Local6)

	if (ERR0) {

		// ERR0 (Local4) - absolute index of file initiating the checking
		// ERR1 (Local3) - name of Method initiating the checking
		// ERR2 (Local5) - index of checking

		Store(ERR0, Local4)
		Store(ERR1, Local3)

		// Dont attempt to set up the zero "index of checking"
		// by SET0. It will be ignored and overwritten by arg4
		// of err().

		if (ERR2) {
			Store(ERR2, Local5)
		} else {
			Store(arg4, Local5)
		}

	} else {
		Store(0, Local4)
		Store(arg4, Local5)
		if (LEqual(TCLL, TCLD)) {
			if (Local5) {
				Store(zFFF, Local4)
			}
		} else {
			Store(arg3, Local4)
		}
		if (LEqual(ObjectType(arg0), c00a)) {
			Store(arg0, Local3)
		}
	}

	if (Local4) {
		// Pack up information of checking
		Store(PK01(Local4, Local5), Local6)
	}

	if (LEqual(TCLL, TCLD)) {

		// Pack up index of bug
		Store(PK02(TIND), Local0)
		Or(Local6, Local0, Local6)
	}

	// Pack up information of error
	Store(PK03(arg1, arg2), Local0)

	// Add ID of test case being executed
	Or(ERRB, Local0, Local7)

	Concatenate("---------- ERROR    : 0x", Local7, Local1)
	Concatenate(", 0x", Local6, Local2)
	Concatenate(Local1, Local2, Local0)
	Concatenate(Local0, ", ", Local1)
	Concatenate(Local1, arg0, Local0)
	Store(Local0, Debug)

	ERP0(arg1, arg2, Local4, Local3, Local5)

    if (LEqual (ObjectType (arg5), 1)) // Check for Integer
    {
        /* Format/print the Expected result value */

        ToHexString (arg6, Local0)
        ToDecimalString (arg6, Local1)

        Concatenate ("**** Expected Result: 0x", Local0, Local0)
        Concatenate (Local0, ", (", Local0)
        Concatenate (Local0, Local1, Local0)
        Concatenate (Local0, ")", Local0)
        Store (Local0, Debug)

         /* Format/print the Actual result value */

        ToHexString (arg5, Local0)
        ToDecimalString (arg5, Local1)

        Concatenate ("**** Actual Result  : 0x", Local0, Local0)
        Concatenate (Local0, ", (", Local0)
        Concatenate (Local0, Local1, Local0)
        Concatenate (Local0, ")", Local0)
        Store (Local0, Debug)
   }
    else
    {
	    Store("**** Actual Result:", Debug)
	    Store(arg5, Debug)
	    Store("**** Expected Result:", Debug)
	    Store(arg6, Debug)
    }
	Store("---------- END\n", Debug)

	// Pack the summary information about the first N errors

	if (LLess(ERRS, ETR1)) {
		Multiply(ERRS, 3, Local0)
		Store(Local7, Index(ERRP, Local0)) // information of error
		Increment(Local0)
		Store(Local6, Index(ERRP, Local0)) // information of checking
		Increment(Local0)
		Store(Local3, Index(ERRP, Local0)) // name of method
	}

	Increment(ERRS)

	// Set current indicator of errors
	Store(1, ERR3)
}

/*
 * Report parameters of error
 * arg0 - absolute index of file reporting the error
 * arg1 - index of error
 * arg2 - absolute index of file initiating the checking
 * arg3 - name of Method initiating the checking
 * arg4 - index of checking
 */
Method(ERP0, 5)
{
	Concatenate("TITLE               : ", TSNM, Local0)
	Store(Local0, Debug)

	Concatenate("COLLECTION          : ", TCN0(TCLL), Local0)
	Store(TNIC(TCLL, TIND), Local1)

	Store(Local0, Debug)

	Concatenate("TEST CASE           : ", Local1, Local0)
	Store(Local0, Debug)

	Concatenate("TEST                : ", NRMT, Local0)
	Store(Local0, Debug)

	// Error

    if (LNotEqual (FNAM, 0))
    {
        // Use global filename, set via SETF
        Store (FNAM, Local1)
    }
	elseif (LEqual(arg0, zFFF)) {

		// ATTENTION: dont use zFFF in tests other than TCLD

		Store(SB00(TIND, 0), Local1)
	} else {
		Store(DeRefOf(Index(TFN0, arg0)), Local1)
	}
	Concatenate("ERROR,    File      : ", Local1, Local0)
	Store(Local0, Debug)

	Concatenate("          Index     : 0x", arg1, Local0)
	Concatenate(Local0, ", (", Local0)
	Concatenate(Local0, ToDecimalString (arg1), Local0)
	Concatenate(Local0, ")", Local0)
	Store(Local0, Debug)

	// Checking

	if (arg2) {
		if (LEqual(arg2, zFFF)) {
			// ATTENTION: dont use zFFF in tests other than TCLD
			Store(SB00(TIND, 0), Local1)
		} else {
			Store(DeRefOf(Index(TFN0, arg2)), Local1)
		}

		Concatenate("CHECKING, File      : ", Local1, Local0)
		Store(Local0, Debug)

		if (LEqual(ObjectType(arg3), c00a)) {
			Concatenate("             Method : ", arg3, Local0)
			Store(Local0, Debug)
		}

		Concatenate("             Index  : ", arg4, Local0)
		Store(Local0, Debug)
	}
}

/*
 * Service for bug-demo.
 *
 * arg0 - index of bug
 * arg1 - type of work:
 *          0 - return the name of test corresponding to bug-demo
 *          1 - return the name of file ..
 */
Method(SB00, 2) {

	Store("?", Local7)

	if (LEqual(arg1, 0)) {
		ToDecimalString(arg0, Local0)
		Concatenate("*", Local0, Local1)
		Concatenate(Local1, ".asl", Local7)
	} elseif (LEqual(arg1, 1)) {
		ToDecimalString(arg0, Local0)
		Concatenate("Demo of bug ", Local0, Local7)
	}

	return (Local7)
}

// Print out the whole contents, not only 32 bytes as debugger does
Method(prn0, 1, Serialized) {

	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(SizeOf(arg0), lpN0)
	Store(0, lpC0)

	While (lpN0) {
		Store(DeRefOf(Index(arg0, lpC0)), Local0)
		Store(Local0, Debug)
		Decrement(lpN0)
		Increment(lpC0)
	}
}

/*
 * Check result of operation on equal to Zero
 * arg0 - message of error
 * arg1 - arg5 of err, "received value"
 * arg2 - arg6 of err, "expected value"
 * arg3 - value
 */
Method(CH00, 4)
{
	if (LNotEqual(arg3, Zero)) {
		err(arg0, z062, 1, 0, 0, arg1, arg2)
	}
}

/*
 * Check result of operation on equal to Non-Zero (Ones)
 * arg0 - message of error
 * arg1 - arg5 of err, "received value"
 * arg2 - arg6 of err, "expected value"
 * arg3 - value
 */
Method(CH01, 4)
{
	if (LNotEqual(arg3, Ones)) {
		err(arg0, z062, 2, 0, 0, arg1, arg2)
	}
}

/*
 * True, when the value is in range
 *
 * arg0 - Value
 * arg1 - RangeMin
 * arg2 - RangeMax
 */
Method(RNG0, 3)
{
	if (LGreater(arg1, arg2)) {
		Store("RNG0: RangeMin greater than RangeMax", Debug)
		Fatal(0, 0, 0) // Type, Code, Arg
	}
	if (LGreater(arg1, arg0)) {
		return (Zero)
	} else {
		if (LGreater(arg0, arg2)) {
			return (Zero)
		}
	}
	return (Ones)
}

// 200 symbols (without '\0')
Name(BIG0, "qwertyuiopasdfghjklzxcvbnm1234567890QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm1234567890QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm1234567890QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdf")

// All symbols
Name(ALL0, "`1234567890-=qwertyuiop[]\\asdfghjkl;'zxcvbnm,./~!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:\"ZXCVBNM<>?")

// Check all the constants are not corrupted
Method(CST0)
{
	if (LNotEqual(c000, 10)) {
		err("c000 corrupted", z062, 3, 0, 0, 0, 0)
	}
	if (LNotEqual(c001, 5)) {
		err("c001 corrupted", z062, 4, 0, 0, 0, 0)
	}

	if (LNotEqual(c002, 13)) {
		err("c002 corrupted", z062, 5, 0, 0, 0, 0)
	}
	if (LNotEqual(c003, 12)) {
		err("c003 corrupted", z062, 6, 0, 0, 0, 0)
	}
	if (LNotEqual(c004, 6)) {
		err("c004 corrupted", z062, 7, 0, 0, 0, 0)
	}
	if (LNotEqual(c005, 4)) {
		err("c005 corrupted", z062, 8, 0, 0, 0, 0)
	}
	if (LNotEqual(c006, 31)) {
		err("c006 corrupted", z062, 9, 0, 0, 0, 0)
	}
	if (LNotEqual(c007, 51)) {
		err("c007 corrupted", z062, 10, 0, 0, 0, 0)
	}

	if (LNotEqual(c008, 0)) {
		err("c008 corrupted", z062, 11, 0, 0, 0, 0)
	}
	if (LNotEqual(c009, 1)) {
		err("c009 corrupted", z062, 12, 0, 0, 0, 0)
	}
	if (LNotEqual(c00a, 2)) {
		err("c00a corrupted", z062, 13, 0, 0, 0, 0)
	}
	if (LNotEqual(c00b, 3)) {
		err("c00b corrupted", z062, 14, 0, 0, 0, 0)
	}
	if (LNotEqual(c00c, 4)) {
		err("c00c corrupted", z062, 15, 0, 0, 0, 0)
	}
	if (LNotEqual(c00d, 5)) {
		err("c00d corrupted", z062, 16, 0, 0, 0, 0)
	}
	if (LNotEqual(c00e, 6)) {
		err("c00e corrupted", z062, 17, 0, 0, 0, 0)
	}
	if (LNotEqual(c00f, 7)) {
		err("c00f corrupted", z062, 18, 0, 0, 0, 0)
	}
	if (LNotEqual(c010, 8)) {
		err("c010 corrupted", z062, 19, 0, 0, 0, 0)
	}
	if (LNotEqual(c011, 9)) {
		err("c011 corrupted", z062, 20, 0, 0, 0, 0)
	}
	if (LNotEqual(c012, 10)) {
		err("c012 corrupted", z062, 21, 0, 0, 0, 0)
	}
	if (LNotEqual(c013, 11)) {
		err("c013 corrupted", z062, 22, 0, 0, 0, 0)
	}
	if (LNotEqual(c014, 12)) {
		err("c014 corrupted", z062, 23, 0, 0, 0, 0)
	}
	if (LNotEqual(c015, 13)) {
		err("c015 corrupted", z062, 24, 0, 0, 0, 0)
	}
	if (LNotEqual(c016, 14)) {
		err("c016 corrupted", z062, 25, 0, 0, 0, 0)
	}
	if (LNotEqual(c017, 15)) {
		err("c017 corrupted", z062, 26, 0, 0, 0, 0)
	}
	if (LNotEqual(c018, 16)) {
		err("c018 corrupted", z062, 27, 0, 0, 0, 0)
	}
	if (LNotEqual(c019, 17)) {
		err("c019 corrupted", z062, 28, 0, 0, 0, 0)
	}
}

/*
 * Shift elements of buffer
 * <buf>,
 * <byte size of buf>,
 * <cmd: 0 - left, 1 - right>
 * <n shift: {1-7}>
 */
Method(sft0, 4, Serialized)
{
	Name(n000, 0)
	Name(ncur, 0)

	Store(arg1, n000)
	Store(0, ncur)

	Store(0, Local6)

	if (arg2) {
		Store(arg3, Local3)
		Subtract(8, Local3, Local5)
	} else {
		Store(arg3, Local5)
		Subtract(8, Local5, Local3)
	}

	Store(arg1, Local0)
	Increment(Local0)
	Name(b000, Buffer(Local0) {})

	While (n000) {
		Store(DeRefOf(Index(arg0, ncur)), Local0)
		ShiftRight(Local0, Local3, Local1)
		And(Local1, 0xff, Local2)
		Or(Local2, Local6, Local1)
		ShiftLeft(Local0, Local5, Local4)
		And(Local4, 0xff, Local6)
		Store(Local1, Index(b000, ncur))
		Decrement(n000)
		Increment(ncur)
	}

	Store(Local6, Index(b000, ncur))

	// Store(arg0, Debug)
	// Store(b000, Debug)

	return (b000)
}

/*
 * The entire byte size of buffer (starting with the
 * first byte of buffer, not field) affected by field.
 *
 * <index of bit>,
 * <num of bits>,
 */
Method(MBS0, 2)
{
	Add(arg0, arg1, Local0)
	Add(Local0, 7, Local1)
	Divide(Local1, 8, Local2, Local0)

	return (Local0)
}

/*
 * Bit-shift (0-7) elements of buffer
 *
 * <buf>,
 * <n shift: {0-7}>
 * <bit size of shift area>,
 * <source value of first byte>,
 * <source value of last byte>,
 */
Method(sft1, 5, Serialized)
{
	Name(prev, 0)
	Name(ms00, 0)
	Name(ms01, 0)
	Name(ms02, 0)
	Name(ms03, 0)
	Name(tail, 0)
	Name(lbt0, 0)

	// Loop 0
	Name(lpN0, 0)
	Name(lpC0, 0)

	// Byte size of result buffer
	Name(nb01, 0)

	// Reqular processed bytes number
	Name(nreg, 0)

	// Bit-size of low part of byte
	Name(nb08, 0)
	// Bit-size of high part of byte
	Name(nb09, 0)
	// Bit-size of last byte
	Name(rest, 0)

	if (LLess(arg2, 1)) {
		err("sft", z062, 29, 0, 0, arg2, 1)
		return (Ones)
	}

	if (LGreater(arg1, 7)) {
		err("sft", z062, 30, 0, 0, arg1, 7)
		return (Ones)
	}

	Store(MBS0(arg1, arg2), nb01)

	Name(b000, Buffer(nb01) {})

	// Layout of regulsr bytes
	Store(arg1, nb08)
	Subtract(8, nb08, nb09)

	// Produce masks of regulsr byte
	ShiftRight(0xff, nb08, Local0)
	ShiftLeft(Local0, nb08, ms01)
	Not(ms01, ms00)

	// Last byte size
	Add(arg1, arg2, Local7)
	Mod(Local7, 8, rest)
	if (LEqual(rest, 0)) {
		Store(8, rest)
	}

	// Substitute field usually determined on previous step
	And(arg3, ms00, prev)

	// Reqular processing repetition number
	if (LGreaterEqual(arg2, nb09)) {
		Store(1, nreg)
		Subtract(arg2, nb09, Local7)
		Divide(Local7, 8, Local1, Local0)
		Add(nreg, Local0, nreg)
	}

	// Regular processing

	Store(nreg, lpN0)
	Store(0, lpC0)
	While (lpN0) {

		Store(DeRefOf(Index(arg0, lpC0)), Local7)
		ShiftLeft(Local7, nb08, Local0)
		Or(Local0, prev, Local1)
		Store(Local1, Index(b000, lpC0))
		ShiftRight(Local7, nb09, prev)

		Decrement(lpN0)
		Increment(lpC0)
	}

	if (LEqual(rest, 8)) {
		Store(0, tail)
	} elseif (LLessEqual(rest, nb08)) {
		Store(1, tail)
	} else {
		Store(2, tail)
		Store(DeRefOf(Index(arg0, lpC0)), lbt0)
	}

	// ===================
	// Processing the tail
	// ===================

	if (LEqual(tail, 1)) {

		// Produce masks
		ShiftRight(0xff, rest, Local0)
		ShiftLeft(Local0, rest, ms03)
		Not(ms03, ms02)

		And(prev, ms02, Local0)
		And(arg4, ms03, Local1)
		Or(Local0, Local1, Local2)

		Store(Local2, Index(b000, lpC0))

	} elseif (LEqual(tail, 2)) {

		And(prev, ms00, Local0)
		ShiftLeft(lbt0, nb08, Local1)
		Or(Local0, Local1, Local7)

		/*
		 * Byte layout:
		 * 000011112222
		 * rem sz  nb08
		 * 33333333
		 * nb09
		 *     44444444
		 *     rest
		 */

		// Produce masks of rem field
		ShiftRight(0xff, rest, Local2)
		ShiftLeft(Local2, rest, Local0)
		Not(Local0, Local1)

		// Determine contents of field
		And(Local7, Local1, Local2)

		// Remained of original last (first) byte
		And(arg4, Local0, Local3)

		// Result
		Or(Local2, Local3, Local0)

		Store(Local0, Index(b000, lpC0))
	}

	return (b000)
}

/*
 * Verify result
 *
 * arg0 - name of test
 * arg1 - result
 * arg2 - expected value (64-bit mode)
 * arg3 - expected value (32-bit mode)
 * DISADVANTAGE: information about the actual place
 *               in errors reports is lost, should be
 *               resolved in the future.
 */
Method(m4c0, 4, Serialized)
{
	Name(tmp0, 0)
	Name(tmp1, 0)

	Store(0, Local7)

	Store(ObjectType(arg1), tmp0)

	if (F64) {
		Store(ObjectType(arg2), tmp1)
		if (LNotEqual(tmp0, tmp1)) {
			err(arg0, z062, 31, 0, 0, tmp0, tmp1)
			Store(1, Local7)
		} elseif (LNotEqual(arg1, arg2)) {
			err(arg0, z062, 32, 0, 0, arg1, arg2)
			Store(1, Local7)
		}
	} else {
		Store(ObjectType(arg3), tmp1)
		if (LNotEqual(tmp0, tmp1)) {
			err(arg0, z062, 33, 0, 0, tmp0, tmp1)
			Store(1, Local7)
		} elseif (LNotEqual(arg1, arg3)) {
			err(arg0, z062, 34, 0, 0, arg1, arg3)
			Store(1, Local7)
		}
	}

	return (Local7)
}

/*
 * Return one-symbol string
 *
 * arg0 - source string contains desirable symbols
 * srg1 - index inside the source string
 */
Method(m4a1, 2, Serialized)
{
	Name(s000, " ")
	Store(DeRefOf(Index(arg0, arg1)), Local0)
	Store(Local0, Index(s000, 0))
	return (s000)
}

// Initialization
Method(STRT, 1, Serialized)
{
	Method(m555)
	{
	}

	/* Data to determine 32/64 mode, global because of mt-tests */
	DataTableRegion (HDR, "DSDT", "", "")
	Field(HDR, AnyAcc, NoLock, Preserve) {
		SIG, 32,
		LENG, 32,
		REV, 8,
		SUM, 8,
		OID, 48,
		OTID, 64,
		OREV, 32,
		CID, 32,
		CREV, 32,
	}

	/*
	 * The first fictitious Method execution which statistics
	 * is then used for to estimate all other Methods executions.
	 */
	m555()

	Store(Timer, tmt0)

	If (LLess (REV, 2)) {
		Store(0, F64)
		Store(4, ISZ0)
		Store(8, ISZC)
		Store ("32-bit mode", Debug)
	} else {
		Store(1, F64)
		Store(8, ISZ0)
		Store(16, ISZC)
		Store ("64-bit mode", Debug)
	}

	/*
	 * Check that the total number of exceptions is zero here.
	 * The internal data about the exceptions initiated by some
	 * bdemo tests on a global level should be reset by them to
	 * this point as they didn't take place. Otherwise, an error
	 * will be below registrated.
	 */
	if (CH02()) {
		Increment(ERR7)

		/* Reset internal information about exceptions */

		CH03("", 0, 0x888, 0, 0)
		Store(0, EXC0)
		Store(0, EXC1)
	}

	SRTP(arg0)

	RTPI()

	RST0()
	RST2()

	/* Adjust some skippings of tests for different ACPICA releases */
	SET2(SETN)
}

Name(TCNP, Package() {
	"compilation",
	"functional",
	"complex",
	"exceptions",
	"bdemo",
	"service",
	"mt",
	"Identity2MS",
	"IMPL",
})

/*
 * Test collection name
 * arg0 - index of test collection
 */
Method(TCN0, 1) {
	Store("?", Local7)
	if (LLessEqual(arg0, MAXC)) {
		Store(DerefOf(Index(TCNP, arg0)), Local7)
	}
	Return(Local7)
}

/*
 * Name of test inside collection
 * arg0 - index of test collection
 * arg1 - index of test inside the collection
 */
Method(TNIC, 2, Serialized) {
	Store("?", Local7)
	switch (ToInteger (arg0)) {
		case (1) {
			Store(DeRefOf(Index(TNF0, arg1)), Local7)
		}
		case (2) {
			Store(DeRefOf(Index(TNC0, arg1)), Local7)
		}
		case (3) {
			Store(DeRefOf(Index(TNE0, arg1)), Local7)
		}
		case (4) {
			Store(SB00(arg1, 1), Local7)
		}
		case (5) {
			Store(DeRefOf(Index(TNS0, arg1)), Local7)
		}
		case (6) {
			Store(DeRefOf(Index(TNM0, arg1)), Local7)
		}
		case (7) {
			Store(DeRefOf(Index(TNT0, arg1)), Local7)
		}
		case (8) {
			Store(DeRefOf(Index(TNI0, arg1)), Local7)
		}
	}

	Return(Local7)
}

// Names of functional tests
Name(TNF0, Package() {
	"arithmetic",
	"bfield",
	"constant",
	"control",
	"descriptor",
	"extern",
	"local",
	"logic",
	"manipulation",
	"name",
	"reference",
	"region",
	"synchronization",
	"table"
})

// Names of complex tests
Name(TNC0, Package() {
	"misc",
	"provoke",
	"oarg",
	"oconst",
	"olocal",
	"oreturn",
	"onamedloc",
	"onamedglob",
	"opackageel",
	"oreftonamed",
	"oconversion",
	"oreftopackageel",
	"rstore",
	"roptional",
	"rconversion",
	"rcopyobject",
	"rindecrement",
	"rexplicitconv",
	"badasl",
	"namespace"
})

// Names of exceptions tests
Name(TNE0, Package() {
	"exc",
	"exc_operand1",
	"exc_operand2",
	"exc_result1",
	"exc_result2",
	"exc_ref",
	"exc_tbl"
})

// Names of service tests
Name(TNS0, Package() {
	"condbranches"
})

// Names of mt tests
Name(TNM0, Package() {
	"mt-mutex"
})

// Names of Identity2MS tests
Name(TNT0, Package() {
	"abbu"
})

// Names of IMPL tests
Name(TNI0, Package() {
	"dynobj"
})

// Names of test files
Name(TFN0, Package() {
	"UNDEF",		// 0
	"crbuffield.asl",
	"constants.asl",
	"ctl0.asl",
	"ctl1.asl",
	"ctl2.asl",
	"timing.asl",
	"concatenaterestemplate.asl",
	"dependentfn.asl",
	"dma.asl",
	"dwordio.asl",
	"dwordmemory.asl",
	"dwordspace.asl",
	"extendedio.asl",
	"extendedmemory.asl",
	"extendedspace.asl",
	"fixedio.asl",
	"interrupt.asl",
	"io.asl",
	"irq.asl",
	"irqnoflags.asl",
	"memory24.asl",
	"memory32.asl",
	"memory32fixed.asl",
	"qwordio.asl",
	"qwordmemory.asl",	// 25
	"qwordspace.asl",
	"register.asl",
	"resourcetemplate.asl",
	"rtemplate.asl",
	"vendorlong.asl",
	"vendorshort.asl",
	"wordbusnumber.asl",
	"wordio.asl",
	"wordspace.asl",
	"logical.asl",
	"concatenate.asl",
	"eisaid.asl",
	"match1.asl",
	"mid.asl",
	"objecttype.asl",
	"sizeof.asl",
	"store.asl",
	"tobuffer.asl",
	"todecimalstring.asl",
	"tofrombcd.asl",
	"tohexstring.asl",
	"tointeger.asl",
	"tostring.asl",
	"touuid.asl",
	"unicode.asl",	// 50
	"package.asl",
	"event.asl",
	"mutex.asl",
	"misc.asl",
	"provoke.asl",
	"oconversion.asl",
	"rconversion.asl",
	"exc.asl",
	"exc_operand1.asl",
	"exc_result.asl",
	"XXXXXX.asl",	// 61 - RESERVED, not in use
	"common.asl",
	"ehandle.asl",
	"oproc.asl",
	"otest.asl",
	"rproc.asl",
	"rtest.asl",
	"switch1.asl",
	"switch2.asl",
	"switch3.asl",
	"switch4.asl",
	"switch5.asl",
	"switch6.asl",
	"while.asl",
	"match2.asl",
	"ref00.asl",
	"ref01.asl",
	"ref02.asl",
	"ref03.asl",
	"ref04.asl",
	"ref70.asl",
	"operations.asl",
	"arithmetic.asl",
	"ocommon.asl",
	"oconst.asl",
	"onamedglob1.asl",
	"onamedglob2.asl",
	"onamedloc1.asl",
	"onamedloc2.asl",
	"opackageel.asl",
	"oreftonamed1.asl",
	"exc_00_undef.asl",
	"exc_01_int.asl",
	"exc_02_str.asl",
	"exc_03_buf.asl",
	"exc_04_pckg.asl",
	"exc_05_funit.asl",
	"exc_06_dev.asl",
	"exc_07_event.asl",
	"exc_08_method.asl",	// 100
	"exc_09_mux.asl",
	"exc_10_oreg.asl",
	"exc_11_pwr.asl",
	"exc_12_proc.asl",
	"exc_13_tzone.asl",
	"exc_14_bfield.asl",
	"exc_operand2.asl",
	"ref05.asl",
	"ref71.asl",
	"ref06.asl",
	"ref50.asl",
	"name.asl",
	"data.asl",
	"dataproc.asl",
	"datastproc.asl",
	"ref07.asl",		// 116
	"olocal.asl",
	"oreturn.asl",
	"oreftopackageel.asl",
	"oreftonamed2.asl",	// 120
	"oarg.asl",
	"rcommon.asl",
	"rstore.asl",
	"rcopyobject.asl",
	"rindecrement.asl",
	"rexplicitconv.asl",
	"roptional.asl",
	"tcicmd.asl",
	"dobexec.asl",
	"dobdecl.asl",	// 130
	"dobctl.asl",
	"dobexceptions.asl",
	"method.asl",
	"function.asl",
	"condbranches.asl",
	"add.asl",
	"standaloneRet.asl",
	"store.asl",
	"return.asl",
	"dobmisc.asl",	// 140
	"opregions.asl",
	"dtregions.asl",
	"regionfield.asl",
	"indexfield.asl",
	"bankfield.asl",
	"badasl.asl",
	"mt-common.asl",
	"mt-mutex.asl",
	"mt-mxs.asl",
	"mutex2.asl",	// 150
	"mutex_proc.asl",
	"mt-tests.asl",
	"mt-service.asl",
	"ns0.asl",
	"ns1.asl",
	"ns2.asl",
	"ns3.asl",
	"ns4.asl",
	"ns5.asl",
	"ns6.asl",			// 160
	"I2MS_msfail0.asl",
	"I2MS_st0.asl",
	"I2MS_ns_in00.asl",
	"I2MS_ns_in10.asl",
	"I2MS_ns_in20.asl",
	"I2MS_ns_in30.asl",
	"I2MS_ns_in40.asl",
	"I2MS_ns_in50.asl",
	"I2MS_mt0_abbu.asl",
	"I2MS_mt0_aslts.asl",	// 170
	"I2MS_recursion_abbu.asl",
	"I2MS_recursion_aslts.asl",
	"serialized.asl",
	"load.asl",			// 174
	"unload.asl",
	"loadtable.asl",
	"recursion.asl",
	"ns-scope.asl",		// 178
	"ns-fullpath.asl",


// below are incorrect yet:

	"I2MS_ns_dv00.asl",
	"I2MS_ns_dv10.asl",
	"I2MS_ns_dv20.asl",
	"I2MS_ns_dv30.asl",	// 170

	"I2MS_ns_device.asl",
	"I2MS_ns_device_abbu.asl",
	"I2MS_ns_device_aslts.asl",

// see these files can be not used at all:
	"I2MS_ns4.asl",
	"I2MS_ns5.asl",
	"I2MS_ns6.asl",
	
// ACPI 5.0
    "fixeddma.asl", // 177
    "gpioint.asl",
    "gpioio.asl",
    "i2cserialbus.asl",
    "spiserialbus.asl",
    "uartserialbus.asl",
})

/*
 * Unpack error
 *
 * arg0 - information of error (Word 0)
 * arg1 - information of checking (Word 1)
 * arg2 - name of Method initiating the checking (Word 2)
 */
Method(UNP0, 3, Serialized)
{
	// c - index of tests collection
	ShiftRight(arg0, 28, Local7)
	And(Local7, 0x0f, Local0)

	// t - index of test inside the collection
	ShiftRight(arg0, 23, Local7)
	And(Local7, 0x1f, Local1)

	// f - absolute index of file reporting the error
	ShiftRight(arg0, 12, Local7)
	And(Local7, 0x07ff, Local2)

	// e - index of error (inside the file)
	And(arg0, 0x0fff, Local3)

	Store("", Local6)
	Store("", Local7)

	Switch (ToInteger (Local0)) {
		case (1) {
			Store(DeRefOf(Index(TNF0, Local1)), Local6)
			if (ERR4) {
				Store(", functional, ", Local7)
			}
		}
		case (2) {
			Store(DeRefOf(Index(TNC0, Local1)), Local6)
			if (ERR4) {
				Store(", complex, ", Local7)
			}
		}
		case (3) {
			Store(DeRefOf(Index(TNE0, Local1)), Local6)
			if (ERR4) {
				Store(", exceptions, ", Local7)
			}
		}
		case (4) {

			// m - in case of TCLD tests there is an index of bug

			ShiftRight(arg1, 23, Local0)
			And(Local0, 0x1ff, Local1)
			Store(SB00(Local1, 1), Local6)
			if (ERR4) {
				Store(", bug-demo, ", Local7)
			}
		}
		case (5) {
			Store(DeRefOf(Index(TNS0, Local1)), Local6)
			if (ERR4) {
				Store(", service, ", Local7)
			}
		}
		case (6) {
			Store(DeRefOf(Index(TNM0, Local1)), Local6)
			if (ERR4) {
				Store(", mt, ", Local7)
			}
		}
		case (7) {
			Store(DeRefOf(Index(TNT0, Local1)), Local6)
			if (ERR4) {
				Store(", Identity2MS, ", Local7)
			}
		}
		case (8) {
			Store(DeRefOf(Index(TNI0, Local1)), Local6)
			if (ERR4) {
				Store(", IMPL, ", Local7)
			}
		}
	}

	Concatenate(Local7, Local6, Local5)
	Concatenate(Local5, ", ", Local1)

	// Error

	if (LEqual(Local2, zFFF)) {

		// ATTENTION: dont use zFFF in tests other than TCLD
		// m - in case of TCLD tests there is an index of bug

		ShiftRight(arg1, 23, Local0)
		And(Local0, 0x1ff, Local2)
		Store(SB00(Local2, 0), Local6)

	} else {
		Store(DeRefOf(Index(TFN0, Local2)), Local6)
	}

	Concatenate(Local1, Local6, Local7)
	Concatenate(Local7, ", ", Local1)
	Concatenate(Local1, Local3, Local7)

	// (z+u) - entire field of checking

	And(arg1, 0x07fffff, Local5)

	if (Local5) {
		// z - absolute index of file initiating the checking
		ShiftRight(arg1, 12, Local5)
		And(Local5, 0x07ff, Local2)

		// u - index of checking
		And(arg1, 0x0fff, Local3)

		if (LEqual(Local2, zFFF)) {
			// ATTENTION: dont use zFFF in tests other than TCLD
			// m - in case of TCLD tests there is an index of bug
			ShiftRight(arg1, 23, Local0)
			And(Local0, 0x1ff, Local2)
			Store(SB00(Local2, 0), Local6)
		} else {
			Store(DeRefOf(Index(TFN0, Local2)), Local6)
		}

		Concatenate(Local7, ", ", Local1)
		Concatenate(Local1, Local6, Local5)
		Concatenate(Local5, ", ", Local1)
		Concatenate(Local1, Local3, Local7)

		if (LEqual(ObjectType(arg2), c00a)) {
			Concatenate(Local7, ", ", Local1)
			Concatenate(Local1, arg2, Local7)
		}
	}

	return (Local7)
}

// Report errors
Method(RERR,, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(ETR1, lpN0)

	if (LLess(ERRS, lpN0)) {
		Store(ERRS, lpN0)
	}

	Store(0, Local0)

	Store("========= ERRORS SUMMARY (max 400):", Debug)

	While (lpN0) {

		Store(DeRefOf(Index(ERRP, Local0)), Local7)
		Increment(Local0)
		Store(DeRefOf(Index(ERRP, Local0)), Local6)
		Increment(Local0)
		Store(DeRefOf(Index(ERRP, Local0)), Local4)
		Increment(Local0)

		Store(UNP0(Local7, Local6, Local4), Local1)

		if (ERR4) {
			Concatenate("", Local7, Local2)
			Concatenate(Local2, ", ", Local5)
			Concatenate(Local5, Local6, Local2)
			Concatenate(Local2, Local1, Local7)
		} else {
			Concatenate("", Local1, Local7)
		}

		Store(Local7, Debug)

		Decrement(lpN0)
		Increment(lpC0)
	}

	if (LGreater(ERRS, ETR1)) {
		Store("********* Not all errors were traced, maximum exceeded!", Debug)
	}
	Store("========= END.", Debug)
}

// Report root Methods run results
Method(RRM0,, Serialized, 3)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	Store(ETR0, lpN0)

	if (LLess(RMRC, lpN0)) {
		Store(RMRC, lpN0)
	}

	Store("========= ROOT METHODS SUMMARY (max 600):", Debug)
	While (lpN0) {
		Store(DeRefOf(Index(RP0P, lpC0)), Local7)
		Store(Local7, Debug)
		Decrement(lpN0)
		Increment(lpC0)
	}
	if (LGreater(RMRC, ETR0)) {
		Store("********* Not all root Methods were traced, maximum exceeded!", Debug)
	}
	Store("========= END.", Debug)
}

// Final actions
Method(FNSH)
{
	// Check, the current number of exceptions is zero

	CH03("FNSH", 0, 0, 0, 0)

	// Check all the constants are not corrupted

	CST0()

	// Run time

	Store(Timer, Local7)
	Subtract(Local7, tmt0, Local6)
	Divide(Local6, 10, Local1, Local2)
	Divide(Local2, 1000000, Local1, Local0)
	Store(Concatenate("Run time (in seconds): 0x", Local0), Debug)

	// Exceptions total

	Store(Concatenate("The total number of exceptions handled: 0x", EXC1), Debug)

	// Status of test run

	if (ERRS) {
		RERR()
	}

	// Report root Methods run results
	RRM0()

	if (F64) {
		Concatenate("TEST ACPICA: ", "64-bit :", Local0)
	} else {
		Concatenate("TEST ACPICA: ", "32-bit :", Local0)
	}

	if (ERR7) {
		Concatenate("!!!! ERRORS were detected during the loading stage, # 0x", ERR7, Debug)
	}

	Store(0, EXC1)

	if (LOr(ERRS, ERR7)) {
		Concatenate(Local0, " FAIL : Errors # 0x", Local1)
		Concatenate(Local1, ERRS, Local2)
		Concatenate(Local2, ", Failed tests # 0x", Local1)
		Store (Concatenate(Local1, ERR6), Debug)

		return (1)
	}

	Store(Concatenate(Local0, " PASS"), Debug)

	return (0)
}

// Trace execution

/*
 * Report write operation
 * arg0 - object where writing
 * arg1 - index where writing
 * arg2 - value
 */
Method(TRC0, 3)
{
	if (TRCF) {
		Concatenate(TRCH, ", WRITE: where ", Local0)
		Concatenate(Local0, arg1, Local1)
		Concatenate(Local1, ", ", Local0)
		Concatenate(Local0, arg2, Local1)
		Store(Local1, Debug)
	}
}

/*
 * Report read operation
 * arg0 - object from where reading
 * arg1 - index from where reading
 * arg2 - obtained value
 */
Method(TRC1, 3)
{
	if (TRCF) {
		Concatenate(TRCH, ", READ: where ", Local0)
		Concatenate(Local0, arg1, Local1)
		Concatenate(Local1, ", ", Local0)
		Concatenate(Local0, arg2, Local1)
		Store(Local1, Debug)
	}
}

/*
 * Report string
 * arg0 - string
 */
Method(TRC2, 1)
{
	if (TRCF) {
		Concatenate(TRCH, ", ", Local0)
		Concatenate(Local0, arg0, Local1)
		Store(Local1, Debug)
	}
}

// Switch on trace
Method(TRC8)
{
	Store(1, TRCF)
}

// Switch off trace
Method(TRC9)
{
	Store(0, TRCF)
}

// Start of test
Method(ts00, 1)
{
	if (pr01) {
		Concatenate("Test ", arg0, Local0)
		Concatenate(Local0, " started", Local1)
		Store(Local1, Debug)
	}
}

/*
 * Convert the Timer units (one unit - 100 nsecs) to Seconds
 * arg0 - interval in Timer units
 */
Method(TMR0, 1)
{
	// Convert to microseconds
	Divide(arg0, 10, Local0, Local1)
	// Convert to seconds
	Divide(Local1, 1000000, Local0, Local2)
	Return (Local2)
}
