/******************************************************************************
 *
 * Module Name: ahdecode - Operator/Opcode decoding for acpihelp utility
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

#define ACPI_CREATE_PREDEFINED_TABLE
#define ACPI_CREATE_RESOURCE_TABLE

#include "acpihelp.h"
#include "acpredef.h"


#define AH_DISPLAY_EXCEPTION(Status, Name) \
    printf ("%.4X: %s\n", Status, Name)

#define AH_DISPLAY_EXCEPTION_TEXT(Status, Exception) \
    printf ("%.4X: %-28s (%s)\n", Status, Exception->Name, Exception->Description)

#define BUFFER_LENGTH           128
#define LINE_BUFFER_LENGTH      512

static char         Gbl_Buffer[BUFFER_LENGTH];
static char         Gbl_LineBuffer[LINE_BUFFER_LENGTH];

/* Local prototypes */

static BOOLEAN
AhDisplayPredefinedName (
    char                    *Name,
    UINT32                  Length);

static void
AhDisplayPredefinedInfo (
    char                    *Name);

static void
AhDisplayResourceName (
    const ACPI_PREDEFINED_INFO  *ThisName);

static void
AhDisplayAmlOpcode (
    const AH_AML_OPCODE     *Op);

static void
AhDisplayAslOperator (
    const AH_ASL_OPERATOR   *Op);

static void
AhDisplayOperatorKeywords (
    const AH_ASL_OPERATOR   *Op);

static void
AhDisplayAslKeyword (
    const AH_ASL_KEYWORD    *Op);

static void
AhPrintOneField (
    UINT32                  Indent,
    UINT32                  CurrentPosition,
    UINT32                  MaxPosition,
    const char              *Field);


/*******************************************************************************
 *
 * FUNCTION:    AhFindPredefinedNames (entry point for predefined name search)
 *
 * PARAMETERS:  NamePrefix          - Name or prefix to find. Must start with
 *                                    an underscore. NULL means "find all"
 *
 * RETURN:      None
 *
 * DESCRIPTION: Find and display all ACPI predefined names that match the
 *              input name or prefix. Includes the required number of arguments
 *              and the expected return type, if any.
 *
 ******************************************************************************/

void
AhFindPredefinedNames (
    char                    *NamePrefix)
{
    UINT32                  Length;
    BOOLEAN                 Found;
    char                    Name[9];


    if (!NamePrefix)
    {
        Found = AhDisplayPredefinedName (Name, 0);
        return;
    }

    /* Contruct a local name or name prefix */

    AhStrupr (NamePrefix);
    if (*NamePrefix == '_')
    {
        NamePrefix++;
    }

    Name[0] = '_';
    strncpy (&Name[1], NamePrefix, 7);

    Length = strlen (Name);
    if (Length > 4)
    {
        printf ("%.8s: Predefined name must be 4 characters maximum\n", Name);
        return;
    }

    Found = AhDisplayPredefinedName (Name, Length);
    if (!Found)
    {
        printf ("%s, no matching predefined names\n", Name);
    }
}


/*******************************************************************************
 *
 * FUNCTION:    AhDisplayPredefinedName
 *
 * PARAMETERS:  Name                - Name or name prefix
 *
 * RETURN:      TRUE if any names matched, FALSE otherwise
 *
 * DESCRIPTION: Display information about ACPI predefined names that match
 *              the input name or name prefix.
 *
 ******************************************************************************/

static BOOLEAN
AhDisplayPredefinedName (
    char                    *Name,
    UINT32                  Length)
{
    const AH_PREDEFINED_NAME    *Info;
    BOOLEAN                     Found = FALSE;
    BOOLEAN                     Matched;
    UINT32                      i;


    /* Find/display all names that match the input name prefix */

    for (Info = AslPredefinedInfo; Info->Name; Info++)
    {
        if (!Name)
        {
            Found = TRUE;
            printf ("%s: <%s>\n", Info->Name, Info->Description);
            printf ("%*s%s\n", 6, " ", Info->Action);

            AhDisplayPredefinedInfo (Info->Name);
            continue;
        }

        Matched = TRUE;
        for (i = 0; i < Length; i++)
        {
            if (Info->Name[i] != Name[i])
            {
                Matched = FALSE;
                break;
            }
        }

        if (Matched)
        {
            Found = TRUE;
            printf ("%s: <%s>\n", Info->Name, Info->Description);
            printf ("%*s%s\n", 6, " ", Info->Action);

            AhDisplayPredefinedInfo (Info->Name);
        }
    }

    return (Found);
}


