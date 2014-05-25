/******************************************************************************
 *
 * Module Name: atexec - Support routines for ACPICA API test suite
 *                       based on AcpiExec aeexec.c
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

#include "acpi.h"
#include "accommon.h"
#include "acparser.h"
#include "amlcode.h"
#include "acnamesp.h"
#include "acdebug.h"
#include "actables.h"
#include "atcommon.h"

#include <stdio.h>
#include <signal.h>

#define _COMPONENT          ACPI_TOOLS
        ACPI_MODULE_NAME    ("atexec")

/*
#define EXAMPLE1_SSDT
*/
#ifdef EXAMPLE1_SSDT
#include "at_ssdt2_1.c"
#include "at_ssdt2_2.c"
#include "at_ssdt2_3.c"
#else
static unsigned char Ssdt1Code[] =
{
    0x53,0x53,0x44,0x54,0x30,0x00,0x00,0x00, /* 00000000    "SSDT0..." */
    0x01,0xB8,0x49,0x6E,0x74,0x65,0x6C,0x00, /* 00000008    "..Intel." */
    0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00, /* 00000010    "Many...." */
    0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C, /* 00000018    "....INTL" */
    0x24,0x04,0x03,0x20,0x14,0x0B,0x5F,0x54, /* 00000020    "$.. .._T" */
    0x39,0x38,0x00,0x70,0x0A,0x04,0x60,0xA4, /* 00000028    "98.p..`." */
};

static unsigned char Ssdt2Code[] =
{
    0x53,0x53,0x44,0x54,0x30,0x00,0x00,0x00, /* 00000000    "SSDT0..." */
    0x01,0xB7,0x49,0x6E,0x74,0x65,0x6C,0x00, /* 00000008    "..Intel." */
    0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00, /* 00000010    "Many...." */
    0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C, /* 00000018    "....INTL" */
    0x24,0x04,0x03,0x20,0x14,0x0B,0x5F,0x54, /* 00000020    "$.. .._T" */
    0x39,0x39,0x00,0x70,0x0A,0x04,0x60,0xA4, /* 00000028    "99.p..`." */
};

static unsigned char Ssdt3Code[] =
{
    0x53,0x53,0x44,0x54,0x30,0x00,0x00,0x00, /* 00000000    "SSDT0..." */
    0x01,0xAF,0x49,0x6E,0x74,0x65,0x6C,0x00, /* 00000008    "..Intel." */
    0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00, /* 00000010    "Many...." */
    0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C, /* 00000018    "....INTL" */
    0x24,0x04,0x03,0x20,0x14,0x0B,0x5F,0x54, /* 00000020    "$.. .._T" */
    0x39,0x41,0x00,0x70,0x0A,0x04,0x60,0xA4, /* 00000028    "9A.p..`." */
};
#endif

static unsigned char Psdt1Code[] =
{
    0x50,0x53,0x44,0x54,0x30,0x00,0x00,0x00, /* 00000000    "PSDT0..." */
    0x01,0xB1,0x49,0x6E,0x74,0x65,0x6C,0x00, /* 00000008    "..Intel." */
    0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00, /* 00000010    "Many...." */
    0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C, /* 00000018    "....INTL" */
    0x24,0x04,0x03,0x20,0x14,0x0B,0x5F,0x54, /* 00000020    "$.. .._T" */
    0x39,0x42,0x00,0x70,0x0A,0x04,0x60,0xA4, /* 00000028    "9B.p..`." */
};

static unsigned char Oem1Code[] =
{
    0x4F,0x45,0x4D,0x31,0x38,0x00,0x00,0x00, /* 00000000    "OEM18..." */
    0x01,0x4B,0x49,0x6E,0x74,0x65,0x6C,0x00, /* 00000008    ".KIntel." */
    0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00, /* 00000010    "Many...." */
    0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C, /* 00000018    "....INTL" */
    0x18,0x09,0x03,0x20,0x08,0x5F,0x58,0x54, /* 00000020    "... ._XT" */
    0x32,0x0A,0x04,0x14,0x0C,0x5F,0x58,0x54, /* 00000028    "2...._XT" */
    0x31,0x00,0x70,0x01,0x5F,0x58,0x54,0x32, /* 00000030    "1.p._XT2" */

};

#define FADT_DESCRIPTOR_REV2    ACPI_TABLE_FADT
#define RSDT_DESCRIPTOR_REV1    ACPI_TABLE_RSDT


/*
 * We need a local FADT so that the hardware subcomponent will function,
 * even though the underlying OSD HW access functions don't do
 * anything.
 */
static ACPI_TABLE_RSDP      LocalRSDP;
static ACPI_TABLE_FADT      LocalFADT;
static ACPI_TABLE_FACS      LocalFACS;
static ACPI_TABLE_HEADER    LocalDSDT;
static ACPI_TABLE_HEADER    LocalTEST;
static ACPI_TABLE_HEADER    LocalBADTABLE;

#define RSDT_TABLES             9
/* Covers both 32-bit and 64-bit addresses */
#define RSDT_SIZE               (sizeof (ACPI_TABLE_XSDT) +\
        ((RSDT_TABLES -1) * sizeof (UINT64)))

static UINT8                    MemRSDT[RSDT_SIZE];
static RSDT_DESCRIPTOR_REV1     *LocalRSDT = (RSDT_DESCRIPTOR_REV1 *)MemRSDT;

static FADT_DESCRIPTOR_REV2     LocalFADT2;

#define ACPI_MAX_INIT_TABLES (10)
static ACPI_TABLE_DESC      Tables[ACPI_MAX_INIT_TABLES];

/* Like AeCtrlCHandler */
void __cdecl
AtSigHandler (
    int                     Sig)
{
    if (Sig == SIGINT)
    {
        signal (SIGINT, SIG_IGN);
        printf ("Caught a ctrl-c\n\n");
#ifdef ACPI_DEBUGGER
        if (AcpiGbl_MethodExecuting)
        {
            AcpiGbl_AbortMethod = TRUE;
            signal (SIGINT, AtSigHandler);
            return;
        }
#endif
    }
    else
    {
        printf ("Caught Signal %d\n\n", Sig);
    }
    exit (AtRetSigTerm);
}


/*******************************************************************************
 *
 * FUNCTION:    AtInitializeTables
 *
 * PARAMETERS:  None
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Wrappper for AcpiInitializeTables()
 *
 ******************************************************************************/
ACPI_STATUS
AtInitializeTables (
    BOOLEAN                 AllowResize)
{
    return (AcpiInitializeTables(Tables, ACPI_MAX_INIT_TABLES, AllowResize));
}


/* Copy of AcpiTbInitGenericAddress */
static void
AtTbInitGenericAddress (
    ACPI_GENERIC_ADDRESS    *NewGasStruct,
    UINT8                   BitWidth,
    ACPI_PHYSICAL_ADDRESS   Address)
{

    NewGasStruct->Address = Address;
    NewGasStruct->SpaceId = ACPI_ADR_SPACE_SYSTEM_IO;
    NewGasStruct->BitWidth = BitWidth;
    NewGasStruct->BitOffset = 0;
    NewGasStruct->AccessWidth = 0;
}


/*******************************************************************************
 *
 * FUNCTION:    AtBuildLocalDSDT
 *
 * PARAMETERS:  UserTable       - Pointer to User's DSDT AML code or NULL
 *              BldTask         - Build Task for errors intrusion
 *              Actual_DSDT     - Where a pointer to the table is returned
 *
 * RETURN:      None
 *
 * DESCRIPTION: Get an DSDT either from User supplied table or use
 *              the simle local one. Perform errors intrusion handling.
 *
 ******************************************************************************/

