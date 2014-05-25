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
 * BankField objects definition and processing
 */

/*
 * On testing following issues should be covered:
 * - Operation Regions of different Region Space types application
 *   for BankField objects definition,
 * - Operation Regions of different Region Space types application
 *   for definition of bank selection register Field object used in
 *   BankField objects definition,
 * - application of any TermArg as a BankValue Integer,
 * - application of any allowed AccessType Keywords,
 * - application of any allowed LockRule Keywords,
 * - application of any allowed UpdateRule Keywords,
 * - application of the Offset macros in the FieldUnitList,
 * - application of the AccessAs macros in the FieldUnitList,
 * - on writing taking into account the Access Type in accord with
     the Update Rule,
 * - AccessAs macros influence on the remaining Field Units within the list,
 * - access to BankField objects in accord with the bank selection register
 *   functionality,
 * - integer/buffer representation of the Unit contents as depends on its
 *   Length and DSDT ComplianceRevision (32/64-bit Integer),
 * - Data Type Conversion Rules on storing to BankFields,
 * - check that Bank value can be computational data.
 *
 * Can not be tested following issues:
 * - exact use of given Access Type alignment on Access to Unit data,
 * - exact functioning of data exchange based on BankField functionality,
 * - exact use of specific Conversion Rules on storing of Buffers or Strings.
 */

Name(z145, 145)

OperationRegion(OPRi, SystemIO, 0x200, 0x10)
OperationRegion(OPRj, SystemIO, 0x230, 0x133)

// Check against benchmark value
// m7bf(msg, result, benchmark, errnum)
Method(m7bf, 4)
{
	if (LNotEqual(ObjectType(arg1), ObjectType(arg2))) {
		err(arg0, z145, arg3, 0, 0, ObjectType(arg1), ObjectType(arg2))
	} elseif (LNotEqual(arg1, arg2)) {
		err(arg0, z145, arg3, 0, 0, arg1, arg2)
	}
}

// Simple BankField test
Method(m7c0, 1, Serialized)
{
	Field (OPRi, ByteAcc, NoLock, Preserve) {
		bnk0, 8
	}

	BankField (OPRj, bnk0, 2, ByteAcc, NoLock, Preserve) {
		Offset(8),
		bf00, 8,
	}

	BankField (OPRj, bnk0, 3, ByteAcc, NoLock, Preserve) {
		Offset(8),
		bf01, 8,
	}

	Concatenate(arg0, "-m7c0", arg0)

//
// Full support for bank fields not implemented in acpiexec, so
// we have to perform write/reads in order. Otherwise, we would
// interleave them.

	// Write bf00

	Store(0xff, bnk0)
	m7bf(arg0, bnk0, 0xff, 1)

	Store(0x67, bf00)
	m7bf(arg0, bnk0, 2, 2)

	// Read bf00

	Store(0xff, bnk0)
	m7bf(arg0, bnk0, 0xff, 5)

	Store(bf00, Local1)
	m7bf(arg0, Local1, 0x67, 6)
	m7bf(arg0, bnk0, 2, 7)

	// Write bf01

	Store(0xff, bnk0)
	m7bf(arg0, bnk0, 0xff, 3)

	Store(0x89, bf01)
	m7bf(arg0, bnk0, 3, 4)

	// Read bf01

	Store(0xff, bnk0)
	m7bf(arg0, bnk0, 0xff, 8)

	Store(bf01, Local1)
	m7bf(arg0, Local1, 0x89, 9)
	m7bf(arg0, bnk0, 3, 10)
}

// Testing parameters Packages
// Layout see in regionfield.asl

// (ByteAcc, NoLock, Preserve)
Name(pp20, Package() {
		0, 8, 0, 8, Package(6){0, 1, 1, 0, 1, "m7d0"},
})

// (WordAcc, NoLock, WriteAsOnes)
Name(pp21, Package() {
		0, 8, 8, 8, Package(6){0, 2, 2, 1, 1, "m7d1"},
})

// (DWordAcc, NoLock, WriteAsZeros)
Name(pp22, Package() {
		8, 8, 0, 8, Package(6){1, 2, 3, 2, 1, "m7d2"},
})

// (QWordAcc, NoLock, Preserve)
Name(pp23, Package() {
		8, 4, 8, 8, Package(6){1, 0, 3, 0, 1, "m7d3"},
})

// (AnyAcc, Lock, Preserve)
Name(pp24, Package() {
		12, 4, 8, 8, Package(6){0, 1, 0, 0, 0, "m7d4"},
})

// Check BankField access: ByteAcc, NoLock, Preserve
// m7c1(CallChain)
Method(m7c1, 1)
{
	Concatenate(arg0, "-m7c1", arg0)

	Store("TEST: m7c1, Check BankFields specified as (ByteAcc, NoLock, Preserve)", Debug)

	m72f(arg0, 1, "pp20", pp20)
}

// Check BankField access: WordAcc, NoLock, WriteAsOnes
// m7c2(CallChain)
Method(m7c2, 1)
{
	Concatenate(arg0, "-m7c2", arg0)

	Store("TEST: m7c2, Check BankFields specified as (WordAcc, NoLock, WriteAsOnes)", Debug)

	m72f(arg0, 1, "pp21", pp21)
}

// Check BankField access: DWordAcc, NoLock, WriteAsZeros
// m7c3(CallChain)
Method(m7c3, 1)
{
	Concatenate(arg0, "-m7c3", arg0)

	Store("TEST: m7c3, Check BankFields specified as (DWordAcc, NoLock, WriteAsZeros)", Debug)

	m72f(arg0, 1, "pp22", pp22)
}

// Check BankField access: QWordAcc, NoLock, Preserve
// m7c4(CallChain)
Method(m7c4, 1)
{
	Concatenate(arg0, "-m7c4", arg0)

	Store("TEST: m7c4, Check BankFields specified as (QWordAcc, NoLock, Preserve)", Debug)

	m72f(arg0, 1, "pp23", pp23)
}

// Check BankField access: AnyAcc, Lock, Preserve
// m7c5(CallChain)
Method(m7c5, 1)
{
	Concatenate(arg0, "-m7c5", arg0)

	Store("TEST: m7c5, Check BankFields specified as (AnyAcc, Lock, Preserve)", Debug)

	m72f(arg0, 1, "pp24", pp24)
}

// Create BankField Unit
// (ByteAcc, NoLock, Preserve)
Method(m7d0, 6, Serialized)
{
	OperationRegion(OPRb, SystemIO, 0, 9)
	OperationRegion(OPR0, SystemIO, 11, 256)

	Field(OPRb, ByteAcc, NoLock, Preserve) {
		BNK0, 8,
	}
	BankField(OPR0, BNK0, 0, ByteAcc, NoLock, Preserve) {
		g000, 2048,
	}
	BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}
	BankField(OPR0, BNK0, 2, ByteAcc, NoLock, Preserve) {
		g002, 2048,
	}
	BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
		g003, 2048,
	}
	BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
		g004, 2048,
	}
	BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
		g005, 2048,
	}
	BankField(OPR0, BNK0, 6, ByteAcc, NoLock, Preserve) {
		g006, 2048,
	}
	BankField(OPR0, BNK0, 7, ByteAcc, NoLock, Preserve) {
		g007, 2048,
	}
	BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
		g008, 2048,
	}
	BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
		g009, 2048,
	}
	BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
		g00a, 2048,
	}
	BankField(OPR0, BNK0, 64, ByteAcc, NoLock, Preserve) {
		g00b, 2048,
	}
	BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
		g00c, 2048,
	}
	BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
		g00d, 2048,
	}
	BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
		g00e, 2048,
	}


	Concatenate(arg0, "-m7d0", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, ByteAcc, NoLock, Preserve) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f001, 6}
				Store(Refof(f001), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, ByteAcc, NoLock, Preserve) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f003, 8}
				Store(Refof(f003), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f005, 31}
				Store(Refof(f005), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, ByteAcc, NoLock, Preserve) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f007, 33}
				Store(Refof(f007), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f009, 64}
				Store(Refof(f009), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z145, 11, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 1, f010, 1}
				Store(Refof(f010), Local3)
				Store(Refof(g001), Local4)
			}
			case (6) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, ByteAcc, NoLock, Preserve) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
				Store(Refof(g002), Local4)
			}
			case (7) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 1, f012, 7}
				Store(Refof(f012), Local3)
				Store(Refof(g003), Local4)
			}
			case (8) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
				Store(Refof(g004), Local4)
			}
			case (9) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 1, f014, 9}
				Store(Refof(f014), Local3)
				Store(Refof(g005), Local4)
			}
			case (31) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, ByteAcc, NoLock, Preserve) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
				Store(Refof(g006), Local4)
			}
			case (32) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 1, f016, 32}
				Store(Refof(f016), Local3)
				Store(Refof(g007), Local4)
			}
			case (33) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
				Store(Refof(g008), Local4)
			}
			case (63) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 1, f018, 63}
				Store(Refof(f018), Local3)
				Store(Refof(g009), Local4)
			}
			case (64) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
				Store(Refof(g00a), Local4)
			}
			case (65) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
				Store(Refof(g00b), Local4)
			}
			case (69) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
				Store(Refof(g00c), Local4)
			}
			case (129) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
				Store(Refof(g00d), Local4)
			}
			case (256) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1023) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
				Store(Refof(g000), Local4)
			}
			case (1983) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
				Store(Refof(g001), Local4)
			}
			default {
				err(arg0, z145, 12, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, ByteAcc, NoLock, Preserve) {
					, 2, f020, 1}
				Store(Refof(f020), Local3)
				Store(Refof(g002), Local4)
			}
			case (6) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f021, 6}
				Store(Refof(f021), Local3)
				Store(Refof(g003), Local4)
			}
			case (7) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					, 2, f022, 7}
				Store(Refof(f022), Local3)
				Store(Refof(g004), Local4)
			}
			case (8) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f023, 8}
				Store(Refof(f023), Local3)
				Store(Refof(g005), Local4)
			}
			case (9) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, ByteAcc, NoLock, Preserve) {
					, 2, f024, 9}
				Store(Refof(f024), Local3)
				Store(Refof(g006), Local4)
			}
			case (31) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f025, 31}
				Store(Refof(f025), Local3)
				Store(Refof(g007), Local4)
			}
			case (32) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					, 2, f026, 32}
				Store(Refof(f026), Local3)
				Store(Refof(g008), Local4)
			}
			case (33) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f027, 33}
				Store(Refof(f027), Local3)
				Store(Refof(g009), Local4)
			}
			case (63) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
					, 2, f028, 63}
				Store(Refof(f028), Local3)
				Store(Refof(g00a), Local4)
			}
			case (64) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f029, 64}
				Store(Refof(f029), Local3)
				Store(Refof(g00b), Local4)
			}
			case (65) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
					, 2, f02a, 65}
				Store(Refof(f02a), Local3)
				Store(Refof(g00c), Local4)
			}
			case (69) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f02b, 69}
				Store(Refof(f02b), Local3)
				Store(Refof(g00d), Local4)
			}
			case (129) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					, 2, f02c, 129}
				Store(Refof(f02c), Local3)
				Store(Refof(g00e), Local4)
			}
			case (256) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f02d, 256}
				Store(Refof(f02d), Local3)
				Store(Refof(g000), Local4)
			}
			case (1023) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
					, 2, f02e, 1023}
				Store(Refof(f02e), Local3)
				Store(Refof(g001), Local4)
			}
			case (1983) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 2, f02f, 1983}
				Store(Refof(f02f), Local3)
				Store(Refof(g002), Local4)
			}
			default {
				err(arg0, z145, 13, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f030, 1}
				Store(Refof(f030), Local3)
				Store(Refof(g003), Local4)
			}
			case (6) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
				Store(Refof(g004), Local4)
			}
			case (7) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f032, 7}
				Store(Refof(f032), Local3)
				Store(Refof(g005), Local4)
			}
			case (8) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, ByteAcc, NoLock, Preserve) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
				Store(Refof(g006), Local4)
			}
			case (9) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f034, 9}
				Store(Refof(f034), Local3)
				Store(Refof(g007), Local4)
			}
			case (31) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
				Store(Refof(g008), Local4)
			}
			case (32) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f036, 32}
				Store(Refof(f036), Local3)
				Store(Refof(g009), Local4)
			}
			case (33) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
				Store(Refof(g00a), Local4)
			}
			case (63) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f038, 63}
				Store(Refof(f038), Local3)
				Store(Refof(g00b), Local4)
			}
			case (64) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
				Store(Refof(g00c), Local4)
			}
			case (65) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
				Store(Refof(g00d), Local4)
			}
			case (69) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
				Store(Refof(g00e), Local4)
			}
			case (129) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
				Store(Refof(g000), Local4)
			}
			case (256) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
				Store(Refof(g001), Local4)
			}
			case (1023) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
				Store(Refof(g002), Local4)
			}
			case (1983) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
				Store(Refof(g003), Local4)
			}
			default {
				err(arg0, z145, 14, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
				Store(Refof(g004), Local4)
			}
			case (6) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f041, 6}
				Store(Refof(f041), Local3)
				Store(Refof(g005), Local4)
			}
			case (7) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, ByteAcc, NoLock, Preserve) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
				Store(Refof(g006), Local4)
			}
			case (8) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f043, 8}
				Store(Refof(f043), Local3)
				Store(Refof(g007), Local4)
			}
			case (9) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
				Store(Refof(g008), Local4)
			}
			case (31) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f045, 31}
				Store(Refof(f045), Local3)
				Store(Refof(g009), Local4)
			}
			case (32) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
				Store(Refof(g00a), Local4)
			}
			case (33) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f047, 33}
				Store(Refof(f047), Local3)
				Store(Refof(g00b), Local4)
			}
			case (63) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
				Store(Refof(g00c), Local4)
			}
			case (64) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f049, 64}
				Store(Refof(f049), Local3)
				Store(Refof(g00d), Local4)
			}
			case (65) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
				Store(Refof(g00e), Local4)
			}
			case (69) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
				Store(Refof(g000), Local4)
			}
			case (129) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
				Store(Refof(g001), Local4)
			}
			case (256) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
				Store(Refof(g002), Local4)
			}
			case (1023) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
				Store(Refof(g003), Local4)
			}
			case (1983) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
				Store(Refof(g004), Local4)
			}
			default {
				err(arg0, z145, 15, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f050, 1}
				Store(Refof(f050), Local3)
				Store(Refof(g005), Local4)
			}
			case (6) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, ByteAcc, NoLock, Preserve) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
				Store(Refof(g006), Local4)
			}
			case (7) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f052, 7}
				Store(Refof(f052), Local3)
				Store(Refof(g007), Local4)
			}
			case (8) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
				Store(Refof(g008), Local4)
			}
			case (9) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f054, 9}
				Store(Refof(f054), Local3)
				Store(Refof(g009), Local4)
			}
			case (31) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
				Store(Refof(g00a), Local4)
			}
			case (32) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f056, 32}
				Store(Refof(f056), Local3)
				Store(Refof(g00b), Local4)
			}
			case (33) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
				Store(Refof(g00c), Local4)
			}
			case (63) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f058, 63}
				Store(Refof(f058), Local3)
				Store(Refof(g00d), Local4)
			}
			case (64) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
				Store(Refof(g00e), Local4)
			}
			case (65) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
				Store(Refof(g000), Local4)
			}
			case (69) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
				Store(Refof(g001), Local4)
			}
			case (129) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
				Store(Refof(g002), Local4)
			}
			case (256) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
				Store(Refof(g003), Local4)
			}
			case (1023) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
				Store(Refof(g004), Local4)
			}
			case (1983) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
				Store(Refof(g005), Local4)
			}
			default {
				err(arg0, z145, 16, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, ByteAcc, NoLock, Preserve) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
				Store(Refof(g006), Local4)
			}
			case (6) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f061, 6}
				Store(Refof(f061), Local3)
				Store(Refof(g007), Local4)
			}
			case (7) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
				Store(Refof(g008), Local4)
			}
			case (8) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f063, 8}
				Store(Refof(f063), Local3)
				Store(Refof(g009), Local4)
			}
			case (9) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
				Store(Refof(g00a), Local4)
			}
			case (31) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f065, 31}
				Store(Refof(f065), Local3)
				Store(Refof(g00b), Local4)
			}
			case (32) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
				Store(Refof(g00c), Local4)
			}
			case (33) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f067, 33}
				Store(Refof(f067), Local3)
				Store(Refof(g00d), Local4)
			}
			case (63) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
				Store(Refof(g00e), Local4)
			}
			case (64) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f069, 64}
				Store(Refof(f069), Local3)
				Store(Refof(g000), Local4)
			}
			case (65) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
				Store(Refof(g001), Local4)
			}
			case (69) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
				Store(Refof(g002), Local4)
			}
			case (129) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
				Store(Refof(g003), Local4)
			}
			case (256) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
				Store(Refof(g004), Local4)
			}
			case (1023) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
				Store(Refof(g005), Local4)
			}
			case (1983) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
				Store(Refof(g006), Local4)
			}
			default {
				err(arg0, z145, 17, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f070, 1}
				Store(Refof(f070), Local3)
				Store(Refof(g007), Local4)
			}
			case (6) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
				Store(Refof(g008), Local4)
			}
			case (7) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f072, 7}
				Store(Refof(f072), Local3)
				Store(Refof(g009), Local4)
			}
			case (8) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
				Store(Refof(g00a), Local4)
			}
			case (9) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f074, 9}
				Store(Refof(f074), Local3)
				Store(Refof(g00b), Local4)
			}
			case (31) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
				Store(Refof(g00c), Local4)
			}
			case (32) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f076, 32}
				Store(Refof(f076), Local3)
				Store(Refof(g00d), Local4)
			}
			case (33) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
				Store(Refof(g00e), Local4)
			}
			case (63) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f078, 63}
				Store(Refof(f078), Local3)
				Store(Refof(g000), Local4)
			}
			case (64) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
				Store(Refof(g001), Local4)
			}
			case (65) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
				Store(Refof(g002), Local4)
			}
			case (69) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
				Store(Refof(g003), Local4)
			}
			case (129) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
				Store(Refof(g004), Local4)
			}
			case (256) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
				Store(Refof(g005), Local4)
			}
			case (1023) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
				Store(Refof(g006), Local4)
			}
			case (1983) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, ByteAcc, NoLock, Preserve) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
				Store(Refof(g007), Local4)
			}
			default {
				err(arg0, z145, 18, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
				Store(Refof(g008), Local4)
			}
			case (6) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
				Store(Refof(g009), Local4)
			}
			case (7) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
				Store(Refof(g00a), Local4)
			}
			case (8) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
				Store(Refof(g00b), Local4)
			}
			case (9) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
				Store(Refof(g00c), Local4)
			}
			case (31) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
				Store(Refof(g00d), Local4)
			}
			case (32) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
				Store(Refof(g00e), Local4)
			}
			case (33) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
				Store(Refof(g000), Local4)
			}
			case (63) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
				Store(Refof(g001), Local4)
			}
			case (64) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
				Store(Refof(g002), Local4)
			}
			case (65) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
				Store(Refof(g003), Local4)
			}
			case (69) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
				Store(Refof(g004), Local4)
			}
			case (129) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
				Store(Refof(g005), Local4)
			}
			case (256) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
				Store(Refof(g006), Local4)
			}
			case (1023) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, ByteAcc, NoLock, Preserve) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
				Store(Refof(g007), Local4)
			}
			case (1983) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
				Store(Refof(g008), Local4)
			}
			default {
				err(arg0, z145, 19, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f090, 1}
				Store(Refof(f090), Local3)
				Store(Refof(g009), Local4)
			}
			case (6) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
				Store(Refof(g00a), Local4)
			}
			case (7) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f092, 7}
				Store(Refof(f092), Local3)
				Store(Refof(g00b), Local4)
			}
			case (8) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
				Store(Refof(g00c), Local4)
			}
			case (9) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f094, 9}
				Store(Refof(f094), Local3)
				Store(Refof(g00d), Local4)
			}
			case (31) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
				Store(Refof(g00e), Local4)
			}
			case (32) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f096, 32}
				Store(Refof(f096), Local3)
				Store(Refof(g000), Local4)
			}
			case (33) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
				Store(Refof(g001), Local4)
			}
			case (63) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f098, 63}
				Store(Refof(f098), Local3)
				Store(Refof(g002), Local4)
			}
			case (64) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
				Store(Refof(g003), Local4)
			}
			case (65) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
				Store(Refof(g004), Local4)
			}
			case (69) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
				Store(Refof(g005), Local4)
			}
			case (129) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
				Store(Refof(g006), Local4)
			}
			case (256) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, ByteAcc, NoLock, Preserve) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
				Store(Refof(g007), Local4)
			}
			case (1023) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
				Store(Refof(g008), Local4)
			}
			case (1983) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
				Store(Refof(g009), Local4)
			}
			default {
				err(arg0, z145, 20, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
				Store(Refof(g00a), Local4)
			}
			case (6) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
				Store(Refof(g00b), Local4)
			}
			case (7) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
				Store(Refof(g00c), Local4)
			}
			case (8) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
				Store(Refof(g00d), Local4)
			}
			case (9) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
				Store(Refof(g00e), Local4)
			}
			case (31) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
				Store(Refof(g000), Local4)
			}
			case (32) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
				Store(Refof(g001), Local4)
			}
			case (33) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
				Store(Refof(g002), Local4)
			}
			case (63) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
				Store(Refof(g003), Local4)
			}
			case (64) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
				Store(Refof(g004), Local4)
			}
			case (65) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
				Store(Refof(g005), Local4)
			}
			case (69) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
				Store(Refof(g006), Local4)
			}
			case (129) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
				Store(Refof(g007), Local4)
			}
			case (256) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
				Store(Refof(g008), Local4)
			}
			case (1023) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
				Store(Refof(g009), Local4)
			}
			case (1983) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
				Store(Refof(g00a), Local4)
			}
			default {
				err(arg0, z145, 21, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
				Store(Refof(g00b), Local4)
			}
			case (6) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
				Store(Refof(g00c), Local4)
			}
			case (7) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
				Store(Refof(g00d), Local4)
			}
			case (8) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
				Store(Refof(g00e), Local4)
			}
			case (9) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
				Store(Refof(g000), Local4)
			}
			case (31) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
				Store(Refof(g001), Local4)
			}
			case (32) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
				Store(Refof(g002), Local4)
			}
			case (33) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
				Store(Refof(g003), Local4)
			}
			case (63) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
				Store(Refof(g004), Local4)
			}
			case (64) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
				Store(Refof(g005), Local4)
			}
			case (65) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
				Store(Refof(g006), Local4)
			}
			case (69) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, ByteAcc, NoLock, Preserve) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
				Store(Refof(g007), Local4)
			}
			case (129) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
				Store(Refof(g008), Local4)
			}
			case (256) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
				Store(Refof(g009), Local4)
			}
			case (1023) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1983) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, ByteAcc, NoLock, Preserve) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
				Store(Refof(g00b), Local4)
			}
			default {
				err(arg0, z145, 22, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
				Store(Refof(g00c), Local4)
			}
			case (6) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
				Store(Refof(g00d), Local4)
			}
			case (7) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
				Store(Refof(g00e), Local4)
			}
			case (8) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
				Store(Refof(g000), Local4)
			}
			case (9) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
				Store(Refof(g001), Local4)
			}
			case (31) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
				Store(Refof(g002), Local4)
			}
			case (32) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
				Store(Refof(g003), Local4)
			}
			case (33) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
				Store(Refof(g004), Local4)
			}
			case (63) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
				Store(Refof(g005), Local4)
			}
			case (64) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
				Store(Refof(g006), Local4)
			}
			case (65) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, ByteAcc, NoLock, Preserve) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
				Store(Refof(g007), Local4)
			}
			case (69) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
				Store(Refof(g008), Local4)
			}
			case (129) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
				Store(Refof(g009), Local4)
			}
			case (256) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1023) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, ByteAcc, NoLock, Preserve) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1983) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
				Store(Refof(g00c), Local4)
			}
			default {
				err(arg0, z145, 23, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
				Store(Refof(g00d), Local4)
			}
			case (6) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
				Store(Refof(g00e), Local4)
			}
			case (7) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
				Store(Refof(g000), Local4)
			}
			case (8) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
				Store(Refof(g001), Local4)
			}
			case (9) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
				Store(Refof(g002), Local4)
			}
			case (31) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
				Store(Refof(g003), Local4)
			}
			case (32) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
				Store(Refof(g004), Local4)
			}
			case (33) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
				Store(Refof(g005), Local4)
			}
			case (63) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
				Store(Refof(g006), Local4)
			}
			case (64) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, ByteAcc, NoLock, Preserve) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
				Store(Refof(g007), Local4)
			}
			case (65) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
				Store(Refof(g008), Local4)
			}
			case (69) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
				Store(Refof(g009), Local4)
			}
			case (129) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
				Store(Refof(g00a), Local4)
			}
			case (256) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, ByteAcc, NoLock, Preserve) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1023) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1983) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
				Store(Refof(g00d), Local4)
			}
			default {
				err(arg0, z145, 24, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
				Store(Refof(g00e), Local4)
			}
			case (6) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
				Store(Refof(g000), Local4)
			}
			case (7) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
				Store(Refof(g001), Local4)
			}
			case (8) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
				Store(Refof(g002), Local4)
			}
			case (9) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
				Store(Refof(g003), Local4)
			}
			case (31) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
				Store(Refof(g004), Local4)
			}
			case (32) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
				Store(Refof(g005), Local4)
			}
			case (33) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
				Store(Refof(g006), Local4)
			}
			case (63) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, ByteAcc, NoLock, Preserve) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
				Store(Refof(g007), Local4)
			}
			case (64) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
				Store(Refof(g008), Local4)
			}
			case (65) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
				Store(Refof(g009), Local4)
			}
			case (69) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
				Store(Refof(g00a), Local4)
			}
			case (129) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, ByteAcc, NoLock, Preserve) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
				Store(Refof(g00b), Local4)
			}
			case (256) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1023) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1983) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
				Store(Refof(g00e), Local4)
			}
			default {
				err(arg0, z145, 25, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					AccessAs(ByteAcc),
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, ByteAcc, NoLock, Preserve) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z145, 26, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z145, 27, 0, 0, arg2, arg3)
		return}
	}

	Store(2, Index(fcp0, 0))
	Store(Refof(BNK0), Index(fcp0, 1))
	Store(Local2, Index(fcp0, 2))
	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Local4)
	Store(0, Index(fcp0, 0))
}

