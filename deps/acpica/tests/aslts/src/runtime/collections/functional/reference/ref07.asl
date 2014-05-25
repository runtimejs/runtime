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
 * References
 *
 * TEST, Package total
 */

Name(z116, 116)

/*
 * Flags and values used by m1c3
 */
Name(FL00, 0) // flag of testing of exceptions
Name(V000, 0) // type of the Standard Data object
Name(V001, 0) // index of element of Package

/*
 * Read immediate image element of Package
 *
 * Package specified by the immediate
 * images {Integer, String, Buffer, Package}.
 * Perform all the ways reading element of
 * Package passed by ArgX.
 */
Method(m1c1,, Serialized)
{
	Name(ppp0, Package(4) {
			0x77,
			"qwer0000",
			Buffer(4) {1,0x77,3,4},
			Package(3) {5,0x77,7}})

	Store(0, FL00)    // flag of testing of exceptions

	Store(c009, V000) // type of the Standard Data object
	Store(0, V001)    // index of element of Package
	m1c3(ppp0, 0, 0, 0, 0, 0, 0)

	Store(c00a, V000) // type of the Standard Data object
	Store(1, V001)    // index of element of Package
	m1c3(ppp0, 0, 0, 0, 0, 0, 0)

	Store(c00b, V000) // type of the Standard Data object
	Store(2, V001)    // index of element of Package
	m1c3(ppp0, 0, 0, 0, 0, 0, 0)

	Store(c00c, V000) // type of the Standard Data object
	Store(3, V001)    // index of element of Package
	m1c3(ppp0, 0, 0, 0, 0, 0, 0)
}

/*
 * Read NamedX element of Package
 * {Integer, String, Buffer, Package}.
 */
Method(m1c2,, Serialized)
{
	Name(ts, "m1c2")

	Name(i000, 0x77)
	Name(s000, "qwer0000")
	Name(b000, Buffer(4) {1,0x77,3,4})
	Name(p000, Package(3) {5,0x77,7})

	Name(ppp0, Package(4) {i000, s000, b000, p000})

	Store(0, FL00)    // flag of testing of exceptions

	Store(c009, V000) // type of the Standard Data object
	Store(0, V001)    // index of element of Package
	m1c3(ppp0, 0, 0, 0, 0, 0, 0)

	Store(c00a, V000) // type of the Standard Data object
	Store(1, V001)    // index of element of Package
	m1c3(ppp0, 0, 0, 0, 0, 0, 0)

	Store(c00b, V000) // type of the Standard Data object
	Store(2, V001)    // index of element of Package
	m1c3(ppp0, 0, 0, 0, 0, 0, 0)

	Store(c00c, V000) // type of the Standard Data object
	Store(3, V001)    // index of element of Package
	m1c3(ppp0, 0, 0, 0, 0, 0, 0)

	m380(ts, i000, 0, 0)
	m381(ts, s000, 0, 1)
	m382(ts, b000, 0, 2)
	m383(ts, p000, 0, 3)
}

