/******************************************************************************
 *
 * Module Name: aslprepkg - support for ACPI predefined name package objects
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

#include "aslcompiler.h"
#include "aslcompiler.y.h"
#include "acpredef.h"


#define _COMPONENT          ACPI_COMPILER
        ACPI_MODULE_NAME    ("aslprepkg")


/* Local prototypes */

static void
ApCheckPackageElements (
    const char                  *PredefinedName,
    ACPI_PARSE_OBJECT           *Op,
    UINT8                       Type1,
    UINT32                      Count1,
    UINT8                       Type2,
    UINT32                      Count2);

static void
ApCheckPackageList (
    const char                  *PredefinedName,
    ACPI_PARSE_OBJECT           *ParentOp,
    const ACPI_PREDEFINED_INFO  *Package,
    UINT32                      StartIndex,
    UINT32                      Count);

static void
ApPackageTooSmall (
    const char                  *PredefinedName,
    ACPI_PARSE_OBJECT           *Op,
    UINT32                      Count,
    UINT32                      ExpectedCount);

static void
ApZeroLengthPackage (
    const char                  *PredefinedName,
    ACPI_PARSE_OBJECT           *Op);

static void
ApPackageTooLarge (
    const char                  *PredefinedName,
    ACPI_PARSE_OBJECT           *Op,
    UINT32                      Count,
    UINT32                      ExpectedCount);


/*******************************************************************************
 *
 * FUNCTION:    ApCheckPackage
 *
 * PARAMETERS:  ParentOp            - Parser op for the package
 *              Predefined          - Pointer to package-specific info for
 *                                    the method
 *
 * RETURN:      None
 *
 * DESCRIPTION: Top-level validation for predefined name return package
 *              objects.
 *
 ******************************************************************************/

void
ApCheckPackage (
    ACPI_PARSE_OBJECT           *ParentOp,
    const ACPI_PREDEFINED_INFO  *Predefined)
{
    ACPI_PARSE_OBJECT           *Op;
    const ACPI_PREDEFINED_INFO  *Package;
    ACPI_STATUS                 Status;
    UINT32                      ExpectedCount;
    UINT32                      Count;
    UINT32                      i;


    /* The package info for this name is in the next table entry */

    Package = Predefined + 1;

    /* First child is the package length */

    Op = ParentOp->Asl.Child;
    Count = (UINT32) Op->Asl.Value.Integer;

    /*
     * Many of the variable-length top-level packages are allowed to simply
     * have zero elements. This allows the BIOS to tell the host that even
     * though the predefined name/method exists, the feature is not supported.
     * Other package types require one or more elements. In any case, there
     * is no need to continue validation.
     */
    if (!Count)
    {
        switch (Package->RetInfo.Type)
        {
        case ACPI_PTYPE1_FIXED:
        case ACPI_PTYPE1_OPTION:
        case ACPI_PTYPE2_PKG_COUNT:
        case ACPI_PTYPE2_REV_FIXED:

            ApZeroLengthPackage (Predefined->Info.Name, ParentOp);
            break;

        case ACPI_PTYPE1_VAR:
        case ACPI_PTYPE2:
        case ACPI_PTYPE2_COUNT:
        case ACPI_PTYPE2_FIXED:
        case ACPI_PTYPE2_MIN:
        case ACPI_PTYPE2_FIX_VAR:
        default:

            break;
        }

        return;
    }

    /* Get the first element of the package */

    Op = Op->Asl.Next;

    /* Decode the package type */

    switch (Package->RetInfo.Type)
    {
    case ACPI_PTYPE1_FIXED:
        /*
         * The package count is fixed and there are no subpackages
         *
         * If package is too small, exit.
         * If package is larger than expected, issue warning but continue
         */
        ExpectedCount = Package->RetInfo.Count1 + Package->RetInfo.Count2;
        if (Count < ExpectedCount)
        {
            goto PackageTooSmall;
        }
        else if (Count > ExpectedCount)
        {
            ApPackageTooLarge (Predefined->Info.Name, ParentOp,
                Count, ExpectedCount);
        }

        /* Validate all elements of the package */

        ApCheckPackageElements (Predefined->Info.Name, Op,
            Package->RetInfo.ObjectType1, Package->RetInfo.Count1,
            Package->RetInfo.ObjectType2, Package->RetInfo.Count2);
        break;

    case ACPI_PTYPE1_VAR:
        /*
         * The package count is variable, there are no subpackages,
         * and all elements must be of the same type
         */
        for (i = 0; i < Count; i++)
        {
            ApCheckObjectType (Predefined->Info.Name, Op,
                Package->RetInfo.ObjectType1, i);
            Op = Op->Asl.Next;
        }
        break;

    case ACPI_PTYPE1_OPTION:
        /*
         * The package count is variable, there are no subpackages.
         * There are a fixed number of required elements, and a variable
         * number of optional elements.
         *
         * Check if package is at least as large as the minimum required
         */
        ExpectedCount = Package->RetInfo3.Count;
        if (Count < ExpectedCount)
        {
            goto PackageTooSmall;
        }

        /* Variable number of sub-objects */

        for (i = 0; i < Count; i++)
        {
            if (i < Package->RetInfo3.Count)
            {
                /* These are the required package elements (0, 1, or 2) */

                ApCheckObjectType (Predefined->Info.Name, Op,
                    Package->RetInfo3.ObjectType[i], i);
            }
            else
            {
                /* These are the optional package elements */

                ApCheckObjectType (Predefined->Info.Name, Op,
                    Package->RetInfo3.TailObjectType, i);
            }
            Op = Op->Asl.Next;
        }
        break;

    case ACPI_PTYPE2_REV_FIXED:

        /* First element is the (Integer) revision */

        ApCheckObjectType (Predefined->Info.Name, Op,
            ACPI_RTYPE_INTEGER, 0);

        Op = Op->Asl.Next;
        Count--;

        /* Examine the subpackages */

        ApCheckPackageList (Predefined->Info.Name, Op,
            Package, 1, Count);
        break;

    case ACPI_PTYPE2_PKG_COUNT:

        /* First element is the (Integer) count of subpackages to follow */

        Status = ApCheckObjectType (Predefined->Info.Name, Op,
            ACPI_RTYPE_INTEGER, 0);

        /* We must have an integer count from above (otherwise, use Count) */

        if (ACPI_SUCCESS (Status))
        {
            /*
             * Count cannot be larger than the parent package length, but
             * allow it to be smaller. The >= accounts for the Integer above.
             */
            ExpectedCount = (UINT32) Op->Asl.Value.Integer;
            if (ExpectedCount >= Count)
            {
                goto PackageTooSmall;
            }

            Count = ExpectedCount;
        }

        Op = Op->Asl.Next;

        /* Examine the subpackages */

        ApCheckPackageList (Predefined->Info.Name, Op,
            Package, 1, Count);
        break;

    case ACPI_PTYPE2:
    case ACPI_PTYPE2_FIXED:
    case ACPI_PTYPE2_MIN:
    case ACPI_PTYPE2_COUNT:
    case ACPI_PTYPE2_FIX_VAR:
        /*
         * These types all return a single Package that consists of a
         * variable number of subpackages.
         */

        /* Examine the subpackages */

        ApCheckPackageList (Predefined->Info.Name, Op,
            Package, 0, Count);
        break;

    default:
        return;
    }

    return;

PackageTooSmall:
    ApPackageTooSmall (Predefined->Info.Name, ParentOp,
        Count, ExpectedCount);
}


