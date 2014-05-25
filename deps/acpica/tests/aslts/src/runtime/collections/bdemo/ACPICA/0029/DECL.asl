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
 * Bug 0029:
 *
 * SUMMARY: Looks, like Sleep (or Wait) spend less time than specified
 */

Method(mdbf, 2, Serialized)
{
	Switch (ToInteger (arg0)) {
	case (0) {
		Store(Timer, Local1)
		Sleep(arg1)
		Store(Timer, Local2)
		Subtract(Local2, Local1, Local6)
		Multiply(arg1, 10000, Local4)
		if (LLess(Local6, Local4)) {
			err("", zFFF, 0x000, 0, 0, Local6, Local4)
		}
	}
	case (1) {
		Store(Timer, Local1)
		Stall(arg1)
		Store(Timer, Local2)
		Subtract(Local2, Local1, Local6)
		Multiply(arg1, 10, Local4)
		if (LLess(Local6, Local4)) {
			err("", zFFF, 0x001, 0, 0, Local6, Local4)
		}
	}
	case (2) {
		Store(Timer, Local1)
		Wait(ed00, arg1)
		Store(Timer, Local2)
		Subtract(Local2, Local1, Local6)
		Multiply(arg1, 10000, Local4)
		if (LLess(Local6, Local4)) {
			err("", zFFF, 0x002, 0, 0, Local6, Local4)
		}
	}
	}
}

// Sleep
Method(mdc0)
{
	mdbf(0,10)
	mdbf(0,100)
	mdbf(0,500)
	mdbf(0,1000)
	mdbf(0,2000)
}

// Wait
Method(mdc1)
{
	mdbf(2,10)
	mdbf(2,100)
	mdbf(2,1000)
	mdbf(2,2000)
}

Method(mdc2)
{
	mdc0()
	mdc1()
}