// All the ways reading element of Package given by ArgX
// arg0 - Package
// arg1,
// arg2,
// arg3,
// arg4,
// arg5,
// arg6 - auxiliary, for arbitrary use
Method(m1c3, 7, Serialized)
{
	Name(ts, "m1c3")

	Name(i000, 0)
	Name(i001, 0)
	Name(i002, 0)
	Name(i003, 0)
	Name(i004, 0)
	Name(i005, 0)
	Name(i006, 0)

	Name(p000, Package(2) {})
	Name(ppp0, Package(2) {})


	// LocalX

	Store(Index(arg0, V001), Local3)
	m390(DerefOf(Local3), V000, 0, 4)
	Store(DerefOf(Local3), Local4)
	m390(Local4, V000, 0, 5)
	m390(DerefOf(Index(arg0, V001)), V000, 0, 6)
	Store(Index(arg0, V001, Local2), Local3)
	m390(DerefOf(Local3), V000, 0, 7)
	Store(DerefOf(Local3), Local4)
	m390(Local4, V000, 0, 8)
	m390(DerefOf(Local2), V000, 0, 9)
	Store(DerefOf(Local2), Local4)
	m390(Local4, V000, 0, 10)

	// ArgX

	Store(Index(arg0, V001), arg3)
	m390(DerefOf(arg3), V000, 0, 11)
	Store(DerefOf(arg3), arg4)
	m390(arg4, V000, 0, 12)
	m390(DerefOf(Index(arg0, V001)), V000, 0, 13)
	Store(Index(arg0, V001, arg2), arg3)
	m390(DerefOf(arg3), V000, 0, 14)
	Store(DerefOf(arg3), arg4)
	m390(arg4, V000, 0, 15)
	m390(DerefOf(arg2), V000, 0, 16)
	Store(DerefOf(arg2), arg4)
	m390(arg4, V000, 0, 17)

	// NamedX

	if (y127) {
		CopyObject(Index(ppp0, 0), i003)
		Store(Index(arg0, V001), i003)
		m390(DerefOf(i003), V000, 0, 18)
		Store(DerefOf(i003), i004)
		m390(i004, V000, 0, 19)
		m390(DerefOf(Index(arg0, V001)), V000, 0, 20)
		Store(Index(arg0, V001, i002), i003)
		m390(DerefOf(i003), V000, 0, 21)
		Store(DerefOf(i003), i004)
		m390(i004, V000, 0, 22)
		m390(DerefOf(i002), V000, 0, 23)
		Store(DerefOf(i002), i004)
		m390(i004, V000, 0, 24)
	}

	/*
	 * El_of_Package
	 *
	 * Identical to the first checking, but only
	 * store intermediately the references to element
	 * of Package arg0 Index(arg0, x) into Index(p000, y)
	 * but not into LocalX.
	 */

	Store(Index(arg0, V001, Index(p000, 0)), Index(p000, 1))

	// DerefOf(DerefOf(Index(x,Destination)))

	m390(DerefOf(DerefOf(Index(p000, 0))), V000, 0, 25)

	// DerefOf(DerefOf(Index(x,Result)))

	m390(DerefOf(DerefOf(Index(p000, 1))), V000, 0, 26)

	// El_of_Package, Destination, LocalX

	/*
	 * After Store(Index(p000, 0), Local5)
	 * Local5 below - reference to element of
	 * Package p000 containing reference to the
	 * 0-th element of Arg0-Package.
	 *
	 * Correspondingly, after Store(DerefOf(Local5), Local3)
	 * Local3 - reference to the 0-th element of Arg0-Package.
	 *
	 * Further, DerefOf(Local3) - 0-th element of Arg0-Package.
	 */

	if (FL00) {
		Store(Index(p000, 0), Local5)

		CH03(ts, z116, 0, 0, 0)
		Add(Local5, 1, Local6)
		CH04(ts, 0, 0xff, z116, 1, 0, 0)

		CH03(ts, z116, 2, 0, 0)
		Add(DerefOf(Local5), 1, Local6)
		CH04(ts, 0, 0xff, z116, 3, 0, 0)

		CH03(ts, z116, 4, 0, 0)
		m390(Local5, V000, 0, 0)
		CH04(ts, 0, 0xff, z116, 5, 0, 0)

		CH03(ts, z116, 6, 0, 0)
		m390(DerefOf(Local5), V000, 0, 0)
		CH04(ts, 0, 0xff, z116, 7, 0, 0)

		Store(Index(p000, 0, Local2), Local5)

		CH03(ts, z116, 8, 0, 0)
		Add(Local5, 1, Local6)
		CH04(ts, 0, 0xff, z116, 9, 0, 0)

		CH03(ts, z116, 10, 0, 0)
		Add(DerefOf(Local5), 1, Local6)
		CH04(ts, 0, 0xff, z116, 11, 0, 0)

		CH03(ts, z116, 12, 0, 0)
		m390(Local5, V000, 0, 0)
		CH04(ts, 0, 0xff, z116, 13, 0, 0)

		CH03(ts, z116, 14, 0, 0)
		m390(DerefOf(Local5), V000, 0, 0)
		CH04(ts, 0, 0xff, z116, 15, 0, 0)

		CH03(ts, z116, 16, 0, 0)
		Add(Local2, 1, Local6)
		CH04(ts, 0, 0xff, z116, 17, 0, 0)

		CH03(ts, z116, 18, 0, 0)
		Add(DerefOf(Local2), 1, Local6)
		CH04(ts, 0, 0xff, z116, 19, 0, 0)

		CH03(ts, z116, 20, 0, 0)
		m390(Local2, V000, 0, 0)
		CH04(ts, 0, 0xff, z116, 21, 0, 0)

		CH03(ts, z116, 22, 0, 0)
		m390(DerefOf(Local2), V000, 0, 0)
		CH04(ts, 0, 0xff, z116, 23, 0, 0)
	}

	if (q001) {

		Store(Index(p000, 0), Local5)

		Store(DerefOf(Local5), Local3)
		m390(DerefOf(Local3), V000, 0, 27)
		Store(DerefOf(Local3), Local4)
		m390(Local4, V000, 0, 28)

		Store(Index(p000, 0, Local2), Local5)

		Store(DerefOf(Local5), Local3)
		m390(DerefOf(Local3), V000, 0, 29)
		Store(DerefOf(Local3), Local4)
		m390(Local4, V000, 0, 30)

		Store(DerefOf(Local2), Local3)
		m390(DerefOf(Local3), V000, 0, 31)
		Store(DerefOf(Local3), Local4)
		m390(Local4, V000, 0, 32)

	} /* if(q001) */

	// El_of_Package, Result, LocalX

	if (FL00) {
		Store(Index(p000, 1), Local5)

		CH03(ts, z116, 24, 0, 0)
		Add(Local5, 1, Local6)
		CH04(ts, 0, 0xff, z116, 25, 0, 0)

		CH03(ts, z116, 26, 0, 0)
		Add(DerefOf(Local5), 1, Local6)
		CH04(ts, 0, 0xff, z116, 27, 0, 0)

		CH03(ts, z116, 28, 0, 0)
		m390(Local5, V000, 0, 33)
		CH04(ts, 0, 0xff, z116, 29, 0, 0)

		CH03(ts, z116, 30, 0, 0)
		m390(DerefOf(Local5), V000, 0, 34)
		CH04(ts, 0, 0xff, z116, 31, 0, 0)

		Store(Index(p000, 1, Local2), Local5)

		CH03(ts, z116, 32, 0, 0)
		Add(Local5, 1, Local6)
		CH04(ts, 0, 0xff, z116, 33, 0, 0)

		CH03(ts, z116, 34, 0, 0)
		Add(DerefOf(Local5), 1, Local6)
		CH04(ts, 0, 0xff, z116, 35, 0, 0)

		CH03(ts, z116, 36, 0, 0)
		m390(Local5, V000, 0, 35)
		CH04(ts, 0, 0xff, z116, 37, 0, 0)

		CH03(ts, z116, 38, 0, 0)
		m390(DerefOf(Local5), V000, 0, 36)
		CH04(ts, 0, 0xff, z116, 39, 0, 0)

		CH03(ts, z116, 40, 0, 0)
		Add(Local2, 1, Local6)
		CH04(ts, 0, 0xff, z116, 41, 0, 0)

		CH03(ts, z116, 42, 0, 0)
		Add(DerefOf(Local2), 1, Local6)
		CH04(ts, 0, 0xff, z116, 43, 0, 0)

		CH03(ts, z116, 44, 0, 0)
		m390(Local2, V000, 0, 37)
		CH04(ts, 0, 0xff, z116, 45, 0, 0)

		CH03(ts, z116, 46, 0, 0)
		m390(DerefOf(Local2), V000, 0, 38)
		CH04(ts, 0, 0xff, z116, 47, 0, 0)
	}

	if (q001) {

		Store(Index(p000, 1), Local5)

		Store(DerefOf(Local5), Local3)
		m390(DerefOf(Local3), V000, 0, 39)
		Store(DerefOf(Local3), Local4)
		m390(Local4, V000, 0, 40)

		Store(Index(p000, 1, Local2), Local5)

		Store(DerefOf(Local5), Local3)
		m390(DerefOf(Local3), V000, 0, 41)
		Store(DerefOf(Local3), Local4)
		m390(Local4, V000, 0, 42)

		Store(DerefOf(Local2), Local3)
		m390(DerefOf(Local3), V000, 0, 43)
		Store(DerefOf(Local3), Local4)
		m390(Local4, V000, 0, 44)

	} /* if(q001) */

	// El_of_Package, Destination, argX

	if (FL00) {
		Store(Index(p000, 0), arg5)

		CH03(ts, z116, 48, 0, 0)
		Add(arg5, 1, arg6)
		CH04(ts, 0, 0xff, z116, 49, 0, 0)

		CH03(ts, z116, 50, 0, 0)
		Add(DerefOf(arg5), 1, arg6)
		CH04(ts, 0, 0xff, z116, 51, 0, 0)

		CH03(ts, z116, 52, 0, 0)
		m390(arg5, V000, 0, 45)
		CH04(ts, 0, 0xff, z116, 53, 0, 0)

		CH03(ts, z116, 54, 0, 0)
		m390(DerefOf(arg5), V000, 0, 46)
		CH04(ts, 0, 0xff, z116, 55, 0, 0)

		Store(Index(p000, 0, arg2), arg5)

		CH03(ts, z116, 56, 0, 0)
		Add(arg5, 1, arg6)
		CH04(ts, 0, 0xff, z116, 57, 0, 0)

		CH03(ts, z116, 58, 0, 0)
		Add(DerefOf(arg5), 1, arg6)
		CH04(ts, 0, 0xff, z116, 59, 0, 0)

		CH03(ts, z116, 60, 0, 0)
		m390(arg5, V000, 0, 47)
		CH04(ts, 0, 0xff, z116, 61, 0, 0)

		CH03(ts, z116, 62, 0, 0)
		m390(DerefOf(arg5), V000, 0, 48)
		CH04(ts, 0, 0xff, z116, 63, 0, 0)

		CH03(ts, z116, 64, 0, 0)
		Add(arg2, 1, arg6)
		CH04(ts, 0, 0xff, z116, 65, 0, 0)

		CH03(ts, z116, 66, 0, 0)
		Add(DerefOf(arg2), 1, arg6)
		CH04(ts, 0, 0xff, z116, 67, 0, 0)

		CH03(ts, z116, 68, 0, 0)
		m390(arg2, V000, 0, 49)
		CH04(ts, 0, 0xff, z116, 69, 0, 0)

		CH03(ts, z116, 70, 0, 0)
		m390(DerefOf(arg2), V000, 0, 50)
		CH04(ts, 0, 0xff, z116, 71, 0, 0)
	}

	if (q001) {

		Store(Index(p000, 0), arg5)

		Store(DerefOf(arg5), arg3)
		m390(DerefOf(arg3), V000, 0, 51)
		Store(DerefOf(arg3), arg4)
		m390(arg4, V000, 0, 52)

		Store(Index(p000, 0, arg2), arg5)

		Store(DerefOf(arg5), arg3)
		m390(DerefOf(arg3), V000, 0, 53)
		Store(DerefOf(arg3), arg4)
		m390(arg4, V000, 0, 54)

		Store(DerefOf(arg2), arg3)
		m390(DerefOf(arg3), V000, 0, 55)
		Store(DerefOf(arg3), arg4)
		m390(arg4, V000, 0, 56)

	} /* if(q001) */

	// El_of_Package, Result, argX

	if (FL00) {
		Store(Index(p000, 1), arg5)

		CH03(ts, z116, 72, 0, 0)
		Add(arg5, 1, arg6)
		CH04(ts, 0, 0xff, z116, 73, 0, 0)

		CH03(ts, z116, 74, 0, 0)
		Add(DerefOf(arg5), 1, arg6)
		CH04(ts, 0, 0xff, z116, 75, 0, 0)

		CH03(ts, z116, 76, 0, 0)
		m390(arg5, V000, 0, 57)
		CH04(ts, 0, 0xff, z116, 77, 0, 0)

		CH03(ts, z116, 78, 0, 0)
		m390(DerefOf(arg5), V000, 0, 58)
		CH04(ts, 0, 0xff, z116, 79, 0, 0)

		Store(Index(p000, 1, arg2), arg5)

		CH03(ts, z116, 80, 0, 0)
		Add(arg5, 1, arg6)
		CH04(ts, 0, 0xff, z116, 81, 0, 0)

		CH03(ts, z116, 82, 0, 0)
		Add(DerefOf(arg5), 1, arg6)
		CH04(ts, 0, 0xff, z116, 83, 0, 0)

		CH03(ts, z116, 84, 0, 0)
		m390(arg5, V000, 0, 59)
		CH04(ts, 0, 0xff, z116, 85, 0, 0)

		CH03(ts, z116, 86, 0, 0)
		m390(DerefOf(arg5), V000, 0, 60)
		CH04(ts, 0, 0xff, z116, 87, 0, 0)

		CH03(ts, z116, 88, 0, 0)
		Add(arg2, 1, arg6)
		CH04(ts, 0, 0xff, z116, 89, 0, 0)

		CH03(ts, z116, 90, 0, 0)
		Add(DerefOf(arg2), 1, arg6)
		CH04(ts, 0, 0xff, z116, 91, 0, 0)

		CH03(ts, z116, 92, 0, 0)
		m390(arg2, V000, 0, 61)
		CH04(ts, 0, 0xff, z116, 93, 0, 0)

		CH03(ts, z116, 94, 0, 0)
		m390(DerefOf(arg2), V000, 0, 62)
		CH04(ts, 0, 0xff, z116, 95, 0, 0)
	}

	if (q001) {

		Store(Index(p000, 1), arg5)

		Store(DerefOf(arg5), arg3)
		m390(DerefOf(arg3), V000, 0, 63)
		Store(DerefOf(arg3), arg4)
		m390(arg4, V000, 0, 64)

		Store(Index(p000, 1, arg2), arg5)

		Store(DerefOf(arg5), arg3)
		m390(DerefOf(arg3), V000, 0, 65)
		Store(DerefOf(arg3), arg4)
		m390(arg4, V000, 0, 66)

		Store(DerefOf(arg2), arg3)
		m390(DerefOf(arg3), V000, 0, 67)
		Store(DerefOf(arg3), arg4)
		m390(arg4, V000, 0, 68)

	} /* if(q001) */

	if (y127) {

	// El_of_Package, Destination, NamedX

	if (FL00) {
		CopyObject(Index(ppp0, 0), i005)
		Store(Index(p000, 0), i005)

		CH03(ts, z116, 96, 0, 0)
		Add(i005, 1, i006)
		CH04(ts, 0, 0xff, z116, 97, 0, 0)

		CH03(ts, z116, 98, 0, 0)
		Add(DerefOf(i005), 1, i006)
		CH04(ts, 0, 0xff, z116, 99, 0, 0)

		CH03(ts, z116, 100, 0, 0)
		m390(i005, V000, 0, 69)
		CH04(ts, 0, 0xff, z116, 101, 0, 0)

		CH03(ts, z116, 102, 0, 0)
		m390(DerefOf(i005), V000, 0, 70)
		CH04(ts, 0, 0xff, z116, 103, 0, 0)

		Store(Index(p000, 0, i002), i005)

		CH03(ts, z116, 104, 0, 0)
		Add(i005, 1, i006)
		CH04(ts, 0, 0xff, z116, 105, 0, 0)

		CH03(ts, z116, 106, 0, 0)
		Add(DerefOf(i005), 1, i006)
		CH04(ts, 0, 0xff, z116, 107, 0, 0)

		CH03(ts, z116, 108, 0, 0)
		m390(i005, V000, 0, 71)
		CH04(ts, 0, 0xff, z116, 109, 0, 0)

		CH03(ts, z116, 110, 0, 0)
		m390(DerefOf(i005), V000, 0, 72)
		CH04(ts, 0, 0xff, z116, 111, 0, 0)

		CH03(ts, z116, 112, 0, 0)
		Add(i002, 1, i006)
		CH04(ts, 0, 0xff, z116, 113, 0, 0)

		CH03(ts, z116, 114, 0, 0)
		Add(DerefOf(i002), 1, i006)
		CH04(ts, 0, 0xff, z116, 115, 0, 0)

		CH03(ts, z116, 116, 0, 0)
		m390(i002, V000, 0, 73)
		CH04(ts, 0, 0xff, z116, 117, 0, 0)

		CH03(ts, z116, 118, 0, 0)
		m390(DerefOf(i002), V000, 0, 74)
		CH04(ts, 0, 0xff, z116, 119, 0, 0)
	}

	if (q001) {

		Store(Index(p000, 0), i005)

		Store(DerefOf(i005), i003)
		m390(DerefOf(i003), V000, 0, 75)
		Store(DerefOf(i003), i004)
		m390(i004, V000, 0, 76)

		Store(Index(p000, 0, i002), i005)

		Store(DerefOf(i005), i003)
		m390(DerefOf(i003), V000, 0, 77)
		Store(DerefOf(i003), i004)
		m390(i004, V000, 0, 78)

		Store(DerefOf(i002), i003)
		m390(DerefOf(i003), V000, 0, 79)
		Store(DerefOf(i003), i004)
		m390(i004, V000, 0, 80)

	} /* if(q001) */

	// El_of_Package, Result, NamedX

	if (FL00) {
		Store(Index(p000, 1), i005)

		CH03(ts, z116, 120, 0, 0)
		Add(i005, 1, i006)
		CH04(ts, 0, 0xff, z116, 121, 0, 0)

		CH03(ts, z116, 122, 0, 0)
		Add(DerefOf(i005), 1, i006)
		CH04(ts, 0, 0xff, z116, 123, 0, 0)

		CH03(ts, z116, 124, 0, 0)
		m390(i005, V000, 0, 81)
		CH04(ts, 0, 0xff, z116, 125, 0, 0)

		CH03(ts, z116, 126, 0, 0)
		m390(DerefOf(i005), V000, 0, 82)
		CH04(ts, 0, 0xff, z116, 127, 0, 0)

		Store(Index(p000, 1, i002), i005)

		CH03(ts, z116, 128, 0, 0)
		Add(i005, 1, i006)
		CH04(ts, 0, 0xff, z116, 129, 0, 0)

		CH03(ts, z116, 130, 0, 0)
		Add(DerefOf(i005), 1, i006)
		CH04(ts, 0, 0xff, z116, 131, 0, 0)

		CH03(ts, z116, 132, 0, 0)
		m390(i005, V000, 0, 83)
		CH04(ts, 0, 0xff, z116, 133, 0, 0)

		CH03(ts, z116, 134, 0, 0)
		m390(DerefOf(i005), V000, 0, 84)
		CH04(ts, 0, 0xff, z116, 135, 0, 0)

		CH03(ts, z116, 136, 0, 0)
		Add(i002, 1, i006)
		CH04(ts, 0, 0xff, z116, 137, 0, 0)

		CH03(ts, z116, 138, 0, 0)
		Add(DerefOf(i002), 1, i006)
		CH04(ts, 0, 0xff, z116, 139, 0, 0)

		CH03(ts, z116, 140, 0, 0)
		m390(i002, V000, 0, 85)
		CH04(ts, 0, 0xff, z116, 141, 0, 0)

		CH03(ts, z116, 142, 0, 0)
		m390(DerefOf(i002), V000, 0, 86)
		CH04(ts, 0, 0xff, z116, 143, 0, 0)
	}

	if (q001) {

		Store(Index(p000, 1), i005)

		Store(DerefOf(i005), i003)
		m390(DerefOf(i003), V000, 0, 87)
		Store(DerefOf(i003), i004)
		m390(i004, V000, 0, 88)

		Store(Index(p000, 1, i002), i005)

		Store(DerefOf(i005), i003)
		m390(DerefOf(i003), V000, 0, 89)
		Store(DerefOf(i003), i004)
		m390(i004, V000, 0, 90)

		Store(DerefOf(i002), i003)
		m390(DerefOf(i003), V000, 0, 91)
		Store(DerefOf(i003), i004)
		m390(i004, V000, 0, 92)

	} /* if(q001) */
	} /* if(y127) */
}

