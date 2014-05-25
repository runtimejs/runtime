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
 * Data type conversion and manipulation
 *
 * Find Object Match (check for Integer values)
 */

Name(z038, 38)

// The depth of testing flag
Name(c099, 0)

// Match operator wrapper
Method(m306, 6, Serialized)	// SPkg, Op1, MO1, Op2, MO2, SInd
{
	switch (ToInteger (arg1)) {
		case (0) {
			switch (ToInteger (arg3)) {
				case (0) {
					Store(Match(arg0, MTR, arg2, MTR, arg4, arg5), Local0)
				}
				case (1) {
					Store(Match(arg0, MTR, arg2, MEQ, arg4, arg5), Local0)
				}
				case (2) {
					Store(Match(arg0, MTR, arg2, MLE, arg4, arg5), Local0)
				}
				case (3) {
					Store(Match(arg0, MTR, arg2, MLT, arg4, arg5), Local0)
				}
				case (4) {
					Store(Match(arg0, MTR, arg2, MGE, arg4, arg5), Local0)
				}
				case (5) {
					Store(Match(arg0, MTR, arg2, MGT, arg4, arg5), Local0)
				}
			}
		}
		case (1) {
			switch (ToInteger (arg3)) {
				case (0) {
					Store(Match(arg0, MEQ, arg2, MTR, arg4, arg5), Local0)
				}
				case (1) {
					Store(Match(arg0, MEQ, arg2, MEQ, arg4, arg5), Local0)
				}
				case (2) {
					Store(Match(arg0, MEQ, arg2, MLE, arg4, arg5), Local0)
				}
				case (3) {
					Store(Match(arg0, MEQ, arg2, MLT, arg4, arg5), Local0)
				}
				case (4) {
					Store(Match(arg0, MEQ, arg2, MGE, arg4, arg5), Local0)
				}
				case (5) {
					Store(Match(arg0, MEQ, arg2, MGT, arg4, arg5), Local0)
				}
			}
		}
		case (2) {
			switch (ToInteger (arg3)) {
				case (0) {
					Store(Match(arg0, MLE, arg2, MTR, arg4, arg5), Local0)
				}
				case (1) {
					Store(Match(arg0, MLE, arg2, MEQ, arg4, arg5), Local0)
				}
				case (2) {
					Store(Match(arg0, MLE, arg2, MLE, arg4, arg5), Local0)
				}
				case (3) {
					Store(Match(arg0, MLE, arg2, MLT, arg4, arg5), Local0)
				}
				case (4) {
					Store(Match(arg0, MLE, arg2, MGE, arg4, arg5), Local0)
				}
				case (5) {
					Store(Match(arg0, MLE, arg2, MGT, arg4, arg5), Local0)
				}
			}
		}
		case (3) {
			switch (ToInteger (arg3)) {
				case (0) {
					Store(Match(arg0, MLT, arg2, MTR, arg4, arg5), Local0)
				}
				case (1) {
					Store(Match(arg0, MLT, arg2, MEQ, arg4, arg5), Local0)
				}
				case (2) {
					Store(Match(arg0, MLT, arg2, MLE, arg4, arg5), Local0)
				}
				case (3) {
					Store(Match(arg0, MLT, arg2, MLT, arg4, arg5), Local0)
				}
				case (4) {
					Store(Match(arg0, MLT, arg2, MGE, arg4, arg5), Local0)
				}
				case (5) {
					Store(Match(arg0, MLT, arg2, MGT, arg4, arg5), Local0)
				}
			}
		}
		case (4) {
			switch (ToInteger (arg3)) {
				case (0) {
					Store(Match(arg0, MGE, arg2, MTR, arg4, arg5), Local0)
				}
				case (1) {
					Store(Match(arg0, MGE, arg2, MEQ, arg4, arg5), Local0)
				}
				case (2) {
					Store(Match(arg0, MGE, arg2, MLE, arg4, arg5), Local0)
				}
				case (3) {
					Store(Match(arg0, MGE, arg2, MLT, arg4, arg5), Local0)
				}
				case (4) {
					Store(Match(arg0, MGE, arg2, MGE, arg4, arg5), Local0)
				}
				case (5) {
					Store(Match(arg0, MGE, arg2, MGT, arg4, arg5), Local0)
				}
			}
		}
		case (5) {
			switch (ToInteger (arg3)) {
				case (0) {
					Store(Match(arg0, MGT, arg2, MTR, arg4, arg5), Local0)
				}
				case (1) {
					Store(Match(arg0, MGT, arg2, MEQ, arg4, arg5), Local0)
				}
				case (2) {
					Store(Match(arg0, MGT, arg2, MLE, arg4, arg5), Local0)
				}
				case (3) {
					Store(Match(arg0, MGT, arg2, MLT, arg4, arg5), Local0)
				}
				case (4) {
					Store(Match(arg0, MGT, arg2, MGE, arg4, arg5), Local0)
				}
				case (5) {
					Store(Match(arg0, MGT, arg2, MGT, arg4, arg5), Local0)
				}
			}
		}
	}
	return (Local0)
}