static void
AtBuildLocalDSDT (
    ACPI_TABLE_HEADER       *UserTable,
    BLD_TABLES_TASK         BldTask,
    ACPI_TABLE_HEADER       **Actual_DSDT)
{
    /*
     * Examine the incoming user table. At this point, it has been verified
     * to be either a DSDT, SSDT, or a PSDT, but they must be handled differently
     */
    if (UserTable && !ACPI_STRNCMP ((char *) UserTable->Signature, ACPI_SIG_DSDT, 4))
    {
        /* User DSDT is installed directly into the FADT */

        *Actual_DSDT = UserTable;
    }
    else
    {
        /*
         * Build a local DSDT because either there is no incoming table
         * or it is an SSDT or PSDT
         */

        ACPI_MEMSET (&LocalDSDT, 0, sizeof (ACPI_TABLE_HEADER));
        ACPI_STRNCPY (LocalDSDT.Signature, ACPI_SIG_DSDT, 4);
        LocalDSDT.Revision = 1;
        LocalDSDT.Length = sizeof (ACPI_TABLE_HEADER);
        LocalDSDT.Checksum = (UINT8)(0 - AcpiTbChecksum
            ((UINT8 *)&LocalDSDT, LocalDSDT.Length));
        *Actual_DSDT = &LocalDSDT;
    }

    if (BldTask.ErrScale & BAD_SIGNATURE_DSDT)
    {
        ACPI_STRNCPY ((*Actual_DSDT)->Signature, "BADS", 4);
    }
    if (BldTask.ErrScale & BAD_CHECKSUM_DSDT)
    {
        (*Actual_DSDT)->Checksum = (UINT8)~(*Actual_DSDT)->Checksum;
    }
    if (BldTask.ErrScale & BAD_LENGTH_HDR_DSDT)
    {
        (*Actual_DSDT)->Length = sizeof (ACPI_TABLE_HEADER) - 1;
    }
}


/*******************************************************************************
 *
 * FUNCTION:    AtBuildLocalFACS1
 *
 * PARAMETERS:  LocalFACS       - Pointer to the local FACS template
 *              BldTask         - Build Task for errors intrusion
 *
 * RETURN:      None
 *
 * DESCRIPTION: Build Revision 1 FACS image, perform errors intrusion handling.
 *
 ******************************************************************************/

static void
AtBuildLocalFACS1 (
    ACPI_TABLE_FACS    *LocalFACS,
    BLD_TABLES_TASK         BldTask)
{
    ACPI_MEMSET (LocalFACS, 0, sizeof (ACPI_TABLE_FACS));

    ACPI_STRNCPY (LocalFACS->Signature, ACPI_SIG_FACS, 4);
    if (BldTask.ErrScale & BAD_SIGNATURE_FACS)
    {
        ACPI_STRNCPY (LocalFACS->Signature, "BADS", 4);
    }

    LocalFACS->Length = sizeof (ACPI_TABLE_FACS);
    if (BldTask.ErrScale & BAD_LENGTH_HDR_FACS)
    {
        LocalFACS->Length = sizeof (ACPI_TABLE_HEADER) - 1;
    }
    if (BldTask.ErrScale & BAD_LENGTH_DSC_FACS)
    {
        LocalFACS->Length = sizeof (ACPI_TABLE_FACS) - 1;
    }

    LocalFACS->GlobalLock = 0x11AA0011;
//    LocalFACS->GlobalLock = 0;

    LocalFACS->FirmwareWakingVector = 0xAFAEADAC;
}


/*******************************************************************************
 *
 * FUNCTION:    AtBuildLocalFADT1
 *
 * PARAMETERS:  LocalFADT       - Pointer to the local FADT template
 *              LocalFACS       - Pointer to the local FACS template
 *              ActualDSDT      - Where a pointer to the table is returned
 *              UserTable       - Pointer to User's DSDT AML code or NULL
 *              BldTask         - Build Task for errors intrusion
 *
 * RETURN:      None
 *
 * DESCRIPTION: Build Revision 1 FADT image, perform errors intrusion handling.
 *
 ******************************************************************************/

static void
AtBuildLocalFADT1 (
    ACPI_TABLE_FADT         *LocalFADT,
    ACPI_TABLE_FACS         *LocalFACS,
    ACPI_TABLE_HEADER       **ActualDSDT,
    ACPI_TABLE_HEADER       *UserTable,
    BLD_TABLES_TASK         BldTask)
{
    if (BldTask.NoTableScale & BLD_NO_FACS)
    {
        BldTask.ErrScale |= NULL_ADDRESS_FACS;
    }
    if (!(BldTask.ErrScale & NULL_ADDRESS_FACS))
    {
        /* Build a FACS */
        AtBuildLocalFACS1(LocalFACS, BldTask);
    }

    if (BldTask.NoTableScale & BLD_NO_DSDT)
    {
        BldTask.ErrScale |= NULL_ADDRESS_DSDT;
    }
    if (!(BldTask.ErrScale & NULL_ADDRESS_DSDT))
    {
        /* Build a DSDT */
        AtBuildLocalDSDT(UserTable, BldTask, ActualDSDT);
    }

    ACPI_MEMSET (LocalFADT, 0, sizeof (ACPI_TABLE_FADT));
    ACPI_STRNCPY (LocalFADT->Header.Signature, ACPI_SIG_FADT, 4);

    if (BldTask.ErrScale & BAD_SIGNATURE_FADT)
    {
        ACPI_STRNCPY (LocalFADT->Header.Signature, "BADS", 4);
    }

    if (BldTask.ErrScale & NULL_ADDRESS_FACS)
    {
        LocalFADT->Facs = ACPI_PTR_TO_PHYSADDR(NULL);
    }
    else
    {
        LocalFADT->Facs = ACPI_PTR_TO_PHYSADDR (LocalFACS);
    }
    if (BldTask.ErrScale & NULL_ADDRESS_DSDT)
    {
        LocalFADT->Dsdt = ACPI_PTR_TO_PHYSADDR(NULL);
    }
    else
    {
        LocalFADT->Dsdt = ACPI_PTR_TO_PHYSADDR (*ActualDSDT);
    }

    /* System port address of the SMI Command Port */
    if (BldTask.ErrScale & ZERO_SMICMD_FADT)
    {
        LocalFADT->SmiCommand = 0;
    }
    else
    {
        LocalFADT->SmiCommand = 0x10;
    }

    LocalFADT->AcpiEnable = 0x01;
    LocalFADT->AcpiDisable = 0x02;
    LocalFADT->Header.Revision = 1;
    LocalFADT->Header.Length = ACPI_FADT_OFFSET (ResetRegister); //sizeof (FADT_DESCRIPTOR);
    LocalFADT->Gpe0BlockLength = 16;
    LocalFADT->Gpe1BlockLength = 6;
    LocalFADT->Gpe1Base = 96;

    LocalFADT->Pm1EventLength = 4;
    LocalFADT->Pm1ControlLength = 2;
    LocalFADT->Pm2ControlLength = 1; /* optional */
    LocalFADT->PmTimerLength = 4;

    LocalFADT->Gpe0Block = 0x00001234;
    LocalFADT->Gpe1Block = 0x00005678;

    LocalFADT->Pm1aEventBlock = 0x00001aaa;
    LocalFADT->Pm1bEventBlock = 0;
    LocalFADT->PmTimerBlock = 0xA00;
    LocalFADT->Pm1aControlBlock = 0xB00;
    LocalFADT->Pm2ControlBlock = 0xD00; /* optional */

    if (BldTask.ErrScale & BAD_LENGTH_HDR_FADT)
    {
        LocalFADT->Header.Length = sizeof (ACPI_TABLE_HEADER) - 1;
    }
    if (BldTask.ErrScale & BAD_LENGTH_DSC_FADT)
    {
        LocalFADT->Header.Length = ACPI_FADT_OFFSET (ResetRegister) - 1;
    }

    /* Complete the FADT with the checksum */

    LocalFADT->Header.Checksum = (UINT8)(0 - AcpiTbChecksum
        ((UINT8 *)&LocalFADT->Header, LocalFADT->Header.Length));
    if (BldTask.ErrScale & BAD_CHECKSUM_FADT)
    {
        LocalFADT->Header.Checksum = (UINT8)~LocalFADT->Header.Checksum;
    }
}

/*******************************************************************************
 *
 * FUNCTION:    AtBuildLocalFADT2
 *
 * PARAMETERS:  LocalFADT       - Pointer to the local FADT template
 *              LocalFACS       - Pointer to the local FACS template
 *              ActualDSDT      - Where a pointer to the table is returned
 *              UserTable       - Pointer to User's DSDT AML code or NULL
 *              BldTask         - Build Task for errors intrusion
 *
 * RETURN:      None
 *
 * DESCRIPTION: Build Revision 2 FADT image, perform errors intrusion handling.
 *
 ******************************************************************************/