// Check Uninitialized element of Package
Method(m1c4,, Serialized)
{
	Name(ppp0, Package(10) {
			0x77,
			"qwer0000",
			Buffer(4) {1,0x77,3,4},
			Package(3) {5,0x77,7}})

	Method(m000, 2)
	{
		Store(Index(arg0, arg1), Local0)
		m1a3(Local0, c008, z116, "m1c4", 93)
	}

	m000(ppp0, 4)
	m000(ppp0, 5)
	m000(ppp0, 6)
	m000(ppp0, 7)
	m000(ppp0, 8)
	m000(ppp0, 9)
}

// The chain of Index_References
Method(m1c5,, Serialized)
{
	Name(ppp0, Package(4) {
			0x77,
			"qwer0000",
			Buffer(4) {1,0x77,3,4},
			Package(3) {5,0x77,7}})

	Name(p000, Package(20) {})

	Store(Index(ppp0, 0), Index(p000, 0))
	m390(DerefOf(DerefOf(Index(p000, 0))), c009, z116, 94)

	if (q002) {
		Store(Index(p000, 0), Index(p000, 1))
		m390(DerefOf(DerefOf(DerefOf(Index(p000, 1)))), c009, z116, 95)

		Store(Index(p000, 1), Index(p000, 2))
		m390(DerefOf(DerefOf(DerefOf(DerefOf(Index(p000, 2))))), c009, z116, 96)

		Store(Index(p000, 2), Index(p000, 3))
		m390(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(Index(p000, 3)))))), c009, z116, 97)

		Store(Index(p000, 3), Index(p000, 4))
		m390(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(Index(p000, 4))))))), c009, z116, 98)

		Store(Index(p000, 4), Index(p000, 5))
		m390(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(Index(p000, 5)))))))), c009, z116, 99)

		Store(Index(p000, 5), Index(p000, 6))
		m390(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(Index(p000, 6))))))))), c009, z116, 100)

		Store(Index(p000, 6), Index(p000, 7))
		m390(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(Index(p000, 7)))))))))), c009, z116, 101)
	}

	m390(DerefOf(DerefOf(Index(p000, 0))), c009, z116, 102)

	if (q002) {
		m390(DerefOf(DerefOf(DerefOf(Index(p000, 1)))), c009, z116, 103)
		m390(DerefOf(DerefOf(DerefOf(DerefOf(Index(p000, 2))))), c009, z116, 104)
		m390(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(Index(p000, 3)))))), c009, z116, 105)
		m390(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(Index(p000, 4))))))), c009, z116, 106)
		m390(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(Index(p000, 5)))))))), c009, z116, 107)
		m390(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(Index(p000, 6))))))))), c009, z116, 108)
		m390(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(DerefOf(Index(p000, 7)))))))))), c009, z116, 109)
	}
}

