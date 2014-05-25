/******************************************************************************
 *
 * Module Name: atcommon - common include for the AcpiCA API validation utility
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

#ifndef _ATCOMMON
#define _ATCOMMON

#include "acpi.h"
#include "accommon.h"
#include "acparser.h"
#include "amlcode.h"
#include "acnamesp.h"
#include "acdebug.h"
#include "actables.h"
#include "acinterp.h"
#include "acapps.h"
#include "acpixf.h"

#ifdef _MSC_VER                 /* disable some level-4 warnings */
#pragma warning(disable:4100)   /* warning C4100: unreferenced formal parameter */
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>

/*
 *  Temporary old definitions from actypes.h insertion.
 */

/*
 * ACPI Table Info. One per ACPI table _type_
 */
typedef struct acpi_table_info
{
    UINT32                          Count;

} ACPI_TABLE_INFO;

typedef ACPI_STATUS  (AT_TEST)(void);

typedef struct BuildTablesTask
{
    UINT32                  NoTableScale;
    UINT32                  ErrScale;
} BLD_TABLES_TASK;

#define BLD_NO_FADT             0x01
#define BLD_NO_FACS             0x02
#define BLD_NO_DSDT             0x04
#define BLD_NO_SSDT1            0x08
#define BLD_NO_SSDT2            0x10
#define BLD_NO_OEM1             0x20
#define BLD_NO_BADT             0x40
#define BLD_NO_TEST             0x80
#define BLD_NO_TABLES           0xFF

#define BAD_SIGNATURE_RSDP      0x0001
#define BAD_SIGNATURE_RSDT      0x0002
#define BAD_SIGNATURE_FADT      0x0004
#define BAD_SIGNATURE_FACS      0x0008
#define BAD_SIGNATURE_DSDT      0x0010
#define BAD_CHECKSUM_RSDP       0x0020
#define BAD_CHECKSUM_RSDT       0x0040
#define BAD_CHECKSUM_FADT       0x0080
#define BAD_CHECKSUM_DSDT       0x0100
#define BAD_LENGTH_HDR_RSDT     0x0200
#define BAD_LENGTH_HDR_FADT     0x0400
#define BAD_LENGTH_HDR_FACS     0x0800
#define BAD_LENGTH_HDR_DSDT     0x1000
#define BAD_LENGTH_DSC_FADT     0x2000
#define BAD_LENGTH_DSC_FACS     0x4000
#define NOT_PRESENT_FADT        0x8000
#define NULL_ADDRESS_FACS       0x10000
#define NULL_ADDRESS_DSDT       0x20000
#define ZERO_SMICMD_FADT        0x40000

#define AT_RSDP_ERR             (BAD_SIGNATURE_RSDP | BAD_CHECKSUM_RSDP)
#define AT_RSDT_ERR             (BAD_SIGNATURE_RSDT | BAD_CHECKSUM_RSDT |\
            BAD_LENGTH_HDR_RSDT)
#define AT_FADT_ERR             (BAD_SIGNATURE_FADT | BAD_CHECKSUM_FADT |\
            BAD_LENGTH_HDR_FADT | BAD_LENGTH_DSC_FADT |\
            NULL_ADDRESS_FACS | NULL_ADDRESS_DSDT)
#define AT_FACS_ERR             (BAD_SIGNATURE_FACS | \
            BAD_LENGTH_HDR_FACS | BAD_LENGTH_DSC_FACS)
#define AT_DSDT_ERR             (BAD_SIGNATURE_DSDT | \
            BAD_CHECKSUM_DSDT | BAD_LENGTH_HDR_DSDT)
#define AT_SSDT_ERR             (0)
#define AT_PSDT_ERR             (0)

void __cdecl
AtSigHandler (
    int                     Sig);

ACPI_STATUS
AtBuildLocalTables (
    ACPI_TABLE_HEADER       *UserTable,
    BLD_TABLES_TASK         ErrTask);

ACPI_STATUS
AtGetTableHeader (
    char                    *Type,
    UINT32                  Instance,
    ACPI_TABLE_HEADER       **Table,
    BLD_TABLES_TASK         BldTask);

void
AtRegionCleanup (void);

ACPI_STATUS
AeInstallHandlers (void);

ACPI_STATUS
AtReadTableFromFile (
    char                    *Filename,
    ACPI_TABLE_HEADER       **Table);

ACPI_STATUS
AtInitializeTables (
    BOOLEAN                 AllowResize);

/*
 * ACPICA API Test execution modes
 */
