/******************************************************************************
 *
 * Module Name: acpixtract - convert ascii ACPI tables to binary
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
#include "acapps.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

/* Local prototypes */

static void
AxStrlwr (
    char                    *String);

static void
AxCheckAscii (
    char                    *Name,
    int                     Count);

static void
AxNormalizeSignature (
    char                    *Signature);

static unsigned int
AxGetNextInstance (
    char                    *InputPathname,
    char                    *Signature);

static size_t
AxGetTableHeader (
    FILE                    *InputFile,
    unsigned char           *OutputData);

static unsigned int
AxCountTableInstances (
    char                    *InputPathname,
    char                    *Signature);

int
AxExtractTables (
    char                    *InputPathname,
    char                    *Signature,
    unsigned int            MinimumInstances);

int
AxListTables (
    char                    *InputPathname);

static size_t
AxConvertLine (
    char                    *InputLine,
    unsigned char           *OutputData);

static int
AxIsEmptyLine (
    char                    *Buffer);

typedef struct AxTableInfo
{
    UINT32                  Signature;
    unsigned int            Instances;
    unsigned int            NextInstance;
    struct AxTableInfo      *Next;

} AX_TABLE_INFO;

/* Extraction states */

#define AX_STATE_FIND_HEADER        0
#define AX_STATE_EXTRACT_DATA       1

/* Miscellaneous constants */

#define AX_LINE_BUFFER_SIZE         256
#define AX_MIN_TABLE_NAME_LENGTH    6   /* strlen ("DSDT @") */


static AX_TABLE_INFO        *AxTableListHead = NULL;
static char                 Filename[16];
static unsigned char        Data[16];
static char                 LineBuffer[AX_LINE_BUFFER_SIZE];
static char                 HeaderBuffer[AX_LINE_BUFFER_SIZE];
static char                 InstanceBuffer[AX_LINE_BUFFER_SIZE];


/*******************************************************************************
 *
 * FUNCTION:    AxStrlwr
 *
 * PARAMETERS:  String              - Ascii string
 *
 * RETURN:      None
 *
 * DESCRIPTION: String lowercase function.
 *
 ******************************************************************************/

static void
AxStrlwr (
    char                    *String)
{

    while (*String)
    {
        *String = (char) tolower ((int) *String);
        String++;
    }
}


/*******************************************************************************
 *
 * FUNCTION:    AxCheckAscii
 *
 * PARAMETERS:  Name                - Ascii string, at least as long as Count
 *              Count               - Number of characters to check
 *
 * RETURN:      None
 *
 * DESCRIPTION: Ensure that the requested number of characters are printable
 *              Ascii characters. Sets non-printable and null chars to <space>.
 *
 ******************************************************************************/

static void
AxCheckAscii (
    char                    *Name,
    int                     Count)
{
    int                     i;


    for (i = 0; i < Count; i++)
    {
        if (!Name[i] || !isprint ((int) Name[i]))
        {
            Name[i] = ' ';
        }
    }
}


/******************************************************************************
 *
 * FUNCTION:    AxIsEmptyLine
 *
 * PARAMETERS:  Buffer              - Line from input file
 *
 * RETURN:      TRUE if line is empty (zero or more blanks only)
 *
 * DESCRIPTION: Determine if an input line is empty.
 *
 ******************************************************************************/

static int
AxIsEmptyLine (
    char                    *Buffer)
{

    /* Skip all spaces */

    while (*Buffer == ' ')
    {
        Buffer++;
    }

    /* If end-of-line, this line is empty */

    if (*Buffer == '\n')
    {
        return (1);
    }

    return (0);
}


/*******************************************************************************
 *
 * FUNCTION:    AxNormalizeSignature
 *
 * PARAMETERS:  Name                - Ascii string containing an ACPI signature
 *
 * RETURN:      None
 *
 * DESCRIPTION: Change "RSD PTR" to "RSDP"
 *
 ******************************************************************************/

static void
AxNormalizeSignature (
    char                    *Signature)
{

    if (!strncmp (Signature, "RSD ", 4))
    {
        Signature[3] = 'P';
    }
}


/******************************************************************************
 *
 * FUNCTION:    AxConvertLine
 *
 * PARAMETERS:  InputLine           - One line from the input acpidump file
 *              OutputData          - Where the converted data is returned
 *
 * RETURN:      The number of bytes actually converted
 *
 * DESCRIPTION: Convert one line of ascii text binary (up to 16 bytes)
 *
 ******************************************************************************/

