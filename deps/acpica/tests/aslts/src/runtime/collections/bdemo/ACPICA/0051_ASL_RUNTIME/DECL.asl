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
 * Bug 0051:
 *
 * SUMMARY: Register() macro missing parameter
 *
 * NOTE: introduce into FULL after fixing bug of iASL
 */


Method(mddb, 5)
{
	if (LNotEqual(arg0, arg1)) {
		err("", zFFF, 0x000, 0, 0, arg0, arg1)
	}
	if (LNotEqual(arg2, arg3)) {
		err("", zFFF, 0x001, 0, 0, arg0, arg1)
	}
}

Method(mddc,, Serialized)
{
	Name(RT00,
		ResourceTemplate () {
			// Register macro AccessSize is not implemented
			Register (SystemMemory, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9, 1)
		})
	Name(BUF0,
			Buffer () {0x82, 0x0c, 0x00, 0x00, 0xf0, 0xf1, 0x01,
				0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00
		})


	// Currently Register macro DescriptorName is not implemented

	Store (
		ResourceTemplate () {
			Register (SystemMemory, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9, 0, REG0)
			Register (SystemMemory, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9, 0, REG1)
		}, Local0)

	mddb(REG0._ASI, 3, REG1._ASI, 18, "_ASI")
	mddb(REG0._RBW, 4, REG1._RBW, 19, "_RBW")
	mddb(REG0._RBO, 5, REG1._RBO, 20, "_RBO")
	mddb(REG0._ASZ, 6, REG1._ASZ, 21, "_ASZ")
	mddb(REG0._ADR, 7, REG1._ADR, 22, "_ADR")

	if (LNotEqual(RT00, BUF0)) {
		err("", zFFF, 0x002, 0, 0, RT00, BUF0)
	}
}
