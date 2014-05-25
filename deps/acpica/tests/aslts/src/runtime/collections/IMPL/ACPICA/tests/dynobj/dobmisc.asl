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
 * DynObj: miscellaneous tests
 */

Name(z140, 140)

Method(m375,, Serialized)
{
	// The Created Objects benchmark Package
	Name(pp00, Package(1) {})

	// The Deleted Objects benchmark Package
	Name(pp01, Package(1) {})

	// The per-memory type benchmark Package
	Name(pp02, Package(1) {})

	// Package for _TCI-begin statistics
	// (use NamedX, dont use ArgX/LocalX).
	Name(pp0a, Package(1) {})

	// Create and initialize the Memory Consumption Statistics Packages

	Store(m3a0(c200), Local0)	// _TCI-end statistics
	Store(m3a0(c201), pp0a)		// _TCI-begin statistics
	Store(m3a0(0), Local1)		// difference

	SET0(z140, "m375", 0)

	/* Start of all sub-tests */


	Store("Test misc 0", Debug)

	_TCI(c200, Local0)

	// ASL-construction being investigated

/* to be implemented, now arbitrary operation only */

	Store(Add(0, 1), Local2)

	// Use NamedX for _TCI-begin statistics Package
	// not to touch the LOCAL_REFERENCE entry.
	_TCI(c201, pp0a)

	m3a3(Local0, pp0a, Local1) // calculate difference

	// Verify result

/* Is not correct yet !!! */

	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer

	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 4)

	/* End of all sub-tests */

	RST0()
}