// Create BankField Unit
// (WordAcc, NoLock, WriteAsOnes)
Method(m7d1, 6, Serialized)
{
	OperationRegion(OPRb, SystemIO, 0, 9)
	OperationRegion(OPR0, SystemIO, 11, 256)

	Field(OPRb, ByteAcc, NoLock, Preserve) {
		BNK0, 8,
	}
	BankField(OPR0, BNK0, 0, ByteAcc, NoLock, Preserve) {
		g000, 2048,
	}
	BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}
	BankField(OPR0, BNK0, 2, ByteAcc, NoLock, Preserve) {
		g002, 2048,
	}
	BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
		g003, 2048,
	}
	BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
		g004, 2048,
	}
	BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
		g005, 2048,
	}
	BankField(OPR0, BNK0, 6, ByteAcc, NoLock, Preserve) {
		g006, 2048,
	}
	BankField(OPR0, BNK0, 7, ByteAcc, NoLock, Preserve) {
		g007, 2048,
	}
	BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
		g008, 2048,
	}
	BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
		g009, 2048,
	}
	BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
		g00a, 2048,
	}
	BankField(OPR0, BNK0, 64, ByteAcc, NoLock, Preserve) {
		g00b, 2048,
	}
	BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
		g00c, 2048,
	}
	BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
		g00d, 2048,
	}
	BankField(OPR0, BNK0, 255, DwordAcc, NoLock, Preserve) {
		g00e, 2048,
	}


	Concatenate(arg0, "-m7d1", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsOnes) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 0, f001, 6}
				Store(Refof(f001), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, WordAcc, NoLock, WriteAsOnes) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 0, f003, 8}
				Store(Refof(f003), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, WordAcc, NoLock, WriteAsOnes) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 0, f005, 31}
				Store(Refof(f005), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsOnes) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 0, f007, 33}
				Store(Refof(f007), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, WordAcc, NoLock, WriteAsOnes) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 0, f009, 64}
				Store(Refof(f009), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsOnes) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, WordAcc, NoLock, WriteAsOnes) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, WordAcc, NoLock, WriteAsOnes) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z145, 28, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 1, f010, 1}
				Store(Refof(f010), Local3)
				Store(Refof(g001), Local4)
			}
			case (6) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, WordAcc, NoLock, WriteAsOnes) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
				Store(Refof(g002), Local4)
			}
			case (7) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 1, f012, 7}
				Store(Refof(f012), Local3)
				Store(Refof(g003), Local4)
			}
			case (8) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, WordAcc, NoLock, WriteAsOnes) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
				Store(Refof(g004), Local4)
			}
			case (9) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 1, f014, 9}
				Store(Refof(f014), Local3)
				Store(Refof(g005), Local4)
			}
			case (31) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsOnes) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
				Store(Refof(g006), Local4)
			}
			case (32) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 1, f016, 32}
				Store(Refof(f016), Local3)
				Store(Refof(g007), Local4)
			}
			case (33) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, WordAcc, NoLock, WriteAsOnes) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
				Store(Refof(g008), Local4)
			}
			case (63) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 1, f018, 63}
				Store(Refof(f018), Local3)
				Store(Refof(g009), Local4)
			}
			case (64) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsOnes) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
				Store(Refof(g00a), Local4)
			}
			case (65) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
				Store(Refof(g00b), Local4)
			}
			case (69) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, WordAcc, NoLock, WriteAsOnes) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
				Store(Refof(g00c), Local4)
			}
			case (129) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
				Store(Refof(g00d), Local4)
			}
			case (256) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, WordAcc, NoLock, WriteAsOnes) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1023) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
				Store(Refof(g000), Local4)
			}
			case (1983) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
				Store(Refof(g001), Local4)
			}
			default {
				err(arg0, z145, 29, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, WordAcc, NoLock, WriteAsOnes) {
					, 2, f020, 1}
				Store(Refof(f020), Local3)
				Store(Refof(g002), Local4)
			}
			case (6) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 2, f021, 6}
				Store(Refof(f021), Local3)
				Store(Refof(g003), Local4)
			}
			case (7) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, WordAcc, NoLock, WriteAsOnes) {
					, 2, f022, 7}
				Store(Refof(f022), Local3)
				Store(Refof(g004), Local4)
			}
			case (8) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 2, f023, 8}
				Store(Refof(f023), Local3)
				Store(Refof(g005), Local4)
			}
			case (9) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsOnes) {
					, 2, f024, 9}
				Store(Refof(f024), Local3)
				Store(Refof(g006), Local4)
			}
			case (31) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 2, f025, 31}
				Store(Refof(f025), Local3)
				Store(Refof(g007), Local4)
			}
			case (32) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, WordAcc, NoLock, WriteAsOnes) {
					, 2, f026, 32}
				Store(Refof(f026), Local3)
				Store(Refof(g008), Local4)
			}
			case (33) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 2, f027, 33}
				Store(Refof(f027), Local3)
				Store(Refof(g009), Local4)
			}
			case (63) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsOnes) {
					, 2, f028, 63}
				Store(Refof(f028), Local3)
				Store(Refof(g00a), Local4)
			}
			case (64) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 2, f029, 64}
				Store(Refof(f029), Local3)
				Store(Refof(g00b), Local4)
			}
			case (65) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, WordAcc, NoLock, WriteAsOnes) {
					, 2, f02a, 65}
				Store(Refof(f02a), Local3)
				Store(Refof(g00c), Local4)
			}
			case (69) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 2, f02b, 69}
				Store(Refof(f02b), Local3)
				Store(Refof(g00d), Local4)
			}
			case (129) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, WordAcc, NoLock, WriteAsOnes) {
					, 2, f02c, 129}
				Store(Refof(f02c), Local3)
				Store(Refof(g00e), Local4)
			}
			case (256) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 2, f02d, 256}
				Store(Refof(f02d), Local3)
				Store(Refof(g000), Local4)
			}
			case (1023) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					, 2, f02e, 1023}
				Store(Refof(f02e), Local3)
				Store(Refof(g001), Local4)
			}
			case (1983) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 2, f02f, 1983}
				Store(Refof(f02f), Local3)
				Store(Refof(g002), Local4)
			}
			default {
				err(arg0, z145, 30, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 3, f030, 1}
				Store(Refof(f030), Local3)
				Store(Refof(g003), Local4)
			}
			case (6) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, WordAcc, NoLock, WriteAsOnes) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
				Store(Refof(g004), Local4)
			}
			case (7) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 3, f032, 7}
				Store(Refof(f032), Local3)
				Store(Refof(g005), Local4)
			}
			case (8) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsOnes) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
				Store(Refof(g006), Local4)
			}
			case (9) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 3, f034, 9}
				Store(Refof(f034), Local3)
				Store(Refof(g007), Local4)
			}
			case (31) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, WordAcc, NoLock, WriteAsOnes) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
				Store(Refof(g008), Local4)
			}
			case (32) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 3, f036, 32}
				Store(Refof(f036), Local3)
				Store(Refof(g009), Local4)
			}
			case (33) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsOnes) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
				Store(Refof(g00a), Local4)
			}
			case (63) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 3, f038, 63}
				Store(Refof(f038), Local3)
				Store(Refof(g00b), Local4)
			}
			case (64) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, WordAcc, NoLock, WriteAsOnes) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
				Store(Refof(g00c), Local4)
			}
			case (65) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
				Store(Refof(g00d), Local4)
			}
			case (69) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, WordAcc, NoLock, WriteAsOnes) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
				Store(Refof(g00e), Local4)
			}
			case (129) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
				Store(Refof(g000), Local4)
			}
			case (256) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
				Store(Refof(g001), Local4)
			}
			case (1023) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
				Store(Refof(g002), Local4)
			}
			case (1983) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, WordAcc, NoLock, WriteAsOnes) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
				Store(Refof(g003), Local4)
			}
			default {
				err(arg0, z145, 31, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, WordAcc, NoLock, WriteAsOnes) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
				Store(Refof(g004), Local4)
			}
			case (6) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 4, f041, 6}
				Store(Refof(f041), Local3)
				Store(Refof(g005), Local4)
			}
			case (7) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsOnes) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
				Store(Refof(g006), Local4)
			}
			case (8) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 4, f043, 8}
				Store(Refof(f043), Local3)
				Store(Refof(g007), Local4)
			}
			case (9) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, WordAcc, NoLock, WriteAsOnes) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
				Store(Refof(g008), Local4)
			}
			case (31) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 4, f045, 31}
				Store(Refof(f045), Local3)
				Store(Refof(g009), Local4)
			}
			case (32) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsOnes) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
				Store(Refof(g00a), Local4)
			}
			case (33) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 4, f047, 33}
				Store(Refof(f047), Local3)
				Store(Refof(g00b), Local4)
			}
			case (63) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, WordAcc, NoLock, WriteAsOnes) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
				Store(Refof(g00c), Local4)
			}
			case (64) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 4, f049, 64}
				Store(Refof(f049), Local3)
				Store(Refof(g00d), Local4)
			}
			case (65) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, WordAcc, NoLock, WriteAsOnes) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
				Store(Refof(g00e), Local4)
			}
			case (69) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
				Store(Refof(g000), Local4)
			}
			case (129) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
				Store(Refof(g001), Local4)
			}
			case (256) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
				Store(Refof(g002), Local4)
			}
			case (1023) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, WordAcc, NoLock, WriteAsOnes) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
				Store(Refof(g003), Local4)
			}
			case (1983) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
				Store(Refof(g004), Local4)
			}
			default {
				err(arg0, z145, 32, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 5, f050, 1}
				Store(Refof(f050), Local3)
				Store(Refof(g005), Local4)
			}
			case (6) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsOnes) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
				Store(Refof(g006), Local4)
			}
			case (7) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 5, f052, 7}
				Store(Refof(f052), Local3)
				Store(Refof(g007), Local4)
			}
			case (8) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, WordAcc, NoLock, WriteAsOnes) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
				Store(Refof(g008), Local4)
			}
			case (9) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 5, f054, 9}
				Store(Refof(f054), Local3)
				Store(Refof(g009), Local4)
			}
			case (31) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsOnes) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
				Store(Refof(g00a), Local4)
			}
			case (32) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 5, f056, 32}
				Store(Refof(f056), Local3)
				Store(Refof(g00b), Local4)
			}
			case (33) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, WordAcc, NoLock, WriteAsOnes) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
				Store(Refof(g00c), Local4)
			}
			case (63) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 5, f058, 63}
				Store(Refof(f058), Local3)
				Store(Refof(g00d), Local4)
			}
			case (64) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, WordAcc, NoLock, WriteAsOnes) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
				Store(Refof(g00e), Local4)
			}
			case (65) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
				Store(Refof(g000), Local4)
			}
			case (69) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
				Store(Refof(g001), Local4)
			}
			case (129) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
				Store(Refof(g002), Local4)
			}
			case (256) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, WordAcc, NoLock, WriteAsOnes) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
				Store(Refof(g003), Local4)
			}
			case (1023) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
				Store(Refof(g004), Local4)
			}
			case (1983) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsOnes) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
				Store(Refof(g005), Local4)
			}
			default {
				err(arg0, z145, 33, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsOnes) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
				Store(Refof(g006), Local4)
			}
			case (6) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 6, f061, 6}
				Store(Refof(f061), Local3)
				Store(Refof(g007), Local4)
			}
			case (7) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, WordAcc, NoLock, WriteAsOnes) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
				Store(Refof(g008), Local4)
			}
			case (8) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 6, f063, 8}
				Store(Refof(f063), Local3)
				Store(Refof(g009), Local4)
			}
			case (9) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsOnes) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
				Store(Refof(g00a), Local4)
			}
			case (31) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 6, f065, 31}
				Store(Refof(f065), Local3)
				Store(Refof(g00b), Local4)
			}
			case (32) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, WordAcc, NoLock, WriteAsOnes) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
				Store(Refof(g00c), Local4)
			}
			case (33) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 6, f067, 33}
				Store(Refof(f067), Local3)
				Store(Refof(g00d), Local4)
			}
			case (63) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, WordAcc, NoLock, WriteAsOnes) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
				Store(Refof(g00e), Local4)
			}
			case (64) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 6, f069, 64}
				Store(Refof(f069), Local3)
				Store(Refof(g000), Local4)
			}
			case (65) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
				Store(Refof(g001), Local4)
			}
			case (69) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
				Store(Refof(g002), Local4)
			}
			case (129) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, WordAcc, NoLock, WriteAsOnes) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
				Store(Refof(g003), Local4)
			}
			case (256) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
				Store(Refof(g004), Local4)
			}
			case (1023) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsOnes) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
				Store(Refof(g005), Local4)
			}
			case (1983) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
				Store(Refof(g006), Local4)
			}
			default {
				err(arg0, z145, 34, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 7, f070, 1}
				Store(Refof(f070), Local3)
				Store(Refof(g007), Local4)
			}
			case (6) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, WordAcc, NoLock, WriteAsOnes) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
				Store(Refof(g008), Local4)
			}
			case (7) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 7, f072, 7}
				Store(Refof(f072), Local3)
				Store(Refof(g009), Local4)
			}
			case (8) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsOnes) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
				Store(Refof(g00a), Local4)
			}
			case (9) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 7, f074, 9}
				Store(Refof(f074), Local3)
				Store(Refof(g00b), Local4)
			}
			case (31) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, WordAcc, NoLock, WriteAsOnes) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
				Store(Refof(g00c), Local4)
			}
			case (32) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 7, f076, 32}
				Store(Refof(f076), Local3)
				Store(Refof(g00d), Local4)
			}
			case (33) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, WordAcc, NoLock, WriteAsOnes) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
				Store(Refof(g00e), Local4)
			}
			case (63) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 7, f078, 63}
				Store(Refof(f078), Local3)
				Store(Refof(g000), Local4)
			}
			case (64) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
				Store(Refof(g001), Local4)
			}
			case (65) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
				Store(Refof(g002), Local4)
			}
			case (69) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, WordAcc, NoLock, WriteAsOnes) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
				Store(Refof(g003), Local4)
			}
			case (129) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
				Store(Refof(g004), Local4)
			}
			case (256) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsOnes) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
				Store(Refof(g005), Local4)
			}
			case (1023) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
				Store(Refof(g006), Local4)
			}
			case (1983) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, WordAcc, NoLock, WriteAsOnes) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
				Store(Refof(g007), Local4)
			}
			default {
				err(arg0, z145, 35, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
				Store(Refof(g008), Local4)
			}
			case (6) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
				Store(Refof(g009), Local4)
			}
			case (7) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
				Store(Refof(g00a), Local4)
			}
			case (8) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
				Store(Refof(g00b), Local4)
			}
			case (9) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
				Store(Refof(g00c), Local4)
			}
			case (31) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
				Store(Refof(g00d), Local4)
			}
			case (32) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
				Store(Refof(g00e), Local4)
			}
			case (33) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
				Store(Refof(g000), Local4)
			}
			case (63) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
				Store(Refof(g001), Local4)
			}
			case (64) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
				Store(Refof(g002), Local4)
			}
			case (65) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
				Store(Refof(g003), Local4)
			}
			case (69) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
				Store(Refof(g004), Local4)
			}
			case (129) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
				Store(Refof(g005), Local4)
			}
			case (256) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
				Store(Refof(g006), Local4)
			}
			case (1023) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, WordAcc, NoLock, WriteAsOnes) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
				Store(Refof(g007), Local4)
			}
			case (1983) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
				Store(Refof(g008), Local4)
			}
			default {
				err(arg0, z145, 36, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 9, f090, 1}
				Store(Refof(f090), Local3)
				Store(Refof(g009), Local4)
			}
			case (6) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsOnes) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
				Store(Refof(g00a), Local4)
			}
			case (7) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 9, f092, 7}
				Store(Refof(f092), Local3)
				Store(Refof(g00b), Local4)
			}
			case (8) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, WordAcc, NoLock, WriteAsOnes) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
				Store(Refof(g00c), Local4)
			}
			case (9) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 9, f094, 9}
				Store(Refof(f094), Local3)
				Store(Refof(g00d), Local4)
			}
			case (31) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, WordAcc, NoLock, WriteAsOnes) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
				Store(Refof(g00e), Local4)
			}
			case (32) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 9, f096, 32}
				Store(Refof(f096), Local3)
				Store(Refof(g000), Local4)
			}
			case (33) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
				Store(Refof(g001), Local4)
			}
			case (63) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 9, f098, 63}
				Store(Refof(f098), Local3)
				Store(Refof(g002), Local4)
			}
			case (64) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, WordAcc, NoLock, WriteAsOnes) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
				Store(Refof(g003), Local4)
			}
			case (65) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
				Store(Refof(g004), Local4)
			}
			case (69) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsOnes) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
				Store(Refof(g005), Local4)
			}
			case (129) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
				Store(Refof(g006), Local4)
			}
			case (256) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, WordAcc, NoLock, WriteAsOnes) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
				Store(Refof(g007), Local4)
			}
			case (1023) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
				Store(Refof(g008), Local4)
			}
			case (1983) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, WordAcc, NoLock, WriteAsOnes) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
				Store(Refof(g009), Local4)
			}
			default {
				err(arg0, z145, 37, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
				Store(Refof(g00a), Local4)
			}
			case (6) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
				Store(Refof(g00b), Local4)
			}
			case (7) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
				Store(Refof(g00c), Local4)
			}
			case (8) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
				Store(Refof(g00d), Local4)
			}
			case (9) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
				Store(Refof(g00e), Local4)
			}
			case (31) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
				Store(Refof(g000), Local4)
			}
			case (32) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
				Store(Refof(g001), Local4)
			}
			case (33) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
				Store(Refof(g002), Local4)
			}
			case (63) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
				Store(Refof(g003), Local4)
			}
			case (64) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
				Store(Refof(g004), Local4)
			}
			case (65) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
				Store(Refof(g005), Local4)
			}
			case (69) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
				Store(Refof(g006), Local4)
			}
			case (129) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
				Store(Refof(g007), Local4)
			}
			case (256) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
				Store(Refof(g008), Local4)
			}
			case (1023) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, WordAcc, NoLock, WriteAsOnes) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
				Store(Refof(g009), Local4)
			}
			case (1983) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
				Store(Refof(g00a), Local4)
			}
			default {
				err(arg0, z145, 38, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
				Store(Refof(g00b), Local4)
			}
			case (6) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
				Store(Refof(g00c), Local4)
			}
			case (7) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
				Store(Refof(g00d), Local4)
			}
			case (8) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
				Store(Refof(g00e), Local4)
			}
			case (9) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
				Store(Refof(g000), Local4)
			}
			case (31) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
				Store(Refof(g001), Local4)
			}
			case (32) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
				Store(Refof(g002), Local4)
			}
			case (33) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
				Store(Refof(g003), Local4)
			}
			case (63) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
				Store(Refof(g004), Local4)
			}
			case (64) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
				Store(Refof(g005), Local4)
			}
			case (65) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
				Store(Refof(g006), Local4)
			}
			case (69) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
				Store(Refof(g007), Local4)
			}
			case (129) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
				Store(Refof(g008), Local4)
			}
			case (256) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
				Store(Refof(g009), Local4)
			}
			case (1023) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1983) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsOnes) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
				Store(Refof(g00b), Local4)
			}
			default {
				err(arg0, z145, 39, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
				Store(Refof(g00c), Local4)
			}
			case (6) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
				Store(Refof(g00d), Local4)
			}
			case (7) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
				Store(Refof(g00e), Local4)
			}
			case (8) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
				Store(Refof(g000), Local4)
			}
			case (9) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
				Store(Refof(g001), Local4)
			}
			case (31) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
				Store(Refof(g002), Local4)
			}
			case (32) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
				Store(Refof(g003), Local4)
			}
			case (33) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
				Store(Refof(g004), Local4)
			}
			case (63) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
				Store(Refof(g005), Local4)
			}
			case (64) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
				Store(Refof(g006), Local4)
			}
			case (65) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
				Store(Refof(g007), Local4)
			}
			case (69) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
				Store(Refof(g008), Local4)
			}
			case (129) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
				Store(Refof(g009), Local4)
			}
			case (256) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1023) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsOnes) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1983) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
				Store(Refof(g00c), Local4)
			}
			default {
				err(arg0, z145, 40, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
				Store(Refof(g00d), Local4)
			}
			case (6) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, WriteAsOnes) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
				Store(Refof(g00e), Local4)
			}
			case (7) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
				Store(Refof(g000), Local4)
			}
			case (8) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
				Store(Refof(g001), Local4)
			}
			case (9) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
				Store(Refof(g002), Local4)
			}
			case (31) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
				Store(Refof(g003), Local4)
			}
			case (32) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
				Store(Refof(g004), Local4)
			}
			case (33) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
				Store(Refof(g005), Local4)
			}
			case (63) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
				Store(Refof(g006), Local4)
			}
			case (64) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
				Store(Refof(g007), Local4)
			}
			case (65) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
				Store(Refof(g008), Local4)
			}
			case (69) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
				Store(Refof(g009), Local4)
			}
			case (129) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
				Store(Refof(g00a), Local4)
			}
			case (256) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1023) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1983) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, WordAcc, NoLock, WriteAsOnes) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
				Store(Refof(g00d), Local4)
			}
			default {
				err(arg0, z145, 41, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
				Store(Refof(g00e), Local4)
			}
			case (6) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
				Store(Refof(g000), Local4)
			}
			case (7) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
				Store(Refof(g001), Local4)
			}
			case (8) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
				Store(Refof(g002), Local4)
			}
			case (9) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
				Store(Refof(g003), Local4)
			}
			case (31) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
				Store(Refof(g004), Local4)
			}
			case (32) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
				Store(Refof(g005), Local4)
			}
			case (33) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
				Store(Refof(g006), Local4)
			}
			case (63) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
				Store(Refof(g007), Local4)
			}
			case (64) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
				Store(Refof(g008), Local4)
			}
			case (65) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
				Store(Refof(g009), Local4)
			}
			case (69) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
				Store(Refof(g00a), Local4)
			}
			case (129) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
				Store(Refof(g00b), Local4)
			}
			case (256) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1023) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, WordAcc, NoLock, WriteAsOnes) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1983) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
				Store(Refof(g00e), Local4)
			}
			default {
				err(arg0, z145, 42, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, WriteAsOnes) {
					AccessAs(WordAcc),
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsOnes) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z145, 43, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z145, 44, 0, 0, arg2, arg3)
		return}
	}

	Store(2, Index(fcp0, 0))
	Store(Refof(BNK0), Index(fcp0, 1))
	Store(Local2, Index(fcp0, 2))
	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Local4)
	Store(0, Index(fcp0, 0))
}

