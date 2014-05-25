/******************************************************************************
 *
 * Module Name: oswintbl - Windows OSL for obtaining ACPI tables
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
#include "acutils.h"
#include <stdio.h>

#ifdef WIN32
#pragma warning(disable:4115)   /* warning C4115: (caused by rpcasync.h) */
#include <windows.h>

#elif WIN64
#include <windowsx.h>
#endif

#define _COMPONENT          ACPI_OS_SERVICES
        ACPI_MODULE_NAME    ("oswintbl")

/* Local prototypes */

static char *
WindowsFormatException (
    LONG                WinStatus);

/* Globals */

#define LOCAL_BUFFER_SIZE           64

static char             KeyBuffer[LOCAL_BUFFER_SIZE];
static char             ErrorBuffer[LOCAL_BUFFER_SIZE];

/*
 * Tables supported in the Windows registry. SSDTs are not placed into
 * the registry, a limitation.
 */
static char             *SupportedTables[] =
{
    "DSDT",
    "RSDT",
    "FACS",
    "FACP"
};

/* Max index for table above */

#define ACPI_OS_MAX_TABLE_INDEX     3


/******************************************************************************
 *
 * FUNCTION:    WindowsFormatException
 *
 * PARAMETERS:  WinStatus       - Status from a Windows system call
 *
 * RETURN:      Formatted (ascii) exception code. Front-end to Windows
 *              FormatMessage interface.
 *
 * DESCRIPTION: Decode a windows exception
 *
 *****************************************************************************/

