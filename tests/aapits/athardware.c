/******************************************************************************
 *
 * Module Name: athardware - ACPICA Hardware Management API tests
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
#include "athardware.h"
#include "atosxfctrl.h"

#define _COMPONENT          ACPI_TOOLS
        ACPI_MODULE_NAME    ("athardware")

/*
 * ASSERTION 0000:
 */
ACPI_STATUS
AtHardwTest0000(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS/* | ACPI_NO_ACPI_ENABLE*/, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /* Legacy */
    Status = AcpiOsWritePort (0x00000001, 0x00000000, 0x00000008);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("AcpiOsWritePort(0x00000001, 0x00000000, 0x00000008) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    /* Status */
    Status = AcpiOsWritePort (0x000000b0, 0x00000000, 0x00000010);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("AcpiOsWritePort(0x000000b0, 0x00000000, 0x00000010) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

/*
 * Provide writing to relevant register
 */
    Status = AcpiEnable();
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiEnable() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0001:
 */
ACPI_STATUS
AtHardwTest0001(void)
{
    ACPI_STATUS             Status;

    NullBldTask.ErrScale |= ZERO_SMICMD_FADT;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS/* | ACPI_NO_ACPI_ENABLE*/, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /* Legacy */
    Status = AcpiOsWritePort (0x00000001, 0x00000000, 0x00000008);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("AcpiOsWritePort(0x00000001, 0x00000000, 0x00000008) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    /* Status */
    Status = AcpiOsWritePort (0x000000b0, 0x00000000, 0x00000010);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("AcpiOsWritePort(0x000000b0, 0x00000000, 0x00000010) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiEnable();
    if (Status != AE_ERROR)
    {
        AapiErrors++;
        printf ("API error: AcpiEnable() returned %s, expected AE_ERROR\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0002:
 */
ACPI_STATUS
AtHardwTest0002(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS/* | ACPI_NO_ACPI_ENABLE*/, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /* Legacy */
    Status = AcpiOsWritePort (0x00000001, 0x00000000, 0x00000008);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("AcpiOsWritePort(0x00000001, 0x00000000, 0x00000008) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    /* Status */
    Status = AcpiOsWritePort (0x000000b0, 0x00000000, 0x00000010);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("AcpiOsWritePort(0x000000b0, 0x00000000, 0x00000010) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiEnable();
    if (Status != AE_ERROR)
    {
        AapiErrors++;
        printf ("API error: AcpiEnable() returned %s, expected AE_ERROR\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0003:
 */
ACPI_STATUS
AtHardwTest0003(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(AAPITS_INITIALIZE_SS, 0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /* Legacy */
    Status = AcpiOsWritePort (0x00000001, 0x00000000, 0x00000008);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("AcpiOsWritePort(0x00000001, 0x00000000, 0x00000008) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    /* Status */
    Status = AcpiOsWritePort (0x000000b0, 0x00000000, 0x00000010);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("AcpiOsWritePort(0x000000b0, 0x00000000, 0x00000010) returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiEnable();
    if (Status != AE_NO_ACPI_TABLES)
    {
        AapiErrors++;
        printf ("API error: AcpiEnable() returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_NO_ACPI_TABLES));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0004:
 */
ACPI_STATUS
AtHardwTest0004(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

/*
 * Provide writing to relevant register
 */
    Status = AcpiDisable();
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiDisable() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0005:
 */
ACPI_STATUS
AtHardwTest0005(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiDisable();
    if (Status != AE_ERROR)
    {
        AapiErrors++;
        printf ("API error: AcpiDisable() returned %s, expected AE_ERROR\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/* Bit registers interface Ids */
static UINT32           BitRegIds[] =
{
    /* 1-bit width registers */
    ACPI_BITREG_TIMER_STATUS,
    ACPI_BITREG_BUS_MASTER_STATUS,
    ACPI_BITREG_GLOBAL_LOCK_STATUS,
    ACPI_BITREG_POWER_BUTTON_STATUS,
    ACPI_BITREG_SLEEP_BUTTON_STATUS,
    ACPI_BITREG_RT_CLOCK_STATUS,
    ACPI_BITREG_WAKE_STATUS,
    ACPI_BITREG_PCIEXP_WAKE_STATUS,
    ACPI_BITREG_TIMER_ENABLE,
    ACPI_BITREG_GLOBAL_LOCK_ENABLE,
    ACPI_BITREG_POWER_BUTTON_ENABLE,
    ACPI_BITREG_SLEEP_BUTTON_ENABLE,
    ACPI_BITREG_RT_CLOCK_ENABLE,
    ACPI_BITREG_PCIEXP_WAKE_DISABLE,
    ACPI_BITREG_SCI_ENABLE,
    ACPI_BITREG_BUS_MASTER_RLD,
    ACPI_BITREG_GLOBAL_LOCK_RELEASE,
    ACPI_BITREG_SLEEP_ENABLE,
    ACPI_BITREG_ARB_DISABLE,
    /* 3-bit width registers */
    ACPI_BITREG_SLEEP_TYPE,
    ACPI_BITREG_SLEEP_TYPE,
};

/* Bit registers position */
static UINT32           BitRegPos[] =
{
    0x00 /* ACPI_BITREG_TIMER_STATUS */,
    0x04 /* ACPI_BITREG_BUS_MASTER_STATUS */,
    0x05 /* ACPI_BITREG_GLOBAL_LOCK_STATUS */,
    0x08 /* ACPI_BITREG_POWER_BUTTON_STATUS */,
    0x09 /* ACPI_BITREG_SLEEP_BUTTON_STATUS */,
    0x0A /* ACPI_BITREG_RT_CLOCK_STATUS */,
    0x0F /* ACPI_BITREG_WAKE_STATUS */,
    0x0E /* ACPI_BITREG_PCIEXP_WAKE_STATUS */,
    0x00 /* ACPI_BITREG_TIMER_ENABLE */,
    0x05 /* ACPI_BITREG_GLOBAL_LOCK_ENABLE */,
    0x08 /* ACPI_BITREG_POWER_BUTTON_ENABLE */,
    0x09 /* ACPI_BITREG_SLEEP_BUTTON_ENABLE */,
    0x0A /* ACPI_BITREG_RT_CLOCK_ENABLE */,
    0x0E /* ACPI_BITREG_PCIEXP_WAKE_DISABLE */,
    0x00 /* ACPI_BITREG_SCI_ENABLE */,
    0x01 /* ACPI_BITREG_BUS_MASTER_RLD */,
    0x02 /* ACPI_BITREG_GLOBAL_LOCK_RELEASE */,
    0x0D /* ACPI_BITREG_SLEEP_ENABLE */,
    0x00 /* ACPI_BITREG_ARB_DISABLE */,
    0x0A /* ACPI_BITREG_SLEEP_TYPE */,
};

static UINT32           StatusRegIds[] =
{
    ACPI_BITREG_TIMER_STATUS,
    ACPI_BITREG_BUS_MASTER_STATUS,
    ACPI_BITREG_GLOBAL_LOCK_STATUS,
    ACPI_BITREG_POWER_BUTTON_STATUS,
    ACPI_BITREG_SLEEP_BUTTON_STATUS,
    ACPI_BITREG_RT_CLOCK_STATUS,
    ACPI_BITREG_WAKE_STATUS,
    ACPI_BITREG_PCIEXP_WAKE_STATUS,
};

static UINT32           EnableRegIds[] =
{
    ACPI_BITREG_TIMER_ENABLE,
    ACPI_BITREG_GLOBAL_LOCK_ENABLE,
    ACPI_BITREG_POWER_BUTTON_ENABLE,
    ACPI_BITREG_SLEEP_BUTTON_ENABLE,
    ACPI_BITREG_RT_CLOCK_ENABLE,
    ACPI_BITREG_PCIEXP_WAKE_DISABLE,
};

static UINT32           ControlRegIds[] =
{
    ACPI_BITREG_SCI_ENABLE,
    ACPI_BITREG_BUS_MASTER_RLD,
    ACPI_BITREG_GLOBAL_LOCK_RELEASE,
    ACPI_BITREG_SLEEP_TYPE,
    ACPI_BITREG_SLEEP_ENABLE,
};

static UINT32           Control2RegIds[] =
{
    ACPI_BITREG_ARB_DISABLE,
};

#define IS3BITREG(BitRegId) (BitRegId == ACPI_BITREG_SLEEP_TYPE)
#define ISWRITE_ONLYBITREG(BitRegId) \
            ((BitRegId == ACPI_BITREG_GLOBAL_LOCK_RELEASE) || \
             (BitRegId == ACPI_BITREG_SLEEP_ENABLE))

UINT32
IsBitRegOfType(UINT32 RegisterId, UINT32 RegIds[], UINT32 NumIds)
{
    UINT32                  Ret = 0;
    UINT32                  i;

    for (i = 0; i < NumIds; i++)
    {
        if (RegIds[i] == RegisterId)
        {
            Ret = 1;
            break;
        }
    }
    return (Ret);
}

UINT32
IsStatusRegister(UINT32 RegisterId)
{
    return (IsBitRegOfType(RegisterId, StatusRegIds,
        sizeof (StatusRegIds) / sizeof (UINT32)));
}

UINT32
IsEnableRegister(UINT32 RegisterId)
{
    return (IsBitRegOfType(RegisterId, EnableRegIds,
        sizeof (EnableRegIds) / sizeof (UINT32)));
}

UINT32
IsControlRegister(UINT32 RegisterId)
{
    return (IsBitRegOfType(RegisterId, ControlRegIds,
        sizeof (ControlRegIds) / sizeof (UINT32)));
}

UINT32
IsControl2Register(UINT32 RegisterId)
{
    return (IsBitRegOfType(RegisterId, Control2RegIds,
        sizeof (Control2RegIds) / sizeof (UINT32)));
}

UINT32
IsBitDefinedRegister(UINT32 RegisterId)
{
    return (IsBitRegOfType(RegisterId, BitRegIds,
        sizeof (BitRegIds) / sizeof (UINT32)));
}

AT_FIXED_REG_NUM
GetRegNum(UINT32 RegisterId)
{
    if (IsStatusRegister(RegisterId))
    {
        return (AtPm1aStatus);
    }
    else if (IsEnableRegister(RegisterId))
    {
        return (AtPm1aEnable);
    }
    else if (IsControlRegister(RegisterId))
    {
        return (AtPm1aControl);
    }
    else if (IsControl2Register(RegisterId))
    {
        return (AtPm2Control);
    }
    else
    {
        return (AtFixeReg_All);
    }
}

/*
 * ASSERTION 0006:
 */
ACPI_STATUS
AtHardwTest0006(void)
{
    ACPI_STATUS             Status;
    UINT32                  RegisterId;
    AT_FIXED_REG_NUM        RegNum;
    UINT32                  ReturnValue;
    UINT32                  NormValue;
    UINT32                  SetValue;
    UINT32                  i;

    Status = AtSubsystemInit(AAPITS_INI_LOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < sizeof (BitRegIds) / sizeof (UINT32); i++)
    {
        RegisterId = BitRegIds[i];

        Status = OsxfCtrlClearFixedRegs();
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error %d: OsxfCtrlClearFixedRegs() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        /* Check cleared BitReg */

        Status = AcpiReadBitRegister(RegisterId, &ReturnValue);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error %d: AcpiGetRegister(%d) returned %s\n",
                i, RegisterId, AcpiFormatException(Status));
            return (Status);
        }

        if (ReturnValue != 0x0)
        {
            AapiErrors++;
            printf ("API error %d: AcpiGetRegister(%d) extracted  0x%x"
                ", expected 0x0\n",
                i, RegisterId, ReturnValue);
            return (AE_ERROR);
        }

        /* Set BitReg to 1 */

        NormValue = (IS3BITREG(RegisterId))? 0x07: 0x01;

        RegNum = GetRegNum(RegisterId);
        SetValue = NormValue << BitRegPos[i];
        Status = OsxfCtrlSetFixedReg(RegNum, SetValue);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error %d: OsxfCtrlSetFixedReg() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        /* Check BitReg to be set */

        Status = AcpiReadBitRegister(RegisterId, &ReturnValue);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error %d: AcpiGetRegister(%d) returned %s\n",
                i, RegisterId, AcpiFormatException(Status));
            return (Status);
        }

        if (!AT_SKIP_WRITE_ONLY_BITS_CHECK &&
            ISWRITE_ONLYBITREG(RegisterId))
        {
            NormValue = 0x00;
        }

        if (ReturnValue != NormValue)
        {
            AapiErrors++;
            printf ("API error %d: AcpiGetRegister(%d) extracted 0x%x"
                ", expected 0x%x\n",
                i, RegisterId, ReturnValue, NormValue);
            return (AE_ERROR);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}


/*
 * ASSERTION 0007:
 */
ACPI_STATUS
AtHardwTest0007(void)
{
    ACPI_STATUS             Status;
    UINT32                  ReturnValue;
    UINT32                  i;
    UINT32                  MaxId = 65;
    UINT32                  CheckLimit = 3;
    UINT32                  CheckCount = 0;

    Status = AtSubsystemInit(AAPITS_INI_LOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < MaxId; i++)
    {
#if OBSOLETE_CODE
#if !AT_BITREG_WAKE_ENABLE_CHECK
        if (i == ACPI_BITREG_WAKE_ENABLE)
        {
            continue;
        }
#endif
#endif

        if (IsBitDefinedRegister(i))
        {
            continue;
        }

        Status = AcpiReadBitRegister(i, &ReturnValue);
        if (Status != AE_BAD_PARAMETER)
        {
            AapiErrors++;
            printf ("API error: AcpiGetRegister(%d) returned %s, expected %s\n",
                i, AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
            return (Status);
        }
        CheckCount++;
    }

    if (CheckCount < CheckLimit)
    {
        TestErrors++;
        printf ("Test error: number of checks less then expected(%d) limit %u\n",
            CheckCount, CheckLimit);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

static UINT32           BitDefinedRegMasks[AtFixeReg_All] =
{
    0xC731,
    0x0000,
    0x4721,
    0x0000,
    0x3C07,
    0x0000,
    0x0001,
    0x0000,
    0x0000,
};

/*
 * ASSERTION 0008:
 */
ACPI_STATUS
AtHardwTest0008(void)
{
    ACPI_STATUS             Status;
    UINT32                  RegisterId;
    AT_FIXED_REG_NUM        RegNum;
    UINT32                  NormValue;
    UINT32                  IniValue;
    UINT32                  SetValue;
    UINT32                  BitDefinedRegMask;
    UINT32                  i;

    Status = AtSubsystemInit(AAPITS_INI_LOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < sizeof (BitRegIds) / sizeof (UINT32); i++)
    {
        RegisterId = BitRegIds[i];

        Status = OsxfCtrlClearFixedRegs();
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error %d: OsxfCtrlClearFixedRegs() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        RegNum = GetRegNum(RegisterId);
        BitDefinedRegMask = BitDefinedRegMasks[RegNum];

        Status = OsxfCtrlSetFixedRegOnes(RegNum);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error %d: OsxfCtrlSetFixedRegOnes() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }
        (void)OsxfCtrlGetFixedReg(RegNum, &IniValue);

        /* Check setting BitReg to 0 */

        Status = AcpiWriteBitRegister(RegisterId, 0);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error %d: AcpiSetRegister() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        NormValue = (IS3BITREG(RegisterId))? 0x07: 0x01;

        if (IsStatusRegister(RegisterId))
        {
            /* No sense to set a Status bit to 0*/
            NormValue = 0;
        }
        if (RegisterId == ACPI_BITREG_SCI_ENABLE)
        {
            /* "OSPM always preserves this bit position" */
            NormValue = 0;
        }

        Status = OsxfCtrlGetFixedReg(RegNum, &SetValue);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error %d: OsxfCtrlSetFixedReg() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        /* Check cleared bits */
        if ((BitDefinedRegMask & SetValue) !=
            (BitDefinedRegMask & (IniValue & ~(NormValue << BitRegPos[i]))))
        {
            AapiErrors++;
            printf ("API error %d: AcpiSetRegister(0) results in 0x%x,"
                " expected 0x%x\n",
                i, SetValue, IniValue & ~(NormValue << BitRegPos[i]));
            return (Status);
        }

        /* Check reserved and ignored bits */
        if (!AT_SKIP_STATUS_REG_RESBIT_CHECK &&
            IsStatusRegister(RegisterId))
        {
            /* Preserved by writing as zeros (and they remain the same) */
            if ((~BitDefinedRegMask & SetValue) !=
                (~BitDefinedRegMask & (IniValue & ~(NormValue << BitRegPos[i]))))
            {
                AapiErrors++;
                printf ("API error %d: undefined bits of Status Register results in 0x%x,"
                    " expected 0x%x\n",
                    i, ~BitDefinedRegMask & SetValue,
                    ~BitDefinedRegMask & (IniValue & ~(NormValue << BitRegPos[i])));
                return (Status);
            }
        }
        else if (!AT_SKIP_ENABLE_REG_RESBIT_CHECK &&
            IsEnableRegister(RegisterId))
        {
            /* Preserved by writing as zeros */
            if ((~BitDefinedRegMask & SetValue) != 0)
            {
                AapiErrors++;
                printf ("API error %d: undefined bits of Enable Register results in 0x%x,"
                    " expected 0x%x\n",
                    i, ~BitDefinedRegMask & SetValue, 0);
                return (Status);
            }
        }
        else if (IsControlRegister(RegisterId))
        {
            /* Preserved by writing back read values */
            if ((~BitDefinedRegMask & SetValue) !=
                (~BitDefinedRegMask & (IniValue & ~(NormValue << BitRegPos[i]))))
            {
                AapiErrors++;
                printf ("API error %d: undefined bits of Control Register results in 0x%x,"
                    " expected 0x%x\n",
                    i, ~BitDefinedRegMask & SetValue,
                    ~BitDefinedRegMask & (IniValue & ~(NormValue << BitRegPos[i])));
                return (Status);
            }
        }

        /* Prepare to setting BitReg to 1 */

        Status = OsxfCtrlSetFixedReg(RegNum, 0);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error %d: OsxfCtrlSetFixedRegOnes() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }
        (void)OsxfCtrlGetFixedReg(RegNum, &IniValue);

        /* Check setting BitReg to 1 */

        NormValue = (IS3BITREG(RegisterId))? 0x07: 0x01;

        Status = AcpiWriteBitRegister(RegisterId, NormValue);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error %d: AcpiSetRegister(1) returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        if (IsStatusRegister(RegisterId))
        {
            /* Zero Status bits remain the same */
            NormValue = 0;
        }
        if (RegisterId == ACPI_BITREG_SCI_ENABLE)
        {
            /* "OSPM always preserves this bit position" */
            NormValue = 0;
        }

        Status = OsxfCtrlGetFixedReg(RegNum, &SetValue);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error %d: OsxfCtrlSetFixedReg() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        /* Check set bits */
        if ((BitDefinedRegMask & SetValue) !=
            (BitDefinedRegMask & (IniValue | (NormValue << BitRegPos[i]))))
        {
            AapiErrors++;
            printf ("API error %d: AcpiSetRegister(1) results in 0x%x,"
                " expected 0x%x\n",
                i, SetValue, IniValue | (NormValue << BitRegPos[i]));
            return (Status);
        }

        /* Check reserved and ignored bits */
        if (!AT_SKIP_STATUS_REG_RESBIT_CHECK &&
            IsStatusRegister(RegisterId))
        {
            /* Preserved by writing as zeros (and they remain the same) */
            if ((~BitDefinedRegMask & SetValue) !=
                (~BitDefinedRegMask & (IniValue & ~(NormValue << BitRegPos[i]))))
            {
                AapiErrors++;
                printf ("API error %d: undefined bits of Status Register results in 0x%x,"
                    " expected 0x%x\n",
                    i, ~BitDefinedRegMask & SetValue,
                    ~BitDefinedRegMask & (IniValue & ~(NormValue << BitRegPos[i])));
                return (Status);
            }
        }
        else if (!AT_SKIP_ENABLE_REG_RESBIT_CHECK &&
            IsEnableRegister(RegisterId))
        {
            /* Preserved by writing as zeros */
            if ((~BitDefinedRegMask & SetValue) != 0)
            {
                AapiErrors++;
                printf ("API error %d: undefined bits of Enable Register results in 0x%x,"
                    " expected 0x%x\n",
                    i, ~BitDefinedRegMask & SetValue, 0);
                return (Status);
            }
        }
        else if (IsControlRegister(RegisterId))
        {
            /* Preserved by writing back read values */
            if ((~BitDefinedRegMask & SetValue) !=
                (~BitDefinedRegMask & (IniValue & ~(NormValue << BitRegPos[i]))))
            {
                AapiErrors++;
                printf ("API error %d: undefined bits of Control Register results in 0x%x,"
                    " expected 0x%x\n",
                    i, ~BitDefinedRegMask & SetValue,
                    ~BitDefinedRegMask & (IniValue & ~(NormValue << BitRegPos[i])));
                return (Status);
            }
        }

        /* Prepare to setting Status BitReg to 1, when the others are Ones */

        if (!IsStatusRegister(RegisterId))
        {
            continue;
        }

        Status = OsxfCtrlSetFixedRegOnes(RegNum);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error %d: OsxfCtrlSetFixedRegOnes() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }
        (void)OsxfCtrlGetFixedReg(RegNum, &IniValue);

        Status = AcpiWriteBitRegister(RegisterId, 1);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error %d: AcpiSetRegister(1) returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        Status = OsxfCtrlGetFixedReg(RegNum, &SetValue);
        if (ACPI_FAILURE(Status))
        {
            TestErrors++;
            printf ("Test error %d: OsxfCtrlSetFixedReg() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }

        /* Check set bits */
        if ((BitDefinedRegMask & SetValue) !=
            (BitDefinedRegMask & (IniValue & ~(1 << BitRegPos[i]))))
        {
            AapiErrors++;
            printf ("API error %d: AcpiSetRegister(1) results in 0x%x,"
                " expected 0x%x\n",
                i, SetValue, IniValue & ~(1 << BitRegPos[i]));
            return (Status);
        }

        /* Check reserved and ignored bits*/
        /* Preserved by writing as zeros (and they remain the same) */
        if (!AT_SKIP_STATUS_REG_RESBIT_CHECK &&
            ((~BitDefinedRegMask & SetValue) !=
             (~BitDefinedRegMask & (IniValue & ~(NormValue << BitRegPos[i])))))
        {
            AapiErrors++;
            printf ("API error %d: undefined bits of Status Register results in 0x%x,"
                " expected 0x%x\n",
                i, ~BitDefinedRegMask & SetValue,
                ~BitDefinedRegMask & (IniValue & ~(NormValue << BitRegPos[i])));
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}


/*
 * ASSERTION 0009:
 */
ACPI_STATUS
AtHardwTest0009(void)
{
    ACPI_STATUS             Status;
    UINT32                  Value = 0;
    UINT32                  i;
    UINT32                  MaxId = 33;
    UINT32                  CheckLimit = 3;
    UINT32                  CheckCount = 0;

    Status = AtSubsystemInit(AAPITS_INI_LOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < MaxId; i++)
    {
#if OBSOLETE_CODE
#if !AT_BITREG_WAKE_ENABLE_CHECK
        if (i == ACPI_BITREG_WAKE_ENABLE)
        {
            continue;
        }
#endif
#endif
        if (IsBitDefinedRegister(i))
        {
            continue;
        }

        Status = AcpiWriteBitRegister(i, Value);
        if (Status != AE_BAD_PARAMETER)
        {
            AapiErrors++;
            printf ("API error: AcpiSetRegister(%d) returned %s, expected %s\n",
                i, AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
            return (Status);
        }
        CheckCount++;
    }

    if (CheckCount < CheckLimit)
    {
        TestErrors++;
        printf ("Test error: number of checks less then expected(%d) limit %u\n",
            CheckCount, CheckLimit);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0010:
 */
ACPI_STATUS
AtHardwTest0010(void)
{
    ACPI_STATUS             Status;
    ACPI_PHYSICAL_ADDRESS   PhysicalAddress =
#if ACPI_MACHINE_WIDTH == 64
        ((UINT64)0x51525354 << 32) |
#endif
        0x55565758;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiSetFirmwareWakingVector(PhysicalAddress);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiSetFirmwareWakingVector() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0011:
 */
ACPI_STATUS
AtHardwTest0011(void)
{
    ACPI_STATUS             Status;
    ACPI_PHYSICAL_ADDRESS   PhysicalAddress =
#if ACPI_MACHINE_WIDTH == 64
        ((UINT64)0x51525354 << 32) |
#endif
        0x55565758;

    ACPI_TABLE_HEADER       UserTableStructure, *UserTable = &UserTableStructure;
    BLD_TABLES_TASK         BldTask = {BLD_NO_FACS, 0};

    memset(&UserTableStructure, 0, sizeof (ACPI_TABLE_HEADER));

    AtBuildLocalTables(UserTable, BldTask);

    Status = AtSubsystemInit(AAPITS_INITIALIZE_SS,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AtInitializeTables(FALSE);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiInitializeTables() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiSetFirmwareWakingVector(PhysicalAddress);
    if (Status != AE_NO_ACPI_TABLES)
    {
        AapiErrors++;
        printf ("API error: AcpiSetFirmwareWakingVector() returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_NO_ACPI_TABLES));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0012:
 */
ACPI_STATUS
AtHardwTest0012(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

#if OBSOLETE_CODE
    ACPI_PHYSICAL_ADDRESS   OutVector;

    Status = AcpiGetFirmwareWakingVector(&OutVector);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiGetFirmwareWakingVector() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }
#endif

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0013:
 */
ACPI_STATUS
AtHardwTest0013(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(AAPITS_INITIALIZE_SS,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

#if OBSOLETE_CODE

    ACPI_PHYSICAL_ADDRESS   OutVector;
    Status = AcpiGetFirmwareWakingVector(&OutVector);
    if (Status != AE_NO_ACPI_TABLES)
    {
        AapiErrors++;
        printf ("API error: AcpiGetFirmwareWakingVector() returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_NO_ACPI_TABLES));
        return (Status);
    }
#endif

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0014:
 */
ACPI_STATUS
AtHardwTest0014(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(AAPITS_INITIALIZE_SS,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

#if OBSOLETE_CODE
    Status = AcpiGetFirmwareWakingVector(NULL);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("API error: AcpiGetFirmwareWakingVector() returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
        return (Status);
    }
#endif

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0015:
 */
ACPI_STATUS
AtHardwTest0015(void)
{
    ACPI_STATUS             Status;
    UINT8                   SleepState;
    UINT8                   SleepTypeA;
    UINT8                   SleepTypeB;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hdwr0015.aml")))
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

    for (SleepState = 0; SleepState < 6; SleepState++)
    {
        Status = AcpiGetSleepTypeData(SleepState, &SleepTypeA, &SleepTypeB);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiGetSleepTypeData(%d) returned %s\n",
                SleepState, AcpiFormatException(Status));
            return (Status);
        }

        if (SleepTypeA != SleepState)
        {
            AapiErrors++;
            printf ("API error: SleepState %d, incorrect SleepTypeA 0x%x"
                " from AcpiGetSleepTypeData(), expected 0x%x\n",
                (UINT8)SleepState, (UINT8)SleepTypeA, (UINT8)SleepState);
            return (AE_ERROR);
        }

        if (SleepTypeB != SleepState + 0x10)
        {
            AapiErrors++;
            printf ("API error: SleepState %d, incorrect SleepTypeB 0x%x"
                " from AcpiGetSleepTypeData(), expected 0x%x\n",
                (UINT8)SleepState, (UINT8)SleepTypeA, (UINT8)SleepState + 0x10);
            return (AE_ERROR);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0016:
 */
ACPI_STATUS
AtHardwTest0016(void)
{
    ACPI_STATUS             Status;
    UINT8                   SleepState;
    UINT8                   SleepTypeA;
    UINT8                   SleepTypeB;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hdwr0015.aml")))
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

    for (SleepState = 6; SleepState < 10; SleepState++)
    {
        Status = AcpiGetSleepTypeData(SleepState, &SleepTypeA, &SleepTypeB);
        if (Status != AE_BAD_PARAMETER)
        {
            AapiErrors++;
            printf ("API error: AcpiGetSleepTypeData(%d) returned %s, expected %s\n",
                SleepState,
                AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0017:
 */
ACPI_STATUS
AtHardwTest0017(void)
{
    ACPI_STATUS             Status;
    UINT8                   SleepState = 0;
    UINT8                   SleepTypeA;
    UINT8                   SleepTypeB;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hdwr0015.aml")))
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

    Status = AcpiGetSleepTypeData(SleepState, NULL, &SleepTypeB);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("API error: AcpiGetSleepTypeData(NULL, B) returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
        return (Status);
    }

    Status = AcpiGetSleepTypeData(SleepState, NULL, NULL);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("API error: AcpiGetSleepTypeData(NULL, NULL) returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
        return (Status);
    }

    Status = AcpiGetSleepTypeData(SleepState, &SleepTypeA, NULL);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("API error: AcpiGetSleepTypeData(A, NULL) returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0018:
 */
ACPI_STATUS
AtHardwTest0018(void)
{
    ACPI_STATUS             Status;
    UINT8                   SleepState;
    UINT8                   SleepTypeA;
    UINT8                   SleepTypeB;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hdwr0018.aml")))
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

    for (SleepState = 0; SleepState < 6; SleepState++)
    {
        Status = AcpiGetSleepTypeData(SleepState, &SleepTypeA, &SleepTypeB);
        if (Status != AE_AML_NO_OPERAND)
        {
            AapiErrors++;
            printf ("API error: AcpiGetSleepTypeData(%d) returned %s, expected %s\n",
                SleepState,
                AcpiFormatException(Status), AcpiFormatException(AE_AML_NO_OPERAND));
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0019:
 */
ACPI_STATUS
AtHardwTest0019(void)
{
    ACPI_STATUS             Status;
    UINT8                   SleepState;
    UINT8                   SleepTypeA;
    UINT8                   SleepTypeB;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hdwr0019.aml")))
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

    for (SleepState = 0; SleepState < 6; SleepState++)
    {
        Status = AcpiGetSleepTypeData(SleepState, &SleepTypeA, &SleepTypeB);
        if (Status != AE_AML_OPERAND_TYPE)
        {
            AapiErrors++;
            printf ("API error: AcpiGetSleepTypeData(%d) returned %s, expected %s\n",
                SleepState,
                AcpiFormatException(Status), AcpiFormatException(AE_AML_OPERAND_TYPE));
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0020:
 */
ACPI_STATUS
AtHardwTest0020(void)
{
    ACPI_STATUS             Status;
    UINT8                   SleepState;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hdwr0020.aml")))
    {
        return (Status);
    }

    for (SleepState = 1; SleepState < 6; SleepState++)
    {
        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\PTSA", 0)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\GTSA", 0)))
        {
            return (Status);
        }

        Status = AcpiEnterSleepStatePrep(SleepState);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiEnterSleepStatePrep(%d) returned %s\n",
                SleepState, AcpiFormatException(Status));
            return (Status);
        }

        /* Ensure that _PTS has been executed */
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\PTSA", SleepState)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\GTSA", SleepState)))
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

void ACPI_SYSTEM_XFACE
AtEmulateWakingStatus(void * Context)
{
    ACPI_STATUS             Status;
    UINT32                  RegisterId = ACPI_BITREG_WAKE_STATUS;
    AT_FIXED_REG_NUM        RegNum;
    UINT32                  IniValue;
    UINT32                  SetValue;

    AcpiOsSleep(1000); /* 1 second */

    RegNum = GetRegNum(RegisterId);
    (void)OsxfCtrlGetFixedReg(RegNum, &IniValue);
    SetValue = IniValue | (1 << BitRegPos[RegisterId]);
    Status = OsxfCtrlSetFixedReg(RegNum, SetValue);
    if (ACPI_FAILURE(Status))
    {
        TestErrors++;
        printf ("Test error (AtEmulateWakingStatus): OsxfCtrlSetFixedReg()"
            " returned %s\n",
            AcpiFormatException(Status));
    }
}


/*
 * ASSERTION 0021:
 */
ACPI_STATUS
AtHardwTest0021(void)
{
    ACPI_STATUS             Status;
    UINT8                   SleepState;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hdwr0020.aml")))
    {
        return (Status);
    }

    for (SleepState = 1; SleepState < 6; SleepState++)
    {
        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        /* Set up waking condition */
        Status = AcpiOsExecute(OSL_GPE_HANDLER,
                    AtEmulateWakingStatus, NULL);
        if (ACPI_FAILURE (Status))
        {
            printf ("API error: AcpiOsExecute() returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiEnterSleepState(SleepState);

        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiEnterSleepState(%d) returned %s\n",
                SleepState, AcpiFormatException(Status));
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
 * ASSERTION 0022:
 */
ACPI_STATUS
AtHardwTest0022(void)
{
    ACPI_STATUS             Status;
    UINT8                   SleepState;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hdwr0022.aml")))
    {
        return (Status);
    }

    for (SleepState = 1; SleepState < 6; SleepState++)
    {
        Status = AtSubsystemInit(
            AAPITS_INI_DEF,
            AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
        if (ACPI_FAILURE(Status))
        {
            return (Status);
        }

        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\ORDR", 0)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\SST0", 0)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\SSA0", 0)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\SSO0", 0)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\SSA1", 0)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\SSO1", 0)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\BFS0", 0)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\BFSA", 0)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\BFSO", 0)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\WAK0", 0)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\WAKA", 0)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\WAKO", 0)))
        {
            return (Status);
        }

        Status = AcpiLeaveSleepState(SleepState);

        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiLeaveSleepState(%d) returned %s\n",
                SleepState, AcpiFormatException(Status));
            return (Status);
        }

        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\ORDR", 4)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\SST0", 2)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\SSA0", 2))) /* Waking */
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\SSO0", 1)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\SSA1", 1))) /* Working */
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\SSO1", 4)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\BFS0", 1)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\BFSA", SleepState)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\BFSO", 2)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\WAK0", 1)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\WAKA", SleepState)))
        {
            return (Status);
        }
        if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\WAKO", 3)))
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

static ACPI_TABLE_FACS      *AtFacs = NULL;

/*
 * ASSERTION 0023:
 */
ACPI_STATUS
AtHardwTest0023(void)
{
    ACPI_STATUS             Status;
    UINT32                  Handle;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetTable (ACPI_SIG_FACS, 0, (ACPI_TABLE_HEADER **) &AtFacs);
    if (ACPI_FAILURE (Status))
    {
        AapiErrors++;
        printf ("API error: AcpiGetTable() returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    /* Simulate GlobalLock is not acquired */
    AtFacs->GlobalLock = 0;

    Status = AcpiAcquireGlobalLock(0, &Handle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiAcquireGlobalLock() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0024:
 */
ACPI_STATUS
AtHardwTest0024(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(AAPITS_INITIALIZE_SS, 0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiAcquireGlobalLock(0, NULL);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("API error: AcpiAcquireGlobalLock(0, NULL) returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0025:
 */

/*
 * Acquire GlobalLock concurrently
 */
void ACPI_SYSTEM_XFACE
AtConcurrentHoldGlobalLock(void * Context)
{
    ACPI_STATUS             Status;
    UINT32                  Handle;
    UINT32                  *Flag = (UINT32 *)Context;

    Status = AcpiAcquireGlobalLock(0, &Handle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiAcquireGlobalLock() returned %s\n",
            AcpiFormatException(Status));
        goto ErrorExit;
    }

    AcpiOsSleep(2000); /* 2 second */

    Status = AcpiReleaseGlobalLock(Handle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiReleaseGlobalLock() returned %s\n",
            AcpiFormatException(Status));
        goto ErrorExit;
    }

    *Flag = 1;

ErrorExit:
    return;
}

static ACPI_STATUS
AtActions0025(void)
{
    ACPI_STATUS             Status;
    UINT32                  Handle, Handle2;
    UINT32                  ConcurrentFlag = 0;
    UINT32                  i;

    /* Run GlobalLock concurrent acquiring */
    Status = AcpiOsExecute(OSL_GPE_HANDLER,
        AtConcurrentHoldGlobalLock, &ConcurrentFlag);
    if (ACPI_FAILURE (Status))
    {
        printf ("API error: AcpiOsExecute() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    AcpiOsSleep(1000); /* 1 second */

    for (i = 0; i < 3; i++) {
        Status = AcpiAcquireGlobalLock((UINT16)(i * 100), &Handle2);
        if (Status != AE_TIME)
        {
            AapiErrors++;
            printf ("API error: case %d AcpiAcquireGlobalLock() returned %s,"
                " expected AE_TIME\n",
                i, AcpiFormatException(Status));
            return (Status);
        }
    }

    AcpiOsSleep(2000); /* 2 second */

    if (!ConcurrentFlag)
    {
        TestErrors++;
        printf ("Test error: ConcurrentFlag has not been fired\n");
        return (AE_ERROR);
    }

    /* Try to acquire GlobalLock repeatedly */

    Status = AcpiAcquireGlobalLock(0xFFFF, &Handle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiAcquireGlobalLock() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    for (i = 0; i < 3; i++) {
        Status = AcpiAcquireGlobalLock((UINT16)(i * 100), &Handle2);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: case %d AcpiAcquireGlobalLock() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }
        if (Handle2 != Handle)
        {
            AapiErrors++;
            printf ("API error: case %d repeated AcpiAcquireGlobalLock()"
                " returned %d Handle, not the original %d\n",
                i, Handle2, Handle);
            return (Status);
        }
    }

    for (i = 0; i < 4; i++) {
        Status = AcpiReleaseGlobalLock(Handle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: case %d AcpiReleaseGlobalLock() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }
    }

    return (Status);
}

ACPI_STATUS
AtHardwTest0025(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    Status = AtSubsystemInit(AAPITS_INITIALIZE_SS, 0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetTable (ACPI_SIG_FACS, 0, (ACPI_TABLE_HEADER **) &AtFacs);
    if (!ACPI_FAILURE (Status))
    {
        AapiErrors++;
        printf ("API error: AcpiGetTable() returned SUCCESS\n");
        return (AE_ERROR);
    }

    for (i = 0; i < 3; i++) {
        Status = AtActions0025();
        if (ACPI_FAILURE (Status))
        {
            AapiErrors++;
            printf ("API error: case %d AtActions0025() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0026:
 */
ACPI_STATUS
AtHardwTest0026(void)
{
    ACPI_STATUS             Status;
    UINT32                  Handle;

    Status = AtSubsystemInit(AAPITS_INITABLES, 0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetTable (ACPI_SIG_FACS, 0, (ACPI_TABLE_HEADER **) &AtFacs);
    if (ACPI_FAILURE (Status))
    {
        AapiErrors++;
        printf ("API error: AcpiGetTable() returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    /* Simulate GlobalLock is not acquired */
    AtFacs->GlobalLock = 0;

    Status = AcpiAcquireGlobalLock(0, &Handle);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("API error: AcpiAcquireGlobalLock returned %s,"
            " expected AE_BAD_PARAMETER\n",
            AcpiFormatException(Status));
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0027:
 */
ACPI_STATUS
AtHardwTest0027(void)
{
    ACPI_STATUS             Status;
    UINT32                  Handle;
    UINT32                  i;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetTable (ACPI_SIG_FACS, 0, (ACPI_TABLE_HEADER **) &AtFacs);
    if (ACPI_FAILURE (Status))
    {
        AapiErrors++;
        printf ("API error: AcpiGetTable() returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    /* Simulate GlobalLock is not acquired */
    AtFacs->GlobalLock = 0;

    for (i = 0; i < 3; i++)
    {
        Status = AcpiAcquireGlobalLock(0, &Handle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiAcquireGlobalLock() returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiReleaseGlobalLock(Handle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiReleaseGlobalLock() returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0028:
 */
ACPI_STATUS
AtHardwTest0028(void)
{
    ACPI_STATUS             Status;
    UINT32                  Handle = 0, Handle0 = 0;
    UINT32                  i;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetTable (ACPI_SIG_FACS, 0, (ACPI_TABLE_HEADER **) &AtFacs);
    if (ACPI_FAILURE (Status))
    {
        AapiErrors++;
        printf ("API error: AcpiGetTable() returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    /* Simulate GlobalLock is not acquired */
    AtFacs->GlobalLock = 0;

    Status = AcpiReleaseGlobalLock(Handle);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("API error: AcpiReleaseGlobalLock(0) returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
        return (AE_ERROR);
    }

    Handle = 1;
    Status = AcpiReleaseGlobalLock(Handle);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("API error: AcpiReleaseGlobalLock(1) returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
        return (AE_ERROR);
    }

    Handle = (UINT32)-1;
    Status = AcpiReleaseGlobalLock(Handle);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("API error: AcpiReleaseGlobalLock(-1) returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
        return (AE_ERROR);
    }

    for (i = 0; i < 2; i++)
    {
        Status = AcpiAcquireGlobalLock(0, &Handle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiAcquireGlobalLock() returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        if (i == 0)
        {
            /* Save the first Handle */
            Handle0 = Handle;
        } else {
            /* Try the first Handle to release in the second time */
            Status = AcpiReleaseGlobalLock(Handle0);
            if (Status != AE_BAD_PARAMETER)
            {
                AapiErrors++;
                printf ("API error: AcpiReleaseGlobalLock returned %s,"
                    " expected AE_BAD_PARAMETER\n",
                    AcpiFormatException(Status));
                return (Status);
            }
        }

        Status = AcpiReleaseGlobalLock(Handle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiReleaseGlobalLock() returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0029:
 */
ACPI_STATUS
AtHardwTest0029(void)
{
    ACPI_STATUS             Status;
    UINT32                  Handle;
    UINT32                  i;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetTable (ACPI_SIG_FACS, 0, (ACPI_TABLE_HEADER **) &AtFacs);
    if (ACPI_FAILURE (Status))
    {
        AapiErrors++;
        printf ("API error: AcpiGetTable() returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    /* Simulate GlobalLock is not acquired */
    AtFacs->GlobalLock = 0;

    for (i = 0; i < 3; i++)
    {
        Status = AcpiAcquireGlobalLock(0, &Handle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiAcquireGlobalLock() returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiReleaseGlobalLock(Handle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiReleaseGlobalLock() returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        Status = AcpiReleaseGlobalLock(Handle);
        if (Status != AE_NOT_ACQUIRED)
        {
            AapiErrors++;
            printf ("API error: AcpiReleaseGlobalLock() returned %s, expected %s\n",
                AcpiFormatException(Status), AcpiFormatException(AE_NOT_ACQUIRED));
            return (AE_ERROR);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0030:
 */
ACPI_STATUS
AtHardwTest0030(void)
{
    ACPI_STATUS             Status;
    UINT32                  Resolution;

    Status = AtSubsystemInit(AAPITS_INI_LOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetTimerResolution(&Resolution);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiGetTimerResolution() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    if (Resolution != 24) /* Value 0 of FADT TMR_VAL_EXT field */
    {
        AapiErrors++;
        printf ("API error: AcpiGetTimerResolution() returned unexpected"
            " Resolution %d, expected 24\n",
            Resolution);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0031:
 */
ACPI_STATUS
AtHardwTest0031(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(AAPITS_INI_LOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetTimerResolution(NULL);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("API error: AcpiGetTimerResolution(NULL) returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0032:
 */
ACPI_STATUS
AtHardwTest0032(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;
    UINT32                  TimeElapsed;
    struct duration_check {
        UINT32                  StartTicks;
        UINT32                  EndTicks;
        UINT32                  Usec;} d24[3] = {
            {1000000, 4579545, 1000000}, /* TicksInSec = 3579545 */
            {1, 0, 4686968},
            {0, 0xFFFFFF, 4686968}};

    Status = AtSubsystemInit(AAPITS_INI_LOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < 3; i++)
    {
        Status = AcpiGetTimerDuration(d24[i].StartTicks, d24[i].EndTicks, &TimeElapsed);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiGetTimerDuration() returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        if (TimeElapsed != d24[i].Usec)
        {
            AapiErrors++;
            printf ("API error: AcpiGetTimerDuration(0x%x, 0x%x) returned unexpected"
                " TimeElapsed %d, expected %d\n",
                d24[i].StartTicks, d24[i].EndTicks,
                TimeElapsed, d24[i].Usec);
            return (AE_ERROR);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0033:
 */
ACPI_STATUS
AtHardwTest0033(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(AAPITS_INI_LOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetTimerDuration(0, 1, NULL);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("API error: AcpiGetTimerDuration(0, 1, NULL) returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0034:
 */
ACPI_STATUS
AtHardwTest0034(void)
{
    ACPI_STATUS             Status;
    UINT32                  OutValue;

    Status = AtSubsystemInit(AAPITS_INI_LOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetTimer(&OutValue);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiGetTimer() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    if (OutValue < 0xFFFFFF)
    {
        AapiErrors++;
        printf ("API error: AcpiGetTimer() returned unexpected"
            " OutValue 0x%x, expected >= 0xFFFFFF\n",
            OutValue);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0035:
 */
ACPI_STATUS
AtHardwTest0035(void)
{
    ACPI_STATUS             Status;

    Status = AtSubsystemInit(AAPITS_INI_LOAD,
        0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetTimer(NULL);
    if (Status != AE_BAD_PARAMETER)
    {
        AapiErrors++;
        printf ("API error: AcpiGetTimer(NULL) returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_BAD_PARAMETER));
        return (Status);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * Acquire GlobalLock concurrently
 */
void ACPI_SYSTEM_XFACE
AtConcurrentAcquireGlobalLock(void * Context)
{
    ACPI_STATUS             Status;
    UINT32                  Handle;
    UINT32                  *Flag = (UINT32 *)Context;

    Status = AcpiAcquireGlobalLock(0, &Handle);
    if (Status != AE_TIME)
    {
        AapiErrors++;
        printf ("API error: AcpiAcquireGlobalLock() returned %s,"
            " expected AE_TIME\n",
            AcpiFormatException(Status));
        goto ErrorExit;
    }

    *Flag = 1;

ErrorExit:
    return;
}

/*
 * ASSERTION 0036:
 */
ACPI_STATUS
AtHardwTest0036(void)
{
    ACPI_STATUS             Status;
    UINT32                  Handle;
    UINT32                  ConcurrentFlag = 0;

    Status = AtSubsystemInit(AAPITS_INITIALIZE_SS, 0, 0, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetTable (ACPI_SIG_FACS, 0, (ACPI_TABLE_HEADER **) &AtFacs);
    if (!ACPI_FAILURE (Status))
    {
        AapiErrors++;
        printf ("API error: AcpiGetTable() returned SUCCESS\n");
        return (AE_ERROR);
    }

    Status = AcpiAcquireGlobalLock(0, &Handle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiAcquireGlobalLock() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    /* Run GlobalLock concurrent acquiring */
    Status = AcpiOsExecute(OSL_GPE_HANDLER,
        AtConcurrentAcquireGlobalLock, &ConcurrentFlag);
    if (ACPI_FAILURE (Status))
    {
        printf ("API error: AcpiOsExecute() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    AcpiOsSleep(1000); /* 1 second */

    if (!ConcurrentFlag)
    {
        TestErrors++;
        printf ("Test error: ConcurrentFlag has not been fired\n");
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0037:
 */

/*
 * Emulate Global Lock Interrupt handling
 */
void ACPI_SYSTEM_XFACE
AtEmulateEventGlobalXrupt(void * Context)
{
    UINT32                  RVal;
    UINT32                  *Flag = (UINT32 *)Context;

    AcpiOsSleep(1000); /* 1 second */

    if (AtFacs == NULL)
    {
        TestErrors++;
        printf ("Test error, AtEmulateEventGlobalXrupt: AtFacs == NULL\n");
        goto ErrorExit;
    }

    if (!(AtFacs->GlobalLock & ACPI_GLOCK_OWNED))
    {
        TestErrors++;
        printf ("Test error, AtEmulateEventGlobalXrupt: GlobalLock"
            " ACPI_GLOCK_OWNED bit is not set\n");
        goto ErrorExit;
    }

    if (!(AtFacs->GlobalLock & ACPI_GLOCK_PENDING))
    {
        TestErrors++;
        printf ("Test error, AtEmulateEventGlobalXrupt: GlobalLock"
            " ACPI_GLOCK_PENDING bit is not set\n");
        goto ErrorExit;
    }

    AtFacs->GlobalLock &= ~ACPI_GLOCK_OWNED;

    RVal = AcpiGbl_FixedEventHandlers[ACPI_EVENT_GLOBAL].Handler(
        AcpiGbl_FixedEventHandlers[ACPI_EVENT_GLOBAL].Context);
    if (RVal != ACPI_INTERRUPT_HANDLED)
    {
        TestErrors++;
        printf ("Test error, AcpiEvGlobalLockHandler: RVal(%d) !="
            " ACPI_INTERRUPT_HANDLED(%d)\n",
            RVal, ACPI_INTERRUPT_HANDLED);
        goto ErrorExit;
    }

    *Flag = 1;

ErrorExit:
    return;
}

ACPI_STATUS
AtActions0037(void)
{
    ACPI_STATUS             Status;
    UINT32                  Handle;
    UINT32                  EmulatedFlag = 0;
    UINT64                  T0, Dt;

    /* Simulate GlobalLock ownership */
    AtFacs->GlobalLock = ACPI_GLOCK_OWNED;

    /* Set up GlobalLock release emulation */
    Status = AcpiOsExecute(OSL_GPE_HANDLER,
        AtEmulateEventGlobalXrupt, &EmulatedFlag);
    if (ACPI_FAILURE (Status))
    {
        printf ("API error: AcpiOsExecute() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    if (EmulatedFlag)
    {
        TestErrors++;
        printf ("Test error: EmulatedFlag has already been fired\n");
        return (AE_ERROR);
    }

    T0 = AcpiOsGetTimer();

    Status = AcpiAcquireGlobalLock(0, &Handle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiAcquireGlobalLock() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    if ((Dt = AcpiOsGetTimer() - T0) < 9000000)
    {
        AapiErrors++;
        printf ("API error: %d ms too short time to acquire locked GL\n",
            (UINT32) (Dt / 10000));
        return (AE_ERROR);
    }

    /* Delay for 1 second to allow concurrent thread finishing */
    AcpiOsSleep(1000);

    if (!EmulatedFlag)
    {
        AapiErrors++;
        printf ("API error: AcpiAcquireGlobalLock() returned SUCCESS"
            " for acquired GlobalLock\n");
        return (AE_ERROR);
    }

    Status = AcpiReleaseGlobalLock(Handle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiReleaseGlobalLock() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiReleaseGlobalLock(Handle);
    if (Status != AE_NOT_ACQUIRED)
    {
        AapiErrors++;
        printf ("API error: AcpiReleaseGlobalLock() returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_NOT_ACQUIRED));
        return (AE_ERROR);
    } else {
        Status = AE_OK;
    }

    return (Status);
}

ACPI_STATUS
AtHardwTest0037(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetTable (ACPI_SIG_FACS, 0, (ACPI_TABLE_HEADER **) &AtFacs);
    if (ACPI_FAILURE (Status))
    {
        AapiErrors++;
        printf ("API error: AcpiGetTable() returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    for (i = 0; i < 3; i++) {
        Status = AtActions0037();
        if (ACPI_FAILURE (Status))
        {
            AapiErrors++;
            printf ("API error: case %d AtActions0037() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}


/*
 * Release GlobalLock concurrently
 */
void ACPI_SYSTEM_XFACE
AtConcurrentReleaseGlobalLock(void * Context)
{
    ACPI_STATUS             Status;
    UINT32                  *Handle = (UINT32 *)Context;

    Status = AcpiReleaseGlobalLock(*Handle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiReleaseGlobalLock() returned %s\n",
            AcpiFormatException(Status));
    }

    return;
}

/*
 * ASSERTION 0038:
 */
ACPI_STATUS
AtHardwTest0038(void)
{
    ACPI_STATUS             Status;
    UINT32                  Handle;
    UINT32                  i;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetTable (ACPI_SIG_FACS, 0, (ACPI_TABLE_HEADER **) &AtFacs);
    if (ACPI_FAILURE (Status))
    {
        AapiErrors++;
        printf ("API error: AcpiGetTable() returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    /* Simulate GlobalLock is not acquired */
    AtFacs->GlobalLock = 0;

    for (i = 0; i < 3; i++)
    {
        Status = AcpiAcquireGlobalLock(0, &Handle);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("API error: AcpiAcquireGlobalLock() returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        /* Set up GlobalLock Concurrent Release */
        Status = AcpiOsExecute(OSL_GPE_HANDLER,
            AtConcurrentReleaseGlobalLock, &Handle);
        if (ACPI_FAILURE (Status))
        {
            printf ("API error: AcpiOsExecute() returned %s\n",
                AcpiFormatException(Status));
            return (Status);
        }

        AcpiOsSleep(1000); /* 1 second */
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}


/*
 * ASSERTION 0039:
 */

ACPI_STATUS
AtActions0039(void)
{
    ACPI_STATUS             Status;
    UINT32                  Handle;
    UINT32                  EmulatedFlag = 0;
    UINT64                  T0, Dt;

    /* Set up GlobalLock 2000 mls holding */
    Status = AcpiOsExecute(OSL_GPE_HANDLER,
        AtConcurrentHoldGlobalLock, &EmulatedFlag);
    if (ACPI_FAILURE (Status))
    {
        printf ("API error: AcpiOsExecute() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    AcpiOsSleep(1000); /* delay for 1 second the Global Lock to be held */

    if (EmulatedFlag)
    {
        TestErrors++;
        printf ("Test error: EmulatedFlag has already been fired\n");
        return (AE_ERROR);
    }

    T0 = AcpiOsGetTimer();

    Status = AcpiAcquireGlobalLock(0xFFFF, &Handle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiAcquireGlobalLock() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    if ((Dt = AcpiOsGetTimer() - T0) < 9000000)
    {
        AapiErrors++;
        printf ("API error: %d ms too short time to acquire locked GL\n",
            (UINT32) (Dt / 10000));
        return (AE_ERROR);
    }

    /* Delay for 1 second to allow concurrent thread finishing */
    AcpiOsSleep(1000);

    if (!EmulatedFlag)
    {
        AapiErrors++;
        printf ("API error: AcpiAcquireGlobalLock() returned SUCCESS"
            " for acquired GlobalLock\n");
        return (AE_ERROR);
    }

    Status = AcpiReleaseGlobalLock(Handle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiReleaseGlobalLock() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiReleaseGlobalLock(Handle);
    if (Status != AE_NOT_ACQUIRED)
    {
        AapiErrors++;
        printf ("API error: AcpiReleaseGlobalLock() returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_NOT_ACQUIRED));
        return (AE_ERROR);
    } else {
        Status = AE_OK;
    }

    return (Status);
}

ACPI_STATUS
AtHardwTest0039(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    Status = AcpiGetTable (ACPI_SIG_FACS, 0, (ACPI_TABLE_HEADER **) &AtFacs);
    if (ACPI_FAILURE (Status))
    {
        AapiErrors++;
        printf ("API error: AcpiGetTable() returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    AtFacs->GlobalLock = 0;

    for (i = 0; i < 3; i++) {
        Status = AtActions0039();
        if (ACPI_FAILURE (Status))
        {
            AapiErrors++;
            printf ("API error: case %d AtActions0039() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}


/*
 * ASSERTION 0040:
 */

/*
 * Acquire GlobalLock concurrently through AML
 */
void ACPI_SYSTEM_XFACE
AtConcurrentHold_GL(void * Context)
{
    ACPI_STATUS             Status;
    UINT32                  *Flag = (UINT32 *)Context;

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\T040", 0)))
    {
        goto ErrorExit;
    }

    *Flag = 1;

ErrorExit:
    return;
}

ACPI_STATUS
AtActions0040(void)
{
    ACPI_STATUS             Status;
    UINT32                  Handle;
    UINT32                  EmulatedFlag = 0;
    UINT64                  T0, Dt;

    /* Set up GlobalLock 2000 mls holding */
    Status = AcpiOsExecute(OSL_GPE_HANDLER,
        AtConcurrentHold_GL, &EmulatedFlag);
    if (ACPI_FAILURE (Status))
    {
        printf ("API error: AcpiOsExecute() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    AcpiOsSleep(1000); /* delay for 1 second the Global Lock to be held */

    if (EmulatedFlag)
    {
        TestErrors++;
        printf ("Test error: EmulatedFlag has already been fired\n");
        return (AE_ERROR);
    }

    T0 = AcpiOsGetTimer();

    Status = AcpiAcquireGlobalLock(0xFFFF, &Handle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiAcquireGlobalLock() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    if ((Dt = AcpiOsGetTimer() - T0) < 9000000)
    {
        AapiErrors++;
        printf ("API error: %d ms too short time to acquire locked GL\n",
            (UINT32) (Dt / 10000));
        return (AE_ERROR);
    }

    /* Delay for 1 second to allow concurrent thread finishing */
    AcpiOsSleep(1000);

    if (!EmulatedFlag)
    {
        AapiErrors++;
        printf ("API error: AcpiAcquireGlobalLock() returned SUCCESS"
            " for acquired GlobalLock\n");
        return (AE_ERROR);
    }

    Status = AcpiReleaseGlobalLock(Handle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiReleaseGlobalLock() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    Status = AcpiReleaseGlobalLock(Handle);
    if (Status != AE_NOT_ACQUIRED)
    {
        AapiErrors++;
        printf ("API error: AcpiReleaseGlobalLock() returned %s, expected %s\n",
            AcpiFormatException(Status), AcpiFormatException(AE_NOT_ACQUIRED));
        return (AE_ERROR);
    } else {
        Status = AE_OK;
    }

    return (Status);
}

ACPI_STATUS
AtHardwTest0040(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hdwr0040.aml")))
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

    Status = AcpiGetTable (ACPI_SIG_FACS, 0, (ACPI_TABLE_HEADER **) &AtFacs);
    if (ACPI_FAILURE (Status))
    {
        AapiErrors++;
        printf ("API error: AcpiGetTable() returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    AtFacs->GlobalLock = 0;

    for (i = 0; i < 3; i++) {
        Status = AtActions0040();
        if (ACPI_FAILURE (Status))
        {
            AapiErrors++;
            printf ("API error: case %d AtActions0040() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}


/*
 * ASSERTION 0041:
 */

ACPI_STATUS
AtActions0041(UINT32 Step)
{
    ACPI_STATUS             Status;
    UINT32                  EmulatedFlag = 0;
    UINT64                  T0, Dt;
    UINT32                  Handle;

    Status = AcpiAcquireGlobalLock(0, &Handle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiAcquireGlobalLock() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    T0 = AcpiOsGetTimer();

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\TNOL", Step)))
    {
        return (Status);
    }

    if ((Dt = AcpiOsGetTimer() - T0) > 1000000)
    {
        AapiErrors++;
        printf ("API error: %d ms too long time of NoLock field access 0\n",
            (UINT32) (Dt / 10000));
        return (AE_ERROR);
    }

    T0 = AcpiOsGetTimer();

    /*
     * Acquire GlobalLock concurrently through AML
     */
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\TLCK", Step)))
    {
        return (Status);
    }

    if ((Dt = AcpiOsGetTimer() - T0) > 1000000)
    {
        AapiErrors++;
        printf ("API error: %d ms too long time of NoLock field access 1\n",
            (UINT32) (Dt / 10000));
        return (AE_ERROR);
    }

    Status = AcpiReleaseGlobalLock(Handle);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("API error: AcpiReleaseGlobalLock() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    /* Set up GlobalLock 2000 mls holding */
    Status = AcpiOsExecute(OSL_GPE_HANDLER,
        AtConcurrentHoldGlobalLock, &EmulatedFlag);
    if (ACPI_FAILURE (Status))
    {
        printf ("API error: AcpiOsExecute() returned %s\n",
            AcpiFormatException(Status));
        return (Status);
    }

    AcpiOsSleep(1000); /* delay for 1 second the Global Lock to be held */

    if (EmulatedFlag)
    {
        TestErrors++;
        printf ("Test error: EmulatedFlag has already been fired\n");
        return (AE_ERROR);
    }

    T0 = AcpiOsGetTimer();

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\TNOL", Step + 1)))
    {
        return (Status);
    }

    if ((Dt = AcpiOsGetTimer() - T0) > 1000000)
    {
        AapiErrors++;
        printf ("API error: %d ms too long time of NoLock field access2\n",
            (UINT32) (Dt / 10000));
        return (AE_ERROR);
    }

    T0 = AcpiOsGetTimer();

    /*
     * Acquire GlobalLock concurrently through AML
     */
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, "\\TLCK", Step + 1)))
    {
        return (Status);
    }

    if ((Dt = AcpiOsGetTimer() - T0) < 9000000)
    {
        AapiErrors++;
        printf ("API error: %d ms too short time of Lock field access\n",
            (UINT32) (Dt / 10000));
        return (AE_ERROR);
    }

    /* Delay for 1 second to allow concurrent thread finishing */
    AcpiOsSleep(1000);

    if (!EmulatedFlag)
    {
        AapiErrors++;
        printf ("API error: AcpiAcquireGlobalLock() returned SUCCESS"
            " for acquired GlobalLock\n");
        return (AE_ERROR);
    }

    return (Status);
}

ACPI_STATUS
AtHardwTest0041(void)
{
    ACPI_STATUS             Status;
    UINT32                  i;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hdwr0041.aml")))
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

    Status = AcpiGetTable (ACPI_SIG_FACS, 0, (ACPI_TABLE_HEADER **) &AtFacs);
    if (ACPI_FAILURE (Status))
    {
        AapiErrors++;
        printf ("API error: AcpiGetTable() returned %s\n",
            AcpiFormatException(Status));
        return (AE_ERROR);
    }

    AtFacs->GlobalLock = 0;

    for (i = 0; i < 3; i++) {
        Status = AtActions0041(2 * i + 1);
        if (ACPI_FAILURE (Status))
        {
            AapiErrors++;
            printf ("API error: case %d AtActions0041() returned %s\n",
                i, AcpiFormatException(Status));
            return (Status);
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}