// Create BankField Unit
// (DWordAcc, NoLock, WriteAsZeros)
Method(m7d2, 6, Serialized)
{
	OperationRegion(OPRb, SystemIO, 0, 9)
	OperationRegion(OPR0, SystemIO, 11, 256)

	Field(OPRb, ByteAcc, NoLock, Preserve) {
		BNK0, 8,
	}
	BankField(OPR0, BNK0, 0, ByteAcc, NoLock, Preserve) {
		g000, 2048,
	}
	BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}
	BankField(OPR0, BNK0, 2, ByteAcc, NoLock, Preserve) {
		g002, 2048,
	}
	BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
		g003, 2048,
	}
	BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
		g004, 2048,
	}
	BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
		g005, 2048,
	}
	BankField(OPR0, BNK0, 6, ByteAcc, NoLock, Preserve) {
		g006, 2048,
	}
	BankField(OPR0, BNK0, 7, ByteAcc, NoLock, Preserve) {
		g007, 2048,
	}
	BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
		g008, 2048,
	}
	BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
		g009, 2048,
	}
	BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
		g00a, 2048,
	}
	BankField(OPR0, BNK0, 64, ByteAcc, NoLock, Preserve) {
		g00b, 2048,
	}
	BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
		g00c, 2048,
	}
	BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
		g00d, 2048,
	}
	BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
		g00e, 2048,
	}


	Concatenate(arg0, "-m7d2", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 0, f001, 6}
				Store(Refof(f001), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 0, f003, 8}
				Store(Refof(f003), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 0, f005, 31}
				Store(Refof(f005), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 0, f007, 33}
				Store(Refof(f007), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 0, f009, 64}
				Store(Refof(f009), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, DWordAcc, NoLock, WriteAsZeros) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z145, 45, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 1, f010, 1}
				Store(Refof(f010), Local3)
				Store(Refof(g001), Local4)
			}
			case (6) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
				Store(Refof(g002), Local4)
			}
			case (7) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 1, f012, 7}
				Store(Refof(f012), Local3)
				Store(Refof(g003), Local4)
			}
			case (8) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
				Store(Refof(g004), Local4)
			}
			case (9) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 1, f014, 9}
				Store(Refof(f014), Local3)
				Store(Refof(g005), Local4)
			}
			case (31) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
				Store(Refof(g006), Local4)
			}
			case (32) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 1, f016, 32}
				Store(Refof(f016), Local3)
				Store(Refof(g007), Local4)
			}
			case (33) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
				Store(Refof(g008), Local4)
			}
			case (63) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 1, f018, 63}
				Store(Refof(f018), Local3)
				Store(Refof(g009), Local4)
			}
			case (64) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
				Store(Refof(g00a), Local4)
			}
			case (65) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
				Store(Refof(g00b), Local4)
			}
			case (69) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
				Store(Refof(g00c), Local4)
			}
			case (129) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
				Store(Refof(g00d), Local4)
			}
			case (256) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1023) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
				Store(Refof(g000), Local4)
			}
			case (1983) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, DWordAcc, NoLock, WriteAsZeros) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
				Store(Refof(g001), Local4)
			}
			default {
				err(arg0, z145, 46, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f020, 1}
				Store(Refof(f020), Local3)
				Store(Refof(g002), Local4)
			}
			case (6) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 2, f021, 6}
				Store(Refof(f021), Local3)
				Store(Refof(g003), Local4)
			}
			case (7) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f022, 7}
				Store(Refof(f022), Local3)
				Store(Refof(g004), Local4)
			}
			case (8) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 2, f023, 8}
				Store(Refof(f023), Local3)
				Store(Refof(g005), Local4)
			}
			case (9) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f024, 9}
				Store(Refof(f024), Local3)
				Store(Refof(g006), Local4)
			}
			case (31) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 2, f025, 31}
				Store(Refof(f025), Local3)
				Store(Refof(g007), Local4)
			}
			case (32) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f026, 32}
				Store(Refof(f026), Local3)
				Store(Refof(g008), Local4)
			}
			case (33) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 2, f027, 33}
				Store(Refof(f027), Local3)
				Store(Refof(g009), Local4)
			}
			case (63) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f028, 63}
				Store(Refof(f028), Local3)
				Store(Refof(g00a), Local4)
			}
			case (64) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 2, f029, 64}
				Store(Refof(f029), Local3)
				Store(Refof(g00b), Local4)
			}
			case (65) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f02a, 65}
				Store(Refof(f02a), Local3)
				Store(Refof(g00c), Local4)
			}
			case (69) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 2, f02b, 69}
				Store(Refof(f02b), Local3)
				Store(Refof(g00d), Local4)
			}
			case (129) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f02c, 129}
				Store(Refof(f02c), Local3)
				Store(Refof(g00e), Local4)
			}
			case (256) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 2, f02d, 256}
				Store(Refof(f02d), Local3)
				Store(Refof(g000), Local4)
			}
			case (1023) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, DWordAcc, NoLock, WriteAsZeros) {
					, 2, f02e, 1023}
				Store(Refof(f02e), Local3)
				Store(Refof(g001), Local4)
			}
			case (1983) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 2, f02f, 1983}
				Store(Refof(f02f), Local3)
				Store(Refof(g002), Local4)
			}
			default {
				err(arg0, z145, 47, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 3, f030, 1}
				Store(Refof(f030), Local3)
				Store(Refof(g003), Local4)
			}
			case (6) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
				Store(Refof(g004), Local4)
			}
			case (7) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 3, f032, 7}
				Store(Refof(f032), Local3)
				Store(Refof(g005), Local4)
			}
			case (8) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
				Store(Refof(g006), Local4)
			}
			case (9) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 3, f034, 9}
				Store(Refof(f034), Local3)
				Store(Refof(g007), Local4)
			}
			case (31) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
				Store(Refof(g008), Local4)
			}
			case (32) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 3, f036, 32}
				Store(Refof(f036), Local3)
				Store(Refof(g009), Local4)
			}
			case (33) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
				Store(Refof(g00a), Local4)
			}
			case (63) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 3, f038, 63}
				Store(Refof(f038), Local3)
				Store(Refof(g00b), Local4)
			}
			case (64) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
				Store(Refof(g00c), Local4)
			}
			case (65) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
				Store(Refof(g00d), Local4)
			}
			case (69) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
				Store(Refof(g00e), Local4)
			}
			case (129) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
				Store(Refof(g000), Local4)
			}
			case (256) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
				Store(Refof(g001), Local4)
			}
			case (1023) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
				Store(Refof(g002), Local4)
			}
			case (1983) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsZeros) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
				Store(Refof(g003), Local4)
			}
			default {
				err(arg0, z145, 48, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
				Store(Refof(g004), Local4)
			}
			case (6) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 4, f041, 6}
				Store(Refof(f041), Local3)
				Store(Refof(g005), Local4)
			}
			case (7) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
				Store(Refof(g006), Local4)
			}
			case (8) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 4, f043, 8}
				Store(Refof(f043), Local3)
				Store(Refof(g007), Local4)
			}
			case (9) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
				Store(Refof(g008), Local4)
			}
			case (31) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 4, f045, 31}
				Store(Refof(f045), Local3)
				Store(Refof(g009), Local4)
			}
			case (32) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
				Store(Refof(g00a), Local4)
			}
			case (33) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 4, f047, 33}
				Store(Refof(f047), Local3)
				Store(Refof(g00b), Local4)
			}
			case (63) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
				Store(Refof(g00c), Local4)
			}
			case (64) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 4, f049, 64}
				Store(Refof(f049), Local3)
				Store(Refof(g00d), Local4)
			}
			case (65) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
				Store(Refof(g00e), Local4)
			}
			case (69) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
				Store(Refof(g000), Local4)
			}
			case (129) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
				Store(Refof(g001), Local4)
			}
			case (256) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
				Store(Refof(g002), Local4)
			}
			case (1023) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsZeros) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
				Store(Refof(g003), Local4)
			}
			case (1983) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
				Store(Refof(g004), Local4)
			}
			default {
				err(arg0, z145, 49, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 5, f050, 1}
				Store(Refof(f050), Local3)
				Store(Refof(g005), Local4)
			}
			case (6) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
				Store(Refof(g006), Local4)
			}
			case (7) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 5, f052, 7}
				Store(Refof(f052), Local3)
				Store(Refof(g007), Local4)
			}
			case (8) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
				Store(Refof(g008), Local4)
			}
			case (9) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 5, f054, 9}
				Store(Refof(f054), Local3)
				Store(Refof(g009), Local4)
			}
			case (31) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
				Store(Refof(g00a), Local4)
			}
			case (32) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 5, f056, 32}
				Store(Refof(f056), Local3)
				Store(Refof(g00b), Local4)
			}
			case (33) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
				Store(Refof(g00c), Local4)
			}
			case (63) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 5, f058, 63}
				Store(Refof(f058), Local3)
				Store(Refof(g00d), Local4)
			}
			case (64) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
				Store(Refof(g00e), Local4)
			}
			case (65) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
				Store(Refof(g000), Local4)
			}
			case (69) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
				Store(Refof(g001), Local4)
			}
			case (129) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
				Store(Refof(g002), Local4)
			}
			case (256) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
				Store(Refof(g003), Local4)
			}
			case (1023) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
				Store(Refof(g004), Local4)
			}
			case (1983) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, DWordAcc, NoLock, WriteAsZeros) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
				Store(Refof(g005), Local4)
			}
			default {
				err(arg0, z145, 50, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
				Store(Refof(g006), Local4)
			}
			case (6) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 6, f061, 6}
				Store(Refof(f061), Local3)
				Store(Refof(g007), Local4)
			}
			case (7) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
				Store(Refof(g008), Local4)
			}
			case (8) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 6, f063, 8}
				Store(Refof(f063), Local3)
				Store(Refof(g009), Local4)
			}
			case (9) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
				Store(Refof(g00a), Local4)
			}
			case (31) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 6, f065, 31}
				Store(Refof(f065), Local3)
				Store(Refof(g00b), Local4)
			}
			case (32) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
				Store(Refof(g00c), Local4)
			}
			case (33) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 6, f067, 33}
				Store(Refof(f067), Local3)
				Store(Refof(g00d), Local4)
			}
			case (63) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
				Store(Refof(g00e), Local4)
			}
			case (64) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 6, f069, 64}
				Store(Refof(f069), Local3)
				Store(Refof(g000), Local4)
			}
			case (65) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
				Store(Refof(g001), Local4)
			}
			case (69) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
				Store(Refof(g002), Local4)
			}
			case (129) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
				Store(Refof(g003), Local4)
			}
			case (256) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
				Store(Refof(g004), Local4)
			}
			case (1023) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, DWordAcc, NoLock, WriteAsZeros) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
				Store(Refof(g005), Local4)
			}
			case (1983) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
				Store(Refof(g006), Local4)
			}
			default {
				err(arg0, z145, 51, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 7, f070, 1}
				Store(Refof(f070), Local3)
				Store(Refof(g007), Local4)
			}
			case (6) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
				Store(Refof(g008), Local4)
			}
			case (7) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 7, f072, 7}
				Store(Refof(f072), Local3)
				Store(Refof(g009), Local4)
			}
			case (8) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
				Store(Refof(g00a), Local4)
			}
			case (9) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 7, f074, 9}
				Store(Refof(f074), Local3)
				Store(Refof(g00b), Local4)
			}
			case (31) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
				Store(Refof(g00c), Local4)
			}
			case (32) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 7, f076, 32}
				Store(Refof(f076), Local3)
				Store(Refof(g00d), Local4)
			}
			case (33) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
				Store(Refof(g00e), Local4)
			}
			case (63) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 7, f078, 63}
				Store(Refof(f078), Local3)
				Store(Refof(g000), Local4)
			}
			case (64) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
				Store(Refof(g001), Local4)
			}
			case (65) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
				Store(Refof(g002), Local4)
			}
			case (69) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
				Store(Refof(g003), Local4)
			}
			case (129) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
				Store(Refof(g004), Local4)
			}
			case (256) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
				Store(Refof(g005), Local4)
			}
			case (1023) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
				Store(Refof(g006), Local4)
			}
			case (1983) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsZeros) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
				Store(Refof(g007), Local4)
			}
			default {
				err(arg0, z145, 52, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
				Store(Refof(g008), Local4)
			}
			case (6) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
				Store(Refof(g009), Local4)
			}
			case (7) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
				Store(Refof(g00a), Local4)
			}
			case (8) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
				Store(Refof(g00b), Local4)
			}
			case (9) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
				Store(Refof(g00c), Local4)
			}
			case (31) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
				Store(Refof(g00d), Local4)
			}
			case (32) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
				Store(Refof(g00e), Local4)
			}
			case (33) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
				Store(Refof(g000), Local4)
			}
			case (63) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
				Store(Refof(g001), Local4)
			}
			case (64) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
				Store(Refof(g002), Local4)
			}
			case (65) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
				Store(Refof(g003), Local4)
			}
			case (69) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
				Store(Refof(g004), Local4)
			}
			case (129) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
				Store(Refof(g005), Local4)
			}
			case (256) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
				Store(Refof(g006), Local4)
			}
			case (1023) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsZeros) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
				Store(Refof(g007), Local4)
			}
			case (1983) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
				Store(Refof(g008), Local4)
			}
			default {
				err(arg0, z145, 53, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 9, f090, 1}
				Store(Refof(f090), Local3)
				Store(Refof(g009), Local4)
			}
			case (6) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
				Store(Refof(g00a), Local4)
			}
			case (7) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 9, f092, 7}
				Store(Refof(f092), Local3)
				Store(Refof(g00b), Local4)
			}
			case (8) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
				Store(Refof(g00c), Local4)
			}
			case (9) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 9, f094, 9}
				Store(Refof(f094), Local3)
				Store(Refof(g00d), Local4)
			}
			case (31) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
				Store(Refof(g00e), Local4)
			}
			case (32) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 9, f096, 32}
				Store(Refof(f096), Local3)
				Store(Refof(g000), Local4)
			}
			case (33) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
				Store(Refof(g001), Local4)
			}
			case (63) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 9, f098, 63}
				Store(Refof(f098), Local3)
				Store(Refof(g002), Local4)
			}
			case (64) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
				Store(Refof(g003), Local4)
			}
			case (65) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
				Store(Refof(g004), Local4)
			}
			case (69) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
				Store(Refof(g005), Local4)
			}
			case (129) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
				Store(Refof(g006), Local4)
			}
			case (256) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
				Store(Refof(g007), Local4)
			}
			case (1023) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
				Store(Refof(g008), Local4)
			}
			case (1983) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, DWordAcc, NoLock, WriteAsZeros) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
				Store(Refof(g009), Local4)
			}
			default {
				err(arg0, z145, 54, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
				Store(Refof(g00a), Local4)
			}
			case (6) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
				Store(Refof(g00b), Local4)
			}
			case (7) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
				Store(Refof(g00c), Local4)
			}
			case (8) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
				Store(Refof(g00d), Local4)
			}
			case (9) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
				Store(Refof(g00e), Local4)
			}
			case (31) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
				Store(Refof(g000), Local4)
			}
			case (32) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
				Store(Refof(g001), Local4)
			}
			case (33) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
				Store(Refof(g002), Local4)
			}
			case (63) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
				Store(Refof(g003), Local4)
			}
			case (64) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
				Store(Refof(g004), Local4)
			}
			case (65) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
				Store(Refof(g005), Local4)
			}
			case (69) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
				Store(Refof(g006), Local4)
			}
			case (129) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
				Store(Refof(g007), Local4)
			}
			case (256) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
				Store(Refof(g008), Local4)
			}
			case (1023) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, DWordAcc, NoLock, WriteAsZeros) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
				Store(Refof(g009), Local4)
			}
			case (1983) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
				Store(Refof(g00a), Local4)
			}
			default {
				err(arg0, z145, 55, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
				Store(Refof(g00b), Local4)
			}
			case (6) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
				Store(Refof(g00c), Local4)
			}
			case (7) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
				Store(Refof(g00d), Local4)
			}
			case (8) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
				Store(Refof(g00e), Local4)
			}
			case (9) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
				Store(Refof(g000), Local4)
			}
			case (31) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
				Store(Refof(g001), Local4)
			}
			case (32) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
				Store(Refof(g002), Local4)
			}
			case (33) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
				Store(Refof(g003), Local4)
			}
			case (63) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
				Store(Refof(g004), Local4)
			}
			case (64) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
				Store(Refof(g005), Local4)
			}
			case (65) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
				Store(Refof(g006), Local4)
			}
			case (69) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
				Store(Refof(g007), Local4)
			}
			case (129) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
				Store(Refof(g008), Local4)
			}
			case (256) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
				Store(Refof(g009), Local4)
			}
			case (1023) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1983) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, DWordAcc, NoLock, WriteAsZeros) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
				Store(Refof(g00b), Local4)
			}
			default {
				err(arg0, z145, 56, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
				Store(Refof(g00c), Local4)
			}
			case (6) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
				Store(Refof(g00d), Local4)
			}
			case (7) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
				Store(Refof(g00e), Local4)
			}
			case (8) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
				Store(Refof(g000), Local4)
			}
			case (9) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
				Store(Refof(g001), Local4)
			}
			case (31) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
				Store(Refof(g002), Local4)
			}
			case (32) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
				Store(Refof(g003), Local4)
			}
			case (33) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
				Store(Refof(g004), Local4)
			}
			case (63) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
				Store(Refof(g005), Local4)
			}
			case (64) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
				Store(Refof(g006), Local4)
			}
			case (65) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
				Store(Refof(g007), Local4)
			}
			case (69) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
				Store(Refof(g008), Local4)
			}
			case (129) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
				Store(Refof(g009), Local4)
			}
			case (256) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1023) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, DWordAcc, NoLock, WriteAsZeros) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1983) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
				Store(Refof(g00c), Local4)
			}
			default {
				err(arg0, z145, 32, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
				Store(Refof(g00d), Local4)
			}
			case (6) {

			    // November 2011: Changed to DWordAcc from ByteAcc to enable
			    // correct operation ("Expected" buffer assumes DWordAcc)

				Store(255, Local2)
				BankField(OPR0, BNK0, 255, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
				Store(Refof(g00e), Local4)
			}
			case (7) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
				Store(Refof(g000), Local4)
			}
			case (8) {

			    // November 2011: Changed to DWordAcc from WordAcc to enable
			    // correct operation ("Expected" buffer assumes DWordAcc)

				Store(1, Local2)
				BankField(OPR0, BNK0, 1, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
				Store(Refof(g001), Local4)
			}
			case (9) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
				Store(Refof(g002), Local4)
			}
			case (31) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
				Store(Refof(g003), Local4)
			}
			case (32) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
				Store(Refof(g004), Local4)
			}
			case (33) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
				Store(Refof(g005), Local4)
			}
			case (63) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
				Store(Refof(g006), Local4)
			}
			case (64) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
				Store(Refof(g007), Local4)
			}
			case (65) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
				Store(Refof(g008), Local4)
			}
			case (69) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
				Store(Refof(g009), Local4)
			}
			case (129) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
				Store(Refof(g00a), Local4)
			}
			case (256) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1023) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1983) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsZeros) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
				Store(Refof(g00d), Local4)
			}
			default {
				err(arg0, z145, 57, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
				Store(Refof(g00e), Local4)
			}
			case (6) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
				Store(Refof(g000), Local4)
			}
			case (7) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
				Store(Refof(g001), Local4)
			}
			case (8) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
				Store(Refof(g002), Local4)
			}
			case (9) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
				Store(Refof(g003), Local4)
			}
			case (31) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
				Store(Refof(g004), Local4)
			}
			case (32) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
				Store(Refof(g005), Local4)
			}
			case (33) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
				Store(Refof(g006), Local4)
			}
			case (63) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
				Store(Refof(g007), Local4)
			}
			case (64) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
				Store(Refof(g008), Local4)
			}
			case (65) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
				Store(Refof(g009), Local4)
			}
			case (69) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
				Store(Refof(g00a), Local4)
			}
			case (129) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
				Store(Refof(g00b), Local4)
			}
			case (256) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1023) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsZeros) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1983) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
				Store(Refof(g00e), Local4)
			}
			default {
				err(arg0, z145, 58, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, WriteAsZeros) {
					AccessAs(DWordAcc),
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, DWordAcc, NoLock, WriteAsZeros) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z145, 59, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z145, 60, 0, 0, arg2, arg3)
		return}
	}

	Store(2, Index(fcp0, 0))
	Store(Refof(BNK0), Index(fcp0, 1))
	Store(Local2, Index(fcp0, 2))
	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Local4)
	Store(0, Index(fcp0, 0))
}

