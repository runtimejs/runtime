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
 * DynObj: ASL declarations
 */

Name(z130, 130)

// Check declarations
Method(m373,, Serialized)
{
	// The Created Objects benchmark Package
	Name(pp00, Package(1) {})

	// The Deleted Objects benchmark Package
	Name(pp01, Package(1) {})

	// The per-memory type benchmark Package
	Name(pp02, Package(1) {})


	// Package for _TCI-begin statistics
	// (use NamedX, dont use ArgX/LocalX).
	Name(pp0a, Package(1) {})

	// Objects for verified operators

	Name(num, 5)
	Name(lpN0, 0)
	Name(lpC0, 0)
	Name(bcf0, Buffer(8) {})
	OperationRegion(r000, SystemMemory, 0x100, 0x100)

	Name(i000, 0)

	// Create and initialize the Memory Consumption Statistics Packages

	Store(m3a0(c200), Local0)	// _TCI-end statistics
	Store(m3a0(c201), pp0a)		// _TCI-begin statistics
	Store(m3a0(0), Local1)		// difference

	// Available free locals

	Store(0, Local2)
	Store(0, Local3)
	Store(0, Local4)
	Store(0, Local5)
	Store(0, Local6)
	Store(0, Local7)

	SET0(z130, "m373", 0)


	// ======================== Name

if (rn00) {

	Store("Name", Debug)

	_TCI(c200, Local0)
	Name(i100, 0)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(m3a8(), pp01)
	Store(m3a9(), pp02)
	Store(1, Index(pp02, c226)) // CLIST_ID_NAMESPACE
	Store(1, Index(pp02, c228)) // CLIST_ID_OPERAND
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 0)
}

if (rn00) {

	_TCI(c200, Local0)
	Name(s100, "qsdrtghyuiopmngsxz")
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00a)) // String
	Store(m3a8(), pp01)
	Store(m3a9(), pp02)
	Store(1, Index(pp02, c226)) // CLIST_ID_NAMESPACE
	Store(1, Index(pp02, c228)) // CLIST_ID_OPERAND
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 1)

	_TCI(c200, Local0)
	Name(b100, Buffer(16){1,2,3,4,5,6,7,8})
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00b)) // Buffer
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(m3a9(), pp02)
	Store(1, Index(pp02, c226)) // CLIST_ID_NAMESPACE
	Store(1, Index(pp02, c228)) // CLIST_ID_OPERAND
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 2)

	_TCI(c200, Local0)
	Name(p100, Package(16){1,2,3,4,5,6,7,8})
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(9, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00c)) // Package
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(m3a9(), pp02)
	Store(1, Index(pp02, c226)) // CLIST_ID_NAMESPACE
	Store(9, Index(pp02, c228)) // CLIST_ID_OPERAND
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 3)
}

if (rn00) {

	_TCI(c200, Local0)
	Name(p101, Package(16){1,2,3,4,5,6,7,8, i000})
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(9, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00c)) // Package
	Store(1, Index(pp00, c01c)) // LOCAL_REFERENCE
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(m3a9(), pp02)
	Store(1, Index(pp02, c226)) // CLIST_ID_NAMESPACE
	Store(10, Index(pp02, c228)) // CLIST_ID_OPERAND
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 4)
}

	// ======================== CreateField

if (rn00) {

	Store("CreateField", Debug)

	_TCI(c200, Local0)
	CreateField(bcf0, 1, 3, bf00)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c016)) // BufferField
	Store(1, Index(pp00, c024)) // LOCAL_EXTRA
	Store(m3a8(), pp01)
	Store(2, Index(pp01, c009)) // Integer
	Store(m3a9(), pp02)
	Store(1, Index(pp02, c226)) // CLIST_ID_NAMESPACE
	Store(2, Index(pp02, c228)) // CLIST_ID_OPERAND
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 5)
}

	// //////// Resource Descriptor macros

	// ======================== DMA

if (rn00) {

	Store("DMA", Debug)

	_TCI(c200, Local0)
	Name(rt00, ResourceTemplate () {
	DMA (Compatibility, NotBusMaster, Transfer8, DMA0) {}})
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c00b)) // Buffer
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(m3a9(), pp02)
	Store(1, Index(pp02, c226)) // CLIST_ID_NAMESPACE
	Store(1, Index(pp02, c228)) // CLIST_ID_OPERAND
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 6)
}

	// ======================== DataTableRegion

if (rn00) {

	Store("DataTableRegion", Debug)

	_TCI(c200, Local0)
	DataTableRegion (HDR, "DSDT", "", "")
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(3, Index(pp00, c00a)) // String
	Store(1, Index(pp00, c012)) // Operation Region
	Store(1, Index(pp00, c024)) // LOCAL_EXTRA
	Store(m3a8(), pp01)
	Store(3, Index(pp01, c00a)) // String
	Store(m3a9(), pp02)
	Store(1, Index(pp02, c226)) // CLIST_ID_NAMESPACE
	Store(2, Index(pp02, c228)) // CLIST_ID_OPERAND
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 7)
}

	// ======================== Field

