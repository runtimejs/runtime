/******************************************************************************
 *
 * Module Name: atosxfctrl - OSL/oslx tests
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

#include <stdio.h>
#include <string.h>

#include "atosxfctrl.h"

#define _COMPONENT          ACPI_OSXF_SERVICES
        ACPI_MODULE_NAME    ("atosxfctrl")

UINT32                  OsInitialized = 0;

const char              *OsxfNames[] = {
    "AcpiOs Total Calls",
    "AcpiOsInitialize",
    "AcpiOsTerminate",
    "AcpiOsGetRootPointer",
    "AcpiOsPredefinedOverride",
    "AcpiOsTableOverride",
    "AcpiOsGetTimer",
    "AcpiOsReadable",
    "AcpiOsWritable",
    "AcpiOsRedirectOutput",
    "AcpiOsPrintf",
    "AcpiOsVprintf",
    "AcpiOsGetLine",
    "AcpiOsMapMemory",
    "AcpiOsUnmapMemory",
    "AcpiOsAllocate",
    "AcpiOsFree",
    "AcpiOsCreateSemaphore",
    "AcpiOsDeleteSemaphore",
    "AcpiOsWaitSemaphore",
    "AcpiOsSignalSemaphore",
    "AcpiOsCreateLock",
    "AcpiOsDeleteLock",
    "AcpiOsAcquireLock",
    "AcpiOsReleaseLock",
    "AcpiOsInstallInterruptHandler",
    "AcpiOsRemoveInterruptHandler",
    "AcpiOsGetThreadId",
    "AcpiOsQueueForExecution",
    "AcpiOsStall",
    "AcpiOsSleep",
    "AcpiOsReadPciConfiguration",
    "AcpiOsWritePciConfiguration",
    "AcpiOsDerivePciId",
    "AcpiOsReadPort",
    "AcpiOsWritePort",
    "AcpiOsReadMemory",
    "AcpiOsWriteMemory",
    "AcpiOsSignal"};

ACPI_OSXF_CONTROL       OsxfCtrl[AcpiOsAllC];

UINT64                  TotalCallsCountMark = 0; /* the mark in OsxfCtrlCheck() */
UINT64                  FinalCallsCountMark = 0; /* the mark in AcpiOsTerminate() */

ACPI_OSXF_CONTROL       InitOsxfCtrl;

static ACPI_OSXF_EMUL_REG     *RegList;

static ACPI_OSXF_EMUL_REG     *FixedRegs[AtFixeReg_All];

/*
 * Initialize AcpiOS* interfaces test control data.
 *
 */
ACPI_STATUS
OsxfCtrlInit(
    void)
{
    UINT32                  i;

    for (i = 0; i < AcpiOsAllC; i++)
    {
        OsxfCtrl[i].CallsCount = 0;
        OsxfCtrl[i].SuccessCount = 0;
        OsxfCtrl[i].CtrlAct.CallsCount = 0;
    }

    InitOsxfCtrl = OsxfCtrl[OSXF_NUM(AcpiOsInitialize)];

    return (AE_OK);
}

/*
 * Calculate AcpiOS* interfaces calls.
 *
 */
ACPI_STATUS
OsxfCtrlGet(ACPI_OSXF OsxfNum, ACPI_OSXF_CONTROL *Ctrl)
{
    if (OsxfNum < AcpiOsAllC)
    {
        *Ctrl = OsxfCtrl[OsxfNum];
        return (AE_OK);
    }

    return (AE_ERROR);
}

/*
 * Get specified AcpiOS* interface calls.
 *
 */
UINT64
OsxfCtrlGetCalls(
    ACPI_OSXF               OsxfNum,
    UINT32                  SuccessCountFlag)
{
    UINT64                  Count;

    if (SuccessCountFlag)
    {
        Count = OsxfCtrl[OsxfNum].SuccessCount;
    }
    else
    {
        Count = OsxfCtrl[OsxfNum].CallsCount;
    }

    return (Count);
}