#define AT_EMULATION_MODE       0
#define AT_KERNEL_MODE          1

#define AT_PATHNAME_MAX         256

/*
 * Known API error condition skipping handling
 * 1 - the check should be skipped to allow
 *     further testing actions enabling
 */

/*
 * If ACPI events is not initialized then
 * the handlers can not be initialized too.
 */
#define AT_SKIP_NO_HANDLER_INIT 1

/*
 * When AcpiGetFirmwareTable is used without AcpiLoadTables
 * MMAP leak is detected.
 */
#define AT_SKIP_MMAP_CHECK      1

/*
 * When AcpiLoadTables is used with invalid Tables
 * MALLOC leak is detected.
 */
#define AT_SKIP_MALLOC_CHECK    1

/*
 * When the FADT header contains invalid length field,
 * AE_NO_ACPI_TABLES is returned instead of AE_BAD_HEADER.
 */
#define AT_SKIP_FADT_BAD_HEADER_CHECK 1

/*
 * Attempt to load RSDP by AcpiLoadTable causes crash of ACPICA.
 * Note: RSDP is ACPI_TABLE_ROOT (neither PRIMARY or SECONDARY)
 */
#define AT_SKIP_RSDP_LOAD_CHECK 1

/*
 * When the type of a searched object is ACPI_TYPE_FIELD_UNIT function
 * AcpiGetNextObject returns AE_NOT_FOUND due to dealing with the local
 * field types.
 */
#define AT_SKIP_ACPI_TYPE_FIELD_UNIT_CHECK 1

/*
 * ACPI_HANDLE RegionHandle parameter of the ACPI_ADR_SPACE_SETUP function
 * is actually an ACPI_OPERAND_OBJECT pointer, but not NS ACPI_HANDLE.
 */
#define AT_SKIP_ADR_SPACE_SETUP_HANDLER_CHECK 1

/*
 * BugId 0003: AcpiGbl_GlobalList and AcpiGbl_NsNodeList
 *             are not being freed on shutdown.
 */
#define AT_SKIP_LIST_FREE_CHECK 0

/*
 * BugId 0005: After shutdown API tests detect one exceeded
 *             call to AcpiOsUnmapMemory OSL routine.
 *             See components\tables\tbrsdt.c(210) error.
 */
#define AT_SKIP_MAPPED_CHECK 0

/*
 * A call to AcpiOsPrintf routine is used before SubSystem
 * was successfully initialized.
 */
#define AT_SKIP_OS_PRINTF_CHECK 1

/*
 * Failures of AcpiOsPredefinedOverride routine is ignored
 * in AcpiNsRootInitialize, do not allow it to fail.
 */
#define AT_SKIP_OS_PRED_OVERRIDE_CTRL 1

/*
 * Failures of AcpiOsSignalSemaphore routine caused the Core to hang.
 */
#define AT_SKIP_OS_SIGNAL_SEM_CTRL 1

/*
 * To allow AtInitTest0010 go to end.
 */
#define AT_SKIP_FREE_STAT_CHECK 1

/*
 * To allow passing the redundant check in the AcpiTbGetTablePtr
 * providing the AtTableTest0039 checks something else.
 */
#define AT_LOAD_DSDT_WORKAROUND 1

/*
 * AcpiNsInitOneDevice fails to pass an appropriate ObjHandle
 * to the User Global Init Handler
 */
#define AT_SKIP_IH_OTYPE_CHECK 1

#define AT_SKIP_ALL_MALLOC_CHECK 0

/*
 * AcpiGetHandle actually allows Pathname without leading slash
 * to be considered as "absolute pathname" when the Parent parameter
 * is NULL.
 */
#define AT_ABS_PATH_WOUT_SLASH 0

/*
 * AcpiWalkNamespace actually passes to the CallBack the NestigLevel value
 * which is relative to the StartObject, not "distance from the root".
 */
#define AT_NESTING_LEVEL_REL 1

/*
 * ACPI_BITREG_WAKE_ENABLE bit-defined Register Id usage should result in
 * AE_BAD_PARAMETER. Now it results in AE_OK.
 */
#define AT_BITREG_WAKE_ENABLE_CHECK 0

/*
 * Now ACPICA preserves reserved bits of the Status Register
 * by writing back read values, should write zeros,
 */
#define AT_SKIP_STATUS_REG_RESBIT_CHECK 1

/*
 * Now ACPICA preserves reserved bits of the Enable Register
 * by writing back read values, should write zeros.
 */
#define AT_SKIP_ENABLE_REG_RESBIT_CHECK 1