// Create BankField Unit
// (QWordAcc, NoLock, Preserve)
Method(m7d3, 6, Serialized)
{
	OperationRegion(OPRb, SystemIO, 0, 9)
	OperationRegion(OPR0, SystemIO, 11, 256)

	Field(OPRb, ByteAcc, NoLock, Preserve) {
		BNK0, 8,
	}
	BankField(OPR0, BNK0, 0, ByteAcc, NoLock, Preserve) {
		g000, 2048,
	}
	BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}
	BankField(OPR0, BNK0, 2, ByteAcc, NoLock, Preserve) {
		g002, 2048,
	}
	BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
		g003, 2048,
	}
	BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
		g004, 2048,
	}
	BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
		g005, 2048,
	}
	BankField(OPR0, BNK0, 6, ByteAcc, NoLock, Preserve) {
		g006, 2048,
	}
	BankField(OPR0, BNK0, 7, ByteAcc, NoLock, Preserve) {
		g007, 2048,
	}
	BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
		g008, 2048,
	}
	BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
		g009, 2048,
	}
	BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
		g00a, 2048,
	}
	BankField(OPR0, BNK0, 64, ByteAcc, NoLock, Preserve) {
		g00b, 2048,
	}
	BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
		g00c, 2048,
	}
	BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
		g00d, 2048,
	}
	BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
		g00e, 2048,
	}


	Concatenate(arg0, "-m7d3", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 0, f001, 6}
				Store(Refof(f001), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, QWordAcc, NoLock, Preserve) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 0, f003, 8}
				Store(Refof(f003), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 0, f005, 31}
				Store(Refof(f005), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, QWordAcc, NoLock, Preserve) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 0, f007, 33}
				Store(Refof(f007), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, QWordAcc, NoLock, Preserve) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 0, f009, 64}
				Store(Refof(f009), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, QWordAcc, NoLock, Preserve) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z145, 61, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 1, f010, 1}
				Store(Refof(f010), Local3)
				Store(Refof(g001), Local4)
			}
			case (6) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, QWordAcc, NoLock, Preserve) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
				Store(Refof(g002), Local4)
			}
			case (7) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 1, f012, 7}
				Store(Refof(f012), Local3)
				Store(Refof(g003), Local4)
			}
			case (8) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
				Store(Refof(g004), Local4)
			}
			case (9) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 1, f014, 9}
				Store(Refof(f014), Local3)
				Store(Refof(g005), Local4)
			}
			case (31) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, QWordAcc, NoLock, Preserve) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
				Store(Refof(g006), Local4)
			}
			case (32) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 1, f016, 32}
				Store(Refof(f016), Local3)
				Store(Refof(g007), Local4)
			}
			case (33) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, QWordAcc, NoLock, Preserve) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
				Store(Refof(g008), Local4)
			}
			case (63) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 1, f018, 63}
				Store(Refof(f018), Local3)
				Store(Refof(g009), Local4)
			}
			case (64) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
				Store(Refof(g00a), Local4)
			}
			case (65) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
				Store(Refof(g00b), Local4)
			}
			case (69) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, QWordAcc, NoLock, Preserve) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
				Store(Refof(g00c), Local4)
			}
			case (129) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
				Store(Refof(g00d), Local4)
			}
			case (256) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1023) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
				Store(Refof(g000), Local4)
			}
			case (1983) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, QWordAcc, NoLock, Preserve) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
				Store(Refof(g001), Local4)
			}
			default {
				err(arg0, z145, 62, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, QWordAcc, NoLock, Preserve) {
					, 2, f020, 1}
				Store(Refof(f020), Local3)
				Store(Refof(g002), Local4)
			}
			case (6) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 2, f021, 6}
				Store(Refof(f021), Local3)
				Store(Refof(g003), Local4)
			}
			case (7) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					, 2, f022, 7}
				Store(Refof(f022), Local3)
				Store(Refof(g004), Local4)
			}
			case (8) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 2, f023, 8}
				Store(Refof(f023), Local3)
				Store(Refof(g005), Local4)
			}
			case (9) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, QWordAcc, NoLock, Preserve) {
					, 2, f024, 9}
				Store(Refof(f024), Local3)
				Store(Refof(g006), Local4)
			}
			case (31) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 2, f025, 31}
				Store(Refof(f025), Local3)
				Store(Refof(g007), Local4)
			}
			case (32) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, QWordAcc, NoLock, Preserve) {
					, 2, f026, 32}
				Store(Refof(f026), Local3)
				Store(Refof(g008), Local4)
			}
			case (33) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 2, f027, 33}
				Store(Refof(f027), Local3)
				Store(Refof(g009), Local4)
			}
			case (63) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					, 2, f028, 63}
				Store(Refof(f028), Local3)
				Store(Refof(g00a), Local4)
			}
			case (64) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 2, f029, 64}
				Store(Refof(f029), Local3)
				Store(Refof(g00b), Local4)
			}
			case (65) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, QWordAcc, NoLock, Preserve) {
					, 2, f02a, 65}
				Store(Refof(f02a), Local3)
				Store(Refof(g00c), Local4)
			}
			case (69) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 2, f02b, 69}
				Store(Refof(f02b), Local3)
				Store(Refof(g00d), Local4)
			}
			case (129) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					, 2, f02c, 129}
				Store(Refof(f02c), Local3)
				Store(Refof(g00e), Local4)
			}
			case (256) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 2, f02d, 256}
				Store(Refof(f02d), Local3)
				Store(Refof(g000), Local4)
			}
			case (1023) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, QWordAcc, NoLock, Preserve) {
					, 2, f02e, 1023}
				Store(Refof(f02e), Local3)
				Store(Refof(g001), Local4)
			}
			case (1983) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 2, f02f, 1983}
				Store(Refof(f02f), Local3)
				Store(Refof(g002), Local4)
			}
			default {
				err(arg0, z145, 63, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 3, f030, 1}
				Store(Refof(f030), Local3)
				Store(Refof(g003), Local4)
			}
			case (6) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
				Store(Refof(g004), Local4)
			}
			case (7) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 3, f032, 7}
				Store(Refof(f032), Local3)
				Store(Refof(g005), Local4)
			}
			case (8) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, QWordAcc, NoLock, Preserve) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
				Store(Refof(g006), Local4)
			}
			case (9) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 3, f034, 9}
				Store(Refof(f034), Local3)
				Store(Refof(g007), Local4)
			}
			case (31) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, QWordAcc, NoLock, Preserve) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
				Store(Refof(g008), Local4)
			}
			case (32) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 3, f036, 32}
				Store(Refof(f036), Local3)
				Store(Refof(g009), Local4)
			}
			case (33) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
				Store(Refof(g00a), Local4)
			}
			case (63) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 3, f038, 63}
				Store(Refof(f038), Local3)
				Store(Refof(g00b), Local4)
			}
			case (64) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, QWordAcc, NoLock, Preserve) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
				Store(Refof(g00c), Local4)
			}
			case (65) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
				Store(Refof(g00d), Local4)
			}
			case (69) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
				Store(Refof(g00e), Local4)
			}
			case (129) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
				Store(Refof(g000), Local4)
			}
			case (256) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, QWordAcc, NoLock, Preserve) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
				Store(Refof(g001), Local4)
			}
			case (1023) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
				Store(Refof(g002), Local4)
			}
			case (1983) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, QWordAcc, NoLock, Preserve) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
				Store(Refof(g003), Local4)
			}
			default {
				err(arg0, z145, 64, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
				Store(Refof(g004), Local4)
			}
			case (6) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 4, f041, 6}
				Store(Refof(f041), Local3)
				Store(Refof(g005), Local4)
			}
			case (7) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, QWordAcc, NoLock, Preserve) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
				Store(Refof(g006), Local4)
			}
			case (8) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 4, f043, 8}
				Store(Refof(f043), Local3)
				Store(Refof(g007), Local4)
			}
			case (9) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, QWordAcc, NoLock, Preserve) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
				Store(Refof(g008), Local4)
			}
			case (31) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 4, f045, 31}
				Store(Refof(f045), Local3)
				Store(Refof(g009), Local4)
			}
			case (32) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
				Store(Refof(g00a), Local4)
			}
			case (33) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 4, f047, 33}
				Store(Refof(f047), Local3)
				Store(Refof(g00b), Local4)
			}
			case (63) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, QWordAcc, NoLock, Preserve) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
				Store(Refof(g00c), Local4)
			}
			case (64) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 4, f049, 64}
				Store(Refof(f049), Local3)
				Store(Refof(g00d), Local4)
			}
			case (65) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
				Store(Refof(g00e), Local4)
			}
			case (69) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
				Store(Refof(g000), Local4)
			}
			case (129) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, QWordAcc, NoLock, Preserve) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
				Store(Refof(g001), Local4)
			}
			case (256) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
				Store(Refof(g002), Local4)
			}
			case (1023) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, QWordAcc, NoLock, Preserve) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
				Store(Refof(g003), Local4)
			}
			case (1983) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
				Store(Refof(g004), Local4)
			}
			default {
				err(arg0, z145, 65, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 5, f050, 1}
				Store(Refof(f050), Local3)
				Store(Refof(g005), Local4)
			}
			case (6) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, QWordAcc, NoLock, Preserve) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
				Store(Refof(g006), Local4)
			}
			case (7) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 5, f052, 7}
				Store(Refof(f052), Local3)
				Store(Refof(g007), Local4)
			}
			case (8) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, QWordAcc, NoLock, Preserve) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
				Store(Refof(g008), Local4)
			}
			case (9) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 5, f054, 9}
				Store(Refof(f054), Local3)
				Store(Refof(g009), Local4)
			}
			case (31) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
				Store(Refof(g00a), Local4)
			}
			case (32) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 5, f056, 32}
				Store(Refof(f056), Local3)
				Store(Refof(g00b), Local4)
			}
			case (33) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, QWordAcc, NoLock, Preserve) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
				Store(Refof(g00c), Local4)
			}
			case (63) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 5, f058, 63}
				Store(Refof(f058), Local3)
				Store(Refof(g00d), Local4)
			}
			case (64) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
				Store(Refof(g00e), Local4)
			}
			case (65) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
				Store(Refof(g000), Local4)
			}
			case (69) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, QWordAcc, NoLock, Preserve) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
				Store(Refof(g001), Local4)
			}
			case (129) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
				Store(Refof(g002), Local4)
			}
			case (256) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, QWordAcc, NoLock, Preserve) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
				Store(Refof(g003), Local4)
			}
			case (1023) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
				Store(Refof(g004), Local4)
			}
			case (1983) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
				Store(Refof(g005), Local4)
			}
			default {
				err(arg0, z145, 66, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, QWordAcc, NoLock, Preserve) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
				Store(Refof(g006), Local4)
			}
			case (6) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 6, f061, 6}
				Store(Refof(f061), Local3)
				Store(Refof(g007), Local4)
			}
			case (7) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, QWordAcc, NoLock, Preserve) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
				Store(Refof(g008), Local4)
			}
			case (8) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 6, f063, 8}
				Store(Refof(f063), Local3)
				Store(Refof(g009), Local4)
			}
			case (9) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
				Store(Refof(g00a), Local4)
			}
			case (31) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 6, f065, 31}
				Store(Refof(f065), Local3)
				Store(Refof(g00b), Local4)
			}
			case (32) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, QWordAcc, NoLock, Preserve) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
				Store(Refof(g00c), Local4)
			}
			case (33) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 6, f067, 33}
				Store(Refof(f067), Local3)
				Store(Refof(g00d), Local4)
			}
			case (63) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
				Store(Refof(g00e), Local4)
			}
			case (64) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 6, f069, 64}
				Store(Refof(f069), Local3)
				Store(Refof(g000), Local4)
			}
			case (65) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, QWordAcc, NoLock, Preserve) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
				Store(Refof(g001), Local4)
			}
			case (69) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
				Store(Refof(g002), Local4)
			}
			case (129) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, QWordAcc, NoLock, Preserve) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
				Store(Refof(g003), Local4)
			}
			case (256) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
				Store(Refof(g004), Local4)
			}
			case (1023) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
				Store(Refof(g005), Local4)
			}
			case (1983) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
				Store(Refof(g006), Local4)
			}
			default {
				err(arg0, z145, 67, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 7, f070, 1}
				Store(Refof(f070), Local3)
				Store(Refof(g007), Local4)
			}
			case (6) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, QWordAcc, NoLock, Preserve) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
				Store(Refof(g008), Local4)
			}
			case (7) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 7, f072, 7}
				Store(Refof(f072), Local3)
				Store(Refof(g009), Local4)
			}
			case (8) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
				Store(Refof(g00a), Local4)
			}
			case (9) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 7, f074, 9}
				Store(Refof(f074), Local3)
				Store(Refof(g00b), Local4)
			}
			case (31) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, QWordAcc, NoLock, Preserve) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
				Store(Refof(g00c), Local4)
			}
			case (32) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 7, f076, 32}
				Store(Refof(f076), Local3)
				Store(Refof(g00d), Local4)
			}
			case (33) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
				Store(Refof(g00e), Local4)
			}
			case (63) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 7, f078, 63}
				Store(Refof(f078), Local3)
				Store(Refof(g000), Local4)
			}
			case (64) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, QWordAcc, NoLock, Preserve) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
				Store(Refof(g001), Local4)
			}
			case (65) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
				Store(Refof(g002), Local4)
			}
			case (69) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, QWordAcc, NoLock, Preserve) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
				Store(Refof(g003), Local4)
			}
			case (129) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
				Store(Refof(g004), Local4)
			}
			case (256) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
				Store(Refof(g005), Local4)
			}
			case (1023) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
				Store(Refof(g006), Local4)
			}
			case (1983) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, QWordAcc, NoLock, Preserve) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
				Store(Refof(g007), Local4)
			}
			default {
				err(arg0, z145, 68, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, QWordAcc, NoLock, Preserve) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
				Store(Refof(g008), Local4)
			}
			case (6) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
				Store(Refof(g009), Local4)
			}
			case (7) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
				Store(Refof(g00a), Local4)
			}
			case (8) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
				Store(Refof(g00b), Local4)
			}
			case (9) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, QWordAcc, NoLock, Preserve) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
				Store(Refof(g00c), Local4)
			}
			case (31) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
				Store(Refof(g00d), Local4)
			}
			case (32) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
				Store(Refof(g00e), Local4)
			}
			case (33) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
				Store(Refof(g000), Local4)
			}
			case (63) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, QWordAcc, NoLock, Preserve) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
				Store(Refof(g001), Local4)
			}
			case (64) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
				Store(Refof(g002), Local4)
			}
			case (65) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, QWordAcc, NoLock, Preserve) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
				Store(Refof(g003), Local4)
			}
			case (69) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
				Store(Refof(g004), Local4)
			}
			case (129) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
				Store(Refof(g005), Local4)
			}
			case (256) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
				Store(Refof(g006), Local4)
			}
			case (1023) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, QWordAcc, NoLock, Preserve) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
				Store(Refof(g007), Local4)
			}
			case (1983) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
				Store(Refof(g008), Local4)
			}
			default {
				err(arg0, z145, 69, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 9, f090, 1}
				Store(Refof(f090), Local3)
				Store(Refof(g009), Local4)
			}
			case (6) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
				Store(Refof(g00a), Local4)
			}
			case (7) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 9, f092, 7}
				Store(Refof(f092), Local3)
				Store(Refof(g00b), Local4)
			}
			case (8) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, QWordAcc, NoLock, Preserve) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
				Store(Refof(g00c), Local4)
			}
			case (9) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 9, f094, 9}
				Store(Refof(f094), Local3)
				Store(Refof(g00d), Local4)
			}
			case (31) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
				Store(Refof(g00e), Local4)
			}
			case (32) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 9, f096, 32}
				Store(Refof(f096), Local3)
				Store(Refof(g000), Local4)
			}
			case (33) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, QWordAcc, NoLock, Preserve) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
				Store(Refof(g001), Local4)
			}
			case (63) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 9, f098, 63}
				Store(Refof(f098), Local3)
				Store(Refof(g002), Local4)
			}
			case (64) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, QWordAcc, NoLock, Preserve) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
				Store(Refof(g003), Local4)
			}
			case (65) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
				Store(Refof(g004), Local4)
			}
			case (69) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
				Store(Refof(g005), Local4)
			}
			case (129) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
				Store(Refof(g006), Local4)
			}
			case (256) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, QWordAcc, NoLock, Preserve) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
				Store(Refof(g007), Local4)
			}
			case (1023) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
				Store(Refof(g008), Local4)
			}
			case (1983) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
				Store(Refof(g009), Local4)
			}
			default {
				err(arg0, z145, 70, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
				Store(Refof(g00a), Local4)
			}
			case (6) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
				Store(Refof(g00b), Local4)
			}
			case (7) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
				Store(Refof(g00c), Local4)
			}
			case (8) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
				Store(Refof(g00d), Local4)
			}
			case (9) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
				Store(Refof(g00e), Local4)
			}
			case (31) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
				Store(Refof(g000), Local4)
			}
			case (32) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
				Store(Refof(g001), Local4)
			}
			case (33) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
				Store(Refof(g002), Local4)
			}
			case (63) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
				Store(Refof(g003), Local4)
			}
			case (64) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
				Store(Refof(g004), Local4)
			}
			case (65) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
				Store(Refof(g005), Local4)
			}
			case (69) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
				Store(Refof(g006), Local4)
			}
			case (129) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
				Store(Refof(g007), Local4)
			}
			case (256) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
				Store(Refof(g008), Local4)
			}
			case (1023) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
				Store(Refof(g009), Local4)
			}
			case (1983) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
				Store(Refof(g00a), Local4)
			}
			default {
				err(arg0, z145, 71, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
				Store(Refof(g00b), Local4)
			}
			case (6) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, QWordAcc, NoLock, Preserve) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
				Store(Refof(g00c), Local4)
			}
			case (7) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
				Store(Refof(g00d), Local4)
			}
			case (8) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
				Store(Refof(g00e), Local4)
			}
			case (9) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
				Store(Refof(g000), Local4)
			}
			case (31) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, QWordAcc, NoLock, Preserve) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
				Store(Refof(g001), Local4)
			}
			case (32) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
				Store(Refof(g002), Local4)
			}
			case (33) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, QWordAcc, NoLock, Preserve) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
				Store(Refof(g003), Local4)
			}
			case (63) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
				Store(Refof(g004), Local4)
			}
			case (64) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
				Store(Refof(g005), Local4)
			}
			case (65) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
				Store(Refof(g006), Local4)
			}
			case (69) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, QWordAcc, NoLock, Preserve) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
				Store(Refof(g007), Local4)
			}
			case (129) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
				Store(Refof(g008), Local4)
			}
			case (256) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
				Store(Refof(g009), Local4)
			}
			case (1023) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1983) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, QWordAcc, NoLock, Preserve) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
				Store(Refof(g00b), Local4)
			}
			default {
				err(arg0, z145, 72, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, QWordAcc, NoLock, Preserve) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
				Store(Refof(g00c), Local4)
			}
			case (6) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
				Store(Refof(g00d), Local4)
			}
			case (7) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
				Store(Refof(g00e), Local4)
			}
			case (8) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
				Store(Refof(g000), Local4)
			}
			case (9) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, QWordAcc, NoLock, Preserve) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
				Store(Refof(g001), Local4)
			}
			case (31) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
				Store(Refof(g002), Local4)
			}
			case (32) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, QWordAcc, NoLock, Preserve) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
				Store(Refof(g003), Local4)
			}
			case (33) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
				Store(Refof(g004), Local4)
			}
			case (63) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
				Store(Refof(g005), Local4)
			}
			case (64) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
				Store(Refof(g006), Local4)
			}
			case (65) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, QWordAcc, NoLock, Preserve) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
				Store(Refof(g007), Local4)
			}
			case (69) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
				Store(Refof(g008), Local4)
			}
			case (129) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
				Store(Refof(g009), Local4)
			}
			case (256) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1023) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, QWordAcc, NoLock, Preserve) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1983) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
				Store(Refof(g00c), Local4)
			}
			default {
				err(arg0, z145, 73, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
				Store(Refof(g00d), Local4)
			}
			case (6) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
				Store(Refof(g00e), Local4)
			}
			case (7) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
				Store(Refof(g000), Local4)
			}
			case (8) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, NoLock, Preserve) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
				Store(Refof(g001), Local4)
			}
			case (9) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
				Store(Refof(g002), Local4)
			}
			case (31) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, NoLock, Preserve) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
				Store(Refof(g003), Local4)
			}
			case (32) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
				Store(Refof(g004), Local4)
			}
			case (33) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
				Store(Refof(g005), Local4)
			}
			case (63) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
				Store(Refof(g006), Local4)
			}
			case (64) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, QWordAcc, NoLock, Preserve) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
				Store(Refof(g007), Local4)
			}
			case (65) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
				Store(Refof(g008), Local4)
			}
			case (69) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
				Store(Refof(g009), Local4)
			}
			case (129) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
				Store(Refof(g00a), Local4)
			}
			case (256) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, QWordAcc, NoLock, Preserve) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1023) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1983) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, QWordAcc, NoLock, Preserve) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
				Store(Refof(g00d), Local4)
			}
			default {
				err(arg0, z145, 74, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
				Store(Refof(g00e), Local4)
			}
			case (6) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
				Store(Refof(g000), Local4)
			}
			case (7) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, QWordAcc, NoLock, Preserve) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
				Store(Refof(g001), Local4)
			}
			case (8) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
				Store(Refof(g002), Local4)
			}
			case (9) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, QWordAcc, NoLock, Preserve) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
				Store(Refof(g003), Local4)
			}
			case (31) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
				Store(Refof(g004), Local4)
			}
			case (32) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
				Store(Refof(g005), Local4)
			}
			case (33) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
				Store(Refof(g006), Local4)
			}
			case (63) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, QWordAcc, NoLock, Preserve) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
				Store(Refof(g007), Local4)
			}
			case (64) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
				Store(Refof(g008), Local4)
			}
			case (65) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
				Store(Refof(g009), Local4)
			}
			case (69) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
				Store(Refof(g00a), Local4)
			}
			case (129) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, QWordAcc, NoLock, Preserve) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
				Store(Refof(g00b), Local4)
			}
			case (256) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1023) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, QWordAcc, NoLock, Preserve) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1983) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
				Store(Refof(g00e), Local4)
			}
			default {
				err(arg0, z145, 75, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, NoLock, Preserve) {
					AccessAs(QWordAcc),
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, NoLock, Preserve) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z145, 76, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z145, 77, 0, 0, arg2, arg3)
		return}
	}

	Store(2, Index(fcp0, 0))
	Store(Refof(BNK0), Index(fcp0, 1))
	Store(Local2, Index(fcp0, 2))
	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Local4)
	Store(0, Index(fcp0, 0))
}