static void
AtBuildLocalFADT2 (
    FADT_DESCRIPTOR_REV2    *LocalFADT,
    ACPI_TABLE_FACS    *LocalFACS,
    ACPI_TABLE_HEADER       **ActualDSDT,
    ACPI_TABLE_HEADER       *UserTable,
    BLD_TABLES_TASK         BldTask)
{
    if (BldTask.NoTableScale & BLD_NO_FACS)
    {
        BldTask.ErrScale |= NULL_ADDRESS_FACS;
    }
    if (!(BldTask.ErrScale & NULL_ADDRESS_FACS))
    {
        /* Build a FACS */
        AtBuildLocalFACS1(LocalFACS, BldTask);
    }

    if (BldTask.NoTableScale & BLD_NO_DSDT)
    {
        BldTask.ErrScale |= NULL_ADDRESS_DSDT;
    }
    if (!(BldTask.ErrScale & NULL_ADDRESS_DSDT))
    {
        /* Build a DSDT */
        AtBuildLocalDSDT(UserTable, BldTask, ActualDSDT);
    }

    ACPI_MEMSET (LocalFADT, 0, sizeof (ACPI_TABLE_FADT));
    ACPI_STRNCPY (LocalFADT->Header.Signature, ACPI_SIG_FADT, 4);

    if (BldTask.ErrScale & BAD_SIGNATURE_FADT)
    {
        ACPI_STRNCPY (LocalFADT->Header.Signature, "BADS", 4);
    }

    if (BldTask.ErrScale & NULL_ADDRESS_FACS)
    {
        LocalFADT->XFacs = ACPI_PTR_TO_PHYSADDR(NULL);
    }
    else
    {
        LocalFADT->XFacs = ACPI_PTR_TO_PHYSADDR (LocalFACS);
    }
    if (BldTask.ErrScale & NULL_ADDRESS_DSDT)
    {
        LocalFADT->XDsdt = ACPI_PTR_TO_PHYSADDR(NULL);
    }
    else
    {
        LocalFADT->XDsdt = ACPI_PTR_TO_PHYSADDR (*ActualDSDT);
    }

    /* System port address of the SMI Command Port */
    if (BldTask.ErrScale & ZERO_SMICMD_FADT)
    {
        LocalFADT->SmiCommand = 0;
    }
    else
    {
        LocalFADT->SmiCommand = 0x10;
    }

    LocalFADT->AcpiEnable = 0x01;
    LocalFADT->AcpiDisable = 0x02;
    LocalFADT->Header.Revision = 3;
    LocalFADT->Header.Length = sizeof (FADT_DESCRIPTOR_REV2);
    LocalFADT->Gpe0BlockLength = 16;
    LocalFADT->Gpe1BlockLength = 6;
    LocalFADT->Gpe1Base = 96;

    LocalFADT->Pm1EventLength = 4;
    LocalFADT->Pm1ControlLength = 4;
    LocalFADT->Pm2ControlLength = 1; /* optional */
    LocalFADT->PmTimerLength = 8;

    /*
     * Convert the addresses to V2.0 GAS structures
     */

    AtTbInitGenericAddress (&LocalFADT->XGpe0Block, 0,
                             (ACPI_PHYSICAL_ADDRESS)   0x12340000);
    AtTbInitGenericAddress (&LocalFADT->XGpe1Block, 0,
                             (ACPI_PHYSICAL_ADDRESS)   0x56780000);

    AtTbInitGenericAddress (&LocalFADT->XPm1aEventBlock, LocalFADT->Pm1EventLength,
                             (ACPI_PHYSICAL_ADDRESS)   0x1aaa0000);
    AtTbInitGenericAddress (&LocalFADT->XPm1bEventBlock, LocalFADT->Pm1EventLength,
                             (ACPI_PHYSICAL_ADDRESS)   0);
    AtTbInitGenericAddress (&LocalFADT->XPm1aControlBlock, LocalFADT->Pm1ControlLength,
                             (ACPI_PHYSICAL_ADDRESS)   0xB0);
    AtTbInitGenericAddress (&LocalFADT->XPm1bControlBlock, LocalFADT->Pm1ControlLength,
                             (ACPI_PHYSICAL_ADDRESS)   0);
    AtTbInitGenericAddress (&LocalFADT->XPm2ControlBlock, LocalFADT->Pm2ControlLength,
                             (ACPI_PHYSICAL_ADDRESS)   0xD0);
    AtTbInitGenericAddress (&LocalFADT->XPmTimerBlock, LocalFADT->PmTimerLength,
                             (ACPI_PHYSICAL_ADDRESS)   0xA0);

    if (BldTask.ErrScale & BAD_LENGTH_HDR_FADT)
    {
        LocalFADT->Header.Length = sizeof (ACPI_TABLE_HEADER) - 1;
    }
    if (BldTask.ErrScale & BAD_LENGTH_DSC_FADT)
    {
        LocalFADT->Header.Length = sizeof (FADT_DESCRIPTOR_REV2) - 1;
    }

    /* Complete the FADT with the checksum */

    LocalFADT->Header.Checksum = (UINT8)(0 - AcpiTbChecksum
        ((UINT8 *)&LocalFADT->Header, LocalFADT->Header.Length));
    if (BldTask.ErrScale & BAD_CHECKSUM_FADT)
    {
        LocalFADT->Header.Checksum = (UINT8)~LocalFADT->Header.Checksum;
    }
}


/*******************************************************************************
 *
 * FUNCTION:    AtBuildLocalRSDT
 *
 * PARAMETERS:  LocalRSDT       - Pointer to the local FADT template
 *              UserTable       - Pointer to User's DSDT AML code or NULL
 *              BldTask         - Build Task for errors intrusion
 *
 * RETURN:      None
 *
 * DESCRIPTION: Build Revision 1 RSDT image, perform errors intrusion handling.
 *
 ******************************************************************************/

static void
AtBuildLocalRSDT (
    RSDT_DESCRIPTOR_REV1    *LocalRSDT,
    ACPI_TABLE_HEADER       *UserTable,
    BLD_TABLES_TASK         BldTask)
{
    ACPI_TABLE_HEADER       *Actual_DSDT = NULL;
    int                     i = 0;

    if (BldTask.ErrScale & NOT_PRESENT_FADT)
    {
        BldTask.NoTableScale |= BLD_NO_FADT;
    }

    ACPI_MEMSET (LocalRSDT, 0, RSDT_SIZE);

    ACPI_STRNCPY (LocalRSDT->Header.Signature, ACPI_SIG_RSDT, 4);
    if (BldTask.ErrScale & BAD_SIGNATURE_RSDT)
    {
        ACPI_STRNCPY (LocalRSDT->Header.Signature, "BADS", 4);
    }

    if (!(BldTask.NoTableScale & BLD_NO_FADT))
    {
        /* Build a FADT so we can test the hardware/event init */
        AtBuildLocalFADT1(&LocalFADT, &LocalFACS, &Actual_DSDT, UserTable, BldTask);

        LocalRSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&LocalFADT);
    }

    if (Actual_DSDT &&
        (!ACPI_STRNCMP ((char *) Actual_DSDT->Signature, ACPI_SIG_SSDT, 4) ||
         !ACPI_STRNCMP ((char *) Actual_DSDT->Signature, ACPI_SIG_PSDT, 4)))
    {
        LocalRSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (UserTable);
    }

    if (!(BldTask.NoTableScale & BLD_NO_BADT))
    {
        /*
         * Build a fake table with a bad signature so that
         * we make sure that the CA core ignores it
         */

        ACPI_MEMSET (&LocalBADTABLE, 0, sizeof (ACPI_TABLE_HEADER));
        ACPI_STRNCPY (LocalBADTABLE.Signature, "BAD!", 4);

        LocalBADTABLE.Revision = 1;
        LocalBADTABLE.Length = sizeof (ACPI_TABLE_HEADER);

        LocalRSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&LocalBADTABLE);
    }

    /* Install two SSDTs to test multiple table support */

    if (!(BldTask.NoTableScale & BLD_NO_SSDT1))
    {
        LocalRSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&Ssdt1Code);
        LocalRSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&Psdt1Code);
    }
    if (!(BldTask.NoTableScale & BLD_NO_SSDT2))
    {
        LocalRSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&Ssdt2Code);
        LocalRSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&Ssdt3Code);
    }

    /* Install the OEM1 table to test LoadTable */

    if (!(BldTask.NoTableScale & BLD_NO_OEM1))
    {
        LocalRSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&Oem1Code);
    }


    /* Build a fake table so that we make sure that the CA core ignores it */

    if (!(BldTask.NoTableScale & BLD_NO_TEST))
    {
        ACPI_MEMSET (&LocalTEST, 0, sizeof (ACPI_TABLE_HEADER));
        ACPI_STRNCPY (LocalTEST.Signature, "TEST", 4);

        LocalTEST.Revision = 1;
        LocalTEST.Length = sizeof (ACPI_TABLE_HEADER);

        LocalRSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&LocalTEST);
    }

    LocalRSDT->Header.Length = sizeof (RSDT_DESCRIPTOR_REV1) +
        (i - 1) * sizeof (UINT32);

    if (BldTask.ErrScale & BAD_LENGTH_HDR_RSDT)
    {
        LocalRSDT->Header.Length = sizeof (ACPI_TABLE_HEADER) - 1;
    }

    /* Set checksums for RSDT */

    LocalRSDT->Header.Checksum = (UINT8)(0 - AcpiTbChecksum
        ((UINT8 *)&LocalRSDT->Header, LocalRSDT->Header.Length));
    if (BldTask.ErrScale & BAD_CHECKSUM_RSDT)
    {
        LocalRSDT->Header.Checksum = (UINT8)~LocalRSDT->Header.Checksum;
    }
}