/*
 * Calculate AcpiOS* interfaces calls.
 *
 */
UINT64
OsxfCtrlTotalCalls(
    UINT32                  SuccessCountFlag)
{
    UINT64                  Count = 0;
    UINT32                  i;

    if (SuccessCountFlag)
    {
        for (i = AcpiOsInitializeC; i < AcpiOsAllC; i++)
        {
            Count += OsxfCtrl[i].SuccessCount;
        }
    }
    else
    {
        Count = OsxfCtrl[OSXF_NUM(AcpiOsTotal)].CallsCount;
    }

    return (Count);
}

/*
 * Set test action data for the specified AcpiOS* interface.
 *
 */
ACPI_STATUS
OsxfCtrlSet(
    ACPI_OSXF               OsxfNum,
    UINT64                  CallsCount,
    AT_ACTD_FLAG            ActFlag,
    AT_ACT_CODE             ActCode)
{
    ACPI_OSXF_CONTROL       *Ctrl = &OsxfCtrl[OsxfNum];

    if (CallsCount > 0 && ActCode < AtActAll &&
            AtActUndefined < ActCode)
    {
        if (Ctrl->CtrlAct.ActFlag != AtActD_Permanent &&
                Ctrl->CtrlAct.CallsCount != 0)
        {
            printf("OsxfCtrlSet(%s): test error, there is waiting"
                " action for CallsCount %d, ActFlag %d, ActCode %d\n",
                OSXF_NAME(OsxfNum), (UINT32)Ctrl->CtrlAct.CallsCount,
                Ctrl->CtrlAct.ActFlag, Ctrl->CtrlAct.ActCode);
            return (AE_ERROR);
        }
    }
    else
    {
        printf("OsxfCtrlSet(%s): test interface error, should be"
            " CallsCount(%d) > 0 && %d < ActCode(%d) < %d\n",
            OSXF_NAME(OsxfNum),
            (UINT32)CallsCount, ActCode, AtActUndefined, AtActAll);
        return (AE_ERROR);
    }

    Ctrl->CtrlAct.CallsCount = Ctrl->CallsCount + CallsCount;
    Ctrl->CtrlAct.ActFlag = ActFlag;
    Ctrl->CtrlAct.ActCode = ActCode;
    Ctrl->CtrlAct.ActOsxf = 0;

    return (AE_OK);
}

/*
 * Get the number of AcpiOS* interface which CHCK_RET_STATUS
 * condition taked place in. Optionally clean the control data.
 *
 */
ACPI_OSXF
OsxfCtrlGetActOsxf(
    ACPI_OSXF               OsxfNum,
    UINT32                  Clean)
{
    ACPI_OSXF               ActOsxf = OsxfCtrl[OsxfNum].CtrlAct.ActOsxf;

    if (Clean)
    {
        OsxfCtrl[OsxfNum].CtrlAct.CallsCount = 0;
    }
    return (ActOsxf);
}

/*
 * Update FinalCallsCountMark
 *
 */
void
OsxfUpdateCallsMark(void)
{
    FinalCallsCountMark = OsxfCtrlTotalCalls(0);
}

/*
 * Get the number of overall AcpiOs* calls since the last mark
 *
 */
UINT64
OsxfGetCallsDiff(void)
{
     return (OsxfCtrlTotalCalls(0) - FinalCallsCountMark);
}

/*
 * Check specified conditions on AcpiOsInitialize test control data.
 *
 */
ACPI_STATUS
InitOsxfCtrlCheck(
    ACPI_STATUS             Check_Status)
{
    ACPI_OSXF_CONTROL       Ctrl = InitOsxfCtrl;

    InitOsxfCtrl = OsxfCtrl[OSXF_NUM(AcpiOsInitialize)];

    if ((InitOsxfCtrl.CallsCount != Ctrl.CallsCount + 1) ||
        (InitOsxfCtrl.SuccessCount != Ctrl.SuccessCount +
            (Check_Status == AE_OK)))
    {
        printf("API error: invalid AcpiOsInitialize call conditions"
            " on Status %s\n", AcpiFormatException(Check_Status));
        return (AE_ERROR);
    }
    return (AE_OK);
}

