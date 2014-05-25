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
 * Run Tests Parameters Technique (RTPT)
 *
 * Tese parameters have effect only when
 * running a group of tests (collections)
 * such as all Functional tests, all Complex
 * tests, all Exceptions tests, Full test
 * (all enumerated above tests).
 *
 * Main flag:
 * 0 - run unconditionally all tests
 * 1 - run all the tests whit non-zero params
 * 2 - run all the tests whit zero params
 * 3 - run all the tests whit params equal to RUN1
 * 4 - run one the particular test specified so:
 *     RUN2 - index of collection
 *     RUN3 - index of the test inside the collection
 */
Name(RUN0, 0)	// main flag
Name(RUN1, 0)	// level
Name(RUN2, 0)	// collection
Name(RUN3, 0)	// test
Name(RTPT, 0)	// validity of RTPT mode

// FUNCTIONAL

Name(W000, 0) // arithmetic
Name(W001, 0) // bfield
Name(W002, 0) // constant
Name(W003, 0) // control
Name(W004, 0) // descriptor
Name(W005, 0) // extern
Name(W006, 0) // local
Name(W007, 0) // logic
Name(W008, 0) // manipulation
Name(W009, 0) // name
Name(W00a, 0) // reference
Name(W00b, 0) // region
Name(W00c, 0) // synchronization
Name(W00d, 0) // table

// COMPLEX

Name(W00e, 0) // misc
Name(W00f, 0) // provoke
Name(W010, 0) // operand
Name(W011, 0) // result
Name(W012, 0) // namespace
Name(W022, 0) // badasl

// EXCEPTIONS

Name(W013, 0) // exc
Name(W014, 0) // exc_operand
Name(W015, 0) // exc_result
Name(W016, 0) // exc_ref

// DEMO

Name(W017, 0) // Bugs (0-N)

// IMPL

Name(W021, 0) // dynobj

// SERVICE

Name(W018, 0) // condbranches

// Identity2MS

Name(W019, 0) // abbu

// Reserved names

Name(W020, 0)

/*
 * Set RTPT technique.
 * Should be invoked in MAIN files of
 * ALL functional, complex, exceptions,...
 */
Method(SRTP, 1) {
	Store(arg0, RTPT)
}


/*
 * Set up the particular desirable set of tests to be run
 *
 * Tese parameters have effect only when
 * running a group of test cases or even
 * collections) such as all Functional tests,
 * all Complex tests, all Exceptions tests,
 * Full test (all enumerated above tests)
 * compiled all as one DefinitionBlock.
 *
 * Parameters:
 *
 * RUN0 - main flag
 * 0 - run unconditionally all tests
 * 1 - run all the tests whit non-zero params
 * 2 - run all the tests whit zero params
 * 3 - run all the tests whit params equal to RUN1
 * 4 - run one the particular test specified in this way:
 *     RUN2 - index of collection
 *            1 - functional
 *            2 - complex
 *            3 - exceptions
 *     RUN3 - index of the test inside the collection
 * RUN1 - level
 * RUN2 - collection
 * RUN3 - test
 */
Method(RTPI) {

// PARAMETRES OF MODE

Store(0, RUN0) // main flag
Store(0, RUN1) // level
Store(1, RUN2) // collection
Store(3, RUN3) // test

// FUNCTIONAL, collection # 1

Store(1, W000) // arithmetic        0
Store(1, W001) // bfield            1
Store(1, W002) // constant          2
Store(1, W003) // control           3
Store(1, W004) // descriptor        4
Store(1, W005) // extern            5
Store(1, W006) // local             6
Store(1, W007) // logic             7
Store(1, W008) // manipulation      8
Store(1, W009) // name              9
Store(1, W00a) // reference        10
Store(1, W00b) // region           11
Store(1, W00c) // synchronization  12
Store(1, W00d) // table            13

// COMPLEX, collection # 2

Store(1, W00e) // misc              0
Store(1, W00f) // provoke           1
Store(1, W010) // operand           2
Store(1, W011) // result            3
Store(1, W021) // dynobj            4
Store(1, W012) // RESERVED, not in use

// EXCEPTIONS, collection # 3

Store(1, W013) // exc               0
Store(1, W014) // exc_operand       1,2
Store(1, W015) // exc_result        3,4
Store(1, W016) // exc_ref           5
Store(1, W019) // exc_tbl           6

// DEMO

Store(1, W017) // Bugs (0-N)		0

// SERVICE

Store(1, W018) // condbranches	0
}

