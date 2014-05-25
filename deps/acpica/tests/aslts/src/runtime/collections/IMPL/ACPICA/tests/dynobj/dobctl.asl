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
 * DynObj: Method execution control operators
 */

Name(z131, 131)

// Check the Method Execution Control operators
Method(m372, 0, Serialized)
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

	// Objects for verified operators

	Name(num, 0)
	Name(num2, 0)
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(i000, 0)
	Name(i001, 0)
	Name(i002, 0)

	// Methods verified

	Method(m000)
	{
	}

	Method(m001)
	{
		return (1000)
	}

	Method(m002, 6)
	{
	}

	Method(m003, 7)
	{
		return (1000)
	}

	Method(m004, 7)
	{
		Store(0, Local0)
		Store(0, Local1)
		Store(0, Local2)
		Store(0, Local3)
		Store(0, Local4)
		Store(0, Local5)
		Store(0, Local6)
		Store(0, Local7)

		Add(Local0, Local1, Local7)

		return (Local7)
	}


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

	SET0(z131, "m372", 0)


	// ======================== While


if (rn00) {

	Store("While, Continue, Break", Debug)

	Store(73, num)
	Store(num, lpN0)
	Store(0, lpC0)
	_TCI(c200, Local0)
	While (lpN0) {
		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(2, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 0)

	// Inv: why (3*num)+1, why +1?

	Store(37, num)
	Store(num, Local4)
	Store(0, Local5)
	_TCI(c200, Local0)
	While (Local4) {
		Decrement(Local4)
		Increment(Local5)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(2, num, Local6)
	Multiply(3, num, Local7)
	Increment(Local7)
	Store(Local6, Index(pp00, c009)) // Integer
	Store(Local7, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 1)
}

if (rn02) {

	// Error: memory is lost

	Store(200, num2)
	Store(num2, i000)
	Store(200, num)
	Store(num, lpN0)
	Store(0, lpC0)
	_TCI(c200, Local0)
	While (lpN0) {
		if (i000) {
			Decrement(i000)
			Continue
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(2, num, Local5)
	Add(Local5, num2, Local4)
	Store(Local4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 2)
}

if (rn02) {

	// Error: memory is lost

	Store(100, num2)
	Store(num2, Local4)
	Store(200, num)
	Store(num, Local5)
	Store(0, Local6)
	_TCI(c200, Local0)
	While (Local5) {
		if (Local4) {
			Decrement(Local4)
			Continue
		}
		Decrement(Local5)
		Increment(Local6)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(2, num, Local5)
	Add(Local5, num2, Local4)
	Store(Local4, Index(pp00, c009)) // Integer
	Multiply(4, num, Local7)
	Increment(Local7)
	Multiply(3, num2, Local6)
	Add(Local7, Local6, Local5)
	Store(Local5, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 3)
}

if (rn02) {
	Store(100, num)
	Store(num, lpN0)
	Store(0, lpC0)
	_TCI(c200, Local0)
	While (lpN0) {
		Break
		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 4)
}


	// ======================== If


if (rn00) {

	Store("If, ElseIf, Else", Debug)

	_TCI(c200, Local0)
	if (0) {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 5)

	_TCI(c200, Local0)
	if (1) {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 6)

	Store(0, i000)
	_TCI(c200, Local0)
	if (i000) {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 7)

	Store(1, i000)
	_TCI(c200, Local0)
	if (i000) {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 8)

	Store(0, Local4)
	_TCI(c200, Local0)
	if (Local4) {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 9)

	Store(1, Local4)
	_TCI(c200, Local0)
	if (Local4) {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 10)

	Store(0, i000)
	Store(19, num)
	Store(num, lpN0)
	Store(0, lpC0)
	_TCI(c200, Local0)
	While (lpN0) {
		if (i000) {
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(2, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 11)

	Store(1, i000)
	Store(19, num)
	Store(num, lpN0)
	Store(0, lpC0)
	_TCI(c200, Local0)
	While (lpN0) {
		if (i000) {
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(2, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 12)

	Store(0, Local4)
	Store(19, num)
	Store(num, lpN0)
	Store(0, lpC0)
	_TCI(c200, Local0)
	While (lpN0) {
		if (Local4) {
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(2, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	Store(num, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 13)

	Store(1, Local4)
	Store(19, num)
	Store(num, lpN0)
	Store(0, lpC0)
	_TCI(c200, Local0)
	While (lpN0) {
		if (Local4) {
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(2, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	Store(num, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 14)

	// LEqual

	Store(100, num)
	Store(num, lpN0)
	Store(0, lpC0)

	Store(1, Local4)
	Store(1, Local5)

	_TCI(c200, Local0)
	While (lpN0) {
		if (LEqual(Local4, Local5)) {
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(3, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	Multiply(2, num, Local5)
	Store(Local5, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 15)

	Store(100, num)
	Store(num, lpN0)
	Store(0, lpC0)

	Store(0, Local4)
	Store(1, Local5)

	_TCI(c200, Local0)
	While (lpN0) {
		if (LEqual(Local4, Local5)) {
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(3, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	Multiply(2, num, Local5)
	Store(Local5, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 16)
}


	// ======================== If, Else


if (rn02) {

	// Error: 1 ACPI_MEM_LIST_STATE is not deleted

	Store(1, Local4)
	Store(1, Local5)
	_TCI(c200, Local0)
	if (LEqual(Local4, Local5)) {
	} else {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 17)

	Store(0, Local4)
	Store(0, Local5)
	_TCI(c200, Local0)
	if (LEqual(Local4, Local5)) {
	} else {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 18)

	Store(1, i000)
	Store(1, i001)
	_TCI(c200, Local0)
	if (LEqual(i000, i001)) {
	} else {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 19)

	Store(0, i000)
	Store(0, i001)
	_TCI(c200, Local0)
	if (LEqual(i000, i001)) {
	} else {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 20)
}

if (rn00) {
	Store(0, Local4)
	Store(1, Local5)

	_TCI(c200, Local0)
	if (LEqual(Local4, Local5)) {
	} else {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 21)

	Store(0, i000)
	Store(1, i001)

	_TCI(c200, Local0)
	if (LEqual(i000, i001)) {
	} else {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 22)
}


	// ======================== If, ElseIf


if (rn02) {

	// Error: 1 ACPI_MEM_LIST_STATE is not deleted

	Store(1, Local4)

	_TCI(c200, Local0)
	if (Local4) {
	} elseif (Local4) {
	} elseif (Local4) {
	} elseif (Local4) {
	} elseif (Local4) {
	} elseif (Local4) {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 23)

	// Error: 1 ACPI_MEM_LIST_STATE is not deleted

	Store(1, i000)

	_TCI(c200, Local0)
	if (i000) {
	} elseif (i000) {
	} elseif (i000) {
	} elseif (i000) {
	} elseif (i000) {
	} elseif (i000) {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 24)

	// Error: (1*num) ACPI_MEM_LIST_STATE are not deleted

	Store(100, num)
	Store(num, lpN0)
	Store(0, lpC0)

	Store(1, Local4)

	_TCI(c200, Local0)
	While (lpN0) {

		if (Local4) {
		} elseif (Local4) {
		} elseif (Local4) {
		} elseif (Local4) {
		} elseif (Local4) {
		} elseif (Local4) {
		}

		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(2, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	Store(num, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 25)
}

if (rn00) {
	Store(0, Local4)

	_TCI(c200, Local0)
	if (Local4) {
	} elseif (Local4) {
	} elseif (Local4) {
	} elseif (Local4) {
	} elseif (Local4) {
	} elseif (Local4) {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(6, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 26)

	Store(0, i000)

	_TCI(c200, Local0)
	if (i000) {
	} elseif (i000) {
	} elseif (i000) {
	} elseif (i000) {
	} elseif (i000) {
	} elseif (i000) {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 27)
}

if (rn02) {

	// Error: 1 ACPI_MEM_LIST_STATE is not deleted

	Store(1, Local4)
	Store(1, Local5)

	_TCI(c200, Local0)
	if (LEqual(Local4, Local5)) {
	} elseif (LEqual(Local4, Local5)) {
	} elseif (LEqual(Local4, Local5)) {
	} elseif (LEqual(Local4, Local5)) {
	} elseif (LEqual(Local4, Local5)) {
	} elseif (LEqual(Local4, Local5)) {
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(2, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 28)

	// Error: (1*num) ACPI_MEM_LIST_STATE are not deleted

	Store(100, num)
	Store(num, lpN0)
	Store(0, lpC0)

	Store(1, Local4)
	Store(1, Local5)

	_TCI(c200, Local0)
	While (lpN0) {

		if (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		}

		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(3, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	Multiply(2, num, Local5)
	Store(Local5, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 29)

	// Error: (1*num) ACPI_MEM_LIST_STATE are not deleted

	Store(100, num)
	Store(num, lpN0)
	Store(0, lpC0)

	Store(1, i000)
	Store(1, i001)

	_TCI(c200, Local0)
	While (lpN0) {

		if (LEqual(i000, i001)) {
		} elseif (LEqual(i000, i001)) {
		} elseif (LEqual(i000, i001)) {
		} elseif (LEqual(i000, i001)) {
		} elseif (LEqual(i000, i001)) {
		} elseif (LEqual(i000, i001)) {
		}

		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(3, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 30)

	// Error: (1*num) ACPI_MEM_LIST_STATE are not deleted

	Store(100, num)
	Store(num, lpN0)
	Store(0, lpC0)

	Store(0, i000)
	Store(0, i001)

	_TCI(c200, Local0)
	While (lpN0) {

		if (LEqual(i000, i001)) {
		} elseif (LEqual(i000, i001)) {
		} elseif (LEqual(i000, i001)) {
		} elseif (LEqual(i000, i001)) {
		} elseif (LEqual(i000, i001)) {
		} elseif (LEqual(i000, i001)) {
		}

		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(3, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 31)
}

if (rn00) {
	Store(17, num)
	Store(num, lpN0)
	Store(0, lpC0)

	Store(0, Local4)
	Store(1, Local5)

	_TCI(c200, Local0)
	While (lpN0) {

		if (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		}

		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(8, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	Multiply(12, num, Local5)
	Store(Local5, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 32)

	Store(17, num)
	Store(num, lpN0)
	Store(0, lpC0)

	Store(0, i000)
	Store(1, i001)

	_TCI(c200, Local0)
	While (lpN0) {

		if (LEqual(i000, i001)) {
		} elseif (LEqual(i000, i001)) {
		} elseif (LEqual(i000, i001)) {
		} elseif (LEqual(i000, i001)) {
		} elseif (LEqual(i000, i001)) {
		} elseif (LEqual(i000, i001)) {
		}

		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(8, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 33)
}

if (rn02) {

	// Error: (1*num) ACPI_MEM_LIST_STATE are not deleted

	Store(100, num)
	Store(num, lpN0)
	Store(0, lpC0)

	Store(0, Local4)
	Store(1, Local5)

	_TCI(c200, Local0)
	While (lpN0) {

		if (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, 0)) {
		} elseif (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		}

		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(6, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	Multiply(5, num, Local5)
	Store(Local5, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 34)
}


	// ======================== If, ElseIf, Else


if (rn02) {

	// Error: (1*num) ACPI_MEM_LIST_STATE are not deleted

	Store(100, num)
	Store(num, lpN0)
	Store(0, lpC0)

	Store(1, Local4)
	Store(1, Local5)

	_TCI(c200, Local0)
	While (lpN0) {

		if (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		} elseif (LEqual(Local4, Local5)) {
		} else {
		}

		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(3, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	Multiply(2, num, Local5)
	Store(Local5, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 35)
}


	// ======================== Switch, Case, Default


	// CAUTION: these tests should be a few updated after fixing interpreter

if (rn02) {

	Store("Switch, Case, Default", Debug)

	// Inv: why so many Integers, 4
	// Error: why is one Integer not deleted

	_TCI(c200, Local0)
	Switch (0) {
		Case (1) {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 36)

	_TCI(c200, Local0)
	Switch (1) {
		Case (1) {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 37)
}

if (rn02) {

	// Inv: why so many Integers, 4
	// Error: why is one Integer not deleted
	// Error: 1 ACPI_MEM_LIST_STATE is not deleted

	_TCI(c200, Local0)
	Switch (0) {
		Case (1) {
		}
		Default {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 38)

	_TCI(c200, Local0)
	Switch (1) {
		Case (1) {
		}
		Default {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(4, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 39)
}

if (rn02) {

	// Inv: what is the number of Integers
	// Error: why is one Integer not deleted
	// Error: (1*num) ACPI_MEM_LIST_STATE are not deleted


	Store(10, num)
	Store(num, lpN0)
	Store(0, lpC0)
	_TCI(c200, Local0)
	While (lpN0) {
		Switch (1) {
			Case (1) {
			}
			Default {
			}
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Multiply(6, num, Local5)
	Store(Local5, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 40)
}


	// ///////////////////// NamedX & LocalX


if (rn02) {

	// NamedX

	// Error: why is one Integer not deleted

	Store(0, i000)
	_TCI(c200, Local0)
	switch (ToInteger (i000)) {
		Case (0) {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 41)

	Store(1, i000)
	_TCI(c200, Local0)
	switch (ToInteger (i000)) {
		Case (1) {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 42)

	Store(0, i000)
	_TCI(c200, Local0)
	switch (ToInteger (i000)) {
		Case (1) {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 43)

	// LocalX

	Store(0, Local4)
	_TCI(c200, Local0)
	switch (ToInteger (Local4)) {
		Case (0) {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 44)

	Store(1, Local4)
	_TCI(c200, Local0)
	switch (ToInteger (Local4)) {
		Case (1) {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 45)

	Store(0, Local4)
	_TCI(c200, Local0)
	switch (ToInteger (Local4)) {
		Case (1) {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 46)
}

if (rn02) {

	// NamedX

	// Error: why is one Integer not deleted

	Store(0, i000)
	_TCI(c200, Local0)
	switch (ToInteger (i000)) {
		Case (0) {
		}
		Default {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 47)

	Store(1, i000)
	_TCI(c200, Local0)
	switch (ToInteger (i000)) {
		Case (1) {
		}
		Default {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 48)

	Store(0, i000)
	_TCI(c200, Local0)
	switch (ToInteger (i000)) {
		Case (1) {
		}
		Default {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 49)

	// LocalX

	Store(0, Local4)
	_TCI(c200, Local0)
	switch (ToInteger (Local4)) {
		Case (0) {
		}
		Default {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 50)

	Store(1, Local4)
	_TCI(c200, Local0)
	switch (ToInteger (Local4)) {
		Case (1) {
		}
		Default {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 51)

	Store(0, Local4)
	_TCI(c200, Local0)
	switch (ToInteger (Local4)) {
		Case (1) {
		}
		Default {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 52)
}

if (rn02) {

	Store(1, i000)
	_TCI(c200, Local0)
	switch (ToInteger (i000)) {
		Case (1) {
		}
		Case (2) {
		}
		Case (3) {
		}
		Case (4) {
		}
		Case (5) {
		}
		Case (6) {
		}
		Case (7) {
		}
		Default {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 53)

	Store(7, i000)
	_TCI(c200, Local0)
	switch (ToInteger (i000)) {
		Case (1) {
		}
		Case (2) {
		}
		Case (3) {
		}
		Case (4) {
		}
		Case (5) {
		}
		Case (6) {
		}
		Case (7) {
		}
		Default {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(17, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 54)

	Store(10000, i000)
	_TCI(c200, Local0)
	switch (ToInteger (i000)) {
		Case (1) {
		}
		Case (2) {
		}
		Case (3) {
		}
		Case (4) {
		}
		Case (5) {
		}
		Case (6) {
		}
		Case (7) {
		}
		Default {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(17, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 55)
}

if (rn02) {
	Store(1, Local4)
	_TCI(c200, Local0)
	switch (ToInteger (Local4)) {
		Case (1) {
		}
		Case (2) {
		}
		Case (3) {
		}
		Case (4) {
		}
		Case (5) {
		}
		Case (6) {
		}
		Case (7) {
		}
		Default {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 56)

	Store(7, Local4)
	_TCI(c200, Local0)
	switch (ToInteger (Local4)) {
		Case (1) {
		}
		Case (2) {
		}
		Case (3) {
		}
		Case (4) {
		}
		Case (5) {
		}
		Case (6) {
		}
		Case (7) {
		}
		Default {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(17, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 57)

	Store(10000, Local4)
	_TCI(c200, Local0)
	switch (ToInteger (Local4)) {
		Case (1) {
		}
		Case (2) {
		}
		Case (3) {
		}
		Case (4) {
		}
		Case (5) {
		}
		Case (6) {
		}
		Case (7) {
		}
		Default {
		}
	}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(17, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 58)
}


	// ======================== Method

if (rn00) {

	Store("Method", Debug)

	_TCI(c200, Local0)
	m000()
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 59)

	_TCI(c200, Local0)
	m001()
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 60)

	_TCI(c200, Local0)
	m002(1,2,3,4,5,6)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(6, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 61)

	_TCI(c200, Local0)
	m003(0,1,2,3,4,5,6)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(8, Index(pp00, c009)) // Integer
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 62)

	_TCI(c200, Local0)
	m004(0,1,2,3,4,5,6)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(16, Index(pp00, c009)) // Integer
	Store(12, Index(pp00, c01c)) // LOCAL_REFERENCE
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 63)
}

	// ======================== NoOp

if (rn00) {

	Store("NoOp", Debug)

	_TCI(c200, Local0)
	NoOp
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 64)
}

	RST0()
}