// Access to the Method named object element of Package

// Methods without parameters
Method(m1c7,, Serialized)
{
	Name(ts, "m1c7")

	Name(i000, 0x77)
	Method(m000) {
		Store(0, i000)
	}
	Method(m001) {
		Store(1, i000)
		return (0x12345678)
	}

	Method(m002) {
		Store(0, i000)
	}
	Method(m003) {
		Store(1, i000)
		return (0x12345678)
	}

	Name(p000, Package() {m000, m001, m002, m003,
					m000, m001, m002, m003,
					i000, i000})


	Store(Index(p000, 0), Local0)
	m1a3(Local0, c010, z116, ts, 110)

	Store(Index(p000, 1), Local0)
	m1a3(Local0, c010, z116, ts, 111)

	Store(Index(p000, 2), Local0)
	m1a3(Local0, c010, z116, ts, 112)

	Store(Index(p000, 3), Local0)
	m1a3(Local0, c010, z116, ts, 113)

	Store(Index(p000, 4), Local0)
	m1a3(Local0, c010, z116, ts, 114)

	Store(Index(p000, 5), Local0)
	m1a3(Local0, c010, z116, ts, 115)

	Store(Index(p000, 6), Local0)
	m1a3(Local0, c010, z116, ts, 116)

	Store(Index(p000, 7), Local0)
	m1a3(Local0, c010, z116, ts, 117)

	Store(Index(p000, 8), Local0)
	m1a3(Local0, c009, z116, ts, 118)

	Store(Index(p000, 9), Local0)
	m1a3(Local0, c009, z116, ts, 119)

	m380(ts, i000, 0, 0)
}