/*******************************************************************************
 *
 * FUNCTION:    AhDisplayPredefinedInfo
 *
 * PARAMETERS:  Name                - Exact 4-character ACPI name.
 *
 * RETURN:      None
 *
 * DESCRIPTION: Find the name in the main ACPICA predefined info table and
 *              display the # of arguments and the return value type.
 *
 *              Note: Resource Descriptor field names do not appear in this
 *              table -- thus, nothing will be displayed for them.
 *
 ******************************************************************************/

static void
AhDisplayPredefinedInfo (
    char                        *Name)
{
    const ACPI_PREDEFINED_INFO  *ThisName;


    /* NOTE: we check both tables always because there are some dupes */

    /* Check against the predefine methods first */

    ThisName = AcpiUtMatchPredefinedMethod (Name);
    if (ThisName)
    {
        AcpiUtDisplayPredefinedMethod (Gbl_Buffer, ThisName, TRUE);
    }

    /* Check against the predefined resource descriptor names */

    ThisName = AcpiUtMatchResourceName (Name);
    if (ThisName)
    {
        AhDisplayResourceName (ThisName);
    }
}


/*******************************************************************************
 *
 * FUNCTION:    AhDisplayResourceName
 *
 * PARAMETERS:  ThisName            - Entry in the predefined method/name table
 *
 * RETURN:      None
 *
 * DESCRIPTION: Display information about a resource descriptor name.
 *
 ******************************************************************************/

static void
AhDisplayResourceName (
    const ACPI_PREDEFINED_INFO  *ThisName)
{
    UINT32                      NumTypes;


    NumTypes = AcpiUtGetResourceBitWidth (Gbl_Buffer,
        ThisName->Info.ArgumentList);

    printf ("      %4.4s resource descriptor field is %s bits wide%s\n",
        ThisName->Info.Name,
        Gbl_Buffer,
        (NumTypes > 1) ? " (depending on descriptor type)" : "");
}


/*******************************************************************************
 *
 * FUNCTION:    AhFindAmlOpcode (entry point for AML opcode name search)
 *
 * PARAMETERS:  Name                - Name or prefix for an AML opcode.
 *                                    NULL means "find all"
 *
 * RETURN:      None
 *
 * DESCRIPTION: Find all AML opcodes that match the input Name or name
 *              prefix.
 *
 ******************************************************************************/

void
AhFindAmlOpcode (
    char                    *Name)
{
    const AH_AML_OPCODE     *Op;
    BOOLEAN                 Found = FALSE;


    AhStrupr (Name);

    /* Find/display all opcode names that match the input name prefix */

    for (Op = AmlOpcodeInfo; Op->OpcodeString; Op++)
    {
        if (!Op->OpcodeName) /* Unused opcodes */
        {
            continue;
        }

        if (!Name)
        {
            AhDisplayAmlOpcode (Op);
            Found = TRUE;
            continue;
        }

        /* Upper case the opcode name before substring compare */

        strcpy (Gbl_Buffer, Op->OpcodeName);
        AhStrupr (Gbl_Buffer);

        if (strstr (Gbl_Buffer, Name) == Gbl_Buffer)
        {
            AhDisplayAmlOpcode (Op);
            Found = TRUE;
        }
    }

    if (!Found)
    {
        printf ("%s, no matching AML operators\n", Name);
    }
}


/*******************************************************************************
 *
 * FUNCTION:    AhDecodeAmlOpcode (entry point for AML opcode search)
 *
 * PARAMETERS:  OpcodeString        - String version of AML opcode
 *
 * RETURN:      None
 *
 * DESCRIPTION: Display information about the input AML opcode
 *
 ******************************************************************************/

void
AhDecodeAmlOpcode (
    char                    *OpcodeString)
{
    const AH_AML_OPCODE     *Op;
    UINT32                  Opcode;
    UINT8                   Prefix;


    if (!OpcodeString)
    {
        AhFindAmlOpcode (NULL);
        return;
    }

    Opcode = ACPI_STRTOUL (OpcodeString, NULL, 16);
    if (Opcode > ACPI_UINT16_MAX)
    {
        printf ("Invalid opcode (more than 16 bits)\n");
        return;
    }

    /* Only valid opcode extension is 0x5B */

    Prefix = (Opcode & 0x0000FF00) >> 8;
    if (Prefix && (Prefix != 0x5B))
    {
        printf ("Invalid opcode (invalid extension prefix 0x%X)\n",
            Prefix);
        return;
    }

    /* Find/Display the opcode. May fall within an opcode range */

    for (Op = AmlOpcodeInfo; Op->OpcodeString; Op++)
    {
        if ((Opcode >= Op->OpcodeRangeStart) &&
            (Opcode <= Op->OpcodeRangeEnd))
        {
            AhDisplayAmlOpcode (Op);
        }
    }
}


