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
 * DynObj: executable ASL operators
 */

Name(z129, 129)

// The sample test
Method(m370,, Serialized)
{
	// Flag of printing
	Name(pr, 0)

	// Check that _TCI is supported
	if (LNot(m3a5())) {
		Store("The Test Command interface with the ACPICA (_TCI) is not supported", Debug)
		Store("Test m370 skipped", Debug)
		return (1)
	}

	// The benchmark Package
	Name(pp00, Package() {
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,
		0,0})

	// Package for _TCI-begin statistics
	// (use NamedX, dont use ArgX/LocalX).
	Name(pp0a, Package(1) {})

	// Auxiliary objects for ASL-construction
	// being investigated:

	Name(num, 5)
	Name(lpN0, 0)
	Name(lpC0, 0)

	// Create and initialize the Memory Consumption Statistics Packages

	Store(m3a0(c200), Local0)	// _TCI-end statistics
	Store(m3a0(c201), pp0a)		// _TCI-begin statistics
	Store(m3a0(0), Local1)		// difference

	// Available free locals

	Store(0, Local2)
	Store(0, Local3)
	Store(0, Local4)
	Store(0, Local5)
	Store(0, Local6)
	Store(0, Local7)


	// ======================== While

if (rn00) {

	Store("While", Debug)

	Store(num, lpN0)
	Store(0, lpC0)

	_TCI(c200, Local0)

	// ASL-construction being investigated

	While (lpN0) {
		Decrement(lpN0)
		Increment(lpC0)
	}

	// Use NamedX for _TCI-begin statistics Package
	// not to touch the LOCAL_REFERENCE entry.

	_TCI(c201, pp0a)

	// Print out the _TCI-end statistics
	// and _TCI-begin statistics Packages

	if (pr) {
		m3a2(Local0, 0)
		m3a2(pp0a, 1)
	}

	// Calculate difference of Packages

	m3a3(Local0, pp0a, Local1)

	// Print out the difference between the two
	// Memory Consumption Statistics Packages.

	if (pr) {
		m3a2(Local1, 2)
	}

	// Verify result

	Store(m3a8(), Local4)
	Multiply(2, num, Local5)
	Store(Local5, Index(Local4, c009))

	m3a4(Local0, pp0a, Local1, Local4, 0, 0, 0)
}

	return (0)
}

// Check simple particular operations
Method(m371,, Serialized)
{
	// Because Local0-7 all have been taken, we declare a new variable here.
	Name(temp,0)
	// The Created Objects benchmark Package
	Name(pp00, Package(1) {})

	// The Deleted Objects benchmark Package
	Name(pp01, Package(1) {})

	// The per-memory type benchmark Package
	Name(pp02, Package(1) {})


	// Package for _TCI-begin statistics
	// (use NamedX, dont use ArgX/LocalX).
	Name(pp0a, Package(1) {})

	// Objects for verified operators

	Mutex(MT00, 0)
	Event(EV00)
	Name(i000, 0)
	Name(i001, 0)
	Name(i002, 0)
	Name(i003, 0)
	Name(num, 5)
	Name(lpN0, 0)
	Name(lpC0, 0)

	Name(b000, Buffer(8) {})
	Name(b001, Buffer(8) {})
	Name(b002, Buffer(8) {})
	Name(b003, Buffer(1) {})
	Name(b004, Buffer(8) {})

	Name(rtp0, ResourceTemplate () { IRQNoFlags () {1} })
	Name(rtp1, ResourceTemplate () { IRQNoFlags () {1} })

	Name(p001, Package(8) {1,2,3,4,5,6,7,8})
	Name(p002, Package(8) {1,2,3,4,5,6,7,8})

	Name(s000, "s")
	Name(s001, "x")
	Name(s002, "swqrtyuiopnm")


	// Optional Results, writing into uninitialized LocalX

	// Add
	Method(m000,, Serialized)
	{
		Name(pp00, Package(1) {})
		Name(pp01, Package(1) {})
		Name(pp02, Package(1) {})
		Name(pp0a, Package(1) {})

		Store(m3a0(c200), Local0)	// _TCI-end statistics
		Store(m3a0(c201), pp0a)		// _TCI-begin statistics
		Store(m3a0(0), Local1)		// difference

		_TCI(c200, Local0)
//		Store(Add(3, 4, Local2), i000)
		Add(3, 4, Local2)
		_TCI(c201, pp0a)

		m3a3(Local0, pp0a, Local1)

		Store(m3a8(), pp00)
		Store(3, Index(pp00, c009)) // Integer
		Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

		Store(m3a8(), pp01)
		Store(2, Index(pp01, c009)) // Integer
		Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

		// Since Local2 was uninitialized,
		// acq0 is greater than rel0 by 1.
		Store(m3a9(), pp02)
		Store(1, Index(pp02, c228)) // CLIST_ID_OPERAND

		m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 1)
	}

	// And
	Method(m001,, Serialized)
	{
		Name(pp00, Package(1) {})
		Name(pp01, Package(1) {})
		Name(pp02, Package(1) {})
		Name(pp0a, Package(1) {})

		Store(m3a0(c200), Local0)	// _TCI-end statistics
		Store(m3a0(c201), pp0a)		// _TCI-begin statistics
		Store(m3a0(0), Local1)		// difference

		_TCI(c200, Local0)
//		Store(And(3, 4, Local2), i000)
		And(3, 4, Local2)
		_TCI(c201, pp0a)

		m3a3(Local0, pp0a, Local1)

		Store(m3a8(), pp00)
		Store(3, Index(pp00, c009)) // Integer
		Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

		Store(m3a8(), pp01)
		Store(2, Index(pp01, c009)) // Integer
		Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

		// Since Local2 was uninitialized,
		// acq0 is greater than rel0 by 1.
		Store(m3a9(), pp02)
		Store(1, Index(pp02, c228)) // CLIST_ID_OPERAND

		m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 2)
	}

	// Store
	Method(m002,, Serialized)
	{
		Name(pp00, Package(1) {})
		Name(pp01, Package(1) {})
		Name(pp02, Package(1) {})
		Name(pp0a, Package(1) {})

		Store(m3a0(c200), Local0)	// _TCI-end statistics
		Store(m3a0(c201), pp0a)		// _TCI-begin statistics
		Store(m3a0(0), Local1)		// difference

		_TCI(c200, Local0)
		Store("ssss", Local2)
		_TCI(c201, pp0a)

		m3a3(Local0, pp0a, Local1)

		Store(m3a8(), pp00)
		Store(2, Index(pp00, c00a)) // String
		Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

		Store(m3a8(), pp01)
		Store(1, Index(pp00, c00a)) // String
		Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

		// Since Local2 was uninitialized,
		// acq0 is greater than rel0 by 1.
		Store(m3a9(), pp02)
		Store(1, Index(pp02, c228)) // CLIST_ID_OPERAND

		m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 3)
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

	// Create and initialize the Memory Consumption Statistics Packages

	Store(m3a0(c200), Local0)	// _TCI-end statistics
	Store(m3a0(c201), pp0a)		// _TCI-begin statistics
	Store(m3a0(0), Local1)		// difference

	// Available free locals

	Store(0, Local2)
	Store(0, Local3)
	Store(0, Local4)
	Store(0, Local5)
	Store(0, Local6)
	Store(0, Local7)


	SET0(z129, "m371", 0)

	// ======================== Acquire

