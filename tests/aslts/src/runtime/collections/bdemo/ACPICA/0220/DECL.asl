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
 * Bug 220:
 *
 * SUMMARY: Inconsistent "Access is available/unavailable" _REG method calls
 */

Device(D220) {
	Name(ACTV, 0)
	Name(DACT, 0)
	Name(NERR, 0)

	Method(_REG, 2)
	{
		Store("_REG:", Debug)
		Store(arg0, Debug)
		Store(arg1, Debug)

		if (arg0) {
			Increment(NERR)
		} elseif (LGreater(arg1, 1)) {
			Increment(NERR)
		} elseif (arg1) {
			Increment(ACTV)
		} else {
			Increment(DACT)
		}
	}

	OperationRegion(OPR0, SystemMemory, 0x2000, 0x100)
}

Method(m108)
{
	if (\D220.NERR) {
		err("", zFFF, 0x000, 0, 0, \D220.NERR, 0)
	}

	Subtract(\D220.ACTV, \D220.DACT, Local0)

	if (LNotEqual(Local0, 1)) {
		err("", zFFF, 0x001, 0, 0, Local0, 1)
	}
}
