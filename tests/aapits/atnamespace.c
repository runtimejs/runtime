/******************************************************************************
 *
 * Module Name: atnamespace - ACPICA Namespace Access API tests
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
#include "atnamespace.h"
#include "atosxfctrl.h"

#define _COMPONENT          ACPI_TOOLS
        ACPI_MODULE_NAME    ("atnamespace")

static ACPI_STRING      Level0TypeNames0000[] = {
    "\\_REV",
    "\\_REV",
    "\\STR0",
    "\\BUF0",
    "\\PAC0",
    "\\FLU0",
    "\\DEV0",
    "\\EVE0",
    "\\MMM0",
    "\\MTX0",
    "\\OPR0",
    "\\PWR0",
    "\\CPU0",
    "\\TZN0",
    "\\BFL0",
};

static ACPI_STRING      Level1TypeNames0000[] = {
    "\\D1L0.INT0",
    "\\D1L0.INT0",
    "\\D1L0.STR0",
    "\\D1L0.BUF0",
    "\\D1L0.PAC0",
    "\\D1L0.FLU0",
    "\\D1L0.DEV0",
    "\\D1L0.EVE0",
    "\\D1L0.MMM0",
    "\\D1L0.MTX0",
    "\\D1L0.OPR0",
    "\\D1L0.PWR0",
    "\\D1L0.CPU0",
    "\\D1L0.TZN0",
    "\\D1L0.BFL0",
};

static ACPI_STRING      LevelATypeNames0000[] = {
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.INT0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.INT0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.STR0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.BUF0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.PAC0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.FLU0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.EVE0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.MMM0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.MTX0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.OPR0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.PWR0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.CPU0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.TZN0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.BFL0",
};

static ACPI_STRING      LevelAType1Names0000[] = {
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.INT1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.INT1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.STR1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.BUF1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.PAC1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.FLU1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.EVE1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.MMM1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.MTX1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.OPR1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.PWR1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.CPU1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.TZN1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.BFL1",
};

static ACPI_STRING      LevelAType2Names0000[] = {
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.INT2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.INT2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.STR2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.BUF2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.PAC2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.FLU2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.EVE2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.MMM2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.MTX2",
    NULL,
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.PWR2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.CPU2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.TZN2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.BFL2",
};

static ACPI_STRING      LevelAType3Names0000[] = {
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.INT3",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.INT3",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.STR3",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.BUF3",
    NULL,
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.FLU3",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV3",
    NULL,
    NULL,
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.MTX3",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.OPR0",
    NULL,
    NULL,
    NULL,
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.BFL3",
};

static ACPI_STRING      LevelAType4Names0000[] = {
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.INT4",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.INT4",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.STR4",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.BUF4",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.PAC0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.FLU4",
    NULL,
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.EVE0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.MMM0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.MTX4",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.OPR1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.PWR0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.CPU0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.TZN0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.BFL4",
};


static ACPI_STRING      LevelATypeLastNames0000[] = {
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.INT9",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.INT9",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.STR8",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.BUF7",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.PAC2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.FLU5",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV3",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.EVE2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.MMM2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.MTX4",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.OPR1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.PWR2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.CPU2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.TZN2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.BFL5",
};

static ACPI_STRING      *LevelATypeNamesArray0000[] = {
    LevelATypeNames0000,
    LevelAType1Names0000,
    LevelAType2Names0000,
    LevelAType3Names0000,
    LevelAType4Names0000,
};

static ACPI_OBJECT_TYPE      LevelTypes0000[] = {
    ACPI_TYPE_ANY,
    ACPI_TYPE_INTEGER,
    ACPI_TYPE_STRING,
    ACPI_TYPE_BUFFER,
    ACPI_TYPE_PACKAGE,
    ACPI_TYPE_FIELD_UNIT,
    ACPI_TYPE_DEVICE,
    ACPI_TYPE_EVENT,
    ACPI_TYPE_METHOD,
    ACPI_TYPE_MUTEX,
    ACPI_TYPE_REGION,
    ACPI_TYPE_POWER,
    ACPI_TYPE_PROCESSOR,
    ACPI_TYPE_THERMAL,
    ACPI_TYPE_BUFFER_FIELD,
};

static ACPI_STRING      EvPathNames0000[] = {
    "\\", "INT0",
    "\\", "STR0",
    "\\", "BUF0",
    "\\", "PAC0",
    "\\", "FLU0",
    "\\", "MMM0",
    "\\", "PWR0",
    "\\", "CPU0",
    "\\", "BFL0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "INT0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "STR0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "BUF0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "PAC0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "FLU0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "MMM0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "PWR0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "CPU0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "BFL0",
};

static ACPI_OBJECT_TYPE      TypesEvPathNames0000[] = {
    ACPI_TYPE_INTEGER,
    ACPI_TYPE_STRING,
    ACPI_TYPE_BUFFER,
    ACPI_TYPE_PACKAGE,
    ACPI_TYPE_LOCAL_REGION_FIELD /* ACPI_TYPE_FIELD_UNIT */,
    ACPI_TYPE_METHOD,
    ACPI_TYPE_POWER,
    ACPI_TYPE_PROCESSOR,
    ACPI_TYPE_BUFFER_FIELD,
    ACPI_TYPE_INTEGER,
    ACPI_TYPE_STRING,
    ACPI_TYPE_BUFFER,
    ACPI_TYPE_PACKAGE,
    ACPI_TYPE_LOCAL_REGION_FIELD /* ACPI_TYPE_FIELD_UNIT */,
    ACPI_TYPE_METHOD,
    ACPI_TYPE_POWER,
    ACPI_TYPE_PROCESSOR,
    ACPI_TYPE_BUFFER_FIELD,
};

static ACPI_STRING      AeTypePathNames0000[] = {
    "\\", "DEV0",
    "\\", "EVE0",
    "\\", "MTX0",
    "\\", "OPR0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "DEV0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "EVE0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "MTX0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "OPR0",
};

static ACPI_OBJECT_TYPE      TypesAeTypePathNames0000[] = {
    ACPI_TYPE_DEVICE,
    ACPI_TYPE_EVENT,
    ACPI_TYPE_MUTEX,
    ACPI_TYPE_REGION,
    ACPI_TYPE_DEVICE,
    ACPI_TYPE_EVENT,
    ACPI_TYPE_MUTEX,
    ACPI_TYPE_REGION,
};

static ACPI_STRING      TermalPathNames0000[] = {
    "\\", "TZN0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "TZN0",
};

static ACPI_OBJECT_TYPE      TypesTermalPathNames0000[] = {
    ACPI_TYPE_THERMAL,
    ACPI_TYPE_THERMAL,
};

static ACPI_STRING      MethodPathNames0000[] = {
    "\\", "M000",
    "\\D1L1", "M000",
    "\\D1L1.D2L0", "M000",
    "\\D1L1.D2L0.D3L0", "M000",
    "\\D1L1.D2L0.D3L0.D4L_", "M000",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0", "M000",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0", "M000",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0", "M000",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0", "M000",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "M000",
};


static ACPI_STRING      MethodArgPathNames0000[] = {
    "\\D1L1", "M001",
    "\\D1L1.D2L0", "M002",
    "\\D1L1.D2L0.D3L0", "M003",
    "\\D1L1.D2L0.D3L0.D4L_", "M004",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0", "M005",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0", "M006",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0", "M007",
};

static ACPI_STRING      PathNames0000[] = {
    "\\", "_SB_",
    "\\", "N0L0",
    "\\", "N0L1",
    "\\", "N0L2",
    "\\", "N0L3",
    "\\", "L4__",
    "\\D1L0", "N0L0",
    "\\D1L0", "N0L1",
    "\\D1L0", "N0L2",
    "\\D1L0", "N0L3",
    "\\D1L0", "L4__",
    "\\D1L1", "N0L0",
    "\\D1L1", "N1L1",
    "\\D1L1", "N0L2",
    "\\D1L1", "N1L3",
    "\\D1L1", "L4__",
    "\\D1L2", "N0L0",
    "\\D1L2", "N1L1",
    "\\D1L2", "N0L2",
    "\\D1L2", "N2L3",
    "\\D1L2", "L4__",
    "\\D1L1.D2L0", "N0L0",
    "\\D1L1.D2L0", "N1L1",
    "\\D1L1.D2L0", "N0L2",
    "\\D1L1.D2L0", "N1L3",
    "\\D1L1.D2L0", "L4__",
    "\\D1L1.D2L0.D3L0", "N0L0",
    "\\D1L1.D2L0.D3L0", "N1L1",
    "\\D1L1.D2L0.D3L0", "N0L2",
    "\\D1L1.D2L0.D3L0", "N1L3",
    "\\D1L1.D2L0.D3L0", "L4__",
    "\\D1L1.D2L0.D3L0.D4L_", "N0L0",
    "\\D1L1.D2L0.D3L0.D4L_", "N1L1",
    "\\D1L1.D2L0.D3L0.D4L_", "N0L2",
    "\\D1L1.D2L0.D3L0.D4L_", "N1L3",
    "\\D1L1.D2L0.D3L0.D4L_", "L4__",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0", "N0L0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0", "N1L1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0", "N0L2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0", "N1L3",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0", "L4__",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0", "N0L0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0", "N1L1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0", "N0L2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0", "N1L3",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0", "L4__",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0", "N0L0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0", "N1L1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0", "N0L2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0", "N1L3",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0", "L4__",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0", "N0L0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0", "N1L1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0", "N0L2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0", "N1L3",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0", "L4__",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "N0L0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "N1L1",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "N0L2",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "N1L3",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0", "L4__",
};

static UINT32           Values0000[] = {
    0,
    0x0000,    0x0001,    0x0002,    0x0003,    0x0004,
    0x0100,    0x0101,    0x0102,    0x0103,    0x0104,
    0x0110,    0x0111,    0x0112,    0x0113,    0x0114,
    0x0210,    0x0211,    0x0212,    0x0213,    0x0214,
    0x0120,    0x0121,    0x0122,    0x0123,    0x0124,
    0x0130,    0x0131,    0x0132,    0x0133,    0x0134,
    0x0140,    0x0141,    0x0142,    0x0143,    0x0144,
    0x0150,    0x0151,    0x0152,    0x0153,    0x0154,
    0x0160,    0x0161,    0x0162,    0x0163,    0x0164,
    0x0170,    0x0171,    0x0172,    0x0173,    0x0174,
    0x0180,    0x0181,    0x0182,    0x0183,    0x0184,
    0x0190,    0x0191,    0x0192,    0x0193,    0x0194,
};

static ACPI_STRING      DevicePathNames0000[] = {
    "\\", "D1L1",
    "\\D1L1", "D2L0",
    "\\D1L1.D2L0", "D3L0",
    "\\D1L1.D2L0.D3L0", "D4L_",
    "\\D1L1.D2L0.D3L0.D4L_", "D5L0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0", "D6L0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0", "D7L0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0", "D8L0",
    "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0", "D9L0",
};

static ACPI_OBJECT_TYPE      TypesDevicePathNames0000[] = {
    ACPI_TYPE_DEVICE,
    ACPI_TYPE_DEVICE,
    ACPI_TYPE_DEVICE,
    ACPI_TYPE_DEVICE,
    ACPI_TYPE_DEVICE,
    ACPI_TYPE_DEVICE,
    ACPI_TYPE_DEVICE,
    ACPI_TYPE_DEVICE,
    ACPI_TYPE_DEVICE,
    ACPI_TYPE_DEVICE,
    ACPI_TYPE_DEVICE,
};

#ifdef    _MSC_VER
#define ULL_CONST(a)        a
#define ULL_POSTFIX
#else
#define ULL_CONST(a)        a##ULL
#endif

typedef struct at_device_info
{
    UINT32                      Valid;
    UINT32                      CurrentStatus;
    ACPI_INTEGER                Address;
    char                        *HardwareId;
    char                        *UniqueId;
/*    UINT8                       HighestDstates[4];*/
    UINT32                      HighestDstates4;
    UINT32                      CidCount;
} AT_DEVICE_INFO;

static AT_DEVICE_INFO   DeviceInfo0000[] = {
    {0x3f, 0xffffffff, ULL_CONST(0xf00000001),
        "PNP0A01", "0", 0xffffff01, 1},
    {0x3f, 0xffffffff, ULL_CONST(0xf00000002),
        "PNP0A02", "1", 0xffff02ff, 1},
    {0x3f, 0xffffffef, ULL_CONST(0xf00000003),
        "ACPI0A03", "d3l0_UID", 0xff03ffff, 2},
    {0x3d, 0x0ffffff7, ULL_CONST(0xf00000004),
        "PNP0A04", "999999999", 0x04ffffff, 1},
    {0x3f, 0x00fffffb, ULL_CONST(0xf00000005),
        "PNP0A05", "100000000", 0xffffffff, 1},
    {0x2f, 0x000ffffd, ULL_CONST(0xf00000006),
        "PNP0A06", "d6l0_UID", 0x01020304, 1},
    {0x37, 0x0000ffff, ULL_CONST(0xf00000007),
        "ACPI0A07", "", 0xff02ff01, 3},
    {0x3b, 0x0000fffe, ULL_CONST(0xf00000008),
        "PNP0A08", "d8l0_UID", 0xd1e2f3ff, 1},
    {0x3f, 0x00000000, ULL_CONST(0xf00000009),
        "PNP0A09", "d9l0_UID", 0xffffffff, 7},
};

typedef struct at_walk_info
{
    UINT32                      NestingLevel;
    ACPI_STRING                 PathName;
    UINT32                      WalkCount;
    UINT32                      HandlerCount;
    UINT32                      XfNestingLevel;
} AT_WALK_INFO;