/*******************************************************************************
 *
 * FUNCTION:    AhDisplayAmlOpcode
 *
 * PARAMETERS:  Op                  - An opcode info struct
 *
 * RETURN:      None
 *
 * DESCRIPTION: Display the contents of an AML opcode information struct
 *
 ******************************************************************************/

static void
AhDisplayAmlOpcode (
    const AH_AML_OPCODE     *Op)
{

    if (!Op->OpcodeName)
    {
        printf ("%18s: Opcode=%-9s\n", "Reserved opcode", Op->OpcodeString);
        return;
    }

    /* Opcode name and value(s) */

    printf ("%18s: Opcode=%-9s Type (%s)",
        Op->OpcodeName, Op->OpcodeString, Op->Type);

    /* Optional fixed/static arguments */

    if (Op->FixedArguments)
    {
        printf (" FixedArgs (");
        AhPrintOneField (37, 36 + 7 + strlen (Op->Type) + 12,
            AH_MAX_AML_LINE_LENGTH, Op->FixedArguments);
        printf (")");
    }

    /* Optional variable-length argument list */

    if (Op->VariableArguments)
    {
        if (Op->FixedArguments)
        {
            printf ("\n%*s", 36, " ");
        }
        printf (" VariableArgs (");
        AhPrintOneField (37, 15, AH_MAX_AML_LINE_LENGTH, Op->VariableArguments);
        printf (")");
    }
    printf ("\n");

    /* Grammar specification */

    if (Op->Grammar)
    {
        AhPrintOneField (37, 0, AH_MAX_AML_LINE_LENGTH, Op->Grammar);
        printf ("\n");
    }
}


/*******************************************************************************
 *
 * FUNCTION:    AhFindAslKeywords (entry point for ASL keyword search)
 *
 * PARAMETERS:  Name                - Name or prefix for an ASL keyword.
 *                                    NULL means "find all"
 *
 * RETURN:      None
 *
 * DESCRIPTION: Find all ASL keywords that match the input Name or name
 *              prefix.
 *
 ******************************************************************************/

void
AhFindAslKeywords (
    char                    *Name)
{
    const AH_ASL_KEYWORD    *Keyword;
    BOOLEAN                 Found = FALSE;


    AhStrupr (Name);

    for (Keyword = AslKeywordInfo; Keyword->Name; Keyword++)
    {
        if (!Name)
        {
            AhDisplayAslKeyword (Keyword);
            Found = TRUE;
            continue;
        }

        /* Upper case the operator name before substring compare */

        strcpy (Gbl_Buffer, Keyword->Name);
        AhStrupr (Gbl_Buffer);

        if (strstr (Gbl_Buffer, Name) == Gbl_Buffer)
        {
            AhDisplayAslKeyword (Keyword);
            Found = TRUE;
        }
    }

    if (!Found)
    {
        printf ("%s, no matching ASL keywords\n", Name);
    }
}


/*******************************************************************************
 *
 * FUNCTION:    AhDisplayAslKeyword
 *
 * PARAMETERS:  Op                  - Pointer to ASL keyword with syntax info
 *
 * RETURN:      None
 *
 * DESCRIPTION: Format and display syntax info for an ASL keyword. Splits
 *              long lines appropriately for reading.
 *
 ******************************************************************************/

static void
AhDisplayAslKeyword (
    const AH_ASL_KEYWORD    *Op)
{

    /* ASL keyword name and description */

    printf ("%22s: %s\n", Op->Name, Op->Description);
    if (!Op->KeywordList)
    {
        return;
    }

    /* List of actual keywords */

    AhPrintOneField (24, 0, AH_MAX_ASL_LINE_LENGTH, Op->KeywordList);
    printf ("\n");
}


/*******************************************************************************
 *
 * FUNCTION:    AhFindAslAndAmlOperators
 *
 * PARAMETERS:  Name                - Name or prefix for an ASL operator.
 *                                    NULL means "find all"
 *
 * RETURN:      None
 *
 * DESCRIPTION: Find all ASL operators that match the input Name or name
 *              prefix. Also displays the AML information if only one entry
 *              matches.
 *
 ******************************************************************************/