// CURRENTLY: compiler failed, Too few arguments (M002 requires X)
// Methods with parameters
Method(m1c8,, Serialized)
{
	Name(ts, "m1c8")

/*
	Name(i000, 0x77)
	Method(m000) {
		Store(0, i000)
	}
	Method(m001) {
		Store(1, i000)
		return (0x12345678)
	}

	Method(m002, 1) {
		Store(arg0, i000)
		Store(0, i000)
	}
	Method(m003, 7) {
		Store(arg0, i000)
		Store(arg1, i000)
		Store(arg2, i000)
		Store(arg3, i000)
		Store(arg4, i000)
		Store(arg5, i000)
		Store(arg6, i000)
		Store(1, i000)
		return (0x12345678)
	}


	Name(p000, Package() {m000, m001, m002, m003,
					m000, m001, m002, m003,
					i000, i000})


	Store(Index(p000, 0), Local0)
	m1a3(Local0, c010, z116, ts, `120)

	Store(Index(p000, 1), Local0)
	m1a3(Local0, c010, z116, ts, 121)

	Store(Index(p000, 2), Local0)
	m1a3(Local0, c010, z116, ts, 122)

	Store(Index(p000, 3), Local0)
	m1a3(Local0, c010, z116, ts, 123)

	Store(Index(p000, 4), Local0)
	m1a3(Local0, c010, z116, ts, 124)

	Store(Index(p000, 5), Local0)
	m1a3(Local0, c010, z116, ts, 125)

	Store(Index(p000, 6), Local0)
	m1a3(Local0, c010, z116, ts, 126)

	Store(Index(p000, 7), Local0)
	m1a3(Local0, c010, z116, ts, 127)

	Store(Index(p000, 8), Local0)
	m1a3(Local0, c009, z116, ts, 128)

	Store(Index(p000, 9), Local0)
	m1a3(Local0, c009, z116, ts, 129)

	m380(ts, i000, 0, 130)
*/
}

