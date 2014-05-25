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
 * LoadTable ASL operator functionality
 */

/*
 * This sub-test is intended to comprehensively verify
 * the LoadTable ASL operator functionality.
 *
 * Performs a run-time load of a Definition Block from the XSDT.
 *
 *    17.5.68   LoadTable (Load Definition Block From XSDT)
 *    Syntax
 * LoadTable (SignatureString, OEMIDString, OEMTableIDString,
 *   RootPathString, ParameterPathString, ParameterData) => DDBHandle
 *
 * On testing the following issues should be covered:
 *
 * - loading from the XSDT of a Definition Block in which the Signature
 *   field (should differ from "DSDT" and "SSDT") matches SignatureString,
 *   the OEM ID field matches OEMIDString, and the OEM Table ID matches
 *   OEMTableIDString,
 *
 * - all comparisons are case sensitive,
 *
 * - the result of the LoadTable operator is an Object of the DDBHandle type,
 *
 * - if no table matches the specified parameters, then 0 is returned,
 *
 * - the DDBHandle Object returned from the LoadTable operator can be used
 *   to unload the table,
 *
 * - any of the optional parameters (RootPathString, ParameterPathString,
 *   and ParameterData) can be omitted,
 *
 * - different sources of the String parameters: literals, Named Objects,
 *   LocalX, ArgX, elements of Packages, results of functions, any TermArg
 *
 * - different sources of the optional parameters: literals, Named Objects,
 *   LocalX, ArgX, elements of Packages, results of functions, any TermArg
 *
 * - implicit operand conversion of the parameters specified to be strings,
 *
 * - namespace location to load the Definition Block is determined by the
 *   RootPathString parameter,
 *
 * - the RootPathString is evaluated using normal scoping rules, assuming
 *   that the scope of the LoadTable operator is the current scope,
 *
 * - if RootPathString is not specified, "\" is assumed,
 *
 * - if ParameterPathString and ParameterData are specified, the data object
 *   specified by ParameterData is stored into the object specified by
 *   ParameterPathString after the table has been added into the namespace,
 *
 * - if the first character of ParameterPathString is a backslash or caret
 *   character, then the path of the object is ParameterPathString. Otherwise,
 *   it is RootPathString.ParameterPathString,
 *
 * - if some SSDT matching the LoadTable parameters is originally not listed
 *   in XSDT, LoadTable returns 0,
 *
 * - exceptional conditions caused by inappropriate data:
 *   = the SignatureString is greater than four characters,
 *   = the OEMIDString is greater than six characters,
 *   = the OEMTableID is greater than eight characters,
 *   = incorrect types of the parameters,
 *   = some DSDT or SSDT matching the LoadTable parameters is already loaded
 *     (actually on initial loading of tables listed in XSDT),
 *   = the matched table is already loaded,
 *   = there already is an previously loaded Object referred by the path
 *     in the Namespace,
 *   = the object specified by the ParameterPathString does not exist,
 *   = storing of data of the ParameterData data type is not allowed,
 *   = AE_OWNER_ID_LIMIT exception when too many Tables loaded.
 *
 * Can not be tested following issues:
 * - providing of the table matched the LoadTable parameters to be "in memory
 *   marked by AddressRangeReserved or AddressRangeNVS",
 * - overriding the supplied table with "a newer revision Definition Block
 *   of the same OEM Table ID" by the OS,
 * - loading a Definition Block to be a synchronous operation ("the control
 *   methods defined in the Definition Block are not executed during load
 *   time").
 *
 * Note: the tests is based on the current representation of the auxiliary
 *       OEM1 table in the artificial set of tables in the RSDT of acpiexec.
 */

Name(z176, 176)

