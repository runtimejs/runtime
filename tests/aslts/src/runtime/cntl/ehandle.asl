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

External (_ERR, MethodObj)

/*
 * Exceptional conditions support
 */

Name(z063, 63)

// The current number of exceptions handled
Name(EXC0, 0x0)

// The total number of exceptions handled
Name(EXC1, 0x0)

// Opcode of the last exception
Name(EX00, 0x0)

// Name of the last exception
Name(EX01, "")

// Opcode of the first exception
Name(EX04, 0x0)

// Name of the first exception
Name(EX05, "")


/*
 * Undefined opcodes of exception
 */
Name(EX0D, 0xfd)
Name(EX0E, 0xfe)

// Undefined opcode of exception means 'any exceptions'
Name(EX0F, 0xff)

// Description of all exceptional conditions
Name(pf00, Package() {
	//          ix opcodes      names
	Package() { 0, 0x00000000, "AE_OK"},
	Package() { 1, 0x00000001, "AE_ERROR"},
	Package() { 2, 0x00000002, "AE_NO_ACPI_TABLES"},
	Package() { 3, 0x00000003, "AE_NO_NAMESPACE"},
	Package() { 4, 0x00000004, "AE_NO_MEMORY"},
	Package() { 5, 0x00000005, "AE_NOT_FOUND"},
	Package() { 6, 0x00000006, "AE_NOT_EXIST"},
	Package() { 7, 0x00000007, "AE_ALREADY_EXISTS"},
	Package() { 8, 0x00000008, "AE_TYPE"},
	Package() { 9, 0x00000009, "AE_NULL_OBJECT"},
	Package() {10, 0x0000000a, "AE_NULL_ENTRY"},
	Package() {11, 0x0000000b, "AE_BUFFER_OVERFLOW"},
	Package() {12, 0x0000000c, "AE_STACK_OVERFLOW"},
	Package() {13, 0x0000000d, "AE_STACK_UNDERFLOW"},
	Package() {14, 0x0000000e, "AE_NOT_IMPLEMENTED"},
	Package() {15, 0x0000000f, "AE_VERSION_MISMATCH"}, /* obsolete */
	Package() {16, 0x0000000f, "AE_SUPPORT"},
	Package() {17, 0x00000011, "AE_SHARE"}, /* obsolete */
	Package() {18, 0x00000010, "AE_LIMIT"},
	Package() {19, 0x00000011, "AE_TIME"},
	Package() {20, 0x00000014, "AE_UNKNOWN_STATUS"}, /* obsolete */
	Package() {21, 0x00000012, "AE_ACQUIRE_DEADLOCK"},
	Package() {22, 0x00000013, "AE_RELEASE_DEADLOCK"},
	Package() {23, 0x00000014, "AE_NOT_ACQUIRED"},
	Package() {24, 0x00000015, "AE_ALREADY_ACQUIRED"},
	Package() {25, 0x00000016, "AE_NO_HARDWARE_RESPONSE"},
	Package() {26, 0x00000017, "AE_NO_GLOBAL_LOCK"},
	Package() {27, 0x00000018, "AE_ABORT_METHOD"},
	Package() {28, 0x00001001, "AE_BAD_PARAMETER"},
	Package() {29, 0x00001002, "AE_BAD_CHARACTER"},
	Package() {30, 0x00001003, "AE_BAD_PATHNAME"},
	Package() {31, 0x00001004, "AE_BAD_DATA"},
	Package() {32, 0x00001005, "AE_BAD_ADDRESS"}, /* obsolete */
	Package() {33, 0x00001006, "AE_ALIGNMENT"}, /* obsolete */
	Package() {34, 0x00001005, "AE_BAD_HEX_CONSTANT"},
	Package() {35, 0x00001006, "AE_BAD_OCTAL_CONSTANT"},
	Package() {36, 0x00001007, "AE_BAD_DECIMAL_CONSTANT"},
	Package() {37, 0x00002001, "AE_BAD_SIGNATURE"},
	Package() {38, 0x00002002, "AE_BAD_HEADER"},
	Package() {39, 0x00002003, "AE_BAD_CHECKSUM"},
	Package() {40, 0x00002004, "AE_BAD_VALUE"},
	Package() {41, 0x00002005, "AE_TABLE_NOT_SUPPORTED"}, /* obsolete */
	Package() {42, 0x00002005, "AE_INVALID_TABLE_LENGTH"},
	Package() {43, 0x00003001, "AE_AML_ERROR"}, /* obsolete */
	Package() {44, 0x00003002, "AE_AML_PARSE"}, /* obsolete */
	Package() {45, 0x00003001, "AE_AML_BAD_OPCODE"},
	Package() {46, 0x00003002, "AE_AML_NO_OPERAND"},
	Package() {47, 0x00003003, "AE_AML_OPERAND_TYPE"},
	Package() {48, 0x00003004, "AE_AML_OPERAND_VALUE"},
	Package() {49, 0x00003005, "AE_AML_UNINITIALIZED_LOCAL"},
	Package() {50, 0x00003006, "AE_AML_UNINITIALIZED_ARG"},
	Package() {51, 0x00003007, "AE_AML_UNINITIALIZED_ELEMENT"},
	Package() {52, 0x00003008, "AE_AML_NUMERIC_OVERFLOW"},
	Package() {53, 0x00003009, "AE_AML_REGION_LIMIT"},
	Package() {54, 0x0000300a, "AE_AML_BUFFER_LIMIT"},
	Package() {55, 0x0000300b, "AE_AML_PACKAGE_LIMIT"},
	Package() {56, 0x0000300c, "AE_AML_DIVIDE_BY_ZERO"},
	Package() {57, 0x0000300d, "AE_AML_BAD_NAME"},
	Package() {58, 0x0000300e, "AE_AML_NAME_NOT_FOUND"},
	Package() {59, 0x0000300f, "AE_AML_INTERNAL"},
	Package() {60, 0x00003010, "AE_AML_INVALID_SPACE_ID"},
	Package() {61, 0x00003011, "AE_AML_STRING_LIMIT"},
	Package() {62, 0x00003012, "AE_AML_NO_RETURN_VALUE"},
	Package() {63, 0x00003014, "AE_AML_NOT_OWNER"},
	Package() {64, 0x00003015, "AE_AML_MUTEX_ORDER"},
	Package() {65, 0x00003016, "AE_AML_MUTEX_NOT_ACQUIRED"},
	Package() {66, 0x00003017, "AE_AML_INVALID_RESOURCE_TYPE"},
	Package() {67, 0x00003018, "AE_AML_INVALID_INDEX"},
	Package() {68, 0x00003019, "AE_AML_REGISTER_LIMIT"},
	Package() {69, 0x0000301a, "AE_AML_NO_WHILE"},
	Package() {70, 0x0000301b, "AE_AML_ALIGNMENT"},
	Package() {71, 0x0000301c, "AE_AML_NO_RESOURCE_END_TAG"},
	Package() {72, 0x0000301d, "AE_AML_BAD_RESOURCE_VALUE"},
	Package() {73, 0x0000301e, "AE_AML_CIRCULAR_REFERENCE"},
	Package() {74, 0x00004001, "AE_CTRL_RETURN_VALUE"},
	Package() {75, 0x00004002, "AE_CTRL_PENDING"},
	Package() {76, 0x00004003, "AE_CTRL_TERMINATE"},
	Package() {77, 0x00004004, "AE_CTRL_TRUE"},
	Package() {78, 0x00004005, "AE_CTRL_FALSE"},
	Package() {79, 0x00004006, "AE_CTRL_DEPTH"},
	Package() {80, 0x00004007, "AE_CTRL_END"},
	Package() {81, 0x00004008, "AE_CTRL_TRANSFER"},
	Package() {82, 0x00004009, "AE_CTRL_BREAK"},
	Package() {83, 0x0000400a, "AE_CTRL_CONTINUE"},

	/* New additional are here not to touch previous indexes */

	Package() {84, 0x00003013, "AE_AML_METHOD_LIMIT"},
	Package() {85, 0x0000100B, "AE_INDEX_TO_NOT_ATTACHED"},
	Package() {86, 0x0000001B, "AE_OWNER_ID_LIMIT"}}
)