if (rn00) {

	Store("Acquire", Debug)

	_TCI(c200, Local0)

	// ASL-construction being investigated

	Acquire(MT00, 100)

	// Use NamedX for _TCI-begin statistics Package
	// not to touch the LOCAL_REFERENCE entry.
	_TCI(c201, pp0a)

	m3a3(Local0, pp0a, Local1) // calculate difference

	// Verify result

	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer

	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 4)
}

	// ======================== Add

if (rn00) {

	Store("Add", Debug)

	// Writing into uninitialized LocalX test
	m000()

	_TCI(c200, Local0)
	Store(Add(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 5)

	_TCI(c200, Local0)
	Store(Add(3, 4), temp)
	Store(Add(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(8, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 6)

	Store(num, lpN0)
	Store(0, lpC0)
	_TCI(c200, Local0)
	While (lpN0) {
		Store(Add(3, 4), temp)
		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(6, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 7)

	Store(3, i000)
	Store(4, i001)

	_TCI(c200, Local0)
	Store(Add(i000, i001), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 8)

	Store(0, Local4)

	_TCI(c200, Local0)
	Add(i000, i001, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 9)

	Store(0, Local4)
	Store("ssss", Local4)

	_TCI(c200, Local0)
	Add(i000, i001, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00a)) // String
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 10)

	_TCI(c200, Local0)
	Add(i000, i001, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 11)

	Store("ssss", Local4)

	_TCI(c200, Local0)
	Add(i000, i001, Local4)
	Add(i000, i001, Local4)
	Add(i000, i001, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(3, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(2, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00a)) // String
	Store(3, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 12)

	Store(0, Local4)
	Store(0, Local5)
	Store(0, Local6)

	_TCI(c200, Local0)
	Add(Local4, Local5, Local6)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(3, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 13)

	Store(0, Local6)

	_TCI(c200, Local0)
	Add(3, Local6, i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 14)

	// Initialized Package example

	Store(Package(9) {1, "", "1", 2, 3, Buffer(7) {8},
				Package(20) {8, 9, "q", 10, 11, Buffer(3) {6}}},
				Local4)

	_TCI(c200, Local0)
	Add(i000, i001, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(2, Index(pp01, c00c)) // Package
	Store(7, Index(pp01, c009)) // Integer
	Store(3, Index(pp01, c00a)) // String
	Store(2, Index(pp01, c00b)) // Buffer
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE
	// These 13 objects of "Store(Package(9) {1,..."
	// being deleted inside _TCI brackets were created
	// outside it before that:
	Store(m3a9(), pp02)
	Subtract(2, 15, Local4)
	Store(Local4, Index(pp02, c228)) // CLIST_ID_OPERAND

	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 15)
}

	// ======================== And

if (rn00) {

	Store("And", Debug)

	// Writing into uninitialized LocalX test
	m001()

	_TCI(c200, Local0)
	Store(And(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 16)

	Store(Package(9) {}, Local4)

	_TCI(c200, Local0)
	And(3, 4, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(2, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00c)) // Package
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 17)

	_TCI(c200, Local0)
	And(3, 4, i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 18)
}

	// ======================== Concatenate

if (rn00) {

	Store("Concatenate", Debug)

	_TCI(c200, Local0)
	Store(Concatenate(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00b)) // Buffer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 19)

	_TCI(c200, Local0)
	Concatenate(3, 4, b000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00b)) // Buffer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 20)

	_TCI(c200, Local0)
	Concatenate(3, 4, b003)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00b)) // Buffer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 21)

	_TCI(c200, Local0)
	Store(Concatenate("3", "4"), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(3, Index(pp00, c00a)) // String
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 22)

	_TCI(c200, Local0)
	Concatenate("3", "4", s000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c00a)) // String
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 23)

	Store(2, i000)
	Store(3, i001)

	_TCI(c200, Local0)
	Store(Concatenate(Buffer(i000) {3,4}, Buffer(i001) {6,7,8}), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(3, Index(pp00, c00b)) // Buffer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 24)

	_TCI(c200, Local0)
	Concatenate(Buffer(i000) {3,4}, Buffer(i001) {6,7,8}, b002)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c00b)) // Buffer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 25)

	_TCI(c200, Local0)
	Concatenate(Buffer(i000) {3,4}, Buffer(i001) {6,7,8}, s000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00a)) // String
	Store(3, Index(pp00, c00b)) // Buffer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 26)
	CopyObject("", s000)

	_TCI(c200, Local0)
	Concatenate("3", "4", b001)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00b)) // Buffer
	Store(3, Index(pp00, c00a)) // String
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 27)

	Store(Package(9) {}, Local4)

	_TCI(c200, Local0)
	Concatenate(3, 4, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00b)) // Buffer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(2, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00c)) // Package
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 28)

	Store("sss", Local4)

	_TCI(c200, Local0)
	Concatenate("3", "4", Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 29)

	Store(0, Local4)

	_TCI(c200, Local0)
	Concatenate("3", "4", Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(3, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(2, Index(pp01, c00a)) // String
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 30)

	Store(Package(9) {}, Local4)

	_TCI(c200, Local0)
	Concatenate(Buffer(3) {}, Buffer(4) {}, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(3, Index(pp00, c00b)) // Buffer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(2, Index(pp01, c009)) // Integer
	Store(2, Index(pp01, c00b)) // Buffer
	Store(1, Index(pp01, c00c)) // Package
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 31)
}

	// ======================== ConcatenateResTemplate