Device(DTM2) {

	Device(DEVR) {Name(s000, "DEVR")}

	// Contents of the OEM1 signature table addressed by the RSDT in acpiexec
	Name(OEMT, Buffer(0x30){
		0x4F,0x45,0x4D,0x31,0x38,0x00,0x00,0x00,  /* 00000000    "OEM18..." */
		0x01,0x4B,0x49,0x6E,0x74,0x65,0x6C,0x00,  /* 00000008    ".KIntel." */
		0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00,  /* 00000010    "Many...." */
		0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
		0x18,0x09,0x03,0x20,0x08,0x5F,0x58,0x54,  /* 00000020    "... ._XT" */
		0x32,0x0A,0x04,0x14,0x0C,0x5F,0x58,0x54,  /* 00000028    "2...._XT" */
		0x31,0x00,0x70,0x01,0x5F,0x58,0x54,0x32,  /* 00000030    "1.p._XT2" */
	})

	CreateField (OEMT,   0, 32, FOEM)
	CreateField (OEMT,  80, 48, FOID)
	CreateField (OEMT, 128, 64, FTID)

	Name(SOEM, "OEM1")
	Name(SOID, "Intel")
	Name(STID, "Many")

	Name(POEM, Package(3) {"OEM1", "Intel", "Many"})

	Name(RPST, "\\DTM2")
	Name(PLDT, 0)
	Name(PPST, "\\DTM2.PLDT")
	Name(DDBH, 0)

	// Check DataTable Region
	Method(chdr, 1, Serialized)
	{
		DataTableRegion (DR00, "OEM1", "", "")
		Field(DR00, AnyAcc, NoLock, Preserve) {
			FU00, 0x1C0}

		Concatenate(arg0, "-tst0", arg0)

		if (LNotEqual(OEMT, FU00)) {
			err(arg0, z176, 0x001, 0, 0, FU00, OEMT)
			return (1)
		}

		return (0)
	}

	// Simple Loadtable test
	Method(tst0, 1, Serialized)
	{
		Name(DDBH, 0)

		Concatenate(arg0, "-tst0", arg0)

		if (chdr(arg0)) {
			return (1)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x002, 0, 0, "\\_XT2", 1)
			return (1)
		}

		Store(0, \DTM2.PLDT)

		Store(LoadTable("OEM1", "", "", "\\", PPST, 1), DDBH)

		if (CH03(arg0, z176, 0x003, 0, 0)) {
			return (1)
		}

		if (y260) {
			Store(ObjectType(DDBH), Local1)
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z176, 0x005, 0, 0, Local1, c017)
				return (1)
			}
		}

		if (LNotEqual(1, \DTM2.PLDT)) {
			err(arg0, z176, 0x006, 0, 0, \DTM2.PLDT, 1)
		}

		if (CondRefof(\_XT2, Local0)) {
		} else {
			err(arg0, z176, 0x007, 0, 0, "\\_XT2", 0)
		}

		UnLoad(DDBH)
		Store("OEM1 unloaded", Debug)

		if (CH03(arg0, z176, 0x008, 0, 0)) {
			return (1)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x009, 0, 0, "\\_XT2", 1)
		}

		return (0)
	}

	// All comparisons of Loadtable parameters are case sensitive,
	// if no table matches the specified parameters, then 0 is returned
	Method(tst1, 1, Serialized)
	{
		Name(DDBH, 0)

		Concatenate(arg0, "-tst1", arg0)

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x010, 0, 0, "\\_XT2", 1)
			return (1)
		}

		// Successful comparison

		Store(0, \DTM2.PLDT)

		if (y281) {
			Store(LoadTable("OEM1", "Intel", "Many", "\\", PPST, 1), DDBH)
		} else {
			Store(LoadTable("OEM1", "", "", "\\", PPST, 1), DDBH)
		}

		if (CH03(arg0, z176, 0x011, 0, 0)) {
			return (1)
		}

		if (y260) {
			Store(ObjectType(DDBH), Local1)
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z176, 0x012, 0, 0, Local1, c017)
				return (1)
			}
		}

		if (LNotEqual(1, \DTM2.PLDT)) {
			err(arg0, z176, 0x013, 0, 0, \DTM2.PLDT, 1)
		}

		if (CondRefof(\_XT2, Local0)) {
		} else {
			err(arg0, z176, 0x014, 0, 0, "\\_XT2", 0)
		}

		UnLoad(DDBH)
		Store("OEM1 unloaded", Debug)

		if (CH03(arg0, z176, 0x015, 0, 0)) {
			return (1)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x016, 0, 0, "\\_XT2", 1)
		}

		// Unhappy comparison due to the SignatureString

		Store(0, \DTM2.PLDT)

		Store(ObjectType(Local2), Local1)
		if (LNotEqual(Local1, c008)) {
			err(arg0, z176, 0x017, 0, 0, Local1, c008)
		}

		Store(LoadTable("OeM1", "Intel", "Many", "\\", PPST, 1), Local2)

		if (CH03(arg0, z176, 0x018, 0, 0)) {
			return (1)
		}

		Store(ObjectType(Local2), Local1)
		if (LNotEqual(Local1, c009)) {
			err(arg0, z176, 0x019, 0, 0, Local1, c009)
		}

		if (LNotEqual(Local2, 0)) {
			err(arg0, z176, 0x01a, 0, 0, Local2, 0)
		}

		if (LNotEqual(0, \DTM2.PLDT)) {
			err(arg0, z176, 0x01b, 0, 0, \DTM2.PLDT, 0)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x01c, 0, 0, "\\_XT2", 1)
		}

		// Unhappy comparison due to the OEMIDString

		Store(0, \DTM2.PLDT)

		Store(ObjectType(Local3), Local1)
		if (LNotEqual(Local1, c008)) {
			err(arg0, z176, 0x01d, 0, 0, Local1, c008)
		}

		Store(LoadTable("OEM1", "InteL", "Many", "\\", PPST, 1), Local3)

		if (CH03(arg0, z176, 0x01e, 0, 0)) {
			return (1)
		}

		Store(ObjectType(Local3), Local1)
		if (LNotEqual(Local1, c009)) {
			err(arg0, z176, 0x01f, 0, 0, Local1, c009)
		}

		if (LNotEqual(Local3, 0)) {
			err(arg0, z176, 0x020, 0, 0, Local3, 0)
		}

		if (LNotEqual(0, \DTM2.PLDT)) {
			err(arg0, z176, 0x021, 0, 0, \DTM2.PLDT, 0)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x022, 0, 0, "\\_XT2", 1)
		}

		// Unhappy comparison due to the OEMTableIDString

		Store(0, \DTM2.PLDT)

		Store(ObjectType(Local4), Local1)
		if (LNotEqual(Local1, c008)) {
			err(arg0, z176, 0x023, 0, 0, Local1, c008)
		}

		Store(LoadTable("OEM1", "Intel", "many", "\\", PPST, 1), Local4)

		if (CH03(arg0, z176, 0x024, 0, 0)) {
			return (1)
		}

		Store(ObjectType(Local4), Local1)
		if (LNotEqual(Local1, c009)) {
			err(arg0, z176, 0x025, 0, 0, Local1, c009)
		}

		if (LNotEqual(Local4, 0)) {
			err(arg0, z176, 0x026, 0, 0, Local4, 0)
		}

		if (LNotEqual(0, \DTM2.PLDT)) {
			err(arg0, z176, 0x027, 0, 0, \DTM2.PLDT, 0)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x028, 0, 0, "\\_XT2", 1)
		}

		return (0)
	}

	// Any of the RootPathString, ParameterPathString, and ParameterData
	// parameters in LoadTable expression can be omitted
	Method(tst2, 1, Serialized)
	{
		Name(DDB0, 0)
		Name(DDB1, 0)
		Name(DDB2, 0)
		Name(DDB3, 0)

		Concatenate(arg0, "-tst2", arg0)

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x030, 0, 0, "\\_XT2", 1)
			return (1)
		}

		// Check when RootPathString omitted

		Store(0, \DTM2.PLDT)

		Store(LoadTable("OEM1", "", "", , PPST, 1), DDB0)

		if (CH03(arg0, z176, 0x031, 0, 0)) {
			return (1)
		}

		if (y260) {
			Store(ObjectType(DDB0), Local1)
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z176, 0x032, 0, 0, Local1, c017)
				return (1)
			}
		}

		if (LNotEqual(1, \DTM2.PLDT)) {
			err(arg0, z176, 0x033, 0, 0, \DTM2.PLDT, 1)
		}

		if (CondRefof(\_XT2, Local0)) {
		} else {
			err(arg0, z176, 0x034, 0, 0, "\\_XT2", 0)
		}

		UnLoad(DDB0)
		Store("OEM1 unloaded", Debug)

		if (CH03(arg0, z176, 0x035, 0, 0)) {
			return (1)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x036, 0, 0, "\\_XT2", 1)
		}

		// Check when ParameterPathString omitted

		Store(0, \DTM2.PLDT)

		Store(LoadTable("OEM1", "", "", "\\", , 1), DDB1)

		if (CH03(arg0, z176, 0x037, 0, 0)) {
			return (1)
		}

		if (y260) {
			Store(ObjectType(DDB1), Local1)
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z176, 0x038, 0, 0, Local1, c017)
				return (1)
			}
		}

		if (LNotEqual(0, \DTM2.PLDT)) {
			err(arg0, z176, 0x039, 0, 0, \DTM2.PLDT, 0)
		}

		if (CondRefof(\_XT2, Local0)) {
		} else {
			err(arg0, z176, 0x03a, 0, 0, "\\_XT2", 0)
		}

		UnLoad(DDB1)
		Store("OEM1 unloaded", Debug)

		if (CH03(arg0, z176, 0x03b, 0, 0)) {
			return (1)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x03c, 0, 0, "\\_XT2", 1)
		}

		// Check when ParameterData omitted

		Store(0, \DTM2.PLDT)

		Store(LoadTable("OEM1", "", "", "\\", PPST, ), DDB2)

		if (CH03(arg0, z176, 0x03d, 0, 0)) {
			return (1)
		}

		if (y260) {
			Store(ObjectType(DDB2), Local1)
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z176, 0x03e, 0, 0, Local1, c017)
				return (1)
			}
		}

		if (LNotEqual(0, \DTM2.PLDT)) {
			err(arg0, z176, 0x03f, 0, 0, \DTM2.PLDT, 0)
		}

		if (CondRefof(\_XT2, Local0)) {
		} else {
			err(arg0, z176, 0x040, 0, 0, "\\_XT2", 0)
		}

		UnLoad(DDB2)
		Store("OEM1 unloaded", Debug)

		if (CH03(arg0, z176, 0x041, 0, 0)) {
			return (1)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x042, 0, 0, "\\_XT2", 1)
		}

		// Check when all optional parameters omitted

		Store(0, \DTM2.PLDT)

		Store(LoadTable("OEM1", "", "", , , ), DDB3)

		if (CH03(arg0, z176, 0x043, 0, 0)) {
			return (1)
		}

		if (y260) {
			Store(ObjectType(DDB3), Local1)
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z176, 0x044, 0, 0, Local1, c017)
				return (1)
			}
		}

		if (LNotEqual(0, \DTM2.PLDT)) {
			err(arg0, z176, 0x045, 0, 0, \DTM2.PLDT, 0)
		}

		if (CondRefof(\_XT2, Local0)) {
		} else {
			err(arg0, z176, 0x046, 0, 0, "\\_XT2", 0)
		}

		UnLoad(DDB3)
		Store("OEM1 unloaded", Debug)

		if (CH03(arg0, z176, 0x047, 0, 0)) {
			return (1)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x048, 0, 0, "\\_XT2", 1)
		}

		return (0)
	}

	// Different sources of the String parameters: Named Objects, LocalX,
	// ArgX, elements of Packages, results of functions, any TermArg
	Method(tst3, 1, Serialized)
	{
		Name(DDB0, 0)
		Name(DDB1, 0)
		Name(DDB2, 0)
		Name(DDB3, 0)
		Name(DDB4, 0)
		Name(DDB5, 0)
		Name(DDB6, 0)

		Name(SOID, "")
		Name(STID, "")

		Name(POEM, Package(3) {"OEM1", "", ""})

		Method(m000, 1) {Return (arg0)}

		Method(m001, 3)
		{
			Concatenate(arg0, arg2, arg0)

			if (CH03(arg0, z176, 0x051, 0, 0)) {
				return (1)
			}

			if (y260) {
				Store(ObjectType(arg1), Local1)
				if (LNotEqual(Local1, c017)) { // DDB Handle
					err(arg0, z176, 0x052, 0, 0, Local1, c017)
					return (1)
				}
			}

			if (LNotEqual(0, \DTM2.PLDT)) {
				err(arg0, z176, 0x053, 0, 0, \DTM2.PLDT, 0)
			}

			if (CondRefof(\_XT2, Local0)) {
			} else {
				err(arg0, z176, 0x054, 0, 0, "\\DTM2._XT2", 0)
			}

			UnLoad(arg1)
			Store("OEM1 unloaded", Debug)

			if (CH03(arg0, z176, 0x055, 0, 0)) {
				return (1)
			}

			if (CondRefof(\_XT2, Local0)) {
				err(arg0, z176, 0x056, 0, 0, "\\DTM2._XT2", 1)
				return (1)
			}

			return (0)
		}

		Method(m002, 3)
		{
			return (LoadTable(Arg0, Derefof(Arg1), Derefof(Arg2), , , ))
		}

		Method(m003, 3)
		{
			return (LoadTable(Derefof(Arg0), Arg1, Derefof(Arg2), , , ))
		}

		Method(m004, 3)
		{
			return (LoadTable(Derefof(Arg0), Derefof(Arg1), Arg2, , , ))
		}

		Concatenate(arg0, "-tst3", arg0)

		if (y281) {
			Store(^SOID, SOID)
			Store(^STID, STID)
			Store(^POEM, POEM)
		}

		if (CondRefof(\DTM2._XT2, Local0)) {
			err(arg0, z176, 0x057, 0, 0, "\\_XT2", 1)
			return (1)
		}

		// Check LoadTable(Named, LocalX, Method(), , , )

		Store(0, \DTM2.PLDT)

		Store(SOID, Local2)

		Store(LoadTable(SOEM, Local2, m000(STID), , , ), DDB0)

		if (m001(arg0, DDB0, ".NLM")) {
			return (1)
		}

		// Check LoadTable(Method(), Named, LocalX, , , )

		Store(0, \DTM2.PLDT)

		Store(STID, Local2)

		Store(LoadTable(m000(SOEM), SOID, Local2, , , ), DDB1)

		if (m001(arg0, DDB1, ".MNL")) {
			return (1)
		}

		// Check LoadTable(LocalX, Method(), Named, , , )

		Store(0, \DTM2.PLDT)

		Store(SOEM, Local2)

		Store(LoadTable(Local2, m000(SOID), STID, , , ), DDB2)

		if (m001(arg0, DDB2, ".LMN")) {
			return (1)
		}

		// Check LoadTable(ArgX, Derefof(Refof), Derefof(Index), , , )

		Store(0, \DTM2.PLDT)

		Store(Refof(SOID), Local2)
		Store(Index(POEM, 2), Local3)

		Store(m002(SOEM, Local2, Local3), DDB3)

		if (m001(arg0, DDB3, ".ARI")) {
			return (1)
		}

		// Check LoadTable(Derefof(Index), ArgX, Derefof(Refof), , , )

		Store(0, \DTM2.PLDT)

		Store(Refof(STID), Local2)
		Store(Index(POEM, 0), Local3)

		Store(m003(Local3, SOID, Local2), DDB4)

		if (m001(arg0, DDB4, ".IAR")) {
			return (1)
		}

		// Check LoadTable(Derefof(Refof), Derefof(Index), ArgX, , , )

		Store(0, \DTM2.PLDT)

		Store(Refof(SOEM), Local2)
		Store(Index(POEM, 1), Local3)

		Store(m004(Local2, Local3, STID), DDB5)

		if (m001(arg0, DDB5, ".RIA")) {
			return (1)
		}

		// Check LoadTable(TermArg, TermArg, TermArg, , , )

		Store(0, \DTM2.PLDT)

		Store(Concatenate("term", SOEM), Local2)
		Store(ToBuffer(Local2), Local2)

		Store(ToBuffer(SOID), Local3)

		Store("", Local4)

		Store(LoadTable(
				Mid(ToString(Local2), 4, 4),
				ToString(m000(Local3)),
				Concatenate(m000(STID), Local4), , , ),
			DDB6)

		if (m001(arg0, DDB6, ".TTT")) {
			return (1)
		}

		return (0)
	}

	// Different sources of the optional parameters (RootPathString,
	// ParameterPathString, and ParameterData): Named Objects, LocalX,
	// ArgX, elements of Packages, results of functions, any TermArg
	Method(tst4, 1, Serialized)
	{
		Name(DDB0, 0)
		Name(DDB1, 0)
		Name(DDB2, 0)
		Name(DDB3, 0)
		Name(DDB4, 0)
		Name(DDB5, 0)
		Name(DDB6, 0)

		Name(RPST, "\\DTM2")
		Name(PPST, "\\DTM2.PLDT")
		Name(NVAL, 1)
		Name(POPT, Package(3) {"\\DTM2", "\\DTM2.PLDT", 1})

		Method(m000, 1) {Return (arg0)}

		Method(m001, 3)
		{
			Concatenate(arg0, arg2, arg0)

			if (CH03(arg0, z176, 0x061, 0, 0)) {
				return (1)
			}

			if (y260) {
				Store(ObjectType(arg1), Local1)
				if (LNotEqual(Local1, c017)) { // DDB Handle
					err(arg0, z176, 0x062, 0, 0, Local1, c017)
					return (1)
				}
			}

			if (LNotEqual(1, \DTM2.PLDT)) {
				err(arg0, z176, 0x063, 0, 0, \DTM2.PLDT, 1)
			}

			if (CondRefof(\DTM2._XT2, Local0)) {
			} else {
				err(arg0, z176, 0x064, 0, 0, "\\DTM2._XT2", 0)
			}

			UnLoad(arg1)
			Store("OEM1 unloaded", Debug)

			if (CH03(arg0, z176, 0x065, 0, 0)) {
				return (1)
			}

			if (CondRefof(\DTM2._XT2, Local0)) {
				err(arg0, z176, 0x066, 0, 0, "\\DTM2._XT2", 1)
				return (1)
			}

			return (0)
		}

		Method(m002, 3)
		{
// Bug 288: iASL unexpectedly forbids ParameterData of Loadtable to be LocalX or UserTerm
//			return (LoadTable("OEM1", "", "", Arg0, Derefof(Arg1), Derefof(Arg2)))
//	                                        parse error, expecting `')'' ^
			return (LoadTable("OEM1", "", "", Arg0, Derefof(Arg1), 1))
		}

		Method(m003, 3)
		{
// Bug 288: iASL unexpectedly forbids ParameterData of Loadtable to be LocalX or UserTerm
//			return (LoadTable("OEM1", "", "", Derefof(Arg0), Arg1, Derefof(Arg2)))
//	                                        parse error, expecting `')'' ^
			return (LoadTable("OEM1", "", "", Derefof(Arg0), Arg1, 1))
		}

		Method(m004, 3)
		{
// Bug 288: iASL unexpectedly forbids ParameterData of Loadtable to be LocalX or UserTerm
//			return (LoadTable("OEM1", "", "", Derefof(Arg0), Derefof(Arg1), Arg2))
//	                                              parse error, expecting `')'' ^
			return (LoadTable("OEM1", "", "", Derefof(Arg0), Derefof(Arg1), 1))
		}

		Concatenate(arg0, "-tst4", arg0)

		if (CondRefof(\DTM2._XT2, Local0)) {
			err(arg0, z176, 0x067, 0, 0, "\\DTM2._XT2", 1)
			return (1)
		}

		// Check LoadTable(..., Named, LocalX, Method())

		Store(0, \DTM2.PLDT)

		Store(PPST, Local2)

// Bug 288: iASL unexpectedly forbids ParameterData of Loadtable to be LocalX or UserTerm
//		Store(LoadTable("OEM1", "", "", RPST, Local2, m000(1)), DDB0)
//	                         parse error, expecting `')'' ^
		Store(LoadTable("OEM1", "", "", RPST, Local2, 1), DDB0)

		if (m001(arg0, DDB0, ".NLM")) {
			return (1)
		}

		// Check LoadTable(..., Method(), Named, LocalX)

		Store(0, \DTM2.PLDT)

		Store(1, Local2)

// Bug 288: iASL unexpectedly forbids ParameterData of Loadtable to be LocalX or UserTerm
//		Store(LoadTable("OEM1", "", "", m000(RPST), PPST, Local2), DDB1)
//	                              parse error, expecting `')'' ^
		Store(LoadTable("OEM1", "", "", m000(RPST), PPST, 1), DDB1)

		if (m001(arg0, DDB1, ".MNL")) {
			return (1)
		}

		// Check LoadTable(..., LocalX, Method(), Named)

		Store(0, \DTM2.PLDT)

		Store(RPST, Local2)

		Store(LoadTable("OEM1", "", "", Local2, m000(PPST), NVAL), DDB2)

		if (m001(arg0, DDB2, ".LMN")) {
			return (1)
		}

		// Check LoadTable(..., ArgX, Derefof(Refof), Derefof(Index))

		Store(0, \DTM2.PLDT)

		Store(Refof(PPST), Local2)
		Store(Index(POPT, 2), Local3)

		Store(m002(RPST, Local2, Local3), DDB3)

		if (m001(arg0, DDB3, ".ARI")) {
			return (1)
		}

		// Check LoadTable(..., Derefof(Index), ArgX, Derefof(Refof))

		Store(0, \DTM2.PLDT)

		Store(Refof(NVAL), Local2)
		Store(Index(POPT, 0), Local3)

		Store(m003(Local3, PPST, Local2), DDB4)

		if (m001(arg0, DDB4, ".ARI")) {
			return (1)
		}

		// Check LoadTable(..., Derefof(Refof), Derefof(Index), ArgX)

		Store(0, \DTM2.PLDT)

		Store(Refof(RPST), Local2)
		Store(Index(POPT, 1), Local3)

		Store(m004(Local2, Local3, NVAL), DDB5)

		if (m001(arg0, DDB5, ".ARI")) {
			return (1)
		}

		// Check LoadTable(..., TermArg, TermArg, TermArg)

		Store(0, \DTM2.PLDT)

		Store(Concatenate("term", RPST), Local2)
		Store(ToBuffer(Local2), Local2)

		Store(ToBuffer(PPST), Local3)

		Store(3, Local4)

		Store(LoadTable("OEM1", "", "",
				Mid(ToString(Local2), 4, 1),
				ToString(m000(Local3)),
// Bug 288: iASL unexpectedly forbids ParameterData of Loadtable to be LocalX or UserTerm
//				Subtract(m000(Local4), 2)),
				Subtract(3, 2)),
			DDB6)

		if (m001(arg0, DDB6, ".TTT")) {
			return (1)
		}

		return (0)
	}

	// Namespace location to load the Definition Block is determined
	// by the RootPathString parameter of Loadtable
	// Arg1: RootPathString
	Method(tst5, 2, Serialized)
	{
		Name(DDBH, 0)

		Concatenate(arg0, "-tst5", arg0)

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x070, 0, 0, "\\_XT2", 1)
			return (1)
		}

		if (CondRefof(\DTM2.DEVR._XT2, Local0)) {
			err(arg0, z176, 0x071, 0, 0, "\\DTM2.DEVR._XT2", 1)
			return (1)
		}

		Store(0, \DTM2.PLDT)

		Store(LoadTable("OEM1", "", "", Arg1, PPST, 1), DDBH)

		if (CH03(arg0, z176, 0x072, 0, 0)) {
			return (1)
		}

		if (y260) {
			Store(ObjectType(DDBH), Local1)
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z176, 0x073, 0, 0, Local1, c017)
				return (1)
			}
		}

		if (LNotEqual(1, \DTM2.PLDT)) {
			err(arg0, z176, 0x074, 0, 0, \DTM2.PLDT, 1)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x075, 0, 0, "\\_XT2", 1)
		}

		if (CondRefof(\DTM2.DEVR._XT2, Local0)) {
		} else {
			err(arg0, z176, 0x076, 0, 0, "\\DTM2.DEVR._XT2", 0)
		}

		UnLoad(DDBH)
		Store("OEM1 unloaded", Debug)

		if (CH03(arg0, z176, 0x077, 0, 0)) {
			return (1)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x078, 0, 0, "\\_XT2", 1)
		}

		if (CondRefof(\DTM2.DEVR._XT2, Local0)) {
			err(arg0, z176, 0x079, 0, 0, "\\DTM2.DEVR._XT2", 1)
		}

		return (0)
	}

	// "\" is assumed to be Namespace location to load the Definition
	// Block if RootPathString parameter is not specified
	Method(tst6, 1, Serialized)
	{
		Name(DDBH, 0)

		Concatenate(arg0, "-tst6", arg0)

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x080, 0, 0, "\\_XT2", 1)
			return (1)
		}

		Store(0, \DTM2.PLDT)

		Store(LoadTable("OEM1", "", "", , PPST, 1), DDBH)

		if (CH03(arg0, z176, 0x081, 0, 0)) {
			return (1)
		}

		if (y260) {
			Store(ObjectType(DDBH), Local1)
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z176, 0x082, 0, 0, Local1, c017)
				return (1)
			}
		}

		if (LNotEqual(1, \DTM2.PLDT)) {
			err(arg0, z176, 0x083, 0, 0, \DTM2.PLDT, 1)
		}

		if (CondRefof(\_XT2, Local0)) {
		} else {
			err(arg0, z176, 0x084, 0, 0, "\\_XT2", 0)
		}

		UnLoad(DDBH)
		Store("OEM1 unloaded", Debug)

		if (CH03(arg0, z176, 0x085, 0, 0)) {
			return (1)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x086, 0, 0, "\\_XT2", 1)
		}

		return (0)
	}

	// If the first character of ParameterPathString is a backslash
	// or caret character, then the path of the object set up on success
	// is ParameterPathString. It is RootPathString.ParameterPathString
	// in any case.
	Method(tst7, 1, Serialized)
	{
		Name(DDBH, 0)
		Name(PLDT, 0)

		Concatenate(arg0, "-tst7", arg0)

		Store(LoadTable("OEM1", "", "", RPST, "^TST7.PLDT", 1), DDBH)

		if (CH03(arg0, z176, 0x091, 0, 0)) {
			return (1)
		}

		if (y260) {
			Store(ObjectType(DDBH), Local1)
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z176, 0x092, 0, 0, Local1, c017)
				return (1)
			}
		}

		if (LNotEqual(1, PLDT)) {
			err(arg0, z176, 0x093, 0, 0, PLDT, 1)
		}

		UnLoad(DDBH)

		if (CH03(arg0, z176, 0x094, 0, 0)) {
			return (1)
		}

		Store(0, PLDT)
		Store(0, \DTM2.PLDT)

		Store(LoadTable("OEM1", "", "", RPST, "PLDT", 1), DDBH)

		if (CH03(arg0, z176, 0x095, 0, 0)) {
			return (1)
		}

		if (y260) {
			Store(ObjectType(DDBH), Local1)
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z176, 0x096, 0, 0, Local1, c017)
				return (1)
			}
		}

		if (LNotEqual(0, PLDT)) {
			err(arg0, z176, 0x097, 0, 0, PLDT, 0)
		}

		if (LNotEqual(1, \DTM2.PLDT)) {
			err(arg0, z176, 0x098, 0, 0, \DTM2.PLDT, 1)
		}

		UnLoad(DDBH)

		if (CH03(arg0, z176, 0x099, 0, 0)) {
			return (1)
		}

		return (0)
	}

	// Exceptions when the SignatureString is greater than four characters,
	// the OEMIDString is greater than six characters, or the OEMTableID is
	// greater than eight characters
	Method(tst8, 1, Serialized)
	{
		Name(DDBH, 0)

		Concatenate(arg0, "-tst8", arg0)

		Store(0, \DTM2.PLDT)

		// SignatureString is greater than four characters
		if (y287) {
			Store(LoadTable("OEM1X", "", "", RPST, PPST, 1), DDBH)
		} else {
			LoadTable("OEM1X", "", "", RPST, PPST, 1)
		}

		CH04(arg0, 0, 61, z176, 0x0a0, 0, 0)	// AE_AML_STRING_LIMIT

		if (LNotEqual(0, \DTM2.PLDT)) {
			err(arg0, z176, 0x0a1, 0, 0, \DTM2.PLDT, 1)

			if (y287) {
				return (1)
			} else {
				// Cleanup
				UnLoad(DDBH)
				Store(0, \DTM2.PLDT)
			}
		}

		// OEMIDString is greater than six characters
		LoadTable("OEM1", "IntelXX", "", RPST, PPST, 1)

		CH04(arg0, 0, 61, z176, 0x0a2, 0, 0)	// AE_AML_STRING_LIMIT

		if (LNotEqual(0, \DTM2.PLDT)) {
			err(arg0, z176, 0x0a3, 0, 0, \DTM2.PLDT, 1)
			return (1)
		}

		// OEMTableID is greater than eight characters
		LoadTable("OEM1", "", "ManyXXXXX", RPST, PPST, 1)

		CH04(arg0, 0, 61, z176, 0x0a4, 0, 0)	// AE_AML_STRING_LIMIT

		if (LNotEqual(0, \DTM2.PLDT)) {
			err(arg0, z176, 0x0a5, 0, 0, \DTM2.PLDT, 1)
			return (1)
		}

		return (0)
	}

	// Exceptions when some DSDT or SSDT matching the LoadTable parameters
	// is already loaded (actually on initial loading of tables listed in XSDT)
	Method(tst9, 1)
	{
		Concatenate(arg0, "-tst9", arg0)

		Store(0, \DTM2.PLDT)

		// SignatureString is "DSDT"
		LoadTable("DSDT", "", "", RPST, PPST, 1)

		CH04(arg0, 0, 7, z176, 0x0a6, 0, 0)	// AE_ALREADY_EXISTS

		if (LNotEqual(0, \DTM2.PLDT)) {
			err(arg0, z176, 0x0a7, 0, 0, \DTM2.PLDT, 1)
		}

		// SignatureString is "SSDT"
		LoadTable("SSDT", "", "", RPST, PPST, 1)

		CH04(arg0, 0, 7, z176, 0x0a8, 0, 0)	// AE_ALREADY_EXISTS

		if (LNotEqual(0, \DTM2.PLDT)) {
			err(arg0, z176, 0x0a9, 0, 0, \DTM2.PLDT, 1)
		}

		return (0)
	}

	// Exceptions when the matched table is already loaded
	Method(tsta, 1, Serialized)
	{
		Name(DDBH, 0)

		Concatenate(arg0, "-tsta", arg0)

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x0b0, 0, 0, "\\_XT2", 1)
			return (1)
		}

		Store(0, \DTM2.PLDT)

		Store(LoadTable("OEM1", "", "", "\\", PPST, 1), DDBH)

		if (CH03(arg0, z176, 0x0b1, 0, 0)) {
			return (1)
		}

		if (y260) {
			Store(ObjectType(DDBH), Local1)
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z176, 0x0b2, 0, 0, Local1, c017)
				return (1)
			}
		}

		if (LNotEqual(1, \DTM2.PLDT)) {
			err(arg0, z176, 0x0b3, 0, 0, \DTM2.PLDT, 1)
		}

		if (CondRefof(\_XT2, Local0)) {
		} else {
			err(arg0, z176, 0x0b4, 0, 0, "\\_XT2", 0)
		}

		Store(0, \DTM2.PLDT)

		LoadTable("OEM1", "", "", "\\DTM2", PPST, 1)

		CH04(arg0, 0, 7, z176, 0x0b5, 0, 0)	// AE_ALREADY_EXISTS

		if (LNotEqual(0, \DTM2.PLDT)) {
			err(arg0, z176, 0x0b6, 0, 0, \DTM2.PLDT, 0)
		}

		if (CondRefof(\DTM2._XT2, Local0)) {
			err(arg0, z176, 0x0b7, 0, 0, "\\DTM2._XT2", 1)
		}

		if (CondRefof(\_XT2, Local0)) {
		} else {
			err(arg0, z176, 0x0b8, 0, 0, "\\_XT2", 0)
		}

		UnLoad(DDBH)
		Store("OEM1 unloaded", Debug)

		if (CH03(arg0, z176, 0x0b9, 0, 0)) {
			return (1)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x0ba, 0, 0, "\\_XT2", 1)
		}

		return (0)
	}

	// Originated from ssdt4.asl: iasl -tc ssdt4.asl
	Name(BUF4, Buffer(){
		0x53,0x53,0x44,0x54,0x44,0x00,0x00,0x00,  /* 00000000    "SSDTD..." */
		0x02,0x08,0x69,0x41,0x53,0x4C,0x54,0x53,  /* 00000008    "..iASLTS" */
		0x4C,0x54,0x42,0x4C,0x30,0x30,0x30,0x31,  /* 00000010    "LTBL0001" */
		0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
		0x15,0x12,0x06,0x20,0x10,0x1F,0x5C,0x00,  /* 00000020    "... ..\." */
		0x08,0x5F,0x58,0x54,0x32,0x0D,0x61,0x62,  /* 00000028    "._XT2.ab" */
		0x73,0x6F,0x6C,0x75,0x74,0x65,0x20,0x6C,  /* 00000030    "solute l" */
		0x6F,0x63,0x61,0x74,0x69,0x6F,0x6E,0x20,  /* 00000038    "ocation " */
		0x6F,0x62,0x6A,0x00,
	})

	OperationRegion (IST4, SystemMemory, 0x600, 0x44)

	Field(IST4, ByteAcc, NoLock, Preserve) {
		RFU4, 0x220,
	}

	// Exceptions when there already is an previously loaded Object
	// referred by the path in the Namespace
	Method(tstb, 1, Serialized)
	{
		Name(DDBH, 0)

		Concatenate(arg0, "-tstb", arg0)

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x0c0, 0, 0, "\\_XT2", 1)
			return (1)
		}

		Store(BUF4, RFU4)
		Load(RFU4, DDBH)

		if (CH03(arg0, z176, 0x0c1, 0, 0)) {
			return (1)
		}

		if (y260) {
			Store(ObjectType(DDBH), Local1)
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z176, 0x0c2, 0, 0, Local1, c017)
				return (1)
			}
		}

		if (CondRefof(\_XT2, Local0)) {
		} else {
			err(arg0, z176, 0x0c3, 0, 0, "\\_XT2", 0)
		}

		Store(0, \DTM2.PLDT)

		LoadTable("OEM1", "", "", "\\", PPST, 1)

		CH04(arg0, 0, 7, z176, 0x0c4, 0, 0)	// AE_ALREADY_EXISTS

		if (LNotEqual(0, \DTM2.PLDT)) {
			err(arg0, z176, 0x0c5, 0, 0, \DTM2.PLDT, 0)
		}

		if (CondRefof(\_XT2, Local0)) {
		} else {
			err(arg0, z176, 0x0c6, 0, 0, "\\_XT2", 0)
		}

		UnLoad(DDBH)
		Store("SSDT unloaded", Debug)

		if (CH03(arg0, z176, 0x0c7, 0, 0)) {
			return (1)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x0c8, 0, 0, "\\_XT2", 1)
		}

		return (0)
	}

	// Exceptions when the object specified by the ParameterPathString
	// does not exist
	Method(tstc, 1)
	{
		Concatenate(arg0, "-tstc", arg0)

		LoadTable("DSDT", "", "", RPST, "\\DTM2.NULL", 1)

		CH04(arg0, 0, 5, z176, 0x0c9, 0, 0)	// AE_NOT_FOUND

		return (0)
	}

	// Exceptions when storing of data of the ParameterData data type
	// to the specified object is not allowed.
	Method(tstd, 1)
	{
		Concatenate(arg0, "-tstd", arg0)

		Store(0, \DTM2.PLDT)

		LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", \DTM2.DEVR)

		CH04(arg0, 0, 47, z176, 0x0ca, 0, 0)	// AE_AML_OPERAND_TYPE

		if (LNotEqual(0, \DTM2.PLDT)) {
			err(arg0, z176, 0x0cb, 0, 0, \DTM2.PLDT, 0)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x0cc, 0, 0, "\\_XT2", 1)
		}

		return (0)
	}

	// Implicit operand conversion of the parameters specified to be strings
	Method(tste, 1, Serialized)
	{
		Name(DDBH, 2)
		Name(SOID, "")
		Name(STID, "")
		Name(RPST, "\\")
		Name(PPST, "DTM2.PLDT")
		Name(DSTR, "01234")

		Method(m000, 3, Serialized)
		{
			Name(DDBH, 2)

			Store(0, \DTM2.PLDT)

			Concatenate(arg0, "-m000.", arg0)
			Concatenate(arg0, Mid(DSTR, arg2, 1), arg0)

			Switch(ToInteger (arg2)) {
				Case(0) {
					LoadTable(arg1, SOID, STID, RPST, PPST, 1)
					return (CH04(arg0, 0, 61, z176, 0x0d0, 0, 0))// AE_AML_STRING_LIMIT
				}
				Case(1) {
					Store(LoadTable(SOEM, arg1, STID, RPST, PPST, 1), DDBH)
				}
				Case(2) {
					Store(LoadTable(SOEM, SOID, arg1, RPST, PPST, 1), DDBH)
				}
				Case(3) {
					LoadTable(SOEM, SOID, STID, arg1, PPST, 1)
					return (CH04(arg0, 0, 30, z176, 0x0d0, 0, 0)) // AE_BAD_PATHNAME
				}
				Case(4) {
					LoadTable(SOEM, SOID, STID, RPST, arg1, 1)
					return (CH04(arg0, 0, 30, z176, 0x0d1, 0, 0)) // AE_BAD_PATHNAME
				}
			}

			if (CH03(arg0, z176, 0x0d2, 0, 0)) {
				return (1)
			}

			if (LNotEqual(0, \DTM2.PLDT)) {
				err(arg0, z176, 0x0d3, 0, 0, \DTM2.PLDT, 0)
				return (1)
			}

			Store(ObjectType(DDBH), Local5)

			if (CH03(arg0, z176, 0x0d4, 0, 0)) {
				return (1)
			}

			if (LNotEqual(Local5, c009)) {	// Integer
				err(arg0, z176, 0x0d5, 0, 0, Local5, c009)
				return (1)
			}

			if (LNotEqual(0, DDBH)) {
				err(arg0, z176, 0x0d6, 0, 0, DDBH, 0)
				return (1)
			}

			return (0)
		}

		Concatenate(arg0, "-tste", arg0)

		if (y281) {
			Store(^SOID, SOID)
			Store(^STID, STID)
		}

		// Buffer to String implicit conversion, only check that then
		// no exception occurs. Actually due to the conversion rule
		// resulting strings will not match the table fields

		ToBuffer(SOEM, Local0)
		ToBuffer(SOID, Local1)
		ToBuffer(STID, Local2)
		ToBuffer(RPST, Local3)
		ToBuffer(PPST, Local4)

		if (m000(arg0, Local0, 0)) {return (1)}
		if (m000(arg0, Local1, 1)) {return (1)}
		if (m000(arg0, Local2, 2)) {return (1)}
		if (m000(arg0, Local3, 3)) {return (1)}
		if (m000(arg0, Local4, 4)) {return (1)}

		// Check consistency of the parameters

		if (LNotEqual(ToBuffer(SOEM), Local0)) {
			err(arg0, z176, 0x0d7, 0, 0, Local0, ToBuffer(SOEM))
			return (1)
		}

		if (LNotEqual(ToBuffer(SOID), Local1)) {
			err(arg0, z176, 0x0d8, 0, 0, Local1, ToBuffer(SOID))
			return (1)
		}

		if (LNotEqual(ToBuffer(STID), Local2)) {
			err(arg0, z176, 0x0d9, 0, 0, Local2, ToBuffer(STID))
			return (1)
		}

		if (LNotEqual(ToBuffer(RPST), Local3)) {
			err(arg0, z176, 0x0da, 0, 0, Local3, ToBuffer(RPST))
			return (1)
		}

		if (LNotEqual(ToBuffer(PPST), Local4)) {
			err(arg0, z176, 0x0db, 0, 0, Local4, ToBuffer(PPST))
			return (1)
		}

		// Integer to String implicit conversion

		ToInteger(Local0, Local0)
		ToInteger(Local1, Local1)
		ToInteger(Local2, Local2)
		ToInteger(Local3, Local3)
		ToInteger(Local4, Local4)

		if (m000(arg0, Local0, 0)) {return (1)}
		//if (m000(arg0, Local1, 1)) {return (1)}
		//if (m000(arg0, Local2, 2)) {return (1)}
		if (m000(arg0, Local3, 3)) {return (1)}
		if (m000(arg0, Local4, 4)) {return (1)}

		// Actual trivial Buffer to String implicit conversion

		if (y293) {
			if (CondRefof(\_XT2, Local0)) {
				err(arg0, z176, 0x0e0, 0, 0, "\\_XT2", 1)
				return (1)
			}

			Store(0, Local0)
			Store(Buffer(Local0){}, Local1)

			Store(0, \DTM2.PLDT)

			Store(LoadTable(SOEM, Local1, Local1, RPST, PPST, 1), DDBH)

			if (CH03(arg0, z176, 0x0e1, 0, 0)) {
				return (1)
			}

			if (LNotEqual(1, \DTM2.PLDT)) {
				err(arg0, z176, 0x0e2, 0, 0, \DTM2.PLDT, 1)
				return (1)
			}

			if (CondRefof(\_XT2, Local0)) {
			} else {
				err(arg0, z176, 0x0e3, 0, 0, "\\_XT2", 1)
				return (1)
			}

			UnLoad(DDBH)

			if (CH03(arg0, z176, 0x0e4, 0, 0)) {
				return (1)
			}

			if (CondRefof(\_XT2, Local0)) {
				err(arg0, z176, 0x0e5, 0, 0, "\\_XT2", 1)
				return (1)
			}
		}

		return (0)
	}

	// LoadTable returns 0 if some SSDT matching the LoadTable
	// parameters is originally not listed in XSDT
	/*
	 * This test should never happen in real ASL code. So it is removed.
	 *
	 * The Load operation will add a table to global table list, which is
	 * the master list that can be find in XSDT.
	 *
	 * The Unload operation will just delete the namespace owned by the table,
	 * release OwnerId and reset the table flag, but the table remains in
	 * global table list.
	 *
	 * So, LoadTable after Load and UnLoad operation will cause exception.
	 *
	 * Nothing like this should happen in real ASL code. The BIOS writer
	 * knows whether the table is in the XSDT or not.
	 */
	/*	
	Method(tstf, 1)
	{
		Name(DDBH, 0)

		Concatenate(arg0, "-tstf", arg0)

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x0f1, 0, 0, "\\_XT2", 1)
			return (1)
		}

		Store(BUF4, RFU4)
		Load(RFU4, DDBH)

		if (CH03(arg0, z176, 0x0f2, 0, 0)) {
			return (1)
		}

		if (y260) {
			Store(ObjectType(DDBH), Local1)
			if (LNotEqual(Local1, c017)) { // DDB Handle
				err(arg0, z176, 0x0f3, 0, 0, Local1, c017)
				return (1)
			}
		}

		if (CondRefof(\_XT2, Local0)) {
		} else {
			err(arg0, z176, 0x0f4, 0, 0, "\\_XT2", 0)
		}

		UnLoad(DDBH)
		Store("SSDT unloaded", Debug)

		if (CH03(arg0, z176, 0x0f5, 0, 0)) {
			return (1)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x0f6, 0, 0, "\\_XT2", 1)
			return (1)
		}

		Store(0, \DTM2.PLDT)

		if (y289) {
			LoadTable("SSDT", "iASLTS", "LTBL0001", "\\", PPST, 1)
		} else {
			Store(LoadTable("SSDT", "iASLTS", "LTBL0001", "\\", PPST, 1), DDBH)
		}

		CH04(arg0, 0, 28, z176, 0x0f7, 0, 0)	// AE_BAD_PARAMETER

		if (LNotEqual(0, \DTM2.PLDT)) {
			err(arg0, z176, 0x0f8, 0, 0, \DTM2.PLDT, 0)
		}

		if (CondRefof(\_XT2, Local0)) {
			err(arg0, z176, 0x0f9, 0, 0, "\\_XT2", 1)
			if (y289) {
				// Cleanup
				UnLoad(DDBH)
			}
		}

		return (0)
	}
	*/

	// AE_OWNER_ID_LIMIT exception when too many Tables loaded
	Method(tstg, 1)
	{
		Concatenate(arg0, "-tstg-\\DTM0", arg0)

		\DTM0.tsth(arg0, 1)
	}

	// Exceptions when the parameter of the Loadtable operator
	// is of incorrect types
	Method(tsth, 1, Serialized)
	{
		Name(DDB0, 0)
		Name(DDB1, 0)
		Name(BTYP, Buffer(){0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0})

		Method(m000, 4)
		{
			Concatenate(arg0, "-m000.", arg0)
			Concatenate(arg0, arg1, arg0)

			Store(ObjectType(arg2), Local0)
			if (LNotEqual(arg3, Local0)) {
				err(arg0, z176, 0x100, 0, 0, Local0, arg3)
				return (1)
			}

			LoadTable(Derefof(arg2), "", "", "\\", "\\DTM2.PLDT", 1)
			CH04(arg0, 0, 47, z176, 0x101, 0, 0)	// AE_AML_OPERAND_TYPE

			return (0)
		}

		Method(m001, 4)
		{
			Concatenate(arg0, "-m001.", arg0)
			Concatenate(arg0, arg1, arg0)

			Store(ObjectType(arg2), Local0)
			if (LNotEqual(arg3, Local0)) {
				err(arg0, z176, 0x102, 0, 0, Local0, arg3)
				return (1)
			}

			LoadTable("OEM1", Derefof(arg2), "", "\\", "\\DTM2.PLDT", 1)
			CH04(arg0, 0, 47, z176, 0x103, 0, 0)	// AE_AML_OPERAND_TYPE

			return (0)
		}

		Method(m002, 4)
		{
			Concatenate(arg0, "-m002.", arg0)
			Concatenate(arg0, arg1, arg0)

			Store(ObjectType(arg2), Local0)
			if (LNotEqual(arg3, Local0)) {
				err(arg0, z176, 0x104, 0, 0, Local0, arg3)
				return (1)
			}

			LoadTable("OEM1", "", Derefof(arg2), "\\", "\\DTM2.PLDT", 1)
			CH04(arg0, 0, 47, z176, 0x105, 0, 0)	// AE_AML_OPERAND_TYPE

			return (0)
		}

		Method(m003, 4)
		{
			Concatenate(arg0, "-m003.", arg0)
			Concatenate(arg0, arg1, arg0)

			Store(ObjectType(arg2), Local0)
			if (LNotEqual(arg3, Local0)) {
				err(arg0, z176, 0x106, 0, 0, Local0, arg3)
				return (1)
			}

			LoadTable("OEM1", "", "", Derefof(arg2), "\\DTM2.PLDT", 1)
			if (Derefof(Index(BTYP, arg3))) {
				CH04(arg0, 0, 30, z176, 0x107, 0, 0) // AE_BAD_PATHNAME
			} else {
				CH04(arg0, 0, 47, z176, 0x108, 0, 0) // AE_AML_OPERAND_TYPE
			}

			return (0)
		}

		Method(m004, 4)
		{
			Concatenate(arg0, "-m004.", arg0)
			Concatenate(arg0, arg1, arg0)

			Store(ObjectType(arg2), Local0)
			if (LNotEqual(arg3, Local0)) {
				err(arg0, z176, 0x109, 0, 0, Local0, arg3)
				return (1)
			}

			LoadTable("OEM1", "", "", "\\", Derefof(arg2), 1)
			if (Derefof(Index(BTYP, arg3))) {
				CH04(arg0, 0, 30, z176, 0x10a, 0, 0) // AE_BAD_PATHNAME
			} else {
				CH04(arg0, 0, 47, z176, 0x10b, 0, 0) // AE_AML_OPERAND_TYPE
			}

			return (0)
		}

		Concatenate(arg0, "-tsth", arg0)

		// Load Auxiliry table
		Store(\DTM0.BUF3, \DTM0.RFU3)
		Load(\DTM0.RFU3, DDB0)

		if (CH03(arg0, z176, 0x10c, 0, 0)) {
			return (1)
		}

		// Uninitialized
		if (0) {
			Store(0, Local1)
		}
		Store(ObjectType(Local1), Local0)
		if (LNotEqual(c008, Local0)) {
			err(arg0, z176, 0x10d, 0, 0, Local0, c008)
		} else {
			LoadTable(Local1, "", "", "\\", "\\DTM2.PLDT", 1)
			if (SLCK) {
				CH04(arg0, 0, 61, z176, 0x10e, 0, 0) // AE_AML_STRING_LIMIT
			} else {
				CH04(arg0, 0, 49, z176, 0x10e, 0, 0) // AE_AML_UNINITIALIZED_LOCAL
			}
			LoadTable("OEM1", Local1, "", "\\", "\\DTM2.PLDT", 1)
			if (SLCK) {
				CH04(arg0, 0, 61, z176, 0x10f, 0, 0) // AE_AML_STRING_LIMIT
			} else {
				CH04(arg0, 0, 49, z176, 0x10f, 0, 0) // AE_AML_UNINITIALIZED_LOCAL
			}
			LoadTable("OEM1", "", Local1, "\\", "\\DTM2.PLDT", 1)
			if (SLCK) {
				// ACPI_OEM_TABLE_ID_SIZE should be less than 8.
				// The size of the "Integer" converted from "Any" is ISZ0*2.
				if (LLessEqual(ISZ0, 4)) {
					CH03(arg0, z176, 0x110, 0, 0) // No exception
				} else {
					CH04(arg0, 0, 61, z176, 0x110, 0, 0) // AE_AML_STRING_LIMIT
				}
			} else {
				CH04(arg0, 0, 49, z176, 0x110, 0, 0) // AE_AML_UNINITIALIZED_LOCAL
			}
			LoadTable("OEM1", "", "", Local1, "\\DTM2.PLDT", 1)
			if (SLCK) {
				CH04(arg0, 0, 30, z176, 0x111, 0, 0) // AE_BAD_PATHNAME
			} else {
				CH04(arg0, 0, 49, z176, 0x111, 0, 0) // AE_AML_UNINITIALIZED_LOCAL
			}
			LoadTable("OEM1", "", "", "\\", Local1, 1)
			if (SLCK) {
				CH04(arg0, 0, 30, z176, 0x112, 0, 0) // AE_BAD_PATHNAME
			} else {
				CH04(arg0, 0, 49, z176, 0x112, 0, 0) // AE_AML_UNINITIALIZED_LOCAL
			}
		}

		// Integer
		m003(arg0, "int", Refof(\AUXD.INT0), c009)
		m004(arg0, "int", Refof(\AUXD.INT0), c009)

		// String
		m003(arg0, "str", Refof(\AUXD.STR0), c00a)
		m004(arg0, "str", Refof(\AUXD.STR0), c00a)

		// Buffer
		m003(arg0, "buf", Refof(\AUXD.BUF0), c00b)
		m004(arg0, "buf", Refof(\AUXD.BUF0), c00b)

		// Package
		if (y286) {
			m000(arg0, "pac", Refof(\AUXD.PAC0), c00c)
			m001(arg0, "pac", Refof(\AUXD.PAC0), c00c)
			m002(arg0, "pac", Refof(\AUXD.PAC0), c00c)
			m003(arg0, "pac", Refof(\AUXD.PAC0), c00c)
			m004(arg0, "pac", Refof(\AUXD.PAC0), c00c)
		}
		LoadTable(\AUXD.PAC0, "", "", "\\", "\\DTM2.PLDT", 1)
		CH04(arg0, 0, 47, z176, 0x113, 0, 0)	// AE_AML_OPERAND_TYPE
		LoadTable("OEM1", \AUXD.PAC0, "", "\\", "\\DTM2.PLDT", 1)
		CH04(arg0, 0, 47, z176, 0x114, 0, 0)	// AE_AML_OPERAND_TYPE
		LoadTable("OEM1", "", \AUXD.PAC0, "\\", "\\DTM2.PLDT", 1)
		CH04(arg0, 0, 47, z176, 0x115, 0, 0)	// AE_AML_OPERAND_TYPE
		LoadTable("OEM1", "", "", \AUXD.PAC0, "\\DTM2.PLDT", 1)
		CH04(arg0, 0, 47, z176, 0x116, 0, 0) // AE_AML_OPERAND_TYPE
		LoadTable("OEM1", "", "", "\\", \AUXD.PAC0, 1)
		CH04(arg0, 0, 47, z176, 0x117, 0, 0) // AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.PAC0), Local0)
		if (LNotEqual(c00c, Local0)) {
			err(arg0, z176, 0x118, 0, 0, Local0, c00c)
		}

		// Field Unit
		m003(arg0, "flu", Refof(\AUXD.FLU0), c00d)
		m004(arg0, "flu", Refof(\AUXD.FLU0), c00d)

		// Device
		LoadTable(\AUXD.DEV0, "", "", "\\", "\\DTM2.PLDT", 1)
		CH04(arg0, 0, 47, z176, 0x119, 0, 0)	// AE_AML_OPERAND_TYPE
		LoadTable("OEM1", \AUXD.DEV0, "", "\\", "\\DTM2.PLDT", 1)
		CH04(arg0, 0, 47, z176, 0x11a, 0, 0)	// AE_AML_OPERAND_TYPE
		LoadTable("OEM1", "", \AUXD.DEV0, "\\", "\\DTM2.PLDT", 1)
		CH04(arg0, 0, 47, z176, 0x11b, 0, 0)	// AE_AML_OPERAND_TYPE
		LoadTable("OEM1", "", "", \AUXD.DEV0, "\\DTM2.PLDT", 1)
		CH04(arg0, 0, 47, z176, 0x11c, 0, 0) // AE_AML_OPERAND_TYPE
		LoadTable("OEM1", "", "", "\\", \AUXD.DEV0, 1)
		CH04(arg0, 0, 47, z176, 0x11d, 0, 0) // AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.DEV0), Local0)
		if (LNotEqual(c00e, Local0)) {
			err(arg0, z176, 0x11e, 0, 0, Local0, c00e)
		}

		// Event
		m000(arg0, "evt", Refof(\AUXD.EVE0), c00f)
		m001(arg0, "evt", Refof(\AUXD.EVE0), c00f)
		m002(arg0, "evt", Refof(\AUXD.EVE0), c00f)
		m003(arg0, "evt", Refof(\AUXD.EVE0), c00f)
		m004(arg0, "evt", Refof(\AUXD.EVE0), c00f)

		// Method
		m000(arg0, "met", Refof(\AUXD.MMM0), c010)
		m001(arg0, "met", Refof(\AUXD.MMM0), c010)
		m002(arg0, "met", Refof(\AUXD.MMM0), c010)
		m003(arg0, "met", Refof(\AUXD.MMM0), c010)
		m004(arg0, "met", Refof(\AUXD.MMM0), c010)

		// Mutex
		m000(arg0, "mtx", Refof(\AUXD.MTX0), c011)
		m001(arg0, "mtx", Refof(\AUXD.MTX0), c011)
		m002(arg0, "mtx", Refof(\AUXD.MTX0), c011)
		m003(arg0, "mtx", Refof(\AUXD.MTX0), c011)
		m004(arg0, "mtx", Refof(\AUXD.MTX0), c011)

		// OpRegion
		m000(arg0, "opr", Refof(\AUXD.OPR0), c012)
		m001(arg0, "opr", Refof(\AUXD.OPR0), c012)
		m002(arg0, "opr", Refof(\AUXD.OPR0), c012)
		m003(arg0, "opr", Refof(\AUXD.OPR0), c012)
		m004(arg0, "opr", Refof(\AUXD.OPR0), c012)

		// Power Resource
		m000(arg0, "pwr", Refof(\AUXD.PWR0), c013)
		m001(arg0, "pwr", Refof(\AUXD.PWR0), c013)
		m002(arg0, "pwr", Refof(\AUXD.PWR0), c013)
		m003(arg0, "pwr", Refof(\AUXD.PWR0), c013)
		m004(arg0, "pwr", Refof(\AUXD.PWR0), c013)

		// Processor
		m000(arg0, "cpu", Refof(\AUXD.CPU0), c014)
		m001(arg0, "cpu", Refof(\AUXD.CPU0), c014)
		m002(arg0, "cpu", Refof(\AUXD.CPU0), c014)
		m003(arg0, "cpu", Refof(\AUXD.CPU0), c014)
		m004(arg0, "cpu", Refof(\AUXD.CPU0), c014)

		// Thermal Zone
		LoadTable(\AUXD.TZN0, "", "", "\\", "\\DTM2.PLDT", 1)
		CH04(arg0, 0, 47, z176, 0x120, 0, 0)	// AE_AML_OPERAND_TYPE
		LoadTable("OEM1", \AUXD.TZN0, "", "\\", "\\DTM2.PLDT", 1)
		CH04(arg0, 0, 47, z176, 0x121, 0, 0)	// AE_AML_OPERAND_TYPE
		LoadTable("OEM1", "", \AUXD.TZN0, "\\", "\\DTM2.PLDT", 1)
		CH04(arg0, 0, 47, z176, 0x122, 0, 0)	// AE_AML_OPERAND_TYPE
		LoadTable("OEM1", "", "", \AUXD.TZN0, "\\DTM2.PLDT", 1)
		CH04(arg0, 0, 47, z176, 0x123, 0, 0) // AE_AML_OPERAND_TYPE
		LoadTable("OEM1", "", "", "\\", \AUXD.TZN0, 1)
		CH04(arg0, 0, 47, z176, 0x124, 0, 0) // AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.TZN0), Local0)
		if (LNotEqual(c015, Local0)) {
			err(arg0, z176, 0x125, 0, 0, Local0, c015)
		}

		// Buffer Field
		m003(arg0, "bfl", Refof(\AUXD.BFL0), c016)
		m004(arg0, "bfl", Refof(\AUXD.BFL0), c016)

		UnLoad(DDB0)

		CH03(arg0, z176, 0x126, 0, 0)

		return (0)
	}

	// Exceptions when the ParameterData parameter of the Loadtable operator
	// can not be saved into the Object referred by ParameterPathString
	Method(tsti, 1, Serialized)
	{
		Name(DDB0, 0)
		Name(DDB1, 0)

		Concatenate(arg0, "-tsti", arg0)

		// Load Auxiliry table
		Store(\DTM0.BUF3, \DTM0.RFU3)
		Load(\DTM0.RFU3, DDB0)

		if (CH03(arg0, z176, 0x130, 0, 0)) {
			return (1)
		}

		// Uninitialized
		if (0) {
			Store(0, Local1)
		}
		Store(ObjectType(Local1), Local0)
		if (LNotEqual(c008, Local0)) {
			err(arg0, z176, 0x131, 0, 0, Local0, c008)
		} else {
// Bug 288: iASL unexpectedly forbids ParameterData of Loadtable to be LocalX or UserTerm
/*
			LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", Local1)
			if (SLCK) {
				CH04(arg0, 0, 47, z176, 0x132, 0, 0) // AE_AML_OPERAND_TYPE
			} else {
				CH04(arg0, 0, 49, z176, 0x132, 0, 0) // AE_AML_UNINITIALIZED_LOCAL
			}
*/
		}

		// Integer
		Store(ObjectType(\DTM2.PLDT), Local0)
		if (LNotEqual(c009, Local0)) {
			err(arg0, z176, 0x133, 0, 0, Local0, c009)
			return (1)
		}
		Store(LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", \AUXD.INT0), DDB1)
		if (CH03(arg0, z176, 0x134, 0, 0)) {
			return (1)
		}
		Store(ObjectType(\DTM2.PLDT), Local0)
		if (LNotEqual(c009, Local0)) {
			err(arg0, z176, 0x135, 0, 0, Local0, c009)
			return (1)
		}
		if (LNotEqual(\DTM2.PLDT, \AUXD.INT0)) {
			err(arg0, z176, 0x136, 0, 0, \DTM2.PLDT, \AUXD.INT0)
			return (1)
		}
		Unload(DDB1)
		if (CH03(arg0, z176, 0x137, 0, 0)) {
			return (1)
		}
		Store(ObjectType(\AUXD.INT0), Local0)
		if (LNotEqual(c009, Local0)) {
			err(arg0, z176, 0x138, 0, 0, Local0, c009)
		}

		// String
	if (y296) {
		Store(ObjectType(\DTM2.PLDT), Local0)
		if (LNotEqual(c009, Local0)) {
			err(arg0, z176, 0x139, 0, 0, Local0, c009)
			return (1)
		}
		Store(LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", \AUXD.STR0), DDB1)
		if (CH03(arg0, z176, 0x13a, 0, 0)) {
			return (1)
		}
		Store(ObjectType(\DTM2.PLDT), Local0)
		if (LNotEqual(c009, Local0)) {
			err(arg0, z176, 0x13b, 0, 0, Local0, c009)
			return (1)
		}
		if (LNotEqual(\DTM2.PLDT, \AUXD.STR0)) {
			err(arg0, z176, 0x13c, 0, 0, \DTM2.PLDT, \AUXD.STR0)
			return (1)
		}
		Unload(DDB1)
		if (CH03(arg0, z176, 0x13d, 0, 0)) {
			return (1)
		}
		Store(ObjectType(\AUXD.STR0), Local0)
		if (LNotEqual(c00a, Local0)) {
			err(arg0, z176, 0x13e, 0, 0, Local0, c00a)
		}
	}

		// Buffer
	if (y296) {
		Store(ObjectType(\DTM2.PLDT), Local0)
		if (LNotEqual(c009, Local0)) {
			err(arg0, z176, 0x13f, 0, 0, Local0, c009)
			return (1)
		}
		Store(LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", \AUXD.BUF0), DDB1)
		if (CH03(arg0, z176, 0x140, 0, 0)) {
			return (1)
		}
		Store(ObjectType(\DTM2.PLDT), Local0)
		if (LNotEqual(c009, Local0)) {
			err(arg0, z176, 0x141, 0, 0, Local0, c009)
			return (1)
		}
		if (LNotEqual(\DTM2.PLDT, \AUXD.BUF0)) {
			err(arg0, z176, 0x142, 0, 0, \DTM2.PLDT, \AUXD.BUF0)
			return (1)
		}
		Unload(DDB1)
		if (CH03(arg0, z176, 0x143, 0, 0)) {
			return (1)
		}
		Store(ObjectType(\AUXD.BUF0), Local0)
		if (LNotEqual(c00b, Local0)) {
			err(arg0, z176, 0x144, 0, 0, Local0, c00b)
		}
	}

		// Package
		LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", \AUXD.PAC0)
		CH04(arg0, 0, 47, z176, 0x145, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.PAC0), Local0)
		if (LNotEqual(c00c, Local0)) {
			err(arg0, z176, 0x146, 0, 0, Local0, c00c)
		}

		// Field Unit
	if (y296) {
		Store(ObjectType(\DTM2.PLDT), Local0)
		if (LNotEqual(c009, Local0)) {
			err(arg0, z176, 0x147, 0, 0, Local0, c009)
			return (1)
		}
		Store(LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", \AUXD.FLU0), DDB1)
		if (CH03(arg0, z176, 0x148, 0, 0)) {
			return (1)
		}
		Store(ObjectType(\DTM2.PLDT), Local0)
		if (LNotEqual(c009, Local0)) {
			err(arg0, z176, 0x149, 0, 0, Local0, c009)
			return (1)
		}
		if (LNotEqual(\DTM2.PLDT, \AUXD.FLU0)) {
			err(arg0, z176, 0x14a, 0, 0, \DTM2.PLDT, \AUXD.FLU0)
			return (1)
		}
		Unload(DDB1)
		if (CH03(arg0, z176, 0x14b, 0, 0)) {
			return (1)
		}
		Store(ObjectType(\AUXD.FLU0), Local0)
		if (LNotEqual(c00d, Local0)) {
			err(arg0, z176, 0x14c, 0, 0, Local0, c00d)
		}
	}

		// Device
		LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", \AUXD.DEV0)
		CH04(arg0, 0, 47, z176, 0x14d, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.DEV0), Local0)
		if (LNotEqual(c00e, Local0)) {
			err(arg0, z176, 0x14e, 0, 0, Local0, c00e)
		}

		// Event
		LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", \AUXD.EVE0)
		CH04(arg0, 0, 47, z176, 0x14f, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.EVE0), Local0)
		if (LNotEqual(c00f, Local0)) {
			err(arg0, z176, 0x150, 0, 0, Local0, c00f)
		}

		// Method
		if (y288) {
			LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", \AUXD.MMM0)
			CH04(arg0, 0, 47, z176, 0x151, 0, 0)	// AE_AML_OPERAND_TYPE
			Store(ObjectType(\AUXD.MMM0), Local0)
			if (LNotEqual(c010, Local0)) {
				err(arg0, z176, 0x152, 0, 0, Local0, c010)
			}
		}

		// Mutex
		LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", \AUXD.MTX0)
		CH04(arg0, 0, 47, z176, 0x153, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.MTX0), Local0)
		if (LNotEqual(c011, Local0)) {
			err(arg0, z176, 0x154, 0, 0, Local0, c011)
		}

		// OpRegion
		LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", \AUXD.OPR0)
		CH04(arg0, 0, 47, z176, 0x155, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.OPR0), Local0)
		if (LNotEqual(c012, Local0)) {
			err(arg0, z176, 0x156, 0, 0, Local0, c012)
		}

		// Power Resource
		LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", \AUXD.PWR0)
		CH04(arg0, 0, 47, z176, 0x157, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.PWR0), Local0)
		if (LNotEqual(c013, Local0)) {
			err(arg0, z176, 0x158, 0, 0, Local0, c013)
		}

		// Processor
		LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", \AUXD.CPU0)
		CH04(arg0, 0, 47, z176, 0x159, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.CPU0), Local0)
		if (LNotEqual(c014, Local0)) {
			err(arg0, z176, 0x15a, 0, 0, Local0, c014)
		}

		// Thermal Zone
		LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", \AUXD.TZN0)
		CH04(arg0, 0, 47, z176, 0x15b, 0, 0)	// AE_AML_OPERAND_TYPE
		Store(ObjectType(\AUXD.TZN0), Local0)
		if (LNotEqual(c015, Local0)) {
			err(arg0, z176, 0x15c, 0, 0, Local0, c015)
		}

		// Buffer Field
	if (y296) {
		Store(ObjectType(\DTM2.PLDT), Local0)
		if (LNotEqual(c009, Local0)) {
			err(arg0, z176, 0x15d, 0, 0, Local0, c009)
			return (1)
		}
		Store(LoadTable("OEM1", "", "", "\\", "\\DTM2.PLDT", \AUXD.BFL0), DDB1)
		if (CH03(arg0, z176, 0x15e, 0, 0)) {
			return (1)
		}
		Store(ObjectType(\DTM2.PLDT), Local0)
		if (LNotEqual(c009, Local0)) {
			err(arg0, z176, 0x15f, 0, 0, Local0, c009)
			return (1)
		}
		if (LNotEqual(\DTM2.PLDT, \AUXD.BFL0)) {
			err(arg0, z176, 0x160, 0, 0, \DTM2.PLDT, \AUXD.BFL0)
			return (1)
		}
		Unload(DDB1)
		if (CH03(arg0, z176, 0x161, 0, 0)) {
			return (1)
		}
		Store(ObjectType(\AUXD.BFL0), Local0)
		if (LNotEqual(c016, Local0)) {
			err(arg0, z176, 0x162, 0, 0, Local0, c016)
		}
	}

		UnLoad(DDB0)

		CH03(arg0, z176, 0x163, 0, 0)

		return (0)
	}
}