// DerefOf of the Method named object element of Package
Method(m1c9,, Serialized)
{
	Name(ts, "m1c9")

	Name(i000, 0x77)
	Method(m000) {
		Store(0, i000)
	}
	Method(m001) {
		Store(1, i000)
		return (0x12345678)
	}

	Method(m002) {
		Store(0, i000)
	}
	Method(m003) {
		Store(1, i000)
		return (0x12345678)
	}

	Name(p000, Package() {m000, m001, m002, m003,
					m000, m001, m002, m003,
					i000, i000})


	Store(Index(p000, 0), Local0)
	m1a3(Local0, c010, z116, ts, 131)
	CH03(ts, z116, 144, 0, 0)
	Store(DerefOf(Local0), Local1)
	CH04(ts, 0, 0xff, z116, 145, 0, 0)

	Store(Index(p000, 1), Local0)
	m1a3(Local0, c010, z116, ts, 132)
	CH03(ts, z116, 146, 0, 0)
	Store(DerefOf(Local0), Local1)
	CH04(ts, 0, 0xff, z116, 147, 0, 0)

	Store(Index(p000, 2), Local0)
	m1a3(Local0, c010, z116, ts, 133)
	CH03(ts, z116, 148, 0, 0)
	Store(DerefOf(Local0), Local1)
	CH04(ts, 0, 0xff, z116, 149, 0, 0)

	Store(Index(p000, 3), Local0)
	m1a3(Local0, c010, z116, ts, 134)
	CH03(ts, z116, 150, 0, 0)
	Store(DerefOf(Local0), Local1)
	CH04(ts, 0, 0xff, z116, 151, 0, 0)

	Store(Index(p000, 4), Local0)
	m1a3(Local0, c010, z116, ts, 135)
	CH03(ts, z116, 152, 0, 0)
	Store(DerefOf(Local0), Local1)
	CH04(ts, 0, 0xff, z116, 153, 0, 0)

	Store(Index(p000, 5), Local0)
	m1a3(Local0, c010, z116, ts, 136)
	CH03(ts, z116, 154, 0, 0)
	Store(DerefOf(Local0), Local1)
	CH04(ts, 0, 0xff, z116, 155, 0, 0)

	Store(Index(p000, 6), Local0)
	m1a3(Local0, c010, z116, ts, 137)
	CH03(ts, z116, 156, 0, 0)
	Store(DerefOf(Local0), Local1)
	CH04(ts, 0, 0xff, z116, 157, 0, 0)

	Store(Index(p000, 7), Local0)
	m1a3(Local0, c010, z116, ts, 138)
	CH03(ts, z116, 158, 0, 0)
	Store(DerefOf(Local0), Local1)
	CH04(ts, 0, 0xff, z116, 159, 0, 0)

	m380(ts, i000, 0, 139)
}

