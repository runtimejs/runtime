/******************************************************************************
 *
 * Module Name: atinit - ACPICA Subsystem Initialization, Shutdown, and Status
 *                       API tests
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
#include "atinit.h"
#include "atosxfctrl.h"

#define _COMPONENT          ACPI_TOOLS
        ACPI_MODULE_NAME    ("atinit")

/*
 * Init/Term check flags
 */
#define CHECK_INIT_TERM         0x01
#define CHECK_INIT_COND         0x02
#define CHECK_TERM_ACT          0x04
#define CHECK_FREE_COND         0x08

/*
FILE    *AcpiGbl_DebugFile = NULL;
*/

static UINT32           IhFunctionIniCounter = 0;
static UINT32           IhFunctionOthersCounter = 0;
static UINT32           IhUnexpectedTypeCounter = 0;
static UINT32           AlternativeHandlerCounter = 0;
static UINT32           EstimatedINVC = 0;
static UINT32           EstimatedINVM = 0;
static ACPI_STATUS      AtAcpiInitHandlerSpecRet = AE_OK;
static UINT8            *AtAcpiInitHandlerSpecName = NULL;

/*
 * Expected digits of AML code init0032 processing
 */
#define _SB_DEV_ACTIVE          1
#define TOTAL_DEVS              (9 + _SB_DEV_ACTIVE)
#define _INI_TOTAL              7
#define _STA_TOTAL              7
#define TOTAL_MASK              0x0FCF
#define _STA_NEGATIV_CALLS      2        /* DEV4 + _INI, DEV8 */
#define _STA_NEGATIV_MASK       0x2020   /* DEV4, DEV8 */

/*
 * Managing AML code update
 */

static struct aml_control
{
    UINT8                   Flag;
    UINT32                  Index;
    UINT8                   Value;
} AmlControl;

void
AtSetAmlControl(
    UINT32                  Index,
    UINT8                   Value)
{
    AmlControl.Flag = 1;
    AmlControl.Index = Index;
    AmlControl.Value = Value;
}

ACPI_STATUS
AtAcpiInitHandler(
    ACPI_HANDLE             Object,
    UINT32                  Function)
{
    ACPI_STATUS             Status = AE_OK;
    UINT8                   ShortName[5];
    UINT8                   ParentName[5];
    ACPI_BUFFER             OutName;
    ACPI_OBJECT_TYPE        OutType;
    ACPI_HANDLE             Parent;

    OutName.Length = 5;
    OutName.Pointer = ShortName;

    if (ACPI_FAILURE(AcpiGetName (Object, ACPI_SINGLE_NAME, &OutName)))
    {
        strcpy((char *)ShortName, "NONE");
    }

    if (ACPI_FAILURE(AcpiGetType (Object, &OutType)))
    {
        OutType = 0xff;
    }

    if (ACPI_FAILURE(AcpiGetParent (Object, &Parent)))
    {
        strcpy((char *)ParentName, "NONE");
    }
    else
    {
        OutName.Length = 5;
        OutName.Pointer = ParentName;
        if (ACPI_FAILURE(AcpiGetName (Parent, ACPI_SINGLE_NAME, &OutName)))
        {
            strcpy((char *)ParentName, "NONE");
        }
    }

    printf ("\nAtAcpiInitHandler: Object %p('%s.%s', Type 0x%.2x),"
        " Function %d\n",
        Object, ParentName, ShortName, OutType, Function);

    if (OutType != ACPI_TYPE_DEVICE &&
        OutType != ACPI_TYPE_PROCESSOR &&
        OutType != ACPI_TYPE_THERMAL)
    {
        ++IhUnexpectedTypeCounter;
    }

    if (Function == ACPI_INIT_DEVICE_INI)
    {
        ++IhFunctionIniCounter;
    }
    else
    {
        ++IhFunctionOthersCounter;
    }

    if (strcmp((char *)ShortName, "DEV0") == 0)
    {
        /* Without the _STA or _INI methods */
        EstimatedINVC += 0;
        EstimatedINVM |= 0;
    }
    if (strcmp((char *)ShortName, "DEV1") == 0)
    {
        /* With the _INI method only (default _STA) */
        EstimatedINVC += 1;
        EstimatedINVM |= 0x01;
    }
    if (strcmp((char *)ShortName, "DEV2") == 0)
    {
        /* With the _STA method only */
        EstimatedINVC += 1;
        EstimatedINVM |= 0x02;
    }
    if (strcmp((char *)ShortName, "DEV3") == 0)
    {
        /* With the both _INI and _STA methods */
        EstimatedINVC += 2;
        EstimatedINVM |= 0x0C;
    }
    if (strcmp((char *)ShortName, "DEV4") == 0)
    {
	    /* With the both _INI and _STA methods but the last indicates
         * that the device is not configured
         */
        EstimatedINVC += 1;
        EstimatedINVM |= 0x20;
    }
    if (strcmp((char *)ShortName, "DEV5") == 0)
    {
	    /* With the both _INI and _STA methods */
        EstimatedINVC += 2;
        EstimatedINVM |= 0xC0;
    }
    if (strcmp((char *)ShortName, "DEV6") == 0)
    {
	    /* With the both _INI and _STA methods */
        EstimatedINVC += 2;
        EstimatedINVM |= 0x300;
    }
    if (strcmp((char *)ShortName, "DEV7") == 0)
    {
	    /* With the both _INI and _STA methods */
        EstimatedINVC += 2;
        EstimatedINVM |= 0xC00;
    }
    if (strcmp((char *)ShortName, "DEV8") == 0)
    {
	    /* With the both _INI and _STA methods but the last indicates
         * that the device is not: present, enabled
         */
        EstimatedINVC += 1;
        EstimatedINVM |= 0x2000;
    }
    if (strcmp((char *)ShortName, "DEV9") == 0)
    {
	    /* With the both _INI and _STA methods, children
         * of not present but functioning Device
         */
        EstimatedINVC += 2;
        EstimatedINVM |= 0xC000;
    }
    if (strcmp((char *)ShortName, "DEVA") == 0)
    {
	    /* With the both _INI and _STA methods but the last indicates
         * that the device is not: present, enabled, functioning
         */
        EstimatedINVC += 1;
        EstimatedINVM |= 0x20000;
    }
    if (strcmp((char *)ShortName, "DEVB") == 0)
    {
	    /* With the both _INI and _STA methods */
        EstimatedINVC += 2;
        EstimatedINVM |= 0xC0000;
    }

    if (AtAcpiInitHandlerSpecRet != AE_OK)
    {
        if (AtAcpiInitHandlerSpecName)
        {
            if (strcmp((char *)ShortName,
                (char *)AtAcpiInitHandlerSpecName) == 0 ||
                    strcmp((char *)ParentName,
                        (char *)AtAcpiInitHandlerSpecName) == 0)
            {
                Status = AtAcpiInitHandlerSpecRet;
                AtAcpiInitHandlerSpecRet = AE_OK;
            }
        }
        else
        {
            Status = AtAcpiInitHandlerSpecRet;
            AtAcpiInitHandlerSpecRet = AE_OK;
        }
    }
    return (Status);
}

ACPI_STATUS
AlternativeAcpiInitHandler(
    ACPI_HANDLE             Object,
    UINT32                  Function)
{
    printf ("\nAlternativeAcpiInitHandler: Object %p, Function %d\n",
        Object, Function);
    ++AlternativeHandlerCounter;
    return (AE_OK);
}

ACPI_STATUS
AtInitTest0030AcpiInitHandler(
    ACPI_HANDLE             Object,
    UINT32                  Function)
{
    printf ("\nAtInitTest0030AcpiInitHandler: Object %p, Function %d\n",
        Object, Function);
    return (AE_ERROR);
}

/*
 * AcpiSubsystemStatus testing auxiliary macro
 */
#define    CHECK_SUBSYSTEM_STATUS(Benchmark) \
    Status = AcpiSubsystemStatus(); \
    if (Status != Benchmark) \
    { \
        AapiErrors++; \
        printf ("API error: AcpiSubsystemStatus" \
            " returned %s, expected %s\n", \
            AcpiFormatException(Status), \
            AcpiFormatException(Benchmark)); \
        return (AE_ERROR); \
    }

/*
 * ACPI_STATUS
 * AtSubsystemInit(
 * UINT32        StagesScale, - scale of initialization steps
 * UINT32        EnFlags,     - AcpiEnableSubsystem flags
 * UINT32        OiFlags)     - AcpiInitializeObjects flags
 * UINT32        StatusFlag)  - flag of call to AcpiSubsystemStatus
 *
 * Performs the ACPICA Core Subsystem intitialization functions
 * according to the specified stages scale while the actions are
 * being successfully completed.
 */
ACPI_STATUS
AtSubsystemInit(
    UINT32              StagesScale,
    UINT32              EnFlags,
    UINT32              OiFlags,
    char                *AMLcodeFileName)
{
    return (AtInitCommonTest(StagesScale, 0, 0,
        EnFlags, OiFlags, AMLcodeFileName));
}

void
AtPrintInitStagesScale(
    UINT32              StagesScale)
{
    printf ("Stages Init Core:");

    if (StagesScale & AAPITS_INITIALIZE_SS)
    {
        printf (" SubSystem,");
    }

    if (StagesScale & AAPITS_INSTALL_IH)
    {
        printf (" InstIH,");
    }

    if (StagesScale & AAPITS_INITABLES)
    {
        printf (" InitTables,");
    }

    if (StagesScale & AAPITS_REALLOCROOTTABLE)
    {
        printf (" ReallocRootTable,");
    }

    if (StagesScale & AAPITS_LOADTABLES)
    {
        printf (" LoadTables,");
    }

    if (StagesScale & AAPITS_ENABLE_SS)
    {
        printf (" EnableSS,");
    }

    if (StagesScale & AAPITS_INITIALIZE_OBJS)
    {
        printf (" InitOBJS,");
    }

    if (StagesScale & AAPITS_INSTALL_HS)
    {
        printf (" InstAdrSH,");
    }

    if (!StagesScale)
    {
        printf (" NONE,");
    }

    printf ("\n");
}

/*
 * ACPI_STATUS
 * AtInitCommonTest(
 * UINT32        StagesScale, - scale of initialization steps
 * UINT32        ErrStagesScale,- relevant scale of errors emulation
 * UINT32        ErrExpScale, - scale of interfaces expected to fail
 * UINT32        EnFlags,     - AcpiEnableSubsystem flags
 * UINT32        OiFlags,     - AcpiInitializeObjects flags
 * char            *AMLcodeFileName)
 *
 * Performs the ACPICA Core Subsystem intitialization functions
 * according to the specified stages scale while the actions are
 * being successfully completed.
 */
