/******************************************************************************
 *
 * Module Name: atfixedevent - ACPICA Fixed Event Management API tests
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
#include "atfixedevent.h"
#include "atosxfctrl.h"

#define _COMPONENT          ACPI_TOOLS
        ACPI_MODULE_NAME    ("atfixedevent")

ACPI_STATUS
AtFixedEventsCommon(
    UINT32                  ApiCall,
    UINT32                  CheckAction,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    UINT32                  Event, Flags = 0;
    UINT32                  i;
    char                    *ApiCallName;
    ACPI_EVENT_STATUS       EventStatus, *EventStatusPointer = &EventStatus;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF,
        AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++)
    {
        switch (i)
        {
        case 0:
            Event = ACPI_EVENT_PMTIMER;
            break;
        case 1:
            Event = ACPI_EVENT_GLOBAL;
            break;
        case 2:
            Event = ACPI_EVENT_POWER_BUTTON;
            break;
        case 3:
            Event = ACPI_EVENT_SLEEP_BUTTON;
            break;
        case 4:
            Event = ACPI_EVENT_RTC;
            break;
        default:
            TestErrors++;
            printf ("Test Error: the number of Fixed Events (%d) too big (should be 5)\n",
                ACPI_NUM_FIXED_EVENTS);
            return (AE_ERROR);
        }
        if (CheckAction == 1)
        {
            Event += ACPI_NUM_FIXED_EVENTS;
        }
        else if (CheckAction == 2)
        {
            EventStatusPointer = NULL;
        }

        switch (ApiCall)
        {
        case 0:
            ApiCallName = "AcpiEnableEvent";
            Status = AcpiEnableEvent(Event, Flags);
            break;
        case 1:
            ApiCallName = "AcpiDisableEvent";
            Status = AcpiDisableEvent(Event, Flags);
            break;
        case 2:
            ApiCallName = "AcpiClearEvent";
            Status = AcpiClearEvent(Event);
            break;
        case 3:
            ApiCallName = "AcpiGetEventStatus";
            Status = AcpiGetEventStatus(Event, EventStatusPointer);
            break;
        default:
            TestErrors++;
            printf ("Test Error: the ApiCall number (%d) should be in range 0-3\n",
                ApiCall);
            return (AE_ERROR);
        }

        if (Status != ExpectedStatus)
        {
            AapiErrors++;
            printf ("Api Error: %s(%d) returned %s, expected %s\n",
                ApiCallName, Event, AcpiFormatException(Status),
                AcpiFormatException(ExpectedStatus));
            if (Status != AE_OK)
            {
                return (Status);
            }
            else
            {
                return (AE_ERROR);
            }
        }
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0000:
 */
ACPI_STATUS
AtFixEvTest0000(void)
{
    return (AtFixedEventsCommon(0 /* Enable */, 0, AE_OK));
}

/*
 * ASSERTION 0001:
 */