/*******************************************************************************
 *
 * FUNCTION:    AtBuildLocalXSDT
 *
 * PARAMETERS:  LocalXSDT       - Pointer to the local XSDT template
 *              UserTable       - Pointer to User's DSDT AML code or NULL
 *              BldTask         - Build Task for errors intrusion
 *
 * RETURN:      None
 *
 * DESCRIPTION: Build Revision 2 XSDT image, perform errors intrusion handling.
 *
 ******************************************************************************/

static ACPI_STATUS
AtBuildLocalXSDT (
    ACPI_TABLE_XSDT    *LocalXSDT,
    ACPI_TABLE_HEADER       *UserTable,
    BLD_TABLES_TASK         BldTask)
{
    ACPI_TABLE_HEADER       *Actual_DSDT = NULL;
    int                     i = 0;

    if (BldTask.ErrScale & NOT_PRESENT_FADT)
    {
        BldTask.NoTableScale |= BLD_NO_FADT;
    }

    ACPI_MEMSET (LocalXSDT, 0, RSDT_SIZE);

    ACPI_STRNCPY (LocalXSDT->Header.Signature, ACPI_SIG_XSDT, 4);
    if (BldTask.ErrScale & BAD_SIGNATURE_RSDT)
    {
        ACPI_STRNCPY (LocalXSDT->Header.Signature, "BADS", 4);
    }

    if (!(BldTask.NoTableScale & BLD_NO_BADT))
    {
        /*
         * Build a fake table with a bad signature so that
         * we make sure that the CA core ignores it
         */

        ACPI_MEMSET (&LocalBADTABLE, 0, sizeof (ACPI_TABLE_HEADER));
        ACPI_STRNCPY (LocalBADTABLE.Signature, "BAD!", 4);

        LocalBADTABLE.Revision = 1;
        LocalBADTABLE.Length = sizeof (ACPI_TABLE_HEADER);

        LocalXSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&LocalBADTABLE);
    }

    if (!(BldTask.NoTableScale & BLD_NO_FADT))
    {
        /* Build a FADT so we can test the hardware/event init */
        AtBuildLocalFADT2(&LocalFADT2, &LocalFACS, &Actual_DSDT, UserTable, BldTask);
        LocalXSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&LocalFADT2);
    }

    if (Actual_DSDT &&
        (!ACPI_STRNCMP ((char *) Actual_DSDT->Signature, ACPI_SIG_SSDT, 4) ||
         !ACPI_STRNCMP ((char *) Actual_DSDT->Signature, ACPI_SIG_PSDT, 4)))
    {
        LocalXSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (UserTable);
    }

    /* Install two SSDTs to test multiple table support */

    if (!(BldTask.NoTableScale & BLD_NO_SSDT1))
    {
        LocalXSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&Ssdt1Code);
        LocalXSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&Psdt1Code);
    }
    if (!(BldTask.NoTableScale & BLD_NO_SSDT2))
    {
        LocalXSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&Ssdt2Code);
        LocalXSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&Ssdt3Code);
    }

    /* Install the OEM1 table to test LoadTable */

    if (!(BldTask.NoTableScale & BLD_NO_OEM1))
    {
        LocalXSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&Oem1Code);
    }


    /* Build a fake table so that we make sure that the CA core ignores it */

    if (!(BldTask.NoTableScale & BLD_NO_TEST))
    {
        ACPI_MEMSET (&LocalTEST, 0, sizeof (ACPI_TABLE_HEADER));
        ACPI_STRNCPY (LocalTEST.Signature, "TEST", 4);

        LocalTEST.Revision = 1;
        LocalTEST.Length = sizeof (ACPI_TABLE_HEADER);

        LocalXSDT->TableOffsetEntry[i++] = ACPI_PTR_TO_PHYSADDR (&LocalTEST);
    }

    if (i > RSDT_TABLES)
    {
        TestErrors++;
        printf ("Test Error in AtBuildLocalXSDT: instances"
            " for RSDP (%d) should be < %d\n",
            i, RSDT_TABLES);
        return (AE_ERROR);
    }

    LocalXSDT->Header.Length = ((ACPI_SIZE) i * sizeof (UINT64)) +
                    sizeof (ACPI_TABLE_HEADER);

    if (BldTask.ErrScale & BAD_LENGTH_HDR_RSDT)
    {
        LocalXSDT->Header.Length = sizeof (ACPI_TABLE_HEADER) - 1;
    }

    /* Set checksums for RSDT */

    LocalXSDT->Header.Checksum = (UINT8)(0 - AcpiTbChecksum
        ((UINT8 *)&LocalXSDT->Header, LocalXSDT->Header.Length));
    if (BldTask.ErrScale & BAD_CHECKSUM_RSDT)
    {
        LocalXSDT->Header.Checksum = (UINT8)~LocalXSDT->Header.Checksum;
    }

    return (AE_OK);
}


/******************************************************************************
 *
 * FUNCTION:    AtBuildLocalTables
 *
 * PARAMETERS:  UserTable       - Pointer to User's DSDT AML code or NULL
 *              BldTask         - Build Task for errors intrusion
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Build the ACPI tables and file in RSDP structure.
 *
 *****************************************************************************/

ACPI_STATUS
AtBuildLocalTables (
    ACPI_TABLE_HEADER       *UserTable,
    BLD_TABLES_TASK         BldTask)
{
    /* Build an RSDT and its members */
#if ACPI_MACHINE_WIDTH == 64
    AtBuildLocalXSDT((ACPI_TABLE_XSDT *)LocalRSDT, UserTable, BldTask);
#else
    AtBuildLocalRSDT(LocalRSDT, UserTable, BldTask);
#endif

    /* Build an RSDP */

    ACPI_MEMSET (&LocalRSDP, 0, sizeof (ACPI_TABLE_RSDP));
    ACPI_STRNCPY (LocalRSDP.Signature, ACPI_SIG_RSDP, 8);
    if (BldTask.ErrScale & BAD_SIGNATURE_RSDP)
    {
        ACPI_STRNCPY (LocalRSDP.Signature, "BAD SIGN", 8);
    }
#if ACPI_MACHINE_WIDTH == 64
    LocalRSDP.Revision = 2;
    LocalRSDP.XsdtPhysicalAddress = ACPI_PTR_TO_PHYSADDR (LocalRSDT);
#else
    LocalRSDP.Revision = 1;
    LocalRSDP.RsdtPhysicalAddress = ACPI_PTR_TO_PHYSADDR (LocalRSDT);
#endif

    /* Set checksums for RSDP */

    LocalRSDP.Checksum = (UINT8) (0 - AcpiTbChecksum
        ((UINT8 *) &LocalRSDP, ACPI_RSDP_CHECKSUM_LENGTH));
    if (BldTask.ErrScale & BAD_CHECKSUM_RSDP)
    {
        LocalRSDP.Checksum = (UINT8)~LocalRSDP.Checksum;
    }
#if ACPI_MACHINE_WIDTH == 64
    LocalRSDP.ExtendedChecksum = (UINT8) (0 - AcpiTbChecksum
        ((UINT8 *) &LocalRSDP, ACPI_RSDP_XCHECKSUM_LENGTH));
#endif

    return (AE_OK);
}