// Create BankField Unit
// (AnyAcc, Lock, Preserve)
Method(m7d4, 6, Serialized)
{
	OperationRegion(OPRb, SystemIO, 0, 9)
	OperationRegion(OPR0, SystemIO, 11, 256)

	Field(OPRb, ByteAcc, NoLock, Preserve) {
		BNK0, 8,
	}
	BankField(OPR0, BNK0, 0, ByteAcc, NoLock, Preserve) {
		g000, 2048,
	}
	BankField(OPR0, BNK0, 1, ByteAcc, NoLock, Preserve) {
		g001, 2048,
	}
	BankField(OPR0, BNK0, 2, ByteAcc, NoLock, Preserve) {
		g002, 2048,
	}
	BankField(OPR0, BNK0, 3, ByteAcc, NoLock, Preserve) {
		g003, 2048,
	}
	BankField(OPR0, BNK0, 4, ByteAcc, NoLock, Preserve) {
		g004, 2048,
	}
	BankField(OPR0, BNK0, 5, ByteAcc, NoLock, Preserve) {
		g005, 2048,
	}
	BankField(OPR0, BNK0, 6, ByteAcc, NoLock, Preserve) {
		g006, 2048,
	}
	BankField(OPR0, BNK0, 7, ByteAcc, NoLock, Preserve) {
		g007, 2048,
	}
	BankField(OPR0, BNK0, 8, ByteAcc, NoLock, Preserve) {
		g008, 2048,
	}
	BankField(OPR0, BNK0, 9, ByteAcc, NoLock, Preserve) {
		g009, 2048,
	}
	BankField(OPR0, BNK0, 63, ByteAcc, NoLock, Preserve) {
		g00a, 2048,
	}
	BankField(OPR0, BNK0, 64, ByteAcc, NoLock, Preserve) {
		g00b, 2048,
	}
	BankField(OPR0, BNK0, 127, ByteAcc, NoLock, Preserve) {
		g00c, 2048,
	}
	BankField(OPR0, BNK0, 128, ByteAcc, NoLock, Preserve) {
		g00d, 2048,
	}
	BankField(OPR0, BNK0, 255, ByteAcc, NoLock, Preserve) {
		g00e, 2048,
	}


	Concatenate(arg0, "-m7d4", arg0)

	switch(ToInteger (arg2)) {
	case (0) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, AnyAcc, Lock, Preserve) {
					, 0, f000, 1}
				Store(Refof(f000), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 0, f001, 6}
				Store(Refof(f001), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, Lock, Preserve) {
					, 0, f002, 7}
				Store(Refof(f002), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 0, f003, 8}
				Store(Refof(f003), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, AnyAcc, Lock, Preserve) {
					, 0, f004, 9}
				Store(Refof(f004), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 0, f005, 31}
				Store(Refof(f005), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, Lock, Preserve) {
					, 0, f006, 32}
				Store(Refof(f006), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 0, f007, 33}
				Store(Refof(f007), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, AnyAcc, Lock, Preserve) {
					, 0, f008, 63}
				Store(Refof(f008), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 0, f009, 64}
				Store(Refof(f009), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, AnyAcc, Lock, Preserve) {
					, 0, f00a, 65}
				Store(Refof(f00a), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 0, f00b, 69}
				Store(Refof(f00b), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, Lock, Preserve) {
					, 0, f00c, 129}
				Store(Refof(f00c), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 0, f00d, 256}
				Store(Refof(f00d), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, AnyAcc, Lock, Preserve) {
					, 0, f00e, 1023}
				Store(Refof(f00e), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 0, f00f, 1983}
				Store(Refof(f00f), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z145, 78, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (1) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 1, f010, 1}
				Store(Refof(f010), Local3)
				Store(Refof(g001), Local4)
			}
			case (6) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, Lock, Preserve) {
					, 1, f011, 6}
				Store(Refof(f011), Local3)
				Store(Refof(g002), Local4)
			}
			case (7) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 1, f012, 7}
				Store(Refof(f012), Local3)
				Store(Refof(g003), Local4)
			}
			case (8) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, Lock, Preserve) {
					, 1, f013, 8}
				Store(Refof(f013), Local3)
				Store(Refof(g004), Local4)
			}
			case (9) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 1, f014, 9}
				Store(Refof(f014), Local3)
				Store(Refof(g005), Local4)
			}
			case (31) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, Lock, Preserve) {
					, 1, f015, 31}
				Store(Refof(f015), Local3)
				Store(Refof(g006), Local4)
			}
			case (32) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 1, f016, 32}
				Store(Refof(f016), Local3)
				Store(Refof(g007), Local4)
			}
			case (33) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, AnyAcc, Lock, Preserve) {
					, 1, f017, 33}
				Store(Refof(f017), Local3)
				Store(Refof(g008), Local4)
			}
			case (63) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 1, f018, 63}
				Store(Refof(f018), Local3)
				Store(Refof(g009), Local4)
			}
			case (64) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, AnyAcc, Lock, Preserve) {
					, 1, f019, 64}
				Store(Refof(f019), Local3)
				Store(Refof(g00a), Local4)
			}
			case (65) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 1, f01a, 65}
				Store(Refof(f01a), Local3)
				Store(Refof(g00b), Local4)
			}
			case (69) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, Lock, Preserve) {
					, 1, f01b, 69}
				Store(Refof(f01b), Local3)
				Store(Refof(g00c), Local4)
			}
			case (129) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 1, f01c, 129}
				Store(Refof(f01c), Local3)
				Store(Refof(g00d), Local4)
			}
			case (256) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, AnyAcc, Lock, Preserve) {
					, 1, f01d, 256}
				Store(Refof(f01d), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1023) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 1, f01e, 1023}
				Store(Refof(f01e), Local3)
				Store(Refof(g000), Local4)
			}
			case (1983) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					, 1, f01f, 1983}
				Store(Refof(f01f), Local3)
				Store(Refof(g001), Local4)
			}
			default {
				err(arg0, z145, 79, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (2) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, Lock, Preserve) {
					, 2, f020, 1}
				Store(Refof(f020), Local3)
				Store(Refof(g002), Local4)
			}
			case (6) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 2, f021, 6}
				Store(Refof(f021), Local3)
				Store(Refof(g003), Local4)
			}
			case (7) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, AnyAcc, Lock, Preserve) {
					, 2, f022, 7}
				Store(Refof(f022), Local3)
				Store(Refof(g004), Local4)
			}
			case (8) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 2, f023, 8}
				Store(Refof(f023), Local3)
				Store(Refof(g005), Local4)
			}
			case (9) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, Lock, Preserve) {
					, 2, f024, 9}
				Store(Refof(f024), Local3)
				Store(Refof(g006), Local4)
			}
			case (31) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 2, f025, 31}
				Store(Refof(f025), Local3)
				Store(Refof(g007), Local4)
			}
			case (32) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, AnyAcc, Lock, Preserve) {
					, 2, f026, 32}
				Store(Refof(f026), Local3)
				Store(Refof(g008), Local4)
			}
			case (33) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 2, f027, 33}
				Store(Refof(f027), Local3)
				Store(Refof(g009), Local4)
			}
			case (63) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, AnyAcc, Lock, Preserve) {
					, 2, f028, 63}
				Store(Refof(f028), Local3)
				Store(Refof(g00a), Local4)
			}
			case (64) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 2, f029, 64}
				Store(Refof(f029), Local3)
				Store(Refof(g00b), Local4)
			}
			case (65) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, Lock, Preserve) {
					, 2, f02a, 65}
				Store(Refof(f02a), Local3)
				Store(Refof(g00c), Local4)
			}
			case (69) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 2, f02b, 69}
				Store(Refof(f02b), Local3)
				Store(Refof(g00d), Local4)
			}
			case (129) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, AnyAcc, Lock, Preserve) {
					, 2, f02c, 129}
				Store(Refof(f02c), Local3)
				Store(Refof(g00e), Local4)
			}
			case (256) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 2, f02d, 256}
				Store(Refof(f02d), Local3)
				Store(Refof(g000), Local4)
			}
			case (1023) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					, 2, f02e, 1023}
				Store(Refof(f02e), Local3)
				Store(Refof(g001), Local4)
			}
			case (1983) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 2, f02f, 1983}
				Store(Refof(f02f), Local3)
				Store(Refof(g002), Local4)
			}
			default {
				err(arg0, z145, 80, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (3) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 3, f030, 1}
				Store(Refof(f030), Local3)
				Store(Refof(g003), Local4)
			}
			case (6) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, AnyAcc, Lock, Preserve) {
					, 3, f031, 6}
				Store(Refof(f031), Local3)
				Store(Refof(g004), Local4)
			}
			case (7) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 3, f032, 7}
				Store(Refof(f032), Local3)
				Store(Refof(g005), Local4)
			}
			case (8) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, Lock, Preserve) {
					, 3, f033, 8}
				Store(Refof(f033), Local3)
				Store(Refof(g006), Local4)
			}
			case (9) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 3, f034, 9}
				Store(Refof(f034), Local3)
				Store(Refof(g007), Local4)
			}
			case (31) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, AnyAcc, Lock, Preserve) {
					, 3, f035, 31}
				Store(Refof(f035), Local3)
				Store(Refof(g008), Local4)
			}
			case (32) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 3, f036, 32}
				Store(Refof(f036), Local3)
				Store(Refof(g009), Local4)
			}
			case (33) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, AnyAcc, Lock, Preserve) {
					, 3, f037, 33}
				Store(Refof(f037), Local3)
				Store(Refof(g00a), Local4)
			}
			case (63) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 3, f038, 63}
				Store(Refof(f038), Local3)
				Store(Refof(g00b), Local4)
			}
			case (64) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, Lock, Preserve) {
					, 3, f039, 64}
				Store(Refof(f039), Local3)
				Store(Refof(g00c), Local4)
			}
			case (65) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 3, f03a, 65}
				Store(Refof(f03a), Local3)
				Store(Refof(g00d), Local4)
			}
			case (69) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, AnyAcc, Lock, Preserve) {
					, 3, f03b, 69}
				Store(Refof(f03b), Local3)
				Store(Refof(g00e), Local4)
			}
			case (129) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 3, f03c, 129}
				Store(Refof(f03c), Local3)
				Store(Refof(g000), Local4)
			}
			case (256) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					, 3, f03d, 256}
				Store(Refof(f03d), Local3)
				Store(Refof(g001), Local4)
			}
			case (1023) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 3, f03e, 1023}
				Store(Refof(f03e), Local3)
				Store(Refof(g002), Local4)
			}
			case (1983) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, AnyAcc, Lock, Preserve) {
					, 3, f03f, 1983}
				Store(Refof(f03f), Local3)
				Store(Refof(g003), Local4)
			}
			default {
				err(arg0, z145, 81, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (4) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, AnyAcc, Lock, Preserve) {
					, 4, f040, 1}
				Store(Refof(f040), Local3)
				Store(Refof(g004), Local4)
			}
			case (6) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 4, f041, 6}
				Store(Refof(f041), Local3)
				Store(Refof(g005), Local4)
			}
			case (7) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, Lock, Preserve) {
					, 4, f042, 7}
				Store(Refof(f042), Local3)
				Store(Refof(g006), Local4)
			}
			case (8) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 4, f043, 8}
				Store(Refof(f043), Local3)
				Store(Refof(g007), Local4)
			}
			case (9) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, AnyAcc, Lock, Preserve) {
					, 4, f044, 9}
				Store(Refof(f044), Local3)
				Store(Refof(g008), Local4)
			}
			case (31) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 4, f045, 31}
				Store(Refof(f045), Local3)
				Store(Refof(g009), Local4)
			}
			case (32) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, AnyAcc, Lock, Preserve) {
					, 4, f046, 32}
				Store(Refof(f046), Local3)
				Store(Refof(g00a), Local4)
			}
			case (33) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 4, f047, 33}
				Store(Refof(f047), Local3)
				Store(Refof(g00b), Local4)
			}
			case (63) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, Lock, Preserve) {
					, 4, f048, 63}
				Store(Refof(f048), Local3)
				Store(Refof(g00c), Local4)
			}
			case (64) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 4, f049, 64}
				Store(Refof(f049), Local3)
				Store(Refof(g00d), Local4)
			}
			case (65) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, AnyAcc, Lock, Preserve) {
					, 4, f04a, 65}
				Store(Refof(f04a), Local3)
				Store(Refof(g00e), Local4)
			}
			case (69) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 4, f04b, 69}
				Store(Refof(f04b), Local3)
				Store(Refof(g000), Local4)
			}
			case (129) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					, 4, f04c, 129}
				Store(Refof(f04c), Local3)
				Store(Refof(g001), Local4)
			}
			case (256) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 4, f04d, 256}
				Store(Refof(f04d), Local3)
				Store(Refof(g002), Local4)
			}
			case (1023) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, AnyAcc, Lock, Preserve) {
					, 4, f04e, 1023}
				Store(Refof(f04e), Local3)
				Store(Refof(g003), Local4)
			}
			case (1983) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 4, f04f, 1983}
				Store(Refof(f04f), Local3)
				Store(Refof(g004), Local4)
			}
			default {
				err(arg0, z145, 82, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (5) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 5, f050, 1}
				Store(Refof(f050), Local3)
				Store(Refof(g005), Local4)
			}
			case (6) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, Lock, Preserve) {
					, 5, f051, 6}
				Store(Refof(f051), Local3)
				Store(Refof(g006), Local4)
			}
			case (7) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 5, f052, 7}
				Store(Refof(f052), Local3)
				Store(Refof(g007), Local4)
			}
			case (8) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, AnyAcc, Lock, Preserve) {
					, 5, f053, 8}
				Store(Refof(f053), Local3)
				Store(Refof(g008), Local4)
			}
			case (9) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 5, f054, 9}
				Store(Refof(f054), Local3)
				Store(Refof(g009), Local4)
			}
			case (31) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, AnyAcc, Lock, Preserve) {
					, 5, f055, 31}
				Store(Refof(f055), Local3)
				Store(Refof(g00a), Local4)
			}
			case (32) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 5, f056, 32}
				Store(Refof(f056), Local3)
				Store(Refof(g00b), Local4)
			}
			case (33) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, Lock, Preserve) {
					, 5, f057, 33}
				Store(Refof(f057), Local3)
				Store(Refof(g00c), Local4)
			}
			case (63) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 5, f058, 63}
				Store(Refof(f058), Local3)
				Store(Refof(g00d), Local4)
			}
			case (64) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, AnyAcc, Lock, Preserve) {
					, 5, f059, 64}
				Store(Refof(f059), Local3)
				Store(Refof(g00e), Local4)
			}
			case (65) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 5, f05a, 65}
				Store(Refof(f05a), Local3)
				Store(Refof(g000), Local4)
			}
			case (69) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					, 5, f05b, 69}
				Store(Refof(f05b), Local3)
				Store(Refof(g001), Local4)
			}
			case (129) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 5, f05c, 129}
				Store(Refof(f05c), Local3)
				Store(Refof(g002), Local4)
			}
			case (256) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, AnyAcc, Lock, Preserve) {
					, 5, f05d, 256}
				Store(Refof(f05d), Local3)
				Store(Refof(g003), Local4)
			}
			case (1023) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 5, f05e, 1023}
				Store(Refof(f05e), Local3)
				Store(Refof(g004), Local4)
			}
			case (1983) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, AnyAcc, Lock, Preserve) {
					, 5, f05f, 1983}
				Store(Refof(f05f), Local3)
				Store(Refof(g005), Local4)
			}
			default {
				err(arg0, z145, 83, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (6) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, Lock, Preserve) {
					, 6, f060, 1}
				Store(Refof(f060), Local3)
				Store(Refof(g006), Local4)
			}
			case (6) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 6, f061, 6}
				Store(Refof(f061), Local3)
				Store(Refof(g007), Local4)
			}
			case (7) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, AnyAcc, Lock, Preserve) {
					, 6, f062, 7}
				Store(Refof(f062), Local3)
				Store(Refof(g008), Local4)
			}
			case (8) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 6, f063, 8}
				Store(Refof(f063), Local3)
				Store(Refof(g009), Local4)
			}
			case (9) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, AnyAcc, Lock, Preserve) {
					, 6, f064, 9}
				Store(Refof(f064), Local3)
				Store(Refof(g00a), Local4)
			}
			case (31) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 6, f065, 31}
				Store(Refof(f065), Local3)
				Store(Refof(g00b), Local4)
			}
			case (32) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, Lock, Preserve) {
					, 6, f066, 32}
				Store(Refof(f066), Local3)
				Store(Refof(g00c), Local4)
			}
			case (33) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 6, f067, 33}
				Store(Refof(f067), Local3)
				Store(Refof(g00d), Local4)
			}
			case (63) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, AnyAcc, Lock, Preserve) {
					, 6, f068, 63}
				Store(Refof(f068), Local3)
				Store(Refof(g00e), Local4)
			}
			case (64) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 6, f069, 64}
				Store(Refof(f069), Local3)
				Store(Refof(g000), Local4)
			}
			case (65) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					, 6, f06a, 65}
				Store(Refof(f06a), Local3)
				Store(Refof(g001), Local4)
			}
			case (69) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 6, f06b, 69}
				Store(Refof(f06b), Local3)
				Store(Refof(g002), Local4)
			}
			case (129) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, AnyAcc, Lock, Preserve) {
					, 6, f06c, 129}
				Store(Refof(f06c), Local3)
				Store(Refof(g003), Local4)
			}
			case (256) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 6, f06d, 256}
				Store(Refof(f06d), Local3)
				Store(Refof(g004), Local4)
			}
			case (1023) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, AnyAcc, Lock, Preserve) {
					, 6, f06e, 1023}
				Store(Refof(f06e), Local3)
				Store(Refof(g005), Local4)
			}
			case (1983) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 6, f06f, 1983}
				Store(Refof(f06f), Local3)
				Store(Refof(g006), Local4)
			}
			default {
				err(arg0, z145, 84, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (7) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 7, f070, 1}
				Store(Refof(f070), Local3)
				Store(Refof(g007), Local4)
			}
			case (6) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, AnyAcc, Lock, Preserve) {
					, 7, f071, 6}
				Store(Refof(f071), Local3)
				Store(Refof(g008), Local4)
			}
			case (7) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 7, f072, 7}
				Store(Refof(f072), Local3)
				Store(Refof(g009), Local4)
			}
			case (8) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, AnyAcc, Lock, Preserve) {
					, 7, f073, 8}
				Store(Refof(f073), Local3)
				Store(Refof(g00a), Local4)
			}
			case (9) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 7, f074, 9}
				Store(Refof(f074), Local3)
				Store(Refof(g00b), Local4)
			}
			case (31) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, Lock, Preserve) {
					, 7, f075, 31}
				Store(Refof(f075), Local3)
				Store(Refof(g00c), Local4)
			}
			case (32) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 7, f076, 32}
				Store(Refof(f076), Local3)
				Store(Refof(g00d), Local4)
			}
			case (33) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, AnyAcc, Lock, Preserve) {
					, 7, f077, 33}
				Store(Refof(f077), Local3)
				Store(Refof(g00e), Local4)
			}
			case (63) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 7, f078, 63}
				Store(Refof(f078), Local3)
				Store(Refof(g000), Local4)
			}
			case (64) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					, 7, f079, 64}
				Store(Refof(f079), Local3)
				Store(Refof(g001), Local4)
			}
			case (65) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 7, f07a, 65}
				Store(Refof(f07a), Local3)
				Store(Refof(g002), Local4)
			}
			case (69) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, AnyAcc, Lock, Preserve) {
					, 7, f07b, 69}
				Store(Refof(f07b), Local3)
				Store(Refof(g003), Local4)
			}
			case (129) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 7, f07c, 129}
				Store(Refof(f07c), Local3)
				Store(Refof(g004), Local4)
			}
			case (256) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, AnyAcc, Lock, Preserve) {
					, 7, f07d, 256}
				Store(Refof(f07d), Local3)
				Store(Refof(g005), Local4)
			}
			case (1023) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 7, f07e, 1023}
				Store(Refof(f07e), Local3)
				Store(Refof(g006), Local4)
			}
			case (1983) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, Lock, Preserve) {
					, 7, f07f, 1983}
				Store(Refof(f07f), Local3)
				Store(Refof(g007), Local4)
			}
			default {
				err(arg0, z145, 85, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (8) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, AnyAcc, Lock, Preserve) {
					Offset(1), f080, 1}
				Store(Refof(f080), Local3)
				Store(Refof(g008), Local4)
			}
			case (6) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(1), f081, 6}
				Store(Refof(f081), Local3)
				Store(Refof(g009), Local4)
			}
			case (7) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, AnyAcc, Lock, Preserve) {
					Offset(1), f082, 7}
				Store(Refof(f082), Local3)
				Store(Refof(g00a), Local4)
			}
			case (8) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(1), f083, 8}
				Store(Refof(f083), Local3)
				Store(Refof(g00b), Local4)
			}
			case (9) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, Lock, Preserve) {
					Offset(1), f084, 9}
				Store(Refof(f084), Local3)
				Store(Refof(g00c), Local4)
			}
			case (31) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(1), f085, 31}
				Store(Refof(f085), Local3)
				Store(Refof(g00d), Local4)
			}
			case (32) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, AnyAcc, Lock, Preserve) {
					Offset(1), f086, 32}
				Store(Refof(f086), Local3)
				Store(Refof(g00e), Local4)
			}
			case (33) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(1), f087, 33}
				Store(Refof(f087), Local3)
				Store(Refof(g000), Local4)
			}
			case (63) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					Offset(1), f088, 63}
				Store(Refof(f088), Local3)
				Store(Refof(g001), Local4)
			}
			case (64) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(1), f089, 64}
				Store(Refof(f089), Local3)
				Store(Refof(g002), Local4)
			}
			case (65) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, AnyAcc, Lock, Preserve) {
					Offset(1), f08a, 65}
				Store(Refof(f08a), Local3)
				Store(Refof(g003), Local4)
			}
			case (69) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(1), f08b, 69}
				Store(Refof(f08b), Local3)
				Store(Refof(g004), Local4)
			}
			case (129) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, AnyAcc, Lock, Preserve) {
					Offset(1), f08c, 129}
				Store(Refof(f08c), Local3)
				Store(Refof(g005), Local4)
			}
			case (256) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(1), f08d, 256}
				Store(Refof(f08d), Local3)
				Store(Refof(g006), Local4)
			}
			case (1023) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, Lock, Preserve) {
					Offset(1), f08e, 1023}
				Store(Refof(f08e), Local3)
				Store(Refof(g007), Local4)
			}
			case (1983) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(1), f08f, 1983}
				Store(Refof(f08f), Local3)
				Store(Refof(g008), Local4)
			}
			default {
				err(arg0, z145, 86, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (9) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 9, f090, 1}
				Store(Refof(f090), Local3)
				Store(Refof(g009), Local4)
			}
			case (6) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, AnyAcc, Lock, Preserve) {
					, 9, f091, 6}
				Store(Refof(f091), Local3)
				Store(Refof(g00a), Local4)
			}
			case (7) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 9, f092, 7}
				Store(Refof(f092), Local3)
				Store(Refof(g00b), Local4)
			}
			case (8) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, Lock, Preserve) {
					, 9, f093, 8}
				Store(Refof(f093), Local3)
				Store(Refof(g00c), Local4)
			}
			case (9) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 9, f094, 9}
				Store(Refof(f094), Local3)
				Store(Refof(g00d), Local4)
			}
			case (31) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, AnyAcc, Lock, Preserve) {
					, 9, f095, 31}
				Store(Refof(f095), Local3)
				Store(Refof(g00e), Local4)
			}
			case (32) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 9, f096, 32}
				Store(Refof(f096), Local3)
				Store(Refof(g000), Local4)
			}
			case (33) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					, 9, f097, 33}
				Store(Refof(f097), Local3)
				Store(Refof(g001), Local4)
			}
			case (63) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 9, f098, 63}
				Store(Refof(f098), Local3)
				Store(Refof(g002), Local4)
			}
			case (64) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, AnyAcc, Lock, Preserve) {
					, 9, f099, 64}
				Store(Refof(f099), Local3)
				Store(Refof(g003), Local4)
			}
			case (65) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 9, f09a, 65}
				Store(Refof(f09a), Local3)
				Store(Refof(g004), Local4)
			}
			case (69) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, AnyAcc, Lock, Preserve) {
					, 9, f09b, 69}
				Store(Refof(f09b), Local3)
				Store(Refof(g005), Local4)
			}
			case (129) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 9, f09c, 129}
				Store(Refof(f09c), Local3)
				Store(Refof(g006), Local4)
			}
			case (256) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, Lock, Preserve) {
					, 9, f09d, 256}
				Store(Refof(f09d), Local3)
				Store(Refof(g007), Local4)
			}
			case (1023) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 9, f09e, 1023}
				Store(Refof(f09e), Local3)
				Store(Refof(g008), Local4)
			}
			case (1983) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, AnyAcc, Lock, Preserve) {
					, 9, f09f, 1983}
				Store(Refof(f09f), Local3)
				Store(Refof(g009), Local4)
			}
			default {
				err(arg0, z145, 87, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (31) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0a0, 1}
				Store(Refof(f0a0), Local3)
				Store(Refof(g00a), Local4)
			}
			case (6) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(3), , 7, f0a1, 6}
				Store(Refof(f0a1), Local3)
				Store(Refof(g00b), Local4)
			}
			case (7) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0a2, 7}
				Store(Refof(f0a2), Local3)
				Store(Refof(g00c), Local4)
			}
			case (8) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(3), , 7, f0a3, 8}
				Store(Refof(f0a3), Local3)
				Store(Refof(g00d), Local4)
			}
			case (9) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0a4, 9}
				Store(Refof(f0a4), Local3)
				Store(Refof(g00e), Local4)
			}
			case (31) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(3), , 7, f0a5, 31}
				Store(Refof(f0a5), Local3)
				Store(Refof(g000), Local4)
			}
			case (32) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0a6, 32}
				Store(Refof(f0a6), Local3)
				Store(Refof(g001), Local4)
			}
			case (33) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(3), , 7, f0a7, 33}
				Store(Refof(f0a7), Local3)
				Store(Refof(g002), Local4)
			}
			case (63) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0a8, 63}
				Store(Refof(f0a8), Local3)
				Store(Refof(g003), Local4)
			}
			case (64) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(3), , 7, f0a9, 64}
				Store(Refof(f0a9), Local3)
				Store(Refof(g004), Local4)
			}
			case (65) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0aa, 65}
				Store(Refof(f0aa), Local3)
				Store(Refof(g005), Local4)
			}
			case (69) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(3), , 7, f0ab, 69}
				Store(Refof(f0ab), Local3)
				Store(Refof(g006), Local4)
			}
			case (129) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0ac, 129}
				Store(Refof(f0ac), Local3)
				Store(Refof(g007), Local4)
			}
			case (256) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(3), , 7, f0ad, 256}
				Store(Refof(f0ad), Local3)
				Store(Refof(g008), Local4)
			}
			case (1023) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, AnyAcc, Lock, Preserve) {
					Offset(3), , 7, f0ae, 1023}
				Store(Refof(f0ae), Local3)
				Store(Refof(g009), Local4)
			}
			case (1983) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(3), , 7, f0af, 1983}
				Store(Refof(f0af), Local3)
				Store(Refof(g00a), Local4)
			}
			default {
				err(arg0, z145, 88, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (32) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 32, f0b0, 1}
				Store(Refof(f0b0), Local3)
				Store(Refof(g00b), Local4)
			}
			case (6) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, Lock, Preserve) {
					, 32, f0b1, 6}
				Store(Refof(f0b1), Local3)
				Store(Refof(g00c), Local4)
			}
			case (7) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 32, f0b2, 7}
				Store(Refof(f0b2), Local3)
				Store(Refof(g00d), Local4)
			}
			case (8) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, AnyAcc, Lock, Preserve) {
					, 32, f0b3, 8}
				Store(Refof(f0b3), Local3)
				Store(Refof(g00e), Local4)
			}
			case (9) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 32, f0b4, 9}
				Store(Refof(f0b4), Local3)
				Store(Refof(g000), Local4)
			}
			case (31) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					, 32, f0b5, 31}
				Store(Refof(f0b5), Local3)
				Store(Refof(g001), Local4)
			}
			case (32) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 32, f0b6, 32}
				Store(Refof(f0b6), Local3)
				Store(Refof(g002), Local4)
			}
			case (33) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, AnyAcc, Lock, Preserve) {
					, 32, f0b7, 33}
				Store(Refof(f0b7), Local3)
				Store(Refof(g003), Local4)
			}
			case (63) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 32, f0b8, 63}
				Store(Refof(f0b8), Local3)
				Store(Refof(g004), Local4)
			}
			case (64) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, AnyAcc, Lock, Preserve) {
					, 32, f0b9, 64}
				Store(Refof(f0b9), Local3)
				Store(Refof(g005), Local4)
			}
			case (65) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 32, f0ba, 65}
				Store(Refof(f0ba), Local3)
				Store(Refof(g006), Local4)
			}
			case (69) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, Lock, Preserve) {
					, 32, f0bb, 69}
				Store(Refof(f0bb), Local3)
				Store(Refof(g007), Local4)
			}
			case (129) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 32, f0bc, 129}
				Store(Refof(f0bc), Local3)
				Store(Refof(g008), Local4)
			}
			case (256) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, AnyAcc, Lock, Preserve) {
					, 32, f0bd, 256}
				Store(Refof(f0bd), Local3)
				Store(Refof(g009), Local4)
			}
			case (1023) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 32, f0be, 1023}
				Store(Refof(f0be), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1983) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, Lock, Preserve) {
					, 32, f0bf, 1983}
				Store(Refof(f0bf), Local3)
				Store(Refof(g00b), Local4)
			}
			default {
				err(arg0, z145, 89, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (33) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, Lock, Preserve) {
					, 33, f0c0, 1}
				Store(Refof(f0c0), Local3)
				Store(Refof(g00c), Local4)
			}
			case (6) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 33, f0c1, 6}
				Store(Refof(f0c1), Local3)
				Store(Refof(g00d), Local4)
			}
			case (7) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, AnyAcc, Lock, Preserve) {
					, 33, f0c2, 7}
				Store(Refof(f0c2), Local3)
				Store(Refof(g00e), Local4)
			}
			case (8) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 33, f0c3, 8}
				Store(Refof(f0c3), Local3)
				Store(Refof(g000), Local4)
			}
			case (9) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					, 33, f0c4, 9}
				Store(Refof(f0c4), Local3)
				Store(Refof(g001), Local4)
			}
			case (31) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 33, f0c5, 31}
				Store(Refof(f0c5), Local3)
				Store(Refof(g002), Local4)
			}
			case (32) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, AnyAcc, Lock, Preserve) {
					, 33, f0c6, 32}
				Store(Refof(f0c6), Local3)
				Store(Refof(g003), Local4)
			}
			case (33) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 33, f0c7, 33}
				Store(Refof(f0c7), Local3)
				Store(Refof(g004), Local4)
			}
			case (63) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, AnyAcc, Lock, Preserve) {
					, 33, f0c8, 63}
				Store(Refof(f0c8), Local3)
				Store(Refof(g005), Local4)
			}
			case (64) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 33, f0c9, 64}
				Store(Refof(f0c9), Local3)
				Store(Refof(g006), Local4)
			}
			case (65) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, Lock, Preserve) {
					, 33, f0ca, 65}
				Store(Refof(f0ca), Local3)
				Store(Refof(g007), Local4)
			}
			case (69) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 33, f0cb, 69}
				Store(Refof(f0cb), Local3)
				Store(Refof(g008), Local4)
			}
			case (129) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, AnyAcc, Lock, Preserve) {
					, 33, f0cc, 129}
				Store(Refof(f0cc), Local3)
				Store(Refof(g009), Local4)
			}
			case (256) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 33, f0cd, 256}
				Store(Refof(f0cd), Local3)
				Store(Refof(g00a), Local4)
			}
			case (1023) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, Lock, Preserve) {
					, 33, f0ce, 1023}
				Store(Refof(f0ce), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1983) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 33, f0cf, 1983}
				Store(Refof(f0cf), Local3)
				Store(Refof(g00c), Local4)
			}
			default {
				err(arg0, z145, 90, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (63) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 63, f0d0, 1}
				Store(Refof(f0d0), Local3)
				Store(Refof(g00d), Local4)
			}
			case (6) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, AnyAcc, Lock, Preserve) {
					, 63, f0d1, 6}
				Store(Refof(f0d1), Local3)
				Store(Refof(g00e), Local4)
			}
			case (7) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 63, f0d2, 7}
				Store(Refof(f0d2), Local3)
				Store(Refof(g000), Local4)
			}
			case (8) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					, 63, f0d3, 8}
				Store(Refof(f0d3), Local3)
				Store(Refof(g001), Local4)
			}
			case (9) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 63, f0d4, 9}
				Store(Refof(f0d4), Local3)
				Store(Refof(g002), Local4)
			}
			case (31) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, AnyAcc, Lock, Preserve) {
					, 63, f0d5, 31}
				Store(Refof(f0d5), Local3)
				Store(Refof(g003), Local4)
			}
			case (32) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 63, f0d6, 32}
				Store(Refof(f0d6), Local3)
				Store(Refof(g004), Local4)
			}
			case (33) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, AnyAcc, Lock, Preserve) {
					, 63, f0d7, 33}
				Store(Refof(f0d7), Local3)
				Store(Refof(g005), Local4)
			}
			case (63) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 63, f0d8, 63}
				Store(Refof(f0d8), Local3)
				Store(Refof(g006), Local4)
			}
			case (64) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, Lock, Preserve) {
					, 63, f0d9, 64}
				Store(Refof(f0d9), Local3)
				Store(Refof(g007), Local4)
			}
			case (65) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 63, f0da, 65}
				Store(Refof(f0da), Local3)
				Store(Refof(g008), Local4)
			}
			case (69) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, AnyAcc, Lock, Preserve) {
					, 63, f0db, 69}
				Store(Refof(f0db), Local3)
				Store(Refof(g009), Local4)
			}
			case (129) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 63, f0dc, 129}
				Store(Refof(f0dc), Local3)
				Store(Refof(g00a), Local4)
			}
			case (256) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, Lock, Preserve) {
					, 63, f0dd, 256}
				Store(Refof(f0dd), Local3)
				Store(Refof(g00b), Local4)
			}
			case (1023) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 63, f0de, 1023}
				Store(Refof(f0de), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1983) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, AnyAcc, Lock, Preserve) {
					, 63, f0df, 1983}
				Store(Refof(f0df), Local3)
				Store(Refof(g00d), Local4)
			}
			default {
				err(arg0, z145, 91, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (64) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, AnyAcc, Lock, Preserve) {
					, 64, f0e0, 1}
				Store(Refof(f0e0), Local3)
				Store(Refof(g00e), Local4)
			}
			case (6) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 64, f0e1, 6}
				Store(Refof(f0e1), Local3)
				Store(Refof(g000), Local4)
			}
			case (7) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					, 64, f0e2, 7}
				Store(Refof(f0e2), Local3)
				Store(Refof(g001), Local4)
			}
			case (8) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 64, f0e3, 8}
				Store(Refof(f0e3), Local3)
				Store(Refof(g002), Local4)
			}
			case (9) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, AnyAcc, Lock, Preserve) {
					, 64, f0e4, 9}
				Store(Refof(f0e4), Local3)
				Store(Refof(g003), Local4)
			}
			case (31) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 64, f0e5, 31}
				Store(Refof(f0e5), Local3)
				Store(Refof(g004), Local4)
			}
			case (32) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, AnyAcc, Lock, Preserve) {
					, 64, f0e6, 32}
				Store(Refof(f0e6), Local3)
				Store(Refof(g005), Local4)
			}
			case (33) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 64, f0e7, 33}
				Store(Refof(f0e7), Local3)
				Store(Refof(g006), Local4)
			}
			case (63) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, Lock, Preserve) {
					, 64, f0e8, 63}
				Store(Refof(f0e8), Local3)
				Store(Refof(g007), Local4)
			}
			case (64) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 64, f0e9, 64}
				Store(Refof(f0e9), Local3)
				Store(Refof(g008), Local4)
			}
			case (65) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, AnyAcc, Lock, Preserve) {
					, 64, f0ea, 65}
				Store(Refof(f0ea), Local3)
				Store(Refof(g009), Local4)
			}
			case (69) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 64, f0eb, 69}
				Store(Refof(f0eb), Local3)
				Store(Refof(g00a), Local4)
			}
			case (129) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, Lock, Preserve) {
					, 64, f0ec, 129}
				Store(Refof(f0ec), Local3)
				Store(Refof(g00b), Local4)
			}
			case (256) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 64, f0ed, 256}
				Store(Refof(f0ed), Local3)
				Store(Refof(g00c), Local4)
			}
			case (1023) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, AnyAcc, Lock, Preserve) {
					, 64, f0ee, 1023}
				Store(Refof(f0ee), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1983) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					, 64, f0ef, 1983}
				Store(Refof(f0ef), Local3)
				Store(Refof(g00e), Local4)
			}
			default {
				err(arg0, z145, 92, 0, 0, arg2, arg3)
				return
			}
		}
	}
	case (65) {
		switch(ToInteger (arg3)) {
			case (1) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(8), , 1, f0f0, 1}
				Store(Refof(f0f0), Local3)
				Store(Refof(g000), Local4)
			}
			case (6) {
				Store(1, Local2)
				BankField(OPR0, BNK0, 1, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0f1, 6}
				Store(Refof(f0f1), Local3)
				Store(Refof(g001), Local4)
			}
			case (7) {
				Store(2, Local2)
				BankField(OPR0, BNK0, 2, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(8), , 1, f0f2, 7}
				Store(Refof(f0f2), Local3)
				Store(Refof(g002), Local4)
			}
			case (8) {
				Store(3, Local2)
				BankField(OPR0, BNK0, 3, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0f3, 8}
				Store(Refof(f0f3), Local3)
				Store(Refof(g003), Local4)
			}
			case (9) {
				Store(4, Local2)
				BankField(OPR0, BNK0, 4, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(8), , 1, f0f4, 9}
				Store(Refof(f0f4), Local3)
				Store(Refof(g004), Local4)
			}
			case (31) {
				Store(5, Local2)
				BankField(OPR0, BNK0, 5, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0f5, 31}
				Store(Refof(f0f5), Local3)
				Store(Refof(g005), Local4)
			}
			case (32) {
				Store(6, Local2)
				BankField(OPR0, BNK0, 6, AnyAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(8), , 1, f0f6, 32}
				Store(Refof(f0f6), Local3)
				Store(Refof(g006), Local4)
			}
			case (33) {
				Store(7, Local2)
				BankField(OPR0, BNK0, 7, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0f7, 33}
				Store(Refof(f0f7), Local3)
				Store(Refof(g007), Local4)
			}
			case (63) {
				Store(8, Local2)
				BankField(OPR0, BNK0, 8, ByteAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(8), , 1, f0f8, 63}
				Store(Refof(f0f8), Local3)
				Store(Refof(g008), Local4)
			}
			case (64) {
				Store(9, Local2)
				BankField(OPR0, BNK0, 9, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0f9, 64}
				Store(Refof(f0f9), Local3)
				Store(Refof(g009), Local4)
			}
			case (65) {
				Store(63, Local2)
				BankField(OPR0, BNK0, 63, WordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(8), , 1, f0fa, 65}
				Store(Refof(f0fa), Local3)
				Store(Refof(g00a), Local4)
			}
			case (69) {
				Store(64, Local2)
				BankField(OPR0, BNK0, 64, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0fb, 69}
				Store(Refof(f0fb), Local3)
				Store(Refof(g00b), Local4)
			}
			case (129) {
				Store(127, Local2)
				BankField(OPR0, BNK0, 127, DWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(8), , 1, f0fc, 129}
				Store(Refof(f0fc), Local3)
				Store(Refof(g00c), Local4)
			}
			case (256) {
				Store(128, Local2)
				BankField(OPR0, BNK0, 128, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0fd, 256}
				Store(Refof(f0fd), Local3)
				Store(Refof(g00d), Local4)
			}
			case (1023) {
				Store(255, Local2)
				BankField(OPR0, BNK0, 255, QWordAcc, Lock, Preserve) {
					AccessAs(AnyAcc),
					Offset(8), , 1, f0fe, 1023}
				Store(Refof(f0fe), Local3)
				Store(Refof(g00e), Local4)
			}
			case (1983) {
				Store(0, Local2)
				BankField(OPR0, BNK0, 0, AnyAcc, Lock, Preserve) {
					Offset(8), , 1, f0ff, 1983}
				Store(Refof(f0ff), Local3)
				Store(Refof(g000), Local4)
			}
			default {
				err(arg0, z145, 93, 0, 0, arg2, arg3)
				return
			}
		}
	}
	default {
		err(arg0, z145, 94, 0, 0, arg2, arg3)
		return}
	}

	Store(2, Index(fcp0, 0))
	Store(Refof(BNK0), Index(fcp0, 1))
	Store(Local2, Index(fcp0, 2))
	m72d(arg0, Local3, arg2, arg3, arg4, arg5, Local4)
	Store(0, Index(fcp0, 0))
}