static char *
WindowsFormatException (
    LONG                WinStatus)
{

    ErrorBuffer[0] = 0;
    FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM, NULL, WinStatus, 0,
        ErrorBuffer, LOCAL_BUFFER_SIZE, NULL);

    return (ErrorBuffer);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsGetTableByAddress
 *
 * PARAMETERS:  Address         - Physical address of the ACPI table
 *              Table           - Where a pointer to the table is returned
 *
 * RETURN:      Status; Table buffer is returned if AE_OK.
 *              AE_NOT_FOUND: A valid table was not found at the address
 *
 * DESCRIPTION: Get an ACPI table via a physical memory address.
 *
 * NOTE:        Cannot be implemented without a Windows device driver.
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsGetTableByAddress (
    ACPI_PHYSICAL_ADDRESS   Address,
    ACPI_TABLE_HEADER       **Table)
{

    fprintf (stderr, "Get table by address is not supported on Windows\n");
    return (AE_SUPPORT);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsGetTableByIndex
 *
 * PARAMETERS:  Index           - Which table to get
 *              Table           - Where a pointer to the table is returned
 *              Instance        - Where a pointer to the table instance no. is
 *                                returned
 *              Address         - Where the table physical address is returned
 *
 * RETURN:      Status; Table buffer and physical address returned if AE_OK.
 *              AE_LIMIT: Index is beyond valid limit
 *
 * DESCRIPTION: Get an ACPI table via an index value (0 through n). Returns
 *              AE_LIMIT when an invalid index is reached. Index is not
 *              necessarily an index into the RSDT/XSDT.
 *              Table is obtained from the Windows registry.
 *
 * NOTE:        Cannot get the physical address from the windows registry;
 *              zero is returned instead.
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsGetTableByIndex (
    UINT32                  Index,
    ACPI_TABLE_HEADER       **Table,
    UINT32                  *Instance,
    ACPI_PHYSICAL_ADDRESS   *Address)
{
    ACPI_STATUS             Status;


    if (Index > ACPI_OS_MAX_TABLE_INDEX)
    {
        return (AE_LIMIT);
    }

    Status = AcpiOsGetTableByName (SupportedTables[Index], 0, Table, Address);
    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsGetTableByName
 *
 * PARAMETERS:  Signature       - ACPI Signature for desired table. Must be
 *                                a null terminated 4-character string.
 *              Instance        - For SSDTs (0...n). Use 0 otherwise.
 *              Table           - Where a pointer to the table is returned
 *              Address         - Where the table physical address is returned
 *
 * RETURN:      Status; Table buffer and physical address returned if AE_OK.
 *              AE_LIMIT: Instance is beyond valid limit
 *              AE_NOT_FOUND: A table with the signature was not found
 *
 * DESCRIPTION: Get an ACPI table via a table signature (4 ASCII characters).
 *              Returns AE_LIMIT when an invalid instance is reached.
 *              Table is obtained from the Windows registry.
 *
 * NOTE:        Assumes the input signature is uppercase.
 *              Cannot get the physical address from the windows registry;
 *              zero is returned instead.
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsGetTableByName (
    char                    *Signature,
    UINT32                  Instance,
    ACPI_TABLE_HEADER       **Table,
    ACPI_PHYSICAL_ADDRESS   *Address)
{
    HKEY                    Handle = NULL;
    LONG                    WinStatus;
    ULONG                   Type;
    ULONG                   NameSize;
    ULONG                   DataSize;
    HKEY                    SubKey;
    ULONG                   i;
    ACPI_TABLE_HEADER       *ReturnTable;
    ACPI_STATUS             Status = AE_OK;


    /*
     * Windows has no SSDTs in the registry, so multiple instances are
     * not supported.
     */
    if (Instance > 0)
    {
        return (AE_LIMIT);
    }

    /* Get a handle to the table key */

    while (1)
    {
        ACPI_STRCPY (KeyBuffer, "HARDWARE\\ACPI\\");
        if (AcpiUtSafeStrcat (KeyBuffer, sizeof (KeyBuffer), Signature))
        {
            return (AE_BUFFER_OVERFLOW);
        }

        WinStatus = RegOpenKeyEx (HKEY_LOCAL_MACHINE, KeyBuffer,
            0L, KEY_READ, &Handle);

        if (WinStatus != ERROR_SUCCESS)
        {
            /*
             * Somewhere along the way, MS changed the registry entry for
             * the FADT from
             * HARDWARE/ACPI/FACP  to
             * HARDWARE/ACPI/FADT.
             *
             * This code allows for both.
             */
            if (ACPI_COMPARE_NAME (Signature, "FACP"))
            {
                Signature = "FADT";
            }
            else if (ACPI_COMPARE_NAME (Signature, "XSDT"))
            {
                Signature = "RSDT";
            }
            else
            {
                fprintf (stderr,
                    "Could not find %s in registry at %s: %s (WinStatus=0x%X)\n",
                    Signature, KeyBuffer, WindowsFormatException (WinStatus), WinStatus);
                return (AE_NOT_FOUND);
            }
        }
        else
        {
            break;
        }
    }

    /* Actual data for the table is down a couple levels */

    for (i = 0; ;)
    {
        WinStatus = RegEnumKey (Handle, i, KeyBuffer, sizeof (KeyBuffer));
        i++;
        if (WinStatus == ERROR_NO_MORE_ITEMS)
        {
            break;
        }

        WinStatus = RegOpenKey (Handle, KeyBuffer, &SubKey);
        if (WinStatus != ERROR_SUCCESS)
        {
            fprintf (stderr, "Could not open %s entry: %s\n",
                Signature, WindowsFormatException (WinStatus));
            Status = AE_ERROR;
            goto Cleanup;
        }

        RegCloseKey (Handle);
        Handle = SubKey;
        i = 0;
    }

    /* Find the (binary) table entry */

    for (i = 0; ; i++)
    {
        NameSize = sizeof (KeyBuffer);
        WinStatus = RegEnumValue (Handle, i, KeyBuffer, &NameSize, NULL,
            &Type, NULL, 0);
        if (WinStatus != ERROR_SUCCESS)
        {
            fprintf (stderr, "Could not get %s registry entry: %s\n",
                Signature, WindowsFormatException (WinStatus));
            Status = AE_ERROR;
            goto Cleanup;
        }

        if (Type == REG_BINARY)
        {
            break;
        }
    }

    /* Get the size of the table */

    WinStatus = RegQueryValueEx (Handle, KeyBuffer, NULL, NULL,
        NULL, &DataSize);
    if (WinStatus = ERROR_SUCCESS)
    {
        fprintf (stderr, "Could not read the %s table size: %s\n",
            Signature, WindowsFormatException (WinStatus));
        Status = AE_ERROR;
        goto Cleanup;
    }

    /* Allocate a new buffer for the table */

    ReturnTable = malloc (DataSize);
    if (!ReturnTable)
    {
        Status = AE_NO_MEMORY;
        goto Cleanup;
    }

    /* Get the actual table from the registry */

    WinStatus = RegQueryValueEx (Handle, KeyBuffer, NULL, NULL,
        (UCHAR *) ReturnTable, &DataSize);
    if (WinStatus = ERROR_SUCCESS)
    {
        fprintf (stderr, "Could not read %s data: %s\n",
            Signature, WindowsFormatException (WinStatus));
        free (ReturnTable);
        Status = AE_ERROR;
        goto Cleanup;
    }

    *Table = ReturnTable;
    *Address = 0;

Cleanup:
    RegCloseKey (Handle);
    return (Status);
}


/* These are here for acpidump only, so we don't need to link oswinxf */

#ifdef ACPI_DUMP_APP
/******************************************************************************
 *
 * FUNCTION:    AcpiOsMapMemory
 *
 * PARAMETERS:  Where               - Physical address of memory to be mapped
 *              Length              - How much memory to map
 *
 * RETURN:      Pointer to mapped memory. Null on error.
 *
 * DESCRIPTION: Map physical memory into caller's address space
 *
 *****************************************************************************/

void *
AcpiOsMapMemory (
    ACPI_PHYSICAL_ADDRESS   Where,
    ACPI_SIZE               Length)
{

    return (ACPI_TO_POINTER ((ACPI_SIZE) Where));
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsUnmapMemory
 *
 * PARAMETERS:  Where               - Logical address of memory to be unmapped
 *              Length              - How much memory to unmap
 *
 * RETURN:      None.
 *
 * DESCRIPTION: Delete a previously created mapping. Where and Length must
 *              correspond to a previous mapping exactly.
 *
 *****************************************************************************/

void
AcpiOsUnmapMemory (
    void                    *Where,
    ACPI_SIZE               Length)
{

    return;
}
#endif
