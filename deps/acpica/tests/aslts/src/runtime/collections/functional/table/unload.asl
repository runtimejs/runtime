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
 * UnLoad ASL operator functionality
 */

/*
 * This sub-test is intended to comprehensively verify
 * the Unload ASL operator functionality.
 *
 * Performs a run-time unload of a Definition Block that was
 * loaded using a Load (and LoadTable) term.
 *
 * The overall functionality of the Unload Objects is indirectly
 * verified by other Table management tests as far as Unload is
 * needed to perform cleanup and check effectiveness of Load and
 * LoadTable operators.
 *
 *    17.5.126   Unload (Unload Definition Block)
 *    Syntax
 * Unload (Handle)
 *
 * On testing the following issues should be covered (actually in the tests
 * of loading except for the exceptional conditions ones):
 *
 * - successful execution of the Unload operator for the specified DDBHandle
 *   obtained through loading of a SSDT from a proper location,
 *
 * - successful execution of the Unload operator for the specified DDBHandle
 *   obtained through LoadTable operator,
 *
 * - the Handle parameter of the Unload can be specified as Named Object,
 *   LocalX, ArgX, Derefof (to Index or RefOf reference), and Method call,
 *
 * - all namespace objects created as a result of the corresponding Load
 *   operation are removed from the namespace,
 *
 * - unloading a number of different SSDTs,
 *
 * - Load/UnLoad processing can be done with the same table many times,
 *
 * - exceptional conditions caused by inappropriate data:
 *   = the parameter of the UnLoad operator is not of DDBHandle type,
 *   = execute UnLoad operator with the same DDBHandle repeatedly,
 *   = the operand of UnLoad operator is absent.
 *
 * Can not be tested following issues:
 * - unloading a SSDT to be a synchronous operation ("the control methods
 *   defined in the Definition Block are not executed during load time")
 */

Name(z175, 175)