static size_t
AxConvertLine (
    char                    *InputLine,
    unsigned char           *OutputData)
{
    char                    *End;
    int                     BytesConverted;
    int                     Converted[16];
    int                     i;


    /* Terminate the input line at the end of the actual data (for sscanf) */

    End = strstr (InputLine + 2, "  ");
    if (!End)
    {
        return (0); /* Don't understand the format */
    }
    *End = 0;

    /*
     * Convert one line of table data, of the form:
     * <offset>: <up to 16 bytes of hex data> <ASCII representation> <newline>
     *
     * Example:
     * 02C0: 5F 53 42 5F 4C 4E 4B 44 00 12 13 04 0C FF FF 08  _SB_LNKD........
     */
    BytesConverted = sscanf (InputLine,
        "%*s %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x",
        &Converted[0],  &Converted[1],  &Converted[2],  &Converted[3],
        &Converted[4],  &Converted[5],  &Converted[6],  &Converted[7],
        &Converted[8],  &Converted[9],  &Converted[10], &Converted[11],
        &Converted[12], &Converted[13], &Converted[14], &Converted[15]);

    /* Pack converted data into a byte array */

    for (i = 0; i < BytesConverted; i++)
    {
        OutputData[i] = (unsigned char) Converted[i];
    }

    return ((size_t) BytesConverted);
}


/******************************************************************************
 *
 * FUNCTION:    AxGetTableHeader
 *
 * PARAMETERS:  InputFile           - Handle for the input acpidump file
 *              OutputData          - Where the table header is returned
 *
 * RETURN:      The actual number of bytes converted
 *
 * DESCRIPTION: Extract and convert an ACPI table header
 *
 ******************************************************************************/

static size_t
AxGetTableHeader (
    FILE                    *InputFile,
    unsigned char           *OutputData)
{
    size_t                  BytesConverted;
    size_t                  TotalConverted = 0;
    int                     i;


    /* Get the full 36 byte ACPI table header, requires 3 input text lines */

    for (i = 0; i < 3; i++)
    {
        if (!fgets (HeaderBuffer, AX_LINE_BUFFER_SIZE, InputFile))
        {
            return (TotalConverted);
        }

        BytesConverted = AxConvertLine (HeaderBuffer, OutputData);
        TotalConverted += BytesConverted;
        OutputData += 16;

        if (BytesConverted != 16)
        {
            return (TotalConverted);
        }
    }

    return (TotalConverted);
}


/******************************************************************************
 *
 * FUNCTION:    AxCountTableInstances
 *
 * PARAMETERS:  InputPathname       - Filename for acpidump file
 *              Signature           - Requested signature to count
 *
 * RETURN:      The number of instances of the signature
 *
 * DESCRIPTION: Count the instances of tables with the given signature within
 *              the input acpidump file.
 *
 ******************************************************************************/

static unsigned int
AxCountTableInstances (
    char                    *InputPathname,
    char                    *Signature)
{
    FILE                    *InputFile;
    unsigned int            Instances = 0;


    InputFile = fopen (InputPathname, "rt");
    if (!InputFile)
    {
        printf ("Could not open file %s\n", InputPathname);
        return (0);
    }

    /* Count the number of instances of this signature */

    while (fgets (InstanceBuffer, AX_LINE_BUFFER_SIZE, InputFile))
    {
        /* Ignore empty lines and lines that start with a space */

        if (AxIsEmptyLine (InstanceBuffer) ||
            (InstanceBuffer[0] == ' '))
        {
            continue;
        }

        AxNormalizeSignature (InstanceBuffer);
        if (ACPI_COMPARE_NAME (InstanceBuffer, Signature))
        {
            Instances++;
        }
    }

    fclose (InputFile);
    return (Instances);
}


/******************************************************************************
 *
 * FUNCTION:    AxGetNextInstance
 *
 * PARAMETERS:  InputPathname       - Filename for acpidump file
 *              Signature           - Requested ACPI signature
 *
 * RETURN:      The next instance number for this signature. Zero if this
 *              is the first instance of this signature.
 *
 * DESCRIPTION: Get the next instance number of the specified table. If this
 *              is the first instance of the table, create a new instance
 *              block. Note: only SSDT and PSDT tables can have multiple
 *              instances.
 *
 ******************************************************************************/