void
AhFindAslAndAmlOperators (
    char                    *Name)
{
    UINT32                  MatchCount;


    MatchCount = AhFindAslOperators (Name);
    if (MatchCount == 1)
    {
        AhFindAmlOpcode (Name);
    }
}


/*******************************************************************************
 *
 * FUNCTION:    AhFindAslOperators (entry point for ASL operator search)
 *
 * PARAMETERS:  Name                - Name or prefix for an ASL operator.
 *                                    NULL means "find all"
 *
 * RETURN:      Number of operators that matched the name prefix.
 *
 * DESCRIPTION: Find all ASL operators that match the input Name or name
 *              prefix.
 *
 ******************************************************************************/

UINT32
AhFindAslOperators (
    char                    *Name)
{
    const AH_ASL_OPERATOR   *Operator;
    BOOLEAN                 MatchCount = 0;


    AhStrupr (Name);

    /* Find/display all names that match the input name prefix */

    for (Operator = AslOperatorInfo; Operator->Name; Operator++)
    {
        if (!Name)
        {
            AhDisplayAslOperator (Operator);
            MatchCount++;
            continue;
        }

        /* Upper case the operator name before substring compare */

        strcpy (Gbl_Buffer, Operator->Name);
        AhStrupr (Gbl_Buffer);

        if (strstr (Gbl_Buffer, Name) == Gbl_Buffer)
        {
            AhDisplayAslOperator (Operator);
            MatchCount++;
        }
    }

    if (!MatchCount)
    {
        printf ("%s, no matching ASL operators\n", Name);
    }

    return (MatchCount);
}


/*******************************************************************************
 *
 * FUNCTION:    AhDisplayAslOperator
 *
 * PARAMETERS:  Op                  - Pointer to ASL operator with syntax info
 *
 * RETURN:      None
 *
 * DESCRIPTION: Format and display syntax info for an ASL operator. Splits
 *              long lines appropriately for reading.
 *
 ******************************************************************************/

static void
AhDisplayAslOperator (
    const AH_ASL_OPERATOR   *Op)
{

    /* ASL operator name and description */

    printf ("%16s: %s\n", Op->Name, Op->Description);
    if (!Op->Syntax)
    {
        return;
    }

    /* Syntax for the operator */

    AhPrintOneField (18, 0, AH_MAX_ASL_LINE_LENGTH, Op->Syntax);
    printf ("\n");

    AhDisplayOperatorKeywords (Op);
    printf ("\n");
}


/*******************************************************************************
 *
 * FUNCTION:    AhDisplayOperatorKeywords
 *
 * PARAMETERS:  Op                  - Pointer to ASL keyword with syntax info
 *
 * RETURN:      None
 *
 * DESCRIPTION: Display any/all keywords that are associated with the ASL
 *              operator.
 *
 ******************************************************************************/

static void
AhDisplayOperatorKeywords (
    const AH_ASL_OPERATOR   *Op)
{
    char                    *Token;
    char                    *Separators = "(){}, ";
    BOOLEAN                 FirstKeyword = TRUE;


    if (!Op || !Op->Syntax)
    {
        return;
    }

    /*
     * Find all parameters that have the word "keyword" within, and then
     * display the info about that keyword
     */
    strcpy (Gbl_LineBuffer, Op->Syntax);
    Token = strtok (Gbl_LineBuffer, Separators);
    while (Token)
    {
        if (strstr (Token, "Keyword"))
        {
            if (FirstKeyword)
            {
                printf ("\n");
                FirstKeyword = FALSE;
            }

            /* Found a keyword, display keyword information */

            AhFindAslKeywords (Token);
        }

        Token = strtok (NULL, Separators);
    }
}


/*******************************************************************************
 *
 * FUNCTION:    AhPrintOneField
 *
 * PARAMETERS:  Indent              - Indent length for new line(s)
 *              CurrentPosition     - Position on current line
 *              MaxPosition         - Max allowed line length
 *              Field               - Data to output
 *
 * RETURN:      Line position after field is written
 *
 * DESCRIPTION: Split long lines appropriately for ease of reading.
 *
 ******************************************************************************/