/*******************************************************************************
 *
 * FUNCTION:    ApCheckPackageElements
 *
 * PARAMETERS:  PredefinedName      - Name of the predefined object
 *              Op                  - Parser op for the package
 *              Type1               - Object type for first group
 *              Count1              - Count for first group
 *              Type2               - Object type for second group
 *              Count2              - Count for second group
 *
 * RETURN:      None
 *
 * DESCRIPTION: Validate all elements of a package. Works with packages that
 *              are defined to contain up to two groups of different object
 *              types.
 *
 ******************************************************************************/

static void
ApCheckPackageElements (
    const char              *PredefinedName,
    ACPI_PARSE_OBJECT       *Op,
    UINT8                   Type1,
    UINT32                  Count1,
    UINT8                   Type2,
    UINT32                  Count2)
{
    UINT32                  i;


    /*
     * Up to two groups of package elements are supported by the data
     * structure. All elements in each group must be of the same type.
     * The second group can have a count of zero.
     *
     * Aborts check upon a NULL package element, as this means (at compile
     * time) that the remainder of the package elements are also NULL
     * (This is the only way to create NULL package elements.)
     */
    for (i = 0; (i < Count1) && Op; i++)
    {
        ApCheckObjectType (PredefinedName, Op, Type1, i);
        Op = Op->Asl.Next;
    }

    for (i = 0; (i < Count2) && Op; i++)
    {
        ApCheckObjectType (PredefinedName, Op, Type2, (i + Count1));
        Op = Op->Asl.Next;
    }
}