ACPI_STATUS
AtFixEvTest0001(void)
{
    return (AtFixedEventsCommon(0 /* Enable */, 1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0002:
 */
ACPI_STATUS
AtFixEvTest0002(void)
{
    return (AtFixedEventsCommon(1 /* Disable */, 0, AE_OK));
}

/*
 * ASSERTION 0003:
 */
ACPI_STATUS
AtFixEvTest0003(void)
{
    return (AtFixedEventsCommon(1 /* Disable */, 1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0004:
 */
ACPI_STATUS
AtFixEvTest0004(void)
{
    return (AtFixedEventsCommon(2 /* Clear */, 0, AE_OK));
}

/*
 * ASSERTION 0005:
 */
ACPI_STATUS
AtFixEvTest0005(void)
{
    return (AtFixedEventsCommon(2 /* Clear */, 1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0006:
 */
ACPI_STATUS
AtFixEvTest0006(void)
{
    return (AtFixedEventsCommon(3 /* Status */, 0, AE_OK));
}

/*
 * ASSERTION 0007:
 */
ACPI_STATUS
AtFixEvTest0007(void)
{
    return (AtFixedEventsCommon(3 /* Status */, 1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0008:
 */
ACPI_STATUS
AtFixEvTest0008(void)
{
    return (AtFixedEventsCommon(3 /* Status */, 2, AE_BAD_PARAMETER));
}

static UINT32           FixedEventHandlerCounter;
static UINT32           FixedEventHandlerContext[ACPI_NUM_FIXED_EVENTS];

UINT32
AtFixedEventHandler0 (
    void                    *Context)
{
    UINT32                  HandlerId = 0;

    printf ("AtFixedEventHandler%d: Context %p\n", HandlerId, Context);
    ++FixedEventHandlerCounter;

    if ((UINT32 *)Context - FixedEventHandlerContext > ACPI_NUM_FIXED_EVENTS) {
        AapiErrors++;
        printf ("AtFixedEventHandler: Context (0x%p) is out of"
            " FixedEventHandlerContext (0x%p: %d)\n",
            Context, FixedEventHandlerContext, ACPI_NUM_FIXED_EVENTS);
    }

    return (0);
}

UINT32
AtFixedEventHandler1 (
    void                    *Context)
{
    UINT32                  HandlerId = 1;

    printf ("AtFixedEventHandler%d: Context %p\n", HandlerId, Context);
    ++FixedEventHandlerCounter;

    if ((UINT32 *)Context - FixedEventHandlerContext > ACPI_NUM_FIXED_EVENTS) {
        AapiErrors++;
        printf ("AtFixedEventHandler: Context (0x%p) is out of"
            " FixedEventHandlerContext (0x%p: %d)\n",
            Context, FixedEventHandlerContext, ACPI_NUM_FIXED_EVENTS);
    }

    return (0);
}

UINT32
AtFixedEventHandler2 (
    void                    *Context)
{
    UINT32                  HandlerId = 2;

    printf ("AtFixedEventHandler%d: Context %p\n", HandlerId, Context);
    ++FixedEventHandlerCounter;

    if ((UINT32 *)Context - FixedEventHandlerContext > ACPI_NUM_FIXED_EVENTS) {
        AapiErrors++;
        printf ("AtFixedEventHandler: Context (0x%p) is out of"
            " FixedEventHandlerContext (0x%p: %d)\n",
            Context, FixedEventHandlerContext, ACPI_NUM_FIXED_EVENTS);
    }

    return (0);
}

static ACPI_EVENT_HANDLER   FixedEventHandlers[ACPI_NUM_FIXED_EVENTS] = {
    AtFixedEventHandler0, AtFixedEventHandler0,
    AtFixedEventHandler1, AtFixedEventHandler1,
    AtFixedEventHandler2};

ACPI_STATUS
AtInstallFixedEventHandlerCommon(
    UINT32                  CheckAction,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    UINT32                  Event = ACPI_NUM_FIXED_EVENTS;
    ACPI_EVENT_HANDLER      EventHandler;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  i;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF & ~AAPITS_INSTALL_HS,
        AAPITS_EN_FLAGS | ACPI_NO_HANDLER_INIT, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    if (CheckAction == 4)
    {
        if (ExpectedStatus != AE_ALREADY_EXISTS)
        {
            TestErrors++;
            printf ("Test Error: ExpectedStatus %s != AE_ALREADY_EXISTS\n",
                AcpiFormatException(ExpectedStatus));
            return (AE_ERROR);
        }
        ExpectedStatus = AE_OK;
    }

    FixedEventHandlerCounter = 0;
    for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++)
    {
        switch (i)
        {
        case 0:
            Event = ACPI_EVENT_PMTIMER;
            break;
        case 1:
            Event = ACPI_EVENT_GLOBAL;
            break;
        case 2:
            Event = ACPI_EVENT_POWER_BUTTON;
            break;
        case 3:
            Event = ACPI_EVENT_SLEEP_BUTTON;
            break;
        case 4:
            Event = ACPI_EVENT_RTC;
            break;
        default:
            TestErrors++;
            printf ("Test Error: the number of Fixed Events (%d) too big (should be 5)\n",
                ACPI_NUM_FIXED_EVENTS);
            return (AE_ERROR);
        }
        EventHandler = FixedEventHandlers[i];

        if (CheckAction == 1)
        {
            Event += ACPI_NUM_FIXED_EVENTS;
        }
        else if (CheckAction == 2)
        {
            EventHandler = NULL;
        }
        else if (CheckAction == 3)
        {
            /*
             * initiate the situation when fixed event
             * enable register can not be written
             */
            Status = OsxfCtrlSet(OSXF_NUM(AcpiOsWritePort), 1,
                AtActD_OneTime, AtActRet_ERROR);
            if (ACPI_FAILURE(Status))
            {
                TestErrors++;
                printf ("Test error: OsxfCtrlSet returned %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
        }

        FixedEventHandlerContext[i] = 0;

        Status = AcpiInstallFixedEventHandler(Event,
            EventHandler, &FixedEventHandlerContext[i]);

        if (CheckAction == 3 &&
            !(OsxfNumAct = OsxfCtrlGetActOsxf(OSXF_NUM(AcpiOsWritePort), 1)))
        {
            TestSkipped++;
            printf ("Test note: test action hasn't occur\n");
            return (AE_ERROR);
        }
        TestPass++;

        if (Status != ExpectedStatus)
        {
            AapiErrors++;
            printf ("Api Error: AcpiInstallFixedEventHandler(%d, 0x%p)"
                " returned %s, expected %s\n",
                Event, EventHandler, AcpiFormatException(Status),
                AcpiFormatException(ExpectedStatus));
            if (Status != AE_OK)
            {
                return (Status);
            }
            else
            {
                return (AE_ERROR);
            }
        }
    }

    if (CheckAction == 4)
    {
        for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++)
        {
            switch (i)
            {
            case 0:
                Event = ACPI_EVENT_PMTIMER;
                break;
            case 1:
                Event = ACPI_EVENT_GLOBAL;
                break;
            case 2:
                Event = ACPI_EVENT_POWER_BUTTON;
                break;
            case 3:
                Event = ACPI_EVENT_SLEEP_BUTTON;
                break;
            case 4:
                Event = ACPI_EVENT_RTC;
                break;
            }
            EventHandler = FixedEventHandlers[(i + 1) % ACPI_NUM_FIXED_EVENTS];

            Status = AcpiInstallFixedEventHandler(Event,
                EventHandler, &FixedEventHandlerContext[i]);
            if (Status != AE_ALREADY_EXISTS)
            {
                AapiErrors++;
                printf ("Error: AcpiInstallFixedEventHandler(%d, 0x%p) returned %s,"
                    " expected %s\n",
                    Event, EventHandler, AcpiFormatException(Status),
                    AcpiFormatException(AE_ALREADY_EXISTS));
                return (AE_ERROR);
            }
        }
    }

    if (FixedEventHandlerCounter != 0)
    {
        AapiErrors++;
        printf ("Api Error: FixedEvent Handler invoked %d times\n",
            FixedEventHandlerCounter);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0009:
 *
 */
ACPI_STATUS
AtFixEvTest0009(void)
{
    return (AtInstallFixedEventHandlerCommon(0, AE_OK));
}

/*
 * ASSERTION 0010:
 *
 */
ACPI_STATUS
AtFixEvTest0010(void)
{
    return (AtInstallFixedEventHandlerCommon(1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0011:
 *
 */
ACPI_STATUS
AtFixEvTest0011(void)
{
    return (AtInstallFixedEventHandlerCommon(2, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0012:
 *
 */
ACPI_STATUS
AtFixEvTest0012(void)
{
    return (AtInstallFixedEventHandlerCommon(3, AE_ERROR));
}

/*
 * ASSERTION 0013:
 *
 */
ACPI_STATUS
AtFixEvTest0013(void)
{
    return (AtInstallFixedEventHandlerCommon(4, AE_ALREADY_EXISTS));
}

ACPI_STATUS
AtRemoveFixedEventHandlerCommon(
    UINT32                  CheckAction,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    UINT32                  Event = ACPI_NUM_FIXED_EVENTS;
    ACPI_EVENT_HANDLER      EventHandler;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  i;

    Status = AtSubsystemInit(
        AAPITS_INI_DEF & ~AAPITS_INSTALL_HS,
        AAPITS_EN_FLAGS | ACPI_NO_HANDLER_INIT, AAPITS_OI_FLAGS, NULL);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    FixedEventHandlerCounter = 0;
    for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++)
    {
        if (CheckAction == 5)
        {
            continue;
        }
        switch (i)
        {
        case 0:
            Event = ACPI_EVENT_PMTIMER;
            break;
        case 1:
            Event = ACPI_EVENT_GLOBAL;
            break;
        case 2:
            Event = ACPI_EVENT_POWER_BUTTON;
            break;
        case 3:
            Event = ACPI_EVENT_SLEEP_BUTTON;
            break;
        case 4:
            Event = ACPI_EVENT_RTC;
            break;
        default:
            TestErrors++;
            printf ("Test Error: the number of Fixed Events (%d) too big (should be 5)\n",
                ACPI_NUM_FIXED_EVENTS);
            return (AE_ERROR);
        }
        EventHandler = FixedEventHandlers[i];

        FixedEventHandlerContext[i] = 0;

        Status = AcpiInstallFixedEventHandler(Event,
            EventHandler, &FixedEventHandlerContext[i]);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiInstallFixedEventHandler(%d) returned %s\n",
                Event, AcpiFormatException(Status));
            return (Status);
        }
    }

    for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++)
    {
        switch (i)
        {
        case 0:
            Event = ACPI_EVENT_PMTIMER;
            break;
        case 1:
            Event = ACPI_EVENT_GLOBAL;
            break;
        case 2:
            Event = ACPI_EVENT_POWER_BUTTON;
            break;
        case 3:
            Event = ACPI_EVENT_SLEEP_BUTTON;
            break;
        case 4:
            Event = ACPI_EVENT_RTC;
            break;
        }
        EventHandler = FixedEventHandlers[i];

        if (CheckAction == 1)
        {
            Event += ACPI_NUM_FIXED_EVENTS;
        }
        else if (CheckAction == 2)
        {
            EventHandler = NULL;
        }
        else if (CheckAction == 3)
        {
            /*
             * initiate the situation when fixed event
             * enable register can not be written
             */
            Status = OsxfCtrlSet(OSXF_NUM(AcpiOsWritePort), 1,
                AtActD_OneTime, AtActRet_ERROR);
            if (ACPI_FAILURE(Status))
            {
                TestErrors++;
                printf ("Test error: OsxfCtrlSet returned %s\n",
                    AcpiFormatException(Status));
                return (Status);
            }
        }
        else if (CheckAction == 4)
        {
            EventHandler = FixedEventHandlers[(i + 2) % ACPI_NUM_FIXED_EVENTS];
        }

        Status = AcpiRemoveFixedEventHandler(Event, EventHandler);

        if (CheckAction == 3 &&
            !(OsxfNumAct = OsxfCtrlGetActOsxf(OSXF_NUM(AcpiOsWritePort), 1)))
        {
            TestSkipped++;
            printf ("Test note: test action hasn't occur\n");
            return (AE_ERROR);
        }
        TestPass++;

        if (Status != ExpectedStatus)
        {
            AapiErrors++;
            printf ("Api Error: AcpiRemoveFixedEventHandler(%d, 0x%p)"
                " returned %s, expected %s\n",
                Event, EventHandler, AcpiFormatException(Status),
                AcpiFormatException(ExpectedStatus));
            if (Status != AE_OK)
            {
                return (Status);
            }
            else
            {
                return (AE_ERROR);
            }
        }
    }

    if (FixedEventHandlerCounter != 0)
    {
        AapiErrors++;
        printf ("Api Error: FixedEvent Handler invoked %d times\n",
            FixedEventHandlerCounter);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0014:
 *
 */
ACPI_STATUS
AtFixEvTest0014(void)
{
    return (AtRemoveFixedEventHandlerCommon(0, AE_OK));
}

/*
 * ASSERTION 0015:
 *
 */
ACPI_STATUS
AtFixEvTest0015(void)
{
    return (AtRemoveFixedEventHandlerCommon(1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0016:
 *
 */
ACPI_STATUS
AtFixEvTest0016(void)
{
    return (AtRemoveFixedEventHandlerCommon(2, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0017:
 *
 */
ACPI_STATUS
AtFixEvTest0017(void)
{
    return (AtRemoveFixedEventHandlerCommon(3, AE_ERROR));
}

/*
 * ASSERTION 0018:
 *
 */
ACPI_STATUS
AtFixEvTest0018(void)
{
    return (AtRemoveFixedEventHandlerCommon(4, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0019:
 *
 */
ACPI_STATUS
AtFixEvTest0019(void)
{
    return (AtRemoveFixedEventHandlerCommon(5, AE_NOT_EXIST));
}