Method(TLT0,, Serialized)
{
	Name(ts, "TLT0")

	CH03(ts, z176, 0x200, 0, 0)

	// Simple Loadtable test
	SRMT("TLT0.tst0")
	\DTM2.tst0(ts)

	CH03(ts, z176, 0x201, 0, 0)

	// All comparisons of Loadtable parameters are case sensitive,
	// if no table matches the specified parameters, then 0 is returned
	SRMT("TLT0.tst1")
	\DTM2.tst1(ts)

	CH03(ts, z176, 0x202, 0, 0)

	// Any of the RootPathString, ParameterPathString, and ParameterData
	// parameters in LoadTable expression can be omitted
	SRMT("TLT0.tst2")
	\DTM2.tst2(ts)

	CH03(ts, z176, 0x203, 0, 0)

	// Different sources of the String parameters: Named Objects, LocalX,
	// ArgX, elements of Packages, results of functions, any TermArg
	SRMT("TLT0.tst3")
	\DTM2.tst3(ts)

	CH03(ts, z176, 0x204, 0, 0)

	// Different sources of the optional parameters (RootPathString,
	// ParameterPathString, and ParameterData): Named Objects, LocalX,
	// ArgX, elements of Packages, results of functions, any TermArg
	SRMT("TLT0.tst4")
	\DTM2.tst4(ts)

	CH03(ts, z176, 0x205, 0, 0)

	// Namespace location to load the Definition Block is determined
	// by the RootPathString parameter of Loadtable
	SRMT("TLT0.tst5.0")
	\DTM2.tst5(ts, "\\DTM2.DEVR")

	CH03(ts, z176, 0x206, 0, 0)

	// The RootPathString value is evaluated using normal scoping rules,
	// assuming that the scope of the LoadTable operator is the current
	// scope
	SRMT("TLT0.tst5.1")
	\DTM2.tst5(ts, "^DEVR")

	CH03(ts, z176, 0x207, 0, 0)

	// "\" is assumed to be Namespace location to load the Definition
	// Block if RootPathString parameter is not specified
	SRMT("TLT0.tst6")
	\DTM2.tst6(ts)

	CH03(ts, z176, 0x208, 0, 0)

	// If the first character of ParameterPathString is a backslash
	// or caret character, then the path of the object set up on success
	// is ParameterPathString. It is RootPathString.ParameterPathString
	// in any case.
	SRMT("TLT0.tst7")
	\DTM2.tst7(ts)

	CH03(ts, z176, 0x209, 0, 0)

	// Implicit operand conversion of the parameters specified to be strings
	SRMT("TLT0.tste")
	\DTM2.tste(ts)

	CH03(ts, z176, 0x20a, 0, 0)

	// LoadTable returns 0 if some SSDT matching the LoadTable
	// parameters is originally not listed in XSDT
	//SRMT("TLT0.tstf")
	//\DTM2.tstf(ts)

	CH03(ts, z176, 0x20b, 0, 0)
}