Device(DTM1) {

	// Different Sources to specify DDBHandle for UnLoad.
	// Most of them (Named Object, LocalX, ArgX, Derefof)
	// are checked in load.asl

	// DDBHandle returned by Method call
	Method(tst0, 1, Serialized)
	{
		Name(HI0, 0)

		Method(m000) {Return (HI0)}

		Concatenate(arg0, "-tst0", arg0)

		Store(\DTM0.BUF0, \DTM0.RFU0)

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z175, 0x000, 0, 0, "\\SSS0", 1)
			return
		}

		// Modify Revision field of SSDT
		Store(Add(\DTM0.CREV, 1), \DTM0.CREV)

		// Recalculate and save CheckSum
		Store(\DTM0.RFU0, Local0)
		Store(Add(\DTM0.SUM, \DTM0.CHSM(Local0, SizeOf (Local0))), \DTM0.SUM)

		if (CH03(arg0, z175, 0x001, 0, 0)) {
			return
		}

		Load(\DTM0.RFU0, HI0)

		if (CH03(arg0, z175, 0x002, 0, 0)) {
			return
		}

		Store("Table Loaded", Debug)

		if (y260) {
			Store(ObjectType(HI0), Local1)
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z175, 0x003, 0, 0, Local1, c017)
			}
		}

		// Check the new Object appears

		if (CondRefof(\SSS0, Local0)) {
		} else {
			err(arg0, z175, 0x004, 0, 0, "\\SSS0", 0)
		}

		Store(ObjectType(Local0), Local1)
		if (LNotEqual(Local1, c010)) { // Method
			err(arg0, z175, 0x005, 0, 0, Local1, c010)
		} else {
			Store(\SSS0(), Local0)
			if (CH03(arg0, z175, 0x006, "\\SSS0", 1)) {
				return
			}
			if (LNotEqual("\\SSS0", Local0)) {
				err(arg0, z175, 0x007, 0, 0, Local0, "\\SSS0")
			}
		}

		// UnLoad operator execution
		UnLoad(m000())

		if (CH03(arg0, z175, 0x008, 0, 0)) {
			return
		}

		Store("Table Unloaded", Debug)

		if (CondRefof(\SSS0, Local0)) {
			err(arg0, z175, 0x009, 0, 0, "\\SSS0", 1)
		}
		return
	}

	// All namespace objects created as a result of the corresponding
	// Load operation are absent in the namespace after UnLoad
	Method(tst1, 1, Serialized)
	{
		Name(DDB0, 0)
		Name(DDB1, 0)

		Method(m000, 4)
		{
			Concatenate(arg0, "-m000.", arg0)
			Concatenate(arg0, arg1, arg0)

			Store(ObjectType(arg2), Local0)
			if (LNotEqual(arg3, Local0)) {
				err(arg0, z175, 0x010, 0, 0, Local0, arg3)
				return (1)
			}

			return (0)
		}

		Method(m001, 1)
		{
			Concatenate(arg0, "-m001", arg0)

			// Integer
			if (CondRefof(\AUXD.INT0, Local0)) {
				err(arg0, z175, 0x011, 0, 0, "\\AUXD.INT0", 1)
				return (1)
			}

			// String
			if (CondRefof(\AUXD.STR0, Local0)) {
				err(arg0, z175, 0x012, 0, 0, "\\AUXD.STR0", 1)
				return (1)
			}

			// Buffer
			if (CondRefof(\AUXD.BUF0, Local0)) {
				err(arg0, z175, 0x013, 0, 0, "\\AUXD.BUF0", 1)
				return (1)
			}

			// Package
			if (CondRefof(\AUXD.PAC0, Local0)) {
				err(arg0, z175, 0x014, 0, 0, "\\AUXD.PAC0", 1)
				return (1)
			}

			// Field Unit
			if (CondRefof(\AUXD.FLU0, Local0)) {
				err(arg0, z175, 0x015, 0, 0, "\\AUXD.FLU0", 1)
				return (1)
			}

			// Device
			if (CondRefof(\AUXD.DEV0, Local0)) {
				err(arg0, z175, 0x016, 0, 0, "\\AUXD.DEV0", 1)
				return (1)
			}

			// Event
			if (CondRefof(\AUXD.EVE0, Local0)) {
				err(arg0, z175, 0x017, 0, 0, "\\AUXD.EVE0", 1)
				return (1)
			}

			// Method
			if (CondRefof(\AUXD.MMM0, Local0)) {
				err(arg0, z175, 0x018, 0, 0, "\\AUXD.MMM0", 1)
				return (1)
			}

			// Mutex
			if (CondRefof(\AUXD.MTX0, Local0)) {
				err(arg0, z175, 0x019, 0, 0, "\\AUXD.MTX0", 1)
				return (1)
			}

			// OpRegion
			if (CondRefof(\AUXD.OPR0, Local0)) {
				err(arg0, z175, 0x01a, 0, 0, "\\AUXD.OPR0", 1)
				return (1)
			}

			// Power Resource
			if (CondRefof(\AUXD.PWR0, Local0)) {
				err(arg0, z175, 0x01b, 0, 0, "\\AUXD.PWR0", 1)
				return (1)
			}

			// Processor
			if (CondRefof(\AUXD.CPU0, Local0)) {
				err(arg0, z175, 0x01c, 0, 0, "\\AUXD.CPU0", 1)
				return (1)
			}

			// Thermal Zone
			if (CondRefof(\AUXD.TZN0, Local0)) {
				err(arg0, z175, 0x01d, 0, 0, "\\AUXD.TZN0", 1)
				return (1)
			}

			// Buffer Field
			if (CondRefof(\AUXD.BFL0, Local0)) {
				err(arg0, z175, 0x01e, 0, 0, "\\AUXD.BFL0", 1)
				return (1)
			}

			return (0)
		}

		Concatenate(arg0, "-tst1", arg0)

		// Check absence of the auxiliary table Objects before Load
		if (m001(Concatenate(arg0, ".before"))) {
			return (1)
		}

		// Load auxiliary table
		Store(\DTM0.BUF3, \DTM0.RFU3)
		Load(\DTM0.RFU3, DDB0)

		if (CH03(arg0, z175, 0x01f, 0, 0)) {
			return (1)
		}

		// Integer
		if (CondRefof(\AUXD.INT0, Local0)) {
			m000(arg0, "int", Local0, c009)
		} else {
			err(arg0, z175, 0x021, 0, 0, "\\AUXD.INT0", 0)
		}

		// String
		if (CondRefof(\AUXD.STR0, Local0)) {
			m000(arg0, "str", Local0, c00a)
		} else {
			err(arg0, z175, 0x022, 0, 0, "\\AUXD.STR0", 0)
		}

		// Buffer
		if (CondRefof(\AUXD.BUF0, Local0)) {
			m000(arg0, "buf", Local0, c00b)
		} else {
			err(arg0, z175, 0x023, 0, 0, "\\AUXD.BUF0", 0)
		}

		// Package
		if (y286) {
			if (CondRefof(\AUXD.PAC0, Local0)) {
				m000(arg0, "pac", Local0, c00c)
			} else {
				err(arg0, z175, 0x024, 0, 0, "\\AUXD.PAC0", 0)
			}
		}

		// Field Unit
		if (CondRefof(\AUXD.FLU0, Local0)) {
			m000(arg0, "flu", Local0, c00d)
		} else {
			err(arg0, z175, 0x025, 0, 0, "\\AUXD.FLU0", 0)
		}

		// Device
		if (CondRefof(\AUXD.DEV0, Local0)) {
			m000(arg0, "dev", Local0, c00e)
		} else {
			err(arg0, z175, 0x026, 0, 0, "\\AUXD.DEV0", 0)
		}

		// Event
		if (CondRefof(\AUXD.EVE0, Local0)) {
			m000(arg0, "evt", Local0, c00f)
		} else {
			err(arg0, z175, 0x027, 0, 0, "\\AUXD.EVE0", 0)
		}

		// Method
		if (CondRefof(\AUXD.MMM0, Local0)) {
			m000(arg0, "met", Local0, c010)
		} else {
			err(arg0, z175, 0x028, 0, 0, "\\AUXD.MMM0", 0)
		}

		// Mutex
		if (CondRefof(\AUXD.MTX0, Local0)) {
			m000(arg0, "mtx", Local0, c011)
		} else {
			err(arg0, z175, 0x029, 0, 0, "\\AUXD.MTX0", 0)
		}

		// OpRegion
		if (CondRefof(\AUXD.OPR0, Local0)) {
			m000(arg0, "opr", Local0, c012)
		} else {
			err(arg0, z175, 0x02a, 0, 0, "\\AUXD.OPR0", 0)
		}

		// Power Resource
		if (CondRefof(\AUXD.PWR0, Local0)) {
			m000(arg0, "pwr", Local0, c013)
		} else {
			err(arg0, z175, 0x02b, 0, 0, "\\AUXD.PWR0", 0)
		}

		// Processor
		if (CondRefof(\AUXD.CPU0, Local0)) {
			m000(arg0, "cpu", Local0, c014)
		} else {
			err(arg0, z175, 0x02c, 0, 0, "\\AUXD.CPU0", 0)
		}

		// Thermal Zone
		if (CondRefof(\AUXD.TZN0, Local0)) {
			m000(arg0, "cpu", Local0, c015)
		} else {
			err(arg0, z175, 0x02d, 0, 0, "\\AUXD.TZN0", 0)
		}

		// Buffer Field
		if (CondRefof(\AUXD.BFL0, Local0)) {
			m000(arg0, "bfl", Local0, c016)
		} else {
			err(arg0, z175, 0x02e, 0, 0, "\\AUXD.BFL0", 0)
		}

		UnLoad(DDB0)

		CH03(arg0, z175, 0x02f, 0, 0)

		// Check absence of the auxiliary table Objects after UnLoad
		if (m001(Concatenate(arg0, ".after"))) {
			return (1)
		}

		return (0)
	}

	// Load/UnLoad processing can be done with the same table many times
	Method(tst2, 1)
	{
		Concatenate(arg0, "tst2.", arg0)

		Store(5, Local0)

		while (Local0) {
			if (tst1(Concatenate(arg0, Mid("0123456789", Local0, 1)))) {
				return (1)
			}
			Decrement(Local0)
		}

		return (0)
	}

	// Exceptions when the parameter of the UnLoad operator
	// is not of DDBHandle type
	Method(tst3, 1, Serialized)
	{
		Name(DDB0, 0)
		Name(DDB1, 0)

		Method(m000, 4)
		{
			Concatenate(arg0, "-m000.", arg0)
			Concatenate(arg0, arg1, arg0)

			Store(ObjectType(arg2), Local0)
			if (LNotEqual(arg3, Local0)) {
				err(arg0, z175, 0x031, 0, 0, Local0, arg3)
				return (1)
			}

			UnLoad(Derefof(arg2))
			CH04(arg0, 0, 47, z175, 0x032, 0, 0)	// AE_AML_OPERAND_TYPE

			return (0)
		}

		Concatenate(arg0, "-tst3", arg0)

		// Load auxiliary table
		Store(\DTM0.BUF3, \DTM0.RFU3)
		Load(\DTM0.RFU3, DDB0)

		if (CH03(arg0, z175, 0x033, 0, 0)) {
			return (1)
		}

		// Uninitialized
		if (0) {
			Store(0, Local1)
		}
		Store(ObjectType(Local1), Local0)
		if (LNotEqual(c008, Local0)) {
			err(arg0, z175, 0x034, 0, 0, Local0, c008)
		} else {
			UnLoad(Local1)
			if (SLCK) {
				CH04(arg0, 0, 47, z175, 0x035, 0, 0) // AE_AML_OPERAND_TYPE
			} else {
				CH04(arg0, 0, 49, z175, 0x035, 0, 0) // AE_AML_UNINITIALIZED_LOCAL
			}
		}

		// Integer
		m000(arg0, "int", Refof(\AUXD.INT0), c009)

		// String
		m000(arg0, "str", Refof(\AUXD.STR0), c00a)

		// Buffer
		m000(arg0, "buf", Refof(\AUXD.BUF0), c00b)

		// Package

		if (y286) {
			m000(arg0, "pac", Refof(\AUXD.PAC0), c00c)
		}

		Store(ObjectType(\AUXD.PAC0), Local0)
		if (LNotEqual(c00c, Local0)) {
			err(arg0, z175, 0x036, 0, 0, Local0, c00c)
		} else {
			UnLoad(\AUXD.PAC0)
			CH04(arg0, 0, 47, z175, 0x037, 0, 0) // AE_AML_OPERAND_TYPE
		}

		// Field Unit
		m000(arg0, "flu", Refof(\AUXD.FLU0), c00d)

		// Device
		Store(ObjectType(\AUXD.DEV0), Local0)
		if (LNotEqual(c00e, Local0)) {
			err(arg0, z175, 0x038, 0, 0, Local0, c00e)
		} else {
			UnLoad(\AUXD.DEV0)
			CH04(arg0, 0, 47, z175, 0x039, 0, 0) // AE_AML_OPERAND_TYPE
		}

		// Event
		m000(arg0, "evt", Refof(\AUXD.EVE0), c00f)

		// Method
		m000(arg0, "met", Refof(\AUXD.MMM0), c010)

		// Mutex
		m000(arg0, "mtx", Refof(\AUXD.MTX0), c011)

		// OpRegion
		m000(arg0, "opr", Refof(\AUXD.OPR0), c012)

		// Power Resource
		m000(arg0, "pwr", Refof(\AUXD.PWR0), c013)

		// Processor
		m000(arg0, "cpu", Refof(\AUXD.CPU0), c014)

		// Thermal Zone
		Store(ObjectType(\AUXD.TZN0), Local0)
		if (LNotEqual(c015, Local0)) {
			err(arg0, z175, 0x03a, 0, 0, Local0, c015)
		} else {
			UnLoad(\AUXD.TZN0)
			CH04(arg0, 0, 47, z175, 0x03b, 0, 0) // AE_AML_OPERAND_TYPE
		}

		// Buffer Field
		m000(arg0, "bfl", Refof(\AUXD.BFL0), c016)

		UnLoad(DDB0)

		CH03(arg0, z175, 0x03c, 0, 0)

		return (0)
	}

	// Exceptions when UnLoad is executed with the same DDBHandle repeatedly
	Method(tst4, 1, Serialized)
	{
		Name(DDB0, 0)
		Name(DDB1, 0)

		Concatenate(arg0, "-tst4", arg0)

		// Load auxiliary table
		Store(\DTM0.BUF3, \DTM0.RFU3)
		Load(\DTM0.RFU3, DDB0)

		if (CH03(arg0, z175, 0x03d, 0, 0)) {
			return (1)
		}

		// First Unload
		UnLoad(DDB0)

		if (CH03(arg0, z175, 0x03e, 0, 0)) {
			return (1)
		}

		Store(5, Local0)
		while (Local0) {

			// Any next
			UnLoad(DDB0)

			CH04(arg0, 0, 28, z175, 0x03f, 5, Local0) // AE_BAD_PARAMETER

			Decrement(Local0)
		}

		// Second DDBHandle
		Store(\DTM0.BUF3, \DTM0.RFU3)
		Load(\DTM0.RFU3, DDB1)

		if (CH03(arg0, z175, 0x040, 0, 0)) {
			return (1)
		}

		Store(5, Local0)
		while (Local0) {

			// Any next
			UnLoad(DDB0)

			CH04(arg0, 0, 28, z175, 0x041, 5, Local0) // AE_BAD_PARAMETER

			Decrement(Local0)
		}

		UnLoad(DDB1)

		if (CH03(arg0, z175, 0x042, 0, 0)) {
			return (1)
		}

		return (0)
	}

	// Exceptions when the operand of UnLoad operator is absent
	Method(tst5, 1, Serialized)
	{
		Name(DDB0, 0)

		Method(m000) {Return (0) }
		Method(m001) {Return (DDB0)}

		Concatenate(arg0, "-tst5", arg0)

		// Load auxiliary table
		Store(\DTM0.BUF3, \DTM0.RFU3)
		Load(\DTM0.RFU3, DDB0)

		if (CH03(arg0, z175, 0x043, 0, 0)) {
			return (1)
		}

		// Device
		UnLoad(Derefof(Refof(\AUXD.DEV0)))
		CH04(arg0, 0, 62, z175, 0x044, 0, 0) // AE_AML_NO_RETURN_VALUE

		// Thermal Zone
		UnLoad(Derefof(Refof(\AUXD.TZN0)))
		CH04(arg0, 0, 62, z175, 0x045, 0, 0) // AE_AML_NO_RETURN_VALUE

		// Method execution
		CopyObject(m000, m001)
		UnLoad(m001())

		if (SLCK) {
			CH04(arg0, 0, 47, z175, 0x046, 0, 0) // AE_AML_OPERAND_TYPE
		} else {
			CH04(arg0, 0, 47, z175, 0x047, 0, 0) // AE_AML_OPERAND_TYPE
		}

		UnLoad(DDB0)

		if (CH03(arg0, z175, 0x048, 0, 0)) {
			return (1)
		}

		return (0)
	}
}