/*
 * Variables below allow to exclude code which causes crashes
 * or hangs or prevents execution of other tests.
 *
 * ATTENTION: all these variables should be set to 1 eventually
 *            (after all bugs fixing).
 *
 * Lyout of variable name: y<xxx> - xxx is the number of bug
 *        0 - dont run
 * non-zero - run
 *
 * ATTENTION: see all the qXXX & rnXX conditions of the particular
 *            tests (which also provide the temporary exclusion).
 *
 * ATTENTION: all disablings must go through this technique of
 *            y<xxx> disable/enable variables.
 *
 * y<xxx>   - prevents undesirable consequences of the surrounded
 *            code (crashes, hangs etc. of tests). Should be finally
 *            set to non-zero (after the product-bug fixing) so
 *            enabling execution of the surrounded code.
 * X<xxx>   - surrounds particular Bugs. Used mostly to point out
 *            the reasons of test failures (xxx - number of bug)
 *            not to review the results of tests each time anew.
 *            So, as a rule these variables are set to non-zero.
 */

/*
 * Bugs
 */
Name(y078, 0)
Name(y083, 0)
Name(y084, 1)
Name(y098, 1)
Name(y100, 0)
Name(y103, 1)
Name(y104, 1)
Name(y105, 1)
Name(y106, 0)
Name(y111, 1)
Name(y113, 0)
Name(y114, 0)
Name(y118, 0)	// elements of Package are NamedX, failed access to Field Unit and Buffer Field
Name(y119, 0)
Name(y120, 0)
Name(y121, 0)
Name(y126, 0)
Name(y127, 0)	// Automatic dereference of Index in CopyObject
Name(y128, 1)
Name(y132, 0)
Name(y133, 0)	// Write access automatic dereference for Index reference
Name(y134, 0)
Name(y135, 0)
Name(y136, 1)	// CopyObject(A, B) for Buffers causes implicit
Name(y157, 1)	// problems when ParameterTypes declaration data omitted
Name(y164, 1)	// tests m22d and m26b of reference test
Name(y176, 0)
Name(y178, 1)	// Non-constant Bank values works since ACPICA release 20071211
Name(y182, 1)
Name(y192, 1)	// AcpiExec is able to emulate access to BankField Objects since ACPICA release 20071211
Name(y200, 0)	// The code path taken after exception in AcpiPsParseLoop is incorrect
Name(y203, 0)	// ObjectType operation falls into infinite loop for ring of RefOf references
Name(y204, 0)	// SizeOf operation falls into infinite loop for ring of RefOf references
Name(y205, 0)	// Store-to-Debug operation falls into infinite loop for ring of RefOf references
Name(y206, 0)	// ObjectType operation falls into infinite loop for ring of Index references
Name(y207, 0)	// SizeOf operation falls into infinite loop for ring of Index references
Name(y208, 0)	// Store-to-Debug operation falls into infinite loop for ring of Index references
Name(y213, 0)	// Crash
Name(y214, 0)	// Crash on repeated duplication of an OpRegion by CopyObject
Name(y215, 0)	// Exception AE_BUFFER_OVERFLOW when IndexName Field exceeds 32 bits
Name(y216, 0)	// exception AE_NOT_FOUND on CreateField under specific conditions
Name(y217, 0)	// Dynamic OpRegion _REG method execution problem
Name(y220, 0)	// Inconsistent "Access is available/unavailable" _REG method calls
Name(y221, 1)	// Alternating access to OpRegions covering different ranges
Name(y222, 0)	// Alternating access to OpRegions of different Address Spaces
Name(y223, 1)	// DataTableRegion with the non-constant *Strings works since ACPICA release 20071211
Name(y224, 0)	// AcpiExec is unable to emulate access to IndexField Objects
Name(y238, 0)	// the jumping over levels in releasing mutexes is not prohibited
Name(y242, 0)	// Releasing the mutex the first Acquired on the non-zero level makes Releasing the residuary mutexes of that level impossible
Name(y243, 0)	// the normal work with mutexes is broken after the mutex Release order violation
Name(y248, 0)	// Incorrect ReferenceCount on Switch operation
Name(y251, 0)	// AE_ALREADY_EXISTS on multi-threading on Switch operator
Name(y260, 0)	// For a DDBHandle Object ObjectType unexpectedly results in AE_AML_INTERNAL
Name(y261, 0)	// Crash when DDBHandle parameter of Load is an Indexed Reference
Name(y262, 0)	// Unexpected AE_STACK_OVERFLOW for a method call expression with nested calls
Name(y263, 0)	// The sequence of evaluating operands of expression with the named objects is violated
Name(y264, 0)	// Crash on re-writing named element of Package
Name(y275, 0)	// Pop result from bottom principle doesn't work
Name(y276, 0)	// 'Large Reference Count' on AML code with LoadTable/UnLoad in a slack mode
Name(y281, 0)	// Normal strings as the LoadTable parameters can cause the matching table to be not found
Name(y282, 0)	// Crash when the Buffer Object parameter of Load is used after an exception in it
Name(y283, 1)	// When the Object parameter of Load is a Field the checksum of the supplied SSDT should be verified
Name(y284, 1)	// An exception should be emitted on Load if the Length field of SSDT exceeds length of its source
Name(y286, 1)	// After an exception the elements of the Package passed to Unload are unexpectedly deleted
Name(y287, 0)	// If any string to match a proper field on LoadTable exceeds field's length an exception should be emitted
Name(y288, 0)	// iASL unexpectedly forbids ParameterData of Loadtable to be LocalX or UserTerm
Name(y289, 0)	// Search of the table matched Loadtable parameters should be restricted to XSDT
Name(y290, 0)	// AcpiExec is unable to emulate Load from OpRegion
Name(y292, 0)	// Different second and third UnLoad execution with the same argument behavior
Name(y293, 0)	// Incorrect zero-length Buffer to String conversion
Name(y294, 0)	// _ERR method can not be evaluated when AE_OWNER_ID_LIMIT is emitted
Name(y296, 0)	// AE_AML_INTERNAL unexpectedly occurs when the Loadtable ParameterData and its Target differ in the types
Name(y297, 0)	// After AE_LIMIT the further work of ACPICA mutex framework looks unstable
Name(y300, 0)	// Recursive calls to methods with the internal names (and Switches) should be provided
Name(y301, 0)	// Recursive call on the same thread to the Serialized method with the internal objects (Swithces) causes AE_AML_INTERNAL
Name(y302, 0)	// Scope operation doesn't work for the root node Location