/*******************************************************************************
 *
 * FUNCTION:    ApCheckPackageList
 *
 * PARAMETERS:  PredefinedName      - Name of the predefined object
 *              ParentOp            - Parser op of the parent package
 *              Package             - Package info for this predefined name
 *              StartIndex          - Index in parent package where list begins
 *              ParentCount         - Element count of parent package
 *
 * RETURN:      None
 *
 * DESCRIPTION: Validate the individual package elements for a predefined name.
 *              Handles the cases where the predefined name is defined as a
 *              Package of Packages (subpackages). These are the types:
 *
 *              ACPI_PTYPE2
 *              ACPI_PTYPE2_FIXED
 *              ACPI_PTYPE2_MIN
 *              ACPI_PTYPE2_COUNT
 *              ACPI_PTYPE2_FIX_VAR
 *
 ******************************************************************************/

static void
ApCheckPackageList (
    const char                  *PredefinedName,
    ACPI_PARSE_OBJECT           *ParentOp,
    const ACPI_PREDEFINED_INFO  *Package,
    UINT32                      StartIndex,
    UINT32                      ParentCount)
{
    ACPI_PARSE_OBJECT           *SubPackageOp = ParentOp;
    ACPI_PARSE_OBJECT           *Op;
    ACPI_STATUS                 Status;
    UINT32                      Count;
    UINT32                      ExpectedCount;
    UINT32                      i;
    UINT32                      j;


    /*
     * Validate each subpackage in the parent Package
     *
     * Note: We ignore NULL package elements on the assumption that
     * they will be initialized by the BIOS or other ASL code.
     */
    for (i = 0; (i < ParentCount) && SubPackageOp; i++)
    {
        /* Each object in the list must be of type Package */

        Status = ApCheckObjectType (PredefinedName, SubPackageOp,
            ACPI_RTYPE_PACKAGE, i + StartIndex);
        if (ACPI_FAILURE (Status))
        {
            goto NextSubpackage;
        }

        /* Examine the different types of expected subpackages */

        Op = SubPackageOp->Asl.Child;

        /* First child is the package length */

        Count = (UINT32) Op->Asl.Value.Integer;
        Op = Op->Asl.Next;

        /* The subpackage must have at least one element */

        if (!Count)
        {
            ApZeroLengthPackage (PredefinedName, SubPackageOp);
            goto NextSubpackage;
        }

        /*
         * Decode the package type.
         * PTYPE2 indicates that a "package of packages" is expected for
         * this name. The various flavors of PTYPE2 indicate the number
         * and format of the subpackages.
         */
        switch (Package->RetInfo.Type)
        {
        case ACPI_PTYPE2:
        case ACPI_PTYPE2_PKG_COUNT:
        case ACPI_PTYPE2_REV_FIXED:

            /* Each subpackage has a fixed number of elements */

            ExpectedCount = Package->RetInfo.Count1 + Package->RetInfo.Count2;
            if (Count < ExpectedCount)
            {
                ApPackageTooSmall (PredefinedName, SubPackageOp,
                    Count, ExpectedCount);
                break;
            }
            if (Count > ExpectedCount)
            {
                ApPackageTooLarge (PredefinedName, SubPackageOp,
                    Count, ExpectedCount);
                break;
            }

            ApCheckPackageElements (PredefinedName, Op,
                Package->RetInfo.ObjectType1, Package->RetInfo.Count1,
                Package->RetInfo.ObjectType2, Package->RetInfo.Count2);
            break;

        case ACPI_PTYPE2_FIX_VAR:
            /*
             * Each subpackage has a fixed number of elements and an
             * optional element
             */
            ExpectedCount = Package->RetInfo.Count1 + Package->RetInfo.Count2;
            if (Count < ExpectedCount)
            {
                ApPackageTooSmall (PredefinedName, SubPackageOp,
                    Count, ExpectedCount);
                break;
            }

            ApCheckPackageElements (PredefinedName, Op,
                Package->RetInfo.ObjectType1, Package->RetInfo.Count1,
                Package->RetInfo.ObjectType2,
                Count - Package->RetInfo.Count1);
            break;

        case ACPI_PTYPE2_FIXED:

            /* Each subpackage has a fixed length */

            ExpectedCount = Package->RetInfo2.Count;
            if (Count < ExpectedCount)
            {
                ApPackageTooSmall (PredefinedName, SubPackageOp,
                    Count, ExpectedCount);
                break;
            }
            if (Count > ExpectedCount)
            {
                ApPackageTooLarge (PredefinedName, SubPackageOp,
                    Count, ExpectedCount);
                break;
            }

            /* Check each object/type combination */

            for (j = 0; j < ExpectedCount; j++)
            {
                ApCheckObjectType (PredefinedName, Op,
                    Package->RetInfo2.ObjectType[j], j);

                Op = Op->Asl.Next;
            }
            break;

        case ACPI_PTYPE2_MIN:

            /* Each subpackage has a variable but minimum length */

            ExpectedCount = Package->RetInfo.Count1;
            if (Count < ExpectedCount)
            {
                ApPackageTooSmall (PredefinedName, SubPackageOp,
                    Count, ExpectedCount);
                break;
            }

            /* Check the type of each subpackage element */

            ApCheckPackageElements (PredefinedName, Op,
                Package->RetInfo.ObjectType1, Count, 0, 0);
            break;

        case ACPI_PTYPE2_COUNT:
            /*
             * First element is the (Integer) count of elements, including
             * the count field (the ACPI name is NumElements)
             */
            Status = ApCheckObjectType (PredefinedName, Op,
                ACPI_RTYPE_INTEGER, 0);

            /* We must have an integer count from above (otherwise, use Count) */

            if (ACPI_SUCCESS (Status))
            {
                /*
                 * Make sure package is large enough for the Count and is
                 * is as large as the minimum size
                 */
                ExpectedCount = (UINT32) Op->Asl.Value.Integer;

                if (Count < ExpectedCount)
                {
                    ApPackageTooSmall (PredefinedName, SubPackageOp,
                        Count, ExpectedCount);
                    break;
                }
                else if (Count > ExpectedCount)
                {
                    ApPackageTooLarge (PredefinedName, SubPackageOp,
                        Count, ExpectedCount);
                }

                /* Some names of this type have a minimum length */

                if (Count < Package->RetInfo.Count1)
                {
                    ExpectedCount = Package->RetInfo.Count1;
                    ApPackageTooSmall (PredefinedName, SubPackageOp,
                        Count, ExpectedCount);
                    break;
                }

                Count = ExpectedCount;
            }

            /* Check the type of each subpackage element */

            Op = Op->Asl.Next;
            ApCheckPackageElements (PredefinedName, Op,
                Package->RetInfo.ObjectType1, (Count - 1), 0, 0);
            break;

        default:
            break;
        }

NextSubpackage:
        SubPackageOp = SubPackageOp->Asl.Next;
    }
}


