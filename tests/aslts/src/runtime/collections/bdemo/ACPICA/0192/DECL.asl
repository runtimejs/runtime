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
 * Bug 192:
 *
 * SUMMARY: Incorrect value of Bank register after storing to its banked field
 */

Method(mfa4,, Serialized)
{
	// CHK0 (CheckValue, BenchMarkValue, CheckNum)
	Method(CHK0, 3)
	{
		if (LNotEqual(arg0, arg1)) {
			err("", zFFF, arg2, 0, 0, arg0, arg1)
		}
	}

	// 8-bit Bank field
	Method(m010,, Serialized)
	{
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, ByteAcc, NoLock, Preserve) {
			bnk0, 8
		}

		BankField (r000, bnk0, 0, ByteAcc, NoLock, Preserve) {
			Offset(16),
			bf00, 8,
		}

		BankField (r000, bnk0, 1, ByteAcc, NoLock, Preserve) {
			Offset(17),
			bf01, 8,
		}

		BankField (r000, bnk0, 0xFF, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0-th bank layout:

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x000)

		Store(0x87, bf00)
		CHK0(bnk0, 0, 0x001)
		CHK0(bf00, 0x87, 0x002)

		// Deal with 1-th bank layout:

		Store(1, bnk0)
		CHK0(bnk0, 1, 0x003)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x004)

		Store(0x96, bf01)
		CHK0(bnk0, 1, 0x005)
		CHK0(bf01, 0x96, 0x006)

		// Deal with 0xFF-th bank layout:

		Store(0xFF, bnk0)
		CHK0(bnk0, 0xFF, 0x007)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x008)

		Store(0xC3, bfff)
		CHK0(bnk0, 0xFF, 0x009)
		CHK0(bfff, 0xC3, 0x00a)
	}

	// 16-bit Bank field
	Method(m011,, Serialized)
	{
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, WordAcc, NoLock, Preserve) {
			bnk0, 16
		}

		BankField (r000, bnk0, 0, ByteAcc, NoLock, Preserve) {
			Offset(16),
			bf00, 8,
		}

		BankField (r000, bnk0, 1, ByteAcc, NoLock, Preserve) {
			Offset(17),
			bf01, 8,
		}

		BankField (r000, bnk0, 0xFFFF, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0-th bank layout:

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x00b)

		Store(0x87, bf00)
		CHK0(bnk0, 0, 0x00c)
		CHK0(bf00, 0x87, 0x00d)

		// Deal with 1-th bank layout:

		Store(1, bnk0)
		CHK0(bnk0, 1, 0x00e)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x00f)

		Store(0x96, bf01)
		CHK0(bnk0, 1, 0x010)
		CHK0(bf01, 0x96, 0x011)

		// Deal with 0xFFFF-th bank layout:

		Store(0xFFFF, bnk0)
		CHK0(bnk0, 0xFFFF, 0x012)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x013)

		Store(0xC3, bfff)
		CHK0(bnk0, 0xFFFF, 0x014)
		CHK0(bfff, 0xC3, 0x015)
	}

	// 32-bit Bank field
	Method(m012,, Serialized)
	{
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, DWordAcc, NoLock, Preserve) {
			bnk0, 32
		}

		BankField (r000, bnk0, 0, ByteAcc, NoLock, Preserve) {
			Offset(16),
			bf00, 8,
		}

		BankField (r000, bnk0, 1, ByteAcc, NoLock, Preserve) {
			Offset(17),
			bf01, 8,
		}

		BankField (r000, bnk0, 0xFFFFFFFF, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0-th bank layout:

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x016)

		Store(0x87, bf00)
		CHK0(bnk0, 0, 0x017)
		CHK0(bf00, 0x87, 0x018)

		// Deal with 1-th bank layout:

		Store(1, bnk0)
		CHK0(bnk0, 1, 0x019)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x01a)

		Store(0x96, bf01)
		CHK0(bnk0, 1, 0x01b)
		CHK0(bf01, 0x96, 0x01c)

		// Deal with 0xFFFFFFFF-th bank layout:

		Store(0xFFFFFFFF, bnk0)
		CHK0(bnk0, 0xFFFFFFFF, 0x01d)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x01e)

		Store(0xC3, bfff)
		CHK0(bnk0, 0xFFFFFFFF, 0x01f)
		CHK0(bfff, 0xC3, 0x020)
	}

	// 33-bit Bank field and QWordAcc
	Method(m013,, Serialized)
	{
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, QWordAcc, NoLock, Preserve) {
			bnk0, 33
		}
		BankField (r000, bnk0, 0x1FFFFFFFF, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0x1FFFFFFFF-th bank layout:

		Store(0x1FFFFFFFF, bnk0)
		CHK0(bnk0, 0x1FFFFFFFF, 0x021)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x022)

		Store(0xC3, bfff)
		CHK0(bnk0, 0x1FFFFFFFF, 0x023)
		CHK0(bfff, 0xC3, 0x024)
	}

	// BankValues set up with Integer Constants
	Method(m001)
	{
		// 8-bit Bank field
		m010()

		// 16-bit Bank field
		m011()

		// 32-bit Bank field
		m012()

		// 33-bit Bank field and QWordAcc
		if (y215) {
			m013()
		}
	}

	// BankValues set up with Named Integers

	Name(i000, 0)
	Name(i001, 1)
	Name(i002, 0xFF)
	Name(i003, 0xFFFF)
	Name(i004, 0xFFFFFFFF)
	Name(i005, 0x1FFFFFFFF)

	// 8-bit Bank field
	Method(m020,, Serialized)
	{
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, ByteAcc, NoLock, Preserve) {
			bnk0, 8
		}

		BankField (r000, bnk0, i000, ByteAcc, NoLock, Preserve) {
			Offset(16),
			bf00, 8,
		}

		BankField (r000, bnk0, i001, ByteAcc, NoLock, Preserve) {
			Offset(17),
			bf01, 8,
		}

		BankField (r000, bnk0, i002, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0-th bank layout:

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x025)

		Store(0x87, bf00)
		CHK0(bnk0, 0, 1)
		CHK0(bf00, 0x87, 0x026)

		// Deal with 1-th bank layout:

		Store(1, bnk0)
		CHK0(bnk0, 1, 0x027)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x028)

		Store(0x96, bf01)
		CHK0(bnk0, 1, 0x029)
		CHK0(bf01, 0x96, 0x02a)

		// Deal with 0xFF-th bank layout:

		Store(0xFF, bnk0)
		CHK0(bnk0, 0xFF, 0x02b)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x02c)

		Store(0xC3, bfff)
		CHK0(bnk0, 0xFF, 0x02d)
		CHK0(bfff, 0xC3, 0x02e)
	}

	// 16-bit Bank field
	Method(m021,, Serialized)
	{
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, WordAcc, NoLock, Preserve) {
			bnk0, 16
		}

		BankField (r000, bnk0, i000, ByteAcc, NoLock, Preserve) {
			Offset(16),
			bf00, 8,
		}

		BankField (r000, bnk0, i001, ByteAcc, NoLock, Preserve) {
			Offset(17),
			bf01, 8,
		}

		BankField (r000, bnk0, i003, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0-th bank layout:

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x02f)

		Store(0x87, bf00)
		CHK0(bnk0, 0, 0x030)
		CHK0(bf00, 0x87, 0x031)

		// Deal with 1-th bank layout:

		Store(1, bnk0)
		CHK0(bnk0, 1, 0x032)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x033)

		Store(0x96, bf01)
		CHK0(bnk0, 1, 0x034)
		CHK0(bf01, 0x96, 0x035)

		// Deal with 0xFFFF-th bank layout:

		Store(0xFFFF, bnk0)
		CHK0(bnk0, 0xFFFF, 0x036)

		Store(0, bnk0)
		CHK0(bnk0, 0, 19)

		Store(0xC3, bfff)
		CHK0(bnk0, 0xFFFF, 0x037)
		CHK0(bfff, 0xC3, 0x038)
	}

	// 32-bit Bank field
	Method(m022,, Serialized)
	{
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, DWordAcc, NoLock, Preserve) {
			bnk0, 32
		}

		BankField (r000, bnk0, i000, ByteAcc, NoLock, Preserve) {
			Offset(16),
			bf00, 8,
		}

		BankField (r000, bnk0, i001, ByteAcc, NoLock, Preserve) {
			Offset(17),
			bf01, 8,
		}

		BankField (r000, bnk0, i004, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0-th bank layout:

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x039)

		Store(0x87, bf00)
		CHK0(bnk0, 0, 0x03a)
		CHK0(bf00, 0x87, 0x03b)

		// Deal with 1-th bank layout:

		Store(1, bnk0)
		CHK0(bnk0, 1, 0x03c)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x03e)

		Store(0x96, bf01)
		CHK0(bnk0, 1, 0x03f)
		CHK0(bf01, 0x96, 0x040)

		// Deal with 0xFFFFFFFF-th bank layout:

		Store(0xFFFFFFFF, bnk0)
		CHK0(bnk0, 0xFFFFFFFF, 0x041)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x042)

		Store(0xC3, bfff)
		CHK0(bnk0, 0xFFFFFFFF, 0x043)
		CHK0(bfff, 0xC3, 0x044)
	}

	// 33-bit Bank field and QWordAcc
	Method(m023,, Serialized)
	{
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, QWordAcc, NoLock, Preserve) {
			bnk0, 33
		}
		BankField (r000, bnk0, i005, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0x1FFFFFFFF-th bank layout:

		Store(0x1FFFFFFFF, bnk0)
		CHK0(bnk0, 0x1FFFFFFFF, 0x045)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x04e)

		Store(0xC3, bfff)
		CHK0(bnk0, 0x1FFFFFFFF, 0x046)
		CHK0(bfff, 0xC3, 0x047)
	}

	// BankValues set up with Named Integers
	Method(m002)
	{
		// 8-bit Bank field
		m020()

		// 16-bit Bank field
		m021()

		// 32-bit Bank field
		m022()

		// 33-bit Bank field and QWordAcc
		if (y215) {
			m023()
		}
	}

	// BankValues set up with LocalX

	// 8-bit Bank field
	Method(m030,, Serialized)
	{
		Store(0, Local0)
		Store(1, Local1)
		Store(0xFF, Local2)

		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, ByteAcc, NoLock, Preserve) {
			bnk0, 8
		}

		BankField (r000, bnk0, Local0, ByteAcc, NoLock, Preserve) {
			Offset(16),
			bf00, 8,
		}

		BankField (r000, bnk0, Local1, ByteAcc, NoLock, Preserve) {
			Offset(17),
			bf01, 8,
		}

		BankField (r000, bnk0, Local2, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0-th bank layout:

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x048)

		Store(0x87, bf00)
		CHK0(bnk0, 0, 0x049)
		CHK0(bf00, 0x87, 0x04a)

		// Deal with 1-th bank layout:

		Store(1, bnk0)
		CHK0(bnk0, 1, 0x04b)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x04c)

		Store(0x96, bf01)
		CHK0(bnk0, 1, 0x04e)
		CHK0(bf01, 0x96, 0x04f)

		// Deal with 0xFF-th bank layout:

		Store(0xFF, bnk0)
		CHK0(bnk0, 0xFF, 0x050)

		Store(0, bnk0)
		CHK0(bnk0, 0, 8)

		Store(0xC3, bfff)
		CHK0(bnk0, 0xFF, 0x051)
		CHK0(bfff, 0xC3, 0x052)
	}

	// 16-bit Bank field
	Method(m031,, Serialized)
	{
		Store(0, Local0)
		Store(1, Local1)
		Store(0xFFFF, Local3)

		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, WordAcc, NoLock, Preserve) {
			bnk0, 16
		}

		BankField (r000, bnk0, Local0, ByteAcc, NoLock, Preserve) {
			Offset(16),
			bf00, 8,
		}

		BankField (r000, bnk0, Local1, ByteAcc, NoLock, Preserve) {
			Offset(17),
			bf01, 8,
		}

		BankField (r000, bnk0, Local3, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0-th bank layout:

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x053)

		Store(0x87, bf00)
		CHK0(bnk0, 0, 0x054)
		CHK0(bf00, 0x87, 0x055)

		// Deal with 1-th bank layout:

		Store(1, bnk0)
		CHK0(bnk0, 1, 0x056)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x057)

		Store(0x96, bf01)
		CHK0(bnk0, 1, 0x058)
		CHK0(bf01, 0x96, 0x059)

		// Deal with 0xFFFF-th bank layout:

		Store(0xFFFF, bnk0)
		CHK0(bnk0, 0xFFFF, 0x05a)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x05b)

		Store(0xC3, bfff)
		CHK0(bnk0, 0xFFFF, 0x05c)
		CHK0(bfff, 0xC3, 0x05d)
	}

	// 32-bit Bank field
	Method(m032,, Serialized)
	{
		Store(0, Local0)
		Store(1, Local1)
		Store(0xFFFFFFFF, Local4)

		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, DWordAcc, NoLock, Preserve) {
			bnk0, 32
		}

		BankField (r000, bnk0, Local0, ByteAcc, NoLock, Preserve) {
			Offset(16),
			bf00, 8,
		}

		BankField (r000, bnk0, Local1, ByteAcc, NoLock, Preserve) {
			Offset(17),
			bf01, 8,
		}

		BankField (r000, bnk0, Local4, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0-th bank layout:

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x05e)

		Store(0x87, bf00)
		CHK0(bnk0, 0, 0x05f)
		CHK0(bf00, 0x87, 0x060)

		// Deal with 1-th bank layout:

		Store(1, bnk0)
		CHK0(bnk0, 1, 0x061)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x062)

		Store(0x96, bf01)
		CHK0(bnk0, 1, 0x063)
		CHK0(bf01, 0x96, 0x064)

		// Deal with 0xFFFFFFFF-th bank layout:

		Store(0xFFFFFFFF, bnk0)
		CHK0(bnk0, 0xFFFFFFFF, 0x065)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x066)

		Store(0xC3, bfff)
		CHK0(bnk0, 0xFFFFFFFF, 0x067)
		CHK0(bfff, 0xC3, 0x068)
	}

	// 33-bit Bank field and QWordAcc
	Method(m033,, Serialized)
	{
		Store(0x1FFFFFFFF, Local5)

		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, QWordAcc, NoLock, Preserve) {
			bnk0, 33
		}
		BankField (r000, bnk0, Local5, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0x1FFFFFFFF-th bank layout:

		Store(0x1FFFFFFFF, bnk0)
		CHK0(bnk0, 0x1FFFFFFFF, 0x069)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x06a)

		Store(0xC3, bfff)
		CHK0(bnk0, 0x1FFFFFFFF, 0x06b)
		CHK0(bfff, 0xC3, 0x06c)
	}

	// BankValues set up with LocalX
	Method(m003)
	{
		// 8-bit Bank field
		m030()

		// 16-bit Bank field
		m031()

		// 32-bit Bank field
		m032()

		// 33-bit Bank field and QWordAcc
		if (y215) {
			m033()
		}
	}

	// BankValues set up with ArgX

	// 8-bit Bank field
	Method(m040, 3, Serialized)
	{
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, ByteAcc, NoLock, Preserve) {
			bnk0, 8
		}

		BankField (r000, bnk0, Arg0, ByteAcc, NoLock, Preserve) {
			Offset(16),
			bf00, 8,
		}

		BankField (r000, bnk0, Arg1, ByteAcc, NoLock, Preserve) {
			Offset(17),
			bf01, 8,
		}

		BankField (r000, bnk0, Arg2, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0-th bank layout:

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x06e)

		Store(0x87, bf00)
		CHK0(bnk0, 0, 0x06f)
		CHK0(bf00, 0x87, 0x070)

		// Deal with 1-th bank layout:

		Store(1, bnk0)
		CHK0(bnk0, 1, 0x071)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x072)

		Store(0x96, bf01)
		CHK0(bnk0, 1, 0x073)
		CHK0(bf01, 0x96, 0x074)

		// Deal with 0xFF-th bank layout:

		Store(0xFF, bnk0)
		CHK0(bnk0, 0xFF, 0x075)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x076)

		Store(0xC3, bfff)
		CHK0(bnk0, 0xFF, 0x077)
		CHK0(bfff, 0xC3, 0x078)
	}

	// 16-bit Bank field
	Method(m041, 3, Serialized)
	{
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, WordAcc, NoLock, Preserve) {
			bnk0, 16
		}

		BankField (r000, bnk0, Arg0, ByteAcc, NoLock, Preserve) {
			Offset(16),
			bf00, 8,
		}

		BankField (r000, bnk0, Arg1, ByteAcc, NoLock, Preserve) {
			Offset(17),
			bf01, 8,
		}

		BankField (r000, bnk0, Arg2, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0-th bank layout:

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x079)

		Store(0x87, bf00)
		CHK0(bnk0, 0, 0x07a)
		CHK0(bf00, 0x87, 0x07b)

		// Deal with 1-th bank layout:

		Store(1, bnk0)
		CHK0(bnk0, 1, 0x07c)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x07e)

		Store(0x96, bf01)
		CHK0(bnk0, 1, 0x07f)
		CHK0(bf01, 0x96, 0x080)

		// Deal with 0xFFFF-th bank layout:

		Store(0xFFFF, bnk0)
		CHK0(bnk0, 0xFFFF, 0x081)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x082)

		Store(0xC3, bfff)
		CHK0(bnk0, 0xFFFF, 0x083)
		CHK0(bfff, 0xC3, 0x084)
	}

	// 32-bit Bank field
	Method(m042, 3, Serialized)
	{
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, DWordAcc, NoLock, Preserve) {
			bnk0, 32
		}

		BankField (r000, bnk0, Arg0, ByteAcc, NoLock, Preserve) {
			Offset(16),
			bf00, 8,
		}

		BankField (r000, bnk0, Arg1, ByteAcc, NoLock, Preserve) {
			Offset(17),
			bf01, 8,
		}

		BankField (r000, bnk0, Arg2, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0-th bank layout:

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x085)

		Store(0x87, bf00)
		CHK0(bnk0, 0, 0x086)
		CHK0(bf00, 0x87, 0x087)

		// Deal with 1-th bank layout:

		Store(1, bnk0)
		CHK0(bnk0, 1, 0x088)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x089)

		Store(0x96, bf01)
		CHK0(bnk0, 1, 0x08a)
		CHK0(bf01, 0x96, 0x08b)

		// Deal with 0xFFFFFFFF-th bank layout:

		Store(0xFFFFFFFF, bnk0)
		CHK0(bnk0, 0xFFFFFFFF, 0x08c)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x08d)

		Store(0xC3, bfff)
		CHK0(bnk0, 0xFFFFFFFF, 0x08e)
		CHK0(bfff, 0xC3, 0x08f)
	}

	// 33-bit Bank field and QWordAcc
	Method(m043, 1, Serialized)
	{
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, QWordAcc, NoLock, Preserve) {
			bnk0, 33
		}
		BankField (r000, bnk0, Arg0, ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0x1FFFFFFFF-th bank layout:

		Store(0x1FFFFFFFF, bnk0)
		CHK0(bnk0, 0x1FFFFFFFF, 0x090)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x091)

		Store(0xC3, bfff)
		CHK0(bnk0, 0x1FFFFFFFF, 0x092)
		CHK0(bfff, 0xC3, 0x093)
	}

	// BankValues set up with ArgX
	Method(m004)
	{
		// 8-bit Bank field
		m040(0, 1, 0xFF)

		// 16-bit Bank field
		m041(0, 1, 0xFFFF)

		// 32-bit Bank field
		m042(0, 1, 0xFFFFFFFF)

		// 33-bit Bank field and QWordAcc
		if (y215) {
			m043(0x1FFFFFFFF)
		}
	}

	// BankValues set up with Expressions

	// 8-bit Bank field
	Method(m050, 3, Serialized)
	{
		Store(0, Local0)
		Store(1, Local1)

		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, ByteAcc, NoLock, Preserve) {
			bnk0, 8
		}

		BankField (r000, bnk0, Add(Arg0, Local0), ByteAcc, NoLock, Preserve) {
			Offset(16),
			bf00, 8,
		}

		BankField (r000, bnk0, Add(Arg1, 1), ByteAcc, NoLock, Preserve) {
			Offset(17),
			bf01, 8,
		}

		BankField (r000, bnk0, Add(Arg2, Local1), ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0-th bank layout:

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x094)

		Store(0x87, bf00)
		CHK0(bnk0, 0, 0x095)
		CHK0(bf00, 0x87, 0x096)

		// Deal with 1-th bank layout:

		Store(1, bnk0)
		CHK0(bnk0, 1, 0x097)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x098)

		Store(0x96, bf01)
		CHK0(bnk0, 1, 0x099)
		CHK0(bf01, 0x96, 0x09a)

		// Deal with 0xFF-th bank layout:

		Store(0xFF, bnk0)
		CHK0(bnk0, 0xFF, 0x09b)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x09c)

		Store(0xC3, bfff)
		CHK0(bnk0, 0xFF, 0x09d)
		CHK0(bfff, 0xC3, 0x09e)
	}

	// 16-bit Bank field
	Method(m051, 3, Serialized)
	{
		Store(0, Local0)
		Store(1, Local1)

		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, WordAcc, NoLock, Preserve) {
			bnk0, 16
		}

		BankField (r000, bnk0, Add(Arg0, Local0), ByteAcc, NoLock, Preserve) {
			Offset(16),
			bf00, 8,
		}

		BankField (r000, bnk0, Add(Arg1, Local1), ByteAcc, NoLock, Preserve) {
			Offset(17),
			bf01, 8,
		}

		BankField (r000, bnk0, Add(Arg2, 1), ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0-th bank layout:

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x09f)

		Store(0x87, bf00)
		CHK0(bnk0, 0, 0x0a0)
		CHK0(bf00, 0x87, 0x0a1)

		// Deal with 1-th bank layout:

		Store(1, bnk0)
		CHK0(bnk0, 1, 0x0a2)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x0a3)

		Store(0x96, bf01)
		CHK0(bnk0, 1, 0x0a4)
		CHK0(bf01, 0x96, 0x0a5)

		// Deal with 0xFFFF-th bank layout:

		Store(0xFFFF, bnk0)
		CHK0(bnk0, 0xFFFF, 0x0a6)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x0a7)

		Store(0xC3, bfff)
		CHK0(bnk0, 0xFFFF, 0x0a8)
		CHK0(bfff, 0xC3, 0x0a9)
	}

	// 32-bit Bank field
	Method(m052, 3, Serialized)
	{
		Store(0, Local0)
		Store(1, Local1)

		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, DWordAcc, NoLock, Preserve) {
			bnk0, 32
		}

		BankField (r000, bnk0, Add(Arg0, Local0), ByteAcc, NoLock, Preserve) {
			Offset(16),
			bf00, 8,
		}

		BankField (r000, bnk0, Add(Arg1, Local1), ByteAcc, NoLock, Preserve) {
			Offset(17),
			bf01, 8,
		}

		BankField (r000, bnk0, Add(Arg2, 1), ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0-th bank layout:

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x0aa)

		Store(0x87, bf00)
		CHK0(bnk0, 0, 0x0ab)
		CHK0(bf00, 0x87, 0x0ac)

		// Deal with 1-th bank layout:

		Store(1, bnk0)
		CHK0(bnk0, 1, 0x0ad)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x0ae)

		Store(0x96, bf01)
		CHK0(bnk0, 1, 0x0af)
		CHK0(bf01, 0x96, 0x0b0)

		// Deal with 0xFFFFFFFF-th bank layout:

		Store(0xFFFFFFFF, bnk0)
		CHK0(bnk0, 0xFFFFFFFF, 0x0b1)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x0b2)

		Store(0xC3, bfff)
		CHK0(bnk0, 0xFFFFFFFF, 0x0b3)
		CHK0(bfff, 0xC3, 0x0b4)
	}

	// 33-bit Bank field and QWordAcc
	Method(m053, 1, Serialized)
	{
		OperationRegion(r000, SystemMemory, 0x100, 0x100)
		Field (r000, QWordAcc, NoLock, Preserve) {
			bnk0, 33
		}
		BankField (r000, bnk0, Add(Arg0, 1), ByteAcc, NoLock, Preserve) {
			Offset(18),
			bfff, 8,
		}

		// Deal with 0x1FFFFFFFF-th bank layout:

		Store(0x1FFFFFFFF, bnk0)
		CHK0(bnk0, 0x1FFFFFFFF, 0x0b5)

		Store(0, bnk0)
		CHK0(bnk0, 0, 0x0b6)

		Store(0xC3, bfff)
		CHK0(bnk0, 0x1FFFFFFFF, 0x0b7)
		CHK0(bfff, 0xC3, 0x0b8)
	}

	// BankValues set up with Expressions
	Method(m005)
	{
		// 8-bit Bank field
		m050(0, 0, 0xFE)

		// 16-bit Bank field
		m051(0, 0, 0xFFFE)

		// 32-bit Bank field
		m052(0, 0, 0xFFFFFFFE)

		// 33-bit Bank field and QWordAcc
		if (y215) {
			m053(0x1FFFFFFFE)
		}
	}

	Store("BankValues set up with Integer Constants", Debug)
	m001()

	Store("BankValues set up with Named Integers", Debug)
	m002()

	Store("BankValues set up with LocalX", Debug)
	m003()

	Store("BankValues set up with ArgX", Debug)
	m004()

	Store("BankValues set up with Expressions", Debug)
	m005()
}