Method(TUL0,, Serialized)
{
	Name(ts, "TUL0")

	CH03(ts, z175, 0x200, 0, 0)

	// Different Sources to specify DDBHandle for UnLoad.
	// Most of them (Named Object, LocalX, ArgX, Derefof)
	// are checked in load.asl
	// DDBHandle returned by Method call
	SRMT("TUL0.tst0")
	\DTM1.tst0(ts)

	CH03(ts, z175, 0x201, 0, 0)

	// All namespace objects created as a result of the corresponding
	// Load operation are absent in the namespace after UnLoad
	SRMT("TUL0.tst1")
	\DTM1.tst1(ts)

	CH03(ts, z175, 0x202, 0, 0)

	// Load/UnLoad processing can be done with the same table many times
	SRMT("TUL0.tst2")
	\DTM1.tst2(ts)

	CH03(ts, z175, 0x203, 0, 0)
}

// Exceptional conditions
Method(TUL1,, Serialized)
{
	Name(ts, "TUL1")

	// Exceptions when the parameter of the UnLoad operator
	// is not of DDBHandle type
	SRMT("TUL1.tst3")
	\DTM1.tst3(ts)

	// Exceptions when UnLoad is executed with the same DDBHandle repeatedly
	SRMT("TUL1.tst4")
	if (y292) {
		\DTM1.tst4(ts)
	} else {
		BLCK()
	}

	// Exceptions when the operand of UnLoad operator is absent
	SRMT("TUL1.tst5")
	\DTM1.tst5(ts)
}
