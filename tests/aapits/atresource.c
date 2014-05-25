/******************************************************************************
 *
 * Module Name: atresource - ACPICA Resource Management API tests
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
#include "atresource.h"
#include "atosxfctrl.h"

#define _COMPONENT          ACPI_TOOLS
        ACPI_MODULE_NAME    ("atresource")


#if ACPI_MACHINE_WIDTH == 64
#define RT0000_DEV0_CRS_LEN 0xCA0
#else
#define RT0000_DEV0_CRS_LEN 0x8C0
#endif
/*
 * ASSERTION 0000:
 */
ACPI_STATUS
AtRsrcTest0000(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";
    ACPI_RESOURCE           *CurrentResource;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiGetCurrentResources (Device, &OutBuffer);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetCurrentResources(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    if (OutBuffer.Length != RT0000_DEV0_CRS_LEN)
    {
        AapiErrors++;
        printf ("API Error: AcpiGetCurrentResources(%s) returned Length %d,"
            " expected %d\n",
            Pathname, OutBuffer.Length, RT0000_DEV0_CRS_LEN);
        return (AE_ERROR);
    }

    /*
     * OutBuffer should be parsed and all field of ACPI_RESOURCE
     * structure should be checked
     */

    CurrentResource = (ACPI_RESOURCE *)OutBuffer.Pointer;

	/*	IRQ (Level, ActiveLow, Shared) {0} */

    if (CurrentResource->Type != ACPI_RESOURCE_TYPE_IRQ)
    {
        AapiErrors++;
        printf ("Api Error: Resource->Type (%d) != ACPI_RESOURCE_TYPE_IRQ\n",
            CurrentResource->Type);
    }

    if (CurrentResource->Length < ACPI_RS_SIZE (ACPI_RESOURCE_IRQ))
    {
        AapiErrors++;
        printf ("Api Error: Resource->Length (%d) < %d\n",
            CurrentResource->Length, ACPI_RS_SIZE (ACPI_RESOURCE_IRQ));
    }

    if (CurrentResource->Data.Irq.Triggering != 0) /* Level-Triggered */
    {
        AapiErrors++;
        printf ("Api Error: Irq.Triggering (%d) != 0\n",
            CurrentResource->Data.Irq.Triggering);
    }

    if (CurrentResource->Data.Irq.Polarity != 1) /* Active-Low */
    {
        AapiErrors++;
        printf ("Api Error: Irq.Polarity (%d) != 1\n",
            CurrentResource->Data.Irq.Polarity);
    }

    if (CurrentResource->Data.Irq.Sharable != 1) /* Interrupt is sharable */
    {
        AapiErrors++;
        printf ("Api Error: Irq.Sharable (%d) != 1\n",
            CurrentResource->Data.Irq.Sharable);
    }

    if (CurrentResource->Data.Irq.InterruptCount != 1)
    {
        AapiErrors++;
        printf ("Api Error: Irq.InterruptCount (%d) != 1\n",
            CurrentResource->Data.Irq.InterruptCount);
    }

    if (CurrentResource->Data.Irq.Interrupts[0] != 0)
    {
        AapiErrors++;
        printf ("Api Error: Irq.Interrupts[0] (%d) != 0\n",
            CurrentResource->Data.Irq.Interrupts[0]);
    }

    AcpiOsFree(OutBuffer.Pointer);

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0001:
 */
ACPI_STATUS
AtRsrcTest0001(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\AUX2.DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_LOAD)))
    {
        return (Status);
    }

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    /* Make Device handle invalid by unloading SSDT table*/
    if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
    {
        return (Status);
    }

    Status = AcpiGetCurrentResources (Device, &OutBuffer);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetCurrentResources(%s) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0002:
 */
ACPI_STATUS
AtRsrcTest0002(void)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiGetCurrentResources (Device, NULL);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetCurrentResources(%s) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0003:
 */
