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
 * (service-test)
 *
 * This service-test reports failures when
 * some conditional branches are disabled.
 *
 * Note: check periodically that all the relevant variables
 * are introduced here (see file runtime/ctl/runmode.asl).
 */

Name(z135, 135)

Method(SRV0,, Serialized) {

	Name(i000, 0)

	Method(m280, 2) {
		SRMT(arg1)
		if (LNot(arg0)) {
			err(arg0, z135, i000, 0, 0, 0, 1)
		}
		Increment(i000)
	}

	m280(EXCV, "EXCV")
	m280(X104, "X104")
	m280(X114, "X114")
	m280(X127, "X127")
	m280(X128, "X128")
	m280(X131, "X131")
	m280(X132, "X132")
	m280(X133, "X133")
	m280(X153, "X153")
	m280(X170, "X170")
	m280(X191, "X191")
	m280(X192, "X192")
	m280(X193, "X193")
	m280(X194, "X194")
	/*
	 * X195 is about Increment and Decrement of an either String or Buffer
	 * Since object will not change the type of the Object to Integer
	 * So this conditional branches should be disabled.
	 */
	//m280(X195, "X195")
	m280(q001, "q001")
	m280(q002, "q002")
	m280(q003, "q003")
	m280(q004, "q004")
	m280(q005, "q005")
	m280(q006, "q006")
	m280(q007, "q007")
	m280(q008, "q008")
	m280(q009, "q009")
	m280(q00a, "q00a")
	m280(q00b, "q00b")
	m280(rn00, "rn00")
	m280(rn01, "rn01")
	m280(rn02, "rn02")
	m280(rn03, "rn03")
	m280(rn04, "rn04")
	m280(rn05, "rn05")
	m280(rn06, "rn06")
	m280(y078, "y078")
	m280(y083, "y083")
	m280(y084, "y084")
	m280(y098, "y098")
	m280(y100, "y100")
	m280(y103, "y103")
	m280(y104, "y104")
	m280(y105, "y105")
	m280(y106, "y106")
	m280(y111, "y111")
	m280(y113, "y113")
	m280(y114, "y114")
	m280(y118, "y118")
	m280(y119, "y119")
	m280(y120, "y120")
	m280(y121, "y121")
	m280(y126, "y126")
	m280(y127, "y127")
	m280(y128, "y128")
	m280(y132, "y132")
	m280(y133, "y133")
	m280(y134, "y134")
	m280(y135, "y135")
	m280(y136, "y136")
	m280(y157, "y157")
	m280(y164, "y164")
	m280(y176, "y176")
	m280(y178, "y178")
	m280(y182, "y182")
	m280(y192, "y192")
	m280(y200, "y200")
	m280(y203, "y203")
	m280(y204, "y204")
	m280(y205, "y205")
	m280(y206, "y206")
	m280(y207, "y207")
	m280(y208, "y208")
	m280(y213, "y213")
	m280(y214, "y214")
	m280(y215, "y215")
	m280(y216, "y216")
	m280(y217, "y217")
	m280(y220, "y220")
	m280(y221, "y221")
	m280(y222, "y222")
	m280(y223, "y223")
	m280(y224, "y224")
	m280(y238, "y238")
	m280(y242, "y242")
	m280(y243, "y243")
	m280(y248, "y248")
	m280(y251, "y251")
	m280(y260, "y260")
	m280(y261, "y261")
	m280(y262, "y262")
	m280(y263, "y263")
	m280(y264, "y264")
	m280(y275, "y275")
	m280(y276, "y276")
	m280(y281, "y281")
	m280(y282, "y282")
	m280(y283, "y283")
	m280(y284, "y284")
	m280(y286, "y286")
	m280(y287, "y287")
	m280(y288, "y288")
	m280(y289, "y289")
	m280(y290, "y290")
	m280(y292, "y292")
	m280(y293, "y293")
	m280(y294, "y294")
	m280(y296, "y296")
	m280(y297, "y297")
	m280(y300, "y300")
	m280(y301, "y301")
	m280(y302, "y302")
	m280(y349, "y349")
	m280(y350, "y350")
	m280(y361, "y361")
	m280(y362, "y362")
	m280(y364, "y364")
	m280(y365, "y365")
	m280(y366, "y366")
	m280(y367, "y367")
	m280(y500, "y500")
	m280(y501, "y501")
	m280(y502, "y502")
	m280(y503, "y503")
	m280(y504, "y504")
	m280(y505, "y505")
	m280(y506, "y506")
	m280(y507, "y507")
	m280(y508, "y508")
	m280(y509, "y509")
	m280(y510, "y510")
	m280(y511, "y511")
	m280(y512, "y512")
	m280(y513, "y513")
	m280(y514, "y514")
	m280(y516, "y516")
	m280(y517, "y517")
	m280(y518, "y518")
	m280(y519, "y519")
	m280(y520, "y520")
	m280(y521, "y521")
	m280(y522, "y522")
	m280(y523, "y523")
	m280(y524, "y524")
	m280(y525, "y525")
	m280(y526, "y526")
	m280(y527, "y527")
	m280(y600, "y600")
	m280(y601, "y601")
	m280(y602, "y602")
	m280(y603, "y603")
	m280(y900, "y900")
	m280(y901, "y901")
}