/*
 * (multi-threading)
 *
 * Packages to store per-thread information about exceptions
 * (used in mt-mode)
 *
 * EXC2 - maximal number of exception can be registered
 * EX02 - package to store ID of thread where exception occurs
 * EX03 - package to store opcode of exception
 */
Name(EXC2, 200)
Name(EX02, Package(EXC2) {})
Name(EX03, Package(EXC2) {})

/*
 * Exceptional conditions handler
 *
 * arg0 - AcpiStatus
 * arg1 - AsciiExceptionString
 * arg2 - ID of current thread
 */
Method(_ERR, 3)
{
	Store(arg0, EX00)
	Store(arg1, EX01)

	if (LEqual(EX04, 0)) {
		Store(arg0, EX04)
		Store(arg1, EX05)
	}

	/* multi-threading */
	if (MTHR) {
		/* If the current number of exceptions handled doesn't exceed EXC2 */
		if (LLess(EXC0, EXC2)) {
			Store(arg2, Index(EX02, EXC0))
			Store(arg0, Index(EX03, EXC0))
		} else {
			Store("Maximal number of exceptions exceeded", Debug)
			err("_ERR", z063, 0, 0, 0, EXC0, EXC2)
		}
	}

	Increment(EXC0)
	Increment(EXC1)

//	Store("Run-time exception:", Debug)
//	Store(arg0, Debug)
//	Store(arg1, Debug)
//	Store(arg2, Debug)

	Return (0) // Map error to AE_OK
}