if (rn00) {

	Store("ConcatenateResTemplate", Debug)

	Store(0, Local4)

	_TCI(c200, Local0)
	ConcatenateResTemplate(rtp0, rtp1, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00b)) // Buffer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 32)
}

	// ======================== CondRefOf

if (rn01) {

	Store("CondRefOf", Debug)

	// Investigate: why 3 objects, but not 2

	_TCI(c200, Local0)
	Store(CondRefOf(i003), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 33)

	CopyObject("sssss", s000)

	_TCI(c200, Local0)
	Store(CondRefOf(s000), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 34)

	_TCI(c200, Local0)
	Store(CondRefOf(i003), temp)
	Store(CondRefOf(i003), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 35)
}

if (rn00) {
	Store(Package(9) {}, Local4)

	_TCI(c200, Local0)
	CondRefOf(s001, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00c)) // Package
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 36)

	Store(Buffer(9) {}, Local4)
	Store(Package(9) {}, Local5)

	_TCI(c200, Local0)
	CondRefOf(Local4, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(3, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00c)) // Package
	Store(2, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 37)
}

	// ======================== CopyObject

if (rn00) {

	Store("CopyObject", Debug)

	_TCI(c200, Local0)
	CopyObject(i000, i001)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 38)

	Store(Buffer(9) {}, Local4)
	Store(2, i000)

	_TCI(c200, Local0)
	CopyObject(i000, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00b)) // Buffer
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 39)

	CondRefOf(Local4, Local5)

	_TCI(c200, Local0)
	CopyObject(Local4, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(3, Index(pp01, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 40)

	_TCI(c200, Local0)
	CopyObject(Local4, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 41)
}

	// ======================== Decrement

if (rn00) {

	Store("Decrement", Debug)

	_TCI(c200, Local0)
	Decrement(i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 42)

	_TCI(c200, Local0)
	Decrement(Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 43)
}

	// ======================== DerefOf

if (rn00) {

	Store("DerefOf", Debug)

	CopyObject(0, i000)
	CopyObject(0, i001)

	Store(RefOf(i000), Local4)

	_TCI(c200, Local0)
	Store(DerefOf(Local4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 44)

	Store(RefOf(i000), Local4)

	_TCI(c200, Local0)
	Store(DerefOf(Local4), i001)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 45)
}

	// ======================== Divide

if (rn01) {

	Store("Divide", Debug)

	// Investigate: why 6 objects, but not 5

	_TCI(c200, Local0)
	Store(Divide(1, 2), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(6, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 46)

	_TCI(c200, Local0)
	Divide(1, 2, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(5, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 47)

	_TCI(c200, Local0)
	Divide(1, 2, i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(5, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 48)

	_TCI(c200, Local0)
	Divide(1, 2, i000, i001)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 49)

	_TCI(c200, Local0)
	Divide(1, 2, Local4, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 50)

	Store(0x1111111111111111, Local4)
	Store(0x12345678, Local5)
	Store("sssssssss", Local6)
	Store(Buffer(17) {}, Local7)

	_TCI(c200, Local0)
	Divide(Local4, Local5, Local6, Local7)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(4, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00a)) // String
	Store(1, Index(pp01, c00b)) // Buffer
	Store(4, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 51)
}

	// ======================== Fatal

if (rn00) {

	Store("Fatal", Debug)

	_TCI(c200, Local0)
	Fatal(1, 2, 3)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 52)
}

	Store(1, i000)
	Store(1, i001)

	// ======================== FindSetLeftBit

if (rn00) {

	Store("FindSetLeftBit", Debug)

	_TCI(c200, Local0)
	Store(FindSetLeftBit(5), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 53)

	_TCI(c200, Local0)
	Store(FindSetLeftBit(i000), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 54)

	_TCI(c200, Local0)
	FindSetLeftBit(i000, i001)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 55)

	_TCI(c200, Local0)
	FindSetLeftBit(i000, i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 56)

	Store(1, Local4)
	Store(1, Local5)

	_TCI(c200, Local0)
	FindSetLeftBit(Local4, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 57)

	_TCI(c200, Local0)
	FindSetLeftBit(i000, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 58)
}

	// ======================== FindSetRightBit

