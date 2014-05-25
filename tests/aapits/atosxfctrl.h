/******************************************************************************
 *
 * Module Name: atosxfctrl - include for AcpiOs* interfaces control
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

#ifndef _ATOSXFCTRL
#define _ATOSXFCTRL

#include "acpi.h"
#include "accommon.h"

/*
 * AcpiOs* interfaces enumeration
 */
typedef enum
{
    AcpiOsTotalC,
    AcpiOsInitializeC,
    AcpiOsTerminateC,
    AcpiOsGetRootPointerC,
    AcpiOsPredefinedOverrideC,
    AcpiOsTableOverrideC,
    AcpiOsGetTimerC,
    AcpiOsReadableC,
    AcpiOsWritableC,
    AcpiOsRedirectOutputC,
    AcpiOsPrintfC,
    AcpiOsVprintfC,
    AcpiOsGetLineC,
    AcpiOsMapMemoryC,
    AcpiOsUnmapMemoryC,
    AcpiOsAllocateC,
    AcpiOsFreeC,
    AcpiOsCreateSemaphoreC,
    AcpiOsDeleteSemaphoreC,
    AcpiOsWaitSemaphoreC,
    AcpiOsSignalSemaphoreC,
    AcpiOsCreateLockC,
    AcpiOsDeleteLockC,
    AcpiOsAcquireLockC,
    AcpiOsReleaseLockC,
    AcpiOsInstallInterruptHandlerC,
    AcpiOsRemoveInterruptHandlerC,
    AcpiOsGetThreadIdC,
    AcpiOsExecuteC,
    AcpiOsStallC,
    AcpiOsSleepC,
    AcpiOsValidateInterfaceC,
    AcpiOsValidateAddressC,
    AcpiOsReadPciConfigurationC,
    AcpiOsWritePciConfigurationC,
    AcpiOsDerivePciIdC,
    AcpiOsReadPortC,
    AcpiOsWritePortC,
    AcpiOsReadMemoryC,
    AcpiOsWriteMemoryC,
    AcpiOsSignalC,
    AcpiOsAllC,
} ACPI_OSXF;

#define OSXF_NUM(inds)    (inds##C)

/*
 * Test action codes
 */
typedef enum
{
    AtActUndefined,
    AtActRet_NULL,
    AtActRet_OK,
    AtActRet_ERROR,
    AtActRet_NO_MEMORY,
    AtActAll,
} AT_ACT_CODE;

/*
 * Test action duration flags
 */
typedef enum
{
    AtActD_Permanent,
    AtActD_OneTime,
    AtActD_All,
} AT_ACTD_FLAG;

typedef struct acpi_os_ctrl_act
{
    UINT64                  CallsCount;
    AT_ACTD_FLAG            ActFlag;
    AT_ACT_CODE             ActCode;
    ACPI_OSXF               ActOsxf;
} ACPI_OSXF_CTRL_ACT;

typedef struct acpi_os_control
{
    UINT64                  CallsCount;
    UINT64                  SuccessCount;
    ACPI_OSXF_CTRL_ACT      CtrlAct;
} ACPI_OSXF_CONTROL;

struct acpi_os_emul_reg;

typedef struct acpi_os_emul_reg
{
    UINT32                  Type;
    ACPI_PHYSICAL_ADDRESS   Address;
    UINT32                  Value;
    UINT32                  Width;
    UINT32                  ReadCount;
    UINT32                  WriteCount;
    struct acpi_os_emul_reg *Next;
} ACPI_OSXF_EMUL_REG;

#define EMUL_REG_MODE          1
#define EMUL_STATUS_REG_MODE   1

/*
 * Emulated registers types
 */
#define EMUL_REG_SYS           0x01
#define EMUL_REG_IO            0x02

/*
 * Fixed ACPI h/w emulated registers numbers
 */
typedef enum
{
    AtPm1aStatus,
    AtPm1bStatus,
    AtPm1aEnable,
    AtPm1bEnable,
    AtPm1aControl,
    AtPm1bControl,
    AtPm2Control,
    AtPmTimer,
    AtSmiCmdBlock,
    AtFixeReg_All,
} AT_FIXED_REG_NUM;

#define MAX(a,b)             ((a) < (b))? (b) : (a)
#define MIN(a,b)             ((a) < (b))? (a) : (b)

/*
 * Check IF statistics conditions flags
 */
#define OSINIT_STAT             0x01
#define MALLOC_STAT             0x02
#define MMAP_STAT               0x04
#define SEMAPH_STAT             0x08
#define LOCK_STAT               0x10
#define TOTAL_STAT              0x20
#define FREE_STAT               0x40
#define SUCCESS_STAT            (OSINIT_STAT | MALLOC_STAT | MMAP_STAT|\
    SEMAPH_STAT | LOCK_STAT)
