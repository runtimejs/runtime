/******************************************************************************
 *
 * Module Name: aslmain - compiler main and utilities
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

#define _DECLARE_GLOBALS

#include "aslcompiler.h"
#include "acapps.h"
#include "acdisasm.h"
#include <signal.h>

#define _COMPONENT          ACPI_COMPILER
        ACPI_MODULE_NAME    ("aslmain")

/*
 * Main routine for the iASL compiler.
 *
 * Portability note: The compiler depends upon the host for command-line
 * wildcard support - it is not implemented locally. For example:
 *
 * Linux/Unix systems: Shell expands wildcards automatically.
 *
 * Windows: The setargv.obj module must be linked in to automatically
 * expand wildcards.
 */

/* Local prototypes */

static void ACPI_SYSTEM_XFACE
AslSignalHandler (
    int                     Sig);

static void
AslInitialize (
    void);

UINT8
AcpiIsBigEndianMachine (
    void);


/*******************************************************************************
 *
 * FUNCTION:    AcpiIsBigEndianMachine
 *
 * PARAMETERS:  None
 *
 * RETURN:      TRUE if machine is big endian
 *              FALSE if machine is little endian
 *
 * DESCRIPTION: Detect whether machine is little endian or big endian.
 *
 ******************************************************************************/

UINT8
AcpiIsBigEndianMachine (
    void)
{
    union {
        UINT32              Integer;
        UINT8               Bytes[4];
    } Overlay = {0xFF000000};

    return (Overlay.Bytes[0]); /* Returns 0xFF (TRUE) for big endian */
}


/*******************************************************************************
 *
 * FUNCTION:    Usage
 *
 * PARAMETERS:  None
 *
 * RETURN:      None
 *
 * DESCRIPTION: Display option help message.
 *              Optional items in square brackets.
 *
 ******************************************************************************/