/*
 * Get specified differencies on AcpiOS* allocation/releasing interfaces calls.
 *
 */
INT64
OsxfCtrlGetDiff(
    UINT32                  OsxfFlags)
{
    INT64                   Diff64 = -1;
    UINT32                  OsxfNum0, OsxfNum1;
    UINT64                  NewTotalCallsCount;

    if (OsxfFlags & TOTAL_STAT)
    {
        NewTotalCallsCount = OsxfCtrlTotalCalls(0);
        Diff64 = NewTotalCallsCount - TotalCallsCountMark;
        TotalCallsCountMark = NewTotalCallsCount;
    }
    else
    {
        switch (OsxfFlags)
        {
        case OSINIT_STAT:
            OsxfNum0 = OSXF_NUM(AcpiOsInitialize);
            OsxfNum1 = OSXF_NUM(AcpiOsTerminate);
            break;
        case MALLOC_STAT:
            OsxfNum0 = OSXF_NUM(AcpiOsAllocate);
            OsxfNum1 = OSXF_NUM(AcpiOsFree);
            break;
        case MMAP_STAT:
            OsxfNum0 = OSXF_NUM(AcpiOsMapMemory);
            OsxfNum1 = OSXF_NUM(AcpiOsUnmapMemory);
            break;
        case SEMAPH_STAT:
            OsxfNum0 = OSXF_NUM(AcpiOsCreateSemaphore);
            OsxfNum1 = OSXF_NUM(AcpiOsDeleteSemaphore);
            break;
        case LOCK_STAT:
            OsxfNum0 = OSXF_NUM(AcpiOsCreateLock);
            OsxfNum1 = OSXF_NUM(AcpiOsDeleteLock);
            break;
        default:
            OsxfNum0 = OSXF_NUM(AcpiOsTotal);
            OsxfNum1 = OSXF_NUM(AcpiOsTotal);
            break;
        }

        Diff64 = OsxfCtrl[OsxfNum0].SuccessCount - OsxfCtrl[OsxfNum1].SuccessCount;
    }

    return (Diff64);
}

const char              *stat_msg[] = {
    "OSINIT_STAT",
    "MALLOC_STAT",
    "MMAP_STAT",
    "SEMAPH_STAT",
    "LOCK_STAT"};

/*
 * Check specified conditions on AcpiOS* interfaces test control data.
 *
 */
