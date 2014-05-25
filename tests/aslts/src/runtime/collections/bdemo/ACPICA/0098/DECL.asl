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
 * Bug 0098:
 *
 * SUMMARY: Crash on a specific AML code
 */

	Method(me51, 1)
	{
		Store(ObjectType(arg0), Local0)
		Store(Local0, Debug)
	}

	Method(me52,, Serialized)
	{
		Name(run0, 1)
		Name(run1, 1)
		Name(run2, 1)

		Name(p000, Package(32) { 0, dd08, sd01, bd04, 0})


		Store("============= Test started:", Debug)

		if (run0) {
			Store("============= Integer:", Debug)
			Store(Index(p000, 1, Local1), Local0)
			Store(Local1, Debug)
			me51(Local1)
			Store(Local0, Debug)
		}
		if (run1) {
			Store("============= String:", Debug)
			Store(Index(p000, 2, Local1), Local0)
			Store(Local1, Debug)
			me51(Local1)
			Store(Local0, Debug)
		}

		if (run2) {
			Store("============= Buffer:", Debug)
			Store(Index(p000, 3, Local1), Local0)
			Store(Local1, Debug)
			me51(Local1)
			Store(Local0, Debug)
		}

		Store("============= Test finished.", Debug)
	}

	// Arg0 - the type of object
	// (for 8 (- Method) causes crash, Bug 0097)
	Method(me54, 1, Serialized)
	{
		Name(pd02, Package(32) {
			0,
			id0c, sd02, bd05, pd02, fd02, dd09, ed01, me53,
			mxd1, rd03, pwd0, prd0, tzd0, bfd0,
		})

		Store("============= Test started:", Debug)

		Switch (ToInteger (Arg0)) {
		Case (0) {
			Store("============= Uninitialized:", Debug)
		}
		Case (1) {
			Store("============= Integer:", Debug)
			Store(Index(pd02, 1, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
		}
		Case (2) {
			Store("============= String:", Debug)
			Store(Index(pd02, 2, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
		}
		Case (3) {
			Store("============= Buffer:", Debug)
			Store(Index(pd02, 3, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
		}
		Case (4) {
			Store("============= Package:", Debug)
			Store(Index(pd02, 4, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
		}
		Case (5) {
			Store("============= Field Unit:", Debug)
			Store(Index(pd02, 5, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
		}
		Case (6) {
			Store("============= Device:", Debug)
			Store(Index(pd02, 6, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
		}
		Case (7) {
			Store("============= Event:", Debug)
			Store(Index(pd02, 7, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
		}
		Case (8) {
			Store("============= Method:", Debug)
			Store(Index(pd02, 8, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
		}
		Case (9) {
			Store("============= Mutex:", Debug)
			Store(Index(pd02, 9, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
		}
		Case (10) {
			Store("============= OperationRegion:", Debug)
			Store(Index(pd02, 10, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
		}
		Case (11) {
			Store("============= PowerResource:", Debug)
			Store(Index(pd02, 11, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
		}
		Case (12) {
			Store("============= Processor:", Debug)
			Store(Index(pd02, 12, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
		}
		Case (13) {
			Store("============= ThermalZone:", Debug)
			Store(Index(pd02, 13, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
		}
		Case (14) {
			Store("============= Buffer Field:", Debug)
			Store(Index(pd02, 14, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
		}
		} // Switch

		Store("============= Test finished.", Debug)
	}

	/*
	 * The same as me54 but all the cases are invoked not
	 * one by one calling to the me54() Method with the next
	 * in turn type of data but all the types of data are
	 * exercised simultaneously  during one call to me55
	 * method.
	 */
	Method(me55,, Serialized)
	{
		Name(pd02, Package(32) {
			0,
			id0c, sd02, bd05, pd02, fd02, dd09, ed01, me53,
			mxd1, rd03, pwd0, prd0, tzd0, bfd0,
		})

		Store("============= Test started:", Debug)

	//	Switch (Arg0) {
	//	Case (0) {
			Store("============= Uninitialized:", Debug)
	//	}
	//	Case (1) {
			Store("============= Integer:", Debug)
			Store(Index(pd02, 1, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
	//	}
	//	Case (2) {
			Store("============= String:", Debug)
			Store(Index(pd02, 2, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
	//	}
	//	Case (3) {
			Store("============= Buffer:", Debug)
			Store(Index(pd02, 3, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
	//	}
	//	Case (4) {
			Store("============= Package:", Debug)
			Store(Index(pd02, 4, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
	//	}
	//	Case (5) {
			Store("============= Field Unit:", Debug)
			Store(Index(pd02, 5, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
	//	}
	//	Case (6) {
			Store("============= Device:", Debug)
			Store(Index(pd02, 6, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
	//	}
	//	Case (7) {
			Store("============= Event:", Debug)
			Store(Index(pd02, 7, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
	//	}
/*
 * Causes crash, Bug 0097
 *
 *	//	Case (8) {
 *			Store("============= Method:", Debug)
 *			Store(Index(pd02, 8, Local1), Local0)
 *			Store(Local1, Debug)
 *			me56(Local1)
 *			Store(Local0, Debug)
 *	//	}
 */
	//	Case (9) {
			Store("============= Mutex:", Debug)
			Store(Index(pd02, 9, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
	//	}
	//	Case (10) {
			Store("============= OperationRegion:", Debug)
			Store(Index(pd02, 10, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
	//	}
	//	Case (11) {
			Store("============= PowerResource:", Debug)
			Store(Index(pd02, 11, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
	//	}
	//	Case (12) {
			Store("============= Processor:", Debug)
			Store(Index(pd02, 12, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
	//	}
	//	Case (13) {
			Store("============= ThermalZone:", Debug)
			Store(Index(pd02, 13, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
	//	}
	//	Case (14) {
			Store("============= Buffer Field:", Debug)
			Store(Index(pd02, 14, Local1), Local0)
			Store(Local1, Debug)
			me56(Local1)
			Store(Local0, Debug)
	//	}
	//	} // Switch

		Store("============= Test finished.", Debug)
	}

	Method(me56, 1)
	{
		Store(ObjectType(arg0), Local0)
		Store(Local0, Debug)
	}

	Method(me57)
	{
		me54(0)
		me54(1)
		me54(2)
		me54(3)
		me54(4)
		me54(5)
		me54(6)
		me54(7)
/*
 * Causes crash, Bug 0097
 *		me54(8)
 */
		me54(9)
		me54(10)
		me54(11)
		me54(12)
		me54(13)
		me54(14)
	}

	Method(me58)
	{
		/*
		 * Exercise one particular type of data
		 * which is specified by Arg0.
		 *
		 * Arg0 - the type of object (0-14)
		 * for 8 (Method) causes crash, Bug 0097
		 */
		me54(14)

		/*
		 * Call to me54 for each type of data excluding
		 * 8 (Method) (causes crash, Bug 0097).
		 */
		me57()

		/*
		 * The same as me54 but all the cases are invoked not
		 * one by one calling to the me54() Method with the next
		 * in turn type of data but all the types of data are
		 * exercised simultaneously  during one call to me55
		 * method.
		 */
		me55()
	}