static AT_WALK_INFO      DeviceWalkInfo0000[] = {
    {1, "\\_SB_"},
    {1, "\\DEV0"},
    {1, "\\D1L0"},
    {2, "\\D1L0.DEV0"},
    {1, "\\D1L1"},
    {2, "\\D1L1.D2L0"},
    {3, "\\D1L1.D2L0.D3L0"},
    {4, "\\D1L1.D2L0.D3L0.D4L_"},
    {5, "\\D1L1.D2L0.D3L0.D4L_.D5L0"},
    {6, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0"},
    {7, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0"},
    {1, "\\D1L2"},
    {1, "\\D1L3"},
    {2, "\\D1L3.DEV0"},
};

static AT_WALK_INFO      DeviceWalkInfoDepth[] = {
    {1, "\\_SB_"},
    {1, "\\DEV0"},
    {1, "\\D1L0"},
    {2, "\\D1L0.DEV0"},
    {1, "\\D1L1"},
    {2, "\\D1L1.D2L0"},
    {3, "\\D1L1.D2L0.D3L0"},
    {4, "\\D1L1.D2L0.D3L0.D4L_"},
    {5, "\\D1L1.D2L0.D3L0.D4L_.D5L0"},
    {1, "\\D1L2"},
    {1, "\\D1L3"},
    {2, "\\D1L3.DEV0"},
};

static AT_WALK_INFO      DeviceWalkInfoTerminate[] = {
    {1, "\\_SB_"},
    {1, "\\DEV0"},
    {1, "\\D1L0"},
    {2, "\\D1L0.DEV0"},
    {1, "\\D1L1"},
    {2, "\\D1L1.D2L0"},
    {3, "\\D1L1.D2L0.D3L0"},
    {4, "\\D1L1.D2L0.D3L0.D4L_"},
};

static AT_WALK_INFO      DeviceWalkInfoError[] = {
    {1, "\\_SB_"},
    {1, "\\DEV0"},
    {1, "\\D1L0"},
    {2, "\\D1L0.DEV0"},
    {1, "\\D1L1"},
    {2, "\\D1L1.D2L0"},
    {3, "\\D1L1.D2L0.D3L0"},
    {4, "\\D1L1.D2L0.D3L0.D4L_"},
};

static AT_WALK_INFO      DeviceWalkInfo2Dev[] = {
    /* Matched HID */
    {4, "\\D1L1.D2L0.D3L0.D4L_"},
    /* Matched CID */
    {7, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0"},
};

static AT_WALK_INFO      DeviceWalkInfoDev5[] = {
    {5, "\\D1L1.D2L0.D3L0.D4L_.D5L0"},
};

static AT_WALK_INFO      DeviceWalkInfoDev7[] = {
    {7, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0"},
};

static AT_WALK_INFO      DeviceWalkInfoLevel5[] = {
    {5, "\\D1L1.D2L0.D3L0.D4L_.D5L0"},
    {6, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0"},
    {7, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0"},
    {8, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0"},
    {9, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DEV0"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV1"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV2"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV3"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL1"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL1.DEV0"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL1.DEV1"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL1.DEV2"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL1.DEV3"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL2"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL2.DEV0"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL2.DEV1"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL2.DEV2"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL2.DEV3"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL3"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL3.DEV0"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL3.DEV1"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL3.DEV2"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL3.DEV3"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL4"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL4.DEV0"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL4.DEV1"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL4.DEV2"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL4.DEV3"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL5"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL5.DEV0"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL5.DEV1"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL5.DEV2"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL5.DEV3"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL6"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL7"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL7.DEV0"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL7.DEV1"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL7.DEV2"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL7.DEV3"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL8"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL8.DEV0"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL8.DEV1"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL8.DEV2"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL8.DEV3"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL9"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL9.DEV0"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL9.DEV1"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL9.DEV2"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL9.DEV3"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALA"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALA.DEV0"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALA.DEV1"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALA.DEV2"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALA.DEV3"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALB"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALB.DEV0"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALB.DEV1"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALB.DEV2"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALB.DEV3"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALC"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALC.DEV0"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALC.DEV1"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALC.DEV2"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALC.DEV3"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALD"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALD.DEV0"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALD.DEV1"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALD.DEV2"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALD.DEV3"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALE"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALE.DEV0"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALE.DEV1"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALE.DEV2"},
    {11, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALE.DEV3"},
    {10, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALZ"},
};

static AT_WALK_INFO     TypesWalkInfoLevel2[] = {
    {2, "\\D1L3.INT0"},
    {2, "\\D1L3.INT0"},
    {2, "\\D1L3.STR0"},
    {2, "\\D1L3.BUF0"},
    {2, "\\D1L3.PAC0"},
    {2, "\\D1L3.FLU0"},
    {2, "\\D1L3.DEV0"},
    {2, "\\D1L3.EVE0"},
    {2, "\\D1L3.MMM0"},
    {2, "\\D1L3.MTX0"},
    {2, "\\D1L3.OPR0"},
    {2, "\\D1L3.PWR0"},
    {2, "\\D1L3.CPU0"},
    {2, "\\D1L3.TZN0"},
    {2, "\\D1L3.BFL0"},
};

typedef struct at_walk_handler_context
{
    UINT32                  RetVal;
    UINT32                  ActionCounter;
    UINT32                  InfoCounter;
    AT_WALK_INFO            *WalkInfo;
} AT_WALK_HANDLER_CONTEXT;

typedef struct at_attach_data_stat
{
    ACPI_HANDLE             Object;
    void                    *Data;
} AT_ATTACH_DATA_STAT;

#define MAX_ATTACH_DATA_STAT    3

static char             PathName[AT_PATHNAME_MAX];

void
AtCleanPointer(ACPI_OBJECT *Object)
{
    UINT32                  i;

    switch (Object->Type)
    {
    case ACPI_TYPE_STRING:
        Object->String.Pointer = NULL;
        break;
    case ACPI_TYPE_BUFFER:
        Object->Buffer.Pointer = NULL;
        break;
    case ACPI_TYPE_PACKAGE:
        for (i = 0; i < Object->Package.Count; i++)
        {
            AtCleanPointer(&Object->Package.Elements[i]);
        }
        Object->Package.Elements = NULL;
        break;
    }
}

ACPI_STATUS
AtEvaluateObjectCommon(
    ACPI_STRING             ScopePath,
    ACPI_STRING             ObjName,
    ACPI_OBJECT_LIST        *ParameterObjects,
    ACPI_BUFFER             *ReturnObjectPointer,
    ACPI_STATUS             ExpectedStatus,
    UINT32                  ExpectedValue,
    UINT32                  CheckAction)
{
    ACPI_STATUS             Status;
    ACPI_STRING             Name = ObjName;
    ACPI_HANDLE             ScopeHandle = NULL;
    UINT32                  Length = sizeof (ACPI_OBJECT);

    if (CheckAction == 7 && ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_LOAD)))
    {
        return (Status);
    }

    Name = ObjName;

    if (ScopePath && CheckAction != 3 && CheckAction != 8 &&
        CheckAction != 9)
    {
        Status = AcpiGetHandle (NULL, ScopePath, &ScopeHandle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("AtEvaluateObjectCommon: AcpiGetHandle(NULL, %s) returned %s\n",
                ScopePath, AcpiFormatException(Status));
            return (Status);
        }
    }
    else
    {
        ScopeHandle = NULL;
    }

    switch (CheckAction)
    {
    case 1:
        Name = PathName;
        strcpy(Name, ObjName);
        Name[strlen(Name) - 1] = '&';
        break;
    case 2:
        Name = PathName;
        strcpy(Name, ObjName);
        Name[strlen(Name) - 1] = '\0';
        break;
    case 8:
        Name = PathName;
        strcpy(Name, ScopePath);
        Name[strlen(Name) - 1] = '\0';
        strcat(Name, ".");
        strcat(Name, ObjName);
        break;
    case 3:
        Name = NULL;
        break;
    case 4:
        ReturnObjectPointer->Length = 1;
        ReturnObjectPointer->Pointer = NULL;
        break;
    case 5:
        ReturnObjectPointer->Length = 1;
        ReturnObjectPointer->Pointer = ReturnObjectPointer;
        break;
    case 6:
        /* Make namespace having not been loaded by Subsystem shutdown */
        Status = AcpiTerminate();
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("AtEvaluateObjectCommon: AcpiTerminate() failure, %s\n",
                AcpiFormatException(Status));
            return (Status);
        }
        break;
    case 7:
        /* Make Device handle invalid by unloading SSDT table */
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
        break;
    }

    Status = AcpiEvaluateObject (ScopeHandle, Name,
        ParameterObjects, ReturnObjectPointer);

    if (Status != ExpectedStatus)
    {
        AapiErrors++;
        printf ("AtEvaluateObjectCommon: AcpiEvaluateObject() returned %s,"
            " expected %s\n",
            AcpiFormatException(Status),
            AcpiFormatException(ExpectedStatus));
        return (AE_ERROR);
    }
    else if (Status != AE_OK)
    {
        if (CheckAction == 5 &&
            ReturnObjectPointer->Length != Length /* Object */)
        {
            AapiErrors++;
            printf ("AtEvaluateObjectCommon: AcpiEvaluateObject() returned invalid"
                " Length %d, expected %d\n",
                (UINT32)ReturnObjectPointer->Length, Length);
            return (AE_ERROR);
        }
        return (AE_OK);
    }

    return (AE_OK);
}

ACPI_STATUS
AtEvaluateObjectTypeCommon(
    ACPI_STRING             *PathNames,
    UINT32                  NamesCount,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    ACPI_OBJECT_LIST        *ParameterObjects = NULL;
    ACPI_STRING             Parent;
    ACPI_STRING             Child;
    UINT32                  i;
    ACPI_BUFFER             ReturnBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_BUFFER             ReturnObjectAbs = ReturnBuffer;
    ACPI_BUFFER             ReturnObjectRel = ReturnBuffer;
    ACPI_OBJECT             *ObjectAbs;
    ACPI_OBJECT             *ObjectRel;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    for (i = 0; i < NamesCount; i++)
    {
        /* Absolute Path */

        Parent = NULL;
        Child = PathName;
        strcpy(Child, PathNames[2 * i]);
        if (strlen(Child) > 1)
        {
            strcat(Child, ".");
        }
        strcat(Child, PathNames[2 * i + 1]);

        Status = AtEvaluateObjectCommon(
            Parent, Child, ParameterObjects, &ReturnObjectAbs,
            ExpectedStatus, 0, 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        /* Relative Path */

        Parent = PathNames[2 * i];
        Child = PathNames[2 * i + 1];

        Status = AtEvaluateObjectCommon(
            Parent, Child, ParameterObjects, &ReturnObjectRel,
            ExpectedStatus, 0, 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (ExpectedStatus != AE_OK)
        {
            continue;
        }

        if (ReturnObjectAbs.Length != ReturnObjectRel.Length)
        {
            AapiErrors++;
            printf ("API Error: Lengths of %s are different: %d != %d\n",
                PathNames[2 * i + 1],
                (UINT32)ReturnObjectAbs.Length,
                (UINT32)ReturnObjectRel.Length);
            return (AE_ERROR);
        }

        ObjectAbs = (ACPI_OBJECT *)ReturnObjectAbs.Pointer;
        ObjectRel = (ACPI_OBJECT *)ReturnObjectRel.Pointer;

        AtCleanPointer(ObjectAbs);
        AtCleanPointer(ObjectRel);

        if (ACPI_FAILURE(Status = AtCheckBytes(
            PathNames[2 * i + 1],
            ReturnObjectAbs.Pointer, ReturnObjectRel.Pointer,
            ReturnObjectAbs.Length)))
        {
            return (Status);
        }

        AcpiOsFree(ReturnObjectAbs.Pointer);
        ReturnObjectAbs = ReturnBuffer;
        AcpiOsFree(ReturnObjectRel.Pointer);
        ReturnObjectRel = ReturnBuffer;
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0000:
 *
 */
ACPI_STATUS
AtNSpaceTest0000(void)
{
    return (AtEvaluateObjectTypeCommon(
        EvPathNames0000,
        sizeof (EvPathNames0000) / sizeof (ACPI_STRING) / 2,
        AE_OK));
}

ACPI_STATUS
AtEvaluateObjectMethodCommon(void)
{
    ACPI_STATUS             Status;
    UINT32                  NamesCount;
    ACPI_STRING             Parent;
    ACPI_STRING             Child;
    UINT32                  i;
    ACPI_BUFFER             ReturnBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_BUFFER             ReturnObjectRel = ReturnBuffer;
    ACPI_OBJECT             *ObjectRel;
    UINT32                  Length = sizeof (ACPI_OBJECT);

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    NamesCount = sizeof (MethodPathNames0000) / sizeof (ACPI_STRING) / 2;

    for (i = 0; i < NamesCount; i++)
    {
        printf ("AtEvaluateObjectMethodCommon: %d\n", i);

        /* Absolute Path */

        Parent = NULL;
        Child = PathName;
        strcpy(Child, MethodPathNames0000[2 * i]);
        if (strlen(Child) > 1)
        {
            strcat(Child, ".");
        }
        strcat(Child, MethodPathNames0000[2 * i + 1]);

        Status = AtEvaluateObjectCommon(
            Parent, Child, NULL, NULL,
            AE_OK, 0, 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\IOUT", 0x200 + i)))
        {
            return (Status);
        }

        /* Relative Path */

        Parent = MethodPathNames0000[2 * i];
        Child = MethodPathNames0000[2 * i + 1];

        Status = AtEvaluateObjectCommon(
            Parent, Child, NULL, &ReturnObjectRel,
            AE_OK, 0, 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (ReturnObjectRel.Length != Length)
        {
            AapiErrors++;
            printf ("API Error: unexpected Length of result: %d != %d\n",
                (UINT32)ReturnObjectRel.Length, Length);
            return (AE_ERROR);
        }

        ObjectRel = (ACPI_OBJECT *)ReturnObjectRel.Pointer;

        if (ObjectRel->Type != ACPI_TYPE_INTEGER)
        {
            AapiErrors++;
            printf ("API Error: unexpected Type of result: %d != %d\n",
                ObjectRel->Type, ACPI_TYPE_INTEGER);
            return (AE_ERROR);
        }

        if (ObjectRel->Integer.Value != 0x200 + i)
        {
            AapiErrors++;
            printf ("API Error: unexpected Value of result: %d != %d\n",
                (UINT32)ObjectRel->Integer.Value, 0x200 + i);
            return (AE_ERROR);
        }

        AcpiOsFree(ReturnObjectRel.Pointer);
        ReturnObjectRel = ReturnBuffer;
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0001:
 *
 */
ACPI_STATUS
AtNSpaceTest0001(void)
{
    return (AtEvaluateObjectMethodCommon());
}

ACPI_STATUS
AtEvaluateObjectMethodArgCommon(UINT32 MoreArgs)
{
    ACPI_STATUS             Status;
    ACPI_OBJECT_LIST        ParameterObjects;
    UINT32                  NamesCount;
    UINT32                  NumArgs;
    ACPI_STRING             Parent;
    ACPI_STRING             Child;
    UINT32                  i, j;
    ACPI_BUFFER             ReturnBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_BUFFER             ReturnObjectAbs = ReturnBuffer;
    ACPI_BUFFER             ReturnObjectRel = ReturnBuffer;
    ACPI_OBJECT             *ObjectAbs;
    ACPI_OBJECT             *ObjectRel;
#define OUT_BUF_LEN         8
    UINT8                   OutBuffer[OUT_BUF_LEN];
    UINT32                  Length = sizeof (ACPI_OBJECT) + OUT_BUF_LEN;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    NamesCount = sizeof (MethodArgPathNames0000) / sizeof (ACPI_STRING) / 2;

    for (i = 0; i < NamesCount; i++)
    {
        printf ("AtEvaluateObjectMethodCommon: %d\n", i);

        if (MoreArgs)
        {
            NumArgs = 8;
        }
        else
        {
            NumArgs = i + 1;
        }
        ParameterObjects.Count = NumArgs;
        ParameterObjects.Pointer = (ACPI_OBJECT *)malloc(
            (NumArgs)* sizeof (ACPI_OBJECT));

        memset(OutBuffer, 0, OUT_BUF_LEN);
        for (j = 0; j < NumArgs; j++)
        {
            ParameterObjects.Pointer[j].Type = ACPI_TYPE_INTEGER;
            ParameterObjects.Pointer[j].Integer.Value = j * 16 + i;
            if (j <= i)
            {
                OutBuffer[j] = (UINT8)(j * 16 + i);
            }
        }

        /* Absolute Path */

        Parent = NULL;
        Child = PathName;
        strcpy(Child, MethodArgPathNames0000[2 * i]);
        if (strlen(Child) > 1)
        {
            strcat(Child, ".");
        }
        strcat(Child, MethodArgPathNames0000[2 * i + 1]);

        Status = AtEvaluateObjectCommon(
            Parent, Child, &ParameterObjects, &ReturnObjectAbs,
            AE_OK, 0, 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (ReturnObjectAbs.Length != Length)
        {
            AapiErrors++;
            printf ("API Error: Result Length %d != %d\n",
                (UINT32)ReturnObjectAbs.Length, Length);
            return (AE_ERROR);
        }

        if (ACPI_FAILURE(Status = AtCheckBytes(
                MethodArgPathNames0000[2 * i + 1],
                (UINT8 *)ReturnObjectAbs.Pointer + sizeof (ACPI_OBJECT),
                OutBuffer, OUT_BUF_LEN)))
        {
            return (Status);
        }

        /* Relative Path */

        Parent = MethodArgPathNames0000[2 * i];
        Child = MethodArgPathNames0000[2 * i + 1];

        Status = AtEvaluateObjectCommon(
            Parent, Child, &ParameterObjects, &ReturnObjectRel,
            AE_OK, 0, 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (ReturnObjectAbs.Length != ReturnObjectRel.Length)
        {
            AapiErrors++;
            printf ("API Error: Lengths of %s are different: %d != %d\n",
                MethodArgPathNames0000[2 * i + 1],
                (UINT32)ReturnObjectAbs.Length,
                (UINT32)ReturnObjectRel.Length);
            return (AE_ERROR);
        }

        ObjectAbs = (ACPI_OBJECT *)ReturnObjectAbs.Pointer;
        ObjectRel = (ACPI_OBJECT *)ReturnObjectRel.Pointer;

        if (ObjectRel->Type != ACPI_TYPE_BUFFER)
        {
            AapiErrors++;
            printf ("API Error: unexpected Type of result: %d != %d\n",
                ObjectRel->Type, ACPI_TYPE_BUFFER);
            return (AE_ERROR);
        }

        AtCleanPointer(ObjectAbs);
        AtCleanPointer(ObjectRel);

        if (ACPI_FAILURE(Status = AtCheckBytes(
            MethodArgPathNames0000[2 * i + 1],
            ReturnObjectAbs.Pointer, ReturnObjectRel.Pointer,
            ReturnObjectAbs.Length)))
        {
            return (Status);
        }

        AcpiOsFree(ReturnObjectAbs.Pointer);
        ReturnObjectAbs = ReturnBuffer;
        AcpiOsFree(ReturnObjectRel.Pointer);
        ReturnObjectRel = ReturnBuffer;
        free(ParameterObjects.Pointer);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0002:
 *
 */
ACPI_STATUS
AtNSpaceTest0002(void)
{
    return (AtEvaluateObjectMethodArgCommon(0));
}

/*
 * ASSERTION 0003:
 *
 */
ACPI_STATUS
AtNSpaceTest0003(void)
{
    return (AtEvaluateObjectMethodArgCommon(1));
}

/*
 * ASSERTION 0004:
 *
 */
ACPI_STATUS
AtNSpaceTest0004(void)
{
    ACPI_STATUS             Status;
    UINT32                  NamesCount;
    ACPI_STRING             Parent;
    ACPI_STRING             Child;
    UINT32                  i;
    ACPI_BUFFER             ReturnBuffer = {ACPI_ALLOCATE_BUFFER};
    ACPI_BUFFER             ReturnObject = ReturnBuffer;
    ACPI_OBJECT             *Object;
    UINT32                  Length = sizeof (ACPI_OBJECT);

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    NamesCount = sizeof (MethodPathNames0000) / sizeof (ACPI_STRING) / 2;

    for (i = 0; i < NamesCount; i++)
    {
        printf ("AtEvaluateObjectMethodCommon: %d\n", i);

        Parent = MethodPathNames0000[2 * i];
        Child = MethodPathNames0000[2 * i + 1];

       /* NULL Result Buffer */

        Status = AtEvaluateObjectCommon(
            Parent, Child, NULL, NULL,
            AE_OK, 0, 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\IOUT", 0x200 + i)))
        {
            return (Status);
        }

        /* non-NULL Result Buffer */

        Parent = MethodPathNames0000[2 * i];
        Child = MethodPathNames0000[2 * i + 1];

        Status = AtEvaluateObjectCommon(
            Parent, Child, NULL, &ReturnObject,
            AE_OK, 0, 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (ReturnObject.Length != Length)
        {
            AapiErrors++;
            printf ("API Error: unexpected Length of result: %d != %d\n",
                (UINT32)ReturnObject.Length, Length);
            return (AE_ERROR);
        }

        Object = (ACPI_OBJECT *)ReturnObject.Pointer;

        if (Object->Type != ACPI_TYPE_INTEGER)
        {
            AapiErrors++;
            printf ("API Error: unexpected Type of result: %d != %d\n",
                Object->Type, ACPI_TYPE_INTEGER);
            return (AE_ERROR);
        }

        if (Object->Integer.Value != 0x200 + i)
        {
            AapiErrors++;
            printf ("API Error: unexpected Value of result: %d != %d\n",
                (UINT32)Object->Integer.Value, 0x200 + i);
            return (AE_ERROR);
        }

        AcpiOsFree(ReturnObject.Pointer);
        ReturnObject = ReturnBuffer;
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0005:
 *
 */
ACPI_STATUS
AtNSpaceTest0005(void)
{
    ACPI_STATUS             Status;
    ACPI_STRING             Parent = "\\";
    ACPI_STRING             Child = "M100";
    ACPI_BUFFER             ReturnObject = {ACPI_ALLOCATE_BUFFER};
    UINT32                  ExpectedLength = 0;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\IOUT", 0x1FF)))
    {
        return (Status);
    }

    /* NULL Result Buffer */

    Status = AtEvaluateObjectCommon(
        Parent, Child, NULL, NULL,
        AE_OK, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\IOUT", 0x200)))
    {
        return (Status);
    }

    /* non-NULL Result Buffer */

    Status = AtEvaluateObjectCommon(
        Parent, Child, NULL, &ReturnObject,
        AE_OK, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (AcpiGbl_EnableInterpreterSlack)
    {
        ExpectedLength = 16;
    }

    if (ReturnObject.Length != ExpectedLength)
    {
        AapiErrors++;
        printf ("API Error: unexpected Length of result: %d != %d\n",
            (UINT32)ReturnObject.Length, ExpectedLength);
        return (AE_ERROR);
    }

    if (ReturnObject.Length)
    {
        AcpiOsFree(ReturnObject. Pointer);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\IOUT", 0x201)))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0006:
 *
 */
ACPI_STATUS
AtNSpaceTest0006(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    Status = AtEvaluateObjectCommon(
        NULL, "\\M001", NULL, NULL,
        AE_OK, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\ICCS", 0x222)))
    {
        printf ("AtNSpaceTest0006: AE_OK error M001\n");
        return (Status);
    }

    Status = AtEvaluateObjectCommon(
        NULL, "\\M001", NULL, NULL,
        AE_AML_DIVIDE_BY_ZERO, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\ICCS", 0x111)))
    {
        printf ("AtNSpaceTest0006: AE_AML_DIVIDE_BY_ZERO error M001\n");
        return (Status);
    }

    Status = AtEvaluateObjectCommon(
        NULL, "\\M101", NULL, NULL,
        AE_OK, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\ICCS", 0x22002)))
    {
        printf ("AtNSpaceTest0006: AE_OK error M101\n");
        return (Status);
    }

    Status = AtEvaluateObjectCommon(
        NULL, "\\M101", NULL, NULL,
        AE_AML_DIVIDE_BY_ZERO, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\ICCS", 0x11001)))
    {
        printf ("AtNSpaceTest0006: AE_AML_DIVIDE_BY_ZERO error M101\n");
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0007:
 *
 */
ACPI_STATUS
AtNSpaceTest0007(void)
{
    return (AtEvaluateObjectTypeCommon(
        AeTypePathNames0000,
        sizeof (AeTypePathNames0000) / sizeof (ACPI_STRING) / 2,
        AE_TYPE));
}

ACPI_STATUS
AtEvaluateObjectExceptionCommon(
    UINT32                  CheckAction,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    ACPI_OBJECT_LIST        *ParameterObjects = NULL;
    ACPI_BUFFER             ReturnBuffer = {ACPI_ALLOCATE_BUFFER};

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    if (CheckAction == 7)
    {
        Status = AtEvaluateObjectCommon(
            "\\AUX2", "SS00",
            ParameterObjects, &ReturnBuffer,
            ExpectedStatus, 0, CheckAction);
    }
    else
    {
        Status = AtEvaluateObjectCommon(
            "\\D1L1.D2L0.D3L0.D4L_.D5L0", "L4__",
            ParameterObjects, &ReturnBuffer,
            ExpectedStatus, 0, CheckAction);
    }

    if (ACPI_FAILURE(Status) || CheckAction == 6)
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

ACPI_STATUS
AtEvaluateObjectMethodException1(
    char                    *CodeName,
    ACPI_STRING             MethodName,
    ACPI_STATUS             ExpectedStatus,
    ACPI_STRING             ControlName,
    UINT32                  ExpectedValue)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet(CodeName)))
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

    Status = AtEvaluateObjectCommon(
        NULL, MethodName, NULL, NULL,
        ExpectedStatus, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, ControlName, ExpectedValue)))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0010:
 *
 */
ACPI_STATUS
AtNSpaceTest0010(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0010.aml")))
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

    Status = AtEvaluateObjectCommon(
        NULL, "\\M000", NULL, NULL,
        AE_AML_BAD_OPCODE, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\I000", 0x0)))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\I001", 0x0)))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0011:
 *
 */
ACPI_STATUS
AtNSpaceTest0011(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0011.aml")))
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

    Status = AtEvaluateObjectCommon(
        NULL, "\\M000", NULL, NULL,
        AE_AML_NO_OPERAND, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\I000", 0x0)))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\I001", 0x1)))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\I002", 0x1)))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\I003", 0x0)))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0012:
 *
 */
ACPI_STATUS
AtNSpaceTest0012(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0012.aml")))
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

    Status = AtEvaluateObjectCommon(
        NULL, "\\M000", NULL, NULL,
        AE_AML_OPERAND_TYPE, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\I000", 0x0)))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\I001", 0x0)))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0013:
 *
 */
ACPI_STATUS
AtNSpaceTest0013(void)
{
    return (AtEvaluateObjectMethodException1(
        "nmsp0013.aml",
        "\\M000", AE_AML_OPERAND_VALUE,
        "\\I000", 0x0));
}

/*
 * ASSERTION 0014:
 *
 */
ACPI_STATUS
AtNSpaceTest0014(void)
{
    return (AtEvaluateObjectMethodException1(
        "nmsp0014.aml",
        "\\M000", (AcpiGbl_EnableInterpreterSlack)? AE_OK:
            AE_AML_UNINITIALIZED_LOCAL,
        "\\I000", (AcpiGbl_EnableInterpreterSlack)? 0x1: 0x0));
}

/*
 * ASSERTION 0015:
 *
 */
ACPI_STATUS
AtNSpaceTest0015(void)
{
    ACPI_STATUS             Status;


    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0015.aml")))
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

    Status = AtEvaluateObjectCommon(
        NULL, "\\M000", NULL, NULL,
        (AcpiGbl_EnableInterpreterSlack)? AE_OK: AE_AML_UNINITIALIZED_ARG, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\I000",
        (AcpiGbl_EnableInterpreterSlack)? 0x1: 0x0)))
    {
        return (Status);
    }

    Status = AtEvaluateObjectCommon(
        NULL, "\\M001", NULL, NULL,
        (AcpiGbl_EnableInterpreterSlack)? AE_OK: AE_AML_UNINITIALIZED_ARG, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\I001",
        (AcpiGbl_EnableInterpreterSlack)? 0x1: 0x0)))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\I002",
        (AcpiGbl_EnableInterpreterSlack)? 0x2: 0x1)))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0016:
 *
 */
ACPI_STATUS
AtNSpaceTest0016(void)
{
    return (AtEvaluateObjectMethodException1(
        "nmsp0016.aml",
        "\\M000", AE_AML_NUMERIC_OVERFLOW,
        "\\I000", 0x0));
}

/*
 * ASSERTION 0017:
 *
 */
ACPI_STATUS
AtNSpaceTest0017(void)
{
    return (AtEvaluateObjectMethodException1(
        "nmsp0017.aml",
        "\\M000", AE_AML_REGION_LIMIT,
        "\\I000", 0x1));
}

/*
 * ASSERTION 0018:
 *
 */
ACPI_STATUS
AtNSpaceTest0018(void)
{
    return (AtEvaluateObjectMethodException1(
        "nmsp0018.aml",
        "\\M000", AE_AML_BUFFER_LIMIT,
        "\\I000", 0x1));
}

/*
 * ASSERTION 0019:
 *
 */
ACPI_STATUS
AtNSpaceTest0019(void)
{
    return (AtEvaluateObjectMethodException1(
        "nmsp0019.aml",
        "\\M000", AE_AML_PACKAGE_LIMIT,
        "\\I000", 0x1));
}

/*
 * ASSERTION 0020:
 *
 */
ACPI_STATUS
AtNSpaceTest0020(void)
{
    return (AtEvaluateObjectMethodException1(
        "nmsp0020.aml",
        "\\M000", AE_AML_STRING_LIMIT,
        "\\I000", 0x1));
}

/*
 * ASSERTION 0021:
 *
 */
ACPI_STATUS
AtNSpaceTest0021(void)
{
    return (AtEvaluateObjectMethodException1(
        "nmsp0021.aml",
        "\\M000", AE_AML_DIVIDE_BY_ZERO,
        "\\I000", 0x0));
}

/*
 * ASSERTION 0022:
 *
 */
ACPI_STATUS
AtNSpaceTest0022(void)
{
    AtSetAmlControl(0x49, '!');

    return (AtEvaluateObjectMethodException1(
        "nmsp0022.aml",
        "\\M000", AE_AML_BAD_NAME,
        "\\I000", 0x0));
}

/*
 * ASSERTION 0023:
 *
 */
ACPI_STATUS
AtNSpaceTest0023(void)
{
    AtSetAmlControl(0x46, 'M');

    return (AtEvaluateObjectMethodException1(
        "nmsp0023.aml",
        "\\M000", AE_AML_NAME_NOT_FOUND,
        "\\I000", 0x0));
}

/*
 * ASSERTION 0025:
 *
 */
ACPI_STATUS
AtNSpaceTest0025(void)
{
    return (AtEvaluateObjectMethodException1(
        "nmsp0025.aml",
        "\\M000", AE_AML_INTERNAL,
        "\\I000", 0x0));
}

/*
 * ASSERTION 0026:
 *
 */
ACPI_STATUS
AtNSpaceTest0026(void)
{
    return (AtEvaluateObjectExceptionCommon(1, AE_BAD_CHARACTER));
}

/*
 * ASSERTION 0027:
 *
 */
ACPI_STATUS
AtNSpaceTest0027(void)
{
    ACPI_STATUS             Status;

    Status = AtEvaluateObjectExceptionCommon(2, AE_BAD_PATHNAME);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtEvaluateObjectExceptionCommon(8, AE_BAD_PATHNAME));
}

/*
 * ASSERTION 0029:
 *
 */
ACPI_STATUS
AtNSpaceTest0029(void)
{
    return (AtEvaluateObjectExceptionCommon(3, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0030:
 *
 */
ACPI_STATUS
AtNSpaceTest0030(void)
{
    return (AtEvaluateObjectExceptionCommon(9, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0031:
 *
 */
ACPI_STATUS
AtNSpaceTest0031(void)
{
    return (AtEvaluateObjectExceptionCommon(7, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0032:
 *
 */
ACPI_STATUS
AtNSpaceTest0032(void)
{
    return (AtEvaluateObjectExceptionCommon(4, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0033:
 *
 */
ACPI_STATUS
AtNSpaceTest0033(void)
{
    return (AtEvaluateObjectExceptionCommon(5, AE_BUFFER_OVERFLOW));
}

ACPI_STATUS
AtEvaluateObjectExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark,
    ACPI_STRING             ScopePath,
    ACPI_STRING             ObjName)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  CtrlCheck = ALL_STAT;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_STRING             Name = ObjName;
    ACPI_HANDLE             ScopeHandle;

    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtResourceExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (ScopePath)
        {
            Status = AcpiGetHandle(NULL, ScopePath, &ScopeHandle);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("API error: AcpiEvaluateObject(NULL, %s)"
                    " returned %s\n",
                    ScopePath, AcpiFormatException(Status));
                return (Status);
            }
        }
        else
        {
            ScopeHandle = NULL;
        }

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: OsxfCtrlSet returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiEvaluateObject (ScopeHandle, Name,
            NULL, NULL);

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
                printf ("API Error: AcpiEvaluateObject returned %s,\n"
                    "           expected to return %s\n",
                    AcpiFormatException(Status), AcpiFormatException(Benchmark));
                printf ("           ObjName '%s', i = %d\n", ObjName, i);
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
 * ASSERTION 0035:
 */
ACPI_STATUS
AtNSpaceTest0035(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */

    Status = AtEvaluateObjectExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0", "L4__");
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtEvaluateObjectExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        NULL, "\\D1L1.D2L0.D3L0.D4L_.D5L0.L4__");
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtEvaluateObjectExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0", "PAC1");
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtEvaluateObjectExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        NULL, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.PAC1");
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtEvaluateObjectExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0", "M000");
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtEvaluateObjectExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        NULL, "\\D1L1.D2L0.D3L0.D4L_.D5L0.M000");
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */

    Status = AtEvaluateObjectExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0", "L4__");
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtEvaluateObjectExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        NULL, "\\D1L1.D2L0.D3L0.D4L_.D5L0.L4__");
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtEvaluateObjectExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0", "PAC1");
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtEvaluateObjectExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        NULL, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.PAC1");
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtEvaluateObjectExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0", "M000");
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtEvaluateObjectExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        NULL, "\\D1L1.D2L0.D3L0.D4L_.D5L0.M000"));
}

/*
 * ASSERTION 0036:
 *
 */
ACPI_STATUS
AtNSpaceTest0036(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    Status = AtEvaluateObjectCommon(
        NULL, "\\D1L1.D2L0.D3L0.D4L0.D5L0.M000",
        NULL, NULL, AE_NOT_FOUND, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtEvaluateObjectCommon(
        "\\D1L1.D2L0.D3L0.D4L_.D5L0", "M001",
        NULL, NULL, AE_NOT_FOUND, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtEvaluateObjectCommon(
        NULL, "\\D1L1.D2L0.D3L0.D4L_.D5L0.M001",
        NULL, NULL, AE_NOT_FOUND, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0037:
 *
 */
ACPI_STATUS
AtNSpaceTest0037(void)
{
    return (AtEvaluateObjectMethodException1(
        "nmsp0037.aml",
        "\\M000", AE_NULL_OBJECT,
        "\\I000", 0x0));
}

ACPI_STATUS
AtGetObjectInfoCommon(
    ACPI_STRING             ObjName,
    ACPI_STATUS             ExpectedStatus,
    ACPI_DEVICE_INFO        **Info,
    UINT32                  CheckAction)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             ObjHandle;
    ACPI_DEVICE_INFO        *LocalInfo;


    if (CheckAction == 3 && ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_LOAD)))
    {
        return (Status);
    }

    Status = AcpiGetHandle (NULL, ObjName, &ObjHandle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("AtGetObjectInfoCommon: AcpiGetHandle(NULL, %s) returned %s\n",
            ObjName, AcpiFormatException(Status));
        return (Status);
    }

    switch (CheckAction)
    {
    case 1:
        ObjHandle = NULL;
        break;
    case 2:
        /* Make namespace having not been loaded by Subsystem shutdown */
        Status = AcpiTerminate();
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("AtGetObjectInfoCommon: AcpiTerminate() failure, %s\n",
                AcpiFormatException(Status));
            return (Status);
        }
        break;
    case 3:
        /* Make Device handle invalid by unloading SSDT table */
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
        break;
    case 4:
        *Info = NULL;
        break;
    }

    Status = AcpiGetObjectInfo (ObjHandle, &LocalInfo);
    *Info = LocalInfo;

    if (Status != ExpectedStatus)
    {
        AapiErrors++;
        printf ("AtGetObjectInfoCommon: AcpiGetObjectInfo() returned %s,"
            " expected %s\n",
            AcpiFormatException(Status),
            AcpiFormatException(ExpectedStatus));
        return (AE_ERROR);
    }
    else if (Status != AE_OK)
    {
        return (AE_OK);
    }

    return (AE_OK);
}

ACPI_STATUS
AtGetObjectInfoTypeCommon(
    ACPI_STRING             *PathNames,
    UINT32                  NamesCount,
    ACPI_STATUS             ExpectedStatus,
    ACPI_OBJECT_TYPE        *ExpectedTypes,
    AT_DEVICE_INFO          *ExpectedInfo)
{
    ACPI_STATUS             Status;
    ACPI_STRING             Node;
    UINT32                  i;
    UINT32                  HighestDstates4;
    ACPI_DEVICE_INFO        *Info;


    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    for (i = 0; i < NamesCount; i++)
    {
        /* Absolute Path */

        Node = PathName;
        strcpy(Node, PathNames[2 * i]);
        if (strlen(Node) > 1)
        {
            strcat(Node, ".");
        }
        strcat(Node, PathNames[2 * i + 1]);

        Status = AtGetObjectInfoCommon(
            Node, ExpectedStatus, &Info, 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (ExpectedStatus != AE_OK)
        {
            continue;
        }

        if (!Info)
        {
            AapiErrors++;
            printf ("API Error: Null return buffer\n");
            return (AE_ERROR);
        }

        if (strncmp((ACPI_STRING)&Info->Name, PathNames[2 * i + 1],
            sizeof (ACPI_NAME)))
        {
            AapiErrors++;
            printf ("API Error: Name of %s is incorrect (%x)\n",
                PathNames[2 * i + 1],
                Info->Name);
            return (AE_ERROR);
        }

        if (Info->Type != ExpectedTypes[i])
        {
            AapiErrors++;
            printf ("API Error: Type of %s (%d) != (%d)\n",
                PathNames[2 * i + 1],
                Info->Type, ExpectedTypes[i]);
            return (AE_ERROR);
        }

        if (Info->Type != ACPI_TYPE_DEVICE && Info->Valid != 0)
        {
            AapiErrors++;
            printf ("API Error: Valid of %s (%d) != (%d)\n",
                PathNames[2 * i + 1],
                Info->Valid, 0);
            return (AE_ERROR);
        }
        else if (Info->Type == ACPI_TYPE_DEVICE && ExpectedInfo)
        {
            if (Info->Valid != ExpectedInfo[i].Valid)
            {
                AapiErrors++;
                printf ("API Error: Valid of %s (%d) != (%d)\n",
                    PathNames[2 * i + 1],
                    Info->Valid, ExpectedInfo[i].Valid);
                return (AE_ERROR);
            }
            if ((Info->Valid & ACPI_VALID_ADR) &&
                Info->Address != ExpectedInfo[i].Address)
            {
                AapiErrors++;
#if ACPI_MACHINE_WIDTH == 64
#ifdef    _MSC_VER
                printf ("API Error: Address of %s (0x%I64X) != (0x%I64X)\n",
                    PathNames[2 * i + 1],
                    Info->Address, ExpectedInfo[i].Address);
#else
                printf ("API Error: Address of %s (0x%llX) != (0x%llX)\n",
                    PathNames[2 * i + 1],
                    Info->Address, ExpectedInfo[i].Address);
#endif
#else
                printf ("API Error: Address of %s (0x%X) != (0x%X)\n",
                    PathNames[2 * i + 1],
                    (UINT32) Info->Address, (UINT32) ExpectedInfo[i].Address);
#endif
                return (AE_ERROR);
            }
            if ((Info->Valid & ACPI_VALID_STA) &&
                Info->CurrentStatus != ExpectedInfo[i].CurrentStatus)
            {
                AapiErrors++;
                printf ("API Error: CurrentStatus of %s (0x%X) != (0x%X)\n",
                    PathNames[2 * i + 1],
                    Info->CurrentStatus, ExpectedInfo[i].CurrentStatus);
                return (AE_ERROR);
            }
            memcpy(&HighestDstates4, Info->HighestDstates, sizeof (HighestDstates4));
            if ((Info->Valid & ACPI_VALID_SXDS) &&
                HighestDstates4 != ExpectedInfo[i].HighestDstates4)
            {
                AapiErrors++;
                printf ("API Error: CurrentStatus of %s (0x%X) != (0x%X)\n",
                    PathNames[2 * i + 1],
                    HighestDstates4, ExpectedInfo[i].HighestDstates4);
                return (AE_ERROR);
            }
            if ((Info->Valid & ACPI_VALID_HID) &&
                strcmp(Info->HardwareId.String, ExpectedInfo[i].HardwareId))
            {
                AapiErrors++;
                printf ("API Error: HardwareId of %s (%s) != (%s)\n",
                    PathNames[2 * i + 1],
                    Info->HardwareId.String, ExpectedInfo[i].HardwareId);
                return (AE_ERROR);
            }
            if ((Info->Valid & ACPI_VALID_UID) &&
            /*
                strncmp(Info->UniqueId.Value, ExpectedInfo[i].UniqueId.Value,
                    ACPI_DEVICE_ID_LENGTH))
             *  Update highlighting bug 17
             */
                strcmp(Info->UniqueId.String, ExpectedInfo[i].UniqueId))
            {
                AapiErrors++;
                printf ("API Error: UniqueId of %s (%s) != (%s)\n",
                    PathNames[2 * i + 1],
                    Info->UniqueId.String, ExpectedInfo[i].UniqueId);
                return (AE_ERROR);
            }
            if ((Info->Valid & ACPI_VALID_CID) &&
                Info->CompatibleIdList.Count != ExpectedInfo[i].CidCount)
            {
                AapiErrors++;
                printf ("API Error: CidCount of %s (%d) != (%d)\n",
                    PathNames[2 * i + 1],
                    Info->CompatibleIdList.Count, ExpectedInfo[i].CidCount);
                return (AE_ERROR);
            }
        }

        AcpiOsFree(Info);
//        ReturnObjBuffer = ReturnBuffer;
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0040:
 *
 */
ACPI_STATUS
AtNSpaceTest0040(void)
{
    ACPI_STATUS             Status;

    Status = AtGetObjectInfoTypeCommon(
        EvPathNames0000,
        sizeof (EvPathNames0000) / sizeof (ACPI_STRING) / 2,
        AE_OK, TypesEvPathNames0000, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtGetObjectInfoTypeCommon(
        AeTypePathNames0000,
        sizeof (AeTypePathNames0000) / sizeof (ACPI_STRING) / 2,
        AE_OK, TypesAeTypePathNames0000, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtGetObjectInfoTypeCommon(
        TermalPathNames0000,
        sizeof (TermalPathNames0000) / sizeof (ACPI_STRING) / 2,
        AE_OK, TypesTermalPathNames0000, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtGetObjectInfoTypeCommon(
        DevicePathNames0000,
        sizeof (DevicePathNames0000) / sizeof (ACPI_STRING) / 2,
        AE_OK, TypesDevicePathNames0000, DeviceInfo0000));
}

ACPI_STATUS
AtGetObjectInfoException(
    ACPI_STATUS             ExpectedStatus,
    UINT32                  Action)
{
    ACPI_STATUS             Status;
    ACPI_STRING             Node = "\\D1L1.D2L0.D3L0.D4L_.D5L0";
    ACPI_DEVICE_INFO        *ReturnBuffer;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    if (Action == 3)
    {
        Node = "\\AUX2.SS00";
    }

    Status = AtGetObjectInfoCommon(
        Node, AE_BAD_PARAMETER, &ReturnBuffer, Action);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0041:
 *
 */
ACPI_STATUS
AtNSpaceTest0041(void)
{
    return (AtGetObjectInfoException(AE_BAD_PARAMETER, 3));
}

/*
 * ASSERTION 0042:
 *
 */
ACPI_STATUS
AtNSpaceTest0042(void)
{
    return (AtGetObjectInfoException(AE_BAD_PARAMETER, 4));
}

/*
 * ASSERTION 0043:
 *
 */
ACPI_STATUS
AtNSpaceTest0043(void)
{
    return (AtGetObjectInfoException(AE_BAD_PARAMETER, 1));
}

ACPI_STATUS
AtGetObjectInfoExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark,
    ACPI_STRING             ObjName)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  CtrlCheck = ALL_STAT;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_DEVICE_INFO        *ReturnBuffer;
    ACPI_HANDLE             ObjHandle;


    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtGetObjectInfoExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = AcpiGetHandle (NULL, ObjName, &ObjHandle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiGetHandle(NULL, %s) returned %s\n",
                ObjName, AcpiFormatException(Status));
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

        Status = AcpiGetObjectInfo (ObjHandle, &ReturnBuffer);

        if (!(OsxfNumAct = OsxfCtrlGetActOsxf(OsxfNum, 1)))
        {
            if (i == TFst)
            {
                TestSkipped++;
                printf ("Test note: test action hasn't occur\n");
            }
            TestPass++;
            Continue_Cond = 0;
            if (Status == AE_OK)
            {
                AcpiOsFree(ReturnBuffer);
            }
        }
        else
        {
            if (Status != Benchmark)
            {
                AapiErrors++;
                printf ("API Error: AcpiGetObjectInfo returned %s,\n"
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
 * ASSERTION 0044:
 */
ACPI_STATUS
AtNSpaceTest0044(void)
{
    ACPI_STATUS             Status;
    ACPI_STRING             Node = "\\D1L1.D2L0.D3L0.D4L_.D5L0";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtGetObjectInfoExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY, Node);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    return (AtGetObjectInfoExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY, Node));
}

ACPI_STATUS
AtGetNextObjectCommon(
    ACPI_OBJECT_TYPE        Type,
    ACPI_HANDLE             Parent,
    ACPI_HANDLE             Child,
    ACPI_STATUS             ExpectedStatus,
    ACPI_STRING             ExpectedName,
    UINT32                  CheckAction)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             OutHandle;

    switch (CheckAction)
    {
    case 1:
        /* Make Device handle invalid by unloading SSDT table*/
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
        break;
    default:
        break;
    }

    Status = AcpiGetNextObject (Type, Parent, Child, &OutHandle);

    if (Status != ExpectedStatus)
    {
        AapiErrors++;
        printf ("AtGetNextObjectCommon: AcpiGetNextObject(0x%x, 0x%p, 0x%p)"
            " returned %s, expected %s\n",
            Type, Parent, Child,
            AcpiFormatException(Status),
            AcpiFormatException(ExpectedStatus));
        return (AE_ERROR);
    }
    else if (Status != AE_OK)
    {
        return (AE_OK);
    }

    return (AtCheckName(OutHandle, ExpectedName));
}

ACPI_STATUS
AtGetNextObjectTypeCommon(
    ACPI_STRING             ParentName,
    ACPI_STRING             *StartNames,
    ACPI_STRING             *ExpectedNames,
    UINT32                  TypesCount)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Parent = NULL;
    ACPI_HANDLE             Child = NULL;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    if (TypesCount != sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE))
    {
        TestErrors++;
        printf ("AtGetNextObjectTypeCommon: different numbers of entities"
            "in TypesNames (%d) and LevelTypes0000 (%d)\n",
            TypesCount, sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE));
        return (AE_ERROR);
    }

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (ParentName)
    {
        Status = AcpiGetHandle (NULL, ParentName, &Parent);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("AtGetHandleCommon: AcpiGetHandle(NULL, %s) returned %s\n",
                ParentName, AcpiFormatException(Status));
            return (Status);
        }
    }

    for (i = 0; i < TypesCount; i++)
    {
        if (LevelTypes0000[i] == ACPI_TYPE_FIELD_UNIT &&
            AT_SKIP_ACPI_TYPE_FIELD_UNIT_CHECK)
        {
            printf ("AtGetHandleCommon: ACPI_TYPE_FIELD_UNIT check skipped\n");
            continue;
        }
        if (StartNames && StartNames[i]) {
            Status = AcpiGetHandle (NULL, StartNames[i], &Child);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("AtGetHandleCommon: AcpiGetHandle(NULL, %s) returned %s\n",
                    StartNames[i], AcpiFormatException(Status));
                return (Status);
            }
        }
        else
        {
            Child = NULL;
        }
        Status = AtGetNextObjectCommon(
            LevelTypes0000[i], Parent, Child,
            (ExpectedNames[i])? AE_OK: AE_NOT_FOUND, ExpectedNames[i], 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0045:
 *
 */
ACPI_STATUS
AtNSpaceTest0045(void)
{
    return (AtGetNextObjectTypeCommon(
        NULL, NULL,
        Level0TypeNames0000,
        sizeof (Level0TypeNames0000) / sizeof (ACPI_STRING)));
}

/*
 * ASSERTION 0046:
 *
 */
ACPI_STATUS
AtNSpaceTest0046(void)
{
    ACPI_STATUS             Status;

    Status = AtGetNextObjectTypeCommon(
        "\\D1L0", NULL,
        Level1TypeNames0000,
        sizeof (Level1TypeNames0000) / sizeof (ACPI_STRING));
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtGetNextObjectTypeCommon(
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0", NULL,
        LevelATypeNames0000,
        sizeof (LevelATypeNames0000) / sizeof (ACPI_STRING)));
}

/*
 * ASSERTION 0047:
 *
 */
ACPI_STATUS
AtNSpaceTest0047(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    for (i = 1; i < 5; i++)
    {
        Status = AtGetNextObjectTypeCommon(
            "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0",
            LevelATypeNamesArray0000[i - 1],
            LevelATypeNamesArray0000[i],
            sizeof (Level1TypeNames0000) / sizeof (ACPI_STRING));
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AE_OK);
}

ACPI_STATUS
AtGetNextObjectException(
    ACPI_OBJECT_TYPE        Type,
    ACPI_STRING             ParentName,
    ACPI_STRING             StartName,
    ACPI_STATUS             ExpectedStatus,
    UINT32                  Action)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Parent = NULL;
    ACPI_HANDLE             Child = NULL;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    if (Action == 1 && ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_LOAD)))
    {
        return (Status);
    }

    if (ParentName)
    {
        Status = AcpiGetHandle (NULL, ParentName, &Parent);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("AtGetHandleCommon: AcpiGetHandle(NULL, %s) returned %s\n",
                ParentName, AcpiFormatException(Status));
            return (Status);
        }
    }

    if (StartName) {
        Status = AcpiGetHandle (NULL, StartName, &Child);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("AtGetHandleCommon: AcpiGetHandle(NULL, %s) returned %s\n",
                StartName, AcpiFormatException(Status));
            return (Status);
        }
    }
    else
    {
        Child = NULL;
    }

    Status = AtGetNextObjectCommon(
        Type, Parent, Child,
        ExpectedStatus, NULL, Action);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0048:
 *
 */
ACPI_STATUS
AtNSpaceTest0048(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    for (i = 0; i < sizeof (Level1TypeNames0000) / sizeof (ACPI_STRING); i++)
    {
        Status = AtGetNextObjectException(
            LevelTypes0000[i],
            "\\AUX2",
            NULL,
            AE_BAD_PARAMETER, 1);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AE_OK);
}

static ACPI_STRING      SsdtTypeNames0000[] = {
    "\\AUX2.INT0",
    "\\AUX2.INT0",
    "\\AUX2.STR0",
    "\\AUX2.BUF0",
    "\\AUX2.PAC0",
    "\\AUX2.FLU0",
    "\\AUX2.DEV0",
    "\\AUX2.EVE0",
    "\\AUX2.MMM0",
    "\\AUX2.MTX0",
    "\\AUX2.OPR0",
    "\\AUX2.PWR0",
    "\\AUX2.CPU0",
    "\\AUX2.TZN0",
    "\\AUX2.BFL0",
};

/*
 * ASSERTION 0049:
 *
 */
ACPI_STATUS
AtNSpaceTest0049(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    for (i = 1; i < sizeof (Level1TypeNames0000) / sizeof (ACPI_STRING); i++)
    {
        Status = AtGetNextObjectException(
            LevelTypes0000[i],
            "\\AUX2",
            SsdtTypeNames0000[i],
            AE_BAD_PARAMETER, 1);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0050:
 *
 */
ACPI_STATUS
AtNSpaceTest0050(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    for (i = 0; i < sizeof (Level1TypeNames0000) / sizeof (ACPI_STRING); i++)
    {
        Status = AtGetNextObjectException(
            LevelTypes0000[i] + ACPI_TYPE_EXTERNAL_MAX + 1,
            "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0",
            LevelATypeNames0000[i],
            AE_BAD_PARAMETER, 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0051:
 *
 */
ACPI_STATUS
AtNSpaceTest0051(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    for (i = 1; i < sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE); i++)
    {
        Status = AtGetNextObjectException(
            LevelTypes0000[i],
            "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0",
            LevelATypeLastNames0000[i],
            AE_NOT_FOUND, 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0052:
 *
 */
ACPI_STATUS
AtNSpaceTest0052(void)
{
    ACPI_STATUS             Status;
    ACPI_STRING             ScopePath = PathName;
    char                    *ScopeEndDigit="0123456789ABCDE";
    UINT32                  i, n = strlen(ScopeEndDigit);

    for (i = 1; i < sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE); i++)
    {
        if (i >= n)
        {
            TestErrors++;
            printf ("Test Error: too many (%d) > (%d) test scopes\n",
                i + 1, n);
            return (AE_ERROR);
        }
        strcpy(ScopePath, "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0");
        PathName[strlen(ScopePath) - 1] = ScopeEndDigit[i];
        Status = AtGetNextObjectException(
            LevelTypes0000[i],
            ScopePath,
            NULL,
            AE_NOT_FOUND, 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AtGetNextObjectException(
            LevelTypes0000[0], /* ANY */
            "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DALZ",
            NULL,
            AE_NOT_FOUND, 0));
}

ACPI_STATUS
AtGetNextObjectExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark,
    ACPI_OBJECT_TYPE        Type,
    ACPI_STRING             ParentName,
    ACPI_STRING             StartName)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  CtrlCheck = ALL_STAT;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_HANDLE             Parent = NULL;
    ACPI_HANDLE             Child = NULL;
    ACPI_HANDLE             OutHandle;

    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtGetNextObjectExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (ParentName)
        {
            Status = AcpiGetHandle (NULL, ParentName, &Parent);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("API Error: AcpiGetHandle(NULL, %s) returned %s\n",
                    ParentName, AcpiFormatException(Status));
                return (Status);
            }
        }

        if (StartName) {
            Status = AcpiGetHandle (NULL, StartName, &Child);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("API Error: AcpiGetHandle(NULL, %s) returned %s\n",
                    StartName, AcpiFormatException(Status));
                return (Status);
            }
        }
        else
        {
            Child = NULL;
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

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: OsxfCtrlSet returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiGetNextObject (Type, Parent, Child, &OutHandle);

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
                printf ("API Error: AcpiGetNextObject returned %s,\n"
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
 * ASSERTION 0053:
 */
ACPI_STATUS
AtNSpaceTest0053(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    for (i = 0; i < sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE); i++)
    {
        Status = AtGetNextObjectExceptionTest(
            OSXF_NUM(AcpiOsAllocate),
            AtActD_Permanent, AtActRet_NULL, 1,
            AE_NO_MEMORY, LevelTypes0000[i],
            "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0",
            LevelATypeNames0000[i]);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    for (i = 0; i < sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE); i++)
    {
        Status = AtGetNextObjectExceptionTest(
            OSXF_NUM(AcpiOsAllocate),
            AtActD_OneTime, AtActRet_NULL, 1,
            AE_NO_MEMORY, LevelTypes0000[i],
            "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0",
            LevelATypeNames0000[i]);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AE_OK);
}

ACPI_STATUS
AtGetParentCommon(
    ACPI_STRING             ObjName,
    ACPI_STRING             Parent,
    ACPI_STATUS             ExpectedStatus,
    UINT32                  CheckAction)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             ObjHandle;
    ACPI_HANDLE             OutHandle, *OutHandlePointer = &OutHandle;


    Status = AcpiGetHandle (NULL, ObjName, &ObjHandle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("AtGetParentCommon: AcpiGetHandle(NULL, %s) returned %s\n",
            ObjName, AcpiFormatException(Status));
        return (Status);
    }

    switch (CheckAction)
    {
    case 1:
        /* Make Device handle invalid by unloading SSDT table*/
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
        break;
    case 2:
        OutHandlePointer = NULL;
        break;
    }

    Status = AcpiGetParent (ObjHandle, OutHandlePointer);

    if (Status != ExpectedStatus)
    {
        AapiErrors++;
        printf ("AtGetParentCommon: AcpiGetParent() returned %s,"
            " expected %s\n",
            AcpiFormatException(Status),
            AcpiFormatException(ExpectedStatus));
        return (AE_ERROR);
    }
    else if (Status != AE_OK)
    {
        return (AE_OK);
    }

    return (AtCheckName(OutHandle, Parent));
}

UINT32
AtCompareConsts(
    UINT32                  Value1,
    UINT32                  Value2)
{
    return (Value1 == Value2);
}

ACPI_STATUS
AtGetParentRawCommon(
    ACPI_STATUS             ExpectedStatus,
    UINT32                  CheckAction)
{
    ACPI_STATUS             Status;
    UINT32                  NamesCount = sizeof (PathNames0000) /
                                sizeof (ACPI_STRING) / 2;
    UINT32                  ValuesCount = sizeof (Values0000) /
                                sizeof (UINT32);
    ACPI_STRING             Parent;
    ACPI_STRING             Child;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    if (!AtCompareConsts(NamesCount, ValuesCount))
    {
        printf ("AtGetParentTypeCommon: different numbers of entities"
            "in PathNames0000 (%d) and Values0000 (%d)\n",
            NamesCount, ValuesCount);
        TestErrors++;
        return (AE_ERROR);
    }

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }
    for (i = 1; i < NamesCount; i++)
    {
        Parent = PathNames0000[2 * i];
        Child = PathName;
        strcpy(Child, PathNames0000[2 * i]);
        if (strlen(Child) > 1)
        {
            strcat(Child, ".");
        }
        strcat(Child, PathNames0000[2 * i + 1]);

        Status = AtGetParentCommon(Child, Parent,
            ExpectedStatus, CheckAction);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    Parent = "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0";
    for (i = 1; i < sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE); i++)
    {
        Status = AtGetParentCommon(LevelATypeNames0000[i], Parent,
            ExpectedStatus, CheckAction);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    Parent = "\\D1L0";
    for (i = 1; i < sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE); i++)
    {
        Status = AtGetParentCommon(Level1TypeNames0000[i], Parent,
            ExpectedStatus, CheckAction);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0054:
 *
 */
ACPI_STATUS
AtNSpaceTest0054(void)
{
    return (AtGetParentRawCommon(AE_OK, 0));
}

/*
 * ASSERTION 0055:
 *
 */
ACPI_STATUS
AtNSpaceTest0055(void)
{
    ACPI_STATUS             Status;
    ACPI_STRING             Parent = "\\AUX2";
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    for (i = 1; i < sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE); i++)
    {
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

        Status = AtGetParentCommon(SsdtTypeNames0000[i], Parent,
            AE_BAD_PARAMETER, 1);
        if (ACPI_FAILURE(Status))
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
 * ASSERTION 0056:
 *
 */
ACPI_STATUS
AtNSpaceTest0056(void)
{
    return (AtGetParentRawCommon(AE_BAD_PARAMETER, 2));
}

/*
 * ASSERTION 0057:
 *
 */
ACPI_STATUS
AtNSpaceTest0057(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    Status = AtGetParentCommon("\\", NULL, AE_NULL_ENTRY, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

ACPI_STATUS
AtGetParentExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark,
    ACPI_STRING             ObjName)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  CtrlCheck = ALL_STAT;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_HANDLE             ObjHandle;
    ACPI_HANDLE             OutHandle;

    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtGetParentExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = AcpiGetHandle (NULL, ObjName, &ObjHandle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetHandle(NULL, %s) returned %s\n",
                ObjName, AcpiFormatException(Status));
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

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: OsxfCtrlSet returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiGetParent (ObjHandle, &OutHandle);

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
                printf ("API Error: AcpiGetHandle returned %s,\n"
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
 * ASSERTION 0058:
 */
ACPI_STATUS
AtNSpaceTest0058(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtGetParentExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.L4__");
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    return (AtGetParentExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.L4__"));
}

ACPI_STATUS
AtGetTypeCommon(
    ACPI_STRING             ObjName,
    ACPI_OBJECT_TYPE        ExpectedType,
    ACPI_STATUS             ExpectedStatus,
    UINT32                  CheckAction)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             ObjHandle;
    ACPI_OBJECT_TYPE        RetType = 0, *RetTypePointer = &RetType;


    Status = AcpiGetHandle (NULL, ObjName, &ObjHandle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("AtGetTypeCommon: AcpiGetHandle(NULL, %s) returned %s\n",
            ObjName, AcpiFormatException(Status));
        return (Status);
    }

    switch (CheckAction)
    {
    case 1:
        /* Make Device handle invalid by unloading SSDT table*/
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
        break;
    case 2:
        RetTypePointer = NULL;
        break;
    }

    Status = AcpiGetType (ObjHandle, RetTypePointer);

    if (Status != ExpectedStatus)
    {
        AapiErrors++;
        printf ("AtGetTypeCommon: AcpiGetType() returned %s,"
            " expected %s\n",
            AcpiFormatException(Status),
            AcpiFormatException(ExpectedStatus));
        return (AE_ERROR);
    }
    else if (Status != AE_OK)
    {
        return (AE_OK);
    }

    if (RetType != ExpectedType)
    {
        AapiErrors++;
        printf ("AtGetTypeCommon: AcpiGetType() returned Type 0x%x,"
            " expected 0x%x\n",
            RetType, ExpectedType);
        return (AE_ERROR);
    }

    return (AE_OK);
}

ACPI_STATUS
AtGetTypeRawCommon(
    ACPI_STATUS             ExpectedStatus,
    UINT32                  CheckAction)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    for (i = 1; i < sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE); i++)
    {
        if (LevelTypes0000[i] == ACPI_TYPE_FIELD_UNIT &&
            AT_SKIP_ACPI_TYPE_FIELD_UNIT_CHECK)
        {
            printf ("AtGetTypeRawCommon: ACPI_TYPE_FIELD_UNIT check skipped\n");
            continue;
        }
        Status = AtGetTypeCommon(LevelATypeNames0000[i], LevelTypes0000[i],
            ExpectedStatus, CheckAction);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    for (i = 1; i < sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE); i++)
    {
        if (LevelTypes0000[i] == ACPI_TYPE_FIELD_UNIT &&
            AT_SKIP_ACPI_TYPE_FIELD_UNIT_CHECK)
        {
            printf ("AtGetTypeRawCommon: ACPI_TYPE_FIELD_UNIT check skipped\n");
            continue;
        }
        Status = AtGetTypeCommon(Level1TypeNames0000[i], LevelTypes0000[i],
            ExpectedStatus, CheckAction);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0059:
 *
 */
ACPI_STATUS
AtNSpaceTest0059(void)
{
    return (AtGetTypeRawCommon(AE_OK, 0));
}

/*
 * ASSERTION 0060:
 *
 */
ACPI_STATUS
AtNSpaceTest0060(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    for (i = 1; i < sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE); i++)
    {
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

        Status = AtGetTypeCommon(SsdtTypeNames0000[i], LevelTypes0000[i],
            AE_BAD_PARAMETER, 1);
        if (ACPI_FAILURE(Status))
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
 * ASSERTION 0061:
 *
 */
ACPI_STATUS
AtNSpaceTest0061(void)
{
    return (AtGetTypeRawCommon(AE_BAD_PARAMETER, 2));
}

ACPI_STATUS
AtGetTypeExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark,
    ACPI_STRING             ObjName)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  CtrlCheck = ALL_STAT;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_HANDLE             ObjHandle;
    ACPI_OBJECT_TYPE        OutType;

    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtResourceExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = AcpiGetHandle (NULL, ObjName, &ObjHandle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiGetHandle(NULL, %s) returned %s\n",
                ObjName, AcpiFormatException(Status));
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

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: OsxfCtrlSet returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiGetType (ObjHandle, &OutType);

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
                printf ("API Error: AcpiGetHandle returned %s,\n"
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
 * ASSERTION 0062:
 */
ACPI_STATUS
AtNSpaceTest0062(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    for (i = 1; i < sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE); i++)
    {
        Status = AtGetTypeExceptionTest(
            OSXF_NUM(AcpiOsAllocate),
            AtActD_Permanent, AtActRet_NULL, 1,
            AE_NO_MEMORY,
            LevelATypeNames0000[i]);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    for (i = 1; i < sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE); i++)
    {
        Status = AtGetTypeExceptionTest(
            OSXF_NUM(AcpiOsAllocate),
            AtActD_OneTime, AtActRet_NULL, 1,
            AE_NO_MEMORY,
            LevelATypeNames0000[i]);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }
    return (AE_OK);
}

/*******************************************************************************
 *
 * FUNCTION:    AtCheckHandlePathMapping
 *
 * PARAMETERS:  Handle          - Checked Object Parent's ACPI handle
 *              Pathname        - Checked Object ACPI Path
 *              Value           - Benchmark value
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Check that interpretation of the (Handle, Pathname) pair
 * of parameters in the AcpiGetHandle is aligned with the AcpiEvaluateObject
 * routine behavior.
 *
 ******************************************************************************/

static ACPI_STATUS
AtCheckHandlePathMapping(
    ACPI_HANDLE             Handle,
    ACPI_STRING             Pathname,
    ACPI_INTEGER            Value)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             Results;
    ACPI_OBJECT             Obj, *Object = &Obj;

    /* Initialize the return buffer structure */
    Results.Length = sizeof (Obj);
    Results.Pointer = Object;
    memset(Results.Pointer, 0, Results.Length);

    Status = AcpiEvaluateObject (Handle, Pathname, NULL, &Results);

    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiEvaluateObject(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    if (Obj.Type != 1)
    {
        AapiErrors++;
        printf ("API Error: Type of %s (%d) is not Integer (1)\n",
            Pathname, Obj.Type);
        Status = AE_ERROR;
    }
    else if (Obj.Integer.Value != Value)
    {
        AapiErrors++;
#ifdef    _MSC_VER
        printf ("API Error: Value of %s is 0x%I64x instead of expected 0x%I64x\n",
            Pathname, Obj.Integer.Value, Value);
#else
        printf ("API Error: Value of %s is 0x%llx instead of expected 0x%llx\n",
            Pathname, Obj.Integer.Value, Value);
#endif
        Status = AE_ERROR;
    }

    return (Status);
}

ACPI_STATUS
AtGetHandleCommon(
    ACPI_STRING             ScopePath,
    ACPI_STRING             ObjName,
    ACPI_STATUS             ExpectedStatus,
    UINT32                  ExpectedValue,
    UINT32                  CheckAction)
{
    ACPI_STATUS             Status;
    ACPI_STRING             Name = ObjName;
    ACPI_HANDLE             ScopeHandle = NULL;
    ACPI_HANDLE             OutHandle, *OutHandlePointer = &OutHandle;

    if (ScopePath && CheckAction != 6)
    {
        Status = AcpiGetHandle (NULL, ScopePath, &ScopeHandle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("AtGetHandleCommon: AcpiGetHandle(NULL, %s) returned %s\n",
                ScopePath, AcpiFormatException(Status));
            return (Status);
        }
    }

    switch (CheckAction)
    {
    case 1:
        Name = PathName;
        strcpy(Name, ObjName);
        Name[strlen(Name) - 1] = '&';
        break;
    case 2:
        Name = PathName;
        strcpy(Name, ObjName);
        Name[strlen(Name) + 1] = '\0';
        Name[strlen(Name)] = '_';
        break;
    case 8:
        Name = PathName;
        strcpy(Name, ObjName);
        Name[strlen(Name) - 1] = '\0';
        break;
    case 3:
        Name = NULL;
        break;
    case 4:
        if (ScopeHandle == NULL)
        {
            TestErrors++;
            printf ("AtGetHandleCommon: ScopeHandle == NULL\n");
            return (AE_ERROR);
        }
        ScopeHandle = NULL;
        break;
    case 5:
        OutHandlePointer = NULL;
        break;
    case 6:
        /* Make namespace having not been loaded by Subsystem shutdown */
        Status = AcpiTerminate();
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("AtGetHandleCommon: AcpiTerminate() failure, %s\n",
                AcpiFormatException(Status));
            return (Status);
        }
        Name = PathName;
        strcpy(Name, ScopePath);
        strcat(Name, ".");
        strcat(Name, ObjName);
        break;
    case 7:
        /* Make Device handle invalid by unloading SSDT table*/
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
        break;
    }

    Status = AcpiGetHandle (ScopeHandle, Name, OutHandlePointer);

    if (Status != ExpectedStatus)
    {
        AapiErrors++;
        printf ("AtGetHandleCommon: AcpiGetHandle(%s) returned %s,"
            " expected %s\n",
            Name,
            AcpiFormatException(Status),
            AcpiFormatException(ExpectedStatus));
        return (AE_ERROR);
    }
    else if (Status != AE_OK)
    {
        return (AE_OK);
    }

    Status = AtCheckInteger(OutHandle, Name, ExpectedValue);
    if (ACPI_FAILURE(Status)) {
        return (Status);
    }

    /* Check that interpretation of (Handle, Name) pair of parameters
     * is aligned with AcpiEvaluateObject behavior
     */
    return (AtCheckHandlePathMapping(ScopeHandle, Name, ExpectedValue));
}

ACPI_STATUS
AtGetHandleTypeCommon(UINT32 AbsolutePathFlag)
{
    ACPI_STATUS             Status;
    ACPI_STATUS             EXpectedStatus;
    UINT32                  NamesCount = sizeof (PathNames0000) /
                                sizeof (ACPI_STRING) / 2;
    UINT32                  ValuesCount = sizeof (Values0000) /
                                sizeof (UINT32);
    ACPI_STRING             Parent;
    ACPI_STRING             Child;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    if (!AtCompareConsts(NamesCount, ValuesCount))
    {
        TestErrors++;
        printf ("AtGetHandleTypeCommon: different numbers of entities"
            "in PathNames0000 (%d) and Values0000 (%d)\n",
            NamesCount, ValuesCount);
        return (AE_ERROR);
    }

    for (i = 1; i < NamesCount; i++)
    {
        strcpy(PathName, PathNames0000[2 * i]);
        if (strlen(PathName) > 1)
        {
            strcat(PathName, ".");
        }
        strcat(PathName, PathNames0000[2 * i + 1]);
        if (AbsolutePathFlag)
        {
            Parent = NULL;
            Child = PathName;
        }
        else
        {
            Parent = PathNames0000[2 * i];
            Child = PathNames0000[2 * i + 1];
        }
        Status = AtGetHandleCommon(
            Parent, Child,
            AE_OK, Values0000[i], 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (AbsolutePathFlag)
        {
            EXpectedStatus = (AT_ABS_PATH_WOUT_SLASH)? AE_OK: AE_BAD_PARAMETER;
            Status = AtGetHandleCommon(
                Parent, Child + 1,
                EXpectedStatus, Values0000[i], 0);
            if (ACPI_FAILURE(Status))
            {
                return (Status);
            }
        }

        /* Not NULL Parent and Absolute Path */
        if (!AbsolutePathFlag)
        {
            Status = AtGetHandleCommon(
                Parent, PathName,
                AE_OK, Values0000[i], 0);
            if (ACPI_FAILURE(Status))
            {
                return (Status);
            }
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0063:
 *
 */
ACPI_STATUS
AtNSpaceTest0063(void)
{
    return (AtGetHandleTypeCommon(1));
}

/*
 * ASSERTION 0064:
 *
 */
ACPI_STATUS
AtNSpaceTest0064(void)
{
    return (AtGetHandleTypeCommon(0));
}

ACPI_STATUS
AtGetHandleExceptionCommon(
    UINT32                  CheckAction,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    UINT32                  ExpectedValue = 0x154; /* D5L0.L4 */

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    if (CheckAction == 4) {
        ExpectedValue = 4; /* value of \L4__ */
    }
    Status = AtGetHandleCommon(
        "\\D1L1.D2L0.D3L0.D4L_.D5L0", "L4__",
        ExpectedStatus, ExpectedValue, CheckAction);

    if (ACPI_FAILURE(Status) || CheckAction == 6)
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0065:
 *
 */
ACPI_STATUS
AtNSpaceTest0065(void)
{
    return (AtGetHandleExceptionCommon(1, AE_BAD_CHARACTER));
}

/*
 * ASSERTION 0066:
 *
 */
ACPI_STATUS
AtNSpaceTest0066(void)
{
    return (AtGetHandleExceptionCommon(2, AE_BAD_PATHNAME));
}

/*
 * ASSERTION 0067:
 *
 */
ACPI_STATUS
AtNSpaceTest0067(void)
{
    return (AtGetHandleExceptionCommon(3, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0068:
 *
 */
ACPI_STATUS
AtNSpaceTest0068(void)
{
    return (AtGetHandleExceptionCommon(4, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0069:
 *
 */
ACPI_STATUS
AtNSpaceTest0069(void)
{
    return (AtGetHandleExceptionCommon(5, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0070:
 *
 */
ACPI_STATUS
AtNSpaceTest0070(void)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             OutHandle;

    Status = AtSubsystemInit(AAPITS_INITIALIZE_SS, 0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetHandle (NULL, "\\D1L1.D2L0.D3L0.D4L_.D5L0.L4__", &OutHandle);

    if (Status != AE_NO_NAMESPACE)
    {
        AapiErrors++;
        printf ("AtGetHandleCommon: AcpiGetHandle() returned %s,"
            " expected %s\n",
            AcpiFormatException(Status),
            AcpiFormatException(AE_NO_NAMESPACE));
        return (AE_ERROR);
    }

    return (AE_OK);
/*
    return (AtGetHandleExceptionCommon(6, AE_NO_NAMESPACE));
*/
}

/*
 * ASSERTION 0071:
 *
 */
ACPI_STATUS
AtNSpaceTest0071(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    Status = AtGetHandleCommon(
        "\\D1L1.D2L0.D3L0.D4L_.D5L0", "L5__",
        AE_NOT_FOUND, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtGetHandleCommon(
        NULL, "\\D1L2.D2L0.D3L0.D4L_.D5L0.L4__",
        AE_NOT_FOUND, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtGetHandleCommon(
        NULL, "\\D1L1.D2L1.D3L1.D4L_.D5L0.L4__",
        AE_NOT_FOUND, 0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

ACPI_STATUS
AtGetHandleExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark,
    ACPI_STRING             ScopePath,
    ACPI_STRING             ObjName)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  CtrlCheck = ALL_STAT;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_STRING             Name = ObjName;
    ACPI_HANDLE             ScopeHandle;
    ACPI_HANDLE             OutHandle;

    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtResourceExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (ScopePath)
        {
            Status = AcpiGetHandle (NULL, ScopePath, &ScopeHandle);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("API error: AcpiGetHandle(NULL, %s)"
                    " returned %s\n",
                    ScopePath, AcpiFormatException(Status));
                return (Status);
            }
        }
        else
        {
            ScopeHandle = NULL;
        }

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: OsxfCtrlSet returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiGetHandle (ScopeHandle, Name, &OutHandle);

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
                printf ("API Error: AcpiGetHandle returned %s,\n"
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
 * ASSERTION 0072:
 */
ACPI_STATUS
AtNSpaceTest0072(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */

    Status = AtGetHandleExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0", "L4__");
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtGetHandleExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        NULL, "\\D1L1.D2L0.D3L0.D4L_.D5L0.L4__");
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */

    Status = AtGetHandleExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0", "L4__");
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtGetHandleExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        NULL, "\\D1L1.D2L0.D3L0.D4L_.D5L0.L4__"));
}

/*
 * ASSERTION 0073:
 */
ACPI_STATUS
AtNSpaceTest0073(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    Status = AtGetHandleCommon(
        "\\", "^N0L0",
        AE_NOT_FOUND, 0, 0);

    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

ACPI_STATUS
AtGetNameCommon(
    ACPI_STRING             ScopePath,
    ACPI_STRING             Name,
    UINT32                  NameType,
    ACPI_SIZE               AllocLength,
    ACPI_STATUS             ExpectedStatus,
    UINT32                  CheckAction)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             ScopeHandle = NULL;
    ACPI_HANDLE             OutHandle;
    ACPI_BUFFER             OutName, *OutNamePointer = &OutName;
    UINT32                  ScopeLength = strlen(ScopePath);
    UINT32                  CheckLength = strlen(Name);
    ACPI_STRING             CheckName;

    if (ScopeLength)
    {
        Status = AcpiGetHandle (NULL, ScopePath, &ScopeHandle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("AtGetNameCommon: AcpiGetHandle(NULL, %s)"
                " returned %s\n",
                ScopePath, AcpiFormatException(Status));
            return (Status);
        }
    }

    Status = AcpiGetHandle (ScopeHandle, Name, &OutHandle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("AtGetNameCommon: AcpiGetHandle(Scope, \"%s\")"
            "returned %s\n",
            Name, AcpiFormatException(Status));
        return (Status);
    }

    OutName.Length = AllocLength;
    if (AllocLength == ACPI_ALLOCATE_BUFFER)
    {
        OutName.Pointer = NULL;
    }
    else
    {
        OutName.Pointer = AcpiOsAllocate(OutName.Length);
        if (OutName.Pointer == NULL)
        {
            AapiErrors++;
            printf ("AtGetNameCommon: ReturnBuffer(%d) returned NULL\n",
                (UINT32)OutName.Length);
            return (AE_ERROR);
        }
    }

    if (NameType == ACPI_FULL_PATHNAME)
    {
        CheckLength += (ScopeLength + (ScopeLength > 1));
    }

    switch (CheckAction)
    {
    case 1:
        /* Make Device handle invalid by unloading SSDT table*/
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
    case 2:
        OutNamePointer = NULL;
        break;
    case 3:
        OutName.Pointer = NULL;
        OutName.Length = 1;
        break;
    case 4:
        OutName.Pointer = OutNamePointer;
        OutName.Length = 1;
        break;
    case 5:
        /* Make namespace having not been loaded by Subsystem shutdown */
        Status = AcpiTerminate();
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("AtGetNameCommon: AcpiTerminate() failure, %s\n",
                AcpiFormatException(Status));
            return (Status);
        }
        break;
    }

    Status = AcpiGetName (OutHandle, NameType, OutNamePointer);

    if (Status != ExpectedStatus)
    {
        AapiErrors++;
        printf ("AtGetNameCommon: AcpiGetName(0x%x) returned %s,"
            " expected %s\n", NameType,
            AcpiFormatException(Status),
            AcpiFormatException(ExpectedStatus));
        return (AE_ERROR);
    }
    else if (Status != AE_OK)
    {
        if (!(AllocLength == ACPI_ALLOCATE_BUFFER))
        {
            AcpiOsFree(OutName.Pointer);
        }
        if (CheckAction == 4 &&
            OutName.Length != CheckLength + 1)
        {
            AapiErrors++;
            printf ("AtGetNameCommon: AcpiGetName() returned invalid"
                " OutName.Length %d, expected %d\n",
                (UINT32)OutName.Length, CheckLength + 1);
            return (AE_ERROR);
        }

        return (AE_OK);
    }
    else if ((AllocLength == ACPI_ALLOCATE_BUFFER &&
            (strlen(OutName.Pointer) + 1) != OutName.Length) ||
            OutName.Length != CheckLength + 1)
    {
        AapiErrors++;
        printf ("AtGetNameCommon: AcpiGetName(0x%x) returned invalid"
            "  OutName, strlen %d, OutName.Length %d\n", NameType,
            (UINT32)strlen(OutName.Pointer), (UINT32)OutName.Length);
    }
    else
    {
        CheckName = OutName.Pointer;

        if (NameType == ACPI_FULL_PATHNAME)
        {
            if (strncmp(CheckName, ScopePath, ScopeLength))
            {
                AapiErrors++;
                printf ("AtGetNameCommon: AcpiGetName() returned Name %s,"
                    " expected %s\n",
                    CheckName, ScopePath);
            }
            CheckName += ScopeLength;
            if (ScopeLength > 1)
            {
                if (*CheckName != '.')
                {
                    AapiErrors++;
                    printf ("AtGetNameCommon: AcpiGetName() returned Name"
                        " delimeter '%c', expected '.'\n",
                        *CheckName);
                }
                CheckName += 1;
            }
        }

        if (strcmp(CheckName, Name))
        {
            AapiErrors++;
            printf ("AtGetNameCommon: AcpiGetName() returned Name '%s',"
                " expected '%s'\n",
                CheckName, Name);
        }
    }
    AcpiOsFree(OutName.Pointer);

    return (AE_OK);
}

ACPI_STATUS
AtGetNameTypeCommon(UINT32 NameType)
{
    ACPI_STATUS             Status;
    UINT32                  NamesCount;
    UINT32                  i;
    UINT32                  BufferLength;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    NamesCount = sizeof (PathNames0000) / sizeof (ACPI_STRING) / 2;

    for (i = 0; i < NamesCount; i++)
    {
        Status = AtGetNameCommon(
            PathNames0000[2 * i],
            PathNames0000[2 * i + 1],
            NameType,
            ACPI_ALLOCATE_BUFFER,
            AE_OK, 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        BufferLength = strlen(PathNames0000[2 * i + 1]) + 1;
        if (NameType == ACPI_FULL_PATHNAME)
        {
            BufferLength += (strlen(PathNames0000[2 * i]) +
                (strlen(PathNames0000[2 * i]) > 1));
        }

        Status = AtGetNameCommon(
            PathNames0000[2 * i],
            PathNames0000[2 * i + 1],
            NameType,
            BufferLength,
            AE_OK, 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    if (NameType == ACPI_FULL_PATHNAME)
    {
        Status = AtGetNameCommon(
            "", "\\",
            NameType,
            5,
            AE_OK, 0);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0074:
 *
 */
ACPI_STATUS
AtNSpaceTest0074(void)
{
    return (AtGetNameTypeCommon(ACPI_FULL_PATHNAME));
}

/*
 * ASSERTION 0075:
 *
 */
ACPI_STATUS
AtNSpaceTest0075(void)
{
    return (AtGetNameTypeCommon(ACPI_SINGLE_NAME));
}

ACPI_STATUS
AtGetNameExceptionCommon(
    UINT32                  CheckAction,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    ACPI_STRING             ScopePath = "\\D1L1.D2L0.D3L0.D4L_.D5L0";
    ACPI_STRING             Name = "L4__";

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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
        ScopePath = "\\AUX2";
        Name = "SS00";
    }

    Status = AtGetNameCommon(
        ScopePath, Name,
        ACPI_FULL_PATHNAME,
        ACPI_ALLOCATE_BUFFER,
        ExpectedStatus, CheckAction);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0076:
 *
 */
ACPI_STATUS
AtNSpaceTest0076(void)
{
    return (AtGetNameExceptionCommon(1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0077:
 *
 */
ACPI_STATUS
AtNSpaceTest0077(void)
{
    return (AtGetNameExceptionCommon(2, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0078:
 *
 */
ACPI_STATUS
AtNSpaceTest0078(void)
{
    return (AtGetNameExceptionCommon(3, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0079:
 *
 */
ACPI_STATUS
AtNSpaceTest0079(void)
{
    return (AtGetNameExceptionCommon(4, AE_BUFFER_OVERFLOW));
}

/*
 * ASSERTION 0080:
 *
 */
ACPI_STATUS
AtNSpaceTest0080(void)
{
    return (AtGetNameExceptionCommon(5, AE_NO_NAMESPACE));
}

ACPI_STATUS
AtGetNameExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark,
    ACPI_STRING             ScopePath,
    ACPI_STRING             Name,
    UINT32                  NameType,
    ACPI_SIZE               AllocLength)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_HANDLE             ScopeHandle;
    ACPI_HANDLE             OutHandle;
    ACPI_BUFFER             OutName, *OutNamePointer = &OutName;


    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtGetNameExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = AcpiGetHandle (NULL, ScopePath, &ScopeHandle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetHandle(NULL, %s) returned %s\n",
                ScopePath, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiGetHandle (ScopeHandle, Name, &OutHandle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetHandle(Scope, %s) returned %s\n",
                Name, AcpiFormatException(Status));
            return (Status);
        }

        OutName.Length = AllocLength;
        if (AllocLength == ACPI_ALLOCATE_BUFFER)
        {
            OutName.Pointer = NULL;
        }
        else
        {
            OutName.Pointer = AcpiOsAllocate(OutName.Length);
            if (OutName.Pointer == NULL)
            {
                AapiErrors++;
                printf ("API Error: AcpiOsAllocate(%d) returned NULL\n",
                    OutName.Length);
                return (AE_ERROR);
            }
        }

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: OsxfCtrlSet returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }


        Status = AcpiGetName (OutHandle, NameType, OutNamePointer);

        if (!(AllocLength == ACPI_ALLOCATE_BUFFER) ||
            Status == AE_OK)
        {
            AcpiOsFree(OutName.Pointer);
        }

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
                printf ("API Error: AcpiGetName returned %s,\n"
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
 * ASSERTION 0081:
 */
ACPI_STATUS
AtNSpaceTest0081(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */

    Status = AtGetNameExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0", "L4__",
        ACPI_FULL_PATHNAME,
        ACPI_ALLOCATE_BUFFER);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtGetNameExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0", "L4__",
        ACPI_FULL_PATHNAME,
        31);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */

    Status = AtGetNameExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0", "L4__",
        ACPI_FULL_PATHNAME,
        ACPI_ALLOCATE_BUFFER);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtGetNameExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0", "L4__",
        ACPI_FULL_PATHNAME,
        31));
}

static UINT32               GetDevicesHandlerCounter;
static UINT32               GetDevicesHandlerReturnValue;
static AT_WALK_HANDLER_CONTEXT    GetDevicesHandlerContext;

ACPI_STATUS
AtGetDevicesHandler (
    ACPI_HANDLE             ObjHandle,
    UINT32                  NestingLevel,
    void                    *Context,
    void                    **ReturnValue)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutName = {AT_PATHNAME_MAX, PathName};
    UINT32                  i;

    ++GetDevicesHandlerCounter;

    Status = AcpiGetName (ObjHandle, ACPI_FULL_PATHNAME, &OutName);

    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiGetName(0x%p) returned %s\n",
            ObjHandle, AcpiFormatException(Status));
        strcpy(PathName, "????");
    }
/*
    printf ("AtGetDevicesHandler %.2d: (%s) ObjHandle %p, Level %d, Context %p\n",
        GetDevicesHandlerCounter, PathName, ObjHandle, NestingLevel, Context);
*/
    if (Context != &GetDevicesHandlerContext) {
        AapiErrors++;
        printf ("AtGetDevicesHandler: Context (%p) !="
            " &GetDevicesHandlerContext (%p)\n",
            Context, &GetDevicesHandlerContext);
    }

    if (*ReturnValue != &GetDevicesHandlerReturnValue) {
        AapiErrors++;
        printf ("AtGetDevicesHandler: *ReturnValue (%p) !="
            " &GetDevicesHandlerReturnValue (%p)\n",
            *ReturnValue, &GetDevicesHandlerReturnValue);
    }

    for (i = 0; i < GetDevicesHandlerContext.InfoCounter; i++)
    {
        if (strcmp(GetDevicesHandlerContext.WalkInfo[i].PathName, PathName) == 0)
        {
            GetDevicesHandlerContext.WalkInfo[i].WalkCount++;
            GetDevicesHandlerContext.WalkInfo[i].XfNestingLevel = NestingLevel;
            GetDevicesHandlerContext.WalkInfo[i].HandlerCount = GetDevicesHandlerCounter;
            break;
        }
    }

    if (GetDevicesHandlerCounter == GetDevicesHandlerContext.ActionCounter) {
        return (GetDevicesHandlerContext.RetVal);
    }

    return (AE_OK);
}

ACPI_STATUS
AtGetDevicesCommon(
    char                    *HID,
    ACPI_STATUS             ExpectedStatus,
    UINT32                  GetDevicesHandlerRet,
    UINT32                  ActionCounter,
    UINT32                  ExpectedCounter,
    AT_WALK_INFO            *DeviceWalkInfo)
{
    ACPI_STATUS             Status;
    UINT32                  *ReturnValue = &GetDevicesHandlerReturnValue;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    GetDevicesHandlerCounter = 0;
    GetDevicesHandlerContext.RetVal = GetDevicesHandlerRet;
    GetDevicesHandlerContext.InfoCounter = ExpectedCounter;
    GetDevicesHandlerContext.WalkInfo = DeviceWalkInfo;
    GetDevicesHandlerContext.ActionCounter = ActionCounter;

    Status = AcpiGetDevices (
        HID, AtGetDevicesHandler,
        &GetDevicesHandlerContext, (void **)&ReturnValue);
    if (Status != ExpectedStatus)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetDevices(%s) returned %s,"
            " expected %s\n",
            (HID)? HID: "NULL",
            AcpiFormatException(Status), AcpiFormatException(ExpectedStatus));
        return (Status);
    }

    if (GetDevicesHandlerCounter != ExpectedCounter)
    {
        AapiErrors++;
        printf ("Api Error: GetDevicesHandlerCounter (%d) !="
            "ExpectedCounter (%d)\n",
            GetDevicesHandlerCounter, ExpectedCounter);
        return (AE_ERROR);
    }

    for (i = 0; i < ExpectedCounter; i++)
    {
        if (DeviceWalkInfo[i].WalkCount == 0)
        {
            AapiErrors++;
            printf ("Api Error: Device '%s' is not met\n",
                DeviceWalkInfo[i].PathName);
        }
        else if (DeviceWalkInfo[i].WalkCount > 1)
        {
            AapiErrors++;
            printf ("Api Error: Device '%s' is met more than once (%d)\n",
                DeviceWalkInfo[i].PathName, DeviceWalkInfo[i].WalkCount);
        }
        else if (DeviceWalkInfo[i].XfNestingLevel != DeviceWalkInfo[i].NestingLevel)
        {
            AapiErrors++;
            printf ("Api Error: NestingLevel of Device '%s' (%d)"
                " is expected to be %d\n",
                DeviceWalkInfo[i].PathName,
                DeviceWalkInfo[i].XfNestingLevel, DeviceWalkInfo[i].NestingLevel);
        }
        else if (DeviceWalkInfo[i].HandlerCount != i + 1)
        {
            AapiErrors++;
            printf ("Api Error: depth-first rule is violated for %s,"
                " the walked number (%d) is expected to be %d\n",
                DeviceWalkInfo[i].PathName,
                DeviceWalkInfo[i].HandlerCount, i + 1);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0082:
 */
ACPI_STATUS
AtNSpaceTest0082(void)
{
    ACPI_STATUS             Status;

    Status = AtGetDevicesCommon("PNP0A05", AE_OK, AE_OK,
        sizeof (DeviceWalkInfoDev5) / sizeof (AT_WALK_INFO) + 1,
        sizeof (DeviceWalkInfoDev5) / sizeof (AT_WALK_INFO),
        DeviceWalkInfoDev5);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtGetDevicesCommon("PCI\\VEN_ffff&DEV_dddd&SUBSYS_cccccccc&REV_01", AE_OK, AE_OK,
        sizeof (DeviceWalkInfoDev7) / sizeof (AT_WALK_INFO) + 1,
        sizeof (DeviceWalkInfoDev7) / sizeof (AT_WALK_INFO),
        DeviceWalkInfoDev7);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtGetDevicesCommon("PNP0A04", AE_OK, AE_OK,
        sizeof (DeviceWalkInfo2Dev) / sizeof (AT_WALK_INFO) + 1,
        sizeof (DeviceWalkInfo2Dev) / sizeof (AT_WALK_INFO),
        DeviceWalkInfo2Dev);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0083:
 */
ACPI_STATUS
AtNSpaceTest0083(void)
{
    ACPI_STATUS             Status;

    Status = AtGetDevicesCommon("PNP0A04", AE_OK, AE_CTRL_DEPTH,
        1,
        1,
        DeviceWalkInfo2Dev);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0084:
 */
ACPI_STATUS
AtNSpaceTest0084(void)
{
    ACPI_STATUS             Status;

    Status = AtGetDevicesCommon("PNP0A04", AE_OK, AE_CTRL_TERMINATE,
        1,
        1,
        DeviceWalkInfo2Dev);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0085:
 */
ACPI_STATUS
AtNSpaceTest0085(void)
{
    ACPI_STATUS             Status;

    Status = AtGetDevicesCommon("PNP0A04", AE_ERROR, AE_ERROR,
        1,
        1,
        DeviceWalkInfo2Dev);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0086:
 */
ACPI_STATUS
AtNSpaceTest0086(void)
{
    ACPI_STATUS             Status;

    Status = AtGetDevicesCommon(NULL, AE_OK, AE_OK,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO) + 1,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO),
        DeviceWalkInfo0000);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtGetDevicesCommon(NULL, AE_OK, AE_CTRL_DEPTH,
        9,
        sizeof (DeviceWalkInfoDepth) / sizeof (AT_WALK_INFO),
        DeviceWalkInfoDepth);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtGetDevicesCommon(NULL, AE_OK, AE_CTRL_TERMINATE,
        sizeof (DeviceWalkInfoTerminate) / sizeof (AT_WALK_INFO),
        sizeof (DeviceWalkInfoTerminate) / sizeof (AT_WALK_INFO),
        DeviceWalkInfoTerminate);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtGetDevicesCommon(NULL, AE_ERROR, AE_ERROR,
        sizeof (DeviceWalkInfoError) / sizeof (AT_WALK_INFO),
        sizeof (DeviceWalkInfoError) / sizeof (AT_WALK_INFO),
        DeviceWalkInfoError);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0087:
 */
ACPI_STATUS
AtNSpaceTest0087(void)
{
    ACPI_STATUS             Status;
    UINT32                  *ReturnValue = &GetDevicesHandlerReturnValue;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    Status = AcpiGetDevices (
        "PNP0A04", NULL,
        &GetDevicesHandlerContext, (void **)&ReturnValue);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetDevices( , NULL) returned %s,"
            " expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

ACPI_STATUS
AtGetDevicesExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark,
    char                    *HID,
    UINT32                  GetDevicesHandlerRet,
    UINT32                  ActionCounter,
    UINT32                  ExpectedCounter,
    AT_WALK_INFO     *DeviceWalkInfo)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  TMax = 10000;
    UINT32                  i;
    UINT32                  *ReturnValue = &GetDevicesHandlerReturnValue;


    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtGetDevicesExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
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

        GetDevicesHandlerCounter = 0;
        GetDevicesHandlerContext.RetVal = GetDevicesHandlerRet;
        GetDevicesHandlerContext.InfoCounter = ExpectedCounter;
        GetDevicesHandlerContext.WalkInfo = DeviceWalkInfo;
        GetDevicesHandlerContext.ActionCounter = ActionCounter;

        Status = AcpiGetDevices (
            HID, AtGetDevicesHandler,
            &GetDevicesHandlerContext, (void **)&ReturnValue);

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
                printf ("API Error: AcpiGetDevices returned %s,\n"
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
 * ASSERTION 0088:
 */
ACPI_STATUS
AtNSpaceTest0088(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */

    Status = AtGetDevicesExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "PNP0A05", AE_OK,
        sizeof (DeviceWalkInfoDev5) / sizeof (AT_WALK_INFO) + 1,
        sizeof (DeviceWalkInfoDev5) / sizeof (AT_WALK_INFO),
        DeviceWalkInfoDev5);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtGetDevicesExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        NULL, AE_OK,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO) + 1,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO),
        DeviceWalkInfo0000);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */

    Status = AtGetDevicesExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "PNP0A05", AE_OK,
        sizeof (DeviceWalkInfoDev5) / sizeof (AT_WALK_INFO) + 1,
        sizeof (DeviceWalkInfoDev5) / sizeof (AT_WALK_INFO),
        DeviceWalkInfoDev5);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AtGetDevicesExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        NULL, AE_OK,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO) + 1,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO),
        DeviceWalkInfo0000));
}

static UINT32               AttachDataCounter[3];
static AT_ATTACH_DATA_STAT  AttachDataStat[3][MAX_ATTACH_DATA_STAT];
static UINT8                DataBuffer[3] = {0, 1, 2};

#define DEF_ATTACH_DATA_HANDLER(Hid) \
void \
AttachDataHandler##Hid( \
    ACPI_HANDLE             Object, \
    void                    *Data) \
{ \
    UINT32                  HandlerId = Hid; \
    UINT32                  i; \
    AT_ATTACH_DATA_STAT     *Stat = AttachDataStat[HandlerId]; \
 \
    if ((i = AttachDataCounter[HandlerId]++) < MAX_ATTACH_DATA_STAT) \
    { \
        Stat[i].Object = Object; \
        Stat[i].Data = Data; \
    } \
    printf ("AttachDataHandler%d %d: Object 0x%p, Data  0x%p\n", \
            Hid, i, Object, Data); \
    if (Hid == 1) \
    { \
        AcpiDetachData(Object, AttachDataHandler##Hid); \
    } \
}

DEF_ATTACH_DATA_HANDLER(0)
DEF_ATTACH_DATA_HANDLER(1)
DEF_ATTACH_DATA_HANDLER(2)


/*
 * Release GlobalLock concurrently
 */
void ACPI_SYSTEM_XFACE
AtConcurrentMethodCall(void * Context)
{
    ACPI_STATUS             Status;
    ACPI_STRING             Pathname = (ACPI_STRING)Context;

    /* Call a Method, creating an Object and blocking */
    Status = AcpiEvaluateObject (NULL, Pathname,
        NULL, NULL);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiEvaluateObject(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
    }

    return;
}

ACPI_STATUS
AtAttachDataCommon(
    UINT32                  UnloadFlag,
    UINT32                  NumNm,
    ACPI_STRING             Pathnames[],
    UINT32                  NumId,
    UINT32                  HandleId[],
    void                    *Data[],
    ACPI_OBJECT_HANDLER     Handlers[],
    UINT32                  HandlerId[],
    ACPI_STATUS             ExpectedStatus[])
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             *Objects;
    AT_ATTACH_DATA_STAT     *Stat;
//    UINT32                  Function = ACPI_NS_NODE_DEL;
    UINT32                  i, j, ExpectedCounter;

    if (NumId > 3)
    {
        TestErrors++;
        printf ("Test Error: NumId (%d) > 3\n", NumId);
        return (AE_ERROR);
    }

    Objects = (ACPI_HANDLE *) malloc(NumNm * sizeof (ACPI_HANDLE));
    if (!Objects)
    {
        TestErrors++;
        printf ("Test Error: no memory for Objects\n");
        return (AE_ERROR);
    }

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    if ((UnloadFlag == 1) || (UnloadFlag == 2))
    {
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_LOAD)))
        {
            return (Status);
        }
    }

    /* Attach to a dynamic Object*/
    if ((UnloadFlag == 3) || (UnloadFlag == 4))
    {
        /* Call a Method, creating an Object and blocking */
        Status = AcpiOsExecute(OSL_GPE_HANDLER, AtConcurrentMethodCall,
            (UnloadFlag == 3)? "\\BLK0": "\\BLK1");
        if (ACPI_FAILURE (Status))
        {
            printf ("API error: AcpiOsExecute() returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }
        AcpiOsSleep(1000);
    }

    for (i = 0; i < NumNm; i++)
    {
        Status = AcpiGetHandle (NULL, Pathnames[i], &Objects[i]);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                Pathnames[i], AcpiFormatException(Status));
            return (Status);
        }
    }

    if (UnloadFlag == 2)
    {
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
    }

    for (i = 0; i < NumId; i++)
    {
        Status = AcpiAttachData(Objects[HandleId[i]], Handlers[i], Data[i]);

        if (Status != ExpectedStatus[i])
        {
            AapiErrors++;
            printf ("API error: AcpiAttachData(%s) returned %s,"
                " expected %s\n",
                Pathnames[HandleId[i]],
                AcpiFormatException(Status),
                AcpiFormatException(ExpectedStatus[i]));
            return (AE_ERROR);
        }
    }

    for (i = 0; i < NumId; i++)
    {
        if (HandlerId[i] > 2)
        {
            TestErrors++;
            printf ("Test Error: HandlerId[%d] (%d) > 2\n", i, HandlerId[i]);
            return (AE_ERROR);
        }
        if (AttachDataCounter[HandlerId[i]] != 0)
        {
            AapiErrors++;
            printf ("API Error: unexpectedly AttachDataCounter[%d] (%d) != 0\n",
                HandlerId[i], AttachDataCounter[HandlerId[i]]);
            return (AE_ERROR);
        }
    }

    if (UnloadFlag == 1)
    {
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
    }

    /* Initiate deletion of the dynamic Objects */
    if ((UnloadFlag == 3) || (UnloadFlag == 4))
    {
        /* Call a Method releasing the blocked thread */
        Status = AcpiEvaluateObject (NULL, "\\REL0",
            NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiEvaluateObject(REL0) returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }
    }

    if ((UnloadFlag == 1) || (UnloadFlag == 3) || (UnloadFlag == 4))
    {
        for (i = 0; i < NumId; i++)
        {
            ExpectedCounter = 0;
            for (j = 0; j < NumId; j++)
            {
                if ((HandlerId[j] == HandlerId[i]) &&
                    (ExpectedStatus[j] == AE_OK))
                {
                    ExpectedCounter++;
                }
            }
            if (AttachDataCounter[HandlerId[i]] != ExpectedCounter)
            {
                AapiErrors++;
                printf ("API Error: unexpectedly AttachDataCounter[%d] (%d) != %d\n",
                    HandlerId[i], AttachDataCounter[HandlerId[i]], ExpectedCounter);
                return (AE_ERROR);
            }
        }
    }
    else
    {
        for (i = 0; i < NumId; i++)
        {
            if (AttachDataCounter[HandlerId[i]] != 0)
            {
                AapiErrors++;
                printf ("API Error: unexpectedly AttachDataCounter[%d] (%d) != %d\n",
                    HandlerId[i], AttachDataCounter[HandlerId[i]], 0);
                return (AE_ERROR);
            }
        }
    }

    Status = AtTerminateCtrlCheck(AE_OK, ALL_STAT);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (!((UnloadFlag == 1) || (UnloadFlag == 3) || (UnloadFlag == 4)))
    {
        for (i = 0; i < NumId; i++)
        {
            ExpectedCounter = 0;
            for (j = 0; j < NumId; j++)
            {
                if ((HandlerId[j] == HandlerId[i]) &&
                    (ExpectedStatus[j] == AE_OK))
                {
                    ExpectedCounter++;
                }
            }
            if (AttachDataCounter[HandlerId[i]] != ExpectedCounter)
            {
                AapiErrors++;
                printf ("API Error: unexpectedly AttachDataCounter[%d] (%d) != %d\n",
                    HandlerId[i], AttachDataCounter[HandlerId[i]], ExpectedCounter);
                return (AE_ERROR);
            }
        }
    }

    for (i = 0; i < NumId; i++)
    {
        if (ExpectedStatus[i] != AE_OK)
        {
            continue;
        }

        Stat = AttachDataStat[HandlerId[i]];
        if (Stat[0].Object != Objects[HandleId[i]])
        {
            AapiErrors++;
            printf ("API Error: Handler's Object (0x%p) is different from"
                " expected (0x%p)\n",
                Stat[0].Object, Objects[HandleId[i]]);
            return (AE_ERROR);
        }
        if (Stat[0].Data != Data[i])
        {
            AapiErrors++;
            printf ("API Error: Handler's Data (0x%p) is different from"
                " expected (0x%p)\n",
                Stat[0].Data, &Data[i]);
            return (AE_ERROR);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0089:
 *
 */
ACPI_STATUS
AtNSpaceTest0089(void)
{
    ACPI_STRING             Pathnames[] =
        {"\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0"};
    UINT32                  HandleId[] = {0};
    void                    *Data[] = {DataBuffer};
    UINT32                  HandlerId[] = {0};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0};
    ACPI_STATUS             ExpectedStatus[] = {AE_OK};

    return (AtAttachDataCommon(0,
        1, Pathnames, 1, HandleId, Data, Handlers, HandlerId, ExpectedStatus));
}

/*
 * ASSERTION 0090:
 *
 */
ACPI_STATUS
AtNSpaceTest0090(void)
{
    ACPI_STRING             Pathnames[] =
        {"\\AUX2.SS00"};
    UINT32                  HandleId[] = {0};
    void                    *Data[] = {DataBuffer};
    UINT32                  HandlerId[] = {1};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler1};
    ACPI_STATUS             ExpectedStatus[] = {AE_OK};

    return (AtAttachDataCommon(1,
        1, Pathnames, 1, HandleId, Data, Handlers, HandlerId, ExpectedStatus));
}

/*
 * ASSERTION 0091:
 *
 */
ACPI_STATUS
AtNSpaceTest0091(void)
{
    ACPI_STRING             Pathnames[] =
        {"\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0"};
    UINT32                  HandleId[] = {0, 0, 0};
    void                    *Data[] = {DataBuffer, DataBuffer + 1, DataBuffer + 2};
    UINT32                  HandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    ACPI_STATUS             ExpectedStatus[] = {AE_OK, AE_OK, AE_OK};

    return (AtAttachDataCommon(0,
        1, Pathnames, 3, HandleId, Data, Handlers, HandlerId, ExpectedStatus));
}

/*
 * ASSERTION 0092:
 *
 */
ACPI_STATUS
AtNSpaceTest0092(void)
{
    ACPI_STRING             Pathnames[] =
        {"\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0"};
    UINT32                  HandleId[] = {0, 0, 0};
    void                    *Data[] = {DataBuffer, DataBuffer + 1, DataBuffer + 2};
    UINT32                  HandlerId[] = {0, 1, 1};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0,
        AttachDataHandler0, AttachDataHandler1};
    ACPI_STATUS             ExpectedStatus[] = {AE_OK, AE_ALREADY_EXISTS, AE_OK};

    return (AtAttachDataCommon(0,
        1, Pathnames, 3, HandleId, Data, Handlers, HandlerId, ExpectedStatus));
}

/*
 * ASSERTION 0093:
 *
 */
ACPI_STATUS
AtNSpaceTest0093(void)
{
    ACPI_STRING             Pathnames[] = {"\\AUX2.SS00"};
    UINT32                  HandleId[] = {0, 0, 0};
    void                    *Data[] = {DataBuffer, DataBuffer + 1, DataBuffer + 2};
    UINT32                  HandlerId[] = {0, 1, 1};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0,
        AttachDataHandler0, AttachDataHandler1};
    ACPI_STATUS             ExpectedStatus[] = {AE_BAD_PARAMETER,
        AE_BAD_PARAMETER, AE_BAD_PARAMETER};

    return (AtAttachDataCommon(2,
        1, Pathnames, 3, HandleId, Data, Handlers, HandlerId, ExpectedStatus));
}

/*
 * ASSERTION 0094:
 *
 */
ACPI_STATUS
AtNSpaceTest0094(void)
{
    ACPI_STRING             Pathnames[] =
        {"\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0"};
    UINT32                  HandleId[] = {0, 0, 0};
    void                    *Data[] = {DataBuffer, DataBuffer + 1, DataBuffer + 2};
    UINT32                  HandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     Handlers[] = {NULL, AttachDataHandler1, NULL};
    ACPI_STATUS             ExpectedStatus[] = {AE_BAD_PARAMETER,
        AE_OK, AE_BAD_PARAMETER};

    return (AtAttachDataCommon(0,
        1, Pathnames, 3, HandleId, Data, Handlers, HandlerId, ExpectedStatus));
}

/*
 * ASSERTION 0095:
 *
 */
ACPI_STATUS
AtNSpaceTest0095(void)
{
    ACPI_STRING             Pathnames[] =
        {"\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0"};
    UINT32                  HandleId[] = {0, 0, 0};
    void                    *Data[] = {NULL, DataBuffer + 1, NULL};
    UINT32                  HandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    ACPI_STATUS             ExpectedStatus[] = {AE_BAD_PARAMETER,
        AE_OK, AE_BAD_PARAMETER};

    return (AtAttachDataCommon(0,
        1, Pathnames, 3, HandleId, Data, Handlers, HandlerId, ExpectedStatus));
}

ACPI_STATUS
AtAttachDataExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark,
    ACPI_STRING             Pathname,
    void                    *Data,
    ACPI_OBJECT_HANDLER     Handler,
    UINT32                  HandlerId)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_HANDLE             Object;


    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtAttachDataExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = AcpiGetHandle (NULL, Pathname, &Object);
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

        Status = AcpiAttachData(Object, Handler, Data);

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
                printf ("API Error: AcpiAttachData returned %s,\n"
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
 * ASSERTION 0096:
 */
ACPI_STATUS
AtNSpaceTest0096(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtAttachDataExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
        DataBuffer, AttachDataHandler0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    return (AtAttachDataExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
        DataBuffer, AttachDataHandler0, 0));
}

UINT8
AtIsDataHandlerAttached(
    UINT32                  HandlerId,
    UINT32                  DetachHandlerId[],
    UINT32                  DetachNumId,
    ACPI_STATUS             ExpectedStatus[])
{
    UINT32                  i = 0;

    for (i = 0; i < DetachNumId; i++)
    {
        if (HandlerId == DetachHandlerId[i] &&
            ExpectedStatus[i] == AE_OK)
        {
            return (0);
        }
    }
    return (1);
}

ACPI_STATUS
AtDetachDataCommon(
    UINT32                  UnloadFlag,
    ACPI_STRING             Pathname,
    void                    *Data[],
    ACPI_OBJECT_HANDLER     Handlers[],
    UINT32                  HandlerId[],
    UINT32                  NumId,
    ACPI_OBJECT_HANDLER     DetachHandlers[],
    UINT32                  DetachHandlerId[],
    UINT32                  DetachNumId,
    ACPI_STATUS             ExpectedStatus[])
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Object;
    AT_ATTACH_DATA_STAT     *Stat;
    ACPI_STRING             UpdateMethod = "\\M120";
    UINT32                  i, j, ExpectedCounter;

    if (NumId > 3)
    {
        TestErrors++;
        printf ("Test Error: NumId (%d) > 3\n", NumId);
        return (AE_ERROR);
    }

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    Status = AcpiGetHandle (NULL, Pathname, &Object);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    for (i = 0; i < NumId; i++)
    {
        Status = AcpiAttachData(Object, Handlers[i], Data[i]);

        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiAttachData() returned %s\n",
                AcpiFormatException(Status));
            return (AE_ERROR);
        }
    }

    for (i = 0; i < NumId; i++)
    {
        if (HandlerId[i] > 2)
        {
            TestErrors++;
            printf ("Test Error: HandlerId[%d] (%d) > 2\n", i, HandlerId[i]);
            return (AE_ERROR);
        }
        if (AttachDataCounter[HandlerId[i]] != 0)
        {
            AapiErrors++;
            printf ("API Error: unexpectedly AttachDataCounter[%d] (%d) != 0\n",
                HandlerId[i], AttachDataCounter[HandlerId[i]]);
            return (AE_ERROR);
        }
    }

    if (UnloadFlag == 0)
    {
        Status = AcpiEvaluateObject (NULL, UpdateMethod, NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiEvaluateObject(%s) returned %s\n",
                UpdateMethod, AcpiFormatException(Status));
            return (Status);
        }
    }

    for (i = 0; i < DetachNumId; i++)
    {
        Status = AcpiDetachData(Object, DetachHandlers[i]);

        if (Status != ExpectedStatus[i])
        {
            AapiErrors++;
            printf ("API error: AcpiDetachData() returned %s,"
                " expected %s\n",
                AcpiFormatException(Status),
                AcpiFormatException(ExpectedStatus[i]));
            return (AE_ERROR);
        }
    }

    if (UnloadFlag == 1)
    {
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
        for (i = 0; i < NumId; i++)
        {
            ExpectedCounter = 0;
            for (j = 0; j < NumId; j++)
            {
                if ((HandlerId[j] == HandlerId[i]) &&
                    AtIsDataHandlerAttached(HandlerId[i],
                        DetachHandlerId, DetachNumId, ExpectedStatus))
                {
                    ExpectedCounter++;
                }
            }
            if (AttachDataCounter[HandlerId[i]] != ExpectedCounter)
            {
                AapiErrors++;
                printf ("API Error: unexpectedly AttachDataCounter[%d] (%d) != %d\n",
                    HandlerId[i], AttachDataCounter[HandlerId[i]], ExpectedCounter);
                return (AE_ERROR);
            }
        }
    }

    Status = AtTerminateCtrlCheck(AE_OK, ALL_STAT);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (UnloadFlag != 1)
    {
        for (i = 0; i < NumId; i++)
        {
            ExpectedCounter = 0;
            for (j = 0; j < NumId; j++)
            {
                if ((HandlerId[j] == HandlerId[i]) &&
                    AtIsDataHandlerAttached(HandlerId[i],
                        DetachHandlerId, DetachNumId, ExpectedStatus))
                {
                    ExpectedCounter++;
                }
            }
            if (AttachDataCounter[HandlerId[i]] != ExpectedCounter)
            {
                AapiErrors++;
                printf ("API Error: unexpectedly AttachDataCounter[%d] (%d) != %d\n",
                    HandlerId[i], AttachDataCounter[HandlerId[i]], ExpectedCounter);
                return (AE_ERROR);
            }
        }
    }

    for (i = 0; i < NumId; i++)
    {
        if (!AtIsDataHandlerAttached(HandlerId[i],
            DetachHandlerId, DetachNumId, ExpectedStatus))
        {
            continue;
        }

        Stat = AttachDataStat[HandlerId[i]];
        if (Stat[0].Object != Object)
        {
            AapiErrors++;
            printf ("API Error: Handler's Object (0x%p) is different from"
                " expected (0x%p)\n",
                Stat[0].Object, Object);
            return (AE_ERROR);
        }
        if (Stat[0].Data != Data[i])
        {
            AapiErrors++;
            printf ("API Error: Handler's Data (0x%p) is different from"
                " expected (0x%p)\n",
                Stat[0].Data, &Data[i]);
            return (AE_ERROR);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0098:
 *
 */
ACPI_STATUS
AtNSpaceTest0098(void)
{
    void                    *Data[] = {DataBuffer, DataBuffer + 1, DataBuffer + 2};
    UINT32                  HandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    UINT32                  DetachHandlerId[] = {0, 2};
    ACPI_OBJECT_HANDLER     DetachHandlers[] = {AttachDataHandler0, AttachDataHandler2};
    ACPI_STATUS             ExpectedStatus[] = {AE_OK, AE_OK};

    return (AtDetachDataCommon(0,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
        Data, Handlers, HandlerId, 3,
        DetachHandlers, DetachHandlerId, 2, ExpectedStatus));
}

/*
 * ASSERTION 0099:
 *
 */
ACPI_STATUS
AtNSpaceTest0099(void)
{
    void                    *Data[] = {DataBuffer, DataBuffer + 1, DataBuffer + 2};
    UINT32                  HandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    UINT32                  DetachHandlerId[] = {0, 2};
    ACPI_OBJECT_HANDLER     DetachHandlers[] = {AttachDataHandler0, AttachDataHandler2};
    ACPI_STATUS             ExpectedStatus[] = {AE_BAD_PARAMETER, AE_BAD_PARAMETER};

    return (AtDetachDataCommon(2,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
        Data, Handlers, HandlerId, 0,
        DetachHandlers, DetachHandlerId, 2, ExpectedStatus));
}

/*
 * ASSERTION 0100:
 *
 */
ACPI_STATUS
AtNSpaceTest0100(void)
{
    void                    *Data[] = {DataBuffer, DataBuffer + 1, DataBuffer + 2};
    UINT32                  HandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    UINT32                  DetachHandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     DetachHandlers[] = {NULL,
        AttachDataHandler1, NULL};
    ACPI_STATUS             ExpectedStatus[] = {AE_BAD_PARAMETER,
        AE_OK, AE_BAD_PARAMETER};

    return (AtDetachDataCommon(0,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
        Data, Handlers, HandlerId, 3,
        DetachHandlers, DetachHandlerId, 3, ExpectedStatus));
}

ACPI_STATUS
AtDetachDataExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark,
    ACPI_STRING             Pathname,
    void                    *Data,
    ACPI_OBJECT_HANDLER     Handler,
    UINT32                  HandlerId)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_HANDLE             Object;

    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtDettachDataExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = AcpiGetHandle (NULL, Pathname, &Object);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                Pathname, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiAttachData(Object, Handler, Data);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiAttachData() returned %s\n",
                AcpiFormatException(Status));
            return (AE_ERROR);
        }

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: OsxfCtrlSet returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiDetachData(Object, Handler);

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
                printf ("API Error: AcpiDetachData returned %s,\n"
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
 * ASSERTION 0101:
 */
ACPI_STATUS
AtNSpaceTest0101(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtDetachDataExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
        DataBuffer, AttachDataHandler0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    return (AtDetachDataExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
        DataBuffer, AttachDataHandler0, 0));
}

/*
 * ASSERTION 0103:
 *
 */
ACPI_STATUS
AtNSpaceTest0103(void)
{
    void                    *Data[] = {DataBuffer + 1};
    UINT32                  HandlerId[] = {1};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler1};
    UINT32                  DetachHandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     DetachHandlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    ACPI_STATUS             ExpectedStatus[] = {AE_NOT_FOUND, AE_OK, AE_NOT_FOUND};

    return (AtDetachDataCommon(0,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
        Data, Handlers, HandlerId, 1,
        DetachHandlers, DetachHandlerId, 3, ExpectedStatus));
}

ACPI_STATUS
AtGetDataCommon(
    UINT32                  UnloadFlag,
    ACPI_STRING             Pathname,
    void                    *Data[],
    ACPI_OBJECT_HANDLER     Handlers[],
    UINT32                  HandlerId[],
    UINT32                  NumId,
    ACPI_OBJECT_HANDLER     GetHandlers[],
    UINT32                  GetHandlerId[],
    UINT32                  GetNumId,
    ACPI_STATUS             ExpectedStatus[])
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Object;
    AT_ATTACH_DATA_STAT     *Stat;
    UINT32                  i = 0;
    void                    *RetData, **RetDataPointer = &RetData;

    if (NumId > 3)
    {
        TestErrors++;
        printf ("Test Error: NumId (%d) > 3\n", NumId);
        return (AE_ERROR);
    }

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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
    if ((UnloadFlag == 1) || (UnloadFlag == 2))
    {
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_LOAD)))
        {
            return (Status);
        }
    }

    Status = AcpiGetHandle (NULL, Pathname, &Object);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            Pathname, AcpiFormatException(Status));
        return (Status);
    }

    for (i = 0; i < NumId; i++)
    {
        Status = AcpiAttachData(Object, Handlers[i], Data[i]);

        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiAttachData() returned %s\n",
                AcpiFormatException(Status));
            return (AE_ERROR);
        }
    }

    for (i = 0; i < NumId; i++)
    {
        if (HandlerId[i] > 2)
        {
            TestErrors++;
            printf ("Test Error: HandlerId[%d] (%d) > 2\n", i, HandlerId[i]);
            return (AE_ERROR);
        }
        if (AttachDataCounter[HandlerId[i]] != 0)
        {
            AapiErrors++;
            printf ("API Error: unexpectedly AttachDataCounter[%d] (%d) != 0\n",
                HandlerId[i], AttachDataCounter[HandlerId[i]]);
            return (AE_ERROR);
        }
    }

    if (UnloadFlag == 2)
    {
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
    }
    else if (UnloadFlag == 4)
    {
        RetDataPointer = NULL;
    }

    for (i = 0; i < GetNumId; i++)
    {
        Status = AcpiGetData(Object, GetHandlers[i], RetDataPointer);

        if (Status != ExpectedStatus[i])
        {
            AapiErrors++;
            printf ("API error: AcpiGetData() returned %s,"
                " expected %s\n",
                AcpiFormatException(Status),
                AcpiFormatException(ExpectedStatus[i]));
            return (AE_ERROR);
        }
        else if (Status == AE_OK && RetData != Data[i])
        {
            AapiErrors++;
            printf ("API error: AcpiGetData() returned Pointer 0x%p,"
                " expected 0x%p\n",
                RetData, Data[i]);
            return (AE_ERROR);
        }
    }

    if (UnloadFlag == 1)
    {
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
        for (i = 0; i < NumId; i++)
        {
            if (AttachDataCounter[HandlerId[i]] != 1)
            {
                AapiErrors++;
                printf ("API Error: unexpectedly AttachDataCounter[%d] (%d) != 1\n",
                    HandlerId[i], AttachDataCounter[HandlerId[i]]);
                return (AE_ERROR);
            }
        }
    }

    Status = AtTerminateCtrlCheck(AE_OK, ALL_STAT);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (UnloadFlag != 1)
    {
        for (i = 0; i < NumId; i++)
        {
            if (AttachDataCounter[HandlerId[i]] != 1)
            {
                AapiErrors++;
                printf ("API Error: unexpectedly AttachDataCounter[%d] (%d) != 1\n",
                    HandlerId[i], AttachDataCounter[HandlerId[i]]);
                return (AE_ERROR);
            }
        }
    }

    for (i = 0; i < NumId; i++)
    {
        if (AttachDataCounter[HandlerId[i]] != 1)
        {
            AapiErrors++;
            printf ("API Error: Handler called %d times,"
                " expected to be caled one time only\n",
                AttachDataCounter[HandlerId[i]]);
            return (AE_ERROR);
        }

        Stat = AttachDataStat[HandlerId[i]];
        if (Stat[0].Object != Object)
        {
            AapiErrors++;
            printf ("API Error: Handler's Object (0x%p) is different from"
                " expected (0x%p)\n",
                Stat[0].Object, Object);
            return (AE_ERROR);
        }
        if (Stat[0].Data != Data[i])
        {
            AapiErrors++;
            printf ("API Error: Handler's Data (0x%p) is different from"
                " expected (0x%p)\n",
                Stat[0].Data, &Data[i]);
            return (AE_ERROR);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0104:
 *
 */
ACPI_STATUS
AtNSpaceTest0104(void)
{
    void                    *Data[] = {DataBuffer, DataBuffer + 1, DataBuffer + 2};
    UINT32                  HandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    UINT32                  GetHandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     GetHandlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    ACPI_STATUS             ExpectedStatus[] = {AE_OK, AE_OK, AE_OK};

    return (AtGetDataCommon(0,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
        Data, Handlers, HandlerId, 3,
        GetHandlers, GetHandlerId, 3, ExpectedStatus));
}

/*
 * ASSERTION 0105:
 *
 */
ACPI_STATUS
AtNSpaceTest0105(void)
{
    void                    *Data[] = {DataBuffer, DataBuffer + 1, DataBuffer + 2};
    UINT32                  HandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    UINT32                  GetHandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     GetHandlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    ACPI_STATUS             ExpectedStatus[] = {AE_BAD_PARAMETER,
        AE_BAD_PARAMETER, AE_BAD_PARAMETER};

    return (AtGetDataCommon(2,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
        Data, Handlers, HandlerId, 3,
        GetHandlers, GetHandlerId, 3, ExpectedStatus));
}

/*
 * ASSERTION 0106:
 *
 */
ACPI_STATUS
AtNSpaceTest0106(void)
{
    void                    *Data[] = {DataBuffer, DataBuffer + 1, DataBuffer + 2};
    UINT32                  HandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    UINT32                  GetHandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     GetHandlers[] = {NULL,
        AttachDataHandler1, NULL};
    ACPI_STATUS             ExpectedStatus[] = {AE_BAD_PARAMETER,
        AE_OK, AE_BAD_PARAMETER};

    return (AtGetDataCommon(0,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
        Data, Handlers, HandlerId, 3,
        GetHandlers, GetHandlerId, 3, ExpectedStatus));
}

/*
 * ASSERTION 0107:
 *
 */
ACPI_STATUS
AtNSpaceTest0107(void)
{
    void                    *Data[] = {DataBuffer, DataBuffer + 1, DataBuffer + 2};
    UINT32                  HandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    UINT32                  GetHandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     GetHandlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    ACPI_STATUS             ExpectedStatus[] = {AE_BAD_PARAMETER,
        AE_BAD_PARAMETER, AE_BAD_PARAMETER};

    return (AtGetDataCommon(4,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
        Data, Handlers, HandlerId, 3,
        GetHandlers, GetHandlerId, 3, ExpectedStatus));
}

ACPI_STATUS
AtGetDataExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark,
    ACPI_STRING             Pathname,
    void                    *Data,
    ACPI_OBJECT_HANDLER     Handler,
    UINT32                  HandlerId)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_HANDLE             Object;
    void                    *RetData;


    for (i = TFst; (i < TMax) && Continue_Cond; i++)
    {
        printf ("AtDettachDataExceptionTest: i = %d\n", i);

        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        Status = AcpiGetHandle (NULL, Pathname, &Object);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                Pathname, AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiAttachData(Object, Handler, Data);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiAttachData() returned %s\n",
                AcpiFormatException(Status));
            return (AE_ERROR);
        }

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: OsxfCtrlSet returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiGetData(Object, Handler, &RetData);

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
                printf ("API Error: AcpiGetData returned %s,\n"
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
 * ASSERTION 0108:
 */
ACPI_STATUS
AtNSpaceTest0108(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtGetDataExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
        DataBuffer, AttachDataHandler0, 0);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    return (AtGetDataExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
        DataBuffer, AttachDataHandler0, 0));
}

/*
 * ASSERTION 0110:
 *
 */
ACPI_STATUS
AtNSpaceTest0110(void)
{
    void                    *Data[] = {DataBuffer + 1};
    UINT32                  HandlerId[] = {1};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler1};
    UINT32                  DetachHandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     DetachHandlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    ACPI_STATUS             ExpectedStatus[] = {AE_NOT_FOUND, AE_OK, AE_NOT_FOUND};

    return (AtGetDataCommon(0,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0",
        Data, Handlers, HandlerId, 1,
        DetachHandlers, DetachHandlerId, 3, ExpectedStatus));
}

static UINT32               WalkNamespaceHandlerCounter;
static UINT32               WalkNamespaceHandlerReturnValue;
static AT_WALK_HANDLER_CONTEXT    WalkNamespaceHandlerContext;

ACPI_STATUS
AtWalkNamespaceHandler (
    ACPI_HANDLE             ObjHandle,
    UINT32                  NestingLevel,
    void                    *Context,
    void                    **ReturnValue)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutName = {AT_PATHNAME_MAX, PathName};
    UINT32                  i;

    ++WalkNamespaceHandlerCounter;

    Status = AcpiGetName (ObjHandle, ACPI_FULL_PATHNAME, &OutName);

    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiGetName(0x%p) returned %s\n",
            ObjHandle, AcpiFormatException(Status));
        strcpy(PathName, "????");
    }
/*
    printf ("AtWalkNamespaceHandler %.2d: (%s) ObjHandle %p, Level %d, Context %p\n",
        WalkNamespaceHandlerCounter, PathName, ObjHandle, NestingLevel, Context);
*/
    printf ("    {%d, \"%s\"},\n",
        NestingLevel, PathName);

    if (Context != &WalkNamespaceHandlerContext) {
        AapiErrors++;
        printf ("AtWalkNamespaceHandler: Context (%p) !="
            " &WalkNamespaceHandlerContext (%p)\n",
            Context, &WalkNamespaceHandlerContext);
    }

    if (*ReturnValue != &WalkNamespaceHandlerReturnValue) {
        AapiErrors++;
        printf ("AtWalkNamespaceHandler: *ReturnValue (%p) !="
            " &WalkNamespaceHandlerReturnValue (%p)\n",
            *ReturnValue, &WalkNamespaceHandlerReturnValue);
    }

    for (i = 0; i < WalkNamespaceHandlerContext.InfoCounter; i++)
    {
        if (strcmp(WalkNamespaceHandlerContext.WalkInfo[i].PathName, PathName) == 0)
        {
            WalkNamespaceHandlerContext.WalkInfo[i].WalkCount++;
            WalkNamespaceHandlerContext.WalkInfo[i].XfNestingLevel = NestingLevel;
            WalkNamespaceHandlerContext.WalkInfo[i].HandlerCount =
                WalkNamespaceHandlerCounter;
            break;
        }
    }

    if (WalkNamespaceHandlerCounter == WalkNamespaceHandlerContext.ActionCounter) {
        return (WalkNamespaceHandlerContext.RetVal);
    }

    return (AE_OK);
}

ACPI_STATUS
AtWalkNamespaceCommon(
    ACPI_OBJECT_TYPE        Type,
    ACPI_STRING             StartObjectName,
    UINT32                  StartObjectDepth,
    UINT32                  MaxDepth,
    ACPI_STATUS             ExpectedStatus,
    UINT32                  WalkNamespaceHandlerRet,
    UINT32                  ActionCounter,
    UINT32                  ExpectedCounter,
    AT_WALK_INFO            *WalkInfo)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             StartObject;
    UINT32                  *ReturnValue = &WalkNamespaceHandlerReturnValue;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    if (StartObjectName)
    {
        Status = AcpiGetHandle (NULL, StartObjectName, &StartObject);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                StartObjectName, AcpiFormatException(Status));
            return (Status);
        }
    }
    else
    {
        StartObject = ACPI_ROOT_OBJECT;
    }

    WalkNamespaceHandlerCounter = 0;
    WalkNamespaceHandlerContext.RetVal = WalkNamespaceHandlerRet;
    WalkNamespaceHandlerContext.InfoCounter = ExpectedCounter;
    WalkNamespaceHandlerContext.WalkInfo = WalkInfo;
    WalkNamespaceHandlerContext.ActionCounter = ActionCounter;

    Status = AcpiWalkNamespace (
        Type, StartObject, MaxDepth, AtWalkNamespaceHandler, NULL,
        &WalkNamespaceHandlerContext, (void **) &ReturnValue);
    if (Status != ExpectedStatus)
    {
        AapiErrors++;
        printf ("Api Error: AcpiWalkNamespace(0x%x) returned %s,"
            " expected %s\n",
            Type,
            AcpiFormatException(Status), AcpiFormatException(ExpectedStatus));
        return (Status);
    }

    if (WalkNamespaceHandlerCounter != ExpectedCounter)
    {
        AapiErrors++;
        printf ("Api Error: Type 0x%x, WalkNamespaceHandlerCounter (%d) !="
            " ExpectedCounter (%d)\n",
            Type, WalkNamespaceHandlerCounter, ExpectedCounter);
        return (AE_ERROR);
    }

    for (i = 0; i < ExpectedCounter; i++)
    {
        if (WalkInfo[i].WalkCount == 0)
        {
            AapiErrors++;
            printf ("Api Error: Object '%s' is not met\n",
                WalkInfo[i].PathName);
        }
        else if (WalkInfo[i].WalkCount > 1)
        {
            AapiErrors++;
            printf ("Api Error: Object '%s' is met more than once (%d)\n",
                WalkInfo[i].PathName, WalkInfo[i].WalkCount);
        }
        else if (WalkInfo[i].XfNestingLevel != WalkInfo[i].NestingLevel -
            AT_NESTING_LEVEL_REL * StartObjectDepth)
        {
            AapiErrors++;
            printf ("Api Error: NestingLevel of Object '%s' (%d)"
                " is expected to be %d\n",
                WalkInfo[i].PathName,
                WalkInfo[i].XfNestingLevel,
                WalkInfo[i].NestingLevel -
                    AT_NESTING_LEVEL_REL * StartObjectDepth);
        }
        else if (WalkInfo[i].HandlerCount != i + 1)
        {
            AapiErrors++;
            printf ("Api Error: depth-first rule is violated for %s,"
                " the walked number (%d) is expected to be %d\n",
                WalkInfo[i].PathName, WalkInfo[i].HandlerCount, i + 1);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0111:
 */
ACPI_STATUS
AtNSpaceTest0111(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    Status = AtWalkNamespaceCommon(ACPI_TYPE_DEVICE,
        NULL, 0, 7,
        AE_OK, AE_OK,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO) + 1,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO),
        DeviceWalkInfo0000);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtWalkNamespaceCommon(ACPI_TYPE_DEVICE,
        "\\", 0, 5,
        AE_OK, AE_OK,
        sizeof (DeviceWalkInfoDepth) / sizeof (AT_WALK_INFO) + 1,
        sizeof (DeviceWalkInfoDepth) / sizeof (AT_WALK_INFO),
        DeviceWalkInfoDepth);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtWalkNamespaceCommon(ACPI_TYPE_DEVICE,
        "\\D1L1.D2L0.D3L0.D4L_", 4, 12,
        AE_OK, AE_OK,
        sizeof (DeviceWalkInfoLevel5) / sizeof (AT_WALK_INFO) + 1,
        sizeof (DeviceWalkInfoLevel5) / sizeof (AT_WALK_INFO),
        DeviceWalkInfoLevel5);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 1; i < sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE); i++)
    {
        if (LevelTypes0000[i] == ACPI_TYPE_FIELD_UNIT &&
            AT_SKIP_ACPI_TYPE_FIELD_UNIT_CHECK)
        {
            printf ("ACPI_TYPE_FIELD_UNIT check skipped\n");
            continue;
        }
        Status = AtWalkNamespaceCommon(LevelTypes0000[i],
            "\\D1L3", 1, 1,
            AE_OK, AE_OK,
            2,
            1,
            TypesWalkInfoLevel2 + i);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0112:
 */
ACPI_STATUS
AtNSpaceTest0112(void)
{
    ACPI_STATUS             Status;

    Status = AtWalkNamespaceCommon(ACPI_TYPE_DEVICE,
        NULL, 0, 7,
        AE_OK, AE_CTRL_DEPTH,
        9,
        sizeof (DeviceWalkInfoDepth) / sizeof (AT_WALK_INFO),
        DeviceWalkInfoDepth);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0113:
 */
ACPI_STATUS
AtNSpaceTest0113(void)
{
    ACPI_STATUS             Status;

    Status = AtWalkNamespaceCommon(ACPI_TYPE_DEVICE,
        NULL, 0, 7,
        AE_OK, AE_CTRL_TERMINATE,
        9,
        9,
        DeviceWalkInfoDepth);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0114:
 */
ACPI_STATUS
AtNSpaceTest0114(void)
{
    ACPI_STATUS             Status;

    Status = AtWalkNamespaceCommon(ACPI_TYPE_DEVICE,
        NULL, 0, 7,
        AE_ERROR, AE_ERROR,
        9,
        9,
        DeviceWalkInfoDepth);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0115:
 */
ACPI_STATUS
AtNSpaceTest0115(void)
{
    ACPI_STATUS             Status;

    Status = AtWalkNamespaceCommon(ACPI_TYPE_DEVICE,
        NULL, 0, 0,
        AE_BAD_PARAMETER, AE_OK,
        0,
        0,
        DeviceWalkInfo0000);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0116:
 */
ACPI_STATUS
AtNSpaceTest0116(void)
{
    ACPI_STATUS             Status;
    UINT32                  *ReturnValue = &WalkNamespaceHandlerReturnValue;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    Status = AcpiWalkNamespace (
        ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, 10, NULL, NULL,
        &WalkNamespaceHandlerContext, (void **)&ReturnValue);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiWalkNamespace( , , , NULL) returned %s,"
            " expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0117:
 */
ACPI_STATUS
AtNSpaceTest0117(void)
{
    ACPI_STATUS             Status;
    ACPI_STRING             StartObjectName = "\\AUX2";
    ACPI_HANDLE             StartObject;
    UINT32                  *ReturnValue = &WalkNamespaceHandlerReturnValue;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
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

    Status = AcpiGetHandle (NULL, StartObjectName, &StartObject);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            StartObjectName, AcpiFormatException(Status));
        return (Status);
    }

    /* Make Object handle invalid by unloading SSDT table */
    if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
    {
        return (Status);
    }

    Status = AcpiWalkNamespace (
        ACPI_TYPE_DEVICE, StartObject, 10, AtWalkNamespaceHandler, NULL,
        &WalkNamespaceHandlerContext, (void **)&ReturnValue);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("Api Error: AcpiWalkNamespace(invalid StartObject) returned %s,"
            " expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0118:
 */
ACPI_STATUS
AtNSpaceTest0118(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    for (i = ACPI_TYPE_EXTERNAL_MAX + 1; i < 20; i++)
    {
        Status = AtWalkNamespaceCommon(i,
            "\\D1L3", 1, 1,
            AE_BAD_PARAMETER, AE_OK,
            0,
            0,
            TypesWalkInfoLevel2);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AE_OK);
}

ACPI_STATUS
AtWalkNamespaceExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark,
    ACPI_OBJECT_TYPE        Type,
    ACPI_STRING             StartObjectName,
    UINT32                  MaxDepth,
    UINT32                  WalkNamespaceHandlerRet,
    UINT32                  ActionCounter,
    UINT32                  ExpectedCounter,
    AT_WALK_INFO            *WalkInfo)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond = 1;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_HANDLE             StartObject;
    UINT32                  *ReturnValue = &WalkNamespaceHandlerReturnValue;


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

        if (StartObjectName)
        {
            Status = AcpiGetHandle (NULL, StartObjectName, &StartObject);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                    StartObjectName, AcpiFormatException(Status));
                return (Status);
            }
        }
        else
        {
            StartObject = ACPI_ROOT_OBJECT;
        }

        Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error: OsxfCtrlSet returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        WalkNamespaceHandlerCounter = 0;
        WalkNamespaceHandlerContext.RetVal = WalkNamespaceHandlerRet;
        WalkNamespaceHandlerContext.InfoCounter = ExpectedCounter;
        WalkNamespaceHandlerContext.WalkInfo = WalkInfo;
        WalkNamespaceHandlerContext.ActionCounter = ActionCounter;

        Status = AcpiWalkNamespace (
            Type, StartObject, MaxDepth, AtWalkNamespaceHandler, NULL,
            &WalkNamespaceHandlerContext, (void **)&ReturnValue);

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
                printf ("API Error: AcpiWalkNamespace returned %s,\n"
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
 * ASSERTION 0119:
 */
ACPI_STATUS
AtNSpaceTest0119(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */

    Status = AtWalkNamespaceExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        ACPI_TYPE_DEVICE, NULL, 7, AE_OK,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO) + 1,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO),
        DeviceWalkInfo0000);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtWalkNamespaceExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        ACPI_TYPE_DEVICE, "\\D1L1.D2L0.D3L0.D4L_", 12, AE_OK,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO) + 1,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO),
        DeviceWalkInfo0000);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 1; i < sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE); i++)
    {
        Status = AtWalkNamespaceExceptionTest(
            OSXF_NUM(AcpiOsAllocate),
            AtActD_Permanent, AtActRet_NULL, 1,
            AE_NO_MEMORY,
            ACPI_TYPE_DEVICE, "\\D1L3", 2, AE_OK,
            2, 1,
            TypesWalkInfoLevel2 + i);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */

    Status = AtWalkNamespaceExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        ACPI_TYPE_DEVICE, NULL, 7, AE_OK,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO) + 1,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO),
        DeviceWalkInfo0000);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtWalkNamespaceExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        ACPI_TYPE_DEVICE, "\\D1L1.D2L0.D3L0.D4L_", 12, AE_OK,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO) + 1,
        sizeof (DeviceWalkInfo0000) / sizeof (AT_WALK_INFO),
        DeviceWalkInfo0000);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 1; i < sizeof (LevelTypes0000) / sizeof (ACPI_OBJECT_TYPE); i++)
    {
        Status = AtWalkNamespaceExceptionTest(
            OSXF_NUM(AcpiOsAllocate),
            AtActD_OneTime, AtActRet_NULL, 1,
            AE_NO_MEMORY,
            ACPI_TYPE_DEVICE, "\\D1L3", 2, AE_OK,
            2, 1,
            TypesWalkInfoLevel2 + i);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0120:
 *
 */
ACPI_STATUS
AtNSpaceTest0120(void)
{
    void                    *Data[] = {DataBuffer};
    UINT32                  HandlerId[] = {0};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0};
    UINT32                  DetachHandlerId[] = {0};
    ACPI_OBJECT_HANDLER     DetachHandlers[] = {AttachDataHandler0};
    ACPI_STATUS             ExpectedStatus[] = {AE_OK};

    return (AtDetachDataCommon(0,
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.INT0",
        Data, Handlers, HandlerId, 1,
        DetachHandlers, DetachHandlerId, 1, ExpectedStatus));
}

/*
 * ASSERTION 0121:
 *
 */
ACPI_STATUS
AtNSpaceTest0121(void)
{
    return (AtGetHandleExceptionCommon(8, AE_OK));
}

/*
 * ASSERTION 0122:
 *
 */
ACPI_STATUS
AtNSpaceTest0122(void)
{
    ACPI_STRING             Pathnames[] = {"\\"};
    UINT32                  HandleId[] = {0, 0, 0};
    void                    *Data[] = {DataBuffer, DataBuffer + 1, DataBuffer + 2};
    UINT32                  HandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    ACPI_STATUS             ExpectedStatus[] = {AE_OK, AE_OK, AE_OK};

    return (AtAttachDataCommon(0,
        1, Pathnames, 3, HandleId, Data, Handlers, HandlerId, ExpectedStatus));
}

/*
 * ASSERTION 0123:
 *
 */
ACPI_STATUS
AtNSpaceTest0123(void)
{
    ACPI_STRING             Pathnames[] = {"\\BLK0.DEVA"};
    UINT32                  HandleId[] = {0, 0, 0};
    void                    *Data[] = {DataBuffer, DataBuffer + 1, DataBuffer + 2};
    UINT32                  HandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    ACPI_STATUS             ExpectedStatus[] = {AE_OK, AE_OK, AE_OK};

    return (AtAttachDataCommon(3,
        1, Pathnames, 3, HandleId, Data, Handlers, HandlerId, ExpectedStatus));
}

/*
 * ASSERTION 0124:
 *
 */
ACPI_STATUS
AtNSpaceTest0124(void)
{
    ACPI_STRING             Pathnames[] =
        {"\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEVA"};
    UINT32                  HandleId[] = {0, 0, 0};
    void                    *Data[] = {DataBuffer, DataBuffer + 1, DataBuffer + 2};
    UINT32                  HandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    ACPI_STATUS             ExpectedStatus[] = {AE_OK, AE_OK, AE_OK};

    return (AtAttachDataCommon(4,
        1, Pathnames, 3, HandleId, Data, Handlers, HandlerId, ExpectedStatus));
}

/*
 * ASSERTION 0125:
 *
 */
ACPI_STATUS
AtNSpaceTest0125(void)
{
    ACPI_STRING             Pathnames[] = {
        "\\D1L1.D2L0.D3L0.D4L_",
        "\\",
        "\\D1L1.D2L0.D3L0.D4L_.D5L0.D6L0.D7L0.D8L0.D9L0.DAL0.DEV0"};
    UINT32                  HandleId[] = {0, 1, 2};
    void                    *Data[] = {DataBuffer, DataBuffer + 1, DataBuffer + 2};
    UINT32                  HandlerId[] = {0, 1, 2};
    ACPI_OBJECT_HANDLER     Handlers[] = {AttachDataHandler0,
        AttachDataHandler1, AttachDataHandler2};
    ACPI_STATUS             ExpectedStatus[] = {AE_OK, AE_OK, AE_OK};

    return (AtAttachDataCommon(0,
        3, Pathnames, 3, HandleId, Data, Handlers, HandlerId, ExpectedStatus));
}

/*
 * ASSERTION 0126:
 * BZ 7689 AE_AML_BUFFER_LIMIT reprodusing
 *
 */
ACPI_STATUS
AtNSpaceTest0126(void)
{
    ACPI_STATUS             Status;
	struct acpi_object_list input;
	union acpi_object       in_params[1];
    char                    *ParentDev = "\\_SB_.C002.C341.C0F3";

    typedef unsigned char   u8;
    typedef unsigned short  u16;
    enum ATA_CONST {ATA_ID_WORDS		= 256};
    struct {
        ACPI_HANDLE obj_handle;
        u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
        } atadev_obj, *atadev = &atadev_obj;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("nmsp0126.aml")))
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

        Status = AcpiGetHandle (NULL, ParentDev, &atadev->obj_handle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("AtNSpaceTest0126: AcpiGetHandle(NULL, %s) returned %s\n",
                ParentDev, AcpiFormatException(Status));
            return (Status);
        }

    /* from drivers/ata/libata-acpi.c */

	/* Give the drive Identify data to the drive via the _SDD method */
	/* _SDD: set up input parameters */
	input.Count = 1;
	input.Pointer = in_params;
	in_params[0].Type = ACPI_TYPE_BUFFER;
	in_params[0].Buffer.Length = sizeof(atadev->id[0]) * ATA_ID_WORDS;
	in_params[0].Buffer.Pointer = (u8 *)atadev->id;

    memset(in_params[0].Buffer.Pointer, 0, in_params[0].Buffer.Length);

	/* Output buffer: _SDD has no output */

	/* It's OK for _SDD to be missing too. */
	Status = AcpiEvaluateObject(atadev->obj_handle, "_SDD", &input, NULL);
    if (ACPI_FAILURE(Status))
    {
            AapiErrors++;
            printf ("AtNSpaceTest0126: AcpiEvaluateObject(%s) returned %s\n",
                "_SDD", AcpiFormatException(Status));
            return (Status);
    }

    return (AE_OK);
}