ACPI_STATUS
OsxfCtrlCheck(
    UINT32                  CondFlags,
    UINT32                  FreeCond)
{
    INT64                   Diff64;
    UINT32                  i;
    UINT32                  Diff_Flags = 0;
    UINT32                  Free_Flag = 0;
    UINT32                  OsxfNum1;

    if (CondFlags & FREE_STAT)
    {
        CondFlags &= ~FREE_STAT;
        Free_Flag = 1;
    }

    if (CondFlags & TOTAL_STAT)
    {
        CondFlags &= ~TOTAL_STAT;

        Diff64 = OsxfCtrlGetDiff(TOTAL_STAT);

        if (Diff64 < 0)
        {
            printf("Test error: invalid CallsCount calculation\n");
            return (AE_ERROR);
        }

        if ((Diff64 == 0 && (FreeCond == 0)) ||
                (Diff64 > 0 && (FreeCond != 0)))
        {
            printf("API error: contradictory %d AcpiOS* invocations"
                " on FreeCond %d\n", (UINT32)Diff64, FreeCond);
            return (AE_ERROR);
        }
    }

    if ((ALL_STAT & CondFlags) != CondFlags)
    {
        printf("Test error: unexpected CondFlags 0x%x\n",
            ~ALL_STAT & CondFlags);
        return (AE_ERROR);
    }
    if (!CondFlags)
    {
        return (AE_OK);
    }
    for (i = 0; i < 5; i++)
    {
        if (CondFlags & (1 << i))
        {
            Diff64 = OsxfCtrlGetDiff(1 << i);

            if (Diff64 < 0)
            {
                printf("%s API error: there were invalid"
                    " freeings, Diff = %d\n", stat_msg[i], (UINT32)Diff64);
                return (AE_ERROR);
            }

            if ((FreeCond == 0 && Diff64 == 0) ||
                    (FreeCond != 0 && Diff64 != 0))
            {
                Diff_Flags |= (1 << i);
            }
            if (Free_Flag)
            {
                switch (1 << i)
                {
                case OSINIT_STAT:
                    OsxfNum1 = OSXF_NUM(AcpiOsTerminate);
                    break;
                case MALLOC_STAT:
                    OsxfNum1 = OSXF_NUM(AcpiOsFree);
                    break;
                case MMAP_STAT:
                    OsxfNum1 = OSXF_NUM(AcpiOsUnmapMemory);
                    break;
                case SEMAPH_STAT:
                    OsxfNum1 = OSXF_NUM(AcpiOsDeleteSemaphore);
                    break;
                case LOCK_STAT:
                    OsxfNum1 = OSXF_NUM(AcpiOsDeleteLock);
                    break;
                default:
                    OsxfNum1 = OSXF_NUM(AcpiOsTotal);
                    break;
                }

                /* Check that all resource releasings resulted in success */
                Diff64 = OsxfCtrl[OsxfNum1].CallsCount - OsxfCtrl[OsxfNum1].SuccessCount;
                if (Diff64)
                {
                    printf("%s API error: there were unexpected"
                        " freeings, Diff = %d\n", stat_msg[i], (UINT32)Diff64);
                    return (AE_ERROR);
                }
            }
        }
    }
    if ((FreeCond == 0 && Diff_Flags == CondFlags) ||
            (FreeCond != 0 && Diff_Flags != 0))
    {
        printf("API error: unexpected free conditions,"
            " FreeCond %d, Diff_Flags = 0x%.2x\n", FreeCond, Diff_Flags);
        return (AE_ERROR);
    }

    return (AE_OK);
}

/*
 * Print AcpiOS* interfaces test control data.
 *
 */
ACPI_STATUS
OsxfCtrlPrint(
    void)
{
    UINT32                  i;
    UINT32                  Name_Len;
#define ALIGN_COLUMN        32
    char                    Align[ALIGN_COLUMN + 1];
    const char              *OsxfName;

    OsxfCtrl[AcpiOsTotalC].SuccessCount = OsxfCtrlTotalCalls(1);

    printf("OsxfCtrl data (%d IF total)):\n", AcpiOsAllC);
    for (i = 0; i < AcpiOsAllC; i++)
    {
        if (OsxfCtrl[i].CallsCount)
        {
            memset(Align, ' ', 32);
            OsxfName = OSXF_NAME(i);
            if ((Name_Len = strlen(OsxfName)) > ALIGN_COLUMN)
            {
                Align[0] = 0;
            }
            else
            {
                Align[ALIGN_COLUMN - Name_Len] = 0;
            }
            printf("%s%s%6.1d", OSXF_NAME(i), Align,
                (UINT32)OsxfCtrl[i].CallsCount);
            if (OsxfCtrl[i].CallsCount != OsxfCtrl[i].SuccessCount)
            {
                printf(": %6.1d", (UINT32)OsxfCtrl[i].SuccessCount);
            }
            printf("\n");
        }
    }

    return (AE_OK);
}

/*
 * Direct setting to the emulated register.
 *
 */
ACPI_STATUS
OsxfCtrlSetReg(
    ACPI_OSXF_EMUL_REG     *Reg,
    UINT32                  Value)
{
    UINT32                 MaxValue;

    if (!Reg)
    {
        return (AE_ERROR);
    }

    MaxValue = (UINT32)((((1 << (Reg->Width - 1)) - 1) << 1) + 1);

    if (Value > MaxValue)
    {
        return (AE_ERROR);
    }

    Reg->Value = Value;

    return (AE_OK);
}