/*
 * Now ACPICA returnes actual read values of write-only bits
 * of the Control Register (they are there only) but should
 * return zeros.
 */
#define AT_SKIP_WRITE_ONLY_BITS_CHECK 1

/*
 * AcpiFindRootPointer(NULL) call leads to a crash.
 */
#define AT_SKIP_FIND_ROOT_PPOINTER_CHECK 1

/*
 * Initialization sequence steps
 */
#define AAPITS_INITIALIZE_SS    0x01
#define AAPITS_INSTALL_IH       0x02
#define AAPITS_INITABLES        0x04
#define AAPITS_REALLOCROOTTABLE 0x08
#define AAPITS_LOADTABLES       0x10
#define AAPITS_ENABLE_SS        0x20
#define AAPITS_INITIALIZE_OBJS  0x40
#define AAPITS_INSTALL_HS       0x80
#define AAPITS_INI_PRELOAD      (AAPITS_INITIALIZE_SS |\
            AAPITS_INITABLES | AAPITS_REALLOCROOTTABLE)
#define AAPITS_INI_LOAD         (AAPITS_INI_PRELOAD |\
            AAPITS_LOADTABLES)
#define AAPITS_INI_DEF          (AAPITS_INI_LOAD |\
            AAPITS_ENABLE_SS | AAPITS_INSTALL_HS |\
            AAPITS_INITIALIZE_OBJS)
#define AAPITS_INI_ALL          (AAPITS_INI_DEF | AAPITS_INSTALL_IH)

#define AAPITS_EN_FLAGS         (ACPI_FULL_INITIALIZATION)
#define AAPITS_OI_FLAGS         (0)

ACPI_STATUS
AtSubsystemInit(
    UINT32                  StagesScale,
    UINT32                  EnFlags,
    UINT32                  OiFlags,
    char                    *AMLcodeFileName);

ACPI_STATUS
AtInitCommonTest(
    UINT32                  StagesScale,
    UINT32                  ErrStagesScale,
    UINT32                  ErrExpScale,
    UINT32                  EnFlags,
    UINT32                  OiFlags,
    char                    *AMLcodeFileName);

ACPI_STATUS
AtTerminateCtrlCheck(
    ACPI_STATUS             SuccessStatus,
    UINT32                  CtrlCheck);

ACPI_STATUS
AtAMLcodeFileNameSet(
    char                    *CodeName);

ACPI_STATUS
AtCheckInteger(
    ACPI_HANDLE             ObjHandle,
    ACPI_STRING             Path,
    ACPI_INTEGER            Value);

ACPI_STATUS
AtCheckBytes(
    ACPI_STRING             Name,
    UINT8                   *Pointer,
    UINT8                   *BenchmarkPointer,
    UINT32                  Length);

ACPI_STATUS
AtCheckString(
    ACPI_STRING             Path,
    UINT8                   *Pointer);

ACPI_STATUS
AtCheckBuffer(
    ACPI_STRING             Path,
    UINT32                  Length,
    UINT8                   *Pointer);

ACPI_STATUS
AtCheckName(
    ACPI_HANDLE             ObjHandle,
    ACPI_STRING             CheckName);

void
AtSetAmlControl(
    UINT32                  Index,
    UINT8                   Value);

#ifdef AT_GLOBAL_DATA
const BLD_TABLES_TASK   ZeroBldTask = {0, 0};
#define AT_EXTERN
#else
extern const BLD_TABLES_TASK    ZeroBldTask;
#define AT_EXTERN               extern
#endif

AT_EXTERN int           AapiErrors;
AT_EXTERN int           TestErrors;
AT_EXTERN int           TestSkipped;
AT_EXTERN int           TestPass;
AT_EXTERN char          *AtAMLcodeFileDir;
AT_EXTERN char          *AtAMLcodeFileName;
AT_EXTERN UINT32        AapiTestMode;
AT_EXTERN BLD_TABLES_TASK    NullBldTask;

/*
 * Test result codes
 */
typedef enum
{
    AtRetPass,
    AtRetSkip,
    AtRetTestErr,
    AtRetApiErr,
    AtRetNotImpl,
    AtRetBadParam,
    AtRetSigTerm,
} AT_RET_CODE;

#define AT_ALARM_PERIOD         180 /* 3 minutes */

/*
 * Auxiliary Ssdt Load/Unload
 */
#define AT_LOAD                 0
#define AT_UNLOAD               1

ACPI_STATUS
AtAuxiliarySsdt(
    UINT32                  Action);

#endif /* _ATCOMMON */