// Check that exceptions has not arisen at all
Method(CH02)
{
	if (EXC1) {
		Concatenate("Some unexpected exceptions were handled, 0x", EXC1, Local0)
		err("CH02", z063, 1, 0, 0, Local0, 0)
	}
	Return(EXC1)
}

/*
 * Check that the counter of current exceptions is zero. Set it to zero.
 * arg0 - diagnostic message
 * arg1 - absolute index of file initiating the checking
 * arg2 - index of checking
 * arg3 - arg5 of err, "received value"
 * arg4 - arg6 of err, "expected value"
 */
Method(CH03, 5)
{
	Store(0, Local7)

	if (EXC0) {
		Concatenate("Unexpected exceptions (count ", EXC0, Local0)
		Concatenate(Local0, "), the last is ", Local1)
		Concatenate(Local1, EX01, Local0)
		Concatenate(Local0, ", ", Local1)
		Concatenate(Local1, EX00, Debug)
		err(arg0, z063, 2, arg1, arg2, arg3, arg4)
		Store(EXC0, Local7)
	}
	Store(0, EXC0)
	Store(0, EX04)

	return (Local7)
}

//
// Convert 32/64 bit integer to 16-bit Hex value
//
Method(ST16, 1, Serialized)
{
    Name (EBUF, Buffer(ISZC){}) /* 8 or 16 bytes, depending on 32/64 mode */
    Name (RBUF, Buffer(4){})

    Store (ToHexString (Arg0), EBUF)
    Mid (EBUF, Subtract(ISZC, 4), 4, RBUF)
    Return (Concatenate ("0x", ToString (RBUF)))
}

/*
 * Check that exceptions are handled as expected, report errors
 * (if any) and set the current number of exceptions to zero.
 *
 * Verified:
 * - exception has arisen
 * - check the number of exceptions
 * - the last arisen exception matches one described by arguments
 *
 * arg0 - diagnostic message
 * arg1 -
 *   zero means:
 *        - check that only one exception has arisen (curent number is equal to 1)
 *        - check that opcode is equal to that specified by arg2
 *   non-zero means:
 *        - check that the number of exception arisen is not less than 1
 *          (curent number is equal to 1 or greater)
 *     1:   check that the first opcode is equal to that specified by arg2
 *     2:   check that the last opcode is equal to that specified by arg2
 *
 * arg2 - index of exception info in pf00 Package
 * arg3 - absolute index of file initiating the checking
 * arg4 - index of checking
 * arg5 - arg5 of err, "received value"
 * arg6 - arg6 of err, "expected value"
 */