// Exceptional conditions
Method(TLT1,, Serialized)
{
	Name(ts, "TLT1")

	// Exceptions when the SignatureString is greater than four characters,
	// the OEMIDString is greater than six characters, or the OEMTableID is
	// greater than eight characters
	SRMT("TLT1.tst8")
	\DTM2.tst8(ts)

	// Exceptions when some DSDT or SSDT matching the LoadTable parameters
	// is already loaded (actually on initial loading of tables listed in XSDT)
	SRMT("TLT1.tst9")
	\DTM2.tst9(ts)

	// Exceptions when the matched table is already loaded
	SRMT("TLT1.tsta")
	\DTM2.tsta(ts)

	// Exceptions when there already is an previously loaded Object
	// referred by the path in the Namespace
	SRMT("TLT1.tstb")
	\DTM2.tstb(ts)

	// Exceptions when the object specified by the ParameterPathString
	// does not exist
	SRMT("TLT1.tstc")
	\DTM2.tstc(ts)

	// Exceptions when storing of data of the ParameterData data type
	// to the specified object is not allowed.
	SRMT("TLT1.tstd")
	\DTM2.tstd(ts)

	// AE_OWNER_ID_LIMIT exception when too many Tables loaded
	SRMT("TLT1.tstg")
	if (y294) {
		\DTM2.tstg(ts)
	} else {
		BLCK()
	}

	// Exceptions when the parameter of the Loadtable operator
	// is of incorrect types
	SRMT("TLT1.tsth")
	\DTM2.tsth(ts)

	// Exceptions when the ParameterData parameter of the Loadtable operator
	// can not be saved into the Object referred by ParameterPathString
	SRMT("TLT1.tsti")
	\DTM2.tsti(ts)
}
