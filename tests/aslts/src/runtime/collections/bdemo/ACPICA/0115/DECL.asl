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
 * Bug 115:
 *
 * SUMMARY: Unexpected dereference of Index reference returned by Method and immediately passed to another Method
 */

	Method(me7e, 2) {
		Store(arg0, Debug)
		Store(arg1, arg0)
	}

	Method(me7f) {
		Return(Index(pd04, 0))
	}

	Method(me80) {
		Store(Index(pd05, 0), Local0)
		Return(Local0)
	}

	Method(me81) {
		Return(Index(pd06, 0, Local0))
	}

	Method(me82) {
		Index(pd07, 0, Local0)
		Return(Local0)
	}

	Method(me83) {
		Store(Index(pd08, 0, Local0), Local1)
		Return(Local0)
	}

	Method(me84) {
		Store(Index(pd09, 0, Local0), Local1)
		Return(Local1)
	}

	Method(me85) {
		Return(RefOf(id10))
	}

	Method(me86,, Serialized)
	{
		Name(prn0, 0)

		// To show: the RefOf reference is actually passed to method (Ok)

		if (prn0) {
			Store(me85(), Debug)
		}

		Store(0xabcd0000, Local0)
		me7e(me85(), Local0)
		if (LNotEqual(id10, Local0)) {
			err("", zFFF, 0x000, 0, 0, id10, Local0)
		}

		// To show: all methods return Index references (Ok)

		if (prn0) {
			Store(me7f(), Debug)
			Store(me80(), Debug)
			Store(me81(), Debug)
			Store(me82(), Debug)
			Store(me83(), Debug)
			Store(me84(), Debug)
		}

		// To show: passed to methods are objects but
		// not Index references to them as expected (Bug)

		Store(0xabcd0001, Local0)
		me7e(me7f(), Local0)
		Store(DerefOf(Index(pd04, 0)), Local1)
		if (LNotEqual(Local1, Local0)) {
			err("", zFFF, 0x001, 0, 0, Local1, Local0)
		}

		Store(0xabcd0002, Local0)
		me7e(me80(), Local0)
		Store(DerefOf(Index(pd05, 0)), Local1)
		if (LNotEqual(Local1, Local0)) {
			err("", zFFF, 0x001, 0, 0, Local1, Local0)
		}

		Store(0xabcd0003, Local0)
		me7e(me81(), Local0)
		Store(DerefOf(Index(pd06, 0)), Local1)
		if (LNotEqual(Local1, Local0)) {
			err("", zFFF, 0x001, 0, 0, Local1, Local0)
		}

		Store(0xabcd0004, Local0)
		me7e(me82(), Local0)
		Store(DerefOf(Index(pd07, 0)), Local1)
		if (LNotEqual(Local1, Local0)) {
			err("", zFFF, 0x001, 0, 0, Local1, Local0)
		}

		Store(0xabcd0005, Local0)
		me7e(me83(), Local0)
		Store(DerefOf(Index(pd08, 0)), Local1)
		if (LNotEqual(Local1, Local0)) {
			err("", zFFF, 0x001, 0, 0, Local1, Local0)
		}

		Store(0xabcd0006, Local0)
		me7e(me84(), Local0)
		Store(DerefOf(Index(pd09, 0)), Local1)
		if (LNotEqual(Local1, Local0)) {
			err("", zFFF, 0x001, 0, 0, Local1, Local0)
		}
	}


