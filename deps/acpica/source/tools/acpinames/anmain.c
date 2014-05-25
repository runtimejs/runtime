/******************************************************************************
 *
 * Module Name: anmain - Main routine for the AcpiNames utility
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

#include "acpinames.h"

#define _COMPONENT          ACPI_TOOLS
        ACPI_MODULE_NAME    ("anmain")


extern ACPI_TABLE_DESC  Tables[];

static AE_TABLE_DESC    *AeTableListHead = NULL;


#define AN_UTILITY_NAME             "ACPI Namespace Dump Utility"
#define AN_SUPPORTED_OPTIONS        "?hv"


/******************************************************************************
 *
 * FUNCTION:    usage
 *
 * PARAMETERS:  None
 *
 * RETURN:      None
 *
 * DESCRIPTION: Print a usage message
 *
 *****************************************************************************/

static void
usage (
    void)
{

    ACPI_USAGE_HEADER ("AcpiNames [options] AMLfile");
    ACPI_OPTION ("-?",                  "Display this message");
    ACPI_OPTION ("-v",                  "Display version information");
}


/******************************************************************************
 *
 * FUNCTION:    NsDumpEntireNamespace
 *
 * PARAMETERS:  AmlFilename         - Filename for DSDT or SSDT AML table
 *
 * RETURN:      Status (pass/fail)
 *
 * DESCRIPTION: Build an ACPI namespace for the input AML table, and dump the
 *              formatted namespace contents.
 *
 *****************************************************************************/

static int
NsDumpEntireNamespace (
    char                    *AmlFilename)
{
    ACPI_STATUS             Status;
    ACPI_TABLE_HEADER       *Table = NULL;
    UINT32                  TableCount = 0;
    AE_TABLE_DESC           *TableDesc;
    ACPI_HANDLE             Handle;


    /* Open the binary AML file and read the entire table */

    Status = AcpiUtReadTableFromFile (AmlFilename, &Table);
    if (ACPI_FAILURE (Status))
    {
        printf ("**** Could not get input table %s, %s\n", AmlFilename,
            AcpiFormatException (Status));
        return (-1);
    }

    /* Table must be a DSDT. SSDTs are not currently supported */

    if (!ACPI_COMPARE_NAME (Table->Signature, ACPI_SIG_DSDT))
    {
        printf ("**** Input table signature is [%4.4s], must be [DSDT]\n",
            Table->Signature);
        return (-1);
    }

    /*
     * Allocate and link a table descriptor (allows for future expansion to
     * multiple input files)
     */
    TableDesc = AcpiOsAllocate (sizeof (AE_TABLE_DESC));
    TableDesc->Table = Table;
    TableDesc->Next = AeTableListHead;
    AeTableListHead = TableDesc;

    TableCount++;

    /*
     * Build a local XSDT with all tables. Normally, here is where the
     * RSDP search is performed to find the ACPI tables
     */
    Status = AeBuildLocalTables (TableCount, AeTableListHead);
    if (ACPI_FAILURE (Status))
    {
        return (-1);
    }

    /* Initialize table manager, get XSDT */

    Status = AcpiInitializeTables (Tables, ACPI_MAX_INIT_TABLES, TRUE);
    if (ACPI_FAILURE (Status))
    {
        printf ("**** Could not initialize ACPI table manager, %s\n",
            AcpiFormatException (Status));
        return (-1);
    }

    /* Reallocate root table to dynamic memory */

    Status = AcpiReallocateRootTable ();
    if (ACPI_FAILURE (Status))
    {
        printf ("**** Could not reallocate root table, %s\n",
            AcpiFormatException (Status));
        return (-1);
    }

    /* Load the ACPI namespace */

    Status = AcpiLoadTables ();
    if (ACPI_FAILURE (Status))
    {
        printf ("**** Could not load ACPI tables, %s\n",
            AcpiFormatException (Status));
        return (-1);
    }

    /*
     * Enable ACPICA. These calls don't do much for this
     * utility, since we only dump the namespace. There is no
     * hardware or event manager code underneath.
     */
    Status = AcpiEnableSubsystem (
                ACPI_NO_ACPI_ENABLE |
                ACPI_NO_ADDRESS_SPACE_INIT |
                ACPI_NO_EVENT_INIT |
                ACPI_NO_HANDLER_INIT);
    if (ACPI_FAILURE (Status))
    {
        printf ("**** Could not EnableSubsystem, %s\n",
            AcpiFormatException (Status));
        return (-1);
    }

    Status = AcpiInitializeObjects (
                ACPI_NO_ADDRESS_SPACE_INIT |
                ACPI_NO_DEVICE_INIT |
                ACPI_NO_EVENT_INIT);
    if (ACPI_FAILURE (Status))
    {
        printf ("**** Could not InitializeObjects, %s\n",
            AcpiFormatException (Status));
        return (-1);
    }

    /*
     * Perform a namespace walk to dump the contents
     */
    AcpiOsPrintf ("\nACPI Namespace:\n");

    AcpiNsDumpObjects (ACPI_TYPE_ANY, ACPI_DISPLAY_SUMMARY, ACPI_UINT32_MAX,
        ACPI_OWNER_ID_MAX, AcpiGbl_RootNode);


    /* Example: get a handle to the _GPE scope */

    Status = AcpiGetHandle (NULL, "\\_GPE", &Handle);
    AE_CHECK_OK (AcpiGetHandle, Status);

    return (0);
}


/******************************************************************************
 *
 * FUNCTION:    main
 *
 * PARAMETERS:  argc, argv
 *
 * RETURN:      Status (pass/fail)
 *
 * DESCRIPTION: Main routine for NsDump utility
 *
 *****************************************************************************/

int ACPI_SYSTEM_XFACE
main (
    int                     argc,
    char                    **argv)
{
    ACPI_STATUS             Status;
    int                     j;


    ACPI_DEBUG_INITIALIZE (); /* For debug version only */
    printf (ACPI_COMMON_SIGNON (AN_UTILITY_NAME));

    if (argc < 2)
    {
        usage ();
        return (0);
    }

    /* Init globals and ACPICA */

    AcpiDbgLevel = ACPI_LV_TABLES;
    AcpiDbgLayer = 0xFFFFFFFF;

    Status = AcpiInitializeSubsystem ();
    AE_CHECK_OK (AcpiInitializeSubsystem, Status);

    /* Get the command line options */

    while ((j = AcpiGetopt (argc, argv, AN_SUPPORTED_OPTIONS)) != EOF) switch(j)
    {
    case 'v': /* -v: (Version): signon already emitted, just exit */

        return (0);

    case '?':
    case 'h':
    default:

        usage();
        return (0);
    }

    /*
     * The next argument is the filename for the DSDT or SSDT.
     * Open the file, build namespace and dump it.
     */
    return (NsDumpEntireNamespace (argv[AcpiGbl_Optind]));
}