void
Usage (
    void)
{
    printf ("%s\n\n", ASL_COMPLIANCE);
    ACPI_USAGE_HEADER ("iasl [Options] [Files]");

    printf ("\nGeneral:\n");
    ACPI_OPTION ("-@ <file>",       "Specify command file");
    ACPI_OPTION ("-I <dir>",        "Specify additional include directory");
    ACPI_OPTION ("-T <sig>|ALL|*",  "Create table template file for ACPI <Sig>");
    ACPI_OPTION ("-p <prefix>",     "Specify path/filename prefix for all output files");
    ACPI_OPTION ("-v",              "Display compiler version");
    ACPI_OPTION ("-vo",             "Enable optimization comments");
    ACPI_OPTION ("-vs",             "Disable signon");

    printf ("\nHelp:\n");
    ACPI_OPTION ("-h",              "This message");
    ACPI_OPTION ("-hc",             "Display operators allowed in constant expressions");
    ACPI_OPTION ("-hf",             "Display help for output filename generation");
    ACPI_OPTION ("-hr",             "Display ACPI reserved method names");
    ACPI_OPTION ("-ht",             "Display currently supported ACPI table names");

    printf ("\nPreprocessor:\n");
    ACPI_OPTION ("-D <symbol>",     "Define symbol for preprocessor use");
    ACPI_OPTION ("-li",             "Create preprocessed output file (*.i)");
    ACPI_OPTION ("-P",              "Preprocess only and create preprocessor output file (*.i)");
    ACPI_OPTION ("-Pn",             "Disable preprocessor");

    printf ("\nErrors, Warnings, and Remarks:\n");
    ACPI_OPTION ("-va",             "Disable all errors/warnings/remarks");
    ACPI_OPTION ("-ve",             "Report only errors (ignore warnings and remarks)");
    ACPI_OPTION ("-vi",             "Less verbose errors and warnings for use with IDEs");
    ACPI_OPTION ("-vr",             "Disable remarks");
    ACPI_OPTION ("-vw <messageid>", "Disable specific warning or remark");
    ACPI_OPTION ("-w1 -w2 -w3",     "Set warning reporting level");
    ACPI_OPTION ("-we",             "Report warnings as errors");

    printf ("\nAML Code Generation (*.aml):\n");
    ACPI_OPTION ("-oa",             "Disable all optimizations (compatibility mode)");
    ACPI_OPTION ("-of",             "Disable constant folding");
    ACPI_OPTION ("-oi",             "Disable integer optimization to Zero/One/Ones");
    ACPI_OPTION ("-on",             "Disable named reference string optimization");
    ACPI_OPTION ("-cr",             "Disable Resource Descriptor error checking");
    ACPI_OPTION ("-in",             "Ignore NoOp operators");
    ACPI_OPTION ("-r <revision>",   "Override table header Revision (1-255)");

    printf ("\nOptional Source Code Output Files:\n");
    ACPI_OPTION ("-sc -sa",         "Create source file in C or assembler (*.c or *.asm)");
    ACPI_OPTION ("-ic -ia",         "Create include file in C or assembler (*.h or *.inc)");
    ACPI_OPTION ("-tc -ta -ts",     "Create hex AML table in C, assembler, or ASL (*.hex)");
    ACPI_OPTION ("-so",             "Create offset table in C (*.offset.h)");

    printf ("\nOptional Listing Files:\n");
    ACPI_OPTION ("-l",              "Create mixed listing file (ASL source and AML) (*.lst)");
    ACPI_OPTION ("-ln",             "Create namespace file (*.nsp)");
    ACPI_OPTION ("-ls",             "Create combined source file (expanded includes) (*.src)");

    printf ("\nData Table Compiler:\n");
    ACPI_OPTION ("-G",              "Compile custom table that contains generic operators");
    ACPI_OPTION ("-vt",             "Create verbose template files (full disassembly)");

    printf ("\nAML Disassembler:\n");
    ACPI_OPTION ("-d  <f1 f2 ...>", "Disassemble or decode binary ACPI tables to file (*.dsl)");
    ACPI_OPTION ("",                "  (Optional, file type is automatically detected)");
    ACPI_OPTION ("-da <f1 f2 ...>", "Disassemble multiple tables from single namespace");
    ACPI_OPTION ("-db",             "Do not translate Buffers to Resource Templates");
    ACPI_OPTION ("-dc <f1 f2 ...>", "Disassemble AML and immediately compile it");
    ACPI_OPTION ("",                "  (Obtain DSDT from current system if no input file)");
    ACPI_OPTION ("-e  <f1 f2 ...>", "Include ACPI table(s) for external symbol resolution");
    ACPI_OPTION ("-fe <file>",      "Specify external symbol declaration file");
    ACPI_OPTION ("-in",             "Ignore NoOp opcodes");
    ACPI_OPTION ("-vt",             "Dump binary table data in hex format within output file");

    printf ("\nDebug Options:\n");
    ACPI_OPTION ("-bf -bt",         "Create debug file (full or parse tree only) (*.txt)");
    ACPI_OPTION ("-f",              "Ignore errors, force creation of AML output file(s)");
    ACPI_OPTION ("-m <size>",       "Set internal line buffer size (in Kbytes)");
    ACPI_OPTION ("-n",              "Parse only, no output generation");
    ACPI_OPTION ("-ot",             "Display compile times and statistics");
    ACPI_OPTION ("-x <level>",      "Set debug level for trace output");
    ACPI_OPTION ("-z",              "Do not insert new compiler ID for DataTables");
}


/*******************************************************************************
 *
 * FUNCTION:    FilenameHelp
 *
 * PARAMETERS:  None
 *
 * RETURN:      None
 *
 * DESCRIPTION: Display help message for output filename generation
 *
 ******************************************************************************/

void
AslFilenameHelp (
    void)
{

    printf ("\nAML output filename generation:\n");
    printf ("  Output filenames are generated by appending an extension to a common\n");
    printf ("  filename prefix. The filename prefix is obtained via one of the\n");
    printf ("  following methods (in priority order):\n");
    printf ("    1) The -p option specifies the prefix\n");
    printf ("    2) The prefix of the AMLFileName in the ASL Definition Block\n");
    printf ("    3) The prefix of the input filename\n");
    printf ("\n");
}