// Size of Package
Method(m1ca,, Serialized)
{
	Name(ts, "m1ca")

	Method(m000, 1, Serialized)
	{
		Name(p000, Package(arg0) {})

		CH03(ts, z116, 160, 0, 0)
		Store(Index(p000, arg0), Local0)
		CH04(ts, 0, 0xff, z116, 161, 0, 0)
	}

	Method(m001, 1, Serialized)
	{
		Name(p000, Package(Arg0) {})

		Name(lpN0, 0)
		Name(lpC0, 0)

		// Write each element of Package with its index

		Store(arg0, lpN0)
		Store(0, lpC0)

		While (lpN0) {
			Store(lpC0, Index(p000, lpC0))
			Decrement(lpN0)
			Increment(lpC0)
		}

		// Verify each element of Package

		Store(arg0, lpN0)
		Store(0, lpC0)

		While (lpN0) {
			Store(Index(p000, lpC0), Local0)
			Store(DerefOf(Local0), Local1)
			if (LNotEqual(Local1, lpC0)) {
				err(ts, z116, 0, z116, 0, Local1, lpC0)
				break
			}
			Decrement(lpN0)
			Increment(lpC0)
		}
	}

	Method(m003,, Serialized)
	{
		Name(p000, Package(2) {})

		CH03(ts, z116, 162, 0, 0)
		Store(Index(p000, 2), Local0)
		CH04(ts, 0, 0xff, z116, 163, 0, 0)
	}

	Method(m004,, Serialized)
	{
		Name(p000, Package(255) {})

		CH03(ts, z116, 164, 0, 0)
		Store(Index(p000, 255), Local0)
		CH04(ts, 0, 0xff, z116, 165, 0, 0)
	}

	// Size not greater than 255

	m000(1)
	m000(8)
	m000(127)
	m000(255)

	m003()
	m004()

	// VarPackage: size of Package greater than 255
	// (bug 129, not a bug)

	m001(256)
}

// Size of Package, see comma "6,})"
Method(m1cb,, Serialized)
{
	Name(ts, "m1cb")

	Name(p000, Package() {1,2,3,4,5,6,})

	Store(SizeOf(p000), Local0)
	if (LNotEqual(Local0, 6)) {
		err(ts, z116, 1, 0, 0, Local0, 6)
	}
}

// Check the read automatic dereference
// arg0 - name of Method initiating the checking
// arg1 - Oref or IRef
// arg2 - expected value
// arg3 - exception is expected
Method(m1cc, 4)
{
	CH03(arg0, z116, 166, 0, 0)

	Store(arg1, Local0)
	Add(Local0, 1, Local7)

	if (LNotEqual(Local7, arg2)) {
		err(arg0, z116, 2, 0, 0, Local7, arg2)
	}

	CH03(arg0, z116, 167, 0, 0)
}

// Check the read automatic dereference
// arg0 - name of Method initiating the checking
// arg1 - Oref or IRef
// arg2 - expected value
// arg3 - exception is expected
Method(m1cd, 4)
{
	CH03(arg0, z116, 168, 0, 0)

	Add(arg1, 1, Local7)

	if (LNotEqual(Local7, arg2)) {
		err(arg0, z116, 3, 0, 0, Local7, arg2)
	}

	CH03(arg0, z116, 169, 0, 0)
}

// Check the read automatic dereference
// when accessing element of Package.

Method(m1ce,, Serialized)
{
	Name(ts, "m1ce")

	Name(p000, Package(1) {0x77})

	m1cc(ts, Index(p000, 0, Local0), 0x78, 0)
	m1cd(ts, Index(p000, 0), 0x78, 0)
}

Method(m1cf,, Serialized)
{
	Name(ts, "m1cf")

	Name(p000, Package(1) {0x77})

	Index(p000, 0, Local0)
	m1cc(ts, Local0, 0x78, 0)
	m1cd(ts, Local0, 0x78, 0)

	Store(Index(p000, 0, Local0), Local1)
	m1cc(ts, Local0, 0x78, 0)
	m1cd(ts, Local0, 0x78, 0)

	m1cc(ts, Local1, 0x78, 0)
	m1cd(ts, Local1, 0x78, 0)
}

Method(m1d0,, Serialized)
{
	Name(ts, "m1d0")

	Name(p000, Package(1) {0x77})

	CopyObject(Index(p000, 0, Local0), Local1)
	m1cc(ts, Local0, 0x78, 0)
	m1cd(ts, Local0, 0x78, 0)

	m1cc(ts, Local1, 0x78, 0)
	m1cd(ts, Local1, 0x78, 0)
}


// EXCEPTIONS


// ref07.asl 1093: Add(Index(p000, 0, Local0), 1, Local7)
// Error 1035 -    Invalid type ^  ([Reference] found,
//                   Add operator requires [Integer|String|Buffer])
/*
 * Method(m1d1)
 * {
 *	Name(p000, Package(1) {0x77})
 *	CH03(ts, z116, 170, 0, 0)
 *	Add(Index(p000, 0, Local0), 1, Local7)
 *	CH04(ts, 0, 0xff, z116, 171, 0, 0)
 * }
 */

// LocalX

Method(m1d1,, Serialized)
{
	Name(ts, "m1d1")

	Name(p000, Package(1) {0x77})

	Store(Index(p000, 0, Local0), Local1)

	CH03(ts, z116, 172, 0, 0)

	Add(Local0, 1, Local7)

	CH04(ts, 0, 0xff, z116, 173, 0, 0)

	Add(Local1, 1, Local7)

	CH04(ts, 0, 0xff, z116, 174, 0, 0)
}

Method(m1d2,, Serialized)
{
	Name(ts, "m1d2")

	Name(p000, Package(1) {0x77})

	CopyObject(Index(p000, 0, Local0), Local1)

	CH03(ts, z116, 175, 0, 0)

	Add(Local0, 1, Local7)

	CH04(ts, 0, 0xff, z116, 176, 0, 0)

	Add(Local1, 1, Local7)

	CH04(ts, 0, 0xff, z116, 177, 0, 0)
}

// ArgX

