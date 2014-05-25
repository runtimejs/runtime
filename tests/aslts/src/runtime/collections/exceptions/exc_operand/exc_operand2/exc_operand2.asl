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
 * Exceptions caused by inappropriate type of operands
 */

Name(z107, 107)

// Run-method
Method(EOP2)
{
	SRMT("m4b0")
	m4b0(0)

	SRMT("m4b1")
	m4b1(0x76543210)

	SRMT("m4b2")
	m4b2("2")

	SRMT("m4b3")
	m4b3(Buffer(){0x62})

	SRMT("m4b4")
	m4b4(Package(){0x62})

	SRMT("m4b5")
	m4b5()

	SRMT("m4b6")
	if (y120) {
		m4b6()
	} else {
		BLCK()
	}

	SRMT("m4b7")
	m4b7()

	SRMT("m4b8")
	m4b8()

	SRMT("m4b9")
	m4b9()

	SRMT("m4ba")
	if (y362) {
		m4ba()
	} else {
		BLCK()
	}

	SRMT("m4bb")
	m4bb()

	SRMT("m4bc")
	m4bc()

	SRMT("m4bd")
	if (y120) {
		m4bd()
	} else {
		BLCK()
	}

	SRMT("m4be")
	m4be()
}