// Splitting of BankFields
// m7c6(CallChain)
Method(m7c6, 1, Serialized)
{
	OperationRegion(OPR0, SystemIO, 1000, 0x101)

	Store("TEST: m7c6, Check Splitting of BankFields", Debug)

	Concatenate(arg0, "-m7c6", arg0)

	m7e0(arg0, OPR0, 0x4)
	m7e1(arg0, OPR0, 0x400)
	m7e2(arg0, OPR0, 0x4000)
	m7e3(arg0, OPR0, 0xf000)
	m7e4(arg0, OPR0, 0xf004)
	m7e5(arg0, OPR0, 0xf400)
	m7e6(arg0, OPR0, 0xff00)
	m7e7(arg0, OPR0, 0xfff0)
	m7e8(arg0, OPR0, 0xffff)
	m7e9(arg0, OPR0, 0x4)
}

// Create BankFields that spans the same bits
// and check possible inconsistence, 0-bit offset.
// m7e0(CallChain, OpRegion, BankNum)
Method(m7e0, 3, Serialized)
{
	OperationRegion(OPRm, 0xff, 0x100, 0x08)
	OperationRegion(OPRn, SystemIO, 0x10, 0x02)

	Field(OPRn, ByteAcc, NoLock, Preserve) {
		BNK0, 16,
	}

	Concatenate(arg0, "-m7e0", arg0)

	CopyObject(arg1, OPRm)

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 0, // 0-bit offset
			BF00, 0x3}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 0,
			BF10, 0x1,
			BF11, 0x1,
			BF12, 0x1}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 0,
			BF20, 0x1,
			BF21, 0x2}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 0,
			BF30, 0x2,
			BF31, 0x1}

	Store(8, Local0)

	Store(Package(){BF10, BF11, BF12, BF20, BF21, BF30, BF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, BF00)

		if (y118) {
		} else {
			Store(BF10, Index(Local1, 0))
			Store(BF11, Index(Local1, 1))
			Store(BF12, Index(Local1, 2))
			Store(BF20, Index(Local1, 3))
			Store(BF21, Index(Local1, 4))
			Store(BF30, Index(Local1, 5))
			Store(BF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create BankFields that spans the same bits
// and check possible inconsistence, 1-bit offset.
// m7e1(CallChain, OpRegion, BankNum)
Method(m7e1, 3, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)
	OperationRegion(OPRn, SystemIO, 0x10, 0x02)

	Field(OPRn, ByteAcc, NoLock, Preserve) {
		BNK0, 16,
	}

	Concatenate(arg0, "-m7e1", arg0)

	CopyObject(arg1, OPRm)

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 1, // 1-bit offset
			BF00, 0x3}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 1,
			BF10, 0x1,
			BF11, 0x1,
			BF12, 0x1}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 1,
			BF20, 0x1,
			BF21, 0x2}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 1,
			BF30, 0x2,
			BF31, 0x1}

	Store(8, Local0)

	Store(Package(){BF10, BF11, BF12, BF20, BF21, BF30, BF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, BF00)

		if (y118) {
		} else {
			Store(BF10, Index(Local1, 0))
			Store(BF11, Index(Local1, 1))
			Store(BF12, Index(Local1, 2))
			Store(BF20, Index(Local1, 3))
			Store(BF21, Index(Local1, 4))
			Store(BF30, Index(Local1, 5))
			Store(BF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create BankFields that spans the same bits
// and check possible inconsistence, 2-bit offset.
// m7e2(CallChain, OpRegion, BankNum)
Method(m7e2, 3, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)
	OperationRegion(OPRn, SystemIO, 0x10, 0x02)

	Field(OPRn, ByteAcc, NoLock, Preserve) {
		BNK0, 16,
	}

	Concatenate(arg0, "-m7e2", arg0)

	CopyObject(arg1, OPRm)

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 2, // 2-bit offset
			BF00, 0x3}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 2,
			BF10, 0x1,
			BF11, 0x1,
			BF12, 0x1}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 2,
			BF20, 0x1,
			BF21, 0x2}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 2,
			BF30, 0x2,
			BF31, 0x1}

	Store(8, Local0)

	Store(Package(){BF10, BF11, BF12, BF20, BF21, BF30, BF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, BF00)

		if (y118) {
		} else {
			Store(BF10, Index(Local1, 0))
			Store(BF11, Index(Local1, 1))
			Store(BF12, Index(Local1, 2))
			Store(BF20, Index(Local1, 3))
			Store(BF21, Index(Local1, 4))
			Store(BF30, Index(Local1, 5))
			Store(BF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create BankFields that spans the same bits
// and check possible inconsistence, 3-bit offset.
// m7e3(CallChain, OpRegion, BankNum)
Method(m7e3, 3, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)
	OperationRegion(OPRn, SystemIO, 0x10, 0x02)

	Field(OPRn, ByteAcc, NoLock, Preserve) {
		BNK0, 16,
	}

	Concatenate(arg0, "-m7e3", arg0)

	CopyObject(arg1, OPRm)

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 3, // 3-bit offset
			BF00, 0x3}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 3,
			BF10, 0x1,
			BF11, 0x1,
			BF12, 0x1}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 3,
			BF20, 0x1,
			BF21, 0x2}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 3,
			BF30, 0x2,
			BF31, 0x1}

	Store(8, Local0)

	Store(Package(){BF10, BF11, BF12, BF20, BF21, BF30, BF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, BF00)

		if (y118) {
		} else {
			Store(BF10, Index(Local1, 0))
			Store(BF11, Index(Local1, 1))
			Store(BF12, Index(Local1, 2))
			Store(BF20, Index(Local1, 3))
			Store(BF21, Index(Local1, 4))
			Store(BF30, Index(Local1, 5))
			Store(BF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create BankFields that spans the same bits
// and check possible inconsistence, 4-bit offset.
// m7e4(CallChain, OpRegion, BankNum)
Method(m7e4, 3, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)
	OperationRegion(OPRn, SystemIO, 0x10, 0x02)

	Field(OPRn, ByteAcc, NoLock, Preserve) {
		BNK0, 16,
	}

	Concatenate(arg0, "-m7e4", arg0)

	CopyObject(arg1, OPRm)

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 4, // 4-bit offset
			BF00, 0x3}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 4,
			BF10, 0x1,
			BF11, 0x1,
			BF12, 0x1}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 4,
			BF20, 0x1,
			BF21, 0x2}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 4,
			BF30, 0x2,
			BF31, 0x1}

	Store(8, Local0)

	Store(Package(){BF10, BF11, BF12, BF20, BF21, BF30, BF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, BF00)

		if (y118) {
		} else {
			Store(BF10, Index(Local1, 0))
			Store(BF11, Index(Local1, 1))
			Store(BF12, Index(Local1, 2))
			Store(BF20, Index(Local1, 3))
			Store(BF21, Index(Local1, 4))
			Store(BF30, Index(Local1, 5))
			Store(BF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create BankFields that spans the same bits
// and check possible inconsistence, 5-bit offset.
// m7e5(CallChain, OpRegion, BankNum)
Method(m7e5, 3, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)
	OperationRegion(OPRn, SystemIO, 0x10, 0x02)

	Field(OPRn, ByteAcc, NoLock, Preserve) {
		BNK0, 16,
	}

	Concatenate(arg0, "-m7e5", arg0)

	CopyObject(arg1, OPRm)

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 5, // 5-bit offset
			BF00, 0x3}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 5,
			BF10, 0x1,
			BF11, 0x1,
			BF12, 0x1}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 5,
			BF20, 0x1,
			BF21, 0x2}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 5,
			BF30, 0x2,
			BF31, 0x1}

	Store(8, Local0)

	Store(Package(){BF10, BF11, BF12, BF20, BF21, BF30, BF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, BF00)

		if (y118) {
		} else {
			Store(BF10, Index(Local1, 0))
			Store(BF11, Index(Local1, 1))
			Store(BF12, Index(Local1, 2))
			Store(BF20, Index(Local1, 3))
			Store(BF21, Index(Local1, 4))
			Store(BF30, Index(Local1, 5))
			Store(BF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create BankFields that spans the same bits
// and check possible inconsistence, 6-bit offset.
// m7e6(CallChain, OpRegion, BankNum)
Method(m7e6, 3, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)
	OperationRegion(OPRn, SystemIO, 0x10, 0x02)

	Field(OPRn, ByteAcc, NoLock, Preserve) {
		BNK0, 16,
	}

	Concatenate(arg0, "-m7e6", arg0)

	CopyObject(arg1, OPRm)

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 6, // 6-bit offset
			BF00, 0x3}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 6,
			BF10, 0x1,
			BF11, 0x1,
			BF12, 0x1}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 6,
			BF20, 0x1,
			BF21, 0x2}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 6,
			BF30, 0x2,
			BF31, 0x1}

	Store(8, Local0)

	Store(Package(){BF10, BF11, BF12, BF20, BF21, BF30, BF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, BF00)

		if (y118) {
		} else {
			Store(BF10, Index(Local1, 0))
			Store(BF11, Index(Local1, 1))
			Store(BF12, Index(Local1, 2))
			Store(BF20, Index(Local1, 3))
			Store(BF21, Index(Local1, 4))
			Store(BF30, Index(Local1, 5))
			Store(BF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create BankFields that spans the same bits
// and check possible inconsistence, 7-bit offset.
// m7e7(CallChain, OpRegion, BankNum)
Method(m7e7, 3, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)
	OperationRegion(OPRn, SystemIO, 0x10, 0x02)

	Field(OPRn, ByteAcc, NoLock, Preserve) {
		BNK0, 16,
	}

	Concatenate(arg0, "-m7e7", arg0)

	CopyObject(arg1, OPRm)

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 7, // 7-bit offset
			BF00, 0x3}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 7,
			BF10, 0x1,
			BF11, 0x1,
			BF12, 0x1}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 7,
			BF20, 0x1,
			BF21, 0x2}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 7,
			BF30, 0x2,
			BF31, 0x1}

	Store(8, Local0)

	Store(Package(){BF10, BF11, BF12, BF20, BF21, BF30, BF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, BF00)

		if (y118) {
		} else {
			Store(BF10, Index(Local1, 0))
			Store(BF11, Index(Local1, 1))
			Store(BF12, Index(Local1, 2))
			Store(BF20, Index(Local1, 3))
			Store(BF21, Index(Local1, 4))
			Store(BF30, Index(Local1, 5))
			Store(BF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create BankFields that spans the same bits
// and check possible inconsistence, 8-bit offset.
// m7e8(CallChain, OpRegion, BankNum)
Method(m7e8, 3, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x08)
	OperationRegion(OPRn, SystemIO, 0x10, 0x02)

	Field(OPRn, ByteAcc, NoLock, Preserve) {
		BNK0, 16,
	}

	Concatenate(arg0, "-m7e8", arg0)

	CopyObject(arg1, OPRm)

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 8, // 8-bit offset
			BF00, 0x3}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 8,
			BF10, 0x1,
			BF11, 0x1,
			BF12, 0x1}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 8,
			BF20, 0x1,
			BF21, 0x2}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 8,
			BF30, 0x2,
			BF31, 0x1}

	Store(8, Local0)

	Store(Package(){BF10, BF11, BF12, BF20, BF21, BF30, BF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, BF00)

		if (y118) {
		} else {
			Store(BF10, Index(Local1, 0))
			Store(BF11, Index(Local1, 1))
			Store(BF12, Index(Local1, 2))
			Store(BF20, Index(Local1, 3))
			Store(BF21, Index(Local1, 4))
			Store(BF30, Index(Local1, 5))
			Store(BF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Create BankFields that spans the same bits
// and check possible inconsistence, 2046-bit offset.
// m7e9(CallChain, OpRegion, BankNum)
Method(m7e9, 3, Serialized)
{
	OperationRegion(OPRm, 0xff, 0, 0x101)
	OperationRegion(OPRn, SystemIO, 0x10, 0x02)

	Field(OPRn, ByteAcc, NoLock, Preserve) {
		BNK0, 16,
	}

	Concatenate(arg0, "-m7e9", arg0)

	CopyObject(arg1, OPRm)

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 2046, // 2046-bit offset
			BF00, 0x3}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 2046,
			BF10, 0x1,
			BF11, 0x1,
			BF12, 0x1}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 2046,
			BF20, 0x1,
			BF21, 0x2}

	BankField(OPRm, BNK0, arg2, ByteAcc, NoLock, Preserve) {
			, 2046,
			BF30, 0x2,
			BF31, 0x1}

	Store(8, Local0)

	Store(Package(){BF10, BF11, BF12, BF20, BF21, BF30, BF31}, Local1)

	while(Local0) {
		Decrement(Local0)

		Store(Local0, BF00)

		if (y118) {
		} else {
			Store(BF10, Index(Local1, 0))
			Store(BF11, Index(Local1, 1))
			Store(BF12, Index(Local1, 2))
			Store(BF20, Index(Local1, 3))
			Store(BF21, Index(Local1, 4))
			Store(BF30, Index(Local1, 5))
			Store(BF31, Index(Local1, 6))
		}

		m72a(arg0, Local0, Local1)
	}
}