if (rn00) {

	Store("FindSetRightBit", Debug)

	_TCI(c200, Local0)
	Store(FindSetRightBit(5), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 59)

	_TCI(c200, Local0)
	Store(FindSetRightBit(i000), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 60)

	_TCI(c200, Local0)
	FindSetRightBit(i000, i001)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 61)

	_TCI(c200, Local0)
	FindSetRightBit(i000, i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 62)

	Store(1, Local4)
	Store(1, Local5)

	_TCI(c200, Local0)
	FindSetRightBit(Local4, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 63)

	_TCI(c200, Local0)
	FindSetRightBit(i000, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 64)

	Store(Package(9) {}, Local5)

	_TCI(c200, Local0)
	FindSetRightBit(i000, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00c)) // Package
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 65)
}

	// ======================== FromBCD

if (rn00) {

	Store("FromBCD", Debug)

	_TCI(c200, Local0)
	Store(FromBCD(4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 66)

	Store(1, i000)
	Store(1, i001)

	_TCI(c200, Local0)
	Store(FromBCD(i000), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 67)

	_TCI(c200, Local0)
	FromBCD(i000, i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 68)

	_TCI(c200, Local0)
	FromBCD(i000, i001)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 69)

	Store(1, Local4)
	Store(Buffer(9) {}, Local5)

	_TCI(c200, Local0)
	FromBCD(Local4, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00b)) // Buffer
	Store(2, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 70)
}

	// ======================== Increment

if (rn00) {

	Store("Increment", Debug)

	Store(1, i000)

	_TCI(c200, Local0)
	Increment(i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 71)

	Store(1, Local4)

	_TCI(c200, Local0)
	Increment(Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 72)
}

	// ======================== Index

if (rn00) {

	Store("Index", Debug)

	// Package

	_TCI(c200, Local0)
	Store(Index(p001, 1), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 73)

	_TCI(c200, Local0)
	Store(Index(Package(16) {1,2,3,4,5,6,7,8}, 1), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(11, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00c))  // Package
	Store(1, Index(pp00, c01c))  // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 74)

	Store(Buffer(1){}, Local4)

	_TCI(c200, Local0)
	Index(p001, 1, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00b)) // Buffer
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 75)

	Store(1, i000)
	Store("ssssss", Local4)

	_TCI(c200, Local0)
	Index(p001, i000, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00a)) // String
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 76)

	// Buffer

	_TCI(c200, Local0)
	Store(Index(b004, 1), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 77)

	_TCI(c200, Local0)
	Store(Index(Buffer(16) {1,2,3,4,5,6,7,8}, 1), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00b))  // Buffer
	Store(1, Index(pp00, c01c))  // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 78)

	Store("ssssssssss", Local4)

	_TCI(c200, Local0)
	Index(b004, 1, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00a)) // String
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 79)


	Store(1, i000)
	Store("ssssss", Local4)

	_TCI(c200, Local0)
	Index(b004, i000, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00a)) // String
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 80)

	Store(Buffer(9) {}, Local4)

	_TCI(c200, Local0)
	Index(b004, 1, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00b)) // Buffer
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 81)

	// String

	_TCI(c200, Local0)
	Store(Index(s002, 1), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 82)

	_TCI(c200, Local0)
	Store(Index("sdrtghjkiopuiy", 1), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 83)

	Store(Buffer(1){}, Local4)

	_TCI(c200, Local0)
	Index(s002, 1, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00b)) // Buffer
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 84)

	Store(1, i000)
	Store("ssssss", Local4)

	_TCI(c200, Local0)
	Index(s002, i000, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00a)) // String
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 85)
}

	// ======================== LAnd