Method(m1d3, 2, Serialized)
{
	Name(ts, "m1d3")

	Name(p000, Package(1) {0x77})

	Store(Index(p000, 0, Arg0), Arg1)

	CH03(ts, z116, 178, 0, 0)

	Add(Arg0, 1, Local7)

	CH04(ts, 0, 0xff, z116, 179, 0, 0)

	Add(Arg1, 1, Local7)

	CH04(ts, 0, 0xff, z116, 180, 0, 0)
}

Method(m1d4, 2, Serialized)
{
	Name(ts, "m1d4")

	Name(p000, Package(1) {0x77})

	CopyObject(Index(p000, 0, Arg0), Arg1)

	CH03(ts, z116, 181, 0, 0)

	Add(Arg0, 1, Local7)

	CH04(ts, 0, 0xff, z116, 182, 0, 0)

	// Type of Arg1 should be IRef here,
	// so, exception is expected.

	Add(Arg1, 1, Local7)

	CH04(ts, 0, 0xff, z116, 183, 0, 0)
}

// NamedX

Method(m1d5,, Serialized)
{
	Name(ts, "m1d5")
	Name(i001, 0)
	Name(p000, Package(2) {0x77, 0x88})

	Name(sw00, 1)

	Name(hg00, 0) // if non-zero - the test hangs
	Name(hg01, 0) // if non-zero - the test hangs
	Name(hg02, 0) // if non-zero - the test hangs

	CH03(ts, z116, 184, 0, 0)

	CopyObject(Index(p000, 1, Local0), i001)

	CH03(ts, z116, 185, 0, 0)

	// Type of i001 should be already IRef here,
	// so, don't expect exception.

	Store(Index(p000, 0, Local0), i001)

	CH03(ts, z116, 186, 0, 0)

	Add(Local0, 1, Local7)

	if (y248) {
		Store(1, hg00)
		Store(1, hg01)
		Store(1, hg02)
	}

	/*
	 * To show visually the consequences of the anomaly
	 * run one of code below. They cause hang.
	 */
	if (hg00) {
		// Infinite loop of printing
		Store(0, Local1)
		Store(Local0, debug)
	}
	if (hg01) {
		// Infinite loop of printing
		Store(Local0, debug)
		Store(Local0, debug)
	}
	if (hg02) {
		Store(0, Local1)

		Store("============== sit 2:", debug)

		Store(ObjectType(Local0), Local7)
		Store(Local7, debug)
	}

	CH04(ts, 0, 0xff, z116, 187, 0, 0)

	Add(i001, 1, Local7)

	CH04(ts, 0, 0xff, z116, 188, 0, 0)

	/*
	 * Looks identical to b248: "Incorrect ReferenceCount on Switch operation":
	 *
	 * Reference count of Local0 is mistakenly zeroed there too.
	 *
	 * [ACPI Debug]  String: [0x0F] "<-------- 0000>"
	 * [ACPI Debug]  Reference: [Debug]
	 * [ACPI Debug]  String: [0x0F] "<-------- 1111>"
	 *
	 * [ACPI Debug]  String: [0x0F] "<-------- 0000>"
	 * [ACPI Debug]  [ACPI Debug]  String: [0x0F] "<-------- 1111>"
	 */
	Store("<-------- 0000>", debug)
	Store(Local0, debug)
	Store("<-------- 1111>", debug)
}

Method(m1d6,, Serialized)
{
	Name(ts, "m1d6")

	Name(i001, 0)

	Name(p000, Package(1) {0x77})

	CH03(ts, z116, 189, 0, 0)

	CopyObject(Index(p000, 0, Local0), i001)

	CH03(ts, z116, 190, 0, 0)

	Add(i001, 1, Local7)

	CH04(ts, 0, 0xff, z116, 192, 0, 0)
}

// Out of Package

Method(m1d7,, Serialized)
{
	Name(ts, "m1d7")

	Name(p000, Package(1) {0x77})

	CH03(ts, z116, 193, 0, 0)

	Store(Index(p000, 1), Local0)

	CH04(ts, 0, 0xff, z116, 194, 0, 0)

	Store(Index(p000, 1, Local0), Local1)

	CH04(ts, 0, 0xff, z116, 195, 0, 0)
}

Method(m1d8,, Serialized)
{
	Name(ts, "m1d8")

	Name(p000, Package(1) {0x77})

	CH03(ts, z116, 196, 0, 0)

	CopyObject(Index(p000, 1), Local0)

	CH04(ts, 0, 0xff, z116, 197, 0, 0)

	CopyObject(Index(p000, 1, Local0), Local1)

	CH04(ts, 0, 0xff, z116, 198, 0, 0)
}

Method(m1db,, Serialized)
{
	Name(ts, "m1db")

	Name(i001, 0)

	Name(p000, Package(2) {0x77, 0x88})

	CH03(ts, z116, 199, 0, 0)

	CopyObject(Index(p000, 1), i001)

	CH03(ts, z116, 200, 0, 0)

	// Type of i001 should be already IRef here,
	// so, don't expect exception. Writing to i001
	// is here identical to Store into it.

	Index(p000, 0, i001)

	CH03(ts, z116, 201, 0, 0)

	Add(i001, 1, Local7)

	CH04(ts, 0, 0xff, z116, 202, 0, 0)
}


// WRITE


Method(m1d9,, Serialized)
{
	Name(p000, Package(3) {5,0,7})

	Method(m000, 1)
	{
		Add(0x76, 1, Local0)
		Store(Local0, arg0)
	}

	m000(Index(p000, 1))
	m383("m1d9", p000, z116, 140)
}

Method(m1da,, Serialized)
{
	Name(p000, Package(3) {5,0,7})

	Method(m000, 1)
	{
		Add(0x76, 1, arg0)
	}

	m000(Index(p000, 1))
	m383("m1da", p000, z116, 141)
}


