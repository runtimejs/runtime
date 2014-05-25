/******************************************************************************
 *
 * Module Name: atgpe - ACPICA General Purpose Event Management API tests
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
#include "atgpe.h"
#include "atosxfctrl.h"

#define _COMPONENT          ACPI_TOOLS
        ACPI_MODULE_NAME    ("atgpe")

static ACPI_GENERIC_ADDRESS GpeBlockAddress = {
    /* Address space where struct or register exists */
    ACPI_ADR_SPACE_SYSTEM_MEMORY,
    0x20,    /* Size in bits of given register */
    0x00,    /* Bit offset within the register */
    0x01,    /* Minimum Access size (ACPI 3.0) */
    0x80,    /* 64-bit address of struct or register) */
};

static UINT32               RegisterCount = 0x08;
static UINT32               InterruptNumber = 0x40;

ACPI_STATUS
AtInstallGpeBlockCommon(
    UINT32                  CheckAction,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    ACPI_STRING             Pathname = "\\DGPE";
    ACPI_HANDLE             GpeDevice;
    ACPI_GENERIC_ADDRESS    *GpeBlockAddressPointer = &GpeBlockAddress;
    UINT32                  RegisterCountLocal = RegisterCount;
    UINT32                  InterruptNumber = 0xD;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("gpev0000.aml")))
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

    if (CheckAction == 1)
    {
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_LOAD)))
        {
            return (Status);
        }
        Pathname = "\\AUX2.DEV0";
    }

    if (CheckAction == 2)
    {
        Pathname = "\\NGPE";
    }

    Status = AcpiGetHandle (NULL, Pathname, &GpeDevice);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    if (CheckAction == 1)
    {
        /* Make Device handle invalid by unloading SSDT table*/
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
    }
    else if (CheckAction == 3)
    {
        GpeBlockAddressPointer = NULL;
    }
    else if (CheckAction == 4)
    {
        RegisterCountLocal = 0;
    }

    Status = AcpiInstallGpeBlock (GpeDevice, GpeBlockAddressPointer,
        RegisterCountLocal, InterruptNumber);
    if (Status != ExpectedStatus)
    {
        AapiErrors++;
        printf ("Api Error: AcpiInstallGpeBlock(%s) returned %s, expected %s\n",
            Pathname, AcpiFormatException(Status),
            AcpiFormatException(ExpectedStatus));
        if (Status != AE_OK)
        {
            return (Status);
        }
        else
        {
            return (AE_ERROR);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0000:
 */
ACPI_STATUS
AtGpeTest0000(void)
{
    return (AtInstallGpeBlockCommon(0, AE_OK));
}

/*
 * ASSERTION 0001:
 */
ACPI_STATUS
AtGpeTest0001(void)
{
    return (AtInstallGpeBlockCommon(1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0002:
 */
ACPI_STATUS
AtGpeTest0002(void)
{
    return (AtInstallGpeBlockCommon(2, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0003:
 */
ACPI_STATUS
AtGpeTest0003(void)
{
    return (AtInstallGpeBlockCommon(3, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0004:
 */
ACPI_STATUS
AtGpeTest0004(void)
{
    return (AtInstallGpeBlockCommon(4, AE_BAD_PARAMETER));
}

ACPI_STATUS
AtInstallGpeBlockExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_STRING             Pathname = "\\DGPE";
    ACPI_HANDLE             GpeDevice;

    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtWalkNamespaceExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = AcpiGetHandle (NULL, Pathname, &GpeDevice);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                Pathname, AcpiFormatException(Status));
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

        Status = AcpiInstallGpeBlock (GpeDevice, &GpeBlockAddress,
            RegisterCount, InterruptNumber);

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
                printf ("API Error: AcpiInstallGpeBlock returned %s,\n"
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

/*
 * ASSERTION 0005:
 */
ACPI_STATUS
AtGpeTest0005(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("gpev0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */

    Status = AtInstallGpeBlockExceptionTest(
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

    Status = AtInstallGpeBlockExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

ACPI_STATUS
AtRemoveGpeBlockCommon(
    UINT32                  CheckAction,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    ACPI_STRING             Pathname = "\\DGPE";
    ACPI_HANDLE             GpeDevice;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("gpev0000.aml")))
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

    if (CheckAction == 1)
    {
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_LOAD)))
        {
            return (Status);
        }
        Pathname = "\\AUX2.DEV0";
    }

    Status = AcpiGetHandle (NULL, Pathname, &GpeDevice);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiInstallGpeBlock (GpeDevice, &GpeBlockAddress,
        RegisterCount, InterruptNumber);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiInstallGpeBlock(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    if (CheckAction == 1)
    {
        /* Make Device handle invalid by unloading SSDT table*/
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
    }
    else if (CheckAction == 2)
    {
        Pathname = "\\NGPE";
    }

    Status = AcpiRemoveGpeBlock (GpeDevice);
    if (Status != ExpectedStatus)
    {
        AapiErrors++;
        printf ("Api Error: AcpiInstallGpeBlock(%s) returned %s, expected %s\n",
            Pathname, AcpiFormatException(Status),
            AcpiFormatException(ExpectedStatus));
        if (Status != AE_OK)
        {
            return (Status);
        }
        else
        {
            return (AE_ERROR);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0006:
 */
ACPI_STATUS
AtGpeTest0006(void)
{
    return (AtRemoveGpeBlockCommon(0, AE_OK));
}

/*
 * ASSERTION 0007:
 */
ACPI_STATUS
AtGpeTest0007(void)
{
    return (AtRemoveGpeBlockCommon(1, AE_BAD_PARAMETER));
}

ACPI_STATUS
AtGpeCommon(
    ACPI_STRING             Pathname,
    UINT32                  GpeNumber[],
    UINT8                   GpeType[],
    UINT32                  GpeCount,
    UINT32                  ApiCall,
    UINT32                  CheckAction,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             GpeDevice = NULL;
    UINT32                  Gpe;
    UINT32                  i;
    char                    *ApiCallName;
    ACPI_EVENT_STATUS       GpeStatus, *GpeStatusPointer = &GpeStatus;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("gpev0000.aml")))
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

    if (CheckAction == 1)
    {
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_LOAD)))
        {
            return (Status);
        }
        Pathname = "\\AUX2.DEV0";
    }

    if (Pathname)
    {
        Status = AcpiGetHandle (NULL, Pathname, &GpeDevice);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                Pathname, AcpiFormatException(Status));
            return (Status);
        }

        if (CheckAction != 2)
        {
            Status = AcpiInstallGpeBlock (GpeDevice, &GpeBlockAddress,
                RegisterCount, InterruptNumber);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("Api Error: AcpiInstallGpeBlock(%s) returned %s\n",
                    Pathname, AcpiFormatException(Status));
                return (Status);
            }
        }
    }

#if 0
/* OBSOLETE interface, AcpiSetGpeType */

    if (CheckAction != 2 && ApiCall != 0)
    {
        for (i = 0; i < GpeCount; i++)
        {
            Gpe = GpeNumber[i];
            Type = GpeType[i];

            Status = AcpiSetGpeType(GpeDevice, Gpe, Type);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("API Error: AcpiSetGpeType(0x%x, 0x%x) returned %s\n",
                    Gpe, (UINT32)Type, AcpiFormatException(Status));
                return (Status);
            }
        }
    }
#endif


    if (CheckAction == 1)
    {
        /* Make Device handle invalid by unloading SSDT table*/
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
    }

    for (i = 0; i < GpeCount; i++)
    {
        Gpe = GpeNumber[i];

        if (CheckAction == 3)
        {
            Gpe += 256;
        }
        else if (CheckAction == 5)
        {
            GpeStatusPointer = NULL;
        }

        switch (ApiCall)
        {
        case 0:
            ApiCallName = "AcpiSetGpeType";
#if 0
/* OBSOLETE INTERFACE */
            Status = AcpiSetGpeType(GpeDevice, Gpe, Type);
#endif
            Status = AE_OK;
            break;
        case 1:
            ApiCallName = "AcpiEnableGpe";
            Status = AcpiEnableGpe(GpeDevice, Gpe);
            break;
        case 2:
            ApiCallName = "AcpiClearGpe";
            Status = AcpiClearGpe(GpeDevice, Gpe);
            break;
        case 3:
            ApiCallName = "AcpiGetGpeStatus";
            Status = AcpiGetGpeStatus(GpeDevice, Gpe, GpeStatusPointer);
            break;
        case 4:
            ApiCallName = "AcpiDisableGpe";
            Status = AcpiDisableGpe(GpeDevice, Gpe);
            break;
        default:
            TestErrors++;
            printf ("Test Error: the ApiCall number (%d) should be in range 0-4\n",
                ApiCall);
            return (AE_ERROR);
        }

        if (Status != ExpectedStatus)
        {
            AapiErrors++;
            printf ("Api Error: %s(%d) returned %s, expected %s\n",
                ApiCallName, Gpe, AcpiFormatException(Status),
                AcpiFormatException(ExpectedStatus));
            if (Status != AE_OK)
            {
                return (Status);
            }
            else
            {
                return (AE_ERROR);
            }
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

static UINT32           GpeNumber[] = {0, 7, 8, 15, 16, 31, 63};

#if 0
/* OBSOLETE */
static UINT8            GpeType[] = {
        ACPI_GPE_TYPE_WAKE,
        ACPI_GPE_TYPE_RUNTIME,
        ACPI_GPE_TYPE_WAKE_RUN,
        ACPI_GPE_TYPE_WAKE,
        ACPI_GPE_TYPE_RUNTIME,
        ACPI_GPE_TYPE_WAKE_RUN,
        ACPI_GPE_TYPE_WAKE};
#endif

static UINT8            GpeEolType[] = {
        ACPI_GPE_LEVEL_TRIGGERED,
        ACPI_GPE_EDGE_TRIGGERED,
        ACPI_GPE_LEVEL_TRIGGERED,
        ACPI_GPE_EDGE_TRIGGERED,
        ACPI_GPE_LEVEL_TRIGGERED,
        ACPI_GPE_EDGE_TRIGGERED,
        ACPI_GPE_LEVEL_TRIGGERED};

/*
 * ASSERTION 0008:
 */
ACPI_STATUS
AtGpeTest0008(void)
{
    return (AtGpeCommon(NULL, GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        0 /* SetGpeType */, 0, AE_OK));
}

/*
 * ASSERTION 0009:
 */
ACPI_STATUS
AtGpeTest0009(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        0 /* SetGpeType */, 0, AE_OK));
}

/*
 * ASSERTION 0010:
 */
ACPI_STATUS
AtGpeTest0010(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        0 /* SetGpeType */, 1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0011:
 */
ACPI_STATUS
AtGpeTest0011(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        0 /* SetGpeType */, 2, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0012:
 */
ACPI_STATUS
AtGpeTest0012(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        0 /* SetGpeType */, 3, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0013:
 */
ACPI_STATUS
AtGpeTest0013(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        0 /* SetGpeType */, 4, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0014:
 */
ACPI_STATUS
AtGpeTest0014(void)
{
    return (AtGpeCommon(NULL, GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        1 /* EnableGpe */, 0, AE_OK));
}

/*
 * ASSERTION 0015:
 */
ACPI_STATUS
AtGpeTest0015(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        1 /* EnableGpe */, 0, AE_OK));
}

/*
 * ASSERTION 0016:
 */
ACPI_STATUS
AtGpeTest0016(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        1 /* EnableGpe */, 1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0017:
 */
ACPI_STATUS
AtGpeTest0017(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        1 /* EnableGpe */, 2, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0018:
 */
ACPI_STATUS
AtGpeTest0018(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        1 /* EnableGpe */, 3, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0019:
 */
ACPI_STATUS
AtGpeTest0019(void)
{
    return (AtGpeCommon(NULL, GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        2 /* ClearGpe */, 0, AE_OK));
}

/*
 * ASSERTION 0020:
 */
ACPI_STATUS
AtGpeTest0020(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        2 /* ClearGpe */, 0, AE_OK));
}

/*
 * ASSERTION 0021:
 */
ACPI_STATUS
AtGpeTest0021(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        2 /* ClearGpe */, 1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0022:
 */
ACPI_STATUS
AtGpeTest0022(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        2 /* ClearGpe */, 2, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0023:
 */
ACPI_STATUS
AtGpeTest0023(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        2 /* ClearGpe */, 3, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0024:
 */
ACPI_STATUS
AtGpeTest0024(void)
{
    return (AtGpeCommon(NULL, GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        3 /* GetGpeStatus */, 0, AE_OK));
}

/*
 * ASSERTION 0025:
 */
ACPI_STATUS
AtGpeTest0025(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        3 /* GetGpeStatus */, 0, AE_OK));
}

/*
 * ASSERTION 0026:
 */
ACPI_STATUS
AtGpeTest0026(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        3 /* GetGpeStatus */, 1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0027:
 */
ACPI_STATUS
AtGpeTest0027(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        3 /* GetGpeStatus */, 2, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0028:
 */
ACPI_STATUS
AtGpeTest0028(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        3 /* GetGpeStatus */, 3, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0029:
 */
ACPI_STATUS
AtGpeTest0029(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        3 /* GetGpeStatus */, 5, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0030:
 */
ACPI_STATUS
AtGpeTest0030(void)
{
    return (AtGpeCommon(NULL, GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        4 /* DisableGpe */, 0, AE_OK));
}

/*
 * ASSERTION 0031:
 */
ACPI_STATUS
AtGpeTest0031(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        4 /* DisableGpe */, 0, AE_OK));
}

/*
 * ASSERTION 0032:
 */
ACPI_STATUS
AtGpeTest0032(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        4 /* DisableGpe */, 1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0033:
 */
ACPI_STATUS
AtGpeTest0033(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        4 /* DisableGpe */, 2, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0034:
 */
ACPI_STATUS
AtGpeTest0034(void)
{
    return (AtGpeCommon("\\DGPE", GpeNumber, NULL,
        sizeof (GpeNumber) / sizeof (UINT32),
        4 /* DisableGpe */, 3, AE_BAD_PARAMETER));
}

#define AT_NUM_GPE_EVENTS   5
static UINT32           GpeHandlerCounter;
static UINT32           GpeHandlerContext[AT_NUM_GPE_EVENTS];

UINT32
AtGpeHandler0 (
    ACPI_HANDLE             GpeDevice,
    UINT32                  GpeNumber,
    void                    *Context)
{
    UINT32                  HandlerId = 0;

    printf ("AtGpeHandler%d: Context %p\n", HandlerId, Context);
    ++GpeHandlerCounter;

    if ((UINT32 *)Context - GpeHandlerContext > AT_NUM_GPE_EVENTS) {
        AapiErrors++;
        printf ("AtGpeHandler: Context (0x%p) is out of"
            " GpeHandlerContext (0x%p: %d)\n",
            Context, GpeHandlerContext, AT_NUM_GPE_EVENTS);
    }

    return (0);
}

UINT32
AtGpeHandler1 (
    ACPI_HANDLE             GpeDevice,
    UINT32                  GpeNumber,
    void                    *Context)
{
    UINT32                  HandlerId = 1;

    printf ("AtGpeHandler%d: Context %p\n", HandlerId, Context);
    ++GpeHandlerCounter;

    if ((UINT32 *)Context - GpeHandlerContext > AT_NUM_GPE_EVENTS) {
        AapiErrors++;
        printf ("AtGpeHandler: Context (0x%p) is out of"
            " GpeHandlerContext (0x%p: %d)\n",
            Context, GpeHandlerContext, AT_NUM_GPE_EVENTS);
    }

    return (0);
}

UINT32
AtGpeHandler2 (
    ACPI_HANDLE             GpeDevice,
    UINT32                  GpeNumber,
    void                    *Context)
{
    UINT32                  HandlerId = 2;

    printf ("AtGpeHandler%d: Context %p\n", HandlerId, Context);
    ++GpeHandlerCounter;

    if ((UINT32 *)Context - GpeHandlerContext > AT_NUM_GPE_EVENTS) {
        AapiErrors++;
        printf ("AtGpeHandler: Context (0x%p) is out of"
            " GpeHandlerContext (0x%p: %d)\n",
            Context, GpeHandlerContext, AT_NUM_GPE_EVENTS);
    }

    return (0);
}

static ACPI_GPE_HANDLER   GpeHandlers[AT_NUM_GPE_EVENTS] = {
    AtGpeHandler0, AtGpeHandler0,
    AtGpeHandler1, AtGpeHandler1,
    AtGpeHandler2};

ACPI_STATUS
AtInstallGpeHandlerCommon(
    UINT32                  CheckAction,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    ACPI_STRING             Pathname = "\\DGPE";
    ACPI_HANDLE             GpeDevice = NULL;
    UINT32                  Gpe;
    UINT8                   EolType;
    ACPI_GPE_HANDLER        EventHandler;
    UINT32                  i;
    UINT32                  InitStages = AAPITS_INI_DEF & ~AAPITS_INSTALL_HS;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("gpev0000.aml")))
    {
        return (Status);
    }

    if (CheckAction == 1)
    {
        InitStages |= AAPITS_INSTALL_HS;
    }

    Status = AtSubsystemInit(
        InitStages,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (CheckAction == 1)
    {
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_LOAD)))
        {
            return (Status);
        }
        Pathname = "\\AUX2.DEV0";
    }

    Status = AcpiGetHandle (NULL, Pathname, &GpeDevice);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    if (CheckAction != 2)
    {
        Status = AcpiInstallGpeBlock (GpeDevice, &GpeBlockAddress,
            RegisterCount, InterruptNumber);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiInstallGpeBlock(%s) returned %s\n",
                Pathname, AcpiFormatException(Status));
            return (Status);
        }
    }

    if (CheckAction == 1)
    {
        /* Make Device handle invalid by unloading SSDT table*/
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
    }
    else if (CheckAction == 5)
    {
        if (ExpectedStatus != AE_ALREADY_EXISTS)
        {
            TestErrors++;
            printf ("Test Error: ExpectedStatus %s != AE_ALREADY_EXISTS\n",
                AcpiFormatException(ExpectedStatus));
            return (AE_ERROR);
        }
        ExpectedStatus = AE_OK;
    }

    GpeHandlerCounter = 0;
    for (i = 0; i < AT_NUM_GPE_EVENTS; i++)
    {
        Gpe = GpeNumber[i];
        EolType = GpeEolType[i];
        EventHandler = GpeHandlers[i];

        if (CheckAction == 3)
        {
            Gpe += 256;
        }
        else if (CheckAction == 4)
        {
            EventHandler = NULL;
        }

        GpeHandlerContext[i] = 0;

        Status = AcpiInstallGpeHandler(GpeDevice, Gpe, EolType,
            EventHandler, &GpeHandlerContext[i]);

        if (Status != ExpectedStatus)
        {
            AapiErrors++;
            printf ("Api Error: AcpiInstallGpeHandler(%d, 0x%x, 0x%p)"
                " returned %s, expected %s\n",
                Gpe, EolType, EventHandler, AcpiFormatException(Status),
                AcpiFormatException(ExpectedStatus));
            if (Status != AE_OK)
            {
                return (Status);
            }
            else
            {
                return (AE_ERROR);
            }
        }
    }

    if (CheckAction == 5)
    {
        for (i = 0; i < AT_NUM_GPE_EVENTS; i++)
        {
            Gpe = GpeNumber[i];
            EolType = GpeEolType[i];
            EventHandler = GpeHandlers[(i + 1) % AT_NUM_GPE_EVENTS];

            Status = AcpiInstallGpeHandler(GpeDevice, Gpe, EolType,
                EventHandler, &GpeHandlerContext[i]);
            if (Status != AE_ALREADY_EXISTS)
            {
                AapiErrors++;
                printf ("Error: AcpiInstallGpeHandler(%d, 0x%x, 0x%p) returned %s,"
                    " expected %s\n",
                    Gpe, EolType, EventHandler, AcpiFormatException(Status),
                    AcpiFormatException(AE_ALREADY_EXISTS));
                return (AE_ERROR);
            }
        }
    }

    if (GpeHandlerCounter != 0)
    {
        AapiErrors++;
        printf ("Api Error: Gpe Handler invoked %d times\n",
            GpeHandlerCounter);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0035:
 *
 */
ACPI_STATUS
AtGpeTest0035(void)
{
    return (AtInstallGpeHandlerCommon(0, AE_OK));
}

/*
 * ASSERTION 0036:
 *
 */
ACPI_STATUS
AtGpeTest0036(void)
{
    return (AtInstallGpeHandlerCommon(1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0037:
 *
 */
ACPI_STATUS
AtGpeTest0037(void)
{
    return (AtInstallGpeHandlerCommon(2, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0038:
 *
 */
ACPI_STATUS
AtGpeTest0038(void)
{
    return (AtInstallGpeHandlerCommon(3, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0039:
 *
 */
ACPI_STATUS
AtGpeTest0039(void)
{
    return (AtInstallGpeHandlerCommon(4, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0040:
 *
 */
ACPI_STATUS
AtGpeTest0040(void)
{
    return (AtInstallGpeHandlerCommon(5, AE_ALREADY_EXISTS));
}

ACPI_STATUS
AtRemoveGpeHandlerCommon(
    UINT32                  CheckAction,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    ACPI_STRING             Pathname = "\\DGPE";
    ACPI_HANDLE             GpeDevice = NULL;
    UINT32                  Gpe;
    UINT8                   EolType;
    ACPI_GPE_HANDLER        EventHandler;
    UINT32                  i;
    UINT32                  InitStages = AAPITS_INI_DEF & ~AAPITS_INSTALL_HS;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("gpev0000.aml")))
    {
        return (Status);
    }

    if (CheckAction == 1)
    {
        InitStages |= AAPITS_INSTALL_HS;
    }

    Status = AtSubsystemInit(
        InitStages,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (CheckAction == 1)
    {
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_LOAD)))
        {
            return (Status);
        }
        Pathname = "\\AUX2.DEV0";
    }

    Status = AcpiGetHandle (NULL, Pathname, &GpeDevice);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    GpeHandlerCounter = 0;

    if (CheckAction != 2)
    {
        Status = AcpiInstallGpeBlock (GpeDevice, &GpeBlockAddress,
            RegisterCount, InterruptNumber);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiInstallGpeBlock(%s) returned %s\n",
                Pathname, AcpiFormatException(Status));
            return (Status);
        }

        if (CheckAction != 6)
        {
            for (i = 0; i < AT_NUM_GPE_EVENTS; i++)
            {
                Gpe = GpeNumber[i];
                EolType = GpeEolType[i];
                EventHandler = GpeHandlers[i];
                GpeHandlerContext[i] = 0;

                Status = AcpiInstallGpeHandler(GpeDevice, Gpe, EolType,
                    EventHandler, &GpeHandlerContext[i]);
                if (ACPI_FAILURE(Status))
                {
                    AapiErrors++;
                    printf ("Error: AcpiInstallGpeHandler(%d, 0x%x, 0x%p) returned %s\n",
                        Gpe, EolType, EventHandler, AcpiFormatException(Status));
                    return (Status);
                }
            }
        }
    }

    if (CheckAction == 1)
    {
        /* Make Device handle invalid by unloading SSDT table*/
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
    }

    for (i = 0; i < AT_NUM_GPE_EVENTS; i++)
    {
        Gpe = GpeNumber[i];
        EolType = GpeEolType[i];
        EventHandler = GpeHandlers[i];

        if (CheckAction == 3)
        {
            Gpe += 256;
        }
        else if (CheckAction == 4)
        {
            EventHandler = NULL;
        }
        else if (CheckAction == 5)
        {
            EventHandler = GpeHandlers[(i + 2) % AT_NUM_GPE_EVENTS];
        }

        Status = AcpiRemoveGpeHandler(GpeDevice, Gpe, EventHandler);

        if (Status != ExpectedStatus)
        {
            AapiErrors++;
            printf ("Api Error: AcpiRemoveGpeHandler(%d, 0x%p)"
                " returned %s, expected %s\n",
                Gpe, EventHandler, AcpiFormatException(Status),
                AcpiFormatException(ExpectedStatus));
            if (Status != AE_OK)
            {
                return (Status);
            }
            else
            {
                return (AE_ERROR);
            }
        }
    }

    if (GpeHandlerCounter != 0)
    {
        AapiErrors++;
        printf ("Api Error: Gpe Handler invoked %d times\n",
            GpeHandlerCounter);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0041:
 *
 */
ACPI_STATUS
AtGpeTest0041(void)
{
    return (AtRemoveGpeHandlerCommon(0, AE_OK));
}

/*
 * ASSERTION 0042:
 *
 */
ACPI_STATUS
AtGpeTest0042(void)
{
    return (AtRemoveGpeHandlerCommon(1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0043:
 *
 */
ACPI_STATUS
AtGpeTest0043(void)
{
    return (AtRemoveGpeHandlerCommon(2, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0044:
 *
 */
ACPI_STATUS
AtGpeTest0044(void)
{
    return (AtRemoveGpeHandlerCommon(3, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0045:
 *
 */
ACPI_STATUS
AtGpeTest0045(void)
{
    return (AtRemoveGpeHandlerCommon(4, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0046:
 *
 */
ACPI_STATUS
AtGpeTest0046(void)
{
    return (AtRemoveGpeHandlerCommon(5, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0047:
 *
 */
ACPI_STATUS
AtGpeTest0047(void)
{
    return (AtRemoveGpeHandlerCommon(6, AE_NOT_EXIST));
}