// Test engine
// arg0 - test name
// arg1 - number of the test cases in the test parameters package
// arg2 - search package name
// arg3 - test parameters package
// arg4 - benchmark package
// arg5 - search package
// arg6 - to do transposition of match objects flag
Method(m308, 7, Serialized)
{
	Name(lpN0, 0)
	Name(lpC0, 0)

	Name(lpN1, 0)
	Name(lpC1, 0)
	Name(lpC2, 0)

	Store(arg1, lpN0)
	Store(0, lpC0)

	While(lpN0) {

		// Operands

		Multiply(lpC0, 3, Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local1)
		Increment(Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local3)
		Increment(Local6)
		Store(DeRefOf(Index(arg3, Local6)), Local4)

		// Expected result package

		Store(DeRefOf(Index(arg4, lpC0)), Local5)

		Store(36, lpN1)
		Store(0, lpC1)

		While(lpN1) {
			Divide(lpC1, 6, Local2, Local0)

			// Expected result

			Store(DeRefOf(Index(Local5, lpC1)), Local7)

			Store(m306(arg5, Local0, Local1, Local2, Local3, Local4), Local6)
			if (LNotEqual(Local7, Local6)) {
				err("err 1", z038, lpC0, 0, 0, lpC1, arg2)
			}

			if (LAnd(arg6, LNotEqual(Local1, Local3))) {
				// Transpose match objects

				// Expected result

				Add(Multiply(Local2, 6), Local0, lpC2)
				Store(DeRefOf(Index(Local5, lpC2)), Local7)

				Store(m306(arg5, Local0, Local3, Local2, Local1, Local4), Local6)
				if (LNotEqual(Local7, Local6)) {
					err("err 2", z038, Add(lpC0, 36), 0, 0, lpC2, arg2)
				}
			}

			Decrement(lpN1)
			Increment(lpC1)
		}
		Decrement(lpN0)
		Increment(lpC0)
	}
}

// Search package
Name(p370, Package() {
	26, 11, 19, 14, 12, 35, 38, 29, 31, 23, 18, 32,
})

// Test parameters package,
// array of triples: MO1, MO2, SInd
Name(p371, Package()
{
	0, 0, 0,
	0, 40, 0,
	40, 40, 0,
	13, 13, 0,
	14, 14, 0,
	15, 15, 0,
	0, 13, 0,
	0, 14, 0,
	0, 15, 0,
	13, 40, 0,
	14, 40, 0,
	15, 40, 0,
	13, 29, 0,
	14, 29, 0,
	15, 29, 0,
	14, 28, 0,
	14, 30, 0,
	15, 28, 0,
	14, 29, 1,
	15, 29, 1,
	14, 30, 1,
	15, 28, 1,
	14, 29, 6,
	15, 29, 6,
	14, 30, 6,
	15, 28, 6,
	14, 29, 9,
	15, 29, 9,
	14, 30, 9,
	15, 28, 9,
	14, 29, 11,
	15, 29, 11,
	14, 30, 11,
	15, 28, 11,
})