/******************************************************************************
 *
 * FUNCTION:    AtGetTableHeader
 *
 * PARAMETERS:  Type            - Type of the requested table
 *              Instance        - Can be not 1 if Type supports multiple tables
 *              Table           - Where a pointer to the table is returned
 *              BldTask         - Build Task for errors intrusion
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Build the ACPI tables and file in RSDP structure.
 *
 *****************************************************************************/

ACPI_STATUS
AtGetTableHeader (
    char                    *Type,
    UINT32                  Instance,
    ACPI_TABLE_HEADER       **Table,
    BLD_TABLES_TASK         BldTask)
{
    ACPI_STATUS             Status = AE_OK;
    ACPI_TABLE_HEADER       *Actual_DSDT = NULL;

    if (!ACPI_COMPARE_NAME(Type, ACPI_SIG_SSDT) && (Instance != 1))
    {
        TestErrors++;
        printf ("Test Error in AtGetTableHeader: for Type %s"
            " Instance should be 1, not %d\n",
            Type, Instance);
        *Table = NULL;
        return (AE_ERROR);
    }

    if (ACPI_COMPARE_NAME(Type, ACPI_SIG_RSDP))
    {
        AtBuildLocalTables(NULL, BldTask);
        *Table = (ACPI_TABLE_HEADER *)&LocalRSDP;
    } else if (ACPI_COMPARE_NAME(Type, ACPI_SIG_DSDT))
    {
        AtBuildLocalDSDT(NULL, BldTask, &Actual_DSDT);
        *Table = Actual_DSDT;
    } else if (ACPI_COMPARE_NAME(Type, ACPI_SIG_FACS))
    {
        AtBuildLocalFACS1(&LocalFACS, BldTask);
        *Table = (ACPI_TABLE_HEADER *)&LocalFACS;
    } else if (ACPI_COMPARE_NAME(Type, ACPI_SIG_FADT))
    {
        BldTask.NoTableScale &= ~(BLD_NO_FACS | BLD_NO_DSDT);
        AtBuildLocalFADT1(&LocalFADT, &LocalFACS, &Actual_DSDT, NULL, BldTask);
        *Table = (ACPI_TABLE_HEADER *)&LocalFADT;
    } else if (ACPI_COMPARE_NAME(Type, ACPI_SIG_PSDT))
    {
        *Table = (ACPI_TABLE_HEADER *)&Psdt1Code;
    } else if (ACPI_COMPARE_NAME(Type, ACPI_SIG_SSDT))
    {
        switch (Instance)
        {
        case 1:
            *Table = (ACPI_TABLE_HEADER *)&Ssdt1Code;
            break;
        case 2:
            *Table = (ACPI_TABLE_HEADER *)&Ssdt2Code;
            break;
        case 3:
            *Table = (ACPI_TABLE_HEADER *)&Ssdt3Code;
            break;
        default:
            TestErrors++;
            printf ("Test Error in AtGetTableHeader: for SSDT"
                " Instance should be in range 1-3, not %d\n",
                Instance);
            *Table = NULL;
            Status = AE_ERROR;
            break;
        }
    } else if (ACPI_COMPARE_NAME(Type, ACPI_SIG_XSDT))
    {
//        BldTask.NoTableScale &= ~(BLD_NO_FACS | BLD_NO_DSDT | BLD_NO_FADT);
        AtBuildLocalDSDT(NULL, BldTask, &Actual_DSDT);
        Status = AtBuildLocalXSDT((ACPI_TABLE_XSDT *)LocalRSDT,
            Actual_DSDT, BldTask);
/*
        AtBuildLocalRSDT(LocalRSDT, NULL, BldTask);
*/
        if (ACPI_FAILURE(Status))
        {
            *Table = NULL;
        }
        else
        {
            *Table = (ACPI_TABLE_HEADER *)LocalRSDT;
        }
    } else
    {
        TestErrors++;
        printf ("Test Error in AtGetTableHeader: unexpected table Type '%s'\n",
            Type);
        *Table = NULL;
        Status = AE_ERROR;
   }

    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AeLocalGetRootPointer
 *
 * PARAMETERS:
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Return a local RSDP, used to dynamically load tables via the
 *              standard ACPI mechanism.
 *
 *****************************************************************************/
/*
ACPI_STATUS
AeLocalGetRootPointer (
    UINT32                  Flags,
    ACPI_POINTER            *Address)
{
    if (Flags != ACPI_LOGICAL_ADDRESSING)
    {
        printf ("AtLocalGetRootPointer: Flags (0x%x) !="
            " ACPI_LOGICAL_ADDRESSING (0x%x)\n",
            Flags, ACPI_LOGICAL_ADDRESSING);
        return (AE_ERROR);
    }

    Address->PointerType = ACPI_LOGICAL_POINTER;
    Address->Pointer.Logical = &LocalRSDP;
    return (AE_OK);
}
*/
ACPI_PHYSICAL_ADDRESS
AeLocalGetRootPointer (
    void)
{

    return ((ACPI_PHYSICAL_ADDRESS) &LocalRSDP);
}


typedef struct Region
{
    ACPI_PHYSICAL_ADDRESS   Address;
    UINT32                  Length;
    void                    *Buffer;
    void                    *NextRegion;

} REGION;

typedef struct DebugRegions
{
    UINT32                  NumberOfRegions;
    REGION                  *RegionList;

} DEBUG_REGIONS;

#define GET_SEGMENT(ptr)                ((UINT16)(_segment)(ptr))
#define GET_OFFSET(ptr)                 ((UINT16)(UINT32) (ptr))
#define GET_PHYSICAL_ADDRESS(ptr)       (((((UINT32)GET_SEGMENT(ptr)) << 4)) + GET_OFFSET(ptr))
#define PTR_OVL_BUILD_PTR(p,b,o)        {p.ovl.base=b;p.ovl.offset=o;}


#define TEST_OUTPUT_LEVEL(lvl)          if ((lvl) & OutputLevel)

#define OSD_PRINT(lvl,fp)               TEST_OUTPUT_LEVEL(lvl) {\
                                            AcpiOsPrintf PARAM_LIST(fp);}

DEBUG_REGIONS               AeRegions;


/******************************************************************************
 *
 * FUNCTION:    AeGetRegionBufferAddress
 *
 * PARAMETERS:  RegionObject
 *
 * RETURN:      Address
 *
 * DESCRIPTION: Returns the address of the Region's first byte
 *              in the respective emulation buffer.
 *
 *****************************************************************************/