#define ALL_STAT                (SUCCESS_STAT | FREE_STAT)
#define SYS_STAT                (SUCCESS_STAT & ~MMAP_STAT)

extern const char               *OsxfNames[];

#define OSXF_NAME(ind)          OsxfNames[ind]

extern ACPI_OSXF_CONTROL        OsxfCtrl[];

extern UINT32                   OsInitialized;
extern UINT64                   TotalCallsCountMark;
extern UINT64                   FinalCallsCountMark;
extern ACPI_OSXF_CONTROL        Init_OsxfCtrl;


#define AT_CTRL_DECL1(inds) \
    ACPI_STATUS             Status; \
    ACPI_OSXF_CONTROL       *Ctrl = &OsxfCtrl[OSXF_NUM(inds)]

#define AT_CTRL_DECL2(inds) \
    if (!(++OsxfCtrl[AcpiOsTotalC].CallsCount)) \
    { \
        printf("%s error: too many Calls!\n", \
            OSXF_NAME(AcpiOsTotalC)); \
        exit(-1); \
    } \
    if (!(++Ctrl->CallsCount)) \
    { \
        printf("%s error: too many Calls!\n", \
            OSXF_NAME(OSXF_NUM(inds))); \
        exit(-1); \
    }

#define AT_CTRL_DECL3(inds) \
    ACPI_OSXF_CONTROL       *Ctrl = &OsxfCtrl[OSXF_NUM(inds)]

#define AT_CTRL_SUCCESS0(inds) \
    if (!(++Ctrl->SuccessCount)) \
    { \
        printf("%s error: too many Success Calls!\n", \
            OSXF_NAME(OSXF_NUM(inds))); \
        exit(-1); \
    }

#define AT_CTRL_SUCCESS(inds) \
    if (ACPI_SUCCESS(Status) && !(++Ctrl->SuccessCount)) \
    { \
        printf("%s error: too many Success Calls!\n", \
            OSXF_NAME(OSXF_NUM(inds))); \
        exit(-1); \
    }

#define AT_CTRL_DECL(inds) \
    AT_CTRL_DECL1(inds); \
    AT_CTRL_DECL2(inds);

#define AT_CTRL_DECL0(inds) \
    AT_CTRL_DECL3(inds); \
    AT_CTRL_DECL2(inds);

#define AT_ACT_EXIT(inds) \
    printf("Test error: for %s unknown test action %d," \
        " CallsCount %d\n", OSXF_NAME(OSXF_NUM(inds)), \
        Ctrl->CtrlAct.ActCode, (UINT32)Ctrl->CtrlAct.CallsCount); \
    exit(-1)

#define AT_CHCK_RET_STATUS(inds) \
        if (OsxfCtrlRetError(OSXF_NUM(inds))) \
        { \
            return (AE_ERROR); \
        }

#define AT_CHCK_RET_STATUS2(inds) \
    if (OsxfCtrl[AcpiOsTotalC].CtrlAct.CallsCount && \
        OsxfCtrl[AcpiOsTotalC].CallsCount >= \
        OsxfCtrl[AcpiOsTotalC].CtrlAct.CallsCount) \
    { \
        if (OsxfCtrl[AcpiOsTotalC].CtrlAct.ActCode == AtActRet_ERROR) \
        { \
            if (OsxfCtrl[AcpiOsTotalC].CtrlAct.ActFlag == AtActD_OneTime) { \
                OsxfCtrl[AcpiOsTotalC].CtrlAct.CallsCount = 0; \
            } \
            OsxfCtrl[AcpiOsTotalC].CtrlAct.ActOsxf = OSXF_NUM(inds); \
            return (AE_ERROR); \
        } \
        AT_ACT_EXIT(inds); \
    }

#define AT_CHCK_RET_ERROR(inds) \
    if (Ctrl->CtrlAct.CallsCount && \
        Ctrl->CallsCount >= Ctrl->CtrlAct.CallsCount) \
    { \
        if (Ctrl->CtrlAct.ActCode == AtActRet_ERROR) \
        { \
            if (Ctrl->CtrlAct.ActFlag == AtActD_OneTime) \
            { \
                Ctrl->CtrlAct.CallsCount = 0; \
            } \
            Ctrl->CtrlAct.ActOsxf = OSXF_NUM(inds); \
            return (AE_ERROR); \
        } \
        AT_ACT_EXIT(inds); \
    }