/*
 * Issues (replace them with the Bug indexes)
 */

Name(y349, 0)	// to clarify what is the proper behaviour when Serialized Method is invoked recursively (now hangs)
Name(y350, 0)	// TermalZone AE_AML_NO_RETURN_VALUE exception
Name(y361, 0)	// OperationRegion in Result tests
Name(y362, 0)	// Investigate and uncomment m4ba

Name(y364, 0)	// if (Derefof(Refof(bf76))) exception in m61b-m06e
Name(y365, 0)	// Increment(Derefof(Refof(bf76))) exception in m61b-m64l
Name(y366, 0)	// exception on Store(Package, Derefof(Arg(Int/Str/Buf)))
Name(y367, 0)	// Increment(Refof(Named))) exception in m692-m00b


Name(y500, 0)	// Deletion of Named Object due to DeRefOf(m000())
Name(y501, 0)	// Increment/Decrement for String/Buffer Named Object
Name(y502, 0)	// Exceptions on DeRefOf(Index(p000, 0))
Name(y503, 0)	// AE_AML_OPERAND_TYPE => AE_AML_NO_RETURN_VALUE
Name(y504, 0)	// Exception on CopyObject(ThermalZone, ...)
Name(y505, 0)	// Buffer Field and Field Unit types should allow SizeOf()
Name(y506, 0)	// exc_ref: crash for DerefOf
Name(y507, 0)	// ref: read of ArgX-RefOf_References without DerefOf
Name(y508, 0)	// all about ThermalZone
Name(y509, 0)	// all about Method
Name(y510, 0)	// all about OperationRegion
Name(y511, 0)	// all about Device
Name(y512, 0)	// the checking causes unexpected exception
Name(y513, 0)	// m005(Index(s021, 1, Local0), RefOf(i020))
			// m005(RefOf(i000), RefOf(i061))