if (rn00) {

	Store("LAnd", Debug)

	Store(1, i000)
	Store(1, i001)

	_TCI(c200, Local0)
	Store(LAnd(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 86)

	_TCI(c200, Local0)
	Store(LAnd(i000, i001), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 87)

	Store(1, Local4)
	Store(1, Local5)

	_TCI(c200, Local0)
	Store(LAnd(Local4, Local4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 88)

	Store(1, Local5)

	_TCI(c200, Local0)
	Store(LAnd(i000, Local5), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 89)
}

	// ======================== LEqual

if (rn00) {

	Store("LEqual", Debug)

	Store(1, Local4)
	Store(1, Local5)
	Store(1, i000)
	Store(1, i001)

	_TCI(c200, Local0)
	Store(LEqual(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 90)

	_TCI(c200, Local0)
	Store(LEqual(i000, i001), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 91)

	_TCI(c200, Local0)
	Store(LEqual(Local4, Local4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 92)

	_TCI(c200, Local0)
	Store(LEqual(i000, Local5), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 93)
}

	// ======================== LGreater

if (rn00) {

	Store("LGreater", Debug)

	_TCI(c200, Local0)
	Store(LGreater(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 94)

	_TCI(c200, Local0)
	Store(LGreater(i000, i001), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 95)

	_TCI(c200, Local0)
	Store(LGreater(Local4, Local4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 96)

	_TCI(c200, Local0)
	Store(LGreater(i000, Local5), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 97)
}

	// ======================== LGreaterEqual

if (rn01) {

	Store("LGreaterEqual", Debug)

	// Investigate: why the numbers differ
	// those of LGreater (+1 Integer).

	_TCI(c200, Local0)
	Store(LGreaterEqual(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 98)

	_TCI(c200, Local0)
	Store(LGreaterEqual(i000, i001), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 99)

	_TCI(c200, Local0)
	Store(LGreaterEqual(Local4, Local4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 100)

	_TCI(c200, Local0)
	Store(LGreaterEqual(i000, Local5), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 101)
}

	// ======================== LLess

if (rn00) {

	Store("LLess", Debug)

	_TCI(c200, Local0)
	Store(LLess(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 102)

	_TCI(c200, Local0)
	Store(LLess(i000, i001), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 103)

	_TCI(c200, Local0)
	Store(LLess(Local4, Local4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 104)

	_TCI(c200, Local0)
	Store(LLess(i000, Local5), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 105)
}

	// ======================== LLessEqual

if (rn01) {

	Store("LLessEqual", Debug)

	// Investigate: why the numbers differ
	// those of LGreater (+1 Integer) (but
	// identical to LGreaterEqual).

	_TCI(c200, Local0)
	Store(LLessEqual(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 106)

	_TCI(c200, Local0)
	Store(LLessEqual(i000, i001), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 107)

	_TCI(c200, Local0)
	Store(LLessEqual(Local4, Local4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 108)

	_TCI(c200, Local0)
	Store(LLessEqual(i000, Local5), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 109)
}

	// ======================== LNot

if (rn00) {

	Store("LNot", Debug)

	_TCI(c200, Local0)
	Store(LNot(3), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 110)

	_TCI(c200, Local0)
	Store(LNot(i000), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 111)

	_TCI(c200, Local0)
	Store(LNot(Local4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 112)
}

	// ======================== LNotEqual

if (rn01) {

	Store("LNotEqual", Debug)

	// Investigate: why the numbers differ
	// those of LGreater (+1 Integer) (but
	// identical to LGreaterEqual).

	_TCI(c200, Local0)
	Store(LNotEqual(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 113)

	_TCI(c200, Local0)
	Store(LNotEqual(i000, i001), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 114)

	_TCI(c200, Local0)
	Store(LNotEqual(Local4, Local4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 115)

	_TCI(c200, Local0)
	Store(LNotEqual(i000, Local5), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 116)
}

	// ======================== LOr

if (rn00) {

	Store("LOr", Debug)

	_TCI(c200, Local0)
	Store(LOr(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 117)

	_TCI(c200, Local0)
	Store(LOr(i000, i001), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 118)

	_TCI(c200, Local0)
	Store(LOr(Local4, Local4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 119)

	_TCI(c200, Local0)
	Store(LOr(i000, Local5), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 120)
}

	// ======================== Match

if (rn00) {

	Store("Match", Debug)

	Store(1, Local4)
	Store(1, Local5)
	Store(1, i000)
	Store(1, i001)

	_TCI(c200, Local0)
	Store(Match(Package(8) {1,2,3,4,5,6,7,8}, MTR, 2, MTR, 3, 0), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(15, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00c))  // Package
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 121)

	_TCI(c200, Local0)
	Store(Match(Package(i001) {1,2,3,4,5,6,7,8}, MTR, i000, MTR, Local4, Local4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(11, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00c))  // Package
	Store(2, Index(pp00, c01c))  // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 122)

	_TCI(c200, Local0)
	Store(Match(p002, MTR, i000, MTR, Local4, Local4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c))  // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 123)
}

	// ======================== Mid

if (rn00) {

	Store("Mid", Debug)

	_TCI(c200, Local0)
	Store(Mid("asdfghjk", 0, 1), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c00a)) // String
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 124)

	Store(Package(9) {}, Local4)

	_TCI(c200, Local0)
	Mid("gsqrtsghjkmnh", 0, 9, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(2, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00a)) // String
	Store(1, Index(pp01, c00c)) // Package
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 125)

	Store(Package(9) {}, Local4)

	_TCI(c200, Local0)
	Mid(s000, 0, 1, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(2, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00c)) // Package
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 126)

	Store(Buffer(9) {}, Local4)

	_TCI(c200, Local0)
	Mid(b000, 0, 1, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00b)) // Buffer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 127)
}

	// ======================== Mod

if (rn00) {

	Store("Mod", Debug)

	_TCI(c200, Local0)
	Store(Mod(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 128)

	Store(Buffer(9) {}, Local4)

	_TCI(c200, Local0)
	Mod(3, 4, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(2, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00b)) // Buffer
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 129)

	Store(1, Local4)

	_TCI(c200, Local0)
	Mod(i000, Local4, i001)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 130)
}

	// ======================== Multiply

if (rn00) {

	Store("Multiply", Debug)

	_TCI(c200, Local0)
	Store(Multiply(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 131)

	_TCI(c200, Local0)
	Multiply(3, 4, i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 132)

	Store(1, Local4)

	_TCI(c200, Local0)
	Multiply(Local4, Local4, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(3, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 133)
}

	// ======================== NAnd

if (rn00) {

	Store("NAnd", Debug)

	_TCI(c200, Local0)
	Store(NAnd(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 134)

	_TCI(c200, Local0)
	NAnd(i000, 4, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 135)

	_TCI(c200, Local0)
	NAnd(i000, i001, i002)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 136)
}

	// ======================== NOr

if (rn00) {

	Store("NOr", Debug)

	_TCI(c200, Local0)
	Store(NOr(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 137)

	_TCI(c200, Local0)
	NOr(i000, 4, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 138)

	_TCI(c200, Local0)
	NOr(i000, i001, i002)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 139)
}

	// ======================== Not

if (rn00) {

	Store("Not", Debug)

	_TCI(c200, Local0)
	Store(Not(3), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 140)

	_TCI(c200, Local0)
	Not(3, i001)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 141)

	_TCI(c200, Local0)
	Not(i000, i001)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 142)

	Store(1, Local4)

	_TCI(c200, Local0)
	Not(Local4, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 143)

	Store("sssssssssss", Local5)

	_TCI(c200, Local0)
	Not(i000, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00a)) // String
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 144)
}

	// ======================== ObjectType

if (rn00) {

	Store("ObjectType", Debug)

	_TCI(c200, Local0)
	Store(ObjectType(i000), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 145)

	Store(Package(1){}, Local4)

	_TCI(c200, Local0)
	Store(ObjectType(Local4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 146)
}

	// ======================== Or

if (rn00) {

	Store("Or", Debug)

	_TCI(c200, Local0)
	Store(Or(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 147)

	Store(Package(9){}, Local4)

	_TCI(c200, Local0)
	Or(i000, 4, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00c)) // Package
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 148)

	_TCI(c200, Local0)
	Or(i000, i001, i002)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 149)
}

	// ======================== RefOf

if (rn00) {

	Store("RefOf", Debug)

	_TCI(c200, Local0)
	Store(RefOf(i000), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 150)

	Store(1, Local4)

	_TCI(c200, Local0)
	Store(RefOf(Local4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 151)
}

	// ======================== Release

if (rn00) {

	Store("Release", Debug)

	Acquire(MT00, 100)

	_TCI(c200, Local0)
	Release(MT00)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 152)
}

	// ======================== Reset

if (rn00) {

	Store("Reset", Debug)

	_TCI(c200, Local0)
	Reset(EV00)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 153)
}

	// ======================== ShiftLeft

if (rn00) {

	Store("ShiftLeft", Debug)

	_TCI(c200, Local0)
	Store(ShiftLeft(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 154)

	Store("qqqqqqqqqqqqq", Local4)

	_TCI(c200, Local0)
	ShiftLeft(3, 4, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(2, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00a)) // String
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 155)

	_TCI(c200, Local0)
	ShiftLeft(i000, Local4, i001)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 156)
}

	// ======================== ShiftRight

if (rn00) {

	Store("ShiftRight", Debug)

	_TCI(c200, Local0)
	Store(ShiftRight(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 157)

	Store("qqqqqqqqqqqqq", Local4)

	_TCI(c200, Local0)
	ShiftRight(3, 4, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(2, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00a)) // String
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 158)

	_TCI(c200, Local0)
	ShiftRight(i000, Local4, i001)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 159)
}

	// ======================== Signal

if (rn00) {

	Store("Signal", Debug)

	Reset(EV00)

	_TCI(c200, Local0)
	Signal(EV00)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 160)
}

	// ======================== SizeOf

if (rn00) {

	Store("SizeOf", Debug)

	Store(Package(9) {}, Local4)

	_TCI(c200, Local0)
	Store(SizeOf(Local4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 161)

	_TCI(c200, Local0)
	Store(SizeOf(b000), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 162)
}

	// ======================== Sleep

if (rn00) {

	Store("Sleep", Debug)

	_TCI(c200, Local0)
	Sleep(1)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 163)

	Store(1, i000)

	_TCI(c200, Local0)
	Sleep(i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 164)

	Store(1, Local4)

	_TCI(c200, Local0)
	Sleep(Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 165)
}

	// ======================== Stall

if (rn00) {

	Store("Stall", Debug)

	_TCI(c200, Local0)
	Stall(1)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 166)

	_TCI(c200, Local0)
	Stall(i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 167)

	_TCI(c200, Local0)
	Stall(Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 168)
}

	// ======================== Store

if (rn01) {
	// Investigate and analize the logic of
	// crreating/deleting objects while processing
	// the Store operator (the number of objects in
	// different cases applying the Store operator).

	Store("Store", Debug)

	// Writing into uninitialized LocalX
	m002()

	Store("ssssssssss", Local4)

	_TCI(c200, Local0)
	Store(5, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00a)) // String
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 169)

	Store(1, i000)
	Store(1, i001)

	_TCI(c200, Local0)
	Store(i000, i001)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 170)

	// But why this example contains three objects,
	// just as expected.

	Store("sssssssss", Local4)
	Store(Package(9) {}, Local5)

	_TCI(c200, Local0)
	Store(Local4, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00a)) // String
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00c)) // Package
	Store(2, Index(pp01, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 171)

	Store(Package(8) {1,2,3,4,5,6,7,8}, Local4)
	Store(1, Local5)

	_TCI(c200, Local0)
	Store(Local4, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(8, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00c)) // Package
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(2, Index(pp01, c01c)) // LOCAL_REFERENCE
	// Package is not being removed,
	// its elements created outide are
	// not removed as well.
	Store(m3a9(), pp02)
	Store(8, Index(pp02, c228)) // CLIST_ID_OPERAND
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 172)

	Store(Buffer(8) {1,2,3,4,5,6,7,8}, Local4)
	Store("q", Local5)

	_TCI(c200, Local0)
	Store(Local4, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00b)) // Buffer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00a)) // String
	Store(2, Index(pp01, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 173)

	Store("sghjklopiuytrwq", Local4)
	Store(Buffer(8) {1,2,3,4,5,6,7,8}, Local5)

	_TCI(c200, Local0)
	Store(Local4, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00a)) // String
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00b)) // Buffer
	Store(2, Index(pp01, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 174)

	Store("a", Local4)

	_TCI(c200, Local0)
	Store("ssss", Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 175)

	Store(Buffer(3) {}, Local4)

	_TCI(c200, Local0)
	Store(Buffer(3) {}, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00b)) // Buffer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 176)

	// Why there is no one new Integer?

	Store(0, i000)
	Store(0, i001)

	_TCI(c200, Local0)
	Store(i000, i001)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 177)
}

	// ======================== Subtract