ACPI_PHYSICAL_ADDRESS
AeGetRegionBufferAddress (
    ACPI_OPERAND_OBJECT     *RegionObject)
{

    ACPI_PHYSICAL_ADDRESS   BaseAddress;
    ACPI_PHYSICAL_ADDRESS   RetAddress = (ACPI_PHYSICAL_ADDRESS) NULL;
    ACPI_SIZE               Length;
    REGION                  *RegionElement;


    ACPI_FUNCTION_NAME (AeGetRegionBufferAddress);


    /*
     * If the object is not a region, return NULL
     */
    if ((RegionObject->Region.Type != ACPI_TYPE_REGION) ||
        (RegionObject->Region.SpaceId == ACPI_ADR_SPACE_SMBUS))
    {
        return (RetAddress);
    }

    /*
     * Find the region's address space and length before searching
     * the linked list.
     */
    BaseAddress = RegionObject->Region.Address;
    Length = (ACPI_SIZE) RegionObject->Region.Length;

    ACPI_DEBUG_PRINT ((ACPI_DB_OPREGION, "OpRegion Address request on %s\n",
            AcpiUtGetRegionName (RegionObject->Region.SpaceId)));

    /*
     * Search through the linked list for this region's buffer
     */
    RegionElement = AeRegions.RegionList;

    if (AeRegions.NumberOfRegions)
    {
        while (RegionElement)
        {
            if (RegionElement->Address == BaseAddress &&
                RegionElement->Length == Length)
            {
                RetAddress = (ACPI_PHYSICAL_ADDRESS) RegionElement->Buffer;
                break;
            }
            else
            {
                RegionElement = RegionElement->NextRegion;
            }
        }
    }

    /*
     * If the Region buffer does not exist, create it now
     */
    if (!RetAddress)
    {
        /*
         * Do the memory allocations first
         */
/*
        RegionElement = AcpiOsAllocate (sizeof (REGION));
*/
        RegionElement = malloc (sizeof (REGION));
        if (!RegionElement)
        {
            return (RetAddress);
        }

/*
        RegionElement->Buffer = AcpiOsAllocate (Length);
*/
        RegionElement->Buffer = malloc (Length);
        if (!RegionElement->Buffer)
        {
/*
            AcpiOsFree (RegionElement);
*/
            free (RegionElement);
            return (RetAddress);
        }

        ACPI_MEMSET (RegionElement->Buffer, 0, Length);
        RegionElement->Address = BaseAddress;
        RegionElement->Length = Length;
        RegionElement->NextRegion = NULL;

        /*
         * Increment the number of regions and put this one
         *  at the head of the list as it will probably get accessed
         *  more often anyway.
         */
        AeRegions.NumberOfRegions += 1;

        if (AeRegions.RegionList)
        {
            RegionElement->NextRegion = AeRegions.RegionList;
        }

        AeRegions.RegionList = RegionElement;

        RetAddress = (ACPI_PHYSICAL_ADDRESS) RegionElement->Buffer;
    }

    return (RetAddress);
}


/******************************************************************************
 *
 * FUNCTION:    AeSmbusRegionHandler
 *
 * PARAMETERS:  Standard region handler parameters
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Test handler - Handles some dummy regions via memory that can
 *              be manipulated in Ring 3.
 *
 *****************************************************************************/

ACPI_STATUS
AeSmbusRegionHandler (
    UINT32                  Function,
    ACPI_INTEGER            *Value)
{
    ACPI_SIZE               Length;
    UINT32                  i;


    Length = 0;

    switch (Function & ACPI_IO_MASK)
    {
    case ACPI_READ:
        switch (Function >> 16)
        {
        case AML_FIELD_ATTRIB_QUICK:
        case AML_FIELD_ATTRIB_SEND_RCV:
        case AML_FIELD_ATTRIB_BYTE:
            Length = 1;
            break;

        case AML_FIELD_ATTRIB_WORD:
        case AML_FIELD_ATTRIB_WORD_CALL:
            Length = 2;
            break;

        case AML_FIELD_ATTRIB_BLOCK:
        case AML_FIELD_ATTRIB_BLOCK_CALL:
            Length = 32;
            break;

        default:
            break;
        }
        break;

    case ACPI_WRITE:
        switch (Function >> 16)
        {
        case AML_FIELD_ATTRIB_QUICK:
        case AML_FIELD_ATTRIB_SEND_RCV:
        case AML_FIELD_ATTRIB_BYTE:
        case AML_FIELD_ATTRIB_WORD:
        case AML_FIELD_ATTRIB_BLOCK:
            Length = 0;
            break;

        case AML_FIELD_ATTRIB_WORD_CALL:
            Length = 2;
            break;

        case AML_FIELD_ATTRIB_BLOCK_CALL:
            Length = 32;
            break;

        default:
            break;
        }
        break;

    default:
        break;
    }

    for (i = 0; i < Length; i++)
    {
        ((UINT8 *) Value)[i+2] = (UINT8) (0xA0 + i);
    }

    ((UINT8 *) Value)[0] = 0x7A;
    ((UINT8 *) Value)[1] = (UINT8) Length;

    return (AE_OK);
}


/******************************************************************************
 *
 * FUNCTION:    AeRegionHandler
 *
 * PARAMETERS:  Standard region handler parameters
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Test handler - Handles some dummy regions via memory that can
 *              be manipulated in Ring 3.
 *
 *****************************************************************************/

ACPI_STATUS
AeRegionHandler (
    UINT32                  Function,
    ACPI_PHYSICAL_ADDRESS   Address,
    UINT32                  BitWidth,
    ACPI_INTEGER            *Value,
    void                    *HandlerContext,
    void                    *RegionContext)
{
    ACPI_OPERAND_OBJECT     *RegionObject = (ACPI_OPERAND_OBJECT*) RegionContext;
    ACPI_PHYSICAL_ADDRESS   BaseAddress;
    ACPI_PHYSICAL_ADDRESS   BufferAddress;
    ACPI_SIZE               Length;
    void                    *BufferValue;
    UINT32                  ByteWidth;


    ACPI_FUNCTION_NAME ("AeRegionHandler");


    /*
     * If the object is not a region, simply return
     */
    if (RegionObject->Region.Type != ACPI_TYPE_REGION)
    {
        return (AE_OK);
    }

    /*
     * Find the region's address space and length before searching
     * the linked list.
     */
    BaseAddress = RegionObject->Region.Address;
    Length = (ACPI_SIZE) RegionObject->Region.Length;

    ACPI_DEBUG_PRINT ((ACPI_DB_OPREGION, "Operation Region request on %s at 0x%X\n",
            AcpiUtGetRegionName (RegionObject->Region.SpaceId),
            (UINT32) Address));

    if (RegionObject->Region.SpaceId == ACPI_ADR_SPACE_SMBUS)
    {
        return (AeSmbusRegionHandler(Function, Value));
    }

    BufferAddress = AeGetRegionBufferAddress(RegionObject);
    if (!BufferAddress)
    {
        return (AE_NO_MEMORY);
    }

    /*
     * Calculate the size of the memory copy
     */
    ByteWidth = (BitWidth / 8);

    if (BitWidth % 8)
    {
        ByteWidth += 1;
    }

    /*
     * The buffer exists and is pointed to by RegionElement.
     * We now need to verify the request is valid and perform the operation.
     *
     * NOTE: RegionElement->Header.Length is in bytes, therefore it we compare against
     * ByteWidth (see above)
     */
    if (((ACPI_INTEGER) Address + ByteWidth) >
        ((ACPI_INTEGER)(BufferAddress) + Length))
    {
        ACPI_WARNING ((AE_INFO,
            "Request on [%4.4s] is beyond region limit Req-%X+%X, Base=%X, Len-%X\n",
            (RegionObject->Region.Node)->Name.Ascii, (UINT32) Address,
            ByteWidth, (UINT32) BufferAddress, Length));

        return (AE_AML_REGION_LIMIT);
    }

    /*
     * Get BufferValue to point to the "address" in the buffer
     */
    BufferValue = ((UINT8 *) BufferAddress +
                    ((ACPI_INTEGER) Address - (ACPI_INTEGER) BaseAddress));

    /*
     * Perform a read or write to the buffer space
     */
    switch (Function)
    {
    case ACPI_READ:
        /*
         * Set the pointer Value to whatever is in the buffer
         */
        ACPI_MEMCPY (Value, BufferValue, ByteWidth);
        break;

    case ACPI_WRITE:
        /*
         * Write the contents of Value to the buffer
         */
        ACPI_MEMCPY (BufferValue, Value, ByteWidth);
        break;

    default:
        return (AE_BAD_PARAMETER);
    }
    return (AE_OK);
}


/******************************************************************************
 *
 * FUNCTION:    AeRegionInit
 *
 * PARAMETERS:  None
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Opregion init function.
 *
 *****************************************************************************/

ACPI_STATUS
AeRegionInit (
    ACPI_HANDLE                 RegionHandle,
    UINT32                      Function,
    void                        *HandlerContext,
    void                        **RegionContext)
{
    /*
     * Real simple, set the RegionContext to the RegionHandle
     */
    *RegionContext = RegionHandle;

    return (AE_OK);
}


