/******************************************************************************
 *
 * Module Name: attable - ACPICA Table Management API tests
 *
 *****************************************************************************/

/******************************************************************************
 *
 * 1. Copyright Notice
 *
 * Some or all of this work - Copyright (c) 1999 - 2014, Intel Corp.
 * All rights reserved.
 *
 * 2. License
 *
 * 2.1. This is your license from Intel Corp. under its intellectual property
 * rights. You may have additional license terms from the party that provided
 * you this software, covering your right to use that party's intellectual
 * property rights.
 *
 * 2.2. Intel grants, free of charge, to any person ("Licensee") obtaining a
 * copy of the source code appearing in this file ("Covered Code") an
 * irrevocable, perpetual, worldwide license under Intel's copyrights in the
 * base code distributed originally by Intel ("Original Intel Code") to copy,
 * make derivatives, distribute, use and display any portion of the Covered
 * Code in any form, with the right to sublicense such rights; and
 *
 * 2.3. Intel grants Licensee a non-exclusive and non-transferable patent
 * license (with the right to sublicense), under only those claims of Intel
 * patents that are infringed by the Original Intel Code, to make, use, sell,
 * offer to sell, and import the Covered Code and derivative works thereof
 * solely to the minimum extent necessary to exercise the above copyright
 * license, and in no event shall the patent license extend to any additions
 * to or modifications of the Original Intel Code. No other license or right
 * is granted directly or by implication, estoppel or otherwise;
 *
 * The above copyright and patent license is granted only if the following
 * conditions are met:
 *
 * 3. Conditions
 *
 * 3.1. Redistribution of Source with Rights to Further Distribute Source.
 * Redistribution of source code of any substantial portion of the Covered
 * Code or modification with rights to further distribute source must include
 * the above Copyright Notice, the above License, this list of Conditions,
 * and the following Disclaimer and Export Compliance provision. In addition,
 * Licensee must cause all Covered Code to which Licensee contributes to
 * contain a file documenting the changes Licensee made to create that Covered
 * Code and the date of any change. Licensee must include in that file the
 * documentation of any changes made by any predecessor Licensee. Licensee
 * must include a prominent statement that the modification is derived,
 * directly or indirectly, from Original Intel Code.
 *
 * 3.2. Redistribution of Source with no Rights to Further Distribute Source.
 * Redistribution of source code of any substantial portion of the Covered
 * Code or modification without rights to further distribute source must
 * include the following Disclaimer and Export Compliance provision in the
 * documentation and/or other materials provided with distribution. In
 * addition, Licensee may not authorize further sublicense of source of any
 * portion of the Covered Code, and must include terms to the effect that the
 * license from Licensee to its licensee is limited to the intellectual
 * property embodied in the software Licensee provides to its licensee, and
 * not to intellectual property embodied in modifications its licensee may
 * make.
 *
 * 3.3. Redistribution of Executable. Redistribution in executable form of any
 * substantial portion of the Covered Code or modification must reproduce the
 * above Copyright Notice, and the following Disclaimer and Export Compliance
 * provision in the documentation and/or other materials provided with the
 * distribution.
 *
 * 3.4. Intel retains all right, title, and interest in and to the Original
 * Intel Code.
 *
 * 3.5. Neither the name Intel nor any other trademark owned or controlled by
 * Intel shall be used in advertising or otherwise to promote the sale, use or
 * other dealings in products derived from or relating to the Covered Code
 * without prior written authorization from Intel.
 *
 * 4. Disclaimer and Export Compliance
 *
 * 4.1. INTEL MAKES NO WARRANTY OF ANY KIND REGARDING ANY SOFTWARE PROVIDED
 * HERE. ANY SOFTWARE ORIGINATING FROM INTEL OR DERIVED FROM INTEL SOFTWARE
 * IS PROVIDED "AS IS," AND INTEL WILL NOT PROVIDE ANY SUPPORT, ASSISTANCE,
 * INSTALLATION, TRAINING OR OTHER SERVICES. INTEL WILL NOT PROVIDE ANY
 * UPDATES, ENHANCEMENTS OR EXTENSIONS. INTEL SPECIFICALLY DISCLAIMS ANY
 * IMPLIED WARRANTIES OF MERCHANTABILITY, NONINFRINGEMENT AND FITNESS FOR A
 * PARTICULAR PURPOSE.
 *
 * 4.2. IN NO EVENT SHALL INTEL HAVE ANY LIABILITY TO LICENSEE, ITS LICENSEES
 * OR ANY OTHER THIRD PARTY, FOR ANY LOST PROFITS, LOST DATA, LOSS OF USE OR
 * COSTS OF PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES, OR FOR ANY INDIRECT,
 * SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THIS AGREEMENT, UNDER ANY
 * CAUSE OF ACTION OR THEORY OF LIABILITY, AND IRRESPECTIVE OF WHETHER INTEL
 * HAS ADVANCE NOTICE OF THE POSSIBILITY OF SUCH DAMAGES. THESE LIMITATIONS
 * SHALL APPLY NOTWITHSTANDING THE FAILURE OF THE ESSENTIAL PURPOSE OF ANY
 * LIMITED REMEDY.
 *
 * 4.3. Licensee shall not export, either directly or indirectly, any of this
 * software or system incorporating such software without first obtaining any
 * required license or other approval from the U. S. Department of Commerce or
 * any other agency or department of the United States Government. In the
 * event Licensee exports any such software from the United States or
 * re-exports any such software from a foreign destination, Licensee shall
 * ensure that the distribution and export/re-export of the software is in
 * compliance with all laws, regulations, orders, or other restrictions of the
 * U.S. Export Administration Regulations. Licensee agrees that neither it nor
 * any of its subsidiaries will export/re-export any technical data, process,
 * software, or service, directly or indirectly, to any country for which the
 * United States government or any agency thereof requires an export license,
 * other governmental approval, or letter of assurance, without first obtaining
 * such license, approval or letter.
 *
 *****************************************************************************/

#include "atcommon.h"
#include "attable.h"
#include "atosxfctrl.h"

#define _COMPONENT          ACPI_TOOLS
        ACPI_MODULE_NAME    ("attable")

typedef struct at_sign_inst
{
    ACPI_STRING             Signature;
    UINT32                  Instance;
} AT_SIGN_INST;

#define ACPI_NUM_TABLE_TYPES            6

static char     *TableSignSet[] = {
    ACPI_SIG_RSDT,
    ACPI_SIG_DSDT,
    ACPI_SIG_FADT,
    ACPI_SIG_FACS,
    ACPI_SIG_PSDT,
    ACPI_SIG_SSDT,
    ACPI_SIG_XSDT,
    "",
    "SIG",
    "BAD_SIG",
    NULL,
};

static AT_SIGN_INST     TestSignInstOk[] = {
    {"FACP", 1}, /* FADT */
    {"SSDT", 1},
    {"SSDT", 2},
    {"SSDT", 3},
    {"PSDT", 1},
    {"OEM1", 1},
    {"DSDT", 1},
    {"FACS", 1},
};
static AT_SIGN_INST     TestSignInstError[] = {
    {"RSDT", 1},
    {"RSDP", 1},
    {"SSDT", 4},
    {"PSDT", 2},
    {"DSDT", 2},
};

/*
 * ASSERTION 0000:
 */
ACPI_STATUS
AtTableTest0000(void)
{
    ACPI_STATUS             Status;
    ACPI_STATUS             Benchmark = AE_BAD_PARAMETER;

    if (AT_SKIP_FIND_ROOT_PPOINTER_CHECK) {
        TestSkipped++;
        printf ("Skip: AcpiFindRootPointer(NULL) results in a crash\n");
        return (AE_OK);
    }
    Status = AcpiFindRootPointer(NULL);
    if (Status != Benchmark)
    {
        AapiErrors++;
        printf ("API Error: AcpiFindRootPointer(NULL) returned %s,\n"
            "           expected to return %s\n",
            AcpiFormatException(Status),
            AcpiFormatException(Benchmark));
        return (AE_ERROR);
    }
    return (AE_OK);
}

/*
 * ASSERTION 0001:
 */
ACPI_STATUS
AtTableTest0001(void)
{
    ACPI_STATUS             Status;
    ACPI_STATUS             Benchmark = AE_OK;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    Status = AtInitializeTables(FALSE);
    if (Status != Benchmark)
    {
        AapiErrors++;
        printf ("API Error: AcpiInitializeTables() returned %s,\n"
            "           expected to return %s\n",
            AcpiFormatException(Status),
            AcpiFormatException(Benchmark));
        return (AE_ERROR);
    }
    return (AE_OK);
}

/*
 * ASSERTION 0002:
 */