// Check non-constant Bank value
Method(m7c7, 1, Serialized)
{
	Field (OPRi, ByteAcc, NoLock, Preserve) {
		bnk0, 8
	}

	Name(BVAL, 2)

	Method(CHCK, 3)
	{
		Store(Refof(arg1), Local0)

		// Write

		Store(0xff, bnk0)
		m7bf(arg0, bnk0, 0xff, Add(arg2, 0))

		Store(0x67, Derefof(Local0))
		m7bf(arg0, bnk0, 2, Add(arg2, 1))

		// Read

		Store(0xff, bnk0)
		m7bf(arg0, bnk0, 0xff, Add(arg2, 2))

		Store(Derefof(arg1), Local1)
		m7bf(arg0, Local1, 0x67, Add(arg2, 3))
		m7bf(arg0, bnk0, 2, Add(arg2, 4))
	}

	// ArgX
	Method(m000, 2, Serialized)
	{
		BankField (OPRj, bnk0, arg1, ByteAcc, NoLock, Preserve) {
			Offset(8),
			bf00, 8,
		}

		CHCK(arg0, Refof(bf00), 95)
	}

	// Named
	Method(m001, 1, Serialized)
	{
		BankField (OPRj, bnk0, BVAL, ByteAcc, NoLock, Preserve) {
			Offset(8),
			bf00, 8,
		}

		CHCK(arg0, Refof(bf00), 100)
	}

	// LocalX
	Method(m002, 1, Serialized)
	{
		Store(BVAL, Local0)

		BankField (OPRj, bnk0, Local0, ByteAcc, NoLock, Preserve) {
			Offset(8),
			bf00, 8,
		}

		CHCK(arg0, Refof(bf00), 105)
	}

	// Expression
	Method(m003, 1, Serialized)
	{
		Store(1, Local0)

		BankField (OPRj, bnk0, Add(Local0, 1), ByteAcc, NoLock, Preserve) {
			Offset(8),
			bf00, 8,
		}

		CHCK(arg0, Refof(bf00), 110)
	}

	Concatenate(arg0, "-m7c7", arg0)

	m000(arg0, 2)
	m001(arg0)
	m002(arg0)
	m003(arg0)
}