/******************************************************************************
 *
 * FUNCTION:    AtRegionCleanup
 *
 * PARAMETERS:  None
 *
 * RETURN:      None
 *
 * DESCRIPTION: OpRegions cleanup function.
 *
 *****************************************************************************/

void
AtRegionCleanup (void)
{
    REGION                  *RegionElement;

    while (AeRegions.NumberOfRegions)
    {
        AeRegions.NumberOfRegions--;
        RegionElement = AeRegions.RegionList;
        AeRegions.RegionList = RegionElement->NextRegion;
        free(RegionElement->Buffer);
        free(RegionElement);
    }

    return;
}

/******************************************************************************
 *
 * FUNCTION:    AeInstallHandlers
 *
 * PARAMETERS:  None
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Install handlers for the AAPITS likely AcpiExec utility.
 *              NOTE: Only AdrSpace handlers are installed.
 *
 *****************************************************************************/

ACPI_ADR_SPACE_TYPE         SpaceId[] = {0, 1, 2, 3, 4, 0x80};
#define AEXEC_NUM_REGIONS   6

ACPI_STATUS
AeInstallHandlers (void)
{
    ACPI_STATUS             Status = AE_OK;
    UINT32                  i;

    ACPI_FUNCTION_NAME ("AeInstallHandlers");

    AtRegionCleanup();

    /*
    */
    for (i = 0; i < AEXEC_NUM_REGIONS; i++)
    {
        if (i == 2)
        {
            continue;
        }

        Status = AcpiRemoveAddressSpaceHandler (ACPI_ROOT_OBJECT,
                        SpaceId[i], AeRegionHandler);

        /* Install handler at the root object.
         * TBD: all default handlers should be installed here!
         */
        Status = AcpiInstallAddressSpaceHandler (ACPI_ROOT_OBJECT,
                        SpaceId[i], AeRegionHandler, AeRegionInit, NULL);
        if (ACPI_FAILURE (Status))
        {
            ACPI_ERROR ((AE_INFO,
                "Could not install an OpRegion handler for %s space(%d), %s\n",
                AcpiUtGetRegionName((UINT8) SpaceId[i]), SpaceId[i],
                AcpiFormatException (Status)));
            return (Status);
        }
    }

    /*
     * Initialize the global Region Handler space
     * MCW 3/23/00
     */
    AeRegions.NumberOfRegions = 0;
    AeRegions.RegionList = NULL;

    return (Status);
}


/*******************************************************************************
 *
 * FUNCTION:    AtReadTableFromFile
 *
 * PARAMETERS:  Filename         - File where table is located
 *              Table            - Where a pointer to the table is returned
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Get an ACPI table from a file, AcpiDbReadTableFromFile and
 *              AcpiDbReadTable do the same but this routine manages without
 *              OSL functions usage and does not require any validation.
 *
 ******************************************************************************/

ACPI_STATUS
AtReadTableFromFile (
    char                    *Filename,
    ACPI_TABLE_HEADER       **Table)
{
    FILE                    *fp;
    ACPI_TABLE_HEADER       TableHeader;
    UINT32                  Actual;
    UINT32                  FileSize;

    printf ("Reading Acpi table from file %s\n", Filename);

    /* Open the file */

    fp = fopen (Filename, "rb");
    if (!fp)
    {
        printf ("Could not open input file %s\n", Filename);
        return (AE_ERROR);
    }

    fseek (fp, 0, SEEK_END);
    FileSize = ftell (fp);
    fseek (fp, 0, SEEK_SET);

    /* Read the table header */

    if (fread (&TableHeader, 1, sizeof (TableHeader), fp) !=
            sizeof (ACPI_TABLE_HEADER))
    {
        printf ("Could not read the table header\n");
        return (AE_BAD_HEADER);
    }

    if (TableHeader.Length < sizeof (ACPI_TABLE_HEADER))
    {
        printf ("Error: TableHeader.Length (%d) < sizeof (ACPI_TABLE_HEADER) (%d)\n",
            TableHeader.Length, (UINT32)sizeof (ACPI_TABLE_HEADER));
        return (AE_BAD_HEADER);
    }

    /* Allocate a buffer for the table */

    *Table = (void *) malloc ((size_t) TableHeader.Length);
    if (!*Table)
    {
        printf (
            "Could not allocate memory for ACPI table %4.4s (size=0x%X)\n",
            TableHeader.Signature, TableHeader.Length);
        return (AE_NO_MEMORY);
    }

    /* Get the entire table */

    if (TableHeader.Length < FileSize)
    {
        FileSize = TableHeader.Length;
    }
    fseek (fp, 0, SEEK_SET);
    Actual = fread (*Table, 1, (size_t) FileSize, fp);
    if (Actual == FileSize)
    {
        return (AE_OK);
    }

    printf ("Error - could not read the table file\n");
    free (*Table);
    *Table = NULL;

    return (AE_ERROR);
}


static char             PathName[AT_PATHNAME_MAX];

/*******************************************************************************
 *
 * FUNCTION:    AtAMLcodeFileNameSet
 *
 * PARAMETERS:  CodeName         - Relative Name of AML code file
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Concatenate CodeName with the DirName specified by User.
 *
 ******************************************************************************/

ACPI_STATUS
AtAMLcodeFileNameSet(
    char                    *CodeName)
{
    if (!AtAMLcodeFileDir)
    {
        TestErrors++;
        printf ("Test Error: AML code FileDir Name path is not specified\n");
        return (AE_ERROR);
    }

    if (strlen(AtAMLcodeFileDir) + strlen(CodeName) + 1 >= AT_PATHNAME_MAX)
    {
        TestErrors++;
        printf ("Test Error: AML code FileName path (%s + %s) is too long\n",
            AtAMLcodeFileDir, CodeName);
        return (AE_ERROR);
    }

    strcpy(PathName, AtAMLcodeFileDir);
    strcat(PathName, "/");
    strcat(PathName, CodeName);
    AtAMLcodeFileName = PathName;

    return (AE_OK);
}


/*******************************************************************************
 *
 * FUNCTION:    AtCheckInteger
 *
 * PARAMETERS:  ObjHandle       - Checked Object ACPI handle or NULL
 *              ObjPath         - Checked Object ACPI Path
 *              Value           - Benchmark value
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Check specified Integer value in ACPI namespace
 *
 ******************************************************************************/

ACPI_STATUS
AtCheckInteger(
    ACPI_HANDLE             ObjHandle,
    ACPI_STRING             ObjPath,
    ACPI_INTEGER            Value)
{
    ACPI_STATUS             Status;
    ACPI_STRING             Path;
    ACPI_BUFFER             Results;
    ACPI_OBJECT             Obj, *Object = &Obj;
    ACPI_BUFFER             OutName = {AT_PATHNAME_MAX, PathName};

    /* Initialize the return buffer structure */
    Results.Length = sizeof (Obj);
    Results.Pointer = Object;
    memset(Results.Pointer, 0, Results.Length);

    if (ObjHandle)
    {
        Path = NULL;
    }
    else
    {
        Path = ObjPath;
    }

    Status = AcpiEvaluateObject (ObjHandle, Path, NULL, &Results);

    if (ObjHandle)
    {
        Status = AcpiGetName (ObjHandle, ACPI_FULL_PATHNAME, &OutName);

        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiGetName(0x%p) returned %s\n",
                ObjHandle, AcpiFormatException(Status));
            return (Status);
        }
        Path = (ACPI_STRING) OutName.Pointer;
    }

    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiEvaluateObject(%s) returned %s\n",
            Path, AcpiFormatException(Status));
        return (Status);
    }

    Status = AE_OK;
    if (Obj.Type != 1)
    {
        AapiErrors++;
        printf ("API Error: Type of %s (%d) is not Integer (1)\n",
            Path, Obj.Type);
        Status = AE_ERROR;
    }
    else if (Obj.Integer.Value != Value)
    {
        AapiErrors++;
#ifdef    _MSC_VER
        printf ("API Error: Value of %s is 0x%I64x instead of expected 0x%I64x\n",
            Path, Obj.Integer.Value, Value);
#else
        printf ("API Error: Value of %s is 0x%llx instead of expected 0x%llx\n",
            Path, Obj.Integer.Value, Value);
#endif
        Status = AE_ERROR;
    }

    return (Status);
}