/*
 * Get the contents of the emulated register.
 *
 */
ACPI_STATUS
OsxfCtrlGetReg(
    ACPI_OSXF_EMUL_REG      *Reg,
    UINT32                  *Value)
{
    if (!Reg)
    {
        return (AE_ERROR);
    }

    *Value = Reg->Value;

    return (AE_OK);
}

/*
 * Auxiliary an emulated register setting to Ones
 *
 */
void
OsxfCtrlSetRegOnes(ACPI_OSXF_EMUL_REG *Reg)
{
    Reg->Value = (UINT32)((((1 << (Reg->Width - 1)) - 1) << 1) + 1);
}

/*
 * Set Fixed ACPI h/w register
 *
 */
ACPI_STATUS
OsxfCtrlSetFixedReg(
    AT_FIXED_REG_NUM       RegNum,
    UINT32                 Value)
{
    if (RegNum >= AtFixeReg_All)
    {
        return (AE_ERROR);
    }

    return (OsxfCtrlSetReg(FixedRegs[RegNum], Value));
}

/*
 * Set Fixed ACPI h/w register
 *
 */
ACPI_STATUS
OsxfCtrlSetFixedRegOnes(
    AT_FIXED_REG_NUM       RegNum)
{
    if (RegNum >= AtFixeReg_All)
    {
        return (AE_ERROR);
    }

    OsxfCtrlSetRegOnes(FixedRegs[RegNum]);

    return (AE_OK);
}

/*
 * Get Fixed ACPI h/w register
 *
 */
ACPI_STATUS
OsxfCtrlGetFixedReg(
    AT_FIXED_REG_NUM       RegNum,
    UINT32                 *Value)
{
    if (RegNum >= AtFixeReg_All)
    {
        return (AE_ERROR);
    }

    return (OsxfCtrlGetReg(FixedRegs[RegNum], Value));
}

/*
 * Clear Fixed ACPI h/w registers
 *
 */
ACPI_STATUS
OsxfCtrlClearFixedRegs(void)
{
    ACPI_STATUS            Status = AE_OK;
    AT_FIXED_REG_NUM       RegNum;

    for (RegNum = 0; RegNum < AtFixeReg_All; RegNum++)
    {
        Status = OsxfCtrlSetReg(FixedRegs[RegNum], 0);
        if (Status != AE_OK)
        {
            break;
        }
    }
    return (Status);
}

/*
 * Search for installed emulated registers.
 *
 */