if (rn04) {

	Store("Field", Debug)

	_TCI(c200, Local0)
	Field(r000, ByteAcc, NoLock, Preserve) { f000, 8 }
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c019)) // LOCAL_REGION_FIELD
	Store(m3a8(), pp01)
	Store(m3a9(), pp02)
	Store(1, Index(pp02, c228)) // CLIST_ID_OPERAND
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 8)
}

	// ======================== BankField

if (rn04) {

	Store("BankField", Debug)

	Field(r000, ByteAcc, NoLock, Preserve) { f001, 8 }

	_TCI(c200, Local0)
	BankField(r000, f001, 0, ByteAcc, NoLock, Preserve) {bn00, 4}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c01a)) // LOCAL_BANK_FIELD
	Store(m3a8(), pp01)
	Store(m3a9(), pp02)
	Store(1, Index(pp02, c228)) // CLIST_ID_OPERAND
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 9)
}

	// ======================== IndexField

if (rn04) {

	Store("IndexField", Debug)

	Field(r000, ByteAcc, NoLock, Preserve) {f002,8,f003,8}

	_TCI(c200, Local0)
	IndexField(f002, f003, ByteAcc, NoLock, Preserve) {if00,8,if01,8}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c01b)) // LOCAL_INDEX_FIELD
	Store(m3a8(), pp01)
	Store(m3a9(), pp02)
	Store(2, Index(pp02, c228)) // CLIST_ID_OPERAND
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 10)
}

	// ======================== Event

if (rn00) {

	Store("Event", Debug)

	_TCI(c200, Local0)
	Event(e900)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00f)) // Event
	Store(m3a8(), pp01)
	Store(m3a9(), pp02)
	Store(1, Index(pp02, c226)) // CLIST_ID_NAMESPACE
	Store(1, Index(pp02, c228)) // CLIST_ID_OPERAND
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 11)
}

	// ======================== Mutex

if (rn00) {

	Store("Mutex", Debug)

	_TCI(c200, Local0)
	Mutex(MT00, 0)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c009)) // Integer
	Store(1, Index(pp00, c011)) // Mutex
	Store(m3a8(), pp01)
	Store(1, Index(pp01, c009)) // Integer
	Store(m3a9(), pp02)
	Store(1, Index(pp02, c226)) // CLIST_ID_NAMESPACE
	Store(1, Index(pp02, c228)) // CLIST_ID_OPERAND
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 12)
}

	// ======================== OperationRegion

if (rn04) {

	Store("OperationRegion", Debug)

	_TCI(c200, Local0)
	OperationRegion(r001, SystemMemory, 0x100, 0x100)
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(2, Index(pp00, c009)) // Integer
//	Store(1, Index(pp00, c012)) // OperationRegion
	Store(m3a8(), pp01)
	Store(m3a9(), pp02)
	m3a4(Local0, pp0a, Local1, pp00, 0, 0, 13)
}


	// ======================== Device

if (rn03) {

	// Causes AE_AML_NAME_NOT_FOUND exception

	Store("Device", Debug)

	_TCI(c200, Local0)
	Device(d000) {}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c00e)) // Device
	Store(m3a8(), pp01)
	Store(m3a9(), pp02)
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 14)
}

	// ======================== Method

if (rn03) {

	// Causes AE_AML_NAME_NOT_FOUND exception

	Store("Method", Debug)

	_TCI(c200, Local0)
	Method(m000) {}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c010)) // Method
	Store(m3a8(), pp01)
	Store(m3a9(), pp02)
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 15)
}

	// ======================== ThermalZone

if (rn03) {

	// Causes AE_AML_NAME_NOT_FOUND exception

	Store("ThermalZone", Debug)

	_TCI(c200, Local0)
	ThermalZone(tz00) {}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c015)) // ThermalZone
	Store(m3a8(), pp01)
	Store(m3a9(), pp02)
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 16)
}

	// ======================== Processor

if (rn03) {

	// Causes AE_AML_NAME_NOT_FOUND exception

	Store("Processor", Debug)

	_TCI(c200, Local0)
	Processor(pr00, 0, 0xFFFFFFFF, 0) {}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c014)) // Processor
	Store(m3a8(), pp01)
	Store(m3a9(), pp02)
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 17)
}

	// ======================== PowerResource

if (rn03) {

	// Causes AE_AML_NAME_NOT_FOUND exception

	Store("PowerResource", Debug)

	_TCI(c200, Local0)
	PowerResource(pw00, 1, 0) {}
	_TCI(c201, pp0a)
	m3a3(Local0, pp0a, Local1)
	Store(m3a8(), pp00)
	Store(1, Index(pp00, c013)) // PowerResource
	Store(m3a8(), pp01)
	Store(m3a9(), pp02)
	m3a4(Local0, pp0a, Local1, pp00, pp01, pp02, 18)
}


	RST0()
}