static void
AhPrintOneField (
    UINT32                  Indent,
    UINT32                  CurrentPosition,
    UINT32                  MaxPosition,
    const char              *Field)
{
    UINT32                  Position;
    UINT32                  TokenLength;
    const char              *This;
    const char              *Next;
    const char              *Last;


    This = Field;
    Position = CurrentPosition;

    if (Position == 0)
    {
        printf ("%*s", (int) Indent, " ");
        Position = Indent;
    }

    Last = This + strlen (This);
    while ((Next = strpbrk (This, " ")))
    {
        TokenLength = Next - This;
        Position += TokenLength;

        /* Split long lines */

        if (Position > MaxPosition)
        {
            printf ("\n%*s", (int) Indent, " ");
            Position = TokenLength;
        }

        printf ("%.*s ", (int) TokenLength, This);
        This = Next + 1;
    }

    /* Handle last token on the input line */

    TokenLength = Last - This;
    if (TokenLength > 0)
    {
        Position += TokenLength;
        if (Position > MaxPosition)
        {
            printf ("\n%*s", (int) Indent, " ");
        }
        printf ("%s", This);
    }
}


/*******************************************************************************
 *
 * FUNCTION:    AhDisplayDeviceIds
 *
 * PARAMETERS:  Name                - Device Hardware ID string.
 *                                    NULL means "find all"
 *
 * RETURN:      None
 *
 * DESCRIPTION: Display PNP* and ACPI* device IDs.
 *
 ******************************************************************************/

void
AhDisplayDeviceIds (
    char                    *Name)
{
    const AH_DEVICE_ID      *Info;
    UINT32                  Length;
    BOOLEAN                 Matched;
    UINT32                  i;
    BOOLEAN                 Found = FALSE;


    /* Null input name indicates "display all" */

    if (!Name)
    {
        printf ("ACPI and PNP Device/Hardware IDs:\n\n");
        for (Info = AslDeviceIds; Info->Name; Info++)
        {
            printf ("%8s   %s\n", Info->Name, Info->Description);
        }

        return;
    }

    Length = strlen (Name);
    if (Length > 8)
    {
        printf ("%.8s: Hardware ID must be 8 characters maximum\n", Name);
        return;
    }

    /* Find/display all names that match the input name prefix */

    AhStrupr (Name);
    for (Info = AslDeviceIds; Info->Name; Info++)
    {
        Matched = TRUE;
        for (i = 0; i < Length; i++)
        {
            if (Info->Name[i] != Name[i])
            {
                Matched = FALSE;
                break;
            }
        }

        if (Matched)
        {
            Found = TRUE;
            printf ("%8s   %s\n", Info->Name, Info->Description);
        }
    }

    if (!Found)
    {
        printf ("%s, Hardware ID not found\n", Name);
    }
}


/*******************************************************************************
 *
 * FUNCTION:    AhDecodeException
 *
 * PARAMETERS:  HexString           - ACPI status string from command line, in
 *                                    hex. If null, display all exceptions.
 *
 * RETURN:      None
 *
 * DESCRIPTION: Decode and display an ACPI_STATUS exception code.
 *
 ******************************************************************************/

void
AhDecodeException (
    char                    *HexString)
{
    const ACPI_EXCEPTION_INFO   *ExceptionInfo;
    UINT32                      Status;
    UINT32                      i;


    /*
     * A null input string means to decode and display all known
     * exception codes.
     */
    if (!HexString)
    {
        printf ("All defined ACPICA exception codes:\n\n");
        AH_DISPLAY_EXCEPTION (0, "AE_OK                        (No error occurred)");

        /* Display codes in each block of exception types */

        for (i = 1; (i & AE_CODE_MASK) <= AE_CODE_MAX; i += 0x1000)
        {
            Status = i;
            do
            {
                ExceptionInfo = AcpiUtValidateException ((ACPI_STATUS) Status);
                if (ExceptionInfo)
                {
                    AH_DISPLAY_EXCEPTION_TEXT (Status, ExceptionInfo);
                }
                Status++;

            } while (ExceptionInfo);
        }
        return;
    }

    /* Decode a single user-supplied exception code */

    Status = ACPI_STRTOUL (HexString, NULL, 16);
    if (!Status)
    {
        printf ("%s: Invalid hexadecimal exception code value\n", HexString);
        return;
    }

    if (Status > ACPI_UINT16_MAX)
    {
        AH_DISPLAY_EXCEPTION (Status, "Invalid exception code (more than 16 bits)");
        return;
    }

    ExceptionInfo = AcpiUtValidateException ((ACPI_STATUS) Status);
    if (!ExceptionInfo)
    {
        AH_DISPLAY_EXCEPTION (Status, "Unknown exception code");
        return;
    }

    AH_DISPLAY_EXCEPTION_TEXT (Status, ExceptionInfo);
}