if (rn00) {

	Store("Subtract", Debug)

	_TCI(c200, Local0)
	Store(Subtract(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 178)

	_TCI(c200, Local0)
	Store(Subtract(3, 4), temp)
	Store(Subtract(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(8, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 179)

	Store(5, num)
	Store(num, lpN0)
	Store(0, lpC0)
	_TCI(c200, Local0)
	While (lpN0) {
		Store(Subtract(3, 4), temp)
		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(6, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 180)

	Store(3, i000)
	Store(4, i001)

	_TCI(c200, Local0)
	Store(Subtract(i000, i001), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 181)

	Store(0, Local4)

	_TCI(c200, Local0)
	Subtract(i000, i001, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 182)

	Store(2, Local4)
	Store(1, Local5)
	Store(0, Local6)

	_TCI(c200, Local0)
	Subtract(Local4, Local5, Local6)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(3, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 183)

	_TCI(c200, Local0)
	Subtract(3, Local6, i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 184)
}

	// ======================== ToBCD

if (rn00) {

	Store("ToBCD", Debug)

	_TCI(c200, Local0)
	Store(ToBCD(3), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 185)

	_TCI(c200, Local0)
	ToBCD(3, i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 186)

	_TCI(c200, Local0)
	ToBCD(3, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 187)

	_TCI(c200, Local0)
	ToBCD(i000, i001)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 188)

	_TCI(c200, Local0)
	ToBCD(Local4, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 189)
}

	// ======================== ToBuffer

if (rn00) {

	Store("ToBuffer", Debug)

	_TCI(c200, Local0)
	Store(ToBuffer(3), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00b)) // Buffer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 190)

	Store(1, Local4)

	_TCI(c200, Local0)
	ToBuffer(3, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00b)) // Buffer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(2, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 191)

	Store(1, Local4)

	_TCI(c200, Local0)
	ToBuffer(Local4, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00b)) // Buffer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(2, Index(pp01, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 192)

	Store(1, Local4)

	_TCI(c200, Local0)
	ToBuffer(Buffer(3) {}, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c00b)) // Buffer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(2, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00b)) // Buffer
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 193)
}