// Benchmark package, each package in it
// corresponds to the relevant test parameters
// case and enumerates the results of Match for
// all combinations of the match operators (36).
Name(p372, Package()
{
	Package() {
		0, Ones, Ones, Ones, 0, 0,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, Ones, Ones, Ones, 0, 0,
		0, Ones, Ones, Ones, 0, 0,
	},
	Package() {
		0, Ones, 0, 0, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
	},
	Package() {
		0, Ones, 0, 0, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
	},
	Package() {
		0, Ones, 1, 1, 0, 0,
		Ones, Ones, Ones, Ones, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		0, Ones, Ones, Ones, 0, 0,
		0, Ones, Ones, Ones, 0, 0,
	},
	Package() {
		0, 3, 1, 1, 0, 0,
		3, 3, 3, Ones, 3, Ones,
		1, 3, 1, 1, 3, Ones,
		1, Ones, 1, 1, Ones, Ones,
		0, 3, 3, Ones, 0, 0,
		0, Ones, Ones, Ones, 0, 0,
	},
	Package() {
		0, Ones, 1, 1, 0, 0,
		Ones, Ones, Ones, Ones, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		0, Ones, Ones, Ones, 0, 0,
		0, Ones, Ones, Ones, 0, 0,
	},
	Package() {
		0, Ones, 1, 1, 0, 0,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, Ones, 1, 1, 0, 0,
		0, Ones, 1, 1, 0, 0,
	},
	Package() {
		0, 3, 1, 1, 0, 0,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, 3, 1, 1, 0, 0,
		0, 3, 1, 1, 0, 0,
	},
	Package() {
		0, Ones, 1, 1, 0, 0,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, Ones, 1, 1, 0, 0,
		0, Ones, 1, 1, 0, 0,
	},
	Package() {
		0, Ones, 0, 0, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
	},
	Package() {
		0, Ones, 0, 0, Ones, Ones,
		3, Ones, 3, 3, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
	},
	Package() {
		0, Ones, 0, 0, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
	},
	Package() {
		0, 7, 0, 0, 5, 5,
		Ones, Ones, Ones, Ones, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		0, 7, 0, 0, 5, 5,
		0, 7, 0, 0, 5, 5,
	},
	Package() {
		0, 7, 0, 0, 5, 5,
		3, Ones, 3, 3, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		0, 7, 0, 0, 5, 5,
		0, 7, 0, 0, 5, 5,
	},
	Package() {
		0, 7, 0, 0, 5, 5,
		Ones, Ones, Ones, Ones, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		0, 7, 0, 0, 5, 5,
		0, 7, 0, 0, 5, 5,
	},
	Package() {
		0, Ones, 0, 0, 5, 5,
		3, Ones, 3, 3, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		0, Ones, 0, 0, 5, 5,
		0, Ones, 0, 0, 5, 5,
	},
	Package() {
		0, Ones, 0, 0, 5, 5,
		3, Ones, 3, 3, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		0, Ones, 0, 0, 5, 5,
		0, Ones, 0, 0, 5, 5,
	},
	Package() {
		0, Ones, 0, 0, 5, 5,
		Ones, Ones, Ones, Ones, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		0, Ones, 0, 0, 5, 5,
		0, Ones, 0, 0, 5, 5,
	},
	Package() {
		1, 7, 1, 1, 5, 5,
		3, Ones, 3, 3, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		2, 7, 2, 2, 5, 5,
		2, 7, 2, 2, 5, 5,
	},
	Package() {
		1, 7, 1, 1, 5, 5,
		Ones, Ones, Ones, Ones, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		2, 7, 2, 2, 5, 5,
		2, 7, 2, 2, 5, 5,
	},
	Package() {
		1, Ones, 1, 1, 5, 5,
		3, Ones, 3, 3, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		2, Ones, 2, 2, 5, 5,
		2, Ones, 2, 2, 5, 5,
	},
	Package() {
		1, Ones, 1, 1, 5, 5,
		Ones, Ones, Ones, Ones, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		1, Ones, 1, 1, Ones, Ones,
		2, Ones, 2, 2, 5, 5,
		2, Ones, 2, 2, 5, 5,
	},
	Package() {
		6, 7, 7, 9, 6, 6,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		6, 7, 7, 9, 6, 6,
		6, 7, 7, 9, 6, 6,
	},
	Package() {
		6, 7, 7, 9, 6, 6,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		6, 7, 7, 9, 6, 6,
		6, 7, 7, 9, 6, 6,
	},
	Package() {
		6, Ones, 7, 7, 6, 6,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		6, Ones, 7, 7, 6, 6,
		6, Ones, 7, 7, 6, 6,
	},
	Package() {
		6, Ones, 9, 9, 6, 6,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		6, Ones, 9, 9, 6, 6,
		6, Ones, 9, 9, 6, 6,
	},
	Package() {
		9, Ones, 9, 9, 11, 11,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		9, Ones, 9, 9, 11, 11,
		9, Ones, 9, 9, 11, 11,
	},
	Package() {
		9, Ones, 9, 9, 11, 11,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		9, Ones, 9, 9, 11, 11,
		9, Ones, 9, 9, 11, 11,
	},
	Package() {
		9, Ones, 9, 9, 11, 11,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		9, Ones, 9, 9, 11, 11,
		9, Ones, 9, 9, 11, 11,
	},
	Package() {
		9, Ones, 9, 9, 11, 11,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		9, Ones, 9, 9, 11, 11,
		9, Ones, 9, 9, 11, 11,
	},
	Package() {
		11, Ones, Ones, Ones, 11, 11,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		11, Ones, Ones, Ones, 11, 11,
		11, Ones, Ones, Ones, 11, 11,
	},
	Package() {
		11, Ones, Ones, Ones, 11, 11,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		11, Ones, Ones, Ones, 11, 11,
		11, Ones, Ones, Ones, 11, 11,
	},
	Package() {
		11, Ones, Ones, Ones, 11, 11,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		11, Ones, Ones, Ones, 11, 11,
		11, Ones, Ones, Ones, 11, 11,
	},
	Package() {
		11, Ones, Ones, Ones, 11, 11,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		11, Ones, Ones, Ones, 11, 11,
		11, Ones, Ones, Ones, 11, 11,
	},
})