ACPI_STATUS
AtTableTest0002(void)
{
    ACPI_STATUS             Status;
    ACPI_STATUS             Benchmark = AE_OK;
    ACPI_TABLE_DESC         Tables[20];
    UINT32                  i;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    for (i = 0; i < 20; i++)
    {
        Status = AcpiInitializeTables(Tables, i, FALSE);
        if (Status != Benchmark)
        {
            AapiErrors++;
            printf ("API Error: AcpiInitializeTables( , 3, ) returned %s,\n"
                "           expected to return %s\n",
                AcpiFormatException(Status),
                AcpiFormatException(Benchmark));
            return (AE_ERROR);
        }
    }
    return (AE_OK);
}

/*
 * ASSERTION 0003:
 */
ACPI_STATUS
AtTableTest0003(void)
{
    ACPI_STATUS             Status;
    ACPI_STATUS             Benchmark = AE_NO_MEMORY;
    UINT32                  RMax = 3;
    UINT32                  i;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    /*
     * Mark the total number of AcpiOS* invocations
     */
    Status = OsxfCtrlCheck(TOTAL_STAT, 1);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error 1: AcpiOS* calls withoout Subsystem init., %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    for (i = 0; i < RMax; i++)
    {
        Status = AcpiInitializeTables(NULL, 20, FALSE);
        if (Status != Benchmark)
        {
            AapiErrors++;
            printf ("API Error: AcpiInitializeTables(NULL) returned %s,\n"
                "           expected to return %s\n",
                AcpiFormatException(Status),
                AcpiFormatException(Benchmark));
            return (AE_ERROR);
        }
    }

    /*
     * Check the total number of AcpiOS* invocations
     */
    Status = OsxfCtrlCheck(TOTAL_STAT, 1);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error 2: AcpiOS* calls during AcpiInitializeTables, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0004:
 */
ACPI_STATUS
AtTableTest0004(void)
{
    ACPI_STATUS             Status;
    ACPI_STATUS             Benchmark = AE_OK;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    Status = AtInitCommonTest(AAPITS_INITIALIZE_SS, 0, 0, 0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiInitializeTables(NULL, 20, FALSE);
    if (Status != Benchmark)
    {
        AapiErrors++;
        printf ("API Error: AcpiInitializeTables(NULL) returned %s,\n"
            "           expected to return %s\n",
            AcpiFormatException(Status),
            AcpiFormatException(Benchmark));
        return (AE_ERROR);
    }
    return (AE_OK);
}

/*
 * ASSERTION 0005:
 */

ACPI_STATUS
AtInitializeTablesExceptionTest1(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  TMax = 10000;
    UINT32                  i;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtInitializeTablesExceptionTest1: i = %d\n", i);

        Status = AtInitCommonTest(AAPITS_INITIALIZE_SS, 0, 0, 0, 0, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: OsxfCtrlSet returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiInitializeTables(NULL, 20, FALSE);

        if (!(OsxfNumAct = OsxfCtrlGetActOsxf(OsxfNum, 1)))
        {
            if (i == TFst)
            {
                TestSkipped++;
                printf ("Test note: test action hasn't occur\n");
            }
            TestPass++;
            Continue_Cond = 0;
        }
        else
        {
            if (Status != Benchmark)
            {
                AapiErrors++;
                printf ("API Error: AcpiInitializeTables returned %s,\n"
                    "           expected to return %s\n",
                    AcpiFormatException(Status), AcpiFormatException(Benchmark));
                return (AE_ERROR);
            }
        }

        Status = AtTerminateCtrlCheck(AE_OK, ALL_STAT);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }
    if (i >= TMax)
    {
        TestErrors++;
        printf ("Test error: there are test cases remained\n");
        return (AE_ERROR);
    }

    return (AE_OK);
}

ACPI_STATUS
AtTableTest0005(void)
{
    ACPI_STATUS             Status;

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtInitializeTablesExceptionTest1(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    return (AtInitializeTablesExceptionTest1(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY));
}

/*
 * ASSERTION 0006:
 */
ACPI_STATUS
AtTableTest0006(void)
{
    ACPI_STATUS             Status;
    ACPI_STATUS             Benchmark = AE_OK;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    Status = AtInitCommonTest(AAPITS_INITIALIZE_SS, 0, 0, 0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtInitializeTables(TRUE);
    if (Status != Benchmark)
    {
        AapiErrors++;
        printf ("API Error: AcpiInitializeTables( , , 1) returned %s,\n"
            "           expected to return %s\n",
            AcpiFormatException(Status),
            AcpiFormatException(Benchmark));
        return (AE_ERROR);
    }

    Status = AcpiReallocateRootTable();
    if (Status != Benchmark)
    {
        AapiErrors++;
        printf ("API Error: AcpiReallocateRootTable() returned %s,\n"
            "           expected to return %s\n",
            AcpiFormatException(Status),
            AcpiFormatException(Benchmark));
        return (AE_ERROR);
    }
    return (AE_OK);
}

ACPI_STATUS
AtReallocateRootTableExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  CtrlCheck = ALL_STAT;
    UINT32                  TMax = 10000;
    UINT32                  i;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtReallocateRootTableExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INITIALIZE_SS | AAPITS_INITABLES, 0, 0, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: OsxfCtrlSet returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiReallocateRootTable();

        if (!(OsxfNumAct = OsxfCtrlGetActOsxf(OsxfNum, 1)))
        {
            if (i == TFst)
            {
                TestSkipped++;
                printf ("Test note: test action hasn't occur\n");
            }
            TestPass++;
            Continue_Cond = 0;
        }
        else
        {
            if (Status != Benchmark)
            {
                AapiErrors++;
                printf ("API Error: AcpiReallocateRootTable returned %s,\n"
                    "           expected to return %s\n",
                    AcpiFormatException(Status), AcpiFormatException(Benchmark));
                return (AE_ERROR);
            }
        }

        Status = AtTerminateCtrlCheck(AE_OK, CtrlCheck);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }
    if (i >= TMax)
    {
        TestErrors++;
        printf ("Test error: there are test cases remained\n");
        return (AE_ERROR);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0007:
 */
ACPI_STATUS
AtTableTest0007(void)
{
    ACPI_STATUS             Status;

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtReallocateRootTableExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    return (AtReallocateRootTableExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY));
}

/*
 * ASSERTION 0008:
 */
ACPI_STATUS
AtTableTest0008(void)
{
    ACPI_STATUS             Status;
    ACPI_STATUS             Benchmark = AE_NO_MEMORY;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    /*
     * Mark the total number of AcpiOS* invocations
     */
    Status = OsxfCtrlCheck(TOTAL_STAT, 1);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error 1: AcpiOS* calls withoout Subsystem init., %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AtInitializeTables(TRUE);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiInitializeTables( , , 1) returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    Status = AcpiReallocateRootTable();
    if (Status != Benchmark)
    {
        AapiErrors++;
        printf ("API Error: AcpiReallocateRootTable() returned %s,\n"
            "           expected to return %s\n",
            AcpiFormatException(Status),
            AcpiFormatException(Benchmark));
        return (AE_ERROR);
    }

    /*
     * Check the total number of AcpiOS* invocations
     */
    Status = OsxfCtrlCheck(TOTAL_STAT, 1);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error 2: AcpiOS* calls during AcpiInitializeTables, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0009:
 */
ACPI_STATUS
AtTableTest0009(void)
{
    ACPI_STATUS             Status;
    ACPI_STATUS             Benchmark = AE_SUPPORT;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    /*
     * Mark the total number of AcpiOS* invocations
     */
    Status = OsxfCtrlCheck(TOTAL_STAT, 1);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error 1: AcpiOS* calls withoout Subsystem init., %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AtInitializeTables(FALSE);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiInitializeTables( , , 0) returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    Status = AcpiReallocateRootTable();
    if (Status != Benchmark)
    {
        AapiErrors++;
        printf ("API Error: AcpiReallocateRootTable() returned %s,\n"
            "           expected to return %s\n",
            AcpiFormatException(Status),
            AcpiFormatException(Benchmark));
        return (AE_ERROR);
    }

    /*
     * Check the total number of AcpiOS* invocations
     */
    Status = OsxfCtrlCheck(TOTAL_STAT, 1);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error 2: AcpiOS* calls during AcpiInitializeTables, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0010:
 */
ACPI_STATUS
AtTableTest0010(void)
{
    ACPI_STATUS             Status;
    ACPI_STATUS             Benchmark = AE_SUPPORT;
    int                     RMax = 5;
    int                     i;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    Status = AtInitCommonTest(AAPITS_INITIALIZE_SS, 0, 0, 0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiInitializeTables(NULL, 20, TRUE);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiInitializeTables(NULL) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    for (i = 0; i < RMax; i++)
    {
        Status = AcpiReallocateRootTable();
        if (Status != Benchmark)
        {
            AapiErrors++;
            printf ("API Error (%d): AcpiReallocateRootTable() returned %s,\n"
                "           expected to return %s\n",
                i, AcpiFormatException(Status),
                AcpiFormatException(Benchmark));
            return (AE_ERROR);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * Common test
 */
ACPI_STATUS
AtGetTableTest(
    UINT32                  StagesScale,
    AT_SIGN_INST            *TestSignInst,
    UINT32                  NumTables,
    ACPI_STATUS             Benchmark)
{
    ACPI_STATUS             Status;
    UINT32                  i;
    ACPI_TABLE_HEADER       *TablePointer;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    if (StagesScale)
    {
        Status = AtSubsystemInit(StagesScale,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    for (i = 0; i < NumTables; i++)
    {
        Status = AcpiGetTable(
            TestSignInst[i].Signature, TestSignInst[i].Instance,
            &TablePointer);
        if (Status != Benchmark)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetTable('%s', %d) returned %s,\n"
                "           expected to return %s\n",
                TestSignInst[i].Signature, TestSignInst[i].Instance,
                AcpiFormatException(Status), AcpiFormatException(Benchmark));
            return (AE_ERROR);
        }
    }

    if (StagesScale & AAPITS_INITIALIZE_SS)
    {
        return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
    }

    return (AE_OK);
}

/*
 * ASSERTION 0011:
 */
ACPI_STATUS
AtTableTest0011(void)
{
    return (AtGetTableTest(
        AAPITS_INITABLES,
        TestSignInstOk,
        sizeof (TestSignInstOk) / sizeof (AT_SIGN_INST),
        AE_OK));
}

/*
 * ASSERTION 0012:
 */
ACPI_STATUS
AtTableTest0012(void)
{
    return (AtGetTableTest(
        AAPITS_INI_PRELOAD & ~AAPITS_REALLOCROOTTABLE,
        TestSignInstOk,
        sizeof (TestSignInstOk) / sizeof (AT_SIGN_INST),
        AE_OK));
}

/*
 * ASSERTION 0013:
 */

ACPI_STATUS
AtInitializeTablesExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  TMax = 2;
    UINT32                  i;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtInitializeTablesExceptionTest: i = %d\n", i);

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: OsxfCtrlSet returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AtInitializeTables(FALSE);

        if (!(OsxfNumAct = OsxfCtrlGetActOsxf(OsxfNum, 1)))
        {
            if (i == TFst)
            {
                TestSkipped++;
                printf ("Test note: test action hasn't occur\n");
            }
            TestPass++;
            Continue_Cond = 0;
        }
        else
        {
            if (Status != Benchmark)
            {
                AapiErrors++;
                printf ("API Error: AcpiInitializeTables returned %s,\n"
                    "           expected to return %s\n",
                    AcpiFormatException(Status), AcpiFormatException(Benchmark));
                return (AE_ERROR);
            }
        }
    }
    return (AE_OK);
}

ACPI_STATUS
AtTableTest0013(void)
{
    /*
     * AcpiOsGetRootPointer returns AE_ERROR
     */
    return (AtInitializeTablesExceptionTest(
        OSXF_NUM(AcpiOsGetRootPointer),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NOT_FOUND));
}

ACPI_STATUS
AtGetTableExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       *TablePointer;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  CtrlCheck = ALL_STAT;
    UINT32                  TMax = 10000;
    UINT32                  i, j;

    if (AT_SKIP_MMAP_CHECK)
    {
        CtrlCheck &= ~MMAP_STAT;
    }

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtGetTableExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(AAPITS_INITIALIZE_SS, 0, 0, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: OsxfCtrlSet returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        j = (i - TFst) % (sizeof (TestSignInstOk) / sizeof (AT_SIGN_INST));

        Status = AcpiGetTable(
            TestSignInstOk[j].Signature, TestSignInstOk[j].Instance,
            &TablePointer);

        if (!(OsxfNumAct = OsxfCtrlGetActOsxf(OsxfNum, 1)))
        {
            if (i == TFst)
            {
                TestSkipped++;
                printf ("Test note: test action hasn't occur\n");
            }
            TestPass++;
            Continue_Cond = 0;
        }
        else
        {
            if (Status != Benchmark)
            {
                AapiErrors++;
                printf ("API Error: AcpiGetFirmwareTable returned %s,\n"
                    "           expected to return %s\n",
                    AcpiFormatException(Status), AcpiFormatException(Benchmark));
                return (AE_ERROR);
            }
        }

        Status = AtTerminateCtrlCheck(AE_OK, CtrlCheck);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }
    if (i >= TMax)
    {
        TestErrors++;
        printf ("Test error: there are test cases remained\n");
        return (AE_ERROR);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0014:
 */
ACPI_STATUS
AtTableTest0014(void)
{
    return (AtGetTableTest(
        AAPITS_INITABLES,
        TestSignInstError,
        sizeof (TestSignInstError) / sizeof (AT_SIGN_INST),
        AE_NOT_FOUND));
}

/*
 * ASSERTION 0015:
 */
ACPI_STATUS
AtTableTest0015(void)
{
    return (AtGetTableTest(
        AAPITS_INI_PRELOAD,
        TestSignInstOk,
        sizeof (TestSignInstOk) / sizeof (AT_SIGN_INST),
        AE_OK));
}

/*
 * ASSERTION 0016:
 */
ACPI_STATUS
AtTableTest0016(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    Status = AtInitializeTables(FALSE);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiInitializeTables() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AtSubsystemInit(
        (AAPITS_INI_PRELOAD & ~AAPITS_INITABLES) | AAPITS_LOADTABLES,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0017:
 */
ACPI_STATUS
AtTableTest0017(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(
        AAPITS_INI_PRELOAD | AAPITS_LOADTABLES,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0018:
 */
ACPI_STATUS
AtTableTest0018(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(
        AAPITS_INI_PRELOAD | AAPITS_LOADTABLES,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

ACPI_STATUS
AtLoadTablesInvalidTest(int Var)
{
    ACPI_STATUS             Status;
    int                     RMax = 5;
    int                     i;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));
    AtBuildLocalTables(UserTable, NullBldTask);

    /*
     * Mark the total number of AcpiOS* invocations
     */
    Status = OsxfCtrlCheck(TOTAL_STAT, 1);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error 1: AcpiOS* calls withoout Subsystem init., %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    if (Var)
    {
        Status = AtInitCommonTest(AAPITS_INITIALIZE_SS,
            AAPITS_INITIALIZE_SS, 0,
            0, 0, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    for (i = 0; i < RMax; i++)
    {
        if (i == (RMax - 2))
        {
            Status = AtInitializeTables(FALSE);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("API Error 2: AcpiInitializeTables returned %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
        }

        Status = AcpiLoadTables();
        if ((i < (RMax - 2)) && Status != AE_NO_ACPI_TABLES)
        {
            AapiErrors++;
            printf ("API Error 3-%d: AcpiLoadTables() returned %s,"
                " expected AE_NO_ACPI_TABLES\n",
                i, AcpiFormatException(Status));
            return (AE_ERROR);
        }
        else if ((i >= (RMax - 2)) && ACPI_SUCCESS(Status))
        {
            AapiErrors++;
            printf ("API Error 3-%d: AcpiLoadTables() returned %s,"
                " expected a FAILURE\n",
                i, AcpiFormatException(Status));
            return (AE_ERROR);
        }
    }

    /*
     * Check the total number of AcpiOS* invocations
     */
    Status = OsxfCtrlCheck(TOTAL_STAT, 1);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error 4: AcpiOS* calls during AcpiLoadTables, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0019:
 */
ACPI_STATUS
AtTableTest0019(void)
{
    return (AtLoadTablesInvalidTest(0));
}

/*
 * ASSERTION 0020:
 */
ACPI_STATUS
AtTableTest0020(void)
{
    return (AtLoadTablesInvalidTest(1));
}

/*
 * ASSERTION 0021:
 */
ACPI_STATUS
AtTableTest0021(void)
{
    ACPI_STATUS             Status;

    Status = AtInitCommonTest(AAPITS_INI_PRELOAD | AAPITS_LOADTABLES,
        AAPITS_LOADTABLES, 0,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0022:
 */
ACPI_STATUS
AtTableTest0022(void)
{
    ACPI_STATUS             Status;

    Status = AtInitCommonTest(
        (AAPITS_INI_PRELOAD & ~AAPITS_REALLOCROOTTABLE) | AAPITS_LOADTABLES,
        AAPITS_LOADTABLES, 0,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0023:
 */
ACPI_STATUS
AtTableTest0023(void)
{
    ACPI_STATUS             Status;
    int                     RMax = 3;
    int                     i;

    Status = AtSubsystemInit(
        AAPITS_INI_PRELOAD | AAPITS_LOADTABLES,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < RMax; i++)
    {
        Status = AtInitCommonTest(AAPITS_LOADTABLES,
            0, AAPITS_LOADTABLES,
            0, 0, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

UINT32
AtIsCheckedAttempt(
    UINT32                  Ind,
    UINT32                  NumTSkip,
    UINT32                  *TSkip)
{
    UINT32                  i;

    for (i = 0; i < NumTSkip / 2; i++)
    {
        if (TSkip[2 * i] <= Ind && Ind <= TSkip[2 * i + 1])
        {
            return (FALSE);
        }
    }
    return (TRUE);
}

ACPI_STATUS
AtLoadTablesExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark,
    UINT32                  NumTSkip,
    UINT32                  *TSkip)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  CtrlCheck = ALL_STAT;
    UINT32                  TMax = 10000;
    UINT32                  i;

    if (AT_SKIP_MMAP_CHECK)
    {
        CtrlCheck &= ~MMAP_STAT;
    }

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtLoadTablesExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(AAPITS_INI_PRELOAD, 0, 0, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: OsxfCtrlSet returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiLoadTables();

        if (!(OsxfNumAct = OsxfCtrlGetActOsxf(OsxfNum, 1)))
        {
            if (i == TFst)
            {
                TestSkipped++;
                printf ("Test note: test action hasn't occur\n");
            }
            TestPass++;
            Continue_Cond = 0;
        }
        else
        {
            if (Status != Benchmark && AtIsCheckedAttempt(i, NumTSkip, TSkip))
            {
                AapiErrors++;
                printf ("API Error: AcpiLoadTables returned %s,\n"
                    "           expected to return %s\n",
                    AcpiFormatException(Status),
                    AcpiFormatException(Benchmark));
                if (Status == AE_OK)
                {
                    return (AE_ERROR);
                }
            }
        }

        Status = AtTerminateCtrlCheck(AE_OK, CtrlCheck);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }
    if (i >= TMax)
    {
        TestErrors++;
        printf ("Test error: there are test cases remained\n");
        return (AE_ERROR);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0024:
 */
ACPI_STATUS
AtTableTest0024(void)
{
    ACPI_STATUS             Status;
    /* Skip a part of checks due to ignoring NS load errors for SSDT */
    UINT32                  TSkip[] = {7, 28};

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtLoadTablesExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY, sizeof (TSkip) / sizeof (UINT32), TSkip);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    return (AtLoadTablesExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY, sizeof (TSkip) / sizeof (UINT32), TSkip));
}

/*
 * AcpiInitializeTables errors common test
 */
ACPI_STATUS
AtInitializeTablesErrTest(
    UINT32 *ErrFlags, int NumCases, ACPI_STATUS *ErrBenchmarks)
{
    ACPI_STATUS             Status;
    int                     i;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;
    UINT32                  CtrlCheck = ALL_STAT;
    BLD_TABLES_TASK         BldTask = {0, 0};

    for (i = 0; i < NumCases; i++)
    {
        printf ("AtInitializeTablesErrTest: i = %d\n", i);

        Status = AtSubsystemInit(AAPITS_INITIALIZE_SS, 0, 0, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

        BldTask.ErrScale = ErrFlags[i];
        AtBuildLocalTables(UserTable, BldTask);

        Status = AtInitializeTables(FALSE);
        if (Status != ErrBenchmarks[i])
        {
            AapiErrors++;
            printf ("API Error: AcpiInitializeTables() returned %s,"
                " expected %s\n",
                AcpiFormatException(Status),
                AcpiFormatException(ErrBenchmarks[i]));
            return (AE_ERROR);
        }

        Status = AtTerminateCtrlCheck(AE_OK, CtrlCheck);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0025:
 */
ACPI_STATUS
AtTableTest0025(void)
{
    UINT32                  ErrFlags[] = {
        BAD_LENGTH_HDR_RSDT};
    ACPI_STATUS             ErrBenchmarks[] = {
        AE_INVALID_TABLE_LENGTH};

    return (AtInitializeTablesErrTest(ErrFlags,
        (sizeof (ErrFlags) / sizeof (UINT32)),
        ErrBenchmarks));
}

/*
 * ASSERTION 0026:
 */
ACPI_STATUS
AtTableTest0026(void)
{
    UINT32                  ErrFlags[] = {
        NOT_PRESENT_FADT,
//        BAD_SIGNATURE_FADT, /* the same affect as NOT_PRESENT_FADT */
        NULL_ADDRESS_FACS,
        NULL_ADDRESS_DSDT};
    ACPI_STATUS             ErrBenchmarks[] = {
        AE_NO_ACPI_TABLES,
//        AE_NO_ACPI_TABLES,
        AE_NO_ACPI_TABLES,
        AE_NO_ACPI_TABLES};

    return (AtInitializeTablesErrTest(ErrFlags,
        (sizeof (ErrFlags) / sizeof (UINT32)),
        ErrBenchmarks));
}

/*
 * AcpiLoadTables errors common test
 */
ACPI_STATUS
AtLoadTablesErrTest(UINT32 *ErrFlags, int NumCases, ACPI_STATUS *ErrBenchmarks)
{
    ACPI_STATUS             Status;
    int                     i;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;
    UINT32                  CtrlCheck = ALL_STAT;
    BLD_TABLES_TASK         BldTask = {0, 0};

    if (AT_SKIP_MALLOC_CHECK)
    {
        CtrlCheck &= ~MALLOC_STAT;
    }

    for (i = 0; i < NumCases; i++)
    {
        printf ("AtLoadTablesErrTest: i = %d\n", i);

        Status = AtSubsystemInit(AAPITS_INITIALIZE_SS, 0, 0, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

        BldTask.ErrScale = ErrFlags[i];
        AtBuildLocalTables(UserTable, BldTask);

        Status = AtInitializeTables(FALSE);
        if (ErrFlags[i] == BAD_CHECKSUM_RSDT ||
            ErrFlags[i] == BAD_CHECKSUM_FADT)
        {
            if (Status != ErrBenchmarks[i])
            {
                AapiErrors++;
                printf ("API Error: AcpiInitializeTables() returned %s,"
                    " expected %s\n",
                    AcpiFormatException(Status),
                    AcpiFormatException(ErrBenchmarks[i]));
                return (AE_ERROR);
            }
        }
        else
        {
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("API Error: AcpiInitializeTables() returned %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }

            Status = AcpiLoadTables();
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("API Error: AcpiLoadTables() returned %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }

            Status = AcpiEnableSubsystem(AAPITS_EN_FLAGS);
            if (Status != ErrBenchmarks[i])
            {
                AapiErrors++;
                printf ("API Error: AcpiEnableSubsystem() returned %s,"
                    " expected %s\n",
                    AcpiFormatException(Status),
                    AcpiFormatException(ErrBenchmarks[i]));
                return (AE_ERROR);
            }
        }

        Status = AtTerminateCtrlCheck(AE_OK, CtrlCheck);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0027:
 */
ACPI_STATUS
AtTableTest0027(void)
{
    UINT32                  ErrFlags[] = {
        /* BAD_CHECKSUM_RSDP,: is not cheked */
        BAD_CHECKSUM_RSDT,
        BAD_CHECKSUM_FADT,
        BAD_CHECKSUM_DSDT};
    ACPI_STATUS             ErrBenchmarks[] = {
        /* AE_BAD_CHECKSUM, */
#if (ACPI_CHECKSUM_ABORT)
        AE_BAD_CHECKSUM,
        AE_BAD_CHECKSUM,
        AE_NO_ACPI_TABLES
#else
        AE_OK,
        AE_OK,
        AE_OK
#endif
    };

    return (AtLoadTablesErrTest(ErrFlags,
        (sizeof (ErrFlags) / sizeof (UINT32)),
        ErrBenchmarks));
}

/*
 * ASSERTION 0028:
 */
ACPI_STATUS
AtTableTest0028(void)
{
    UINT32                  ErrFlags[] = {
        BAD_SIGNATURE_RSDT,
        BAD_SIGNATURE_FADT, /* the same affect as NOT_PRESENT_FADT */
        BAD_SIGNATURE_FACS,
        BAD_SIGNATURE_DSDT};
    ACPI_STATUS             ErrBenchmarks[] = {
        AE_OK,
        AE_OK,
        AE_BAD_SIGNATURE,
        AE_BAD_SIGNATURE};

    return (AtInitializeTablesErrTest(ErrFlags,
        (sizeof (ErrFlags) / sizeof (UINT32)),
        ErrBenchmarks));
}

/*
 * ASSERTION 0029:
 */
ACPI_STATUS
AtTableTest0029(void)
{
    UINT32                  ErrFlags[] = {
        BAD_LENGTH_HDR_FADT,
        BAD_LENGTH_HDR_FACS,
        BAD_LENGTH_HDR_DSDT};
    ACPI_STATUS             ErrBenchmarks[] = {
        AE_BAD_HEADER,
        AE_BAD_HEADER,
        AE_BAD_HEADER};

    if (AT_SKIP_FADT_BAD_HEADER_CHECK)
    {
        ErrBenchmarks[0] = AE_NO_ACPI_TABLES;
    }
    return (AtLoadTablesErrTest(ErrFlags,
        (sizeof (ErrFlags) / sizeof (UINT32)),
        ErrBenchmarks));
}

/*
 * ASSERTION 0030:
 */
ACPI_STATUS
AtTableTest0030(void)
{
    UINT32                  ErrFlags[] = {
        BAD_SIGNATURE_FACS,
        BAD_LENGTH_DSC_FADT,
        BAD_LENGTH_DSC_FACS};
    ACPI_STATUS             ErrBenchmarks[] = {
        AE_NOT_FOUND,
        AE_INVALID_TABLE_LENGTH,
        AE_INVALID_TABLE_LENGTH};

    return (AtLoadTablesErrTest(ErrFlags,
        (sizeof (ErrFlags) / sizeof (UINT32)),
        ErrBenchmarks));
}

/*
 * Common test
 */
ACPI_STATUS
AtGetTableByIndexTest(
    UINT32                  StagesScale,
    UINT32                  FirstInd,
    UINT32                  NumTables,
    ACPI_STATUS             Benchmark)
{
    ACPI_STATUS             Status;
    UINT32                  i = 0;
    ACPI_TABLE_HEADER       *TablePointer;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    if (StagesScale)
    {
        Status = AtSubsystemInit(StagesScale,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    for (i = FirstInd; i < (FirstInd + NumTables); i++)
    {
        Status = AcpiGetTableByIndex(i, &TablePointer);
        if (Status != Benchmark)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetTableByIndex(%d) returned %s,\n"
                "           expected to return %s\n",
                i,
                AcpiFormatException(Status), AcpiFormatException(Benchmark));
            return (AE_ERROR);
        }
    }

    if (StagesScale & AAPITS_INITIALIZE_SS)
    {
        return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
    }

    return (AE_OK);
}

/*
 * ASSERTION 0031:
 */
ACPI_STATUS
AtTableTest0031(void)
{
    return (AtGetTableByIndexTest(
        AAPITS_INITABLES,
        0, 8,
        AE_OK));
}

/*
 * ASSERTION 0032:
 */
ACPI_STATUS
AtTableTest0032(void)
{
    return (AtGetTableByIndexTest(
        AAPITS_INI_PRELOAD,
        0, 10,
        AE_OK));
}

/*
 * ASSERTION 0033:
 */
ACPI_STATUS
AtTableTest0033(void)
{
    return (AtGetTableByIndexTest(
        AAPITS_INI_PRELOAD,
        10, 3,
        AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0034:
 */
ACPI_STATUS
AtTableTest0034(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    Status = AtSubsystemInit(
        AAPITS_INI_PRELOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < 8; i++)
    {
        Status = AcpiGetTableByIndex(i, NULL);
        if (Status != AE_BAD_PARAMETER)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetTableByIndex(%d, NULL) returned %s,"
                " expected AE_BAD_PARAMETER\n",
                i, AcpiFormatException(Status));
            return (AE_ERROR);
        }
    }

    return (AE_OK);
}

ACPI_STATUS
AtTableTest0035(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       *OutTable;
    UINT32                  i;
    UINT32                  OutInd = 0;
    UINT32                  SanityLimitInd = 1000;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("tblm0047.aml")))
    {
        return (Status);
    }

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiEvaluateObject (NULL, "\\INIT",
        NULL, NULL);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error : AcpiEvaluateObject(INIT) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    /*
     * Find the first index out of the registered Tables range
     */
    while (1)
    {
        Status = AcpiGetTableByIndex(OutInd, &OutTable);
        if (ACPI_FAILURE(Status))
        {
            if (Status != AE_BAD_PARAMETER)
            {
                AapiErrors++;
                printf ("API Error: AcpiGetTableByIndex(%d) returned %s,"
                    " expected AE_BAD_PARAMETER\n",
                    OutInd, AcpiFormatException(Status));
                return (AE_ERROR);
            }
            break;
        }
        if (++OutInd > SanityLimitInd)
        {
            AapiErrors++;
            printf ("API Error: Success of AcpiGetTableByIndex(%d)"
                " out of the registered Tables range\n",
                SanityLimitInd);
            return (AE_ERROR);
        }
    }

    for (i = 0; i < 17; i++)
    {
        Status = AcpiEvaluateObject (NULL, "\\_PR_.CPU0._PPC",
            NULL, NULL);
        if (Status != AE_NOT_FOUND)
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(_PR_.CPU0._PPC)"
                " returned %s, expected AE_NOT_FOUND\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiEvaluateObject (NULL, "\\LD__",
            NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(LD) returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiEvaluateObject (NULL, "\\_PR_.CPU0._PPC",
            NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(_PR_.CPU0._PPC) returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiGetTableByIndex(OutInd, &OutTable);
        if (Status != AE_OK)
        {
            AapiErrors++;
            printf ("API Error %d: AcpiGetTableByIndex(%d) returned %s\n",
                    i, OutInd, AcpiFormatException(Status));
            return (AE_ERROR);
        }

        Status = AcpiEvaluateObject (NULL, "\\UNLD",
            NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(UNLD) returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiGetTableByIndex(OutInd, &OutTable);
        if (Status != AE_OK)
        {
            AapiErrors++;
            printf ("API Error %d(UNLD): AcpiGetTableByIndex(%d) returned %s\n",
                i, OutInd, AcpiFormatException(Status));
            return (AE_ERROR);
        }
    }

    Status = AcpiGetTableByIndex(OutInd + 1, &OutTable);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("API Error: AcpiGetTableByIndex(%d) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            OutInd + 1, AcpiFormatException(Status));
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0036:
 */
ACPI_STATUS
AtTableTest0036(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       *OutTable;
    UINT32                  i;
    UINT32                  OutInd = 10;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("tblm0047.aml")))
    {
        return (Status);
    }

    Status = AtSubsystemInit(
        AAPITS_INI_DEF & ~AAPITS_REALLOCROOTTABLE,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiEvaluateObject (NULL, "\\INIT",
        NULL, NULL);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error : AcpiEvaluateObject(INIT) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiGetTableByIndex(OutInd, &OutTable);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("API Error: AcpiGetTableByIndex(%d) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            OutInd, AcpiFormatException(Status));
        return (AE_ERROR);
    }

    for (i = 0; i < 7; i++)
    {
        Status = AcpiEvaluateObject (NULL, "\\_PR_.CPU0._PPC",
            NULL, NULL);
        if (Status != AE_NOT_FOUND)
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(_PR_.CPU0._PPC)"
                " returned %s, expected AE_NOT_FOUND\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiEvaluateObject (NULL, "\\LD__",
            NULL, NULL);
        if (Status != AE_SUPPORT)
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(LD) returned %s,"
                " expected AE_SUPPORT\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiGetTableByIndex(OutInd, &OutTable);
        if (Status != AE_BAD_PARAMETER)
        {
            AapiErrors++;
            printf ("API Error %d: AcpiGetTableByIndex(%d) returned %s,"
                " expected AE_BAD_PARAMETER\n",
                i, OutInd, AcpiFormatException(Status));
            return (AE_ERROR);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0037:
 */
ACPI_STATUS
AtTableTest0037(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("tblm0037.aml")))
    {
        return (Status);
    }

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiEvaluateObject (NULL, "\\INIT",
        NULL, NULL);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error : AcpiEvaluateObject(INIT) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    for (i = 0; i < 99; i++)
    {
        Status = AcpiEvaluateObject (NULL, "\\LD__",
            NULL, NULL);
        if (Status != AE_OK)
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(LD) returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0038:
 */
ACPI_STATUS
AtTableTest0038(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("tblm0037.aml")))
    {
        return (Status);
    }

    Status = AtReadTableFromFile (AtAMLcodeFileName, &UserTable);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("Test error: AtReadTableFromFile(DSDT) failure, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    AtBuildLocalTables(UserTable, NullBldTask);

    Status = AtInitCommonTest(AAPITS_INITIALIZE_SS, 0, 0, 0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiInitializeTables(NULL, 10, FALSE);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiInitializeTables(NULL) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AtSubsystemInit(
        AAPITS_INI_DEF & ~(AAPITS_INITIALIZE_SS |
            AAPITS_INITABLES | AAPITS_REALLOCROOTTABLE),
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }


    Status = AcpiEvaluateObject (NULL, "\\INIT",
        NULL, NULL);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error : AcpiEvaluateObject(INIT) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    for (i = 0; i < 99; i++)
    {
        Status = AcpiEvaluateObject (NULL, "\\LD__",
            NULL, NULL);
        if (Status != AE_OK)
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(LD) returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

ACPI_STATUS
AtCheckGetTableHeader(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;
    UINT32                  Instance = 1;
    ACPI_TABLE_HEADER       *TablePointer;
    ACPI_TABLE_HEADER       OutTableHeader;
    BLD_TABLES_TASK         BldTask = {BLD_NO_TABLES, 0};

    for (i = 1; i < ACPI_NUM_TABLE_TYPES; i++)
    {
        /* Caller should unmap the header with AcpiOsUnmapMemory */
        Status = AcpiGetTableHeader(TableSignSet[i], Instance, &OutTableHeader);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetTableHeader(%d, %d) returned %s\n",
                i, Instance, AcpiFormatException(Status));
            return (Status);
        }

        Status = AtGetTableHeader(TableSignSet[i], 1, &TablePointer, BldTask);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test Error: AtGetTableHeader(%d) failed (%s)\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        if (ACPI_COMPARE_NAME(TableSignSet[i], ACPI_SIG_FADT) &&
            TablePointer->Revision < 3)
        {
            /* Check Length field */
            if (OutTableHeader.Length != ACPI_FADT_OFFSET (ResetRegister))
            {
                AapiErrors++;
                printf ("API Error: Length field of FADT header %d,"
                    " expected %d\n",
                    (int)OutTableHeader.Length, (int)ACPI_FADT_OFFSET (ResetRegister));
                return (AE_ERROR);
            }
            OutTableHeader.Length = TablePointer->Length;
        }
        if (ACPI_FAILURE(Status = AtCheckBytes("CheckGetHeader",
            (UINT8 *)&OutTableHeader, (UINT8 *)TablePointer,
            sizeof (ACPI_TABLE_HEADER))))
        {
            printf ("API Error: AcpiGetTableHeader(%d, %d) table\n",
                i, Instance);
            return (Status);
        }
//        AcpiOsUnmapMemory(OutTableHeader, (ACPI_SIZE) sizeof (ACPI_TABLE_HEADER));
    }

    return (AE_OK);
}

/*
 * ASSERTION 0039:
 */
ACPI_STATUS
AtTableTest0039(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    Status = AtInitializeTables(FALSE);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiInitializeTables() returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    return (AtCheckGetTableHeader());
}

/*
 * ASSERTION 0040:
 */
ACPI_STATUS
AtTableTest0040(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(
        AAPITS_INI_PRELOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtCheckGetTableHeader());
}

ACPI_STATUS
AtCheckGetTableHeaderInstance(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       *TablePointer;
    ACPI_TABLE_HEADER       OutTableHeader;
    BLD_TABLES_TASK         BldTask = {BLD_NO_TABLES, 0};

    Status = AtGetTableHeader(ACPI_SIG_SSDT, 1, &TablePointer, BldTask);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("Test Error: AtGetTableHeader(SSDT1) failed (%s)\n",
            AcpiFormatException(Status));
        return (Status);
    }

    /* Caller should unmap the header with AcpiOsUnmapMemory */
    Status = AcpiGetTableHeader(ACPI_SIG_SSDT, 1,
        &OutTableHeader);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiGetTableHeader(SSDT, %d) returned %s\n",
            1, AcpiFormatException(Status));
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckBytes("SSDT1",
        (UINT8 *)&OutTableHeader, (UINT8 *)TablePointer,
        sizeof (ACPI_TABLE_HEADER))))
    {
        return (Status);
    }
//    AcpiOsUnmapMemory(OutTableHeader, (ACPI_SIZE) sizeof (ACPI_TABLE_HEADER));

    Status = AtGetTableHeader(ACPI_SIG_SSDT, 2, &TablePointer, BldTask);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("Test Error: AtGetTableHeader(SSDT2) failed (%s)\n",
            AcpiFormatException(Status));
        return (Status);
    }

    /* Caller should unmap the header with AcpiOsUnmapMemory */
    Status = AcpiGetTableHeader(ACPI_SIG_SSDT, 2,
        &OutTableHeader);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiGetTableHeader(SSDT, %d) returned %s\n",
            2, AcpiFormatException(Status));
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckBytes("SSDT2",
        (UINT8 *)&OutTableHeader, (UINT8 *)TablePointer,
        sizeof (ACPI_TABLE_HEADER))))
    {
        return (Status);
    }
//    AcpiOsUnmapMemory(OutTableHeader, (ACPI_SIZE) sizeof (ACPI_TABLE_HEADER));

    return (AE_OK);
}

/*
 * ASSERTION 0041:
 */
ACPI_STATUS
AtTableTest0041(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    Status = AtInitializeTables(FALSE);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiInitializeTables() returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    return (AtCheckGetTableHeaderInstance());
}

/*
 * ASSERTION 0042:
 */
ACPI_STATUS
AtTableTest0042(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(
        AAPITS_INI_PRELOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtCheckGetTableHeader();
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtCheckGetTableHeaderInstance());
}

/*
 * ASSERTION 0043:
 */
ACPI_STATUS
AtTableTest0043(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       OutTableHeader;
    UINT32                  i;

    Status = AtSubsystemInit(
        AAPITS_INI_PRELOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = ACPI_NUM_TABLE_TYPES; i < ACPI_NUM_TABLE_TYPES + 4; i++)
    {
        Status = AcpiGetTableHeader(TableSignSet[i], 1, &OutTableHeader);
        if (Status != AE_NOT_FOUND)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetTableHeader('%s', %d) returned %s,"
                " expected AE_NOT_FOUND\n",
                TableSignSet[i], 1, AcpiFormatException(Status));
            return (AE_ERROR);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0044:
 */
ACPI_STATUS
AtTableTest0044(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    Status = AtSubsystemInit(
        AAPITS_INI_PRELOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < ACPI_NUM_TABLE_TYPES + 4; i++)
    {
        Status = AcpiGetTableHeader(TableSignSet[i], 1, NULL);
        if (Status != AE_BAD_PARAMETER)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetTableHeader('%s', 1, NULL) returned %s,"
                " expected AE_BAD_PARAMETER\n",
                TableSignSet[i], AcpiFormatException(Status));
            return (AE_ERROR);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0045:
 */
ACPI_STATUS
AtTableTest0045(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       OutTableHeader;
    UINT32                  i, j;

    Status = AtSubsystemInit(
        AAPITS_INI_PRELOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < ACPI_NUM_TABLE_TYPES; i++)
    {
        if (ACPI_COMPARE_NAME(TableSignSet[i], ACPI_SIG_PSDT) ||
            ACPI_COMPARE_NAME(TableSignSet[i], ACPI_SIG_SSDT))
        {
            continue;
        }
        for (j = 2; j < 5; j++)
        {
            Status = AcpiGetTableHeader(TableSignSet[i], j, &OutTableHeader);
            if (Status != AE_NOT_FOUND)
            {
                AapiErrors++;
                printf ("API Error: AcpiGetTableHeader('%s', %d) returned %s,"
                    " expected AE_NOT_FOUND\n",
                    TableSignSet[i], j, AcpiFormatException(Status));
                return (AE_ERROR);
            }
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0046:
 */
ACPI_STATUS
AtTableTest0046(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       OutTableHeader;
    UINT32                  i;

    Status = AtSubsystemInit(AAPITS_INITIALIZE_SS, 0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 1; i < ACPI_NUM_TABLE_TYPES; i++)
    {
        Status = AcpiGetTableHeader(TableSignSet[i], 1, &OutTableHeader);
        if (Status != AE_NOT_FOUND)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetTableHeader(%d, 1) returned %s,"
                " expected AE_NOT_EXIST\n",
                i, AcpiFormatException(Status));
            return (AE_ERROR);
        }
    }

    for (i = 2; i < 10; i += 3)
    {
        Status = AcpiGetTableHeader(ACPI_SIG_SSDT, i,
            &OutTableHeader);
        if (Status != AE_NOT_FOUND)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetTableHeader(SSDT, %d) returned %s,"
                " expected AE_NOT_EXIST\n",
                i, AcpiFormatException(Status));
            return (AE_ERROR);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0047:
 */
ACPI_STATUS
AtTableTest0047(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       OutTableHeader;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("tblm0047.aml")))
    {
        return (Status);
    }

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiEvaluateObject (NULL, "\\INIT",
        NULL, NULL);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error : AcpiEvaluateObject(INIT) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiGetTableHeader(ACPI_SIG_SSDT, 4,
        &OutTableHeader);
    if (Status != AE_NOT_FOUND)
    {
        AapiErrors++;
        printf ("API Error: AcpiGetTableHeader(SSDT, 4) returned %s,"
            " expected AE_NOT_FOUND\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    for (i = 0; i < 150; i++)
    {
        Status = AcpiEvaluateObject (NULL, "\\_PR_.CPU0._PPC",
            NULL, NULL);
        if (Status != AE_NOT_FOUND)
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(_PR_.CPU0._PPC)"
                " returned %s, expected AE_NOT_FOUND\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiEvaluateObject (NULL, "\\LD__",
            NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(LD) returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiEvaluateObject (NULL, "\\_PR_.CPU0._PPC",
            NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(_PR_.CPU0._PPC) returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        /* Caller should unmap the header with AcpiOsUnmapMemory */
        Status = AcpiGetTableHeader(ACPI_SIG_SSDT, 4,
            &OutTableHeader);
        if (Status != AE_OK)
        {
            AapiErrors++;
            printf ("API Error %d: AcpiGetTableHeader(SSDT, 4) returned %s,"
                " expected AE_OK\n",
                i, AcpiFormatException(Status));
            return (AE_ERROR);
        }
//        AcpiOsUnmapMemory(OutTableHeader, (ACPI_SIZE) sizeof (ACPI_TABLE_HEADER));

        Status = AcpiEvaluateObject (NULL, "\\UNLD",
            NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(UNLD) returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        /* Caller should unmap the header with AcpiOsUnmapMemory */
        Status = AcpiGetTableHeader(ACPI_SIG_SSDT, 4,
            &OutTableHeader);
        if (Status != AE_OK)
        {
            AapiErrors++;
            printf ("API Error %d(UNLD): AcpiGetTableHeader(SSDT, 4) returned %s,"
                " expected AE_OK\n",
                i, AcpiFormatException(Status));
            return (AE_ERROR);
        }
//        AcpiOsUnmapMemory(OutTableHeader, (ACPI_SIZE) sizeof (ACPI_TABLE_HEADER));
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

ACPI_STATUS
AtCheckGetTable(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;
    UINT32                  Instance = 1;
    ACPI_TABLE_HEADER       *TablePointer;
    ACPI_TABLE_HEADER       *OutTableHeader;
    BLD_TABLES_TASK         BldTask = {BLD_NO_TABLES, 0};

    for (i = 1; i < ACPI_NUM_TABLE_TYPES; i++)
    {
        Status = AcpiGetTable(TableSignSet[i], Instance, &OutTableHeader);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetTable(%d, %d) returned %s\n",
                i, Instance, AcpiFormatException(Status));
            return (Status);
        }

        Status = AtGetTableHeader(TableSignSet[i], 1, &TablePointer, BldTask);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test Error: AtGetTableHeader(%d) failed (%s)\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        if (ACPI_COMPARE_NAME(TableSignSet[i], ACPI_SIG_FADT) &&
            TablePointer->Revision < 3)
        {
            /* Check Length field */
            if (OutTableHeader->Length != ACPI_FADT_OFFSET (ResetRegister))
            {
                AapiErrors++;
                printf ("API Error: Length field of FADT header %d,"
                    " expected %d\n",
                    (int)OutTableHeader->Length, (int)ACPI_FADT_OFFSET (ResetRegister));
                return (AE_ERROR);
            }
            OutTableHeader->Length = TablePointer->Length;
        }
        if (ACPI_FAILURE(Status = AtCheckBytes("CheckGetHeader",
            (UINT8 *)OutTableHeader, (UINT8 *)TablePointer,
            sizeof (ACPI_TABLE_HEADER))))
        {
            printf ("API Error: AcpiGetTable(%d, %d) table\n",
                i, Instance);
            return (Status);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0048:
 */
ACPI_STATUS
AtTableTest0048(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    Status = AtInitializeTables(FALSE);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiInitializeTables() returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    return (AtCheckGetTable());
}

/*
 * ASSERTION 0049:
 */
ACPI_STATUS
AtTableTest0049(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(
        AAPITS_INI_PRELOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtCheckGetTable());
}

ACPI_STATUS
AtCheckGetTableInstance(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       *TablePointer;
    ACPI_TABLE_HEADER       *OutTableHeader;
    BLD_TABLES_TASK         BldTask = {BLD_NO_TABLES, 0};

    Status = AtGetTableHeader(ACPI_SIG_SSDT, 1, &TablePointer, BldTask);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("Test Error: AtGetTableHeader(SSDT1) failed (%s)\n",
            AcpiFormatException(Status));
        return (Status);
    }
    Status = AcpiGetTable(ACPI_SIG_SSDT, 1,
        &OutTableHeader);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiGetTable(SSDT, %d) returned %s\n",
            1, AcpiFormatException(Status));
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckBytes("SSDT1",
        (UINT8 *)OutTableHeader, (UINT8 *)TablePointer,
        sizeof (ACPI_TABLE_HEADER))))
    {
        return (Status);
    }

    Status = AtGetTableHeader(ACPI_SIG_SSDT, 2, &TablePointer, BldTask);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("Test Error: AtGetTableHeader(SSDT2) failed (%s)\n",
            AcpiFormatException(Status));
        return (Status);
    }
    Status = AcpiGetTable(ACPI_SIG_SSDT, 2,
        &OutTableHeader);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiGetTable(SSDT, %d) returned %s\n",
            2, AcpiFormatException(Status));
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckBytes("SSDT2",
        (UINT8 *)OutTableHeader, (UINT8 *)TablePointer,
        sizeof (ACPI_TABLE_HEADER))))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0050:
 */
ACPI_STATUS
AtTableTest0050(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, NullBldTask);

    Status = AtInitializeTables(FALSE);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiInitializeTables() returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    return (AtCheckGetTableInstance());
}

/*
 * ASSERTION 0051:
 */
ACPI_STATUS
AtTableTest0051(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(
        AAPITS_INI_PRELOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtCheckGetTable();
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtCheckGetTableInstance());
}

/*
 * ASSERTION 0052:
 */
ACPI_STATUS
AtTableTest0052(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       *OutTableHeader;
    UINT32                  i;

    Status = AtSubsystemInit(
        AAPITS_INI_PRELOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = ACPI_NUM_TABLE_TYPES; i < ACPI_NUM_TABLE_TYPES + 4; i++)
    {
        Status = AcpiGetTable(TableSignSet[i], 1, &OutTableHeader);
        if (Status != AE_NOT_FOUND)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetTable('%s', %d) returned %s,"
                " expected AE_NOT_FOUND\n",
                TableSignSet[i], 1, AcpiFormatException(Status));
            return (AE_ERROR);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0053:
 */
ACPI_STATUS
AtTableTest0053(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    Status = AtSubsystemInit(
        AAPITS_INI_PRELOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < ACPI_NUM_TABLE_TYPES + 4; i++)
    {
        Status = AcpiGetTable(TableSignSet[i], 1, NULL);
        if (Status != AE_BAD_PARAMETER)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetTable('%s', 1, NULL) returned %s,"
                " expected AE_BAD_PARAMETER\n",
                TableSignSet[i], AcpiFormatException(Status));
            return (AE_ERROR);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0054:
 */
ACPI_STATUS
AtTableTest0054(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       *OutTableHeader;
    UINT32                  i, j;

    Status = AtSubsystemInit(
        AAPITS_INI_PRELOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < ACPI_NUM_TABLE_TYPES; i++)
    {
        if (ACPI_COMPARE_NAME(TableSignSet[i], ACPI_SIG_PSDT) ||
            ACPI_COMPARE_NAME(TableSignSet[i], ACPI_SIG_SSDT))
        {
            continue;
        }
        for (j = 2; j < 5; j++)
        {
            Status = AcpiGetTable(TableSignSet[i], j, &OutTableHeader);
            if (Status != AE_NOT_FOUND)
            {
                AapiErrors++;
                printf ("API Error: AcpiGetTable('%s', %d) returned %s,"
                    " expected AE_NOT_FOUND\n",
                    TableSignSet[i], j, AcpiFormatException(Status));
                return (AE_ERROR);
            }
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0055:
 */
ACPI_STATUS
AtTableTest0055(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       *OutTableHeader;
    UINT32                  i;

    Status = AtSubsystemInit(AAPITS_INITIALIZE_SS, 0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 1; i < ACPI_NUM_TABLE_TYPES; i++)
    {
        Status = AcpiGetTable(TableSignSet[i], 1, &OutTableHeader);
        if (Status != AE_NOT_FOUND)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetTable(%d, 1) returned %s,"
                " expected AE_NOT_EXIST\n",
                i, AcpiFormatException(Status));
            return (AE_ERROR);
        }
    }

    for (i = 2; i < 10; i += 3)
    {
        Status = AcpiGetTable(ACPI_SIG_SSDT, i,
            &OutTableHeader);
        if (Status != AE_NOT_FOUND)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetTable(SSDT, %d) returned %s,"
                " expected AE_NOT_EXIST\n",
                i, AcpiFormatException(Status));
            return (AE_ERROR);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0056:
 */
ACPI_STATUS
AtTableTest0056(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       *OutTableHeader;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("tblm0047.aml")))
    {
        return (Status);
    }

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiEvaluateObject (NULL, "\\INIT",
        NULL, NULL);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error : AcpiEvaluateObject(INIT) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiGetTable(ACPI_SIG_SSDT, 4,
        &OutTableHeader);
    if (Status != AE_NOT_FOUND)
    {
        AapiErrors++;
        printf ("API Error: AcpiGetTable(SSDT, 4) returned %s,"
            " expected AE_NOT_FOUND\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    for (i = 0; i < 150; i++)
    {
        Status = AcpiEvaluateObject (NULL, "\\_PR_.CPU0._PPC",
            NULL, NULL);
        if (Status != AE_NOT_FOUND)
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(_PR_.CPU0._PPC)"
                " returned %s, expected AE_NOT_FOUND\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiEvaluateObject (NULL, "\\LD__",
            NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(LD) returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiEvaluateObject (NULL, "\\_PR_.CPU0._PPC",
            NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(_PR_.CPU0._PPC) returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiGetTable(ACPI_SIG_SSDT, 4,
            &OutTableHeader);
        if (Status != AE_OK)
        {
            AapiErrors++;
            printf ("API Error %d: AcpiGetTable(SSDT, 4) returned %s,"
                " expected AE_OK\n",
                i, AcpiFormatException(Status));
            return (AE_ERROR);
        }

        Status = AcpiEvaluateObject (NULL, "\\UNLD",
            NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(UNLD) returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiGetTable(ACPI_SIG_SSDT, 4,
            &OutTableHeader);
        if (Status != AE_OK)
        {
            AapiErrors++;
            printf ("API Error %d(UNLD): AcpiGetTable(SSDT, 4) returned %s,"
                " expected AE_OK\n",
                i, AcpiFormatException(Status));
            return (AE_ERROR);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0057:
 */
ACPI_STATUS
AtTableTest0057(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       *OutTableHeader0;
    ACPI_TABLE_HEADER       OutTableHeader1;
    UINT32                  i;

    Status = AtSubsystemInit(
        AAPITS_INI_PRELOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 1; i < ACPI_NUM_TABLE_TYPES; i++)
    {
        Status = AcpiGetTable(TableSignSet[i], 1, &OutTableHeader0);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetTable('%s', 1) returned %s\n",
                TableSignSet[i], AcpiFormatException(Status));
            return (Status);
        }

        /* Caller should unmap the header with AcpiOsUnmapMemory */
        Status = AcpiGetTableHeader(TableSignSet[i], 1, &OutTableHeader1);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetTableHeader('%s', 1) returned %s\n",
                TableSignSet[i], AcpiFormatException(Status));
            return (Status);
        }
//        if (!(OutTableHeader0 == OutTableHeader1))
        Status = AtCheckBytes("Headers", (UINT8 *)OutTableHeader0,
            (UINT8 *)&OutTableHeader1, sizeof (ACPI_TABLE_HEADER));
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
/*
            printf ("API Error: AcpiGetTable and AcpiGetTableHeader returned"
                " different pointers %p != %p",
                OutTableHeader0, OutTableHeader1);
            return (AE_ERROR);
*/
            printf ("API Error: AcpiGetTable and AcpiGetTableHeader returned"
                " different contents");
            return (Status);
        }
//        AcpiOsUnmapMemory(OutTableHeader1, (ACPI_SIZE) sizeof (ACPI_TABLE_HEADER));
    }

    return (AE_OK);
}

/*
 * ASSERTION 0058:
 * Bug 34 reproducing
 */
ACPI_STATUS
AtTableTest0058(void)
{

#if (!ACPI_CHECKSUM_ABORT)
        TestSkipped++;
        printf ("Test note: ACPI_CHECKSUM_ABORT macros is not TRUE\n");
        return (AE_ERROR);
#else
    ACPI_STATUS             Status;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("tblm0058.aml")))
    {
        return (Status);
    }

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiEvaluateObject (NULL, "\\INIT",
        NULL, NULL);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error : AcpiEvaluateObject(INIT) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    for (i = 0; i < 3; i++)
    {
        Status = AcpiEvaluateObject (NULL, "\\LD__",
            NULL, NULL);
        if (Status != AE_ALREADY_EXISTS)
        {
            AapiErrors++;
            printf ("API Error %d: AcpiEvaluateObject(LD) returned %s,"
                " expected AE_ALREADY_EXISTS\n",
                i, AcpiFormatException(Status));
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
#endif
}

/*
 * ASSERTION 0059:
 */
ACPI_STATUS
AtTableTest0059(void)
{
    UINT32                  ErrFlags[] = {
        NOT_PRESENT_FADT,
        BAD_SIGNATURE_FADT, /* the same affect as NOT_PRESENT_FADT */
//        NULL_ADDRESS_FACS,
        NULL_ADDRESS_DSDT};
    ACPI_STATUS             ErrBenchmarks[] = {
        AE_NO_ACPI_TABLES,
        AE_NO_ACPI_TABLES,
//        AE_NO_ACPI_TABLES,
        AE_NO_ACPI_TABLES};

    return (AtLoadTablesErrTest(ErrFlags,
        sizeof (ErrFlags) / sizeof (UINT32),
        ErrBenchmarks));
}

/*
 * ASSERTION 0060:
 */
ACPI_STATUS
AtTableTest0060(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       OutTableHeader;
    ACPI_TABLE_HEADER       OutTableHeader2;
    ACPI_TABLE_HEADER       *UserTable;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("dsdt1.aml")))
    {
        return (Status);
    }

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /* Caller should unmap the header with AcpiOsUnmapMemory */
    Status = AcpiGetTableHeader(ACPI_SIG_DSDT, 1,
        &OutTableHeader);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiGetTableHeader(DSDT, 1) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    AtAMLcodeFileName[strlen(AtAMLcodeFileName) - 5] = '2';

    Status = AtReadTableFromFile (AtAMLcodeFileName, &UserTable);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("Test error: AtReadTableFromFile(DSDT) failure, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    free(UserTable);

    /* Caller should unmap the header with AcpiOsUnmapMemory */
    Status = AcpiGetTableHeader(ACPI_SIG_DSDT, 1,
        &OutTableHeader2);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiGetTableHeader(DSDT, 1) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }
    Status = AtReadTableFromFile (AtAMLcodeFileName, &UserTable);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("Test error: AtReadTableFromFile(DSDT) failure, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckBytes("DSDT",
        (UINT8 *)&OutTableHeader2, (UINT8 *)UserTable,
        sizeof (ACPI_TABLE_HEADER))))
    {
        return (Status);
    }

    for (i = 0; i < sizeof (ACPI_TABLE_HEADER); i++)
    {
        if (((UINT8 *)&OutTableHeader)[i] != ((UINT8 *)&OutTableHeader2)[i])
        {
            break;
        }
    }
    if (i >= sizeof (ACPI_TABLE_HEADER))
    {
        TestErrors++;
        printf ("Test Error: both internal and %s DSDTs are the same\n",
            AtAMLcodeFileName);
        return (AE_ERROR);
    }

//    AcpiOsUnmapMemory(OutTableHeader, (ACPI_SIZE) sizeof (ACPI_TABLE_HEADER));
//    AcpiOsUnmapMemory(OutTableHeader2, (ACPI_SIZE) sizeof (ACPI_TABLE_HEADER));

    return (AE_OK);
}

/*
 * ASSERTION 0061:
 */
ACPI_STATUS
AtTableTest0061(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("dsdt.aml")))
    {
        return (Status);
    }

    Status = AtInitCommonTest(AAPITS_INI_PRELOAD | AAPITS_LOADTABLES |
        AAPITS_ENABLE_SS | AAPITS_INITIALIZE_OBJS | AAPITS_INSTALL_HS,
        0, 0,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}