Name(y514, 0)	// repeated attempts to overwrite RefOf_Reference-ArgX cause exceptions
// Name(y515, 0)	// Uninitialized element of Package (the same as y127)
Name(y516, 0)	// write from {Integer/String/Buffer} to Package
Name(y517, 0)	// Buffer Field (and Field Unit) as elements of Package
Name(y518, 0)	// utdelete-0487 [07] UtUpdateRefCount : **** Warning
			// **** Large Reference Count (EAEA) in object 00466BC8
Name(y519, 0)	// ArgX term effectively becomes a LocalX term
			// Store(x,ArgX-Object) should be identical to Store(x,LocalX)
Name(y520, 0)	// ArgX term effectively becomes a LocalX term
			// CopyObject(x,ArgX-Object) should be identical to CopyObject(x,LocalX)
			// Now, DerefOf(arg0) causes exception
Name(y521, 0)	// Store reference to NamedX
Name(y522, 0)	// CopyObject reference to NamedX
Name(y523, 0)	// Store(RefOf(NamedX), NamedX)
Name(y524, 0)	// Store(RefOf(NamedX), DerefOf(Expr_resulting_in_ORef))
Name(y525, 0)	// Store(RefOf(NamedX), RefOf(Named_X))
Name(y526, 0)	// CopyObject(RefOf(NamedX), ArgX-ORef-to-Named_X)
Name(y527, 0)	// The code path taken after AE_OWNER_ID_LIMIT is incorrect


Name(y600, 0)	// Some oprators (not all) doesn't provide passing invocation
			// of Method as a parameter to them (though iASL succeeds).
			// Looks that Method is simply not invoked. But, since it doesn't
			// now look as an important feature for those particular operators
			// we don't file bug in this respect but exclude tesing.
Name(y601, 0)	// The Reference issues to be thought over in the future
Name(y602, 1)	// generalized - new specs of String to Integer conversion
Name(y603, 0)	// bunch of anomalies with references to be splited to separate bugs,
			// mostly - cyclical references (rings of references).

Name(y900, 0)	// Allow immediate Index(Buffer(){}), Index("qwerty"), Index(Package(){})
Name(y901, 1)	// Predicate generates Implicit Return
Name(y902, 1)	// Expected is that Serialized method being invoked recursively on the same thread:
			// 1) 0 - doesn't cause
			// 2) otherwise - causes
			// exception in case it has either internal objects (including Methods) or Switches


/*
 * functional/reference
 *
 * Exclude temporary the relevant checking.
 *
 * All them should be set to non-zero after
 * clarifying the relevant issue, or provided
 * with the comment clarifying what is wrong in
 * the sub-test - dont remove them even in the
 * latter case.
 */