Name(p373, Package() {
	26, 11, 19, 14, 14, 35, 38, 29, 31, 23, 18, 32,
})

Name(p374, Package() {
	26, 11, 19, 14, 12, 35, 38, 29, 29, 23, 18, 32,
})

Name(p375, Package() {
	26, 11, 19, 14, 14, 35, 38, 29, 29, 23, 18, 32,
})

Name(p376, Package() {
	26, 11, 19, 14, Package(){29}, 35, 38, 29, Package(){40}, 23, Package(){0}, 32,
})

Name(p389, Package() {
	0x80000026, 11, 19, 14, 12, 0x80000035, 0x80000038, 0x80000029, 0x80000031, 23, 18, 0x80000032,
})

Name(p38a, Package()
{
	0, 0, 0,
	0, 0x80000040, 0,
	0x80000040, 0x80000040, 0,
	13, 13, 0,
	14, 14, 0,
	15, 15, 0,
	0, 13, 0,
	0, 14, 0,
	0, 15, 0,
	13, 0x80000040, 0,
	14, 0x80000040, 0,
	15, 0x80000040, 0,
	13, 0x80000029, 0,
	14, 0x80000029, 0,
	15, 0x80000029, 0,
	14, 0x80000028, 0,
	14, 0x80000030, 0,
	15, 0x80000028, 0,
	14, 0x80000029, 1,
	15, 0x80000029, 1,
	14, 0x80000030, 1,
	15, 0x80000028, 1,
	14, 0x80000029, 6,
	15, 0x80000029, 6,
	14, 0x80000030, 6,
	15, 0x80000028, 6,
	14, 0x80000029, 9,
	15, 0x80000029, 9,
	14, 0x80000030, 9,
	15, 0x80000028, 9,
	14, 0x80000029, 11,
	15, 0x80000029, 11,
	14, 0x80000030, 11,
	15, 0x80000028, 11,
})

Name(p38b, Package() {
	0x100000026, 11, 19, 14, 12, 0x100000035, 0x100000038, 0x100000029, 0x100000031, 23, 18, 0x100000032,
})

Name(p38c, Package()
{
	0, 0, 0,
	0, 0x100000040, 0,
	0x100000040, 0x100000040, 0,
	13, 13, 0,
	14, 14, 0,
	15, 15, 0,
	0, 13, 0,
	0, 14, 0,
	0, 15, 0,
	13, 0x100000040, 0,
	14, 0x100000040, 0,
	15, 0x100000040, 0,
	13, 0x100000029, 0,
	14, 0x100000029, 0,
	15, 0x100000029, 0,
	14, 0x100000028, 0,
	14, 0x100000030, 0,
	15, 0x100000028, 0,
	14, 0x100000029, 1,
	15, 0x100000029, 1,
	14, 0x100000030, 1,
	15, 0x100000028, 1,
	14, 0x100000029, 6,
	15, 0x100000029, 6,
	14, 0x100000030, 6,
	15, 0x100000028, 6,
	14, 0x100000029, 9,
	15, 0x100000029, 9,
	14, 0x100000030, 9,
	15, 0x100000028, 9,
	14, 0x100000029, 11,
	15, 0x100000029, 11,
	14, 0x100000030, 11,
	15, 0x100000028, 11,
})