Method(CH04, 7)
{
	Store(0, Local5)

	if (LEqual(arg2, 0xff)) {

	if (LEqual(EXC0, 0)) {
		Store(1, Local5)
		Store("ERROR: No ANY exception has arisen.", Debug)
	}

	} else {

	// Determine opcode and name of the expected exception

	Store(DeRefOf(Index (pf00, arg2)), Local2) // exception info
	Store(DeRefOf(Index (Local2, 1)), Local3)  // opcode
	Store(DeRefOf(Index (Local2, 2)), Local4)  // name

	if (LEqual(EXC0, 0)) {
		Store (1, Local5)
		Concatenate("No exception - expected: ", Local4, Local0)
		Concatenate(Local0, "-", Local0)
		Concatenate(Local0, ST16(Local3), Local0)
		Store(Local0, Debug)
	} else {
		if (LAnd(LNot(arg1), LGreater(EXC0, 1))) {
			Store(1, Local5)
			Concatenate("More than one exception: 0x", EXC0, Local0)
			Store(Local0, Debug)
		} else {
			if (LEqual(arg1, 1)) {
				/* Opcode of the first exception */
				Store(EX04, Local6)
				Store(EX05, Local7)
			} else {
				/* Opcode of the last exception */
				Store(EX00, Local6)
				Store(EX01, Local7)
			}

			if (LNotEqual(Local3, Local6)) {
				Store(1, Local5)
				Concatenate("Exception: ", Local7, Local0)

				Concatenate(Local0, "-", Local0)
				Concatenate(Local0, ST16(Local6), Local0)

				Concatenate(" differs from expected: ", Local4, Local1)
				Concatenate(Local0, Local1, Local0)

				Concatenate(Local0, "-", Local0)
				Concatenate(Local0, ST16(Local3), Local0)
				Store(Local0, Debug)
			}
			if (LNotEqual(Local4, Local7)) {
				Store(1, Local5)
				Store("Unexpected exception:", Debug)
				Store(Concatenate("Expected: ", Local4), Debug)
				Store(Concatenate("Received: ", Local7), Debug)
			}
		}
	}

	} /* if(LNotEqual(arg2,0xff)) */

	Store(0, EXC0)
	Store(0, EX04)

	if (Local5) {
		err(arg0, z063, 3, arg3, arg4, arg5, arg6)
	}

	return (Local5)
}

Method(CH05)
{
	return (CH03("CH05", 0, 0, 0, 0))
}

Method(CH06, 3)
{
	if (EXCV) {
		return (CH04(arg0, 0, arg2, 0, arg1, 0, 0))
	} else {
		// Just only presence of ANY exception(s)
		return (CH04(arg0, 0, 0xff, 0, arg1, 0, 0))
	}
}

/*
 * Check for any exception when the slack mode is initiated
 */
