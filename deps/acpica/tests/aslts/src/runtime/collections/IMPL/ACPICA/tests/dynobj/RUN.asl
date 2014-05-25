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
 * The Dynamic Object Deletion complex test
 *
 * The complex test reflects the current dynamic of using the memory
 * for ASL objects and will be reporting any change in this process.
 * It is based on _TCI interface provided by ACPI implementation.
 * In case, _TCI is not supported, the test is quit.
 */

// Run-method
Method(DYN0,, Serialized)
{
	Name(ts, "DYN0")

	Name(pp00, Package(1) {})
	Name(pp0a, Package(1) {})

	// Create and initialize the Memory Consumption Statistics Packages

	Store(m3a0(c200), Local0)	// _TCI-end statistics
	Store(m3a0(c201), pp0a)		// _TCI-begin statistics
	Store(m3a0(0), Local1)		// difference

	Store("Check for the Test Command Interface with the ACPICA (_TCI) support", Debug)

	if (LNot(m3a5())) {
		Store("The Test Command Interface with the ACPICA (_TCI) is not supported", Debug)
		Store("Test DYN0 skipped!", Debug)
		return (1)
	}

	Store("Check that the Memory Consumption Statistics is handled properly", Debug)

	// Check that the Memory Consumption Statistics
	// is handled properly - the difference between
	// two _TCI-end statistics and _TCI-begin statistics
	// must be zero.

	_TCI(c200, Local0)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	if (m3a4(Local0, pp0a, Local1, pp00, 0, 0, 185)) {
		Store("the Memory Consumption Statistics is not properly handled", Debug)
		Store("Test DYN0 skipped!", Debug)
		return (1)
	}

	// Determine the flag of optimization

	m3aa()

	if (LEqual(FOPT, 1)) {
		Store("Optimization is tuned on", Debug)
	} elseif (LEqual(FOPT, 0)) {
		Store("Optimization is tuned off", Debug)
		Store("The tests are not yet adopted for this mode!", Debug)
		Store("Test DYN0 skipped!", Debug)
		return
	} else {
		Store("Test DYN0 skipped!", Debug)
		return
	}

/*
 *	// Apply the same technique to the entire test.
 *
 *	// ################################## Check all the test:
 *
 *	// Packages for _TCI statistics
 *	Name(LLL0, Package(1) {})
 *	Name(LLL1, Package(1) {})
 *	Name(LLL2, Package(1) {})
 *
 *	// Create and initialize the Memory Consumption Statistics Packages
 *
 *	Store(m3a0(c200), LLL0)	// _TCI-end statistics
 *	Store(m3a0(c201), LLL1)	// _TCI-begin statistics
 *	Store(m3a0(0), LLL2)	// difference
 *
 *	_TCI(c200, LLL0)
 *	// ################################## Check all the test.
 */

	// Run the tests

if (1) {
	SRMT("dobexec-m370")
	m370()
	SRMT("dobexec-m371")
	m371()
	SRMT("dobctl-m372")
	m372()
	SRMT("dobdecl-m373")
	m373()
	// SRMT("dobexceptions-m374")
	// m374()
	// SRMT("dobmisc-m375")
	// m375()
} else {
	SRMT("dobdecl-m373")
	m373()
}

/*
 *	// ################################## Check all the test:
 *	_TCI(c201, LLL1)
 *	m3a3(LLL0, LLL1, LLL2)
 *	m3a4(LLL0, LLL1, LLL2, 0, 0, 0, 0xff1)
 *	// ################################## Check all the test.
 */


	return (0)
}

if (STTT("Dynamic Object Deletion implementation dependent test", TCLI, 0, W021)) {
	SRMT("DYN0")
	DYN0()
}
FTTT()