Name(p38d, Package() {
	0x8000000000000026, 0x100000011, 0x100000019, 0x100000014, 0x100000012, 0x8000000000000035, 0x8000000000000038, 0x8000000000000029, 0x8000000000000031, 0x100000023, 0x100000018, 0x8000000000000032,
})

Name(p38e, Package()
{
	0x100000000, 0x100000000, 0,
	0x100000000, 0x8000000000000040, 0,
	0x8000000000000040, 0x8000000000000040, 0,
	0x100000013, 0x100000013, 0,
	0x100000014, 0x100000014, 0,
	0x100000015, 0x100000015, 0,
	0x100000000, 0x100000013, 0,
	0x100000000, 0x100000014, 0,
	0x100000000, 0x100000015, 0,
	0x100000013, 0x8000000000000040, 0,
	0x100000014, 0x8000000000000040, 0,
	0x100000015, 0x8000000000000040, 0,
	0x100000013, 0x8000000000000029, 0,
	0x100000014, 0x8000000000000029, 0,
	0x100000015, 0x8000000000000029, 0,
	0x100000014, 0x8000000000000028, 0,
	0x100000014, 0x8000000000000030, 0,
	0x100000015, 0x8000000000000028, 0,
	0x100000014, 0x8000000000000029, 1,
	0x100000015, 0x8000000000000029, 1,
	0x100000014, 0x8000000000000030, 1,
	0x100000015, 0x8000000000000028, 1,
	0x100000014, 0x8000000000000029, 6,
	0x100000015, 0x8000000000000029, 6,
	0x100000014, 0x8000000000000030, 6,
	0x100000015, 0x8000000000000028, 6,
	0x100000014, 0x8000000000000029, 9,
	0x100000015, 0x8000000000000029, 9,
	0x100000014, 0x8000000000000030, 9,
	0x100000015, 0x8000000000000028, 9,
	0x100000014, 0x8000000000000029, 11,
	0x100000015, 0x8000000000000029, 11,
	0x100000014, 0x8000000000000030, 11,
	0x100000015, 0x8000000000000028, 11,
})

Name(p377, Package() {
	0xffffffffffffff26, 0xffffffffffffff11, 0xffffffffffffff19, 0xffffffffffffff14,
	0xffffffffffffff14, 0xffffffffffffff35, 0xffffffffffffff38, 0xffffffffffffff29,
	0xffffffffffffff29, 0xffffffffffffff23, 0xffffffffffffff18, 0xffffffffffffff32,
})

Name(p378, Package()
{
	0xffffffffffffff00, 0xffffffffffffff00, 0,
	0xffffffffffffff00, 0xffffffffffffffff, 0,
	0xffffffffffffffff, 0xffffffffffffffff, 0,
	0xffffffffffffff13, 0xffffffffffffff13, 0,
	0xffffffffffffff14, 0xffffffffffffff14, 0,
	0xffffffffffffff15, 0xffffffffffffff15, 0,
	0xffffffffffffff00, 0xffffffffffffff13, 0,
	0xffffffffffffff00, 0xffffffffffffff14, 0,
	0xffffffffffffff00, 0xffffffffffffff15, 0,
	0xffffffffffffff13, 0xffffffffffffffff, 0,
	0xffffffffffffff14, 0xffffffffffffffff, 0,
	0xffffffffffffff15, 0xffffffffffffffff, 0,
	0xffffffffffffff13, 0xffffffffffffff29, 0,
	0xffffffffffffff14, 0xffffffffffffff29, 0,
	0xffffffffffffff15, 0xffffffffffffff29, 0,
	0xffffffffffffff14, 0xffffffffffffff28, 0,
	0xffffffffffffff14, 0xffffffffffffff2a, 0,
	0xffffffffffffff15, 0xffffffffffffff28, 0,
	0xffffffffffffff14, 0xffffffffffffff29, 1,
	0xffffffffffffff15, 0xffffffffffffff29, 1,
	0xffffffffffffff14, 0xffffffffffffff2a, 1,
	0xffffffffffffff15, 0xffffffffffffff28, 1,
	0xffffffffffffff14, 0xffffffffffffff29, 6,
	0xffffffffffffff15, 0xffffffffffffff29, 6,
	0xffffffffffffff14, 0xffffffffffffff2a, 6,
	0xffffffffffffff15, 0xffffffffffffff28, 6,
	0xffffffffffffff14, 0xffffffffffffff29, 9,
	0xffffffffffffff15, 0xffffffffffffff29, 9,
	0xffffffffffffff14, 0xffffffffffffff2a, 9,
	0xffffffffffffff15, 0xffffffffffffff28, 9,
	0xffffffffffffff14, 0xffffffffffffff29, 11,
	0xffffffffffffff15, 0xffffffffffffff29, 11,
	0xffffffffffffff14, 0xffffffffffffff2a, 11,
	0xffffffffffffff15, 0xffffffffffffff28, 11,
})