Name(q001, 1) // Dereference of Store(Index(x,x,Index(x,x)), Index(x,x))
Name(q002, 0) // The chain of Index_References
Name(q003, 0) // CURRENTLY: compiler failed CopyObject(xx, Index(xx,xx))

Name(q004, 0) // Implicit Operand conversion on MS contradicts ACPI Spec
Name(q005, 0) // Method object as a Source of Index operation is treated as a call to that Method
Name(q006, 0) // on MS Name of an Object as an element of Package is treated as String
Name(q007, 0) // Disregard of the length Buffer Fields on MS are read as Buffers
Name(q008, 0) // On MS Store to LocalX containing a reference causes indirect access
Name(q009, 0) // It looks like on MS writing to a narrow Field Unit is splited on pieces
Name(q00a, 0) // On MS writing to unmodified bits of Field OpRegion implemented differently
Name(q00b, 0) // On MS Break in Switch is not implemented

/*
 * The non-zero value flags allow to run the relevant part of sub-tests.
 *
 * Each sub-test is conditioned by some rn0*.
 *
 * ATTENTION: many sub-tests conditioned by rn01-rn04 are not run now
 *            in general mode, they should be investigated.
 */
Name(rn00, 1) // Correct, no any remarks
Name(rn01, 0) // Investigation needed
Name(rn02, 0) // Classified as a bug
Name(rn03, 0) // Causes exception
Name(rn04, 0) // Regression


Name(rn05, 0) // Long-time tests of bug-demo collection
Name(rn06, 0) // 1 - CopyObject and Store of Method doesn't evaluate that Method

/*
 * Indicators of bugs.
 */
Name(X104, 1)

Name(X114, 1)
Name(X127, 1)
Name(X128, 1)
Name(X131, 1)
Name(X132, 1)
Name(X133, 1)
Name(X153, 1) // Store() to Named Target allows to update the Source
Name(X170, 1)
Name(X191, 1)
Name(X192, 1)
Name(X193, 1) // 32-bit mode optional storing of Not, NAnd, or NOr
		  // ASL operators result to Buffer Field produces 64-bit
Name(X194, 1) // Unexpected implicit result object conversion when the
		  // Target operand of ToBuffer operator is a Named Buffer
Name(X195, 0) // Increment and Decrement of an either String or Buffer
		  // Object will not change the type of the Object to Integer (~ y501)


/*
 * Flag, allows (when non-zero) access to the internal objects of method.
 *
 * No entry of type Method should occur in the declared path specified for search.
 */
Name(FLG9, 0)

/*
 * Set up run4 to non-zero when compile aslts (affects actually only Identity2MS)
 * for to run on MS, and reset it to zero when compile to run on ACPICA
 *
 *   for ACPICA - 0
 *   for MS     - non-zero
 */
Name(run4, 0)

/*
 * Current release of ASLTS test suite
 *
 * Layout:
 *   now simply incremental number
 *
 * Releases:
 *
 *   31.12.2004 - 1
 *   31.07.2005 - 2
 *   16.11.2005 - 3
 *   21.07.2006 - 4, (1115 files), with ACPICA version 20060721 released
 *   25.12.2006 - 5, (1277 files, 382 folder, 15.3 MB, 2006 tests, 38(44) test cases, 278 bugs of ACPICA)
 *   01.03.2007 - 6, (1403 files, 415 folder, 17.0 MB, 2227 tests, 40(46) test cases, 305 bugs of ACPICA)
 *   21.03.2007 - 7, (1409 files, 417 folder, 17.1 MB, 2236 tests, 40(46) test cases, 307 bugs of ACPICA)
 *   December 2011: - 0x15 (ACPI 5.0)
 *   April 2011: - 0x16, iASL fix for StartDependentFunction* descriptors to account for descriptor length.
 */
