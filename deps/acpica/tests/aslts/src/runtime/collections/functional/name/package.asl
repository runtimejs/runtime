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
 * Miscellaneous named object creation
 */

/*
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SEE: see below, update needed
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/

// Package, Declare Package Object
//
// Update needed:
//
// m1f4() - this test should be implemented after references to Control
//          Methods as elements of Package will be implemented by ACPICA.
// m1f7() - this test should be implemented after ObjectType stops aborting
//          program when dealing with uninitialized objects.
// all    - add references to Control Methods to all other tests of this file.
//
// Note: verification of the contents of Packages is not performed, too complex.

Name(z051, 51)

// Step {1,2,4,8,16,32}. Use 16, too much time for 1 there.
Name(c040, 16)

// Max number of iterations of Mix test.
// Use 25, though available are {1-29}.
Name(c041, 22)

// Check Integers
Method(m1f0,, Serialized)
{
	Name(ts, "m1f0")

	Name(p000, Package() {
		// 0
		0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
		10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
		20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
		30, 31, 32, 33, 34, 35, 36, 37, 38, 39,
		40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
		50, 51, 52, 53, 54, 55, 56, 57, 58, 59,
		60, 61, 62, 63, 64, 65, 66, 67, 68, 69,
		70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
		80, 81, 82, 83, 84, 85, 86, 87, 88, 89,
		90, 91, 92, 93, 94, 95,

		// 96
		0x8765ac00, 0x8765ac01, 0x8765ac02, 0x8765ac03,
		0x8765ac04, 0x8765ac05, 0x8765ac06, 0x8765ac07,
		0x8765ac08, 0x8765ac09, 0x8765ac0a, 0x8765ac0b,
		0x8765ac0c, 0x8765ac0d, 0x8765ac0e, 0x8765ac0f,

		0x8765ac10, 0x8765ac11, 0x8765ac12, 0x8765ac13,
		0x8765ac14, 0x8765ac15, 0x8765ac16, 0x8765ac17,
		0x8765ac18, 0x8765ac19, 0x8765ac1a, 0x8765ac1b,
		0x8765ac1c, 0x8765ac1d, 0x8765ac1e, 0x8765ac1f,

		0x8765ac20, 0x8765ac21, 0x8765ac22, 0x8765ac23,
		0x8765ac24, 0x8765ac25, 0x8765ac26, 0x8765ac27,
		0x8765ac28, 0x8765ac29, 0x8765ac2a, 0x8765ac2b,
		0x8765ac2c, 0x8765ac2d, 0x8765ac2e, 0x8765ac2f,

		0x8765ac30, 0x8765ac31, 0x8765ac32, 0x8765ac33,
		0x8765ac34, 0x8765ac35, 0x8765ac36, 0x8765ac37,
		0x8765ac38, 0x8765ac39, 0x8765ac3a, 0x8765ac3b,
		0x8765ac3c, 0x8765ac3d, 0x8765ac3e, 0x8765ac3f,

		// 160
		0x8765acba11223300, 0x8765acba11223301,
		0x8765acba11223302, 0x8765acba11223303,
		0x8765acba11223304, 0x8765acba11223305,
		0x8765acba11223306, 0x8765acba11223307,
		0x8765acba11223308, 0x8765acba11223309,
		0x8765acba1122330a, 0x8765acba1122330b,
		0x8765acba1122330c, 0x8765acba1122330d,
		0x8765acba1122330e, 0x8765acba1122330f,
		0x8765acba11223310, 0x8765acba11223311,
		0x8765acba11223312, 0x8765acba11223313,

		0x8765acba11223314, 0x8765acba11223315,
		0x8765acba11223316, 0x8765acba11223317,
		0x8765acba11223318, 0x8765acba11223319,
		0x8765acba1122331a, 0x8765acba1122331b,
		0x8765acba1122331c, 0x8765acba1122331d,
		0x8765acba1122331e, 0x8765acba1122331f,
		0x8765acba11223320, 0x8765acba11223321,
		0x8765acba11223322, 0x8765acba11223323,

		// 196
		196, 197, 198, 199,
		200, 201, 202, 203, 204, 205, 206, 207, 208, 209,
		210, 211, 212, 213, 214, 215, 216, 217, 218, 219,
		220, 221, 222, 223, 224, 225, 226, 227, 228, 229,
		230, 231, 232, 233, 234, 235, 236, 237, 238, 239,
		240, 241, 242, 243, 244, 245, 246, 247, 248, 249,
		250, 251, 252, 253, 254,
	})

	ts00(ts)

	// Too much time for 1 there, so use {8/16}
	Store(c040, Local6)
	Divide(255, Local6, Local1, Local0)

	Store(0, Local1)
	Store(0, Local4)
	Store(0, Local5)

	While (Local0) {

		Store(DeRefOf(Index(p000, Local1)), Local2)
		Store(Local1, Local3)

		if (LLessEqual(Local1, 95)) {
			if (LNotEqual(Local2, Local3)) {
				err(ts, z051, 0, 0, 0, Local2, Local3)
			}
		} elseif (LLessEqual(Local1, 159)) {
			Add(0x8765ac00, Local4, Local3)
			if (LNotEqual(Local2, Local3)) {
				err(ts, z051, 1, 0, 0, Local2, Local3)
			}
			Add(Local4, Local6, Local4)
		} elseif (LLessEqual(Local1, 195)) {
			Add(0x8765acba11223300, Local5, Local3)
			if (LNotEqual(Local2, Local3)) {
				err(ts, z051, 2, 0, 0, Local2, Local3)
			}
			Add(Local5, Local6, Local5)
		} else {
			if (LNotEqual(Local2, Local3)) {
				err(ts, z051, 3, 0, 0, Local2, Local3)
			}
		}

		Store(ObjectType(Local2), Local3)
		if (LNotEqual(Local3, 1)) {
			err(ts, z051, 4, 0, 0, Local3, 1)
		}

		Add(Local1, Local6, Local1)
		Decrement(Local0)
	}

	Store(SizeOf(p000), Local0)
	if (LNotEqual(Local0, 255)) {
		err(ts, z051, 5, 0, 0, Local0, 255)
	}
}

// Check Strings
Method(m1f1,, Serialized)
{
	Name(ts, "m1f1")

	Name(p000, Package() {
		"", "0", "01", "012", " 0 0", "   9 ", "vqwert", "1234567", "01234567",
		"01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789",
	})

	ts00(ts)

	Store(10, Local0)
	Store(0, Local1)
	Store(0, Local5)

	While (Local0) {

		Store(DeRefOf(Index(p000, Local1)), Local2)
		Store(SizeOf(Local2), Local3)

		Store(Local1, Local4)
		if (LEqual(Local1, 9)) {
			Store(200, Local4)
		}

		if (LNotEqual(Local4, Local3)) {
			err(ts, z051, 6, 0, 0, Local4, Local3)
		}

		Store(ObjectType(Local2), Local3)
		if (LNotEqual(Local3, 2)) {
			err(ts, z051, 7, 0, 0, Local3, 2)
		}

		Increment(Local1)
		Decrement(Local0)
	}

	Store(SizeOf(p000), Local0)
	if (LNotEqual(Local0, 10)) {
		err(ts, z051, 8, 0, 0, Local0, 10)
	}
}

// Check Buffers
Method(m1f2,, Serialized)
{
	Name(ts, "m1f2")

	Name(p000, Package() {
		Buffer(1) {},
		Buffer(2) {},
		Buffer(3) {},
		Buffer(4) {},
		Buffer(5) {},
		Buffer(6) {},
		Buffer(7) {},
		Buffer(8) {},
		Buffer(9) {},
		Buffer(10) {},

		Buffer() {1,2,3,4,5,6,7,8,9,10,11},
		Buffer() {1,2,3,4,5,6,7,8,9,10,11,12},
		Buffer() {1,2,3,4,5,6,7,8,9,10,11,12,13},
		Buffer() {1,2,3,4,5,6,7,8,9,10,11,12,13,14},
		Buffer() {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
		Buffer() {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16},
		Buffer() {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17},
		Buffer() {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18},
		Buffer() {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19},
		Buffer() {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20},

		Buffer(21) {}, Buffer(22) {}, Buffer(23) {}, Buffer(24) {}, Buffer(25) {},
		Buffer(26) {}, Buffer(27) {}, Buffer(28) {}, Buffer(29) {}, Buffer(30) {},
		Buffer(31) {}, Buffer(32) {}, Buffer(33) {}, Buffer(34) {}, Buffer(35) {},
		Buffer(36) {}, Buffer(37) {}, Buffer(38) {}, Buffer(39) {}, Buffer(40) {},
		Buffer(41) {}, Buffer(42) {}, Buffer(43) {}, Buffer(44) {}, Buffer(45) {},
		Buffer(46) {}, Buffer(47) {}, Buffer(48) {}, Buffer(49) {}, Buffer(50) {},
		Buffer(51) {}, Buffer(52) {}, Buffer(53) {}, Buffer(54) {}, Buffer(55) {},
		Buffer(56) {}, Buffer(57) {}, Buffer(58) {}, Buffer(59) {}, Buffer(60) {},
		Buffer(61) {}, Buffer(62) {}, Buffer(63) {}, Buffer(64) {}, Buffer(65) {},
		Buffer(66) {}, Buffer(67) {}, Buffer(68) {}, Buffer(69) {}, Buffer(70) {},
		Buffer(71) {}, Buffer(72) {}, Buffer(73) {}, Buffer(74) {}, Buffer(75) {},
		Buffer(76) {}, Buffer(77) {}, Buffer(78) {}, Buffer(79) {}, Buffer(80) {},
		Buffer(81) {}, Buffer(82) {}, Buffer(83) {}, Buffer(84) {}, Buffer(85) {},
		Buffer(86) {}, Buffer(87) {}, Buffer(88) {}, Buffer(89) {}, Buffer(90) {},
		Buffer(91) {}, Buffer(92) {}, Buffer(93) {}, Buffer(94) {}, Buffer(95) {},
		Buffer(96) {}, Buffer(97) {}, Buffer(98) {}, Buffer(99) {},

		Buffer(100) {}, Buffer(101) {}, Buffer(102) {}, Buffer(103) {},
		Buffer(104) {}, Buffer(105) {}, Buffer(106) {}, Buffer(107) {},
		Buffer(108) {}, Buffer(109) {}, Buffer(110) {}, Buffer(111) {},
		Buffer(112) {}, Buffer(113) {}, Buffer(114) {},	Buffer(115) {},
		Buffer(116) {}, Buffer(117) {}, Buffer(118) {}, Buffer(119) {},
		Buffer(120) {}, Buffer(121) {}, Buffer(122) {}, Buffer(123) {},
		Buffer(124) {}, Buffer(125) {}, Buffer(126) {}, Buffer(127) {},
		Buffer(128) {}, Buffer(129) {}, Buffer(130) {}, Buffer(131) {},
		Buffer(132) {}, Buffer(133) {}, Buffer(134) {}, Buffer(135) {},
		Buffer(136) {}, Buffer(137) {}, Buffer(138) {}, Buffer(139) {},
		Buffer(140) {}, Buffer(141) {}, Buffer(142) {}, Buffer(143) {},
		Buffer(144) {}, Buffer(145) {}, Buffer(146) {}, Buffer(147) {},
		Buffer(148) {}, Buffer(149) {},

		Buffer(150) {}, Buffer(151) {}, Buffer(152) {}, Buffer(153) {},
		Buffer(154) {}, Buffer(155) {}, Buffer(156) {}, Buffer(157) {},
		Buffer(158) {}, Buffer(159) {}, Buffer(160) {}, Buffer(161) {},
		Buffer(162) {}, Buffer(163) {}, Buffer(164) {}, Buffer(165) {},
		Buffer(166) {}, Buffer(167) {}, Buffer(168) {}, Buffer(169) {},
		Buffer(170) {}, Buffer(171) {}, Buffer(172) {}, Buffer(173) {},
		Buffer(174) {}, Buffer(175) {}, Buffer(176) {}, Buffer(177) {},
		Buffer(178) {}, Buffer(179) {}, Buffer(180) {}, Buffer(181) {},
		Buffer(182) {}, Buffer(183) {}, Buffer(184) {}, Buffer(185) {},
		Buffer(186) {}, Buffer(187) {}, Buffer(188) {}, Buffer(189) {},
		Buffer(190) {}, Buffer(191) {}, Buffer(192) {}, Buffer(193) {},
		Buffer(194) {}, Buffer(195) {}, Buffer(196) {}, Buffer(197) {},
		Buffer(198) {}, Buffer(199) {},

		Buffer(200) {}, Buffer(201) {}, Buffer(202) {}, Buffer(203) {},
		Buffer(204) {}, Buffer(205) {}, Buffer(206) {}, Buffer(207) {},
		Buffer(208) {}, Buffer(209) {}, Buffer(210) {}, Buffer(211) {},
		Buffer(212) {}, Buffer(213) {}, Buffer(214) {}, Buffer(215) {},
		Buffer(216) {}, Buffer(217) {}, Buffer(218) {}, Buffer(219) {},
		Buffer(220) {}, Buffer(221) {}, Buffer(222) {}, Buffer(223) {},
		Buffer(224) {}, Buffer(225) {}, Buffer(226) {}, Buffer(227) {},
		Buffer(228) {}, Buffer(229) {}, Buffer(230) {}, Buffer(231) {},
		Buffer(232) {}, Buffer(233) {}, Buffer(234) {}, Buffer(235) {},
		Buffer(236) {}, Buffer(237) {}, Buffer(238) {}, Buffer(239) {},
		Buffer(240) {}, Buffer(241) {}, Buffer(242) {}, Buffer(243) {},
		Buffer(244) {}, Buffer(245) {}, Buffer(246) {}, Buffer(247) {},
		Buffer(248) {}, Buffer(249) {},

		Buffer(250) {}, Buffer(251) {}, Buffer(252) {}, Buffer(253) {},
		Buffer(254) {}, Buffer(255) {},
	})

	ts00(ts)

	// Too much time for 1 there, so use {8/16}
	Store(c040, Local6)
	Divide(255, Local6, Local1, Local0)
	Store(0, Local1)
	Store(0, Local5)

	While (Local0) {

		Store(DeRefOf(Index(p000, Local1)), Local2)
		Store(SizeOf(Local2), Local3)

		Add(Local1, 1, Local4)

		if (LNotEqual(Local4, Local3)) {
			err(ts, z051, 9, 0, 0, Local4, Local3)
		}

		Store(ObjectType(Local2), Local3)
		if (LNotEqual(Local3, 3)) {
			err(ts, z051, 10, 0, 0, Local3, 3)
		}

		Add(Local1, Local6, Local1)
		Decrement(Local0)
	}

	Store(SizeOf(p000), Local0)
	if (LNotEqual(Local0, 255)) {
		err(ts, z051, 11, 0, 0, Local0, 255)
	}
}

// Packages
Method(m1f3,, Serialized)
{
	Name(ts, "m1f3")

	Name(p000, Package() {
		Package(1) {},
		Package(2) {},
		Package(3) {},
		Package(4) {},
		Package(5) {},
		Package(6) {},
		Package(7) {},
		Package(8) {},
		Package(9) {},
		Package(10) {},

		Package() {1,2,3,4,5,6,7,8,9,10,11},
		Package() {1,2,3,4,5,6,7,8,9,10,11,12},
		Package() {1,2,3,4,5,6,7,8,9,10,11,12,13},
		Package() {1,2,3,4,5,6,7,8,9,10,11,12,13,14},
		Package() {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15},
		Package() {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16},
		Package() {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17},
		Package() {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18},
		Package() {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19},
		Package() {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20},

		Package(21) {}, Package(22) {}, Package(23) {}, Package(24) {},
		Package(25) {}, Package(26) {}, Package(27) {}, Package(28) {},
		Package(29) {}, Package(30) {}, Package(31) {}, Package(32) {},
		Package(33) {}, Package(34) {}, Package(35) {}, Package(36) {},
		Package(37) {}, Package(38) {}, Package(39) {}, Package(40) {},
		Package(41) {}, Package(42) {}, Package(43) {}, Package(44) {},
		Package(45) {}, Package(46) {}, Package(47) {}, Package(48) {},
		Package(49) {}, Package(50) {}, Package(51) {}, Package(52) {},
		Package(53) {}, Package(54) {}, Package(55) {}, Package(56) {},
		Package(57) {}, Package(58) {}, Package(59) {}, Package(60) {},
		Package(61) {}, Package(62) {}, Package(63) {}, Package(64) {},
		Package(65) {}, Package(66) {}, Package(67) {}, Package(68) {},
		Package(69) {}, Package(70) {}, Package(71) {}, Package(72) {},
		Package(73) {}, Package(74) {}, Package(75) {}, Package(76) {},
		Package(77) {}, Package(78) {}, Package(79) {}, Package(80) {},
		Package(81) {}, Package(82) {}, Package(83) {}, Package(84) {},
		Package(85) {}, Package(86) {}, Package(87) {}, Package(88) {},
		Package(89) {}, Package(90) {}, Package(91) {}, Package(92) {},
		Package(93) {}, Package(94) {}, Package(95) {}, Package(96) {},
		Package(97) {}, Package(98) {}, Package(99) {},

		Package(100) {}, Package(101) {}, Package(102) {}, Package(103) {},
		Package(104) {}, Package(105) {}, Package(106) {}, Package(107) {},
		Package(108) {}, Package(109) {}, Package(110) {}, Package(111) {},
		Package(112) {}, Package(113) {}, Package(114) {}, Package(115) {},
		Package(116) {}, Package(117) {}, Package(118) {}, Package(119) {},
		Package(120) {}, Package(121) {}, Package(122) {}, Package(123) {},
		Package(124) {}, Package(125) {}, Package(126) {}, Package(127) {},
		Package(128) {}, Package(129) {}, Package(130) {}, Package(131) {},
		Package(132) {}, Package(133) {}, Package(134) {}, Package(135) {},
		Package(136) {}, Package(137) {}, Package(138) {}, Package(139) {},
		Package(140) {}, Package(141) {}, Package(142) {}, Package(143) {},
		Package(144) {}, Package(145) {}, Package(146) {}, Package(147) {},
		Package(148) {}, Package(149) {},

		Package(150) {}, Package(151) {}, Package(152) {}, Package(153) {},
		Package(154) {}, Package(155) {}, Package(156) {}, Package(157) {},
		Package(158) {}, Package(159) {}, Package(160) {}, Package(161) {},
		Package(162) {}, Package(163) {}, Package(164) {}, Package(165) {},
		Package(166) {}, Package(167) {}, Package(168) {}, Package(169) {},
		Package(170) {}, Package(171) {}, Package(172) {}, Package(173) {},
		Package(174) {}, Package(175) {}, Package(176) {}, Package(177) {},
		Package(178) {}, Package(179) {}, Package(180) {}, Package(181) {},
		Package(182) {}, Package(183) {}, Package(184) {}, Package(185) {},
		Package(186) {}, Package(187) {}, Package(188) {}, Package(189) {},
		Package(190) {}, Package(191) {}, Package(192) {}, Package(193) {},
		Package(194) {}, Package(195) {}, Package(196) {}, Package(197) {},
		Package(198) {}, Package(199) {},

		Package(200) {}, Package(201) {}, Package(202) {}, Package(203) {},
		Package(204) {}, Package(205) {}, Package(206) {}, Package(207) {},
		Package(208) {}, Package(209) {}, Package(210) {}, Package(211) {},
		Package(212) {}, Package(213) {}, Package(214) {}, Package(215) {},
		Package(216) {}, Package(217) {}, Package(218) {}, Package(219) {},
		Package(220) {}, Package(221) {}, Package(222) {}, Package(223) {},
		Package(224) {}, Package(225) {}, Package(226) {}, Package(227) {},
		Package(228) {}, Package(229) {}, Package(230) {}, Package(231) {},
		Package(232) {}, Package(233) {}, Package(234) {}, Package(235) {},
		Package(236) {}, Package(237) {}, Package(238) {}, Package(239) {},
		Package(240) {}, Package(241) {}, Package(242) {}, Package(243) {},
		Package(244) {}, Package(245) {}, Package(246) {}, Package(247) {},
		Package(248) {}, Package(249) {},

		Package(250) {}, Package(251) {}, Package(252) {}, Package(253) {},
		Package(254) {}, Package(255) {},
	})

	ts00(ts)

	// Too much time for 1 there, so use {8/16}
	Store(c040, Local6)
	Divide(255, Local6, Local1, Local0)
	Store(0, Local1)
	Store(0, Local5)

	While (Local0) {

		Store(DeRefOf(Index(p000, Local1)), Local2)
		Store(SizeOf(Local2), Local3)

		Add(Local1, 1, Local4)

		if (LNotEqual(Local4, Local3)) {
			err(ts, z051, 12, 0, 0, Local4, Local3)
		}

		Store(ObjectType(Local2), Local3)
		if (LNotEqual(Local3, 4)) {
			err(ts, z051, 13, 0, 0, Local3, 4)
		}

		Add(Local1, Local6, Local1)
		Decrement(Local0)
	}

	Store(SizeOf(p000), Local0)
	if (LNotEqual(Local0, 255)) {
		err(ts, z051, 14, 0, 0, Local0, 255)
	}
}

// Do test for Methods, when Methods will be implemented !!!!!!!!!!!!!!!
Method(m1f4,, Serialized)
{
	Name(ts, "m1f4")

	ts00(ts)

// Not implemented yet

	Method(m000) {return ("aaaa")}
	Method(m001) {return (Buffer() {1,2,3,4})}
	Method(m002) {return (Package() {1,2,3,4,5})}
//	Method(m003) {return (0)}

	Store("============= vvvvvvvvvvvvv", Debug)
	Store(RefOf(m000), Local0)
	Store(SizeOf(Local0), Local1)
	// Store(SizeOf(m000), Local1)
	Store(Local0, Debug)
	Store(Local1, Debug)
	Store("============= ccccccccccccc", Debug)

	return (0)
}

Method(m1f5, 3, Serialized)
{
	// n000 - decr cur counter (levels num)
	// n001 - incr cur counter
	// n002 - type of target object
	// n004 - size of target object
	// n003 - incr cur counter (index of first level)

	Name(n000, 0)
	Name(n001, 0)
	Name(n002, 0x1234)
	Name(n004, 0)
	Name(n003, 4)

	// Type of target object
	Store(DeRefOf(Index(arg2, 0)), n002)

	// Size of target object
	Store(DeRefOf(Index(arg2, 1)), n004)

	// Repetition
	Store(DeRefOf(Index(arg2, 3)), n000)

	// Cur de-reference
	Store(arg1, Local7)

	While (n000) {

		// Index in cur object
		Store(DeRefOf(Index(arg2, n003)), Local0)

		// Cur de-reference
		Store(DeRefOf(Index(Local7, Local0)), Local7)

		Store(ObjectType(Local7), Local0)

		Increment(n003)
		Increment(n001)
		Decrement(n000)
	}

	// Type

	Store(ObjectType(Local7), Local0)
	if (LNotEqual(Local0, n002)) {
		err(arg0, z051, 15, 0, 0, Local0, n002)
	}

	// Contents

	if (LGreaterEqual(n002, 1)) {
		if (LLessEqual(n002, 3)) {

			Store(0, Local6)
			Store(0, Local1)

			Store(DeRefOf(Index(arg2, 2)), Local0)

			if (LNotEqual(n002, 1)) {
				Store(SizeOf(Local0), Local1)
			}

			if (LNotEqual(Local1, n004)) {
				err(arg0, z051, 16, 0, 0, Local1, n004)
				Store(1, Local6)
			} elseif (LNotEqual(Local7, Local0)) {
				err(arg0, z051, 17, 0, 0, Local7, Local0)
				Store(1, Local6)
			}
			if (Local6) {
				Store("============= To ERROR:", Debug)
				Store(Local0, Debug)
				Store(Local7, Debug)
				Store("=============.", Debug)
			}
		}
	}
}

// Mix
// - all one level combinations
// - 255 levels in depth
Method(m1f6,, Serialized)
{
	Name(ts, "m1f6")

	Name(p000, Package() {

		// 0

		0xb2345678,
		"qwert",
		Buffer() {1,2,3,4,5,6},
		Package(1) {},

		// 4, Integer, String, Buffer

		Package() {0},
		Package() {"qwhj"},
		Package() {1, "qwu"},
		Package() {"er", 2},
		Package() {Buffer() {1}},
		Package() {3, Buffer() {2,3}},
		Package() {Buffer() {4,5,6}, 4},
		Package() {"a", Buffer() {7,8,9,10}},
		Package() {Buffer() {11,12,13,14,15}, "qw"},
		Package() {Buffer() {16,17}, "12r", 55},
		Package() {Buffer() {18,19}, 56, "ghjk"},
		Package() {57, Buffer() {20,21,22}, "ghjkf"},
		Package() {58, "sdfghj", Buffer() {23,24}},
		Package() {"sdfghjg", Buffer() {25}, 59},
		Package() {"sdfghjgg", 60, Buffer() {26,27}},

		// 19, Integer, String, Buffer, Package

		Package() {Package() {0}},
		Package() {0, Package() {0,1}},
		Package() {Package() {0}, 1},
		Package() {"qwhj", Package() {0,1,2}},
		Package() {Package() {0}, "ffrgg"},
		Package() {1, "qwum", Package() {3,4,4,4}},
		Package() {2, Package() {5,5,5,5,5,}, "dfgh"},
		Package() {"qwu", 3, Package() {6,6,6,6,6,6}},
		Package() {"qwuuio", Package() {7,7,7,7,7,7,7}, 4},
		Package() {Package() {8,8,8,8,8,8,8,8}, "asd0000f", 5},
		Package() {Package() {9,9,9,9,9,9,9}, 6, "fasdfbvcd"},
		// 30
		Package() {Package() {10,1,1,1,1,2}, Buffer() {28,2,3,4,5,6}},
		Package() {Buffer() {29,2,3,4,5,6}, Package() {9,8,7,6,5}},
		Package() {Package() {0,8,7,6}, 9, Buffer() {1,2,30,4,5,6}},
		Package() {Package() {6,5,3}, Buffer() {1,2,31,4,5,6}, 10},
		Package() {Buffer() {1,2,32,4,5,6}, Package() {6,7}, 11},
		Package() {Buffer() {1,2,33,4,5,6}, 12, Package(7) {0}},
		Package() {12, Package() {7,6}, Buffer() {1,2,34,4,5,6}},
		Package() {13, Buffer() {1,2,35,4,5,6}, Package() {5,4,6}},
		Package() {Package() {8,7,6,5}, "sdfghjg0", Buffer() {36}},
		Package() {Package() {8,7,8,9,0}, Buffer() {37,38}, "cbvnm"},
		// 40
		Package() {"sdfgh1jg", Buffer() {39}, Package() {9,9,7,6,5,4}},
		Package() {"sdf2ghjg", Package() {9,0,3,4,5,7,6}, Buffer() {40,1,2}},
		Package() {Buffer() {41,2}, "cb3vnm", Package() {8,0,3,5,1,8}},
		Package() {Buffer() {1,42}, Package() {8,7,6,5,4}, "zx"},
		Package() {Package() {2,7,0,4}, "sdfgh4jg", Buffer() {1,2,43}, 59},
		Package() {Package() {55,66,77}, "sdfghj5g", 70, Buffer() {1,2,44,45}},
		Package() {Package() {99,12}, Buffer() {46,47,48,1,2}, "g6g", 59},
		Package() {Package() {1234}, Buffer() {49,1,2}, 59, "d7fg"},
		Package() {Package() {46,59}, 7, "8sdfghjg", Buffer() {1,2,50}},
		Package() {Package() {76,98,62}, 8, Buffer() {51,2}, "9sdfghjg"},
		// 50
		Package() {"s10dfghjg", Package() {47,78,74,37}, Buffer() {1,52}, 59},
		Package() {"sdf11ghjg", Package() {70,12,34,45,56}, 70, Buffer() {53}},
		Package() {Buffer() {1,2,54}, Package() {90,12,13,14,15,19}, "g12g", 59},
		Package() {Buffer() {1,2,55}, Package() {87,94,83,42,54}, 59, "d1f3g"},
		Package() {7, Package() {34,56,78,90}, "1sdf4ghjg", Buffer() {1,2,56}},
		Package() {8, Package() {76,43,79}, Buffer() {1,2,57,58}, "s1dfg5hjg"},
		Package() {"sd1fg6hjg", Buffer() {1,2,59}, Package() {55,89}, 59},
		Package() {"sdfg17hjg", 70, Package() {92}, Buffer() {1,60,2}},
		Package() {Buffer() {61,2}, "g18g", Package() {67,89}, 59},
		Package() {Buffer() {1,62}, 59, Package() {46,89,90}, "dfg19"},
		// 60
		Package() {0x82987640, "sdf2gh0jg", Package() {43,79,45,67}, Buffer() {1,2,63}},
		Package() {8, Buffer() {64,1,2}, Package() {56,78,96}, "21sdfghjg"},
		Package() {"sd22fghjg", Buffer() {65}, 59, Package() {49,60}},
		Package() {"sdfg23hjg", 70, Buffer() {66,67,1,2}, Package() {20}},
		Package() {Buffer() {1,2,68,69,70}, "2g4g", 59, Package() {11,22}},
		Package() {Buffer() {71,2}, 59, "2dfg5", Package() {11,22,33}},
		Package() {7, "sd26fghjg", Buffer() {1,72}, Package() {55,66,77,88}},
		Package() {1145677, Buffer() {1,73,2,3,4}, "shjd2fg7hjg",
						Package() {89,67,54,32,1,2,3}},
		Package() {
		 Package() {
		  Package() {
		   Package() {
		    Package() {0x9b8def45
		    },
		   },
		  },
		 },
		},
		Package(255) {9,7,8,89,67,54,32,1,2,3,1234,456789},

		// 70

		Package(10) {11045677,
				Buffer(202) {1,73,92,39,4},
				Buffer(5) {1,73,92,39,4},
				"shjd2fg7hjg0123456",
				"0123456789qwertyuiop012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789",
				Package(11) {89,67,54,32,1,2,3,33,44,55,66},
				Package(255) {89,67,54,32,1,2,3,1234,456789},
		},
		71,72,73,74,75,76,77,78,79,

		// 80

		0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,

		// 100

		0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
		0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
		0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
		0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
		0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,

		// 200

		0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
		0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
		0,1,2,3,4,5,6,7,8,9,

		// 250

		250, 251, 252, 253,

		// 254 (maximal element)

		// + one encircling Package, 0-63
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		// 64-127
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		// 128-191
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		// 192-253
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() { Package() { Package() {
		Package() { Package() {

			0x9b8def45,
			"q0w1e2r3t4y5u6i7o8p91234567890",
			Buffer() {17,28,69,11,22,34,35,56,67,11},
			Package() {19,27,74,32,18,2,3,67,34},

		// 192-253
		      }, }, }, }, }, }, }, }, }, }, }, }, }, },
		}, }, }, }, }, }, }, }, }, }, }, }, }, }, }, },
		}, }, }, }, }, }, }, }, }, }, }, }, }, }, }, },
		}, }, }, }, }, }, }, }, }, }, }, }, }, }, }, },

			0x19283746

		// 128-191
		}, }, }, }, }, }, }, }, }, }, }, }, }, }, }, },
		}, }, }, }, }, }, }, }, }, }, }, }, }, }, }, },
		}, }, }, }, }, }, }, }, }, }, }, }, }, }, }, },
		}, }, }, }, }, }, }, }, }, }, }, }, }, }, }, },

			0x98765432

		// 64-127
		}, }, }, }, }, }, }, }, }, }, }, }, }, }, }, },
		}, }, }, }, }, }, }, }, }, }, }, }, }, }, }, },
		}, }, }, }, }, }, }, }, }, }, }, }, }, }, }, },
		}, }, }, }, }, }, }, }, }, }, }, }, }, }, }, },

			0x12345678,

		// 32-63
		}, }, }, }, }, }, }, }, }, }, }, }, }, }, }, },
		}, }, }, }, }, }, }, }, }, }, }, }, }, }, }, },

			0xb0ac61df,

		// 16-31
		}, }, }, }, }, }, }, }, }, }, }, }, }, }, }, },

			0xc1dc51b3,
			"qwertyuiop1234567890",
			Buffer() {1,2,63,11,22,34,35,56,67},
			Package() {19,27,74,32,18,2,3},

		// 0-15
		}, }, }, }, }, }, }, }, }, }, }, }, }, }, },

			// 1
			1,2,3,4,5,6,7,8,9,

			// 10
			0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
			0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
			0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
			0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
			0,1,2,3,4,5,6,7,8,9,

			// 100
			0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
			0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
			0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
			0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
			0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,

			// 200
			0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
			0,1,2,3,4,5,6,7,8,9, 0,1,2,3,4,5,6,7,8,9,
			0,1,2,3,4,5,6,7,8,9,

			// 250

			250, 251, 252, 253, Buffer(300) {1,2,63,99,5,67,14,0,6,0,31},
		},
	})

	Name(p001, Package() {

		// 0 - 12
		Package() {1, 0, 0xb2345678, 1, 0},
		Package() {2, 5, "qwert", 1, 1},
		Package() {3, 6, Buffer() {1,2,3,4,5,6}, 1, 2},
		Package() {4, 1, 0, 1, 3},
		Package() {1, 0, 0x82987640, 2, 60, 0},
		Package() {2, 9, "sdf2gh0jg", 2, 60, 1},
		Package() {4, 4, 0, 2, 60, 2},
		Package() {3, 3, Buffer() {1,2,63}, 2, 60, 3},
		Package() {1, 0, 1145677, 2, 67, 0},
		Package() {3, 5, Buffer() {1,73,2,3,4}, 2, 67, 1},
		Package() {2, 11, "shjd2fg7hjg", 2, 67, 2},
		Package() {4, 7, 0, 2, 67, 3},
		Package() {1, 0, 0x9b8def45, 6, 68,0,0,0,0,0},

		// 13-19
		Package() {1, 0, 11045677, 2, 70, 0},
		Package() {3, 202, Buffer(202) {1,73,92,39,4}, 2, 70, 1},
		Package() {3, 5, Buffer(5) {1,73,92,39,4}, 2, 70, 2},
		Package() {2, 18, "shjd2fg7hjg0123456", 2, 70, 3},
		Package() {2, 200,
				"0123456789qwertyuiop012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789",
				2, 70, 4},
		Package() {4, 11, 0, 2, 70, 5},
		Package() {4, 255, 0, 2, 70, 6},

		// 20
		Package() {3, 300, Buffer(300) {1,2,63,99,5,67,14,0,6,0,31}, 2, 254, 254},

		// 21-28
		Package() {1, 0, 0xc1dc51b3, 17, 254,
			// 0-15
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1,
		},
		Package() {2, 20, "qwertyuiop1234567890", 17, 254,
			// 0-15
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,2,
		},
		Package() {3, 9, Buffer() {1,2,63,11,22,34,35,56,67}, 17, 254,
			// 0-15
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,3,
		},
		Package() {4, 7, Package() {19,27,74,32,18,2,3}, 17, 254,
			// 0-15
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,4,
		},
		Package() {1, 0, 0xb0ac61df, 33, 254,
			// 0-31
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1,
		},
		Package() {1, 0, 0x12345678, 65, 254,
			// 0-63
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1,
		},
		Package() {1, 0, 0x98765432, 129, 254,
			// 0-63
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			// 64-127
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1,
		},
		Package() {1, 0, 0x9b8def45, 255, 254,
			// 0-63
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			// 64-127
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			// 128-191
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			// 192-253
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,
			0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,
		},
	})

	// n000 - step
	// n001 - decr cur counter
	// n002 - incr cur counter

	ts00(ts)

	Name(n000, 0)
	Name(n001, 0)
	Name(n002, 0)

	// Too much time for 1 there, so use {8/16}
	Store(1, n000)
	Divide(c041, n000, n002, n001)
	Store(0, n002)

	While (n001) {

		if (pr02) {
			Store(n001, Debug)
		}

		Store(DeRefOf(Index(p001, n002)), Local0)
		Store(ObjectType(Local0), Local1)

		m1f5(ts, p000, Local0)

		Add(n002, n000, n002)
		Decrement(n001)
	}

	Store(SizeOf(p000), Local0)
	if (LNotEqual(Local0, 255)) {
		err(ts, z051, 18, 0, 0, Local0, 255)
	}

	Store(SizeOf(p001), Local0)
	if (LNotEqual(Local0, 29)) {
		err(ts, z051, 19, 0, 0, Local0, 29)
	}
}

// Check uninitialized elements of Package
//
// Now - causes crash!!!!!!!
// Do this test when ObjectType will be fixed.
Method(m1f7,, Serialized)
{
	Name(ts, "m1f7")

	ts00(ts)

	Name(p000, Package(255) {})

//	Store(DeRefOf(Index(p000, 0)), Local0)
	Store(Index(p000, 0), Local0)

	Store(ObjectType(Local0), Local2)
//	Store(ObjectType(Local0), Local1)
}

// Write Integers into Package, then Read and verify
//
// <Package>,<size>,<start value>
Method(m1f8, 3, Serialized)
{
	Name(ts, "m1f8")

	Name(n000, 0)
	Name(ncur, 0)

	// Writing with indexes

	Store(arg1, n000)
	Store(0, ncur)
	Store(arg2, Local0)

	While (n000) {
		Store(Local0, Index(arg0, ncur))
		if (0) {
			Store(Local0, Debug)
		}
		Increment(Local0)
		Decrement(n000)
		Increment(ncur)
	}

	// Reading and verifying

	Store(arg1, n000)
	Store(0, ncur)
	Store(arg2, Local0)

	While (n000) {
		Store(DeRefOf(Index(arg0, ncur)), Local1)
		if (0) {
			Store(Local1, Debug)
		}
		if (LNotEqual(Local1, Local0)) {
			err(ts, z051, 20, 0, 0, Local1, Local0)
		}
		Increment(Local0)
		Decrement(n000)
		Increment(ncur)
	}

	Store(ObjectType(arg0), Local0)
	if (LNotEqual(Local0, 4)) {
		err(ts, z051, 21, 0, 0, Local0, 4)
	}

	Store(SizeOf(arg0), Local0)
	if (LNotEqual(Local0, arg1)) {
		err(ts, z051, 22, 0, 0, Local0, arg1)
	}
}

Method(m1f9, 1, Serialized)
{
	Name(p000, Package(arg0) {})

	// Write
	m1f8(p000, arg0, 0x80000000)

	// Re-write
	m1f8(p000, arg0, 0x12345678)
}

// Write/rewrite Integers into Package and verify
Method(m1fa,, Serialized)
{
	Name(ts, "m1fa")

	ts00(ts)

	m1f9(255)
}

// Write Strings into Package, then Read and verify
//
// <Package>,<size>,<start string>
Method(m1fb, 3, Serialized)
{
	Name(ts, "m1fb")

	Name(n000, 0)
	Name(ncur, 0)

	// Writing with indexes

	Store(arg1, n000)
	Store(0, ncur)

	While (n000) {
		Concatenate(arg2, ncur, Local0)
		Store(Local0, Index(arg0, ncur))
		if (0) {
			Store(Local0, Debug)
		}
		Decrement(n000)
		Increment(ncur)
	}

	// Reading and verifying

	Store(arg1, n000)
	Store(0, ncur)

	While (n000) {
		Concatenate(arg2, ncur, Local0)
		Store(DeRefOf(Index(arg0, ncur)), Local1)
		if (0) {
			Store(Local1, Debug)
		}
		if (LNotEqual(Local1, Local0)) {
			err(ts, z051, 23, 0, 0, Local1, Local0)
		}
		Decrement(n000)
		Increment(ncur)
	}

	Store(ObjectType(arg0), Local0)
	if (LNotEqual(Local0, 4)) {
		err(ts, z051, 24, 0, 0, Local0, 4)
	}

	Store(SizeOf(arg0), Local0)
	if (LNotEqual(Local0, arg1)) {
		err(ts, z051, 25, 0, 0, Local0, arg1)
	}
}

Method(m1fc, 1, Serialized)
{
	Name(p000, Package(arg0) {})

	// Write
	m1fb(p000, arg0, "qwert")

	// Re-write
	m1fb(p000, arg0, "mnbvcxzdf0123456789qwertyuiopllkjhgfdsa")
}

// Write/rewrite Strings into Package and verify
Method(m1fd,, Serialized)
{
	Name(ts, "m1fd")

	ts00(ts)

	m1fc(255)
}

// Write Buffers into Package, then Read and verify
//
// <Package>,<size>,<start buffer>
Method(m1fe, 3, Serialized)
{
	Name(ts, "m1fe")

	Name(n000, 0)
	Name(ncur, 0)

	// Writing with indexes

	Store(arg1, n000)
	Store(0, ncur)

	While (n000) {
		Concatenate(arg2, ncur, Local0)
		Store(Local0, Index(arg0, ncur))
		if (0) {
			Store(Local0, Debug)
		}
		Decrement(n000)
		Increment(ncur)
	}

	// Reading and verifying

	Store(arg1, n000)
	Store(0, ncur)

	While (n000) {
		Concatenate(arg2, ncur, Local0)
		Store(DeRefOf(Index(arg0, ncur)), Local1)

		if (0) {
			Store(ncur, Debug)
			Store(Local0, Debug)
			Store(Local1, Debug)
		}
		if (LNotEqual(Local1, Local0)) {
			err(ts, z051, 26, 0, 0, 0, 0)
			Store(Local0, Debug)
			Store(Local1, Debug)
			return (Ones)
		}
		Decrement(n000)
		Increment(ncur)
	}

	Store(ObjectType(arg0), Local0)
	if (LNotEqual(Local0, 4)) {
		err(ts, z051, 27, 0, 0, Local0, 4)
	}

	Store(SizeOf(arg0), Local0)
	if (LNotEqual(Local0, arg1)) {
		err(ts, z051, 28, 0, 0, Local0, arg1)
	}

	return (Zero)
}

// More complex cases with buffers of different sizes
// are performed into conversion tests.
Method(m1ff, 1, Serialized)
{
	Name(p000, Package(arg0) {})

	// Write
	m1fe(p000, arg0, Buffer() {81,82,83,84,85})

	// Re-write
	m1fe(p000, arg0, Buffer() {1,2,3,4,5})
}

// Write/rewrite Buffers into Package and verify
Method(m200,, Serialized)
{
	Name(ts, "m200")

	ts00(ts)

	m1ff(255)
}

// Write Packages into Package, then Read (and verify)
//
// <Package>,<size>,<start Package>
Method(m201, 3, Serialized)
{
	Name(pr00, 0)

	Name(ts, "m201")

	Name(n000, 0)
	Name(ncur, 0)

	// Writing with indexes

	Store(arg1, n000)
	Store(0, ncur)

	if (pr00) {
		Store("Writing:", Debug)
	}

	While (n000) {
		if (pr00) {
			Store(ncur, Debug)
		}
		Store(arg2, Index(arg0, ncur))
		Decrement(n000)
		Increment(ncur)
	}

	// Reading (and verifying)

	Store(arg1, n000)
	Store(0, ncur)

	if (pr00) {
		Store("Reading:", Debug)
	}

	While (n000) {
		if (pr00) {
			Store(ncur, Debug)
		}
		Store(DeRefOf(Index(arg0, ncur)), Local1)
		Store(ObjectType(Local1), Local0)
		if (LNotEqual(Local0, 4)) {
			err(ts, z051, 29, 0, 0, Local0, 4)
			return (Ones)
		}
		Decrement(n000)
		Increment(ncur)
	}

	Store(ObjectType(arg0), Local0)
	if (LNotEqual(Local0, 4)) {
		err(ts, z051, 30, 0, 0, Local0, 4)
	}

	Store(SizeOf(arg0), Local0)
	if (LNotEqual(Local0, arg1)) {
		err(ts, z051, 31, 0, 0, Local0, arg1)
	}
	return (Zero)
}

// More complex cases are performed into obj_deletion.asl test
Method(m202, 1, Serialized)
{
	Name(p000, Package(arg0) {})

	// Write
	m201(p000, arg0, Package() {81})

	// Re-write
	m201(p000, arg0, Package() {81})
}

// Write/rewrite Packages into Package (and verify)
//
// Verification of the contents of Packages is not
// performed, too complex.
Method(m203,, Serialized)
{
	Name(ts, "m203")

	ts00(ts)

//	m202(255)
	m202(1)
}

// Run-method
Method(PCG0)
{
	Store("TEST: PCG0, Declare Package Object", Debug)

	SRMT("m1f0")
	m1f0()
	SRMT("m1f1")
	m1f1()
	SRMT("m1f2")
	m1f2()
	SRMT("m1f3")
	m1f3()
//	SRMT("m1f4")
//	m1f4()
	SRMT("m1f6")
	m1f6()
//	SRMT("m1f7")
//	m1f7()
	SRMT("m1fa")
	m1fa()
	SRMT("m1fd")
	m1fd()
	SRMT("m200")
	m200()
	SRMT("m203")
	m203()
}