// One-element length package special case

Name(p380, Package() {
	1,
})

Name(p381, Package()
{
	0, 0, 0,
	0, 1, 0,
	0, 2, 0,
	1, 1, 0,
	1, 2, 0,
	2, 2, 0,
})

Name(p382, Package()
{
	Package() {
		0, Ones, Ones, Ones, 0, 0,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, Ones, Ones, Ones, 0, 0,
		0, Ones, Ones, Ones, 0, 0,
	},
	Package() {
		0, 0, 0, Ones, 0, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, 0, 0, Ones, 0, Ones,
		0, 0, 0, Ones, 0, Ones,
	},
	Package() {
		0, Ones, 0, 0, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
	},
	Package() {
		0, 0, 0, Ones, 0, Ones,
		0, 0, 0, Ones, 0, Ones,
		0, 0, 0, Ones, 0, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, 0, 0, Ones, 0, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
	},
	Package() {
		0, Ones, 0, 0, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
	},
	Package() {
		0, Ones, 0, 0, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
	},
})

// 255-element length package special case

Name(p383, Package() {
	  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
	 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
	 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
	 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
	 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
	 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96,
	 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111,112,
	113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,
	129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,
	145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,
	161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,
	177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,
	193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,
	209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,
	225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,
	241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,
})

Name(p384, Package()
{
	0, 0, 0,
	0, 128, 0,
	0, 256, 0,
	128, 128, 0,
	128, 256, 0,
	256, 256, 0,
})

Name(p385, Package()
{
	Package() {
		0, Ones, Ones, Ones, 0, 0,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, Ones, Ones, Ones, 0, 0,
		0, Ones, Ones, Ones, 0, 0,
	},
	Package() {
		0, 127, 0, 0, 127, 128,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, 127, 0, 0, 127, 128,
		0, 127, 0, 0, 127, 128,
	},
	Package() {
		0, Ones, 0, 0, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
	},
	Package() {
		0, 127, 0, 0, 127, 128,
		127, 127, 127, Ones, 127, Ones,
		0, 127, 0, 0, 127, Ones,
		0, Ones, 0, 0, Ones, Ones,
		127, 127, 127, Ones, 127, 128,
		128, Ones, Ones, Ones, 128, 128,
	},
	Package() {
		0, Ones, 0, 0, Ones, Ones,
		127, Ones, 127, 127, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		127, Ones, 127, 127, Ones, Ones,
		128, Ones, 128, 128, Ones, Ones,
	},
	Package() {
		0, Ones, 0, 0, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		0, Ones, 0, 0, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
		Ones, Ones, Ones, Ones, Ones, Ones,
	},
})

// Run-method
Method(MAT0,, Serialized)
{
	Name(ts, "MAT0")

	Store("TEST: MAT0, Find Object Match", Debug)

	// to do transposition of match objects flag
	Name(trns, 0)

	if (c099) {
		Store(1, trns)
	}

	m308(ts, 34, "p370", p371, p372, p370, trns)

	if (c099) {
		m308(ts, 34, "p373", p371, p372, p373, trns)
		m308(ts, 34, "p374", p371, p372, p374, trns)
	}

	m308(ts, 34, "p375", p371, p372, p375, trns)

	if (LEqual(F64, 1)) {
		m308(ts, 34, "p377", p378, p372, p377, trns)

		if (c099) {
			m308(ts, 34, "p389", p38a, p372, p389, trns)

			m308(ts, 34, "p38b", p38c, p372, p38b, trns)
			m308(ts, 34, "p38d", p38e, p372, p38d, trns)
		}
	} else {
		m308(ts, 34, "p389", p38a, p372, p389, trns)
	}

	// One-element length package special case

	m308(ts, 6, "p380", p381, p382, p380, trns)

	// 255-element length package special case

	if (c099) {
		m308(ts, 6, "p383", p384, p385, p383, trns)
	}
}