if (rn01) {
	// Investigate, why only two objects

	Store(Buffer(3) {}, Local4)

	_TCI(c200, Local0)
	ToBuffer(Local4, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 194)
}

if (rn00) {
	Store(Buffer(3) {}, Local4)
	Store(Buffer(3) {}, Local5)

	_TCI(c200, Local0)
	ToBuffer(Local4, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00b)) // Buffer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 195)
}

	// ======================== ToDecimalString

if (rn00) {
	Store("ToDecimalString", Debug)

	_TCI(c200, Local0)
	Store(ToDecimalString(3), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00a)) // String
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 196)

	Store(Buffer(3) {}, Local4)

	_TCI(c200, Local0)
	ToDecimalString(3, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00b)) // Buffer
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 197)

	Store("aaa", Local4)

	_TCI(c200, Local0)
	ToDecimalString(i000, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 198)

	Store(1, Local4)
	Store(Package(9) {}, Local5)

	_TCI(c200, Local0)
	ToDecimalString(Local4, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00a)) // String
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00c)) // Package
	Store(2, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 199)

	Store(1, Local4)

	_TCI(c200, Local0)
	ToDecimalString(Local4, s000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 200)
}

	// ======================== ToHexString

if (rn00) {
	Store("ToHexString", Debug)

	_TCI(c200, Local0)
	Store(ToHexString(3), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00a)) // String
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 201)

	Store(Buffer(3) {}, Local4)

	_TCI(c200, Local0)
	ToHexString(3, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00b)) // Buffer
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 202)

	Store("aaa", Local4)

	_TCI(c200, Local0)
	ToHexString(i000, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 203)

	Store(1, Local4)
	Store(Package(9) {}, Local5)

	_TCI(c200, Local0)
	ToHexString(Local4, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)

	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00a)) // String
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE

	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00c)) // Package
	Store(2, Index(pp01, c01c)) // LOCAL_REFERENCE

	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 204)

	Store(1, Local4)

	_TCI(c200, Local0)
	ToHexString(Local4, s000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 205)
}

	// ======================== ToInteger

