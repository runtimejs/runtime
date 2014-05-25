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
 * Bug 111:
 *
 * SUMMARY: No String to Integer and Buffer to Integer conversions of the Predicate Value in If, ElseIf and While operators
 */

	Method(me73, 1)
	{
		if (arg0) {
			Store("If done", Debug)
			Store(1, id0f)
		}
	}

	Method(me74, 2)
	{
		if (arg1) {
			Store(1, id0f)
		} elseif (arg0) {
			Store(2, id0f)
		}
	}

	Method(me75, 1)
	{
		While (arg0) {
			Store(1, id0f)
			Break
		}
	}

	Method(me76)
	{
		// //////////

		Store(0, id0f)
		me73("1")
		if (LNot(id0f)) {
			err("", zFFF, 0x000, 0, 0, 0, 0)
		}

		Store(0, id0f)
		me73(Buffer(){1})
		if (LNot(id0f)) {
			err("", zFFF, 0x001, 0, 0, 0, 0)
		}

		Store(0, id0f)
		me73("0")
		if (id0f) {
			err("", zFFF, 0x002, 0, 0, 0, 0)
		}

		Store(0, id0f)
		me73(Buffer(){0})
		if (id0f) {
			err("", zFFF, 0x003, 0, 0, 0, 0)
		}

		// //////////

		Store(0, id0f)
		me74("1", 0)
		if (LNotEqual(id0f, 2)) {
			err("", zFFF, 0x004, 0, 0, 0, 0)
		}

		Store(0, id0f)
		me74(Buffer(){0,0,1,0}, 0)
		if (LNotEqual(id0f, 2)) {
			err("", zFFF, 0x005, 0, 0, 0, 0)
		}

		Store(0, id0f)
		me74("0", 0)
		if (id0f) {
			err("", zFFF, 0x006, 0, 0, 0, 0)
		}

		Store(0, id0f)
		me74(Buffer(){0,0,0,0}, 0)
		if (id0f) {
			err("", zFFF, 0x007, 0, 0, 0, 0)
		}

		Store(0, id0f)
		me74("1", 1)
		if (LNotEqual(id0f, 1)) {
			err("", zFFF, 0x008, 0, 0, 0, 0)
		}

		Store(0, id0f)
		me74(Buffer(){0,0,1,0}, 1)
		if (LNotEqual(id0f, 1)) {
			err("", zFFF, 0x009, 0, 0, 0, 0)
		}

		Store(0, id0f)
		me75("0")
		if (id0f) {
			err("", zFFF, 0x00a, 0, 0, 0, 0)
		}

		Store(0, id0f)
		me75(Buffer(){0})
		if (id0f) {
			err("", zFFF, 0x00b, 0, 0, 0, 0)
		}

		Store(0, id0f)
		me75("01")
		if (LNot(id0f)) {
			err("", zFFF, 0x00c, 0, 0, 0, 0)
		}

		Store(0, id0f)
		me75(Buffer(){0,0,1,0})
		if (LNot(id0f)) {
			err("", zFFF, 0x00d, 0, 0, 0, 0)
		}

	}