ACPI_STATUS
AtInitCommonTest(
    UINT32              StagesScale,
    UINT32              ErrStagesScale,
    UINT32              ErrExpScale,
    UINT32              EnFlags,
    UINT32              OiFlags,
    char                *AMLcodeFileName)
{
    ACPI_STATUS         Status;
    ACPI_TABLE_HEADER   UserTableStructure, *UserTable = &UserTableStructure;

    AtPrintInitStagesScale(StagesScale);

    if ((StagesScale & ErrStagesScale) != ErrStagesScale)
    {
        TestErrors++;
        printf ("AtInitCommonTest test error 1: StagesScale & ErrStagesScale (0x%x)"
            " != ErrStagesScale (0x%x)\n", StagesScale & ErrStagesScale, ErrStagesScale);
        return (AE_ERROR);
    }

    if ((StagesScale & ErrExpScale) != ErrExpScale)
    {
        TestErrors++;
        printf ("AtInitCommonTest test error 2: StagesScale & ErrExpScale (0x%x)"
            " != ErrStagesScale (0x%x)\n", StagesScale & ErrExpScale, ErrExpScale);
        return (AE_ERROR);
    }

    if (ErrStagesScale & ErrExpScale)
    {
        TestErrors++;
        printf ("AtInitCommonTest test error 3: ErrStagesScale"
            " & ErrExpScale (0x%x) != 0\n", ErrStagesScale & ErrExpScale);
        return (AE_ERROR);
    }

    if ((StagesScale & AAPITS_INSTALL_IH) &&
        (ErrStagesScale & AAPITS_INITIALIZE_OBJS))
    {
        TestErrors++;
        printf ("AtInitCommonTest test error 4: AAPITS_INSTALL_IH and"
            " ErrStagesScale & AAPITS_INITIALIZE_OBJS simulteneously\n");
        return (AE_ERROR);
    }

    if (StagesScale & AAPITS_INITIALIZE_SS)
    {
        if (ErrStagesScale & AAPITS_INITIALIZE_SS)
        {
            Status = OsxfCtrlSet(OSXF_NUM(AcpiOsInitialize),
                1, AtActD_OneTime, AtActRet_ERROR);
            if (ACPI_FAILURE(Status))
            {
                TestErrors++;
                printf ("AtInitCommonTest test error 5: %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
        }

        /* Clean Registers Emulation */
        OsxfCtrlRegService(0);

        Status = AcpiInitializeSubsystem();

        if (ACPI_FAILURE(Status))
        {
            if (ErrExpScale & AAPITS_INITIALIZE_SS)
            {
            }
            else if (!(ErrStagesScale & AAPITS_INITIALIZE_SS))
            {
                AapiErrors++;
                printf ("AtInitCommonTest: AcpiInitializeSubsystem() failure, %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
            else if (Status != AE_ERROR)
            {
                TestErrors++;
                printf ("AtInitCommonTest: AcpiInitializeSubsystem()"
                    " returned %s, expected AE_ERROR emulation\n",
                    AcpiFormatException(Status));
                return (Status);
            }
        }
        else if (ErrExpScale & AAPITS_INITIALIZE_SS)
        {
            AapiErrors++;
            printf ("AtInitCommonTest: AcpiInitializeSubsystem()"
                " succeeded, expected to fail\n");
            return (AE_ERROR);
        }
        else if (ErrStagesScale & AAPITS_INITIALIZE_SS)
        {
            TestErrors++;
            printf ("AtInitCommonTest: AcpiInitializeSubsystem()"
                " succeeded, expected AE_ERROR emulation\n");
            return (AE_ERROR);
        }
        /*
         * Mark the total number of AcpiOS* invocations
         */
        Status = OsxfCtrlCheck(TOTAL_STAT, 0);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            return (Status);
        }
    }

    if (StagesScale & AAPITS_INSTALL_IH)
    {
        Status = AcpiInstallInitializationHandler(AtAcpiInitHandler, 0);
        if (ACPI_FAILURE(Status))
        {
            printf ("AtInitCommonTest: AcpiInstallInitializationHandler() failure, %s\n",
                AcpiFormatException(Status));
            return (Status);
        }
    }

    if (StagesScale & AAPITS_INITABLES)
    {
        memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

        if (AMLcodeFileName)
        {
            Status = AtReadTableFromFile (AMLcodeFileName, &UserTable);
            if (ACPI_FAILURE(Status))
            {
                TestErrors++;
                printf ("AtInitCommonTest: AtReadTableFromFile() failure, %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
            if (AmlControl.Flag)
            {
                AmlControl.Flag = 0;
                if (!(AmlControl.Index < UserTable->Length)) {
                    TestErrors++;
                    printf ("AtInitCommonTest: AmlControl.Index (%d) >="
                        " UserTable->Length (%d)\n",
                        AmlControl.Index, UserTable->Length);
                    return (AE_ERROR);
                }
                ((UINT8 *)UserTable)[AmlControl.Index] = AmlControl.Value;
                printf ("AtInitCommonTest: AmlCode Index %d updated into %c\n",
                        AmlControl.Index, (UINT32)AmlControl.Value);
            }
        }

        AtBuildLocalTables(UserTable, NullBldTask);

        if (ErrStagesScale & AAPITS_INITABLES)
        {
            Status = OsxfCtrlSet(OSXF_NUM(AcpiOsAllocate),
                1 , AtActD_OneTime, AtActRet_NULL);
            if (ACPI_FAILURE(Status))
            {
                TestErrors++;
                printf ("AtInitCommonTest test error 6: %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }

            Status = AcpiInitializeTables(NULL, 20, FALSE);
        }
        else
        {
            Status = AtInitializeTables (FALSE);
        }

        if (ACPI_FAILURE(Status))
        {
            if (ErrExpScale & AAPITS_INITABLES)
            {
                ;
            }
            else if (!(ErrStagesScale & AAPITS_INITABLES))
            {
                AapiErrors++;
                printf ("AtInitCommonTest: AcpiInitializeTables() failure, %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
            else if (Status != AE_NO_MEMORY)
            {
                TestErrors++;
                printf ("AtInitCommonTest: AcpiInitializeTables()"
                    " returned %s, expected AE_NO_MEMORY emulation\n",
                    AcpiFormatException(Status));
                return (Status);
            }
        }
        else if (ErrExpScale & AAPITS_INITABLES)
        {
            AapiErrors++;
            printf ("AtInitCommonTest: AcpiInitializeTables()"
                " succeeded, expected to fail\n");
            return (AE_ERROR);
        }
        else if (ErrStagesScale & AAPITS_INITABLES)
        {
            TestErrors++;
            printf ("AtInitCommonTest: AcpiInitializeTables()"
                " succeeded, expected AE_NO_MEMORY emulation\n");
            return (AE_ERROR);
        }
    }

    if (StagesScale & AAPITS_REALLOCROOTTABLE)
    {
        Status = AcpiReallocateRootTable();

        if (ACPI_FAILURE(Status))
        {
            if (ErrExpScale & AAPITS_REALLOCROOTTABLE)
            {
                ;
            }
            else if (!(ErrStagesScale & AAPITS_REALLOCROOTTABLE))
            {
                AapiErrors++;
                printf ("AtInitCommonTest: AcpiReallocateRootTable() failure, %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
            else if (Status != AE_NO_MEMORY)
            {
                TestErrors++;
                printf ("AtInitCommonTest: AcpiReallocateRootTable()"
                    " returned %s, expected AE_NO_MEMORY emulation\n",
                    AcpiFormatException(Status));
                return (Status);
            }
        }
        else if (ErrExpScale & AAPITS_REALLOCROOTTABLE)
        {
            AapiErrors++;
            printf ("AtInitCommonTest: AcpiReallocateRootTable()"
                " succeeded, expected to fail\n");
            return (AE_ERROR);
        }
        else if (ErrStagesScale & AAPITS_REALLOCROOTTABLE)
        {
            TestErrors++;
            printf ("AtInitCommonTest: AcpiReallocateRootTable()"
                " succeeded, expected AE_NO_MEMORY emulation\n");
            return (AE_ERROR);
        }
    }

    if (StagesScale & AAPITS_LOADTABLES)
    {
        if (ErrStagesScale & AAPITS_LOADTABLES)
        {
/* 2.3.2.1 ACPI Table Validation:
A warning is issued for tables that do not pass one or more of these tests
...
4. The table checksum must be valid (with the exception of the FACS,
   which has no checksum).

            LocalRSDT = MemRSDT;
            LocalRSDT->Checksum = (UINT8)(~LocalRSDT->Checksum);
*/
            Status = OsxfCtrlSet(OSXF_NUM(AcpiOsAllocate),
                2, AtActD_OneTime, AtActRet_NULL);
            if (ACPI_FAILURE(Status))
            {
                TestErrors++;
                printf ("AtInitCommonTest test error 6: %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
        }

        Status = AcpiLoadTables();

        if (ACPI_FAILURE(Status))
        {
            if (ErrExpScale & AAPITS_LOADTABLES)
            {
                ;
            }
            else if (!(ErrStagesScale & AAPITS_LOADTABLES))
            {
                AapiErrors++;
                printf ("AtInitCommonTest: AcpiLoadTables() failure, %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
            else if (Status != AE_NO_MEMORY)
            {
                TestErrors++;
                printf ("AtInitCommonTest: AcpiLoadTables()"
                    " returned %s, expected AE_NO_MEMORY emulation\n",
                    AcpiFormatException(Status));
                return (Status);
            }
        }
        else if (ErrExpScale & AAPITS_LOADTABLES)
        {
            AapiErrors++;
            printf ("AtInitCommonTest: AcpiLoadTables()"
                " succeeded, expected to fail\n");
            return (AE_ERROR);
        }
        else if (ErrStagesScale & AAPITS_LOADTABLES)
        {
            TestErrors++;
            printf ("AtInitCommonTest: AcpiLoadTables()"
                " succeeded, expected AE_NO_MEMORY emulation\n");
            return (AE_ERROR);
        }

        Status = OsxfCtrlAcpiRegsInit(
            &AcpiGbl_FADT, AcpiGbl_XPm1aEnable, AcpiGbl_XPm1bEnable);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("AtInitCommonTest: OsxfCtrlAcpiRegsInit failed\n");
            return (Status);
        }

    }

    if (StagesScale & AAPITS_INSTALL_HS)
    {
        Status = AeInstallHandlers();
        if (ACPI_FAILURE (Status))
        {
            AapiErrors++;
            printf ("AtInitCommonTest: AtInstallHandlers() failure, %s\n",
                AcpiFormatException(Status));
            return (Status);
        }
    }

    if (StagesScale & AAPITS_ENABLE_SS)
    {
        if (ErrStagesScale & AAPITS_ENABLE_SS)
        {
            Status = OsxfCtrlSet(OSXF_NUM(AcpiOsAllocate),
                2, AtActD_OneTime, AtActRet_NULL);
            if (ACPI_FAILURE(Status))
            {
                TestErrors++;
                printf ("AtInitCommonTest test error 7: %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
        }

        Status = AcpiEnableSubsystem(EnFlags);

        if (ACPI_FAILURE(Status))
        {
            if (ErrExpScale & AAPITS_ENABLE_SS)
            {
            }
            else if (!(ErrStagesScale & AAPITS_ENABLE_SS))
            {
                AapiErrors++;
                printf ("AtInitCommonTest: AcpiEnableSubsystem() failure, %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
            else if (Status != AE_NO_MEMORY)
            {
                TestErrors++;
                printf ("AtInitCommonTest: AcpiEnableSubsystem()"
                    " returned %s, expected AE_NO_MEMORY emulation\n",
                    AcpiFormatException(Status));
                return (Status);
            }
        }
        else if (ErrExpScale & AAPITS_ENABLE_SS)
        {
            AapiErrors++;
            printf ("AtInitCommonTest: AcpiEnableSubsystem()"
                " succeeded, expected to fail\n");
            return (AE_ERROR);
        }
        else if (ErrStagesScale & AAPITS_ENABLE_SS)
        {
            TestErrors++;
            printf ("AtInitCommonTest: AcpiEnableSubsystem()"
                " succeeded, expected AE_NO_MEMORY emulation\n");
            return (AE_ERROR);
        }

    }

    if (StagesScale & AAPITS_INITIALIZE_OBJS)
    {
        if (ErrStagesScale & AAPITS_INITIALIZE_OBJS)
    {
/* This doesn't work
            Status = OsxfCtrlSet(OSXF_NUM(AcpiOsAllocate),
                1, AtActD_OneTime, AtActRet_NULL);
            if (ACPI_FAILURE(Status))
    {
                TestErrors++;
                printf ("AtInitCommonTest test error 8: %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
*/
            Status = AcpiInstallInitializationHandler(AtInitTest0030AcpiInitHandler, 0);
            if (ACPI_FAILURE(Status))
            {
                TestErrors++;
                printf ("AtInitCommonTest: AcpiInstallInitializationHandler() failure, %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
        }

        Status = AcpiInitializeObjects(OiFlags);

        if (ACPI_FAILURE(Status))
        {
            if (ErrExpScale & AAPITS_INITIALIZE_OBJS)
            {
            }
            else if (!(ErrStagesScale & AAPITS_INITIALIZE_OBJS))
            {
                AapiErrors++;
                printf ("AtInitCommonTest: AcpiInitializeObjects() failure, %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
            else if (Status != AE_ERROR)
            {
                TestErrors++;
                printf ("AtInitCommonTest: AcpiInitializeObjects()"
                    " returned %s, expected AE_ERROR emulation\n",
                    AcpiFormatException(Status));
                return (Status);
            }
        }
        else if (ErrExpScale & AAPITS_INITIALIZE_OBJS)
        {
            AapiErrors++;
            printf ("AtInitCommonTest: AcpiInitializeObjects()"
                " succeeded, expected to fail\n");
            return (AE_ERROR);
        }
        else if (ErrStagesScale & AAPITS_INITIALIZE_OBJS)
        {
            AapiErrors++;
            printf ("AtInitCommonTest: AcpiInitializeObjects()"
                " succeeded, expected AE_ERROR emulation\n");
            return (AE_ERROR);
        }
    }

    return (AE_OK);
}

#ifdef xxxxACPI_DEBUGGER
ACPI_EXTERN ACPI_TABLE_HEADER          *AcpiGbl_DbTablePtr;
ACPI_EXTERN char                       *AcpiGbl_DbBuffer;
#endif

/*
 * Check Subsystem shutdown
 */
ACPI_STATUS
AtTerminateCheck(
    ACPI_STATUS         SuccessStatus,
    UINT32              CtrlCheck)
{
    ACPI_STATUS         Status;

#ifdef xxxxACPI_DEBUGGER
    /* Shut down the debugger */
    if (AcpiGbl_DbTablePtr)
    {
        AcpiGbl_DbTablePtr = NULL;
    }
    if (AcpiGbl_DbBuffer)
    {
        AcpiGbl_DbBuffer = NULL;
    }
#endif

    if (AT_SKIP_ALL_MALLOC_CHECK) {
        CtrlCheck &= ~MALLOC_STAT;
    }

    if (AT_SKIP_MAPPED_CHECK) {
        CtrlCheck &= ~MMAP_STAT;
    }

    Status = OsxfCtrlCheck(CtrlCheck, 1);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        return (Status);
    }

    return (SuccessStatus);
}

/*
 * Initiate and check Subsystem shutdown
 */
ACPI_STATUS
AtTerminateCtrlCheck(
    ACPI_STATUS         SuccessStatus,
    UINT32              CtrlCheck)
{
    ACPI_STATUS         Status;

    Status = AcpiTerminate();
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiTerminate() failure, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCheck(SuccessStatus, CtrlCheck));
}

/*
 * 6.1 Subsystem Initialization, Shutdown, and Status
 */

/*
 * ACPI_STATUS
 * AtInitTermCommonTest(
 *     AT_ACTD_FLAG ActFlag, - flag of one-time/permanent action mode
 *     UINT32 TFst,       - number of the first call to OS IF for the action
 *     ACPI_OSXF OsxfNum, - number of the specified OS IF
 *     UINT32 ActCode,   - code of the action
 *     UINT32 Check_Flags)- flags of the additional check of AcpiTerminate:
 *         0 - without any check
 *         1 - check before and after AcpiTerminate
 *         2 - the second check without call to AcpiTerminate
 *         3 - without any check and call to AcpiTerminate
 *
 * Performs actions which are common for AcpiInitializeSubsystem
 * and AcpiTerminate routines test cases.
 *
 */

ACPI_STATUS
AtInitTermCommonTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    UINT32                  Check_Flags,
    ACPI_STATUS             Benchmark)
{
    ACPI_STATUS             Status;
    ACPI_STATUS             Init_Os_Status = AE_OK;
    ACPI_STATUS             Init_Sub_Status;
    UINT32                  i;
    UINT32                  Continue_Cond = 1;
    UINT32                  Check_Stat = ALL_STAT;
    UINT32                  TMax = 10000;
    ACPI_OSXF               OsxfNumAct;

    printf ("AtInitTermCommonTest: ActFlag % d, TFst %d, TMax %d\n",
        ActFlag, TFst, TMax);

    if (TFst == 0)
    {
        TestErrors++;
        printf ("Test error, TFst = 0\n");
        return (AE_ERROR);
    }

    if (Check_Flags & CHECK_INIT_TERM)
    {
        /* Exclude check of AcpiInitializeSubsystem/AcpiTerminate agreement */
        Check_Stat &= ~OSINIT_STAT;
    }

    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtInitTermCommonTest: i = %d\n", i);

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Init_Sub_Status = AcpiInitializeSubsystem();

        if (!(OsxfNumAct = OsxfCtrlGetActOsxf(OsxfNum, 1)))
        {
            if (i == TFst)
            {
                TestSkipped++;
                printf ("Test note: test action hasn't occur\n");
                return (AE_ERROR);
            }
            TestPass++;
            Continue_Cond = 0;
        }
        else
        {
            if ((ACPI_SUCCESS(Benchmark) && Init_Sub_Status != Benchmark) ||
                (ACPI_FAILURE(Benchmark) && ACPI_SUCCESS(Init_Sub_Status)))
            {
                AapiErrors++;
                printf ("API Error: AcpiInitializeSubsystem returned %s,\n"
                    "           expected to return %s\n",
                    AcpiFormatException(Init_Sub_Status),
                    AcpiFormatException(Benchmark));
                return (AE_ERROR);
            }
            else if (Init_Sub_Status != Benchmark)
            {
                printf ("Test note: AcpiInitializeSubsystem returned %s,\n"
                    "           expected to return %s\n",
                    AcpiFormatException(Init_Sub_Status),
                    AcpiFormatException(Benchmark));
            }

            if (OsxfNumAct == OSXF_NUM(AcpiOsInitialize) &&
                    ActCode == AtActRet_ERROR)
            {
                Init_Os_Status = AE_ERROR;
            }
        }

        if (AT_SKIP_OS_PRINTF_CHECK && ACPI_FAILURE(Init_Os_Status))
        {
            OsxfUpdateCallsMark();
        }

        Status = InitOsxfCtrlCheck(Init_Os_Status);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            return (Status);
        }

        if (Check_Flags & CHECK_INIT_COND)
        {
            Status = OsxfCtrlCheck(SYS_STAT, 0);
            if (ACPI_FAILURE(Status))
            {
                TestErrors++;
                return (Status);
            }
        }

        if (Check_Flags & CHECK_TERM_ACT)
        {
            Status = AcpiTerminate();
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("API Error: AcpiTerminate() failure, %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
#ifdef xxxxACPI_DEBUGGER
            /* Shut down the debugger */
            if (AcpiGbl_DbTablePtr)
            {
                AcpiGbl_DbTablePtr = NULL;
            }
            if (AcpiGbl_DbBuffer)
            {
                AcpiGbl_DbBuffer = NULL;
            }
#endif
            Init_Os_Status = AE_OK;
        }
        else
        {
            if (OsxfNumAct == OSXF_NUM(AcpiOsInitialize))
            {
                Init_Os_Status = AE_OK;
            }
            else
            {
                Init_Os_Status = AE_ERROR;
            }
        }


        if (Check_Flags & CHECK_FREE_COND)
        {
            Status = OsxfCtrlCheck(Check_Stat, 1);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                return (Status);
            }
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
 * ACPI_STATUS
 * AtExceptionCommonTest(
 *     AT_ACTD_FLAG ActFlag, - flag of one-time/permanent action mode
 *     UINT32 TFst,       - number of the first call to OS IF for the action
 *     ACPI_OSXF OsxfNum, - number of the specified OS IF
 *     UINT32 ActCode)   - code of the action
 *
 * Performs actions which are common for AcpiInitializeSubsystem
 * and AcpiTerminate routines test cases.
 *
 */
ACPI_STATUS
AtExceptionCommonTest(
    UINT32                  FlagIFVerified,
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  StagesScale = AAPITS_INI_PRELOAD;
    UINT32                  TMax = 10000;
    UINT32                  i;
    char                    *NameIF = "AcpiLoadTables";

    printf ("AtExceptionCommonTest: ActFlag % d, TFst %d, TMax %d\n",
        ActFlag, TFst, TMax);

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("init0032.aml")))
    {
        return (Status);
    }

    if (FlagIFVerified != AAPITS_LOADTABLES &&
        FlagIFVerified != AAPITS_ENABLE_SS &&
        FlagIFVerified != AAPITS_INITIALIZE_OBJS)
    {
        TestErrors++;
        printf ("AtExceptionCommonTest: test error, incorrect"
            " FlagIFVerified (0x%x)\n", FlagIFVerified);
        return (AE_ERROR);
    }

    if (TFst == 0)
    {
        TestErrors++;
        printf ("Test error, TFst = 0\n");
        return (AE_ERROR);
    }

    if (FlagIFVerified == AAPITS_ENABLE_SS)
    {
        StagesScale |= AAPITS_LOADTABLES;
        NameIF = "AcpiEnableSubsystem";
    }
    else if (FlagIFVerified == AAPITS_INITIALIZE_OBJS)
    {
        StagesScale |= (AAPITS_LOADTABLES | AAPITS_ENABLE_SS);
        NameIF = "AcpiInitializeObjects";
    }

    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtExceptionCommonTest: i = %d\n", i);

        Status = AtInitCommonTest(StagesScale,
            0, 0,
            AAPITS_EN_FLAGS, 0, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        switch (FlagIFVerified)
        {
        case (AAPITS_LOADTABLES):
            Status = AcpiLoadTables();
            break;
        case (AAPITS_ENABLE_SS):
            Status = AcpiEnableSubsystem(AAPITS_EN_FLAGS);
            break;
        case (AAPITS_INITIALIZE_OBJS):
            Status = AcpiInitializeObjects(AAPITS_OI_FLAGS);
            break;
        }

        if (!(OsxfNumAct = OsxfCtrlGetActOsxf(OsxfNum, 1)))
        {
            if (i == TFst)
            {
                TestSkipped++;
                printf ("Test note: test action hasn't occur\n");
                return (AE_ERROR);
            }
            TestPass++;
            Continue_Cond = 0;
        }
        else
        {
            if (Status != Benchmark)
            {
                AapiErrors++;
                printf ("API Error: %s returned %s,\n"
                    "           expected to return %s\n", NameIF,
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

/*
 * ASSERTION 0000:
 */
ACPI_STATUS
AtInitTest0000(void)
{
    ACPI_STATUS             Status;

    Status = AcpiInitializeSubsystem();

    if (Status != AE_OK)
    {
        AapiErrors++;
        printf ("API Error: AcpiInitializeSubsystem returned %s,\n"
            "           expected to return (AE_OK)\n",
            AcpiFormatException(Status));
    }

    Status = InitOsxfCtrlCheck(AE_OK);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
    }

    return (AE_OK);
}

/*
 * ASSERTION 0001:
 */
ACPI_STATUS
AtInitTest0001(void)
{
    return (AtInitTermCommonTest(OSXF_NUM(AcpiOsInitialize),
        AtActD_OneTime, AtActRet_ERROR, 1, CHECK_INIT_TERM, AE_ERROR));
}

/*
 * ASSERTION 0002:
 */

ACPI_STATUS
Init_NO_MEMORY_Test1(
    UINT32              TFst1,
    UINT32              TFst2,
    UINT32              Check)
{
    ACPI_STATUS         Status;

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtInitTermCommonTest(OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, TFst1, Check,
        AE_NO_MEMORY);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    return (AtInitTermCommonTest(OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, TFst2, Check,
        AE_NO_MEMORY));
}

ACPI_STATUS
AtInitTest0002(void)
{
    return (Init_NO_MEMORY_Test1(1, 1, CHECK_TERM_ACT));
}

/*
 * ASSERTION 0003:
 */

ACPI_STATUS
Init_NO_MEMORY_Test2(
    UINT32                  TFst1,
    UINT32                  TFst2,
    UINT32                  Check)
{
    ACPI_STATUS             Status;

    /*
     * AcpiOsCreateLock returns AE_NO_MEMORY permanently since the specified call
     */
    Status = AtInitTermCommonTest(OSXF_NUM(AcpiOsCreateLock),
        AtActD_Permanent, AtActRet_NO_MEMORY, TFst1, Check,
        AE_NO_MEMORY);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsCreateLock returns AE_NO_MEMORY one time on the specified call
     */
    return (AtInitTermCommonTest(OSXF_NUM(AcpiOsCreateLock),
        AtActD_OneTime, AtActRet_NO_MEMORY, TFst2, Check,
        AE_NO_MEMORY));
}

ACPI_STATUS
AtInitTest0003(void)
{
    return (Init_NO_MEMORY_Test2(1, 1, CHECK_TERM_ACT));
}

/*
 * ASSERTION 0004:
 */

ACPI_STATUS
Init_NO_MEMORY_Test3(
    UINT32                  TFst1,
    UINT32                  TFst2,
    UINT32                  Check)
{
    ACPI_STATUS             Status;

    /*
     * AcpiOsCreateSemaphore returns AE_NO_MEMORY
     * permanently since the specified call
     */
    Status = AtInitTermCommonTest(OSXF_NUM(AcpiOsCreateSemaphore),
        AtActD_Permanent, AtActRet_NO_MEMORY, TFst1, Check,
        AE_NO_MEMORY);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsCreateSemaphore returns AE_NO_MEMORY
     * one time on the specified call
     */
    return (AtInitTermCommonTest(OSXF_NUM(AcpiOsCreateSemaphore),
        AtActD_OneTime, AtActRet_NO_MEMORY, TFst2, Check,
        AE_NO_MEMORY));
}

ACPI_STATUS
AtInitTest0004(void)
{
    return (Init_NO_MEMORY_Test3(1, 1, CHECK_TERM_ACT));
}

/*
 * ASSERTION 0005:
 */
ACPI_STATUS
AtInitTest0005(void)
{
    ACPI_STATUS             Status;
    UINT32                  TMax = 3;
    UINT32                  i;

    for (i = 0; i < TMax; i++)
    {
        printf ("i == %d\n", i);
        Status = AcpiInitializeSubsystem();
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("AcpiInitializeSubsystem() failure, %s\n",
                AcpiFormatException(Status));
            break;
        }

        Status = OsxfCtrlCheck(SYS_STAT, 0);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            break;
        }

        Status = AtTerminateCtrlCheck(AE_OK, ALL_STAT);
        if (ACPI_FAILURE(Status))
        {
            break;
        }
    }
    return (AE_OK);
}

/*
 * ASSERTION 0006:
 */
ACPI_STATUS
AtInitTest0006(void)
{
    ACPI_STATUS             Status;
    UINT32                  TMax = 3;
    UINT32                  i;

    for (i = 0; i < TMax; i++)
    {
        printf ("i == %d\n", i);
        Status = AcpiTerminate();
        if (ACPI_FAILURE(Status))
        {
            /* It is not an aapi error without previous
             * successful call to AcpiInitializeSubsystem()
             * AapiErrors++;
             * break;
             */
            printf ("AcpiTerminate() returned %s\n",
                AcpiFormatException(Status));
        }

        /*
         * Check the total number of AcpiOS* invocations
         */
        Status = OsxfCtrlCheck(TOTAL_STAT, 1);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            break;
        }
    }
    return (AE_OK);
}

/*
 * ASSERTION 0007:
 */
ACPI_STATUS
AtInitTest0007(void)
{
    ACPI_STATUS             Status;
    UINT32                  TMax = 3, RMax = 3;
    UINT32                  i, j;

    for (i = 0; i < RMax; i++)
    {
        Status = AcpiInitializeSubsystem();
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("AcpiInitializeSubsystem() failure, %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = OsxfCtrlCheck(SYS_STAT, 0);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            return (Status);
        }

        Status = AtTerminateCtrlCheck(AE_OK, ALL_STAT);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        /*
         * Mark the total number of AcpiOS* invocations
         */
        Status = OsxfCtrlCheck(TOTAL_STAT, 0);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            return (Status);
        }

        for (j = 0; j < TMax; j++)
        {
            printf ("j == %d\n", j);

            /*
             * Check the total number of AcpiOS* invocations
             */
            Status = AtTerminateCtrlCheck(AE_OK, TOTAL_STAT);
            if (ACPI_FAILURE(Status))
            {
                return (Status);
            }
        }
    }
    return (AE_OK);
}

/*
 * ASSERTION 0008:
 */
ACPI_STATUS
AtInitTest0008(void)
{
    return (AtInitTermCommonTest(OSXF_NUM(AcpiOsInitialize),
        AtActD_OneTime, AtActRet_ERROR, 1, CHECK_TERM_ACT, AE_ERROR));
}

/*
 * ASSERTION 0009:
 */
ACPI_STATUS
AtInitTest0009(void)
{
    ACPI_STATUS             Status;
    UINT32                  Test_Flags = MALLOC_STAT | LOCK_STAT | SEMAPH_STAT;

    if (Test_Flags & MALLOC_STAT)
    {
        Status = Init_NO_MEMORY_Test1(1, 1,
            CHECK_INIT_COND | CHECK_TERM_ACT | CHECK_FREE_COND);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    if (Test_Flags & LOCK_STAT)
    {
        Status = Init_NO_MEMORY_Test2(1, 1,
            CHECK_INIT_COND | CHECK_TERM_ACT | CHECK_FREE_COND);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    if (Test_Flags & SEMAPH_STAT)
    {
        Status = Init_NO_MEMORY_Test3(1, 1,
            CHECK_INIT_COND | CHECK_TERM_ACT | CHECK_FREE_COND);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }
    return (AE_OK);
}

/*
 * ASSERTION 0010:
 */
ACPI_STATUS
AtInitTest0010(void)
{
    UINT32                  Check_Flags = CHECK_INIT_TERM |
        CHECK_TERM_ACT | CHECK_FREE_COND;

    if (AT_SKIP_FREE_STAT_CHECK)
    {
        Check_Flags &= ~CHECK_FREE_COND;
    }
    return (AtInitTermCommonTest(OSXF_NUM(AcpiOsTotal),
        AtActD_OneTime, AtActRet_ERROR, 1,
        Check_Flags, AE_ERROR));
}

/*
 * ASSERTION 0011:
 */
ACPI_STATUS
AtInitTest0011(void)
{
    ACPI_STATUS             Status;
    UINT32                  Test_Flags = MALLOC_STAT | LOCK_STAT | SEMAPH_STAT;

    if (Test_Flags & MALLOC_STAT)
    {
        Status = Init_NO_MEMORY_Test1(1, 1, CHECK_INIT_TERM | CHECK_FREE_COND);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    if (Test_Flags & LOCK_STAT)
    {
        Status = Init_NO_MEMORY_Test2(1, 1, CHECK_INIT_TERM | CHECK_FREE_COND);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    if (Test_Flags & SEMAPH_STAT)
    {
        Status = Init_NO_MEMORY_Test3(1, 1, CHECK_INIT_TERM | CHECK_FREE_COND);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }
    return (AE_OK);
}

/*
 * ASSERTION 0012:
 */
ACPI_STATUS
AtInitTest0012(void)
{
    ACPI_STATUS             Status;
    int                     RMax = 100;
    int                     i;

    for (i = 0; i < RMax; i++)
    {

        Status = AcpiInitializeSubsystem();
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiInitializeSubsystem() failure, %s,"
                " step %d\n", AcpiFormatException(Status), i);
            return (Status);
        }

        Status = OsxfCtrlCheck(SYS_STAT, 0);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: no any resources allocated, step %d\n", i);
            return (Status);
        }

        Status = AtTerminateCtrlCheck(AE_OK, ALL_STAT);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }
    return (AE_OK);
}

/*
 * ASSERTION 0013:
 */
ACPI_STATUS
AtInitTest0013(void)
{
    ACPI_STATUS             Status;
    int                     RMax = 3;
    int                     i;

    printf ("Test 0013:\n");

    Status = AcpiInitializeSubsystem();
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiInitializeSubsystem() failure, %s,"
            " step %d\n", AcpiFormatException(Status), 0);
        return (Status);
    }

    Status = OsxfCtrlCheck(SYS_STAT, 0);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: no any resources allocated, step %d\n", 1);
        return (Status);
    }

    /*
     * Mark the total number of AcpiOS* invocations
     */
    Status = OsxfCtrlCheck(TOTAL_STAT, 0);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        return (Status);
    }

    for (i = 0; i < RMax; i++)
    {

        Status = AcpiInitializeSubsystem();
        if (ACPI_SUCCESS(Status))
        {
            AapiErrors++;
            printf ("API Error: repeated AcpiInitializeSubsystem() returned %s,"
                " step %d\n", AcpiFormatException(Status), i + 2);
            return (Status);
        }

        /*
         * Check the total number of AcpiOS* invocations
         */
        Status = OsxfCtrlCheck(TOTAL_STAT, 0);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            break;
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0014:
 */
ACPI_STATUS
AtInitTest0014(void)
{
    ACPI_STATUS             Status;

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS,
        0, 0,
        AAPITS_EN_FLAGS, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0015:
 */
ACPI_STATUS
AtInitTest0015(void)
{
    ACPI_STATUS             Status;

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS,
        0, 0,
        AAPITS_EN_FLAGS, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0016:
 */
ACPI_STATUS
AtInitTest0016(void)
{
    ACPI_STATUS             Status;
    int                     RMax = 3;
    int                     i;

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
        Status = AcpiEnableSubsystem(AAPITS_EN_FLAGS);
        if (Status != AE_ERROR)
        {
            AapiErrors++;
            printf ("API Error 2: AcpiEnableSubsystem() returned %s,"
                " expected AE_ERROR\n",
                AcpiFormatException(Status));
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
        printf ("API Error 2: AcpiOS* calls during AcpiEnableSubsystem, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0017:
 */
ACPI_STATUS
AtInitTest0017(void)
{
    ACPI_STATUS             Status;
    int                     RMax = 3;
    int                     i;

    Status = AtInitCommonTest(AAPITS_INITIALIZE_SS,
        AAPITS_INITIALIZE_SS, 0,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < RMax; i++)
    {
        Status = AcpiEnableSubsystem(AAPITS_EN_FLAGS);
        if (Status != AE_ERROR)
        {
            AapiErrors++;
            printf ("API Error: AcpiEnableSubsystem() returned %s,"
                " expected AE_ERROR\n",
                AcpiFormatException(Status));
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
        printf ("API Error: AcpiOS* calls during AcpiEnableSubsystem, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0018:
 */
ACPI_STATUS
AtInitTest0018(void)
{
    ACPI_STATUS             Status;

    Status = AtInitCommonTest(AAPITS_INITIALIZE_SS | AAPITS_ENABLE_SS,
        0, AAPITS_ENABLE_SS,
        AAPITS_EN_FLAGS, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0019:
 */
ACPI_STATUS
AtInitTest0019(void)
{
    ACPI_STATUS             Status;

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS,
        AAPITS_LOADTABLES, AAPITS_ENABLE_SS,
        AAPITS_EN_FLAGS, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0020:
 */
ACPI_STATUS
AtInitTest0020(void)
{
    ACPI_STATUS             Status;

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS,
        AAPITS_ENABLE_SS, 0,
        AAPITS_EN_FLAGS, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0021:
 */
ACPI_STATUS
AtInitTest0021(void)
{
    ACPI_STATUS             Status;
    int                     RMax = 3;
    int                     i;

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS,
        0, 0,
        AAPITS_EN_FLAGS, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < RMax; i++)
    {
        Status = AtInitCommonTest(AAPITS_ENABLE_SS,
            0, AAPITS_ENABLE_SS,
            AAPITS_EN_FLAGS, 0, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0121:
 * > 3. acpi_enable_subsystem(~(ACPI_NO_HARDWARE_INIT | ACPI_NO_ACPI_ENABLE));
 * > 4. acpi_enable_subsystem(ACPI_NO_HARDWARE_INIT | ACPI_NO_ACPI_ENABLE);
 */
ACPI_STATUS
AtInitTest0121(void)
{
    ACPI_STATUS             Status;
    int                     RMax = 1;
    int                     i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("init0121.aml")))
    {
        return (Status);
    }

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS,
        0, 0,
        ~(UINT32)(ACPI_NO_HARDWARE_INIT | ACPI_NO_ACPI_ENABLE), 0, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < RMax; i++)
    {
        Status = AtInitCommonTest(AAPITS_ENABLE_SS,
            0, AAPITS_ENABLE_SS,
            ACPI_NO_HARDWARE_INIT | ACPI_NO_ACPI_ENABLE, 0, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0022:
 */
ACPI_STATUS
AtInitTest0022(void)
{
    ACPI_STATUS             Status;

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS | AAPITS_INITIALIZE_OBJS,
        0, 0,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0023:
 */
ACPI_STATUS
AtInitTest0023(void)
{
    ACPI_STATUS             Status;

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS | AAPITS_INITIALIZE_OBJS,
        0, 0,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0024:
 */
ACPI_STATUS
AtInitTest0024(void)
{
    ACPI_STATUS             Status;
    int                     RMax = 3;
    int                     i;

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
        Status = AcpiInitializeObjects(AAPITS_OI_FLAGS);
        if (Status != AE_ERROR)
        {
            AapiErrors++;
            printf ("API Error 2: AcpiInitializeObjects() returned %s,"
                " expected AE_ERROR\n",
                AcpiFormatException(Status));
            return (Status);
        }
    }

    /*
     * Check the total number of AcpiOS* invocations
     */
    Status = OsxfCtrlCheck(TOTAL_STAT, 1);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error 2: AcpiOS* calls during AcpiInitializeObjects, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0025:
 */
ACPI_STATUS
AtInitTest0025(void)
{
    ACPI_STATUS             Status;
    int                     RMax = 3;
    int                     i;

    Status = AtInitCommonTest(AAPITS_INITIALIZE_SS,
        AAPITS_INITIALIZE_SS, 0,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < RMax; i++)
    {
        Status = AcpiInitializeObjects(AAPITS_OI_FLAGS);
        if (Status != AE_ERROR)
        {
            AapiErrors++;
            printf ("API Error: AcpiInitializeObjects() returned %s,"
                " expected AE_ERROR\n",
                AcpiFormatException(Status));
            return (Status);
        }
    }

    /*
     * Check the total number of AcpiOS* invocations
     */
    Status = OsxfCtrlCheck(TOTAL_STAT, 1);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiOS* calls during AcpiInitializeObjects, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0026:
 */
ACPI_STATUS
AtInitTest0026(void)
{
    ACPI_STATUS             Status;

    Status = AtInitCommonTest(AAPITS_INITIALIZE_SS | AAPITS_INITIALIZE_OBJS,
        0, AAPITS_INITIALIZE_OBJS,
        0, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0027:
 */
ACPI_STATUS
AtInitTest0027(void)
{
    ACPI_STATUS             Status;

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_INITIALIZE_OBJS,
        AAPITS_LOADTABLES, AAPITS_INITIALIZE_OBJS,
        0, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0028:
 */
ACPI_STATUS
AtInitTest0028(void)
{
    ACPI_STATUS             Status;

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_INITIALIZE_OBJS,
        0, AAPITS_INITIALIZE_OBJS,
        0, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0029:
 */
ACPI_STATUS
AtInitTest0029(void)
{
    ACPI_STATUS             Status;

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS | AAPITS_INITIALIZE_OBJS,
        AAPITS_ENABLE_SS, AAPITS_INITIALIZE_OBJS,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0030:
 */
ACPI_STATUS
AtInitTest0030(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("init0030.aml")))
    {
        return (Status);
    }

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS | AAPITS_INITIALIZE_OBJS,
        AAPITS_INITIALIZE_OBJS, 0,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0031:
 */
ACPI_STATUS
AtInitTest0031(void)
{
    ACPI_STATUS             Status;
    int                     RMax = 3;
    int                     i;

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS | AAPITS_INITIALIZE_OBJS,
        0, 0,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < RMax; i++)
    {
        Status = AtInitCommonTest(AAPITS_INITIALIZE_OBJS,
            0, AAPITS_INITIALIZE_OBJS,
            0, AAPITS_OI_FLAGS, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0032:
 */
ACPI_STATUS
AtInitTest0032(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("init0032.aml")))
    {
        return (Status);
    }

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS,
        0, 0,
        AAPITS_EN_FLAGS, 0, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INVC", 0)))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INVM", 0)))
    {
        return (Status);
    }

    Status = AtInitCommonTest(AAPITS_INITIALIZE_OBJS,
        0, 0,
        0, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INVC",
        _INI_TOTAL + _STA_TOTAL - 2)))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INVM",
        TOTAL_MASK | _STA_NEGATIV_MASK)))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * Check InitializationHandler calls
 */
ACPI_STATUS
AtInitializationHandlerCallsCheck(
    UINT32                  Function_INI)
{
    if (Function_INI)
    {
        if (IhFunctionIniCounter != Function_INI)
        {
            AapiErrors++;
            printf ("API Error: %d INI Function calls"
                " of InitializationHandler, expected %d ones\n",
                IhFunctionIniCounter, Function_INI);
            return (AE_ERROR);
        }
    }
    else
    {
        if (IhFunctionIniCounter)
        {
            AapiErrors++;
            printf ("API Error: unexpected INI Function calls"
                " of InitializationHandler, %d times\n",
                IhFunctionIniCounter);
            return (AE_ERROR);
        }
    }

    if (IhFunctionOthersCounter)
    {
        AapiErrors++;
            printf ("API Error: unexpected Unknown Function calls"
                " of InitializationHandler, %d times\n",
            IhFunctionOthersCounter);
        return (AE_ERROR);
    }

    if (!AT_SKIP_IH_OTYPE_CHECK && IhUnexpectedTypeCounter)
    {
        AapiErrors++;
            printf ("API Error: unexpected type of Object"
                " in InitializationHandler, %d times\n",
            IhUnexpectedTypeCounter);
        return (AE_ERROR);
    }

    if (AlternativeHandlerCounter)
    {
        AapiErrors++;
            printf ("API Error: unexpected calls"
                " of AlternativeInitHandler, %d times\n",
            AlternativeHandlerCounter);
        return (AE_ERROR);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0033:
 */
ACPI_STATUS
AtInitTest0033(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("init0032.aml")))
    {
        return (Status);
    }

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS | AAPITS_INITIALIZE_OBJS | AAPITS_INSTALL_IH,
        0, 0,
        AAPITS_EN_FLAGS, ACPI_NO_DEVICE_INIT, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtInitializationHandlerCallsCheck(0)))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INVC", 0)))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INVM", 0)))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0034:
 */
ACPI_STATUS
AtInitTest0034(void)
{
    ACPI_STATUS             Status;
    UINT8                   BenchmarkField[] = {
        0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x1};
    UINT8                   BenchmarkBuffer[] = {
        9, 8, 7, 6, 5, 4, 3, 2, 1, 0};

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("init0034.aml")))
    {
        return (Status);
    }

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS,
        0, 0,
        AAPITS_EN_FLAGS, 0, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /* Region */
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTR", 49)))
    {
        return (Status);
    }

    /* Buffer Fields */
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTF", 64)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTG", 6)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTH", 4)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTI", 2)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTJ", 0)))
    {
        return (Status);
    }

    /* Buffer */
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTB", 9)))
    {
        return (Status);
    }

    /* Package */
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTP", 3)))
    {
        return (Status);
    }

    Status = AtInitCommonTest(AAPITS_INITIALIZE_OBJS,
        0, 0,
        0, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * Check OperationRegions, BufferFields, Buffers, and Packages
     * initialization AML code execution
     */

    /* Region */
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTR", 50)))
    {
        return (Status);
    }

    /* Buffer Fields */
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTF", 65)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckBuffer("\\BFL0",
            sizeof (BenchmarkField), BenchmarkField)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTG", 7)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\BFL1", 0x87)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTH", 5)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\BFL2", 0x8685)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTI", 3)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\BFL3", 0x86858483)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTJ", 1)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\BFL4",
        ((UINT64)0x8090a0b << 32) |  0x0c0d0e0f)))
    {
        return (Status);
    }

    /* Buffer */
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTB", 10)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckBuffer("\\BUF0",
            sizeof (BenchmarkBuffer), BenchmarkBuffer)))
    {
        return (Status);
    }

    /* Package */
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTP", 4)))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0035:
 */
ACPI_STATUS
AtInitTest0035(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("init0034.aml")))
    {
        return (Status);
    }

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS | AAPITS_INITIALIZE_OBJS,
        0, 0,
        AAPITS_EN_FLAGS, ACPI_NO_OBJECT_INIT, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * Check OperationRegions, BufferFields, Buffers, and Packages
     * initialization AML code is not executed
     */

    /* Region */
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTR", 49)))
    {
        return (Status);
    }

    /* Buffer Fields */
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTF", 64)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTG", 6)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTH", 4)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTI", 2)))
    {
        return (Status);
    }
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTJ", 0)))
    {
        return (Status);
    }

    /* Buffer */
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTB", 9)))
    {
        return (Status);
    }

    /* Package */
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INTP", 3)))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0036:
 */
ACPI_STATUS
AtInitTest0036(void)
{
    ACPI_STATUS             Status;

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS | AAPITS_INITIALIZE_OBJS,
        0, 0,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * Mark the total number of AcpiOS* invocations
     */
    Status = OsxfCtrlCheck(TOTAL_STAT, 0);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        return (Status);
    }

    Status = AcpiPurgeCachedObjects();
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiPurgeCachedObjects() failure, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    /*
     * Check the total number of AcpiOS* invocations
     */
    Status = OsxfCtrlCheck(TOTAL_STAT, 1);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiOS* calls during AcpiPurgeCachedObjects, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0037:
 */
ACPI_STATUS
AtInitTest0037(void)
{
    ACPI_STATUS             Status;

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS | AAPITS_INITIALIZE_OBJS,
        0, 0,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    CHECK_SUBSYSTEM_STATUS(AE_OK);

    return (AE_OK);
}

/*
 * ASSERTION 0038:
 */
ACPI_STATUS
AtInitTest0038(void)
{
    ACPI_STATUS             Status;
    UINT32                  CtrlCheck = ALL_STAT;

    if (AT_SKIP_MMAP_CHECK)
    {
        CtrlCheck &= ~MMAP_STAT;
    }

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS | AAPITS_INITIALIZE_OBJS,
        0, 0,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    CHECK_SUBSYSTEM_STATUS(AE_OK);

    Status = AcpiTerminate();
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiTerminate() failure, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    CHECK_SUBSYSTEM_STATUS(AE_ERROR);

    Status = OsxfCtrlCheck(CtrlCheck, 1);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: some resources don't released\n");
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0039:
 */
ACPI_STATUS
AtInitTest0039(void)
{
    ACPI_STATUS             Status;
    UINT32                  StagesScale = 0;
    UINT32                  i = 0;
    UINT32                  Stages[3] = {AAPITS_INITIALIZE_SS,
        AAPITS_LOADTABLES, AAPITS_ENABLE_SS};

    for (i = 0; i < 3; i++)
    {
        StagesScale |= Stages[i];

        Status = AtInitCommonTest(StagesScale,
            0, 0,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        CHECK_SUBSYSTEM_STATUS(AE_ERROR);

        Status = AcpiTerminate();
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiTerminate() failure, %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        CHECK_SUBSYSTEM_STATUS(AE_ERROR);

        Status = AtTerminateCheck(Status, ALL_STAT);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0040:
 */
ACPI_STATUS
AtInitTest0040(void)
{
    ACPI_STATUS             Status;
    UINT32                  StagesScale = 0;
    UINT32                  ErrStagesScale;
    UINT32                  i = 0;
    UINT32                  Stages[5] = {
        AAPITS_INITIALIZE_SS, AAPITS_INITABLES, AAPITS_LOADTABLES,
        AAPITS_ENABLE_SS, AAPITS_INITIALIZE_OBJS};

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("init0030.aml")))
    {
        return (Status);
    }

    for (i = 0; i < 5; i++)
    {
        StagesScale |= Stages[i];
        ErrStagesScale = Stages[i];

        Status = AtInitCommonTest(StagesScale,
            ErrStagesScale, 0,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        CHECK_SUBSYSTEM_STATUS(AE_ERROR);


        Status = AcpiTerminate();
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiTerminate() failure, %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        CHECK_SUBSYSTEM_STATUS(AE_ERROR);

        /* AcpiOsTerminate redundancy issue */
        if (1) continue;

        Status = OsxfCtrlCheck(ALL_STAT, 1);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: some resources don't released\n");
            return (Status);
        }
    }

    return (AE_OK);
}

#define NUM_ACPI_TABLE_TYPES    7
char                    *Table_Names[NUM_ACPI_TABLE_TYPES] = {
    "RSDP", "DSDT", "FADT", "FACS", "PSDT", "SSDT", "XSDT"};

/*
 * ASSERTION 0041:
 */
ACPI_STATUS
AtCheckSystemInfo(
    ACPI_SYSTEM_INFO        *InfoPtr)
{
    if (!(InfoPtr->TimerResolution == 24 || InfoPtr->TimerResolution == 32))
    {
        AapiErrors++;
        printf ("API Error: AcpiGetSystemInfo() returned"
            " TimerResolution (%d) != 24 (or 32)\n",
            InfoPtr->TimerResolution);
        return (AE_ERROR);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0041:
 */
ACPI_STATUS
AtInitTest0041(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;
    ACPI_BUFFER             OutBuffer;
    ACPI_SYSTEM_INFO        Info;
    UINT32                  Stages[6] = {
        0, AAPITS_INITIALIZE_SS, AAPITS_INITABLES, AAPITS_LOADTABLES,
        AAPITS_ENABLE_SS, AAPITS_INITIALIZE_OBJS};

    for (i = 0; i < 6; i++)
    {
        Status = AtInitCommonTest(Stages[i],
            0, 0,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        OutBuffer.Pointer = &Info;
        OutBuffer.Length = 0;

        Status = AcpiGetSystemInfo(&OutBuffer);
        if (Status != AE_BUFFER_OVERFLOW)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo() returned %s,"
                " expected AE_BUFFER_OVERFLOW\n",
                AcpiFormatException(Status));
            return (Status);
        }

        if (OutBuffer.Length != sizeof (Info))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo() returned"
                " Length %d, expected %d\n",
                OutBuffer.Length, sizeof (Info));
            return (AE_ERROR);
        }

        OutBuffer.Pointer = &Info;
        OutBuffer.Length = sizeof (Info) - 1;

        Status = AcpiGetSystemInfo(&OutBuffer);
        if (Status != AE_BUFFER_OVERFLOW)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo() returned %s,"
                " expected AE_BUFFER_OVERFLOW\n",
                AcpiFormatException(Status));
            return (Status);
        }

        if (OutBuffer.Length != sizeof (Info))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo() returned"
                " Length %d, expected %d\n",
                OutBuffer.Length, sizeof (Info));
            return (AE_ERROR);
        }

        OutBuffer.Pointer = &Info;
        OutBuffer.Length = sizeof (Info);

        Status = AcpiGetSystemInfo(&OutBuffer);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo() returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }
        else if (OutBuffer.Length != sizeof (Info))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo() returned"
                " Length %d, expected %d\n",
                OutBuffer.Length, sizeof (Info));
            return (AE_ERROR);
        }
        else if (OutBuffer.Pointer != &Info)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo() succeeded but"
                " OutBuffer.Pointer (%p) is not &Info (%p)\n",
                OutBuffer.Pointer, &Info);
            return (AE_ERROR);
        }
        if (ACPI_FAILURE(Status = AtCheckSystemInfo(OutBuffer.Pointer)))
        {
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0042:
 */
ACPI_STATUS
AtInitTest0042(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;
    ACPI_BUFFER             OutBuffer;
    ACPI_SYSTEM_INFO        Info;
    UINT32                  Stages[6] = {
        0, AAPITS_INITIALIZE_SS, AAPITS_INITABLES, AAPITS_LOADTABLES,
        AAPITS_ENABLE_SS, AAPITS_INITIALIZE_OBJS};

    for (i = 0; i < 6; i++)
    {
        Status = AtInitCommonTest(Stages[i],
            0, 0,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = AcpiGetSystemInfo(NULL);
        if (Status != AE_BAD_PARAMETER)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo(NULL) returned %s,"
                " expected AE_BAD_PARAMETER\n",
                AcpiFormatException(Status));
            return (Status);
        }

        OutBuffer.Pointer = NULL;
        OutBuffer.Length = sizeof (Info);

        Status = AcpiGetSystemInfo(&OutBuffer);
        if (Status != AE_BAD_PARAMETER)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo(OutBuffer.Pointer = NULL)"
                " returned %s, expected AE_BAD_PARAMETER\n",
                AcpiFormatException(Status));
            return (Status);
        }

        OutBuffer.Pointer = &Info;
        OutBuffer.Length = sizeof (Info);

        Status = AcpiGetSystemInfo(&OutBuffer);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo() returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }
        else if (OutBuffer.Length != sizeof (Info))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo() returned"
                " Length %d, expected %d\n",
                OutBuffer.Length, sizeof (Info));
            return (AE_ERROR);
        }
        else if (OutBuffer.Pointer != &Info)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo() succeeded but"
                " OutBuffer.Pointer (%p) is not &Info (%p)\n",
                OutBuffer.Pointer, &Info);
            return (AE_ERROR);
        }
        if (ACPI_FAILURE(Status = AtCheckSystemInfo(OutBuffer.Pointer)))
        {
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0043:
 */
ACPI_STATUS
AtInitTest0043(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;
    ACPI_BUFFER             OutBuffer;
    UINT32                  Stages[5] = {
        AAPITS_INITIALIZE_SS, AAPITS_INITABLES, AAPITS_LOADTABLES,
        AAPITS_ENABLE_SS, AAPITS_INITIALIZE_OBJS};

    for (i = 0; i < 5; i++)
    {
        Status = AtInitCommonTest(Stages[i],
            0, 0,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        OutBuffer.Length = ACPI_ALLOCATE_BUFFER;
        OutBuffer.Pointer = NULL;

        Status = AcpiGetSystemInfo(&OutBuffer);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo() returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }
        else if (OutBuffer.Pointer == NULL)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo() succeeded but returned NULL\n");
            return (AE_ERROR);
        }
        else if (OutBuffer.Length != sizeof (ACPI_SYSTEM_INFO))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo() returned"
                " Length %d, expected %d\n",
                OutBuffer.Length, sizeof (ACPI_SYSTEM_INFO));
            return (AE_ERROR);
        }
        else
        {
            /* Check ACPI_SYSTEM_INFO structure*/
            if (ACPI_FAILURE(Status = AtCheckSystemInfo(OutBuffer.Pointer)))
        {
                return (Status);
            }
            AcpiOsFree(OutBuffer.Pointer);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0044:
 */
ACPI_STATUS
AtInitTest0044(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;
    ACPI_BUFFER             OutBuffer;
    UINT32                  Stages[5] = {
        AAPITS_INITIALIZE_SS, AAPITS_INITABLES, AAPITS_LOADTABLES,
        AAPITS_ENABLE_SS, AAPITS_INITIALIZE_OBJS};

    for (i = 0; i < 5; i++)
    {
        Status = AtInitCommonTest(Stages[i],
            0, 0,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = OsxfCtrlSet(OSXF_NUM(AcpiOsAllocate),
            1, AtActD_OneTime, AtActRet_NULL);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test Error: OsxfCtrlSet() returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        OutBuffer.Length = ACPI_ALLOCATE_BUFFER;
        OutBuffer.Pointer = NULL;

        Status = AcpiGetSystemInfo(&OutBuffer);
        if (Status != AE_NO_MEMORY)
        {
            AapiErrors++;
            printf ("API Error: AcpiGetSystemInfo() returned %s,\n"
                " expected AE_NO_MEMORY\n",
                AcpiFormatException(Status));
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0045:
 */
ACPI_STATUS
AtInitTest0045(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer;

    OutBuffer.Length = ACPI_ALLOCATE_BUFFER;
    OutBuffer.Pointer = NULL;

    Status = AcpiGetSystemInfo(&OutBuffer);
    if (ACPI_SUCCESS(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiGetSystemInfo() returned %s,"
            " expected FAILURE\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AtInitTest0044());
}

/*
 * ASSERTION 0046:
 */
ACPI_STATUS
AtInitTest0046(void)
{
    ACPI_STATUS             Status;
    UINT32                  StagesScale = 0;
    UINT32                  i;
    UINT32                  Stages[6] = {
        0, AAPITS_INITIALIZE_SS, AAPITS_INITABLES, AAPITS_LOADTABLES,
        AAPITS_ENABLE_SS, AAPITS_INITIALIZE_OBJS};

    for (i = 0; i < 6; i++)
    {
        StagesScale |= Stages[i];

        Status = AtInitCommonTest(StagesScale,
            0, 0,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = AcpiInstallInitializationHandler(NULL, 0);
        if (!ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiInstallInitializationHandler(NULL)"
                " returned %s, expected FAILURE\n",
                AcpiFormatException(Status));
            return (Status);
        }

        if (i < 1) continue;

        Status = AcpiTerminate();
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiTerminate() failure, %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        /* AcpiOsTerminate redundancy issue */
        if (1) continue;

        Status = OsxfCtrlCheck(ALL_STAT, 1);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: some resources don't released\n");
            return (Status);
        }
    }

    return (AE_OK);
}

/*
 * AtInitializationHandlerCommon:
 */

/******************************************************************************
 *
 * FUNCTION:    AtInitializationHandlerCommon
 *
 * PARAMETERS:  SpecName        - Device to apply the special return value
 *              SpecRet         - The Status code to return from the Handler
 *              ExpectedINVC    - Expected value of the invocation counter
 *              ExpectedINVM    - Expected mask of the invoked Methods
 *              ExpectedNegativeC_STA - Number of negative _STA invocations
 *              ExpectedNegativeM_STA - Mask of negative _STA invocations
 *              ExpectedCalls   - Total number of Handler calls
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Common test of Global Initialization Handler installation.
 *
 *****************************************************************************/

ACPI_STATUS
AtInitializationHandlerCommon(
    char                    *AmlName,
    UINT8                   *SpecName,
    ACPI_STATUS             SpecRet,
    UINT32                  ExpectedINVC,
    UINT32                  ExpectedINVM,
    UINT32                  ExpectedNegativeC_STA,
    UINT32                  ExpectedNegativeM_STA,
    UINT32                  ExpectedCalls)
{
    ACPI_STATUS             Status;
    UINT32                  StagesScale = 0;
    UINT32                  i, j;
    UINT32                  Stages[3] = {
        AAPITS_INITIALIZE_SS, AAPITS_LOADTABLES, AAPITS_ENABLE_SS};

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet(AmlName)))
    {
        return (Status);
    }

    for (i = 0; i < 3; i++)
    {
        StagesScale |= Stages[i];

        Status = AtInitCommonTest(StagesScale,
            0, 0,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        IhFunctionIniCounter = 0;

        Status = AcpiInstallInitializationHandler(AtAcpiInitHandler, 0);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiInstallInitializationHandler()"
                " returned %s, expected SUCCESS\n",
                AcpiFormatException(Status));
            return (Status);
        }

        for (j = i + 1; j < 3; j++)
        {
            Status = AtInitCommonTest(Stages[j],
                0, 0,
                AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
            if (ACPI_FAILURE(Status))
            {
                return (Status);
            }

            if (ACPI_FAILURE(Status = AtInitializationHandlerCallsCheck(0)))
            {
                printf ("AtInitializationHandlerCallsCheck Error"
                    " after Stage 0x%x (0x%x)\n",
                    Stages[j], StagesScale);
                return (Status);
            }
        }

        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INVC", 0)))
        {
            return (Status);
        }

        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INVM", 0)))
        {
            return (Status);
        }

        AtAcpiInitHandlerSpecName = SpecName;
        AtAcpiInitHandlerSpecRet = SpecRet;
        EstimatedINVC = 0;
        EstimatedINVM = 0;

        Status = AtInitCommonTest(AAPITS_INITIALIZE_OBJS,
            0, 0,
            0, AAPITS_OI_FLAGS, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (AtAcpiInitHandlerSpecRet != AE_OK)
        {
            AapiErrors++;
            printf ("API Error: None InitializationHandler() call"
                " on the Object Name '%s'\n",
                AtAcpiInitHandlerSpecName);
            return (AE_ERROR);
        }

        if (EstimatedINVM & ExpectedNegativeM_STA)
        {
            AapiErrors++;
            printf ("API Error: EstimatedINVM (0x%x) & ExpectedNegativeM_STA"
                " (0x%x) != 0 (unexpected call for not present device)\n",
                EstimatedINVM, ExpectedNegativeM_STA);
            return (AE_ERROR);
        }

        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INVC",
            EstimatedINVC + ExpectedNegativeC_STA)))
        {
            return (Status);
        }

        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INVM",
            EstimatedINVM | ExpectedNegativeM_STA)))
        {
            return (Status);
        }

        if (EstimatedINVC != ExpectedINVC)
        {
            AapiErrors++;
            printf ("API Error: EstimatedINVC (%d) != ExpectedINVC (%d)\n",
                EstimatedINVC, ExpectedINVC);
            return (AE_ERROR);
        }

        if (EstimatedINVM != ExpectedINVM)
        {
            AapiErrors++;
            printf ("API Error: EstimatedINVM (0x%x) != ExpectedINVM (0x%x)\n",
                EstimatedINVM, ExpectedINVM);
            return (AE_ERROR);
        }

        if (ACPI_FAILURE(Status = AtInitializationHandlerCallsCheck(
                ExpectedCalls)))
        {
            return (Status);
        }

        Status = AtTerminateCtrlCheck(AE_OK, ALL_STAT);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0047:
 */
ACPI_STATUS
AtInitTest0047(void)
{
    return (AtInitializationHandlerCommon(
        "init0032.aml",
        NULL, AE_OK, 10, TOTAL_MASK,
        _STA_NEGATIV_CALLS, _STA_NEGATIV_MASK, 8));
}

/*
 * ASSERTION 0048:
 */
ACPI_STATUS
AtInitTest0048(void)
{
    ACPI_STATUS             Status;
    UINT32                  StagesScale = 0;
    UINT32                  i, j;
    UINT32                  Stages[3] = {
        AAPITS_INITIALIZE_SS, AAPITS_LOADTABLES, AAPITS_ENABLE_SS};

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("init0032.aml")))
    {
        return (Status);
    }

    for (i = 0; i < 3; i++)
    {
        StagesScale |= Stages[i];

        Status = AtInitCommonTest(StagesScale,
            0, 0,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        IhFunctionIniCounter = 0;

        Status = AcpiInstallInitializationHandler(AtAcpiInitHandler, 0);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiInstallInitializationHandler()"
                " returned %s, expected SUCCESS\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiInstallInitializationHandler(AlternativeAcpiInitHandler, 0);
        if (Status != AE_ALREADY_EXISTS)
        {
            AapiErrors++;
            printf ("API Error: AcpiInstallInitializationHandler()"
                " returned %s, expected AE_ALREADY_EXISTS\n",
                AcpiFormatException(Status));
            return (AE_ERROR);
        }

        for (j = i + 1; j < 3; j++)
        {
            Status = AtInitCommonTest(Stages[j],
                0, 0,
                AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
            if (ACPI_FAILURE(Status))
            {
                return (Status);
            }

            if (ACPI_FAILURE(Status = AtInitializationHandlerCallsCheck(0)))
            {
                printf ("AtInitializationHandlerCallsCheck Error"
                    " after Stage 0x%x (0x%x)\n",
                    Stages[j], StagesScale);
                return (Status);
            }

            Status = AcpiInstallInitializationHandler(AlternativeAcpiInitHandler, 0);
            if (Status != AE_ALREADY_EXISTS)
            {
                AapiErrors++;
                printf ("API Error: AcpiInstallInitializationHandler()"
                    " returned %s, expected AE_ALREADY_EXISTS\n",
                    AcpiFormatException(Status));
                return (AE_ERROR);
            }
        }

        Status = AtInitCommonTest(AAPITS_INITIALIZE_OBJS,
            0, 0,
            0, AAPITS_OI_FLAGS, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (ACPI_FAILURE(Status = AtInitializationHandlerCallsCheck(5)))
        {
            return (Status);
        }

        Status = AtTerminateCtrlCheck(AE_OK, ALL_STAT);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0049:
 */
ACPI_STATUS
AtInitTest0049(void)
{
    ACPI_STATUS             Status;
    UINT32                  RMax = 3;
    UINT32                  i;

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
        Status = AcpiInstallInitializationHandler(AlternativeAcpiInitHandler, 0);
        if (Status != AE_ERROR)
        {
            AapiErrors++;
            printf ("API Error: AcpiInstallInitializationHandler()"
                " returned %s, expected AE_ERROR\n",
                AcpiFormatException(Status));
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
        printf ("API Error 2: AcpiOS* calls during AcpiInitializeObjects, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0050:
 */
ACPI_STATUS
AtInitTest0050(void)
{
    ACPI_STATUS             Status;
    UINT32                  RMax = 3;
    UINT32                  i;

    Status = AtInitCommonTest(AAPITS_INITIALIZE_SS,
        AAPITS_INITIALIZE_SS, 0,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < RMax; i++)
    {
        Status = AcpiInstallInitializationHandler(
            AlternativeAcpiInitHandler, 0);
        if (Status != AE_ERROR)
        {
            AapiErrors++;
            printf ("API Error: AcpiInstallInitializationHandler()"
                " returned %s, expected AE_ERROR\n",
                AcpiFormatException(Status));
            return (Status);
        }
    }

    /*
     * Check the total number of AcpiOS* invocations
     */
    Status = OsxfCtrlCheck(TOTAL_STAT, 1);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiOS* calls during AcpiInitializeObjects, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0051:
 */
ACPI_STATUS
AtInitTest0051(void)
{
    return (AtInitializationHandlerCommon(
        "init0032.aml",
        (UINT8 *)"DEV5", AE_CTRL_TERMINATE, 5, 0xCE,
        1, 0x20 /* DEV4 */, 5));
}

/*
 * ASSERTION 0052:
 */
ACPI_STATUS
AtInitTest0052(void)
{
    return (AtInitializationHandlerCommon(
        "init0032.aml",
        (UINT8 *)"DEV5", AE_CTRL_DEPTH,
        8, TOTAL_MASK & ~0x330,
        _STA_NEGATIV_CALLS, _STA_NEGATIV_MASK, 7));
}

/*
 * ASSERTION 0053:
 */
ACPI_STATUS
AtInitTest0053(void)
{
    ACPI_STATUS             Status;
    UINT32                  AllEnFlags[] = {
        ACPI_NO_ADDRESS_SPACE_INIT,
        ACPI_NO_HARDWARE_INIT,
        ACPI_NO_EVENT_INIT,
        ACPI_NO_HANDLER_INIT,
        ACPI_NO_ACPI_ENABLE,
        /* ACPI_NO_PCI_INIT */};
    UINT32                  MaxEnFlags = 5; /* 6 with ACPI_NO_PCI_INIT */
    UINT32                  ScaleEnFlags = (1 << MaxEnFlags);
    UINT32                  EnFlags = 0, i, j;

    for (i = 1; i < ScaleEnFlags; i++)
    {
        printf ("i == %d\n", i);

        EnFlags = 0;

        for (j = 0; j < MaxEnFlags; j++)
        {
            if ((i >> j) & 1)
            {
                EnFlags |= AllEnFlags[j];
            }
        }

        /*
         * If ACPI events is not initialized then
         * the handlers can not be initialized too.
         */
        if (EnFlags & ACPI_NO_EVENT_INIT &&
            !(EnFlags & ACPI_NO_HANDLER_INIT) &&
                AT_SKIP_NO_HANDLER_INIT)
        {
            continue;
        }

        Status = AtInitCommonTest(AAPITS_INI_LOAD |
            AAPITS_ENABLE_SS | AAPITS_INITIALIZE_OBJS,
            0, 0,
            EnFlags, AAPITS_OI_FLAGS, NULL);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        CHECK_SUBSYSTEM_STATUS(AE_OK);

        Status = AtTerminateCtrlCheck(AE_OK, ALL_STAT);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0054:
 */
ACPI_STATUS
AtInitTest0054(void)
{
    ACPI_STATUS             Status;

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtExceptionCommonTest(AAPITS_ENABLE_SS,
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
    return (AtExceptionCommonTest(AAPITS_ENABLE_SS,
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY));
}

/*
 * ASSERTION 0055:
 */
ACPI_STATUS
AtInitTest0055(void)
{
    ACPI_STATUS             Status;

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtExceptionCommonTest(AAPITS_INITIALIZE_OBJS,
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
    return (AtExceptionCommonTest(AAPITS_INITIALIZE_OBJS,
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY));
}

#define    TO_STRING(a)    #a

ACPI_STATUS  AllExceptionsCodes[] = {
    AE_OK,
    AE_ERROR,
    AE_NO_ACPI_TABLES,
    AE_NO_NAMESPACE,
    AE_NO_MEMORY,
    AE_NOT_FOUND,
    AE_NOT_EXIST,
    AE_ALREADY_EXISTS,
    AE_TYPE,
    AE_NULL_OBJECT,
    AE_NULL_ENTRY,
    AE_BUFFER_OVERFLOW,
    AE_STACK_OVERFLOW,
    AE_STACK_UNDERFLOW,
    AE_NOT_IMPLEMENTED,
    AE_SUPPORT,
    AE_LIMIT,
    AE_TIME,
    AE_ACQUIRE_DEADLOCK,
    AE_RELEASE_DEADLOCK,
    AE_NOT_ACQUIRED,
    AE_ALREADY_ACQUIRED,
    AE_NO_HARDWARE_RESPONSE,
    AE_NO_GLOBAL_LOCK,
    AE_ABORT_METHOD,
    AE_SAME_HANDLER,
    AE_NO_HANDLER,
//    AE_OWNER_ID_LIMIT,
    AE_BAD_PARAMETER,
    AE_BAD_CHARACTER,
    AE_BAD_PATHNAME,
    AE_BAD_DATA,
    AE_BAD_ADDRESS,
    AE_BAD_HEX_CONSTANT,
    AE_BAD_OCTAL_CONSTANT,
    AE_BAD_DECIMAL_CONSTANT,
    AE_BAD_SIGNATURE,
    AE_BAD_HEADER,
    AE_BAD_CHECKSUM,
    AE_BAD_VALUE,
    AE_INVALID_TABLE_LENGTH,
    AE_AML_BAD_OPCODE,
    AE_AML_NO_OPERAND,
    AE_AML_OPERAND_TYPE,
    AE_AML_OPERAND_VALUE,
    AE_AML_UNINITIALIZED_LOCAL,
    AE_AML_UNINITIALIZED_ARG,
    AE_AML_UNINITIALIZED_ELEMENT,
    AE_AML_NUMERIC_OVERFLOW,
    AE_AML_REGION_LIMIT,
    AE_AML_BUFFER_LIMIT,
    AE_AML_PACKAGE_LIMIT,
    AE_AML_DIVIDE_BY_ZERO,
    AE_AML_BAD_NAME,
    AE_AML_NAME_NOT_FOUND,
    AE_AML_INTERNAL,
    AE_AML_INVALID_SPACE_ID,
    AE_AML_STRING_LIMIT,
    AE_AML_NO_RETURN_VALUE,
    AE_AML_METHOD_LIMIT,
    AE_AML_NOT_OWNER,
    AE_AML_MUTEX_ORDER,
    AE_AML_MUTEX_NOT_ACQUIRED,
    AE_AML_INVALID_RESOURCE_TYPE,
    AE_AML_INVALID_INDEX,
    AE_AML_REGISTER_LIMIT,
    AE_AML_NO_WHILE,
    AE_AML_ALIGNMENT,
    AE_AML_NO_RESOURCE_END_TAG,
    AE_AML_BAD_RESOURCE_VALUE,
    AE_AML_CIRCULAR_REFERENCE,
    AE_AML_BAD_RESOURCE_LENGTH,
    AE_CTRL_RETURN_VALUE,
    AE_CTRL_PENDING,
    AE_CTRL_TERMINATE,
    AE_CTRL_TRUE,
    AE_CTRL_FALSE,
    AE_CTRL_DEPTH,
    AE_CTRL_END,
    AE_CTRL_TRANSFER,
    AE_CTRL_BREAK,
    AE_CTRL_CONTINUE,
    AE_CTRL_SKIP
};

char  *AllExceptionsStrings[] = {
    TO_STRING(AE_OK),
    TO_STRING(AE_ERROR),
    TO_STRING(AE_NO_ACPI_TABLES),
    TO_STRING(AE_NO_NAMESPACE),
    TO_STRING(AE_NO_MEMORY),
    TO_STRING(AE_NOT_FOUND),
    TO_STRING(AE_NOT_EXIST),
    TO_STRING(AE_ALREADY_EXISTS),
    TO_STRING(AE_TYPE),
    TO_STRING(AE_NULL_OBJECT),
    TO_STRING(AE_NULL_ENTRY),
    TO_STRING(AE_BUFFER_OVERFLOW),
    TO_STRING(AE_STACK_OVERFLOW),
    TO_STRING(AE_STACK_UNDERFLOW),
    TO_STRING(AE_NOT_IMPLEMENTED),
    TO_STRING(AE_SUPPORT),
    TO_STRING(AE_LIMIT),
    TO_STRING(AE_TIME),
    TO_STRING(AE_ACQUIRE_DEADLOCK),
    TO_STRING(AE_RELEASE_DEADLOCK),
    TO_STRING(AE_NOT_ACQUIRED),
    TO_STRING(AE_ALREADY_ACQUIRED),
    TO_STRING(AE_NO_HARDWARE_RESPONSE),
    TO_STRING(AE_NO_GLOBAL_LOCK),
    TO_STRING(AE_ABORT_METHOD),
    TO_STRING(AE_SAME_HANDLER),
    TO_STRING(AE_WAKE_ONLY_GPE),
//    TO_STRING(AE_OWNER_ID_LIMIT),
    TO_STRING(AE_BAD_PARAMETER),
    TO_STRING(AE_BAD_CHARACTER),
    TO_STRING(AE_BAD_PATHNAME),
    TO_STRING(AE_BAD_DATA),
    TO_STRING(AE_BAD_ADDRESS),
    TO_STRING(AE_BAD_HEX_CONSTANT),
    TO_STRING(AE_BAD_OCTAL_CONSTANT),
    TO_STRING(AE_BAD_DECIMAL_CONSTANT),
    TO_STRING(AE_BAD_SIGNATURE),
    TO_STRING(AE_BAD_HEADER),
    TO_STRING(AE_BAD_CHECKSUM),
    TO_STRING(AE_BAD_VALUE),
    TO_STRING(AE_INVALID_TABLE_LENGTH),
    TO_STRING(AE_AML_BAD_OPCODE),
    TO_STRING(AE_AML_NO_OPERAND),
    TO_STRING(AE_AML_OPERAND_TYPE),
    TO_STRING(AE_AML_OPERAND_VALUE),
    TO_STRING(AE_AML_UNINITIALIZED_LOCAL),
    TO_STRING(AE_AML_UNINITIALIZED_ARG),
    TO_STRING(AE_AML_UNINITIALIZED_ELEMENT),
    TO_STRING(AE_AML_NUMERIC_OVERFLOW),
    TO_STRING(AE_AML_REGION_LIMIT),
    TO_STRING(AE_AML_BUFFER_LIMIT),
    TO_STRING(AE_AML_PACKAGE_LIMIT),
    TO_STRING(AE_AML_DIVIDE_BY_ZERO),
    TO_STRING(AE_AML_BAD_NAME),
    TO_STRING(AE_AML_NAME_NOT_FOUND),
    TO_STRING(AE_AML_INTERNAL),
    TO_STRING(AE_AML_INVALID_SPACE_ID),
    TO_STRING(AE_AML_STRING_LIMIT),
    TO_STRING(AE_AML_NO_RETURN_VALUE),
    TO_STRING(AE_AML_METHOD_LIMIT),
    TO_STRING(AE_AML_NOT_OWNER),
    TO_STRING(AE_AML_MUTEX_ORDER),
    TO_STRING(AE_AML_MUTEX_NOT_ACQUIRED),
    TO_STRING(AE_AML_INVALID_RESOURCE_TYPE),
    TO_STRING(AE_AML_INVALID_INDEX),
    TO_STRING(AE_AML_REGISTER_LIMIT),
    TO_STRING(AE_AML_NO_WHILE),
    TO_STRING(AE_AML_ALIGNMENT),
    TO_STRING(AE_AML_NO_RESOURCE_END_TAG),
    TO_STRING(AE_AML_BAD_RESOURCE_VALUE),
    TO_STRING(AE_AML_CIRCULAR_REFERENCE),
    TO_STRING(AE_AML_BAD_RESOURCE_LENGTH),
    TO_STRING(AE_CTRL_RETURN_VALUE),
    TO_STRING(AE_CTRL_PENDING),
    TO_STRING(AE_CTRL_TERMINATE),
    TO_STRING(AE_CTRL_TRUE),
    TO_STRING(AE_CTRL_FALSE),
    TO_STRING(AE_CTRL_DEPTH),
    TO_STRING(AE_CTRL_END),
    TO_STRING(AE_CTRL_TRANSFER),
    TO_STRING(AE_CTRL_BREAK),
    TO_STRING(AE_CTRL_CONTINUE),
    TO_STRING(AE_CTRL_SKIP)
};

/*
 * ASSERTION 0056:
 */
ACPI_STATUS
AtInitTest0056(void)
{
    const char              *ExceptionString;
    UINT32                  i;
    UINT32                  NumCodes =
        sizeof (AllExceptionsCodes) / sizeof (ACPI_STATUS);

    for (i = 0; i < NumCodes; i++)
    {
        ExceptionString = AcpiFormatException(AllExceptionsCodes[i]);
        if (!ExceptionString)
        {
            AapiErrors++;
            printf ("API Error: AcpiFormatException(0x%x) returned NULL\n",
                AllExceptionsCodes[i]);
        }
        else if (strcmp(ExceptionString, AllExceptionsStrings[i]) != 0){
            AapiErrors++;
            printf ("API Error: AcpiFormatException(0x%x) returned %s,"
                " expected %s\n",
                AllExceptionsCodes[i], ExceptionString, AllExceptionsStrings[i]);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0057:
 */
ACPI_STATUS
AtInitTest0057(void)
{
    ACPI_STATUS             Status;
    const char              *ExceptionString;
    UINT32                  i, k = 0, NumChecked = 0, NumChecks = 10;
    UINT32                  NumCodes =
        sizeof (AllExceptionsCodes) / sizeof (ACPI_STATUS);

    Status = AllExceptionsCodes[k++];
    while (NumChecked < NumChecks)
    {
        for (i = 0; i < NumCodes; i++)
        {
            if (Status == AllExceptionsCodes[i])
            {
                break;
            }
        }
        if (i < NumCodes)
        {
            Status++;
            k++;
        }
        else
        {
            NumChecked++;
            ExceptionString = AcpiFormatException(Status);
            if (ExceptionString)
            {
                for (i = 0; i < NumCodes; i++)
                {
                    if (strcmp(ExceptionString, AllExceptionsStrings[i]) == 0)
                    {
                        AapiErrors++;
                        printf ("API Error: AcpiFormatException(0x%x) returned"
                            " unexpected '%s' related to 0x%x code\n",
                            Status, ExceptionString, AllExceptionsCodes[i]);
                        break;
                    }
                }
            }
            else
            {
                AapiErrors++;
                printf ("API Error: AcpiFormatException(0x%x) for unknown"
                    " code returned NULL, expected string\n",
                    Status);
            }
            if (k < NumCodes)
            {
                Status = AllExceptionsCodes[k++];
            }
            else
            {
                Status++;
            }
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0058:
 */
ACPI_STATUS
AtInitTest0058(void)
{
    ACPI_STATUS             Status;
    UINT64                  MallocCount[4];
    INT64                   MallocDiff[4];
    INT64                   Diff[4];
    UINT32                  RMax = 3;
    UINT32                  i;

    if (ACPI_MAX_OBJECT_CACHE_DEPTH < 64)
    {
        TestErrors++;
        printf ("Test Error: AtInitTest0058 skipped due to too small"
            "ACPI_MAX_OBJECT_CACHE_DEPTH constant (%d)\n",
            ACPI_MAX_OBJECT_CACHE_DEPTH);
        return (AE_LIMIT);
    }

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("init0058.aml")))
    {
        return (Status);
    }
    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS | AAPITS_INITIALIZE_OBJS,
        0, 0,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    MallocCount[0] = OsxfCtrlGetCalls(OSXF_NUM(AcpiOsAllocate), 1);
    Diff[0] = OsxfCtrlGetDiff(MALLOC_STAT);

    Status = AcpiEvaluateObject (NULL, "\\MAIN", NULL, NULL);

    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiEvaluateObject(\\MAIN) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    MallocCount[1] = OsxfCtrlGetCalls(OSXF_NUM(AcpiOsAllocate), 1);
    MallocDiff[0] = MallocCount[1] - MallocCount[0];
    Diff[1] = OsxfCtrlGetDiff(MALLOC_STAT);

    /*
     * Specified AML code should initiate memory allocations
     * which occupy enough caches positions, but don't exceed
     * any cache limit
     */
    if ((Diff[1] - Diff[0]) < ACPI_MAX_OBJECT_CACHE_DEPTH / 2)
    {
        TestErrors++;
        printf ("Test Error: AtInitTest0058 skipped due to too weak"
            " memory allocation activity (%d)\n",
            (UINT32)(Diff[1] - Diff[0]));
        return (AE_ERROR);
    }

    /*
     * Repeat Specified AML code execution
     */
    for (i = 0; i < RMax; i++)
    {
        Status = AcpiEvaluateObject (NULL, "\\MAIN", NULL, NULL);

        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiEvaluateObject(\\MAIN) returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        MallocCount[2] = OsxfCtrlGetCalls(OSXF_NUM(AcpiOsAllocate), 1);
        MallocDiff[1] = MallocCount[2] - MallocCount[1];
        Diff[2] = OsxfCtrlGetDiff(MALLOC_STAT);

        /*
         * Specified AML code should not initiate needless memory allocations,
         * check that objects from caches were used for memory consumption.
         */
        if ((MallocDiff[0] - MallocDiff[1]) < (Diff[1] - Diff[0]) / 2)
        {
            TestErrors++;
            printf ("Test Error %d: too little %d memory allocations"
                " shortening basing on caches\n",
                i, (UINT32)(MallocDiff[0] - MallocDiff[1]));
            return (AE_ERROR);
        }
        if (Diff[2] != Diff[1])
        {
            TestErrors++;
            printf ("Test Error %d: AtInitTest0058 skipped due to %d memory allocations"
                " outside caches\n",
                i, (UINT32)(Diff[2] - Diff[1]));
            return (AE_ERROR);
        }
        if (i > 0)
        {
            if (MallocDiff[2] != MallocDiff[1])
            {
                TestErrors++;
                printf ("API Error %d: %d memory allocations"
                    " against %d previous\n",
                    i, (UINT32)MallocDiff[2], (UINT32)MallocDiff[1]);
                return (AE_ERROR);
            }
        }
        MallocCount[1] = MallocCount[2];
        MallocDiff[2] = MallocDiff[1];
    }

    Status = AcpiPurgeCachedObjects();
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiPurgeCachedObjects() failure, %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    MallocCount[3] = OsxfCtrlGetCalls(OSXF_NUM(AcpiOsAllocate), 1);
    Diff[3] = OsxfCtrlGetDiff(MALLOC_STAT);

    /*
     * AcpiPurgeCachedObjects is expected to release Cached Objects.
     */
    if (Diff[3] != Diff[0])
    {
        AapiErrors++;
        printf ("API Error: AcpiPurgeCachedObjects is not release %d"
            " allocations\n",
            (UINT32)(Diff[3] - Diff[0]));
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0059: extension of 0047
 */
ACPI_STATUS
AtInitTest0059(void)
{
    return (AtInitializationHandlerCommon(
        "init0059.aml",
        NULL, AE_OK, 12, TOTAL_MASK | 0xC000,
        _STA_NEGATIV_CALLS + 1, _STA_NEGATIV_MASK | 0x20000,
        9));
}

/*
 * ASSERTION 0060:
 */
ACPI_STATUS
AtInitTest0060(void)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;
    BLD_TABLES_TASK         BldTask = {BLD_NO_FADT, 0};

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, BldTask);

    Status = AtSubsystemInit(AAPITS_INITIALIZE_SS,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtInitializeTables(FALSE);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiInitializeTables() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiLoadTables();
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiLoadTables() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiEnableSubsystem(0);
    if (Status != AE_NO_ACPI_TABLES)
    {
        AapiErrors++;
        printf ("API error: AcpiEnableSubsystem () returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_NO_ACPI_TABLES));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0066:
 */
ACPI_STATUS
AtInitTest0066(void)
{
    ACPI_STATUS             Status;
    UINT8    BenchmarkBuffer[] = {9, 8, 7, 6, 5, 4, 3, 2, 1, 0};

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("init0066.aml")))
    {
        return (Status);
    }

    Status = AtInitCommonTest(AAPITS_INI_LOAD |
        AAPITS_ENABLE_SS,
        0, 0,
        AAPITS_EN_FLAGS, 0, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

/*
    Status = AtInitCommonTest(AAPITS_INITIALIZE_OBJS,
        0, 0,
        0, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }
*/
    /* Buffer Fields */
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\INT0", 64)))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckBuffer("\\MBF0",
            sizeof (BenchmarkBuffer), BenchmarkBuffer)))
    {
        return (Status);
    }

    return (AE_OK);
}