/*******************************************************************************
 *
 * FUNCTION:    AtCheckBytes
 *
 * PARAMETERS:  Name            - Checked Object name
 *              Pointer         - Pointer to the Checked Object memory
 *              Benchmark       - Pointer to the Benchmark memory
 *              Length          - Length of memory ranges
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Check specified memory ranges if they are identical
 *
 ******************************************************************************/

ACPI_STATUS
AtCheckBytes(
    ACPI_STRING             Name,
    UINT8                   *Pointer,
    UINT8                   *Benchmark,
    UINT32                  Length)
{
    ACPI_STATUS             Status = AE_OK;
    UINT32                  i;

    for (i = 0; i < Length; i++)
    {
        if (Pointer[i] != Benchmark[i])
        {
            AapiErrors++;
            printf ("API Error: Element %d of %s is 0x%x instead of expected 0x%x\n",
                i, Name, Pointer[i], Benchmark[i]);
            Status = AE_ERROR;
            break;
        }
    }
    return (Status);
}


/*******************************************************************************
 *
 * FUNCTION:    AtCheckString
 *
 * PARAMETERS:  Path            - Checked Object ACPI Path
 *              Pointer         - Pointer to the Benchmark String
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Check specified String value in ACPI namespace
 *
 ******************************************************************************/

ACPI_STATUS
AtCheckString(
    ACPI_STRING             Path,
    UINT8                   *Pointer)
{
    ACPI_STATUS             Status;
    UINT32                  Length = strlen((char *)Pointer);
    ACPI_BUFFER             Results;
    ACPI_OBJECT             *Object;

    /* Initialize the return buffer structure */
    Results.Length = ACPI_ROUND_UP_TO_NATIVE_WORD(sizeof (ACPI_OBJECT) + Length + 1);
    Object = (ACPI_OBJECT    *)malloc((size_t)Results.Length);
    if (!Object)
    {
        TestErrors++;
        printf ("Test Error: cannot allocate buffer of %d bytes\n",
            Results.Length);
        return (AE_NO_MEMORY);
    }
    Results.Pointer = Object;
    memset(Results.Pointer, 0, Results.Length);

    Status = AcpiEvaluateObject (NULL, Path, NULL, &Results);

    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiEvaluateObject(%s) returned %s\n",
            Path, AcpiFormatException(Status));
        goto Cleanup;
    }

    Status = AE_OK;
    if (Object->Type != 2)
    {
        AapiErrors++;
        printf ("API Error: Type of %s (%d) is not String (2)\n",
            Path, Object->Type);
        Status = AE_ERROR;
    }
    else if (Object->Buffer.Length != Length)
    {
        AapiErrors++;
        printf ("API Error: Length of %s is %d instead of expected %d\n",
            Path, Object->Buffer.Length, Length);
        Status = AE_ERROR;
    }
    else
    {
        Status = AtCheckBytes(Path, Object->Buffer.Pointer, Pointer, Length);
    }

Cleanup:
    free(Object);

    return (AE_OK);
}


/*******************************************************************************
 *
 * FUNCTION:    AtCheckBuffer
 *
 * PARAMETERS:  Path            - Checked Object ACPI Path
 *              Length          - Length of the Benchmark buffer
 *              Pointer         - Pointer to the Benchmark buffer
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Check specified Buffer value in ACPI namespace
 *
 ******************************************************************************/

ACPI_STATUS
AtCheckBuffer(
    ACPI_STRING             Path,
    UINT32                  Length,
    UINT8                   *Pointer)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             Results = {0, NULL};
    ACPI_OBJECT             *Object;

    Status = AcpiEvaluateObject (NULL, Path, NULL, &Results);

    if (Status != AE_BUFFER_OVERFLOW)
    {
        AapiErrors++;
        printf ("API Error: AcpiEvaluateObject(%s) returned %s\n",
            Path, AcpiFormatException(Status));
        return (Status);
    }

    if (Results.Length != ACPI_ROUND_UP_TO_NATIVE_WORD(sizeof (ACPI_OBJECT) + Length))
    {
        printf ("AtCheckBuffer: unexpected length %d of Buffer vs"
            " calculated %d bytes\n",
            Results.Length, ACPI_ROUND_UP_TO_NATIVE_WORD(sizeof (ACPI_OBJECT) + Length));
    }

    /* Initialize the return buffer structure */
    Object = (ACPI_OBJECT    *)malloc((size_t)Results.Length);
    if (!Object)
    {
        TestErrors++;
        printf ("Test Error: cannot allocate buffer of %d bytes\n",
            Results.Length);
        return (AE_NO_MEMORY);
    }
    Results.Pointer = Object;
    memset(Results.Pointer, 0, Results.Length);

    Status = AcpiEvaluateObject (NULL, Path, NULL, &Results);

    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiEvaluateObject(%s) returned %s\n",
            Path, AcpiFormatException(Status));
        goto Cleanup;
    }

    Status = AE_OK;
    if (Object->Type != 3)
    {
        AapiErrors++;
        printf ("API Error: Type of %s (%d) is not Buffer (3)\n",
            Path, Object->Type);
        Status = AE_ERROR;
    }
    else if (Object->Buffer.Length != Length)
    {
        AapiErrors++;
        printf ("API Error: Length of %s is %d instead of expected %d\n",
            Path, Object->Buffer.Length, Length);
        Status = AE_ERROR;
        if (Object->Buffer.Length < Length)
        {
            Length = Object->Buffer.Length;
        }
        (void)AtCheckBytes(Path, Object->Buffer.Pointer, Pointer, Length);
    }
    else
    {
        Status = AtCheckBytes(Path, Object->Buffer.Pointer, Pointer, Length);
    }

Cleanup:
    free(Object);

    return (Status);
}


/*******************************************************************************
 *
 * FUNCTION:    AtCheckName
 *
 * PARAMETERS:  ObjHandle       - Checked Object ACPI handle or NULL
 *              CheckName       - Pointer to the expected name
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Check NS Object specified by the ObjHandle to have the name
 *
 ******************************************************************************/

ACPI_STATUS
AtCheckName(
    ACPI_HANDLE             ObjHandle,
    ACPI_STRING             CheckName)
{
    ACPI_STATUS             Status;
    ACPI_BUFFER             OutName = {ACPI_ALLOCATE_BUFFER};

    Status = AcpiGetName (ObjHandle, ACPI_FULL_PATHNAME, &OutName);

    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API Error: AcpiGetName(0x%p) returned %s\n",
            ObjHandle, AcpiFormatException(Status));
        return (Status);
    }

    if (strcmp(CheckName, (char *)OutName.Pointer))
    {
        AapiErrors++;
        Status = AE_ERROR;
        printf ("AtCheckName: AcpiGetName() returned Name %s,"
            " expected %s\n",
            CheckName, (char *)OutName.Pointer);
    }

    AcpiOsFree(OutName.Pointer);

    return (Status);
}


ACPI_STATUS
AeIndexFieldHandler (
    ACPI_OBJECT_INDEX_FIELD *IndexField,
    UINT32                  ReadWrite)
{
    return (AE_OK);
}

ACPI_STATUS
AeBankFieldHandler (
    ACPI_OPERAND_OBJECT     *ObjDesc)
{
    return (AE_OK);
}


/*
 * Auxiliary Ssdt Load/Unload
 */
ACPI_STATUS
AtAuxiliarySsdt(
    UINT32                  Action)
{
    ACPI_STATUS             Status = AE_OK;

    if (Action == AT_LOAD)
    {
        Status = AcpiEvaluateObject (NULL, "\\AUX0.INIT",
            NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiEvaluateObject(AUX0.INIT) returned %s\n",
                AcpiFormatException(Status));
        }
        else
        {
            Status = AcpiEvaluateObject (NULL, "\\AUX0.LD__",
                NULL, NULL);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("API Error: AcpiEvaluateObject(AUX0.LD) returned %s\n",
                    AcpiFormatException(Status));
            }
        }
    }
    else /* AT_UNLOAD */
    {
        Status = AcpiEvaluateObject (NULL, "\\AUX0.UNLD",
            NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API Error: AcpiEvaluateObject(AUX0.UNLD) returned %s\n",
                AcpiFormatException(Status));
        }
    }
    return (Status);
}