if (rn01) {

	Store("ToInteger", Debug)

	// Investigate: why only 2 objects, but not 3

	_TCI(c200, Local0)
	Store(ToInteger(3), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 206)

	_TCI(c200, Local0)
	ToInteger(3, i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 207)

	// Inv: why only one object, no Integer

	Store(1, Local4)

	_TCI(c200, Local0)
	ToInteger(Local4, i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 208)

	Store(Package(9){}, Local4)

	_TCI(c200, Local0)
	ToInteger(i000, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00c)) // Package
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 209)

	// See: there are created all the expected 3 objects

	_TCI(c200, Local0)
	Store(ToInteger("0xaaaa"), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00a)) // String
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 210)

	_TCI(c200, Local0)
	ToInteger("0xaaaa", i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00a)) // String
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 211)

	Store("0xaaaa", Local4)

	_TCI(c200, Local0)
	ToInteger(Local4, i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 212)

	Store("0xaaaa", s000)
	Store(Package(9){}, Local4)

	_TCI(c200, Local0)
	ToInteger(s000, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c00c)) // Package
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 213)

	_TCI(c200, Local0)
	Store(ToInteger(Buffer(9){1,2,3,4,5,6,7,8,9}), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00b)) // Buffer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 214)
}

	// ======================== ToString

if (rn02) {

	Store("ToString", Debug)

	// Integer

	// Inv: Buffer is result of conversion of Integer 2?
	// Error: 1 Integer is not deleted

	_TCI(c200, Local0)
	Store(ToString(2), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c00b)) // Buffer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 215)
}

if (rn00) {
	Store("sssss", Local5)

	_TCI(c200, Local0)
	Store(ToString(2), Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 216)

	Store(2, i000)
	Store("sssss", Local5)

	_TCI(c200, Local0)
	Store(ToString(i000), Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c00b)) // Buffer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 217)
}

if (rn02) {

	// Error: 1 Integer is not deleted

	Store("sssss", Local5)

	_TCI(c200, Local0)
	ToString(2, 0, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c00b)) // Buffer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 218)
}

	// Buffer

if (rn00) {

	Store("sssss", Local5)
	Store(Buffer(9) {1,2,3,4,5,6,7,8,9}, b000)

	_TCI(c200, Local0)
	Store(ToString(b000), Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 219)

	Store("sssss", Local5)

	_TCI(c200, Local0)
	ToString(Buffer(9) {1,2,3,4,5,6,7,8,9}, 0, Local5)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c00b)) // Buffer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 220)

	Store(Buffer(9) {1,2,3,4,5,6,7,8,9}, Local4)
	Store(1, Local5)
	Store("sssssss", Local6)

	_TCI(c200, Local0)
	ToString(Local4, Local5, Local6)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00a)) // String
	Store(3, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 221)
}

	// ======================== Wait

if (rn00) {

	Store("Wait", Debug)

	_TCI(c200, Local0)
	Wait(EV00, 1)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 222)

	Store(1, Local4)

	_TCI(c200, Local0)
	Wait(EV00, Local4)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 223)

	Store(1, i000)

	_TCI(c200, Local0)
	Wait(EV00, i000)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 224)
}

	// ======================== XOr

if (rn00) {

	Store("XOr", Debug)

	_TCI(c200, Local0)
	Store(XOr(3, 4), temp)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 225)

	Store(1, Local4)
	Store(1, Local5)
	Store(1, Local6)

	_TCI(c200, Local0)
	XOr(Local4, Local5, Local6)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(3, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 226)

	Store(1, i000)
	Store(1, i001)
	Store(1, i002)

	_TCI(c200, Local0)
	XOr(i000, i001, i002)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 227)

	Store(Package(9) {}, Local6)

	_TCI(c200, Local0)
	XOr(i000, 3, Local6)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(1, Index(pp01, c00c)) // Package
	Store(1, Index(pp01, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, pp01, 0, 228)
}


	RST0()

/*
 *	// ################################## Check all the test:
 *	_TCI(c201, LLL1)
 *	m3a3(LLL0, LLL1, LLL2)
 *	m3a4(LLL0, LLL1, LLL2, 0, 0, 0, 0xff0)
 *	// ################################## Check all the test.
 */
}