static unsigned int
AxGetNextInstance (
    char                    *InputPathname,
    char                    *Signature)
{
    AX_TABLE_INFO           *Info;


    Info = AxTableListHead;
    while (Info)
    {
        if (*(UINT32 *) Signature == Info->Signature)
        {
            break;
        }

        Info = Info->Next;
    }

    if (!Info)
    {
        /* Signature not found, create new table info block */

        Info = malloc (sizeof (AX_TABLE_INFO));
        if (!Info)
        {
            printf ("Could not allocate memory\n");
            exit (0);
        }

        Info->Signature = *(UINT32 *) Signature;
        Info->Instances = AxCountTableInstances (InputPathname, Signature);
        Info->NextInstance = 1;
        Info->Next = AxTableListHead;
        AxTableListHead = Info;
    }

    if (Info->Instances > 1)
    {
        return (Info->NextInstance++);
    }

    return (0);
}


/******************************************************************************
 *
 * FUNCTION:    AxExtractTables
 *
 * PARAMETERS:  InputPathname       - Filename for acpidump file
 *              Signature           - Requested ACPI signature to extract.
 *                                    NULL means extract ALL tables.
 *              MinimumInstances    - Min instances that are acceptable
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Convert text ACPI tables to binary
 *
 ******************************************************************************/