Method(CH07, 7)
{
	if (SLCK) {
		CH03(arg0, arg3, arg4, arg5, arg6)
	} else {
		CH04(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
	}
}


/* MULTI-THREADING */

/*
 * Report message of thread
 * (adds ID of thread and reports the message)
 *
 * arg0 - ID of current thread
 * arg1 - string
 */
Method(MSG0, 2)
{
	Concatenate("THREAD ID ", arg0, Local0)
	Concatenate(Local0, ": ", Local1)
	Concatenate(Local1, arg1, Local0)
	Store(Local0, Debug)
}

/*
 * Used in multi-threading mode
 *
 * Return the first encountered exception corresponding to this Thread ID
 * and the total number of exceptions corresponding to this Thread ID.
 * Reset all the entries corresponding to the thread identified by arg0.
 *
 * Note: this method is used in mt-mode (by several threads simultaneously)
 *       but each of threads changes only its elements of EX02.
 *
 * arg0 - ID of current thread
 */
Method(MTEX, 1)
{
	Store(Package(2) {0,0}, Local2) // Package to be returned
	Store(0, Local3) // found

	Store(EXC0, Local4) // lpN0
	Store(0, Local5)    // lpC0
	While (Local4) {

		Store(DeRefOf(Index(EX02, Local5)), Local0)

		/* Matching ID of current thread */
		if (LEqual(Local0, arg0)) {
			Store(DeRefOf(Index(EX03, Local5)), Local1)
			if (LEqual(Local3, 0)) {
				/* Opcode of the first exception */
				Store(Local1, Index(Local2, 0))
			}
			Increment(Local3)

			/* Reset information about this exception */
			Store(0, Index(EX02, Local5))
		}

		Decrement(Local4)
		Increment(Local5)
	}
	Store(Local3, Index(Local2, 1))

	return (Local2)
}

/*
 * The same as CH03, but to be used in multi-threading mode
 *
 * arg0 - diagnostic message
 * arg1 - ID of current thread
 * arg2 - absolute index of file initiating the checking
 * arg3 - index of checking
 * arg4 - arg5 of err, "received value"
 * arg5 - arg6 of err, "expected value"
 *
 * Return: current number of exceptions occur on this thread
 */
Method(CH08, 6)
{
	Store(MTEX(arg1), Local2)
	Store(DeRefOf(Index(Local2, 0)), Local3) // opcode of the first exception
	Store(DeRefOf(Index(Local2, 1)), Local4) // number of exceptions

	Store(0, Local7)

	if (Local4) {
		Concatenate("Unexpected exception 0x", Local3, Local0)
		Concatenate(Local0, ", number of exceptions 0x", Local1)
		Concatenate(Local1, Local4, Local0)
		MSG0(arg1, Local0)
		err(arg0, z063, 4, arg2, arg3, arg4, arg5)
		Store(1, Local7)
	}

	/*
	 * Reset of EXC0 should be done by Control thread
	 * Store(0, EXC0)
	 */

	return (Local4)
}

/*
 * The same as CH04, but to be used in multi-threading mode
 *
 * arg0 - non-zero means to treat "More than one exceptions" as error
 * arg1 - ID of current thread
 * arg2 - index of exception info in pf00 Package
 * arg3 - absolute index of file initiating the checking
 * arg4 - index of checking
 * arg5 - RefOf to Integer to return 'current number of exceptions occur on this thread'
 *
 * Return: non-zero when errors detected
 */
Method(CH09, 6)
{
	Store(MTEX(arg1), Local7)
	Store(DeRefOf(Index(Local7, 0)), Local6) // opcode of the first exception
	Store(DeRefOf(Index(Local7, 1)), Local7) // number of exceptions

	Store(0, Local5)

	if (LEqual(arg2, 0xff)) {
		if (LEqual(Local7, 0)) {
			/* No exceptions */
			Store(1, Local5)
			MSG0(arg1, "ERROR: No ANY exception has arisen.")
		}
	} else {

	// Determine opcode and name of the expected exception

	Store(DeRefOf(Index (pf00, arg2)), Local2) // exception info
	Store(DeRefOf(Index (Local2, 1)), Local3)  // opcode
	Store(DeRefOf(Index (Local2, 2)), Local4)  // name

	if (LEqual(Local7, 0)) {
		/* No exceptions */
		Store (1, Local5)
		Concatenate("No exception has arisen, expected: ", Local4, Local0)
		Concatenate(", opcode 0x", Local3, Local1)
		Concatenate(Local0, Local1, Local0)
		MSG0(arg1, Local0)
	} else {
		if (LAnd(arg0, LGreater(Local7, 1))) {
			Store(1, Local5)
			Concatenate("More than one exception has arisen: 0x", Local7, Local0)
			MSG0(arg1, Local0)
		} else {

			/* Opcode of the first exception */

			if (LNotEqual(Local3, Local6)) {
				Store(1, Local5)
				Concatenate("The exception 0x", Local6, Local0)
				Concatenate(Local0, " differs from expected ", Local1)
				Concatenate(Local1, ST16 (Local3), Local0)
				MSG0(arg1, Local0)
			}
		}
	}

	} /* if(LNotEqual(arg2,0xff)) */

	/*
	 * Reset of EXC0 should be done by Control thread
	 * Store(0, EXC0)
	 */

	if (Local5) {
		err("", z063, 5, arg3, arg4, 0, 0)
	}

	Store(Local7, arg5)

	return (Local5)
}

/*
 * Reset EXC0 (the current number of exceptions handled)
 *
 * It should be invoked by the Control thread.
 */
Method(CH0A)
{
	Store(0, EXC0)
}