/******************************************************************************
 *
 * FUNCTION:    AslSignalHandler
 *
 * PARAMETERS:  Sig                 - Signal that invoked this handler
 *
 * RETURN:      None
 *
 * DESCRIPTION: Control-C handler. Delete any intermediate files and any
 *              output files that may be left in an indeterminate state.
 *
 *****************************************************************************/

static void ACPI_SYSTEM_XFACE
AslSignalHandler (
    int                     Sig)
{
    UINT32                  i;


    signal (Sig, SIG_IGN);
    printf ("Aborting\n\n");

    /* Close all open files */

    Gbl_Files[ASL_FILE_PREPROCESSOR].Handle = NULL; /* the .i file is same as source file */

    for (i = ASL_FILE_INPUT; i < ASL_MAX_FILE_TYPE; i++)
    {
        FlCloseFile (i);
    }

    /* Delete any output files */

    for (i = ASL_FILE_AML_OUTPUT; i < ASL_MAX_FILE_TYPE; i++)
    {
        FlDeleteFile (i);
    }

    exit (0);
}


/*******************************************************************************
 *
 * FUNCTION:    AslInitialize
 *
 * PARAMETERS:  None
 *
 * RETURN:      None
 *
 * DESCRIPTION: Initialize compiler globals
 *
 ******************************************************************************/

static void
AslInitialize (
    void)
{
    UINT32                  i;


    for (i = 0; i < ASL_NUM_FILES; i++)
    {
        Gbl_Files[i].Handle = NULL;
        Gbl_Files[i].Filename = NULL;
    }

    Gbl_Files[ASL_FILE_STDOUT].Handle   = stdout;
    Gbl_Files[ASL_FILE_STDOUT].Filename = "STDOUT";

    Gbl_Files[ASL_FILE_STDERR].Handle   = stderr;
    Gbl_Files[ASL_FILE_STDERR].Filename = "STDERR";
}


/*******************************************************************************
 *
 * FUNCTION:    main
 *
 * PARAMETERS:  Standard argc/argv
 *
 * RETURN:      Program termination code
 *
 * DESCRIPTION: C main routine for the Asl Compiler. Handle command line
 *              options and begin the compile for each file on the command line
 *
 ******************************************************************************/

int ACPI_SYSTEM_XFACE
main (
    int                     argc,
    char                    **argv)
{
    ACPI_STATUS             Status;
    int                     Index1;
    int                     Index2;


    /*
     * Big-endian machines are not currently supported. ACPI tables must
     * be little-endian, and support for big-endian machines needs to
     * be implemented.
     */
    if (AcpiIsBigEndianMachine ())
    {
        fprintf (stderr,
            "iASL is not currently supported on big-endian machines.\n");
        return (-1);
    }

    ACPI_DEBUG_INITIALIZE (); /* For debug version only */

    /* Initialize preprocessor and compiler before command line processing */

    signal (SIGINT, AslSignalHandler);
    AcpiGbl_ExternalFileList = NULL;
    AcpiDbgLevel = 0;
    PrInitializePreprocessor ();
    AslInitialize ();

    Index1 = Index2 = AslCommandLine (argc, argv);

    /* Allocate the line buffer(s), must be after command line */

    Gbl_LineBufferSize /= 2;
    UtExpandLineBuffers ();

    /* Perform global actions first/only */

    if (Gbl_DisassembleAll)
    {
        while (argv[Index1])
        {
            Status = AcpiDmAddToExternalFileList (argv[Index1]);
            if (ACPI_FAILURE (Status))
            {
                return (-1);
            }

            Index1++;
        }
    }

    /* Process each pathname/filename in the list, with possible wildcards */

    while (argv[Index2])
    {
        /*
         * If -p not specified, we will use the input filename as the
         * output filename prefix
         */
        if (Gbl_UseDefaultAmlFilename)
        {
            Gbl_OutputFilenamePrefix = argv[Index2];
            UtConvertBackslashes (Gbl_OutputFilenamePrefix);
        }

        Status = AslDoOneFile (argv[Index2]);
        if (ACPI_FAILURE (Status))
        {
            return (-1);
        }

        Index2++;
    }

    if (AcpiGbl_ExternalFileList)
    {
        AcpiDmClearExternalFileList();
    }

    return (0);
}