ACPI_OSXF_EMUL_REG
*OsxfCtrlFingReg(
    UINT32                  Type,
    ACPI_PHYSICAL_ADDRESS   Address,
    UINT32                  Width,
    UINT32                  CreateFlag)
{
    ACPI_OSXF_EMUL_REG     *Reg = RegList;
    ACPI_PHYSICAL_ADDRESS    Max, Min;

    if (Width == 0 || Width > 32)
    {
#if ACPI_MACHINE_WIDTH == 64
#ifdef    _MSC_VER
        printf("OsxfCtrlFingReg: unexpected Width %d of Reg 0x%I64x\n",
#else
        printf("OsxfCtrlFingReg: unexpected Width %d of Reg 0x%llx\n",
#endif
#else
        printf("OsxfCtrlFingReg: unexpected Width %d of Reg 0x%x\n",
#endif
            Width, Address);
        return (NULL);
    }

    while (Reg)
    {
        Max = MAX(Reg->Address, Address);
        Min = MIN(Reg->Address + ACPI_ROUND_BITS_UP_TO_BYTES(Reg->Width),
            Address + ACPI_ROUND_BITS_UP_TO_BYTES(Width));
        if (Reg->Type == Type)
        {
            if (Reg->Address == Address && Reg->Width == Width)
            {
                return (Reg);
            }
            else if (Max < Min)
            {
#if ACPI_MACHINE_WIDTH == 64
#ifdef    _MSC_VER
                printf("OsxfCtrlFingReg: intersection Regs (0x%I64x: 0x%x)"
                    " and (0x%I64x: 0x%x)\n",
#else
                printf("OsxfCtrlFingReg: intersection Regs (0x%llx: 0x%x)"
                    " and (0x%llx: 0x%x)\n",
#endif
#else
                printf("OsxfCtrlFingReg: intersection Regs (0x%x: 0x%x)"
                    " and (0x%x: 0x%x)\n",
#endif
                    Reg->Address, Reg->Width, Address, Width);
                return (NULL);
            }
        }
        Reg = Reg->Next;
    }
    if (CreateFlag)
    {
        Reg = (ACPI_OSXF_EMUL_REG *) malloc(sizeof (ACPI_OSXF_EMUL_REG));
        if (!Reg)
        {
#if ACPI_MACHINE_WIDTH == 64
#ifdef    _MSC_VER
            printf("OsxfCtrlFingReg: no memory for Reg (0x%I64x: 0x%x)\n",
#else
            printf("OsxfCtrlFingReg: no memory for Reg (0x%llx: 0x%x)\n",
#endif
#else
            printf("OsxfCtrlFingReg: no memory for Reg (0x%x: 0x%x)\n",
#endif
                Reg->Address, Reg->Width);
            return (NULL);
        }
        Reg->Type = Type;
        Reg->Address = Address;
        Reg->Width = Width;
        OsxfCtrlSetRegOnes(Reg);
        Reg->ReadCount = 0;
        Reg->WriteCount = 0;
        Reg->Next = RegList;
        RegList = Reg;
    }

    return (Reg);
}

/*
 * Write to the emulated register.
 * A bit in the fixed ACPI h/w Status registers are
 * cleared if the respective written bit is set to 1.
 *
 */
ACPI_STATUS
OsxfCtrlWriteReg(
    UINT32                  Type,
    ACPI_PHYSICAL_ADDRESS   Address,
    UINT32                  Value,
    UINT32                  Width)
{
    ACPI_STATUS            Status;
    ACPI_OSXF_EMUL_REG     *Reg = OsxfCtrlFingReg(Type, Address, Width, 1);

    if (EMUL_STATUS_REG_MODE &&
        (Reg == FixedRegs[AtPm1aStatus] || Reg == FixedRegs[AtPm1bStatus]))
    {
        /* Clear bits being set to 1 */
        Value = Reg->Value & ~Value;
    }
    Status = OsxfCtrlSetReg(Reg, (UINT32) Value);
    if (Status == AE_OK)
    {
        Reg->WriteCount++;
    }
    return (Status);
}

/*
 * Read out of the emulated register.
 *
 */
ACPI_STATUS
OsxfCtrlReadReg(
    UINT32                  Type,
    ACPI_PHYSICAL_ADDRESS   Address,
    UINT32                  *Value,
    UINT32                  Width)
{
    ACPI_STATUS            Status;
    ACPI_OSXF_EMUL_REG     *Reg = OsxfCtrlFingReg(Type, Address, Width, 1);

    Status = OsxfCtrlGetReg(Reg, Value);
    if (Status == AE_OK)
    {
        Reg->ReadCount++;
    }
    return (Status);
}

/*
 * Initialize ACPI h/w registers
 *
 */
ACPI_STATUS
OsxfCtrlAcpiRegsInit(
    ACPI_TABLE_FADT         *FADT,
    ACPI_GENERIC_ADDRESS    XPm1aEnable,
    ACPI_GENERIC_ADDRESS    XPm1bEnable)
{
    ACPI_OSXF_EMUL_REG     *Reg;
#define INIT_REG(Ind, Adr, Size)\
    if (!(Reg = OsxfCtrlFingReg(EMUL_REG_IO,\
        (ACPI_PHYSICAL_ADDRESS)Adr, Size, 1)))\
    {\
        return (AE_ERROR);\
    }\
    FixedRegs[Ind] = Reg

    /* ACPI_REGISTER_PM1_STATUS, 16-bit access */
    INIT_REG(AtPm1aStatus, FADT->XPm1aEventBlock.Address, 16);
    INIT_REG(AtPm1bStatus, FADT->XPm1bEventBlock.Address, 16);

    /* ACPI_REGISTER_PM1_ENABLE, 16-bit access */
    INIT_REG(AtPm1aEnable, XPm1aEnable.Address, 16);
    INIT_REG(AtPm1bEnable, XPm1bEnable.Address, 16);

    /* ACPI_REGISTER_PM1_CONTROL, 16-bit access */
    INIT_REG(AtPm1aControl, FADT->XPm1aControlBlock.Address, 16);
    INIT_REG(AtPm1bControl, FADT->XPm1bControlBlock.Address, 16);

    /* ACPI_REGISTER_PM2_CONTROL, 8-bit access */
    INIT_REG(AtPm2Control, FADT->XPm2ControlBlock.Address, 8);

    /* ACPI_REGISTER_PM_TIMER, 32-bit access */
    INIT_REG(AtPmTimer, FADT->XPmTimerBlock.Address, 32);

    /* ACPI_REGISTER_SMI_COMMAND_BLOCK, 8-bit access */
    INIT_REG(AtSmiCmdBlock, FADT->SmiCommand, 8);

    return (AE_OK);
}

/*
 * Emulated registers service.
 *
 */
void
OsxfCtrlRegService(UINT32 ServiceFlag)
{
    ACPI_OSXF_EMUL_REG     *Reg = RegList;
    UINT32                   i = 0;

    while (Reg)
    {
        if (ServiceFlag == 0)
        {
            /* Release memory */
            RegList = Reg->Next;
            free(Reg);
            Reg = RegList;
        }
        else if (ServiceFlag == 1)
        {
            /* Print registers summary */
            if (i == 0)
            {
                printf("OsxfCtrlRegService: registers summary\n");
            }
#if ACPI_MACHINE_WIDTH == 64
#ifdef    _MSC_VER
            printf("%.2u (%s Address 0x%I64x: Width %.2u) r/w counts: %u/%u\n",
#else
            printf("%.2u (%s Address 0x%llx: Width %.2u) r/w counts: %u/%u\n",
#endif
#else
            printf("%.2u (%s Address 0x%.4x: Width %.2u) r/w counts: %u/%u\n",
#endif
                i, (Reg->Type == EMUL_REG_SYS)? "SYS": "IO",
                Reg->Address, Reg->Width, Reg->ReadCount, Reg->WriteCount);
            Reg = Reg->Next;
            i++;
        }
    }
}

UINT32
OsxfCtrlRetError(
    ACPI_OSXF               OsxfNum)
{
    if (OsxfCtrl[AcpiOsTotalC].CtrlAct.CallsCount &&
        OsxfCtrl[AcpiOsTotalC].CallsCount >=
        OsxfCtrl[AcpiOsTotalC].CtrlAct.CallsCount)
    {
        if (OsxfCtrl[AcpiOsTotalC].CtrlAct.ActCode == AtActRet_ERROR)
        {
            if (OsxfCtrl[AcpiOsTotalC].CtrlAct.ActFlag == AtActD_OneTime)
            {
                OsxfCtrl[AcpiOsTotalC].CtrlAct.CallsCount = 0;
            }
            OsxfCtrl[AcpiOsTotalC].CtrlAct.ActOsxf = OsxfNum;
            printf("OsxfCtrlRetError: ret AE_ERROR from %s\n",
                OSXF_NAME(OsxfNum));
            return (1);
        }
        printf("Test error: for %s specified unknown test action %d,"
            " Calls %d\n", OSXF_NAME(OsxfNum),
            OsxfCtrl[AcpiOsTotalC].CtrlAct.ActCode,
            (UINT32)OsxfCtrl[AcpiOsTotalC].CtrlAct.CallsCount);
        exit(-1);
    }
    return (0);
}