#define AT_CHCK_RET_NULL(inds) \
    if (Ctrl->CtrlAct.CallsCount && \
        Ctrl->CallsCount >= Ctrl->CtrlAct.CallsCount) \
    { \
        if (Ctrl->CtrlAct.ActCode == AtActRet_NULL) \
        { \
            if (Ctrl->CtrlAct.ActFlag == AtActD_OneTime) \
            {\
                Ctrl->CtrlAct.CallsCount = 0; \
            } \
            Ctrl->CtrlAct.ActOsxf = OSXF_NUM(inds); \
            return (NULL); \
        } \
        AT_ACT_EXIT(inds); \
    }

#define AT_CHCK_RET_ZERO(inds) \
    if (Ctrl->CtrlAct.CallsCount && \
        Ctrl->CallsCount >= Ctrl->CtrlAct.CallsCount) \
    { \
        if (Ctrl->CtrlAct.ActCode == AtActRet_NULL) \
        { \
            if (Ctrl->CtrlAct.ActFlag == AtActD_OneTime) \
            {\
                Ctrl->CtrlAct.CallsCount = 0; \
            } \
            Ctrl->CtrlAct.ActOsxf = OSXF_NUM(inds); \
            return (0); \
        } \
        AT_ACT_EXIT(inds); \
    }

#define AT_CHCK_RET_NO_MEMORY(inds) \
    if (Ctrl->CtrlAct.CallsCount && \
        Ctrl->CallsCount >= Ctrl->CtrlAct.CallsCount) \
    { \
	    if (Ctrl->CtrlAct.ActCode == AtActRet_NO_MEMORY) \
        { \
            if (Ctrl->CtrlAct.ActFlag == AtActD_OneTime) \
            { \
                Ctrl->CtrlAct.CallsCount = 0; \
            } \
            Ctrl->CtrlAct.ActOsxf = OSXF_NUM(inds); \
            return (AE_NO_MEMORY); \
	    } \
        AT_ACT_EXIT(inds); \
    }

ACPI_STATUS
OsxfCtrlInit(
    void);

ACPI_STATUS
OsxfCtrlSet(
    ACPI_OSXF               OsxfNum,
    UINT64                  CallsCount,
    AT_ACTD_FLAG            ActFlag,
    AT_ACT_CODE             ActCode);

ACPI_OSXF
OsxfCtrlGetActOsxf(
    ACPI_OSXF               OsxfNum,
    UINT32                  Clean);

void
OsxfUpdateCallsMark(void);

UINT64
OsxfGetCallsDiff(void);

ACPI_STATUS
OsxfCtrlPrint(
    void);

ACPI_STATUS
OsxfCtrlCheck(
    UINT32                  CondFlags,
    UINT32                  FreeCond);

ACPI_STATUS
InitOsxfCtrlCheck(
    ACPI_STATUS             Check_Status);

UINT64
OsxfCtrlTotalCalls(
    UINT32                  SuccessCountFlag);

UINT64
OsxfCtrlGetCalls(
    ACPI_OSXF               OsxfNum,
    UINT32                  SuccessCountFlag);

INT64
OsxfCtrlGetDiff(
    UINT32                  OsxfFlags);

ACPI_STATUS
OsxfCtrlSetFixedReg(
    AT_FIXED_REG_NUM       RegNum,
    UINT32                 Value);

ACPI_STATUS
OsxfCtrlSetFixedRegOnes(
    AT_FIXED_REG_NUM       RegNum);

ACPI_STATUS
OsxfCtrlGetFixedReg(
    AT_FIXED_REG_NUM       RegNum,
    UINT32                 *Value);

ACPI_STATUS
OsxfCtrlClearFixedRegs(void);

ACPI_STATUS
OsxfCtrlWriteReg(
    UINT32                  Type,
    ACPI_PHYSICAL_ADDRESS   Address,
    UINT32                  Value,
    UINT32                  Width);

ACPI_STATUS
OsxfCtrlReadReg(
    UINT32                  Type,
    ACPI_PHYSICAL_ADDRESS   Address,
    UINT32                  *Value,
    UINT32                  Width);

ACPI_STATUS
OsxfCtrlAcpiRegsInit(
    ACPI_TABLE_FADT         *FADT,
    ACPI_GENERIC_ADDRESS    XPm1aEnable,
    ACPI_GENERIC_ADDRESS    XPm1bEnable);

void
OsxfCtrlRegService(UINT32 ServiceFlag);

UINT32
OsxfCtrlRetError(
    ACPI_OSXF               OsxfNum);

#endif /* _ATOSXFCTRL */