Name(REL0, 0x16)

/*
 * Settings number, used to adjust the aslts tests for different releases of ACPICA
 *
 * SETN - settings number of aslts:
 *        0 - release from Bob
 *        1 - release from Bob + my updates
 *        2 - new architecture of Method calculation
 *        3 - fixed bug 263,266
 *        4 - fixed bugs 275,276
 *        5 - fixed bugs 262 (corresponds to the 20070320 release of ACPICA)
 *        6 - 20074403
 *        all the greater - not used yet
 *
 * Used for to adjust some skippings of tests for different ACPICA releases
 * (set up this value manually). See Method SET2 below.
 *
 * Note: the value 5 of SETN corresponds to the 20070320 release of ACPICA.
 */
Name(SETN, 5)

/*
 * Adjust some skippings of tests for different ACPICA releases
 *
 * arg0 - settings number of aslts (see SETN for comment)
 */
Method(SET2, 1, Serialized) {

	Store(arg0, Local0)

/*
	if (ABUU) {
		Store(0, Local0)
	} else {
		Store(arg0, Local0)
	}
*/

	Switch (ToInteger (Local0)) {
	Case (0) {
		Store(0, y135)
		Store(1, y900)
		Store(0, y901)
		Store(1, FLG9)
		Store(0, y263)
		Store(0, y275)
		Store(0, y276)
	}
	Case (1) {
		Store(1, y135)
		Store(0, y900)
		Store(0, y901)
		Store(1, FLG9)
		Store(0, y263)
		Store(0, y275)
		Store(0, y276)
	}
	Case (2) {
		Store(0, y135)
		Store(0, y900)
		Store(1, y901)
		Store(0, FLG9)
		Store(0, y263)
		Store(0, y275)
		Store(0, y276)
	}
	Case (3) {
		Store(0, y135)
		Store(1, y900)
		Store(0, y901)
		Store(1, FLG9)
		Store(1, y263)
		Store(0, y275)
		Store(0, y276)
		Store(0, y262)
	}
	Case (4) {
		Store(0, y135) // Store of Index reference to another element of the same Package causes hang
		Store(1, y900) // Allow immediate Index(Buffer(){}), Index("qwerty"), Index(Package(){})
		Store(0, y901) // Predicate generates Implicit Return
		Store(1, FLG9) // Non-zero allows accessing internal objects of method
		Store(1, y263) // The sequence of evaluating operands of expression with the named objects is violated
		Store(1, y275) // Pop result from bottom principle doesn't work
		Store(1, y276) // 'Large Reference Count' on AML code with LoadTable/UnLoad in a slack mode
		Store(0, y262) // Unexpected AE_STACK_OVERFLOW for a method call expression with nested calls
		Store(0, y251) // AE_ALREADY_EXISTS on multi-threading on Switch operator
		Store(0, y300) // Recursive calls to methods with the internal names (and Switches) should be provided
	}
	Case (5) {
		Store(0, y135)
		Store(1, y900)
		Store(1, y901) // Predicate generates Implicit Return since ACPICA release 20080926
		Store(1, FLG9)
		Store(1, y263)
		Store(1, y275)
		Store(1, y276)
		Store(1, y262)
		Store(0, y251)
		Store(0, y300)
	}
	Case (6) {
		Store(0, y135)
		Store(1, y900)
		Store(0, y901)
		Store(1, FLG9)
		Store(1, y263)
		Store(1, y275)
		Store(1, y276)
		Store(1, y262)
		Store(1, y251)
		Store(1, y300)
		Store(0, y902)
	}

	}

	if (LNot(run4)){
		Concatenate("Release of parent ACPICA code 0x", Revision, Debug)
		Concatenate("Release of ASLTS test suite  0x", REL0, Debug)
		Concatenate("Settings of ASLTS test suite 0x", arg0, Debug)
	}
}