int
AxExtractTables (
    char                    *InputPathname,
    char                    *Signature,
    unsigned int            MinimumInstances)
{
    FILE                    *InputFile;
    FILE                    *OutputFile = NULL;
    size_t                  BytesWritten;
    size_t                  TotalBytesWritten = 0;
    size_t                  BytesConverted;
    unsigned int            State = AX_STATE_FIND_HEADER;
    unsigned int            FoundTable = 0;
    unsigned int            Instances = 0;
    unsigned int            ThisInstance;
    char                    ThisSignature[4];
    int                     Status = 0;


    /* Open input in text mode, output is in binary mode */

    InputFile = fopen (InputPathname, "rt");
    if (!InputFile)
    {
        printf ("Could not open file %s\n", InputPathname);
        return (-1);
    }

    if (Signature)
    {
        /* Are there enough instances of the table to continue? */

        AxNormalizeSignature (Signature);

        Instances = AxCountTableInstances (InputPathname, Signature);
        if (Instances < MinimumInstances)
        {
            printf ("Table %s was not found in %s\n", Signature, InputPathname);
            Status = -1;
            goto CleanupAndExit;
        }

        if (Instances == 0)
        {
            goto CleanupAndExit;
        }
    }

    /* Convert all instances of the table to binary */

    while (fgets (LineBuffer, AX_LINE_BUFFER_SIZE, InputFile))
    {
        switch (State)
        {
        case AX_STATE_FIND_HEADER:

            /* Ignore lines that are too short to be header lines */

            if (strlen (LineBuffer) < AX_MIN_TABLE_NAME_LENGTH)
            {
                continue;
            }

            /* Ignore empty lines and lines that start with a space */

            if (AxIsEmptyLine (LineBuffer) ||
                (LineBuffer[0] == ' '))
            {
                continue;
            }

            /*
             * Ignore lines that are not of the form <sig> @ <addr>.
             * Examples of lines that must be supported:
             *
             * DSDT @ 0x737e4000
             * XSDT @ 0x737f2fff
             * RSD PTR @ 0xf6cd0
             * SSDT @ (nil)
             */
            if (!strstr (LineBuffer, " @ "))
            {
                continue;
            }

            AxNormalizeSignature (LineBuffer);
            ACPI_MOVE_NAME (ThisSignature, LineBuffer);

            if (Signature)
            {
                /* Ignore signatures that don't match */

                if (!ACPI_COMPARE_NAME (ThisSignature, Signature))
                {
                    continue;
                }
            }

            /*
             * Get the instance number for this signature. Only the
             * SSDT and PSDT tables can have multiple instances.
             */
            ThisInstance = AxGetNextInstance (InputPathname, ThisSignature);

            /* Build an output filename and create/open the output file */

            if (ThisInstance > 0)
            {
                sprintf (Filename, "%4.4s%u.dat", ThisSignature, ThisInstance);
            }
            else
            {
                sprintf (Filename, "%4.4s.dat", ThisSignature);
            }

            AxStrlwr (Filename);
            OutputFile = fopen (Filename, "w+b");
            if (!OutputFile)
            {
                printf ("Could not open file %s\n", Filename);
                Status = -1;
                goto CleanupAndExit;
            }

            State = AX_STATE_EXTRACT_DATA;
            TotalBytesWritten = 0;
            FoundTable = 1;
            continue;

        case AX_STATE_EXTRACT_DATA:

            /* Empty line or non-data line terminates the data */

            if (AxIsEmptyLine (LineBuffer) ||
                (LineBuffer[0] != ' '))
            {
                fclose (OutputFile);
                OutputFile = NULL;
                State = AX_STATE_FIND_HEADER;

                printf ("Acpi table [%4.4s] - %u bytes written to %s\n",
                    ThisSignature, (unsigned int) TotalBytesWritten, Filename);
                continue;
            }

            /* Convert the ascii data (one line of text) to binary */

            BytesConverted = AxConvertLine (LineBuffer, Data);

            /* Write the binary data */

            BytesWritten = fwrite (Data, 1, BytesConverted, OutputFile);
            if (BytesWritten != BytesConverted)
            {
                printf ("Error when writing file %s\n", Filename);
                fclose (OutputFile);
                OutputFile = NULL;
                Status = -1;
                goto CleanupAndExit;
            }

            TotalBytesWritten += BytesConverted;
            continue;

        default:

            Status = -1;
            goto CleanupAndExit;
        }
    }

    if (!FoundTable)
    {
        printf ("Table %s was not found in %s\n", Signature, InputPathname);
    }


CleanupAndExit:

    if (OutputFile)
    {
        fclose (OutputFile);
        if (State == AX_STATE_EXTRACT_DATA)
        {
            /* Received an EOF while extracting data */

            printf ("Acpi table [%4.4s] - %u bytes written to %s\n",
                ThisSignature, (unsigned int) TotalBytesWritten, Filename);
        }
    }

    fclose (InputFile);
    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AxListTables
 *
 * PARAMETERS:  InputPathname       - Filename for acpidump file
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Display info for all ACPI tables found in input. Does not
 *              perform an actual extraction of the tables.
 *
 ******************************************************************************/

int
AxListTables (
    char                    *InputPathname)
{
    FILE                    *InputFile;
    size_t                  HeaderSize;
    unsigned char           Header[48];
    int                     TableCount = 0;
    ACPI_TABLE_HEADER       *TableHeader = (ACPI_TABLE_HEADER *) (void *) Header;


    /* Open input in text mode, output is in binary mode */

    InputFile = fopen (InputPathname, "rt");
    if (!InputFile)
    {
        printf ("Could not open file %s\n", InputPathname);
        return (-1);
    }

    /* Dump the headers for all tables found in the input file */

    printf ("\nSignature  Length      Revision   OemId    OemTableId"
            "   OemRevision CompilerId CompilerRevision\n\n");

    while (fgets (LineBuffer, AX_LINE_BUFFER_SIZE, InputFile))
    {
        /* Ignore empty lines and lines that start with a space */

        if (AxIsEmptyLine (LineBuffer) ||
            (LineBuffer[0] == ' '))
        {
            continue;
        }

        /* Get the 36 byte header and display the fields */

        HeaderSize = AxGetTableHeader (InputFile, Header);
        if (HeaderSize < 16)
        {
            continue;
        }

        /* RSDP has an oddball signature and header */

        if (!strncmp (TableHeader->Signature, "RSD PTR ", 8))
        {
            AxCheckAscii ((char *) &Header[9], 6);
            printf ("%7.4s                          \"%6.6s\"\n", "RSDP", &Header[9]);
            TableCount++;
            continue;
        }

        /* Minimum size for table with standard header */

        if (HeaderSize < sizeof (ACPI_TABLE_HEADER))
        {
            continue;
        }

        /* Signature and Table length */

        TableCount++;
        printf ("%7.4s   0x%8.8X", TableHeader->Signature, TableHeader->Length);

        /* FACS has only signature and length */

        if (ACPI_COMPARE_NAME (TableHeader->Signature, "FACS"))
        {
            printf ("\n");
            continue;
        }

        /* OEM IDs and Compiler IDs */

        AxCheckAscii (TableHeader->OemId, 6);
        AxCheckAscii (TableHeader->OemTableId, 8);
        AxCheckAscii (TableHeader->AslCompilerId, 4);

        printf ("     0x%2.2X    \"%6.6s\"  \"%8.8s\"   0x%8.8X    \"%4.4s\"     0x%8.8X\n",
            TableHeader->Revision, TableHeader->OemId,
            TableHeader->OemTableId, TableHeader->OemRevision,
            TableHeader->AslCompilerId, TableHeader->AslCompilerRevision);
    }

    printf ("\nFound %u ACPI tables\n", TableCount);
    fclose (InputFile);
    return (0);
}