// Check non-Integer Bank value
Method(m7c8, 1, Serialized)
{
	Field (OPRi, ByteAcc, NoLock, Preserve) {
		bnk0, 8
	}

	Name(val0, 2)
	Name(valb, Buffer(1){2})
	Name(vals, "2")

	BankField (OPRj, bnk0, 2, ByteAcc, NoLock, Preserve) {
		Offset(8), bf00, 32,
	}

    //
    // BUG: ToInteger should not be necessary. The buffer and string
    // arguments should be implicitly converted to integers.
    //
	BankField (OPRj, bnk0, ToInteger (valb), ByteAcc, NoLock, Preserve) {
		Offset(8), bf01, 32,
	}

	BankField (OPRj, bnk0, ToInteger (vals), ByteAcc, NoLock, Preserve) {
		Offset(8), bf02, 32,
	}

	Name(i000, 0x12345678)

	Method(m000, 3, Serialized)
	{
		Store(1, Local0)

		BankField (OPRj, bnk0, arg1, ByteAcc, NoLock, Preserve) {
			Offset(8), bf03, 32,
		}

		if (LNotEqual(bf03, i000)) {
			err(arg0, z145, arg2, 0, 0, bf03, i000)
		}
	}

	Concatenate(arg0, "-m7c8", arg0)

	Store(i000, bf00)

	if (LNotEqual(bf00, i000)) {
		err(arg0, z145, 115, 0, 0, bf00, i000)
	}
	if (LNotEqual(bf01, i000)) {
		err(arg0, z145, 116, 0, 0, bf00, i000)
	}
	if (LNotEqual(bf02, i000)) {
		err(arg0, z145, 117, 0, 0, bf00, i000)
	}

    //
    // BUG: ToInteger should not be necessary. The buffer and string
    // arguments should be implicitly converted to integers.
    //
	m000(arg0, val0, 118)
	m000(arg0, ToInteger (valb), 119)
	m000(arg0, ToInteger (vals), 120)
}

// Run-method
Method(BFC0,, Serialized)
{
	Name(ts, "BFC0")

	// Simple BankField test
	SRMT("m7c0")
	m7c0(ts)

	// Check BankField access: ByteAcc, NoLock, Preserve
	SRMT("m7c1")
	if (y192) {
		m7c1(ts)
	} else {
		BLCK()
	}

	// Check BankField access: WordAcc, NoLock, WriteAsOnes
	SRMT("m7c2")
	if (y192) {
		m7c2(ts)
	} else {
		BLCK()
	}

	// Check BankField access: DWordAcc, NoLock, WriteAsZeros
	SRMT("m7c3")
	if (y192) {
		m7c3(ts)
	} else {
		BLCK()
	}

	// Check BankField access: QWordAcc, NoLock, Preserve
	SRMT("m7c4")
	if (y192) {
		m7c4(ts)
	} else {
		BLCK()
	}

	// Check BankField access: AnyAcc, Lock, Preserve
	SRMT("m7c5")
	if (y192) {
		m7c5(ts)
	} else {
		BLCK()
	}

	// Splitting of BankFields
	SRMT("m7c6")
	if (y192) {
		m7c6(ts)
	} else {
		BLCK()
	}

	// Non-constant Bank value
	SRMT("m7c7")
	if (y178) {
		m7c7(ts)
	} else {
		BLCK()
	}

	// Non-Integer Bank value
	SRMT("m7c8")
	if (y178) {
		m7c8(ts)
	} else {
		BLCK()
	}
}