ACPI_STATUS
AtRsrcTest0003(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    OutBuffer.Length = 1;
    OutBuffer.Pointer = NULL;

    Status = AcpiGetCurrentResources (Device, &OutBuffer);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetCurrentResources(%s) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0004:
 */
ACPI_STATUS
AtRsrcTest0004(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\M000";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiGetCurrentResources (Device, &OutBuffer);
    if (Status != AE_TYPE)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetCurrentResources(%s) returned %s,"
            " expected AE_TYPE\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0005:
 */
ACPI_STATUS
AtRsrcTest0005(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer;
    UINT32                  BufferSpace;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    OutBuffer.Length = 4;
    OutBuffer.Pointer = &BufferSpace;

    Status = AcpiGetCurrentResources (Device, &OutBuffer);
    if (Status != AE_BUFFER_OVERFLOW)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetCurrentResources(%s) returned %s,"
            " expected AE_BUFFER_OVERFLOW\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    if (OutBuffer.Length != RT0000_DEV0_CRS_LEN)
    {
        AapiErrors++;
        printf ("API Error: AcpiGetCurrentResources(%s) returned Length %d,"
            " expected %d\n",
            Pathname, OutBuffer.Length, RT0000_DEV0_CRS_LEN);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

ACPI_STATUS
AtGetCurrentResourcesExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  CtrlCheck = ALL_STAT;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_BUFFER             OutBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";


    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtGetCurrentResourcesExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = AcpiGetHandle (NULL, Pathname, &Device);
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

        Status = AcpiGetCurrentResources (Device, &OutBuffer);

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
                printf ("API Error: AcpiGetCurrentResources returned %s,\n"
                    "           expected to return %s\n",
                    AcpiFormatException(Status), AcpiFormatException(Benchmark));
                return (AE_ERROR);
            }
        }
        if (ACPI_SUCCESS(Status))
        {
            AcpiOsFree(OutBuffer.Pointer);
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
 * ASSERTION 0006:
 */
ACPI_STATUS
AtRsrcTest0006(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtGetCurrentResourcesExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 12,
        AE_NO_MEMORY);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    return (AtGetCurrentResourcesExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY));
}

/*
 * ASSERTION 0007:
 */
ACPI_STATUS
AtRsrcTest0007(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";
    ACPI_RESOURCE           *CurrentResource;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiGetPossibleResources (Device, &OutBuffer);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetPossibleResources(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    /*
     * OutBuffer should be parsed and all field of ACPI_RESOURCE
     * structure should be checked
     */

    CurrentResource = (ACPI_RESOURCE *)OutBuffer.Pointer;

	/*	IRQ (Level, ActiveLow, Shared) {0} */

    if (CurrentResource->Type != ACPI_RESOURCE_TYPE_IRQ)
    {
        AapiErrors++;
        printf ("Api Error: Resource->Type (%d) != ACPI_RESOURCE_TYPE_IRQ\n",
            CurrentResource->Type);
    }

    if (CurrentResource->Length !=
        ACPI_ROUND_UP_TO_NATIVE_WORD (ACPI_RS_SIZE (ACPI_RESOURCE_IRQ)))
    {
        AapiErrors++;
        printf ("Api Error: Resource->Length (%d) != %d\n",
            CurrentResource->Length,
            ACPI_ROUND_UP_TO_NATIVE_WORD (ACPI_RS_SIZE (ACPI_RESOURCE_IRQ)));
    }

    if (CurrentResource->Data.Irq.Triggering != 0) /* Level-Triggered */
    {
        AapiErrors++;
        printf ("Api Error: Irq.Triggering (%d) != 0\n",
            CurrentResource->Data.Irq.Triggering);
    }

    if (CurrentResource->Data.Irq.Polarity != 1) /* Active-Low */
    {
        AapiErrors++;
        printf ("Api Error: Irq.Polarity (%d) != 1\n",
            CurrentResource->Data.Irq.Polarity);
    }

    if (CurrentResource->Data.Irq.Sharable != 1) /* Interrupt is sharable */
    {
        AapiErrors++;
        printf ("Api Error: Irq.Sharable (%d) != 1\n",
            CurrentResource->Data.Irq.Sharable);
    }

    if (CurrentResource->Data.Irq.InterruptCount != 1)
    {
        AapiErrors++;
        printf ("Api Error: Irq.InterruptCount (%d) != 1\n",
            CurrentResource->Data.Irq.InterruptCount);
    }

    if (CurrentResource->Data.Irq.Interrupts[0] != 0)
    {
        AapiErrors++;
        printf ("Api Error: Irq.Interrupts[0] (%d) != 0\n",
            CurrentResource->Data.Irq.Interrupts[0]);
    }

    AcpiOsFree(OutBuffer.Pointer);

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0008:
 */
ACPI_STATUS
AtRsrcTest0008(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\AUX2.DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_LOAD)))
    {
        return (Status);
    }

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    /* Make Device handle invalid by unloading SSDT table*/
    if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
    {
        return (Status);
    }

    Status = AcpiGetPossibleResources (Device, &OutBuffer);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetPossibleResources(%s) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0009:
 */
ACPI_STATUS
AtRsrcTest0009(void)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiGetPossibleResources (Device, NULL);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetPossibleResources(%s) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0010:
 */
ACPI_STATUS
AtRsrcTest0010(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    OutBuffer.Length = 1;
    OutBuffer.Pointer = NULL;

    Status = AcpiGetPossibleResources (Device, &OutBuffer);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetPossibleResources(%s) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0011:
 */
ACPI_STATUS
AtRsrcTest0011(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\M000";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiGetPossibleResources (Device, &OutBuffer);
    if (Status != AE_TYPE)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetPossibleResources(%s) returned %s,"
            " expected AE_TYPE\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0012:
 */
ACPI_STATUS
AtRsrcTest0012(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer;
    UINT32                  BufferSpace;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    OutBuffer.Length = 4;
    OutBuffer.Pointer = &BufferSpace;

    Status = AcpiGetPossibleResources (Device, &OutBuffer);
    if (Status != AE_BUFFER_OVERFLOW)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetPossibleResources(%s) returned %s,"
            " expected AE_BUFFER_OVERFLOW\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    if (OutBuffer.Length != RT0000_DEV0_CRS_LEN)
    {
        AapiErrors++;
        printf ("API Error: AcpiGetPossibleResources(%s) returned Length %d,"
            " expected %d\n",
            Pathname, OutBuffer.Length, RT0000_DEV0_CRS_LEN);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

ACPI_STATUS
AtGetPossibleResourcesExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  CtrlCheck = ALL_STAT;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_BUFFER             OutBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";


    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtGetPossibleResourcesExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = AcpiGetHandle (NULL, Pathname, &Device);
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

        Status = AcpiGetPossibleResources (Device, &OutBuffer);

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
                printf ("API Error: AcpiGetPossibleResources returned %s,\n"
                    "           expected to return %s\n",
                    AcpiFormatException(Status), AcpiFormatException(Benchmark));
                return (AE_ERROR);
            }
        }
        if (ACPI_SUCCESS(Status))
        {
            AcpiOsFree(OutBuffer.Pointer);
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
 * ASSERTION 0013:
 */
ACPI_STATUS
AtRsrcTest0013(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtGetPossibleResourcesExceptionTest(
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
    return (AtGetPossibleResourcesExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY));
}

ACPI_RESOURCE           Resource[2];

void
AtInitResourceBuffer(ACPI_BUFFER *InBuffer)
{
    ACPI_RESOURCE           *CurrentResource = &Resource[0];
    ACPI_RESOURCE           *EndResource;

	/*	IRQ (Level, ActiveLow, Shared) {0} */

    CurrentResource->Type = ACPI_RESOURCE_TYPE_IRQ;
    CurrentResource->Length = ACPI_RS_SIZE (ACPI_RESOURCE_IRQ);
    CurrentResource->Data.Irq.Triggering = 0; /* Level-Triggered */
//    CurrentResource->Data.Irq.Polarity = 1;   /* Active-Low */
    CurrentResource->Data.Irq.Polarity = 0;   /* Active-High */
    CurrentResource->Data.Irq.Sharable = 1;   /* Interrupt is sharable */
    CurrentResource->Data.Irq.InterruptCount = 1;
    CurrentResource->Data.Irq.Interrupts[0] = 1;

    CurrentResource->Length = ACPI_ROUND_UP_TO_NATIVE_WORD (CurrentResource->Length);

    EndResource = (ACPI_RESOURCE *)((UINT8 *)CurrentResource +
        CurrentResource->Length);
    EndResource->Type = ACPI_RESOURCE_TYPE_END_TAG;
    EndResource->Length = ACPI_RS_SIZE (ACPI_RESOURCE_END_TAG);

    InBuffer->Length = CurrentResource->Length + EndResource->Length;
    InBuffer->Pointer = CurrentResource;
}

/*
 * ASSERTION 0014:
 */
ACPI_STATUS
AtRsrcTest0014(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             InBuffer;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    AtInitResourceBuffer(&InBuffer);

    /* Add the flag to print contents of buffers */
    AcpiDbgLevel |= ACPI_LV_TABLES;

    Status = AcpiSetCurrentResources (Device, &InBuffer);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiSetCurrentResources(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0015:
 */
ACPI_STATUS
AtRsrcTest0015(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             InBuffer;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\AUX2.DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_LOAD)))
    {
        return (Status);
    }

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    /* Make Device handle invalid by unloading SSDT table*/
    if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
    {
        return (Status);
    }

    AtInitResourceBuffer(&InBuffer);

    Status = AcpiSetCurrentResources (Device, &InBuffer);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiSetCurrentResources(%s) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0016:
 */
ACPI_STATUS
AtRsrcTest0016(void)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiSetCurrentResources (Device, NULL);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiSetCurrentResources(%s) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0017:
 */
ACPI_STATUS
AtRsrcTest0017(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             InBuffer;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    InBuffer.Length = 1;
    InBuffer.Pointer = NULL;

    Status = AcpiSetCurrentResources (Device, &InBuffer);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiSetCurrentResources(%s) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0018:
 */
ACPI_STATUS
AtRsrcTest0018(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             InBuffer;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    AtInitResourceBuffer(&InBuffer);
    InBuffer.Length = 0;

    Status = AcpiSetCurrentResources (Device, &InBuffer);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiSetCurrentResources(%s) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0019:
 */
ACPI_STATUS
AtRsrcTest0019(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             InBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\M000";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    AtInitResourceBuffer(&InBuffer);

    Status = AcpiSetCurrentResources (Device, &InBuffer);
    if (Status != AE_TYPE)
    {
        AapiErrors++;
        printf ("Api Error: AcpiSetCurrentResources(%s) returned %s,"
            " expected AE_TYPE\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

ACPI_STATUS
AtSetCurrentResourcesExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  CtrlCheck = ALL_STAT;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_BUFFER             InBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";


    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtSetCurrentResourcesExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = AcpiGetHandle (NULL, Pathname, &Device);
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

        AtInitResourceBuffer(&InBuffer);

        Status = AcpiSetCurrentResources (Device, &InBuffer);

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
                printf ("API Error: AcpiSetCurrentResources returned %s,\n"
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
 * ASSERTION 0020:
 */
ACPI_STATUS
AtRsrcTest0020(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtSetCurrentResourcesExceptionTest(
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
    return (AtSetCurrentResourcesExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY));
}

/*
 * ASSERTION 0021:
 */
ACPI_STATUS
AtRsrcTest0021(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";
    ACPI_STRING             RefPath = "\\DEV0.LNKA";
    ACPI_PCI_ROUTING_TABLE  *UserPrt;
    UINT32                  Length;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiGetIrqRoutingTable (Device, &OutBuffer);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetIrqRoutingTable(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    /*
     * OutBuffer should be parsed and all field of ACPI_PCI_ROUTING_TABLE
     * structure should be checked
     */

    UserPrt = (ACPI_PCI_ROUTING_TABLE *)OutBuffer.Pointer;

/*
 *              Package(0x04){
 *                      0x001FFFFF,
 *                      0x00,
 *                      \DEV0.LNKA,
 *                      0x00
 *                   },
 */

    if (UserPrt->Address != 0x001FFFFF)
    {
        AapiErrors++;
        printf ("Api Error: PciRT->Address (0x%x) != 0x%x\n",
            (UINT32)UserPrt->Address, 0x001FFFFF);
    }

    if (UserPrt->Pin != 0)
    {
        AapiErrors++;
        printf ("Api Error: PciRT->Pin (%d) != %d\n",
            UserPrt->Pin, 0);
    }

    if (UserPrt->SourceIndex != 0)
    {
        AapiErrors++;
        printf ("Api Error: PciRT->SourceIndex (%d) != %d\n",
            UserPrt->SourceIndex, 0);
    }

    if (strcmp(UserPrt->Source, RefPath))
    {
        AapiErrors++;
        printf ("Api Error: PciRT->Source (%s) != %s\n",
            UserPrt->Source, RefPath);
    }

    Length = sizeof (ACPI_PCI_ROUTING_TABLE) - 4 + strlen(RefPath) + 1;
    Length = (UINT32) ACPI_ROUND_UP_TO_64BIT (Length);

    if (UserPrt->Length != Length)
    {
        AapiErrors++;
        printf ("Api Error: PciRT->Length (%d) != %d\n",
            UserPrt->Length, Length);
    }

    AcpiOsFree(OutBuffer.Pointer);

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0022:
 */
ACPI_STATUS
AtRsrcTest0022(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\AUX2.DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_LOAD)))
    {
        return (Status);
    }

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    /* Make Device handle invalid by unloading SSDT table*/
    if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
    {
        return (Status);
    }

    Status = AcpiGetIrqRoutingTable (Device, &OutBuffer);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetIrqRoutingTable(%s) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0023:
 */
ACPI_STATUS
AtRsrcTest0023(void)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiGetIrqRoutingTable (Device, NULL);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetIrqRoutingTable(%s) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0024:
 */
ACPI_STATUS
AtRsrcTest0024(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    OutBuffer.Length = 1;
    OutBuffer.Pointer = NULL;

    Status = AcpiGetIrqRoutingTable (Device, &OutBuffer);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetIrqRoutingTable(%s) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0025:
 */
ACPI_STATUS
AtRsrcTest0025(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\M000";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiGetIrqRoutingTable (Device, &OutBuffer);
    if (Status != AE_TYPE)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetIrqRoutingTable(%s) returned %s,"
            " expected AE_TYPE\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0026:
 */
ACPI_STATUS
AtRsrcTest0026(void)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutBuffer;
    UINT32                  BufferSpace;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    OutBuffer.Length = 4;
    OutBuffer.Pointer = &BufferSpace;

    Status = AcpiGetIrqRoutingTable (Device, &OutBuffer);
    if (Status != AE_BUFFER_OVERFLOW)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetIrqRoutingTable(%s) returned %s,"
            " expected AE_BUFFER_OVERFLOW\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    if (OutBuffer.Length != 0xB8)
    {
        AapiErrors++;
        printf ("API Error: AcpiGetIrqRoutingTable(%s) returned Length %d,"
            " expected %d\n",
            Pathname, OutBuffer.Length, 0xA48);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

ACPI_STATUS
AtGetIRQRoutingTableExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  CtrlCheck = ALL_STAT;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_BUFFER             OutBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";


    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtGetIRQRoutingTableExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = AcpiGetHandle (NULL, Pathname, &Device);
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

        Status = AcpiGetIrqRoutingTable (Device, &OutBuffer);

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
                printf ("API Error: AcpiGetIrqRoutingTable returned %s,\n"
                    "           expected to return %s\n",
                    AcpiFormatException(Status), AcpiFormatException(Benchmark));
                return (AE_ERROR);
            }
        }
        if (ACPI_SUCCESS(Status))
        {
            AcpiOsFree(OutBuffer.Pointer);
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
 * ASSERTION 0027:
 */
ACPI_STATUS
AtRsrcTest0027(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtGetIRQRoutingTableExceptionTest(
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
    return (AtGetIRQRoutingTableExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY));
}

static UINT32               WalkResourcesHandlerCounter;
static UINT32               WalkResourcesHandlerLength;
static UINT32               WalkResourcesHandlerContext;

ACPI_STATUS AtWalkResourcesHandler (
    ACPI_RESOURCE           *Resource,
    void                    *Context)
{

    printf ("AtWalkResourcesHandler: Resource %p (Type 0x%x, Len 0x%x), Context %p\n",
        Resource, Resource->Type, Resource->Length, Context);
    ++WalkResourcesHandlerCounter;
    WalkResourcesHandlerLength += Resource->Length;

    if (Context != &WalkResourcesHandlerContext) {
        AapiErrors++;
        printf ("AtWalkResourcesHandler: Context (%p) !="
            " &WalkResourcesHandlerContext (%p)\n",
            Context, &WalkResourcesHandlerContext);
    }

    if (WalkResourcesHandlerCounter) {
        return (*(UINT32 *)Context);
    }

	/*	IRQ (Level, ActiveLow, Shared) {0} */

    if (Resource->Type != ACPI_RESOURCE_TYPE_IRQ)
    {
        AapiErrors++;
        printf ("Api Error: Resource->Type (%d) != ACPI_RESOURCE_TYPE_IRQ\n",
            Resource->Type);
    }

    if (Resource->Length != ACPI_RS_SIZE (ACPI_RESOURCE_IRQ))
    {
        AapiErrors++;
        printf ("Api Error: Resource->Length (%d) != %d\n",
            Resource->Length, ACPI_RS_SIZE (ACPI_RESOURCE_IRQ));
    }

    if (Resource->Data.Irq.Triggering != 0) /* Level-Triggered */
    {
        AapiErrors++;
        printf ("Api Error: Irq.Triggering (%d) != 0\n",
            Resource->Data.Irq.Triggering);
    }

    if (Resource->Data.Irq.Polarity != 1) /* Active-Low */
    {
        AapiErrors++;
        printf ("Api Error: Irq.Polarity (%d) != 1\n",
            Resource->Data.Irq.Polarity);
    }

    if (Resource->Data.Irq.Sharable != 1) /* Interrupt is sharable */
    {
        AapiErrors++;
        printf ("Api Error: Irq.Sharable (%d) != 1\n",
            Resource->Data.Irq.Sharable);
    }

    if (Resource->Data.Irq.InterruptCount != 1)
    {
        AapiErrors++;
        printf ("Api Error: Irq.InterruptCount (%d) != 1\n",
            Resource->Data.Irq.InterruptCount);
    }

    if (Resource->Data.Irq.Interrupts[0] != 0)
    {
        AapiErrors++;
        printf ("Api Error: Irq.Interrupts[0] (%d) != 0\n",
            Resource->Data.Irq.Interrupts[0]);
    }

    return (*(UINT32 *)Context);
}

ACPI_STATUS
AtWalkResourcesTestCommon(
    char                    *MethodPath,
    UINT32                  WalkResourcesHandlerRet,
    ACPI_STATUS             ExpectedStatus,
    UINT32                  ExpectedCounter,
    UINT32                  ExpectedLength)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    WalkResourcesHandlerCounter = 0;
    WalkResourcesHandlerLength  = 0;
    WalkResourcesHandlerContext = WalkResourcesHandlerRet;

    Status = AcpiWalkResources (Device, MethodPath,
        AtWalkResourcesHandler, &WalkResourcesHandlerContext);
    if (Status != ExpectedStatus)
    {
        AapiErrors++;
        printf ("Api Error: AcpiWalkResources(%s, %s) returned %s,"
            " expected %s\n",
            Pathname, MethodPath,
            AcpiFormatException(Status),
            AcpiFormatException(ExpectedStatus));
        return (AE_ERROR);
    }

    if (WalkResourcesHandlerCounter != ExpectedCounter)
    {
        AapiErrors++;
        printf ("Api Error: WalkResourcesHandlerCounter (%d) !="
            "ExpectedCounter (%d)\n",
            WalkResourcesHandlerCounter, ExpectedCounter);
        return (AE_ERROR);
    }

    if (WalkResourcesHandlerLength != ExpectedLength)
    {
        AapiErrors++;
        printf ("Api Error: WalkResourcesHandlerLength (%d) !="
            " ExpectedLength (%d)\n",
            WalkResourcesHandlerLength, ExpectedLength);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0028:
 */
ACPI_STATUS
AtRsrcTest0028(void)
{
    ACPI_STATUS             Status;

    Status = AtWalkResourcesTestCommon("_CRS", AE_OK, AE_OK,
        25, RT0000_DEV0_CRS_LEN);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtWalkResourcesTestCommon("_PRS", AE_OK, AE_OK,
        25, RT0000_DEV0_CRS_LEN);
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
AtRsrcTest0029(void)
{
    ACPI_STATUS             Status;

    Status = AtWalkResourcesTestCommon("_CRS", AE_CTRL_DEPTH, AE_OK,
        25, RT0000_DEV0_CRS_LEN);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtWalkResourcesTestCommon("_PRS", AE_CTRL_DEPTH, AE_OK,
        25, RT0000_DEV0_CRS_LEN);
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
AtRsrcTest0030(void)
{
    ACPI_STATUS             Status;

    Status = AtWalkResourcesTestCommon("_CRS", AE_CTRL_TERMINATE, AE_OK, 1, 16);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtWalkResourcesTestCommon("_PRS", AE_CTRL_TERMINATE, AE_OK, 1, 16);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0031:
 */
ACPI_STATUS
AtRsrcTest0031(void)
{
    ACPI_STATUS             Status;

    Status = AtWalkResourcesTestCommon("_CRS",
        AE_ERROR, AE_ERROR, 1, 16);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtWalkResourcesTestCommon("_PRS",
        AE_ERROR, AE_ERROR, 1, 16);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0032:
 */
ACPI_STATUS
AtRsrcTest0032(void)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\AUX2.DEV0";
    char                    *MethodPath = "_CRS";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_LOAD)))
    {
        return (Status);
    }

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    /* Make Device handle invalid by unloading SSDT table*/
    if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
    {
        return (Status);
    }

        /* Empty cash to force actual memory allocations */
        Status = AcpiPurgeCachedObjects();
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiPurgeCachedObjects() failure, %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

    WalkResourcesHandlerCounter = 0;
    WalkResourcesHandlerContext = AE_OK;

    Status = AcpiWalkResources (Device, MethodPath,
        AtWalkResourcesHandler, &WalkResourcesHandlerContext);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiWalkResources(%s, %s) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            Pathname, "_CRS",
            AcpiFormatException(Status));
        return (Status);
    }

    if (WalkResourcesHandlerCounter != 0)
    {
        AapiErrors++;
        printf ("Api Error: WalkResourcesHandlerCounter (%d) !="
            "ExpectedCounter (%d)\n",
            WalkResourcesHandlerCounter, 0);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0033:
 */
ACPI_STATUS
AtRsrcTest0033(void)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";
    char                    *MethodPath = "_PRT";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    WalkResourcesHandlerCounter = 0;
    WalkResourcesHandlerContext = AE_OK;

    Status = AcpiWalkResources (Device, MethodPath,
        AtWalkResourcesHandler, &WalkResourcesHandlerContext);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiWalkResources(%s, %s) returned %s,"
            " expected AE_BAD_PARAMETER\n",
            Pathname, "_CRS",
            AcpiFormatException(Status));
        return (Status);
    }

    if (WalkResourcesHandlerCounter != 0)
    {
        AapiErrors++;
        printf ("Api Error: WalkResourcesHandlerCounter (%d) !="
            "ExpectedCounter (%d)\n",
            WalkResourcesHandlerCounter, 0);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

ACPI_STATUS
AtWalkResourcesExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  CtrlCheck = ALL_STAT;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";
    char                    *MethodPath = "_CRS";


    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtWalkResourcesExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = AcpiGetHandle (NULL, Pathname, &Device);
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

        WalkResourcesHandlerCounter = 0;
        WalkResourcesHandlerContext = AE_OK;

        Status = AcpiWalkResources (Device, MethodPath,
            AtWalkResourcesHandler, &WalkResourcesHandlerContext);

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
                printf ("API Error: AcpiWalkResources returned %s,\n"
                    "           expected to return %s\n",
                    AcpiFormatException(Status), AcpiFormatException(Benchmark));
                return (AE_ERROR);
            }

            if (WalkResourcesHandlerCounter != 0)
            {
                AapiErrors++;
                printf ("Api Error: WalkResourcesHandlerCounter (%d) !="
                    "ExpectedCounter (%d)\n",
                    WalkResourcesHandlerCounter, 0);
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
 * ASSERTION 0034:
 */
ACPI_STATUS
AtRsrcTest0034(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtWalkResourcesExceptionTest(
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
    return (AtWalkResourcesExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY));
}

static	UINT8           Buffer0035[] =  {
		0x23, 0x01, 0x00, 0x00,
		0x22, 0x02, 0x00,
		0x2a, 0x04, 0x02,
		0x47, 0x01, 0xf1, 0xf0, 0xf3, 0xf2, 0xf4, 0xf5,
		0x4b, 0xf1, 0xf0, 0xf2,
		0x77, 0x00, 0xa2, 0xb3, 0x76, 0xd5, 0xe6, 0xf7,
		0x81, 0x09, 0x00, 0x01, 0xf1, 0xf0, 0xf3, 0xf2, 0xf5, 0xf4, 0xf7, 0xf6,
		0x85, 0x11, 0x00, 0x01,
			0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
			0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc,
		0x86, 0x09, 0x00, 0x00,
			0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0x84, 0x15, 0x00, 0x9f,
			0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
			0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
			0x00, 0x01, 0x02, 0x03,
		0x8a, 0x39, 0x00, 0x01, 0x0f, 0x33,
			0xdf, 0xde, 0xdd, 0xdc, 0xdb, 0xda, 0xd9, 0xd8,
			0xe7, 0xe6, 0xe5, 0xe4, 0xe3, 0xe2, 0xe1, 0xe0,
			0xef, 0xee, 0xed, 0xec, 0xeb, 0xea, 0xe9, 0xe8,
			0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
			0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00,
		0x87, 0x25, 0x00, 0x01, 0x0f, 0x33, 0xef, 0xee, 0xed, 0xec,
			0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
			0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00,
		0x88, 0x1b, 0x00, 0x01, 0x0f, 0x33,
			0xf7, 0xf6, 0xf9, 0xf8, 0xfb, 0xfa, 0xfd, 0xfc, 0xff, 0xfe,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00,
		0x8a, 0x39, 0x00, 0x00, 0x0f, 0x30,
			0xdf, 0xde, 0xdd, 0xdc, 0xdb, 0xda, 0xd9, 0xd8,
			0xe7, 0xe6, 0xe5, 0xe4, 0xe3, 0xe2, 0xe1, 0xe0,
			0xef, 0xee, 0xed, 0xec, 0xeb, 0xea, 0xe9, 0xe8,
			0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
			0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00,
		0x87, 0x25, 0x00, 0x00, 0x0f, 0x30,
			0xef, 0xee, 0xed, 0xec,
			0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
			0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00,
		0x88, 0x1b, 0x00, 0x02, 0x0f, 0x00,
			0xf7, 0xf6, 0xf9, 0xf8, 0xfb, 0xfa, 0xfd, 0xfc, 0xff, 0xfe,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00,
		0x89, 0xc8, 0x04, 0x0f, 0xff,
			  1,  0,  0,  0,  2,  0,  0,  0,  3,  0,  0,  0,  4,  0,  0,  0,
			  5,  0,  0,  0,  6,  0,  0,  0,  7,  0,  0,  0,  8,  0,  0,  0,
			  9,  0,  0,  0, 10,  0,  0,  0, 11,  0,  0,  0, 12,  0,  0,  0,
			 13,  0,  0,  0, 14,  0,  0,  0, 15,  0,  0,  0, 16,  0,  0,  0,
			 17,  0,  0,  0, 18,  0,  0,  0, 19,  0,  0,  0, 20,  0,  0,  0,
			 21,  0,  0,  0, 22,  0,  0,  0, 23,  0,  0,  0, 24,  0,  0,  0,
			 25,  0,  0,  0, 26,  0,  0,  0, 27,  0,  0,  0, 28,  0,  0,  0,
			 29,  0,  0,  0, 30,  0,  0,  0, 31,  0,  0,  0, 32,  0,  0,  0,
			 33,  0,  0,  0, 34,  0,  0,  0, 35,  0,  0,  0, 36,  0,  0,  0,
			 37,  0,  0,  0, 38,  0,  0,  0, 39,  0,  0,  0, 40,  0,  0,  0,
			 41,  0,  0,  0, 42,  0,  0,  0, 43,  0,  0,  0, 44,  0,  0,  0,
			 45,  0,  0,  0, 46,  0,  0,  0, 47,  0,  0,  0, 48,  0,  0,  0,
			 49,  0,  0,  0, 50,  0,  0,  0, 51,  0,  0,  0, 52,  0,  0,  0,
			 53,  0,  0,  0, 54,  0,  0,  0, 55,  0,  0,  0, 56,  0,  0,  0,
			 57,  0,  0,  0, 58,  0,  0,  0, 59,  0,  0,  0, 60,  0,  0,  0,
			 61,  0,  0,  0, 62,  0,  0,  0, 63,  0,  0,  0, 64,  0,  0,  0,
			 65,  0,  0,  0, 66,  0,  0,  0, 67,  0,  0,  0, 68,  0,  0,  0,
			 69,  0,  0,  0, 70,  0,  0,  0, 71,  0,  0,  0, 72,  0,  0,  0,
			 73,  0,  0,  0, 74,  0,  0,  0, 75,  0,  0,  0, 76,  0,  0,  0,
			 77,  0,  0,  0, 78,  0,  0,  0, 79,  0,  0,  0, 80,  0,  0,  0,
			 81,  0,  0,  0, 82,  0,  0,  0, 83,  0,  0,  0, 84,  0,  0,  0,
			 85,  0,  0,  0, 86,  0,  0,  0, 87,  0,  0,  0, 88,  0,  0,  0,
			 89,  0,  0,  0, 90,  0,  0,  0, 91,  0,  0,  0, 92,  0,  0,  0,
			 93,  0,  0,  0, 94,  0,  0,  0, 95,  0,  0,  0, 96,  0,  0,  0,
			 97,  0,  0,  0, 98,  0,  0,  0, 99,  0,  0,  0,100,  0,  0,  0,
			101,  0,  0,  0,102,  0,  0,  0,103,  0,  0,  0,104,  0,  0,  0,
			105,  0,  0,  0,106,  0,  0,  0,107,  0,  0,  0,108,  0,  0,  0,
			109,  0,  0,  0,110,  0,  0,  0,111,  0,  0,  0,112,  0,  0,  0,
			113,  0,  0,  0,114,  0,  0,  0,115,  0,  0,  0,116,  0,  0,  0,
			117,  0,  0,  0,118,  0,  0,  0,119,  0,  0,  0,120,  0,  0,  0,
			121,  0,  0,  0,122,  0,  0,  0,123,  0,  0,  0,124,  0,  0,  0,
			125,  0,  0,  0,126,  0,  0,  0,127,  0,  0,  0,128,  0,  0,  0,
			129,  0,  0,  0,130,  0,  0,  0,131,  0,  0,  0,132,  0,  0,  0,
			133,  0,  0,  0,134,  0,  0,  0,135,  0,  0,  0,136,  0,  0,  0,
			137,  0,  0,  0,138,  0,  0,  0,139,  0,  0,  0,140,  0,  0,  0,
			141,  0,  0,  0,142,  0,  0,  0,143,  0,  0,  0,144,  0,  0,  0,
			145,  0,  0,  0,146,  0,  0,  0,147,  0,  0,  0,148,  0,  0,  0,
			149,  0,  0,  0,150,  0,  0,  0,151,  0,  0,  0,152,  0,  0,  0,
			153,  0,  0,  0,154,  0,  0,  0,155,  0,  0,  0,156,  0,  0,  0,
			157,  0,  0,  0,158,  0,  0,  0,159,  0,  0,  0,160,  0,  0,  0,
			161,  0,  0,  0,162,  0,  0,  0,163,  0,  0,  0,164,  0,  0,  0,
			165,  0,  0,  0,166,  0,  0,  0,167,  0,  0,  0,168,  0,  0,  0,
			169,  0,  0,  0,170,  0,  0,  0,171,  0,  0,  0,172,  0,  0,  0,
			173,  0,  0,  0,174,  0,  0,  0,175,  0,  0,  0,176,  0,  0,  0,
			177,  0,  0,  0,178,  0,  0,  0,179,  0,  0,  0,180,  0,  0,  0,
			181,  0,  0,  0,182,  0,  0,  0,183,  0,  0,  0,184,  0,  0,  0,
			185,  0,  0,  0,186,  0,  0,  0,187,  0,  0,  0,188,  0,  0,  0,
			189,  0,  0,  0,190,  0,  0,  0,191,  0,  0,  0,192,  0,  0,  0,
			193,  0,  0,  0,194,  0,  0,  0,195,  0,  0,  0,196,  0,  0,  0,
			197,  0,  0,  0,198,  0,  0,  0,199,  0,  0,  0,200,  0,  0,  0,
			201,  0,  0,  0,202,  0,  0,  0,203,  0,  0,  0,204,  0,  0,  0,
			205,  0,  0,  0,206,  0,  0,  0,207,  0,  0,  0,208,  0,  0,  0,
			209,  0,  0,  0,210,  0,  0,  0,211,  0,  0,  0,212,  0,  0,  0,
			213,  0,  0,  0,214,  0,  0,  0,215,  0,  0,  0,216,  0,  0,  0,
			217,  0,  0,  0,218,  0,  0,  0,219,  0,  0,  0,220,  0,  0,  0,
			221,  0,  0,  0,222,  0,  0,  0,223,  0,  0,  0,224,  0,  0,  0,
			225,  0,  0,  0,226,  0,  0,  0,227,  0,  0,  0,228,  0,  0,  0,
			229,  0,  0,  0,230,  0,  0,  0,231,  0,  0,  0,232,  0,  0,  0,
			233,  0,  0,  0,234,  0,  0,  0,235,  0,  0,  0,236,  0,  0,  0,
			237,  0,  0,  0,238,  0,  0,  0,239,  0,  0,  0,240,  0,  0,  0,
			241,  0,  0,  0,242,  0,  0,  0,243,  0,  0,  0,244,  0,  0,  0,
			245,  0,  0,  0,246,  0,  0,  0,247,  0,  0,  0,248,  0,  0,  0,
			249,  0,  0,  0,250,  0,  0,  0,251,  0,  0,  0,252,  0,  0,  0,
			253,  0,  0,  0,254,  0,  0,  0,255,  0,  0,  0,
			0xff,
			0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
			0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30,
			0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
			0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40,
			0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48,
			0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50,
			0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
			0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x60,
			0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,
			0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70,
			0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
			0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x20, 0x21,
			0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29,
			0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30, 0x31,
			0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39,
			0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40, 0x41,
			0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49,
			0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50, 0x51,
			0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59,
			0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x60, 0x61,
			0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69,
			0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70, 0x71,
			0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79,
			0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x20, 0x21, 0x22,
			0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a,
			0x00,
		0x82, 0x0c, 0x00, 0x7f, 0xf0, 0xf1, 0x00,
			0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2,
		0x8b, 0x35, 0x00, 0x01, 0x0f, 0x33, 0x01, 0x00,
			0xd7, 0xd6, 0xd5, 0xd4, 0xd3, 0xd2, 0xd1, 0xd0,
			0xdf, 0xde, 0xdd, 0xdc, 0xdb, 0xda, 0xd9, 0xd8,
			0xe7, 0xe6, 0xe5, 0xe4, 0xe3, 0xe2, 0xe1, 0xe0,
			0xef, 0xee, 0xed, 0xec, 0xeb, 0xea, 0xe9, 0xe8,
			0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
			0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
		0x8b, 0x35, 0x00, 0x00, 0x0f, 0x30, 0x01, 0x00,
			0xd7, 0xd6, 0xd5, 0xd4, 0xd3, 0xd2, 0xd1, 0xd0,
			0xdf, 0xde, 0xdd, 0xdc, 0xdb, 0xda, 0xd9, 0xd8,
			0xe7, 0xe6, 0xe5, 0xe4, 0xe3, 0xe2, 0xe1, 0xe0,
			0xef, 0xee, 0xed, 0xec, 0xeb, 0xea, 0xe9, 0xe8,
			0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
			0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
		0x8b, 0x35, 0x00, 0xc0, 0x0f, 0x5a, 0x01, 0x00,
			0xd7, 0xd6, 0xd5, 0xd4, 0xd3, 0xd2, 0xd1, 0xd0,
			0xdf, 0xde, 0xdd, 0xdc, 0xdb, 0xda, 0xd9, 0xd8,
			0xe7, 0xe6, 0xe5, 0xe4, 0xe3, 0xe2, 0xe1, 0xe0,
			0xef, 0xee, 0xed, 0xec, 0xeb, 0xea, 0xe9, 0xe8,
			0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
			0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
		0x87, 0x25, 0x00, 0xc0, 0x0f, 0x5a,
			0xef, 0xee, 0xed, 0xec,
			0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
			0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00,
		0x8a, 0x39, 0x00, 0xc0, 0x0f, 0x5a,
			0xdf, 0xde, 0xdd, 0xdc, 0xdb, 0xda, 0xd9, 0xd8,
			0xe7, 0xe6, 0xe5, 0xe4, 0xe3, 0xe2, 0xe1, 0xe0,
			0xef, 0xee, 0xed, 0xec, 0xeb, 0xea, 0xe9, 0xe8,
			0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
			0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00,
		0x88, 0x1b, 0x00, 0xc0, 0x0f, 0x5a,
			0xf7, 0xf6, 0xf9, 0xf8, 0xfb, 0xfa, 0xfd, 0xfc, 0xff, 0xfe,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00,
		0x79, 0x00};

/*
 * ASSERTION 0035: update of 0014
 */
ACPI_STATUS
AtRsrcTest0035(void)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";
    ACPI_BUFFER             OutBuffer = {ACPI_ALLOCATE_BUFFER};

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0035.aml")))
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

    if (ACPI_FAILURE(Status = AtCheckBuffer("\\DEV0._PRS",
            sizeof (Buffer0035), Buffer0035)))
    {
        return (Status);
    }

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiGetPossibleResources (Device, &OutBuffer);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetCurrentResources(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    /* Add the flag to print contents of buffers */
    AcpiDbgLevel |= ACPI_LV_TABLES;

    Status = AcpiSetCurrentResources (Device, &OutBuffer);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiSetCurrentResources(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckBuffer("\\DEV0.ECRS",
            sizeof (Buffer0035), Buffer0035)))
    {
        return (Status);
    }

    AcpiOsFree(OutBuffer.Pointer);

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

typedef struct {
    UINT8           Bytes[1280];
} UINT8ARR;

static	UINT32            BufLen0036[] =  {
         6,  5,  5, 10,    6, 10, 14, 22, 14, 26, 62, 42,
        32, 62, 42, 32, 1229, 17, 58, 58, 58, 42, 62, 32, 2,
        11, 15, 19, 23, 27, 31, 35, 39, 43, 47, 51, 55, 59, 63, 67, 71,
        26,
};

static	UINT8ARR          Buffer0036[] =  {
		{{0x23, 0x01, 0x00, 0x00, 0x79, 0x00}},
		{{0x22, 0x02, 0x00, 0x79, 0x00}},
		{{0x2a, 0x04, 0x02, 0x79, 0x00}},
		{{0x47, 0x01, 0xf1, 0xf0, 0xf3, 0xf2, 0xf4, 0xf5, 0x79, 0x00}},
		{{0x4b, 0xf1, 0xf0, 0xf2, 0x79, 0x00}},
		{{0x77, 0x00, 0xa2, 0xb3, 0x76, 0xd5, 0xe6, 0xf7, 0x79, 0x00}},
		{{0x81, 0x09, 0x00, 0x01, 0xf1, 0xf0, 0xf3, 0xf2, 0xf5, 0xf4, 0xf7, 0xf6, 0x79, 0x00}},
		{{0x85, 0x11, 0x00, 0x01,
			0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
			0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
		{{0x86, 0x09, 0x00, 0x00,
			0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4, 0x79, 0x00}},
		{{0x84, 0x15, 0x00, 0x9f,
			0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
			0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
			0x00, 0x01, 0x02, 0x03, 0x79, 0x00}},
		{{0x8a, 0x39, 0x00, 0x01, 0x0f, 0x33,
			0xdf, 0xde, 0xdd, 0xdc, 0xdb, 0xda, 0xd9, 0xd8,
			0xe7, 0xe6, 0xe5, 0xe4, 0xe3, 0xe2, 0xe1, 0xe0,
			0xef, 0xee, 0xed, 0xec, 0xeb, 0xea, 0xe9, 0xe8,
			0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
			0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00, 0x79, 0x00}},
		{{0x87, 0x25, 0x00, 0x01, 0x0f, 0x33, 0xef, 0xee, 0xed, 0xec,
			0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
			0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00, 0x79, 0x00}},
		{{0x88, 0x1b, 0x00, 0x01, 0x0f, 0x33,
			0xf7, 0xf6, 0xf9, 0xf8, 0xfb, 0xfa, 0xfd, 0xfc, 0xff, 0xfe,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00, 0x79, 0x00}},
		{{0x8a, 0x39, 0x00, 0x00, 0x0f, 0x30,
			0xdf, 0xde, 0xdd, 0xdc, 0xdb, 0xda, 0xd9, 0xd8,
			0xe7, 0xe6, 0xe5, 0xe4, 0xe3, 0xe2, 0xe1, 0xe0,
			0xef, 0xee, 0xed, 0xec, 0xeb, 0xea, 0xe9, 0xe8,
			0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
			0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00, 0x79, 0x00}},
		{{0x87, 0x25, 0x00, 0x00, 0x0f, 0x30,
			0xef, 0xee, 0xed, 0xec,
			0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
			0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00, 0x79, 0x00}},
		{{0x88, 0x1b, 0x00, 0x02, 0x0f, 0x00,
			0xf7, 0xf6, 0xf9, 0xf8, 0xfb, 0xfa, 0xfd, 0xfc, 0xff, 0xfe,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00, 0x79, 0x00}},
		{{0x89, 0xc8, 0x04, 0x0f, 0xff,
			  1,  0,  0,  0,  2,  0,  0,  0,  3,  0,  0,  0,  4,  0,  0,  0,
			  5,  0,  0,  0,  6,  0,  0,  0,  7,  0,  0,  0,  8,  0,  0,  0,
			  9,  0,  0,  0, 10,  0,  0,  0, 11,  0,  0,  0, 12,  0,  0,  0,
			 13,  0,  0,  0, 14,  0,  0,  0, 15,  0,  0,  0, 16,  0,  0,  0,
			 17,  0,  0,  0, 18,  0,  0,  0, 19,  0,  0,  0, 20,  0,  0,  0,
			 21,  0,  0,  0, 22,  0,  0,  0, 23,  0,  0,  0, 24,  0,  0,  0,
			 25,  0,  0,  0, 26,  0,  0,  0, 27,  0,  0,  0, 28,  0,  0,  0,
			 29,  0,  0,  0, 30,  0,  0,  0, 31,  0,  0,  0, 32,  0,  0,  0,
			 33,  0,  0,  0, 34,  0,  0,  0, 35,  0,  0,  0, 36,  0,  0,  0,
			 37,  0,  0,  0, 38,  0,  0,  0, 39,  0,  0,  0, 40,  0,  0,  0,
			 41,  0,  0,  0, 42,  0,  0,  0, 43,  0,  0,  0, 44,  0,  0,  0,
			 45,  0,  0,  0, 46,  0,  0,  0, 47,  0,  0,  0, 48,  0,  0,  0,
			 49,  0,  0,  0, 50,  0,  0,  0, 51,  0,  0,  0, 52,  0,  0,  0,
			 53,  0,  0,  0, 54,  0,  0,  0, 55,  0,  0,  0, 56,  0,  0,  0,
			 57,  0,  0,  0, 58,  0,  0,  0, 59,  0,  0,  0, 60,  0,  0,  0,
			 61,  0,  0,  0, 62,  0,  0,  0, 63,  0,  0,  0, 64,  0,  0,  0,
			 65,  0,  0,  0, 66,  0,  0,  0, 67,  0,  0,  0, 68,  0,  0,  0,
			 69,  0,  0,  0, 70,  0,  0,  0, 71,  0,  0,  0, 72,  0,  0,  0,
			 73,  0,  0,  0, 74,  0,  0,  0, 75,  0,  0,  0, 76,  0,  0,  0,
			 77,  0,  0,  0, 78,  0,  0,  0, 79,  0,  0,  0, 80,  0,  0,  0,
			 81,  0,  0,  0, 82,  0,  0,  0, 83,  0,  0,  0, 84,  0,  0,  0,
			 85,  0,  0,  0, 86,  0,  0,  0, 87,  0,  0,  0, 88,  0,  0,  0,
			 89,  0,  0,  0, 90,  0,  0,  0, 91,  0,  0,  0, 92,  0,  0,  0,
			 93,  0,  0,  0, 94,  0,  0,  0, 95,  0,  0,  0, 96,  0,  0,  0,
			 97,  0,  0,  0, 98,  0,  0,  0, 99,  0,  0,  0,100,  0,  0,  0,
			101,  0,  0,  0,102,  0,  0,  0,103,  0,  0,  0,104,  0,  0,  0,
			105,  0,  0,  0,106,  0,  0,  0,107,  0,  0,  0,108,  0,  0,  0,
			109,  0,  0,  0,110,  0,  0,  0,111,  0,  0,  0,112,  0,  0,  0,
			113,  0,  0,  0,114,  0,  0,  0,115,  0,  0,  0,116,  0,  0,  0,
			117,  0,  0,  0,118,  0,  0,  0,119,  0,  0,  0,120,  0,  0,  0,
			121,  0,  0,  0,122,  0,  0,  0,123,  0,  0,  0,124,  0,  0,  0,
			125,  0,  0,  0,126,  0,  0,  0,127,  0,  0,  0,128,  0,  0,  0,
			129,  0,  0,  0,130,  0,  0,  0,131,  0,  0,  0,132,  0,  0,  0,
			133,  0,  0,  0,134,  0,  0,  0,135,  0,  0,  0,136,  0,  0,  0,
			137,  0,  0,  0,138,  0,  0,  0,139,  0,  0,  0,140,  0,  0,  0,
			141,  0,  0,  0,142,  0,  0,  0,143,  0,  0,  0,144,  0,  0,  0,
			145,  0,  0,  0,146,  0,  0,  0,147,  0,  0,  0,148,  0,  0,  0,
			149,  0,  0,  0,150,  0,  0,  0,151,  0,  0,  0,152,  0,  0,  0,
			153,  0,  0,  0,154,  0,  0,  0,155,  0,  0,  0,156,  0,  0,  0,
			157,  0,  0,  0,158,  0,  0,  0,159,  0,  0,  0,160,  0,  0,  0,
			161,  0,  0,  0,162,  0,  0,  0,163,  0,  0,  0,164,  0,  0,  0,
			165,  0,  0,  0,166,  0,  0,  0,167,  0,  0,  0,168,  0,  0,  0,
			169,  0,  0,  0,170,  0,  0,  0,171,  0,  0,  0,172,  0,  0,  0,
			173,  0,  0,  0,174,  0,  0,  0,175,  0,  0,  0,176,  0,  0,  0,
			177,  0,  0,  0,178,  0,  0,  0,179,  0,  0,  0,180,  0,  0,  0,
			181,  0,  0,  0,182,  0,  0,  0,183,  0,  0,  0,184,  0,  0,  0,
			185,  0,  0,  0,186,  0,  0,  0,187,  0,  0,  0,188,  0,  0,  0,
			189,  0,  0,  0,190,  0,  0,  0,191,  0,  0,  0,192,  0,  0,  0,
			193,  0,  0,  0,194,  0,  0,  0,195,  0,  0,  0,196,  0,  0,  0,
			197,  0,  0,  0,198,  0,  0,  0,199,  0,  0,  0,200,  0,  0,  0,
			201,  0,  0,  0,202,  0,  0,  0,203,  0,  0,  0,204,  0,  0,  0,
			205,  0,  0,  0,206,  0,  0,  0,207,  0,  0,  0,208,  0,  0,  0,
			209,  0,  0,  0,210,  0,  0,  0,211,  0,  0,  0,212,  0,  0,  0,
			213,  0,  0,  0,214,  0,  0,  0,215,  0,  0,  0,216,  0,  0,  0,
			217,  0,  0,  0,218,  0,  0,  0,219,  0,  0,  0,220,  0,  0,  0,
			221,  0,  0,  0,222,  0,  0,  0,223,  0,  0,  0,224,  0,  0,  0,
			225,  0,  0,  0,226,  0,  0,  0,227,  0,  0,  0,228,  0,  0,  0,
			229,  0,  0,  0,230,  0,  0,  0,231,  0,  0,  0,232,  0,  0,  0,
			233,  0,  0,  0,234,  0,  0,  0,235,  0,  0,  0,236,  0,  0,  0,
			237,  0,  0,  0,238,  0,  0,  0,239,  0,  0,  0,240,  0,  0,  0,
			241,  0,  0,  0,242,  0,  0,  0,243,  0,  0,  0,244,  0,  0,  0,
			245,  0,  0,  0,246,  0,  0,  0,247,  0,  0,  0,248,  0,  0,  0,
			249,  0,  0,  0,250,  0,  0,  0,251,  0,  0,  0,252,  0,  0,  0,
			253,  0,  0,  0,254,  0,  0,  0,255,  0,  0,  0,
			0xff,
			0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
			0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30,
			0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
			0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40,
			0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48,
			0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50,
			0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
			0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x60,
			0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,
			0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70,
			0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
			0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x20, 0x21,
			0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29,
			0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30, 0x31,
			0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39,
			0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40, 0x41,
			0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49,
			0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50, 0x51,
			0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59,
			0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x60, 0x61,
			0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69,
			0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70, 0x71,
			0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79,
			0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x20, 0x21, 0x22,
			0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a,
			0x00, 0x79, 0x00}},
		{{0x82, 0x0c, 0x00, 0x7f, 0xf0, 0xf1, 0x00,
			0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0x79, 0x00}},
		{{0x8b, 0x35, 0x00, 0x01, 0x0f, 0x33, 0x01, 0x00,
			0xd7, 0xd6, 0xd5, 0xd4, 0xd3, 0xd2, 0xd1, 0xd0,
			0xdf, 0xde, 0xdd, 0xdc, 0xdb, 0xda, 0xd9, 0xd8,
			0xe7, 0xe6, 0xe5, 0xe4, 0xe3, 0xe2, 0xe1, 0xe0,
			0xef, 0xee, 0xed, 0xec, 0xeb, 0xea, 0xe9, 0xe8,
			0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
			0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8, 0x79, 0x00}},
		{{0x8b, 0x35, 0x00, 0x00, 0x0f, 0x30, 0x01, 0x00,
			0xd7, 0xd6, 0xd5, 0xd4, 0xd3, 0xd2, 0xd1, 0xd0,
			0xdf, 0xde, 0xdd, 0xdc, 0xdb, 0xda, 0xd9, 0xd8,
			0xe7, 0xe6, 0xe5, 0xe4, 0xe3, 0xe2, 0xe1, 0xe0,
			0xef, 0xee, 0xed, 0xec, 0xeb, 0xea, 0xe9, 0xe8,
			0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
			0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8, 0x79, 0x00}},
		{{0x8b, 0x35, 0x00, 0xc0, 0x0f, 0x5a, 0x01, 0x00,
			0xd7, 0xd6, 0xd5, 0xd4, 0xd3, 0xd2, 0xd1, 0xd0,
			0xdf, 0xde, 0xdd, 0xdc, 0xdb, 0xda, 0xd9, 0xd8,
			0xe7, 0xe6, 0xe5, 0xe4, 0xe3, 0xe2, 0xe1, 0xe0,
			0xef, 0xee, 0xed, 0xec, 0xeb, 0xea, 0xe9, 0xe8,
			0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
			0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8, 0x79, 0x00}},
		{{0x87, 0x25, 0x00, 0xc0, 0x0f, 0x5a,
			0xef, 0xee, 0xed, 0xec,
			0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
			0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00, 0x79, 0x00}},
		{{0x8a, 0x39, 0x00, 0xc0, 0x0f, 0x5a,
			0xdf, 0xde, 0xdd, 0xdc, 0xdb, 0xda, 0xd9, 0xd8,
			0xe7, 0xe6, 0xe5, 0xe4, 0xe3, 0xe2, 0xe1, 0xe0,
			0xef, 0xee, 0xed, 0xec, 0xeb, 0xea, 0xe9, 0xe8,
			0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
			0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00, 0x79, 0x00}},
		{{0x88, 0x1b, 0x00, 0xc0, 0x0f, 0x5a,
			0xf7, 0xf6, 0xf9, 0xf8, 0xfb, 0xfa, 0xfd, 0xfc, 0xff, 0xfe,
			0xff, 0x50, 0x41, 0x54, 0x48, 0x50, 0x41, 0x54,
			0x48, 0x50, 0x41, 0x54, 0x48, 0x00, 0x79, 0x00}},
		{{0x79, 0x00}},

	{{0x89, 0x06, 0x00, 0x00, 0x01,
		0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x89, 0x0a, 0x00, 0x08, 0x02,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x89, 0x0e, 0x00, 0x04, 0x03,
		0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x89, 0x12, 0x00, 0x0c, 0x04,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x89, 0x16, 0x00, 0x02, 0x05,
		0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x89, 0x1a, 0x00, 0x0a, 0x06,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x89, 0x1e, 0x00, 0x06, 0x07,
		0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x89, 0x22, 0x00, 0x0e, 0x08,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x89, 0x26, 0x00, 0x01, 0x09,
		0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x89, 0x2a, 0x00, 0x09, 0x0a,
		0xdb, 0xda, 0xd9, 0xd8, 0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x89, 0x2e, 0x00, 0x05, 0x0b,
		0xd7, 0xd6, 0xd5, 0xd4,
		0xdb, 0xda, 0xd9, 0xd8, 0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x89, 0x32, 0x00, 0x0d, 0x0c,
		0xd3, 0xd2, 0xd1, 0xd0, 0xd7, 0xd6, 0xd5, 0xd4,
		0xdb, 0xda, 0xd9, 0xd8, 0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x89, 0x36, 0x00, 0x03, 0x0d,
		0xcf, 0xce, 0xcd, 0xcc,
		0xd3, 0xd2, 0xd1, 0xd0, 0xd7, 0xd6, 0xd5, 0xd4,
		0xdb, 0xda, 0xd9, 0xd8, 0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x89, 0x3a, 0x00, 0x0b, 0x0e,
		0xcb, 0xca, 0xc9, 0xc8, 0xcf, 0xce, 0xcd, 0xcc,
		0xd3, 0xd2, 0xd1, 0xd0, 0xd7, 0xd6, 0xd5, 0xd4,
		0xdb, 0xda, 0xd9, 0xd8, 0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x89, 0x3e, 0x00, 0x07, 0x0f,
		0xc7, 0xc6, 0xc5, 0xc4,
		0xcb, 0xca, 0xc9, 0xc8, 0xcf, 0xce, 0xcd, 0xcc,
		0xd3, 0xd2, 0xd1, 0xd0, 0xd7, 0xd6, 0xd5, 0xd4,
		0xdb, 0xda, 0xd9, 0xd8, 0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x89, 0x42, 0x00, 0x0f, 0x10,
		0xc3, 0xc2, 0xc1, 0xc0, 0xc7, 0xc6, 0xc5, 0xc4,
		0xcb, 0xca, 0xc9, 0xc8, 0xcf, 0xce, 0xcd, 0xcc,
		0xd3, 0xd2, 0xd1, 0xd0, 0xd7, 0xd6, 0xd5, 0xd4,
		0xdb, 0xda, 0xd9, 0xd8, 0xdf, 0xde, 0xdd, 0xdc,
		0xe3, 0xe2, 0xe1, 0xe0, 0xe7, 0xe6, 0xe5, 0xe4,
		0xeb, 0xea, 0xe9, 0xe8, 0xef, 0xee, 0xed, 0xec,
		0xf3, 0xf2, 0xf1, 0xf0, 0xf7, 0xf6, 0xf5, 0xf4,
		0xfb, 0xfa, 0xf9, 0xf8, 0xff, 0xfe, 0xfd, 0xfc, 0x79, 0x00}},
	{{0x31, 0x00, 0x38, 0x31, 0x04, 0x31, 0x08, 0x38, 0x31, 0x01, 0x30,
		0x31, 0x09, 0x38, 0x31, 0x02, 0x38, 0x31, 0x06, 0x38, 0x31, 0x0a, 0x38, 0x79, 0x00}},


};

/*
 * ASSERTION 0036: update of 0035
 */
ACPI_STATUS
AtRsrcTest0036(void)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";
    ACPI_BUFFER             OutBuffer = {ACPI_ALLOCATE_BUFFER};
    UINT32                  i;
    UINT32                  NumChecks;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0036.aml")))
    {
        return (Status);
    }

    NumChecks = sizeof (BufLen0036) / sizeof (UINT32);
    if (NumChecks != (sizeof (Buffer0036) / sizeof (UINT8ARR)))
    {
        TestErrors++;
        printf ("Test error: NumChecks (%d) != sizeof (Buffer0036) /"
            " sizeof (UINT8ARR) (%d)\n",
            NumChecks, (UINT32)(sizeof (Buffer0036) / sizeof (UINT8ARR)));
        return (AE_ERROR);
    }

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /* Add the flag to print contents of buffers */
    AcpiDbgLevel |= ACPI_LV_TABLES;

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    for (i = 0; i < NumChecks; i++)
    {
        printf ("i = %d\n", i);
        OutBuffer.Length = ACPI_ALLOCATE_BUFFER;
        OutBuffer.Pointer = NULL;

        Status = AcpiGetPossibleResources (Device, &OutBuffer);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiGetCurrentResources(%s) returned %s\n",
                Pathname, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiSetCurrentResources (Device, &OutBuffer);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiSetCurrentResources(%s) returned %s\n",
                Pathname, AcpiFormatException(Status));
            return (Status);
        }

        (void)AtCheckBuffer("\\DEV0.ECRS", BufLen0036[i], Buffer0036[i].Bytes);

        AcpiOsFree(OutBuffer.Pointer);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}


/*
 * ASSERTION 0037: reproduces BZ2039
 */

/* from drivers/acpi/pci_link.c */

#define ACPI_PCI_LINK_MAX_POSSIBLE 16

/*
 * If a link is initialized, we never change its active and initialized
 * later even the link is disable. Instead, we just repick the active irq
 */
struct acpi_pci_link_irq {
	UINT8 active;		/* Current IRQ */
	UINT8 triggering;		/* All IRQs */
	UINT8 polarity;	/* All IRQs */
	UINT8 resource_type;
	UINT8 possible_count;
	UINT8 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
	UINT8 initialized;
	UINT8 reserved;
};

struct acpi_pci_link {
//	struct list_head node;
//	struct acpi_device *device;
    ACPI_HANDLE handle;
	struct acpi_pci_link_irq irq;
	int refcnt;
};

static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
{
	int result = 0;
	ACPI_STATUS status = AE_OK;
	struct {
		struct acpi_resource res;
		struct acpi_resource end;
	} resource_obj, *resource = &resource_obj;
	struct acpi_buffer buffer = { 0, NULL };


	if (!link || !irq)
		return (-1);

	memset(resource, 0, sizeof(resource_obj));
	buffer.Length = sizeof(resource_obj);
	buffer.Pointer = resource;

	switch (link->irq.resource_type) {
	case ACPI_RESOURCE_TYPE_IRQ:
		resource->res.Type = ACPI_RESOURCE_TYPE_IRQ;
		resource->res.Length = sizeof(struct acpi_resource);
		resource->res.Data.Irq.Triggering = link->irq.triggering;
		resource->res.Data.Irq.Polarity =
		    link->irq.polarity;
		if (link->irq.triggering == ACPI_EDGE_SENSITIVE)
			resource->res.Data.Irq.Sharable =
			    ACPI_EXCLUSIVE;
		else
			resource->res.Data.Irq.Sharable = ACPI_SHARED;
		resource->res.Data.Irq.InterruptCount = 1;
		resource->res.Data.Irq.Interrupts[0] = (UINT8)irq;
		break;

	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
		resource->res.Type = ACPI_RESOURCE_TYPE_EXTENDED_IRQ;
		resource->res.Length = sizeof(struct acpi_resource);
		resource->res.Data.ExtendedIrq.ProducerConsumer =
		    ACPI_CONSUMER;
		resource->res.Data.ExtendedIrq.Triggering =
		    link->irq.triggering;
		resource->res.Data.ExtendedIrq.Polarity =
		    link->irq.polarity;
		if (link->irq.triggering == ACPI_EDGE_SENSITIVE)
			resource->res.Data.Irq.Sharable =
			    ACPI_EXCLUSIVE;
		else
			resource->res.Data.Irq.Sharable = ACPI_SHARED;
		resource->res.Data.ExtendedIrq.InterruptCount = 1;
		resource->res.Data.ExtendedIrq.Interrupts[0] = (UINT8)irq;
		/* ignore resource_source, it's optional */
		break;
	default:
		printf ("Invalid Resource_type %d\n", link->irq.resource_type);
		result = -2;
		goto end;

	}
	resource->end.Type = ACPI_RESOURCE_TYPE_END_TAG;

	/* Attempt to set the resource */
	status = AcpiSetCurrentResources(link->handle, &buffer);

	/* check for total failure */
	if (ACPI_FAILURE(status)) {
		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _SRS"));
		result = -3;
		goto end;
	}

/*
...
 */
      end:
	return (result);
}

ACPI_STATUS
AtRsrcTest0037(void)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Device;
    ACPI_STRING             Pathname = "\\DEV0";
	struct acpi_pci_link    link;
    int                     irq = 1;
    int                     i, NumErr = 0;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("rt0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    /* Add the flag to print contents of buffers */
    AcpiDbgLevel |= ACPI_LV_TABLES;

/*
    Status =  AtTerminateCtrlCheck(AE_OK, ALL_STAT);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }
*/

    link.handle = Device;
    for (i = 0; i < 8; i++)
    {
        link.irq.resource_type = (UINT8) ((i % 2) ?
            ACPI_RESOURCE_TYPE_EXTENDED_IRQ :
            ACPI_RESOURCE_TYPE_IRQ);

        link.irq.triggering = (UINT8) ((i >> 1) % 2);
        link.irq.polarity = (UINT8) ((i >> 2) % 2);

        if (acpi_pci_link_set(&link, irq))
        {
            NumErr++;
        }
    }

    if (NumErr)
    {
        printf ("acpi_pci_link_set: %d errors\n",
            NumErr);
        return (Status);
    }

    return (AE_OK);
}