/*******************************************************************************
 *
 * FUNCTION:    ApPackageTooSmall
 *
 * PARAMETERS:  PredefinedName      - Name of the predefined object
 *              Op                  - Current parser op
 *              Count               - Actual package element count
 *              ExpectedCount       - Expected package element count
 *
 * RETURN:      None
 *
 * DESCRIPTION: Issue error message for a package that is smaller than
 *              required.
 *
 ******************************************************************************/

static void
ApPackageTooSmall (
    const char                  *PredefinedName,
    ACPI_PARSE_OBJECT           *Op,
    UINT32                      Count,
    UINT32                      ExpectedCount)
{

    sprintf (MsgBuffer, "%s: length %u, required minimum is %u",
        PredefinedName, Count, ExpectedCount);

    AslError (ASL_ERROR, ASL_MSG_RESERVED_PACKAGE_LENGTH, Op, MsgBuffer);
}


/*******************************************************************************
 *
 * FUNCTION:    ApZeroLengthPackage
 *
 * PARAMETERS:  PredefinedName      - Name of the predefined object
 *              Op                  - Current parser op
 *
 * RETURN:      None
 *
 * DESCRIPTION: Issue error message for a zero-length package (a package that
 *              is required to have a non-zero length). Variable length
 *              packages seem to be allowed to have zero length, however.
 *              Even if not allowed, BIOS code does it.
 *
 ******************************************************************************/

static void
ApZeroLengthPackage (
    const char                  *PredefinedName,
    ACPI_PARSE_OBJECT           *Op)
{

    sprintf (MsgBuffer, "%s: length is zero", PredefinedName);

    AslError (ASL_ERROR, ASL_MSG_RESERVED_PACKAGE_LENGTH, Op, MsgBuffer);
}


/*******************************************************************************
 *
 * FUNCTION:    ApPackageTooLarge
 *
 * PARAMETERS:  PredefinedName      - Name of the predefined object
 *              Op                  - Current parser op
 *              Count               - Actual package element count
 *              ExpectedCount       - Expected package element count
 *
 * RETURN:      None
 *
 * DESCRIPTION: Issue a remark for a package that is larger than expected.
 *
 ******************************************************************************/

static void
ApPackageTooLarge (
    const char                  *PredefinedName,
    ACPI_PARSE_OBJECT           *Op,
    UINT32                      Count,
    UINT32                      ExpectedCount)
{

    sprintf (MsgBuffer, "%s: length is %u, only %u required",
        PredefinedName, Count, ExpectedCount);

    AslError (ASL_REMARK, ASL_MSG_RESERVED_PACKAGE_LENGTH, Op, MsgBuffer);
}
