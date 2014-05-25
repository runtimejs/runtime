/******************************************************************************
 *
 * Module Name: athandlers - ACPICA Miscellaneous Handler Support API tests
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
#include "athandlers.h"
#include "atosxfctrl.h"

#define _COMPONENT          ACPI_TOOLS
        ACPI_MODULE_NAME    ("athandlers")


#define AT_NUM_NOTIFY_TYPES   2
#define AT_MAX_NUM_NOTIFY     10

typedef struct at_notify_test_data
{
    UINT32                  InstallFlag;
    ACPI_STRING             Pathname;
    ACPI_HANDLE             Object;
    UINT32                  NotifyHandlerNum;
    ACPI_NOTIFY_HANDLER     Handler[AT_NUM_NOTIFY_TYPES];
    UINT32                  HandlerType[AT_NUM_NOTIFY_TYPES];
    UINT32                  Context[AT_NUM_NOTIFY_TYPES];
    UINT32                  NumNotify;
    UINT32                  HandlerId[AT_MAX_NUM_NOTIFY];
    UINT32                  NotifyValue[AT_MAX_NUM_NOTIFY];
    UINT32                  NotifyCount[AT_MAX_NUM_NOTIFY];
} AT_NOTIFY_TEST_DATA;

typedef struct at_notify_handler_test_data
{
    UINT32                  NumData;
    AT_NOTIFY_TEST_DATA     *TestData;
} AT_NOTIFY_HANDLER_TEST_DATA;

static UINT32               NotifyHandlerCounter;
static UINT32               NotifyHandlerMissCounter;

static AT_NOTIFY_HANDLER_TEST_DATA    NotifyHandlerTestData;

#define DEF_NOTIFY_HANDLER(Hid) \
void \
AtNotifyHandler##Hid (\
    ACPI_HANDLE             Device,\
    UINT32                  Value,\
    void                    *Context)\
{\
    UINT32                  HandlerId = Hid;\
    UINT32                  i, j;\
    AT_NOTIFY_TEST_DATA     *TestData;\
\
    ++NotifyHandlerCounter;\
\
    printf ("AtNotifyHandler%d %d: Device 0x%p, Value 0x%x, Context 0x%p\n",\
        HandlerId, NotifyHandlerCounter, Device, Value, Context);\
\
    for (i = 0; i < NotifyHandlerTestData.NumData; i++)\
    {\
        TestData = &NotifyHandlerTestData.TestData[i];\
        if (Device == TestData->Object)\
        {\
            if ((UINT32 *)Context - TestData->Context > AT_NUM_NOTIFY_TYPES) {\
                AapiErrors++;\
                printf ("AtNotifyHandler%d: Context (0x%p) is out of"\
                    " NotifyHandlerContext (0x%p: %d)\n",\
                    HandlerId, Context, TestData->Context, AT_NUM_NOTIFY_TYPES);\
            }\
            for (j = 0; j < TestData->NumNotify; j++) {\
                if (HandlerId == TestData->HandlerId[j] &&\
                    Value == TestData->NotifyValue[j])\
                {\
                    TestData->NotifyCount[j]++;\
                    return;\
                }\
            }\
\
        }\
    }\
\
    ++NotifyHandlerMissCounter;\
\
    return;\
}

DEF_NOTIFY_HANDLER(0)
DEF_NOTIFY_HANDLER(1)
DEF_NOTIFY_HANDLER(2)
DEF_NOTIFY_HANDLER(3)
DEF_NOTIFY_HANDLER(4)
DEF_NOTIFY_HANDLER(5)

static AT_NOTIFY_TEST_DATA  NotifyTestData0000[] = {
    {
        1, NULL, NULL,
        2 /* NotifyHandlerNum */,
        {AtNotifyHandler0, AtNotifyHandler1},
        {ACPI_SYSTEM_NOTIFY, ACPI_DEVICE_NOTIFY},
        {0, 1},
        0 /* NumNotify */,
    },
    {
        0, "\\DEV0", NULL,
        2 /* NotifyHandlerNum */,
        {NULL, NULL},
        {0, 0},
        {0, 1},
        5 /* NumNotify */,
        {0, 0, 0, 1, 1},
        {0x00, 0x20, 0x7f, 0x80, 0xff},
    },
    {
        0, "\\CPU0", NULL,
        2 /* NotifyHandlerNum */,
        {NULL, NULL},
        {0, 0},
        {0, 1},
        5 /* NumNotify */,
        {0, 0, 0, 1, 1},
        {0x02, 0x22, 0x7d, 0x82, 0xfd},
    },
    {
        0, "\\TZN0", NULL,
        2 /* NotifyHandlerNum */,
        {NULL, NULL},
        {0, 0},
        {0, 1},
        5 /* NumNotify */,
        {0, 0, 0, 1, 1},
        {0x03, 0x23, 0x7c, 0x83, 0xfc},
    },
    {
        0, "\\_SB_.DEV0", NULL,
        2 /* NotifyHandlerNum */,
        {NULL, NULL},
        {0, 0},
        {0, 1},
        5 /* NumNotify */,
        {0, 0, 0, 1, 1},
        {0x01, 0x21, 0x7e, 0x81, 0xfe},
    },
};

static AT_NOTIFY_TEST_DATA  NotifyTestData0001[] = {
    {
        1, "\\DEV0", NULL,
        2 /* NotifyHandlerNum */,
        {AtNotifyHandler0, AtNotifyHandler0},
        {ACPI_SYSTEM_NOTIFY, ACPI_DEVICE_NOTIFY},
        {0, 1},
        5 /* NumNotify */,
        {0, 0, 0, 0, 0},
        {0x00, 0x20, 0x7f, 0x80, 0xff},
    },
    {
        1, "\\CPU0", NULL,
        2 /* NotifyHandlerNum */,
        {AtNotifyHandler1, AtNotifyHandler2},
        {ACPI_SYSTEM_NOTIFY, ACPI_DEVICE_NOTIFY},
        {0, 1},
        5 /* NumNotify */,
        {1, 1, 1, 2, 2},
        {0x02, 0x22, 0x7d, 0x82, 0xfd},
    },
    {
        1, "\\TZN0", NULL,
        2 /* NotifyHandlerNum */,
        {AtNotifyHandler2, AtNotifyHandler3},
        {ACPI_SYSTEM_NOTIFY, ACPI_DEVICE_NOTIFY},
        {0, 1},
        5 /* NumNotify */,
        {2, 2, 2, 3, 3},
        {0x03, 0x23, 0x7c, 0x83, 0xfc},
    },
    {
        1, "\\_SB_.DEV0", NULL,
        1 /* NotifyHandlerNum */,
        {AtNotifyHandler4},
        {ACPI_SYSTEM_NOTIFY | ACPI_DEVICE_NOTIFY},
        {0, 1},
        5 /* NumNotify */,
        {4, 4, 4, 4, 4},
        {0x01, 0x21, 0x7e, 0x81, 0xfe},
    },
};

static AT_NOTIFY_TEST_DATA  NotifyTestData0006[] = {
    {
        1, "\\INT0", NULL,
        1 /* NotifyHandlerNum */,
        {AtNotifyHandler0, AtNotifyHandler0},
        {ACPI_SYSTEM_NOTIFY | ACPI_DEVICE_NOTIFY},
        {0},
        0 /* NumNotify */,
    },
    {
        1, "\\STR0", NULL,
        1 /* NotifyHandlerNum */,
        {AtNotifyHandler0, AtNotifyHandler0},
        {ACPI_SYSTEM_NOTIFY | ACPI_DEVICE_NOTIFY},
        {0},
        0 /* NumNotify */,
    },
    {
        1, "\\BUF0", NULL,
        1 /* NotifyHandlerNum */,
        {AtNotifyHandler0, AtNotifyHandler0},
        {ACPI_SYSTEM_NOTIFY | ACPI_DEVICE_NOTIFY},
        {0},
        0 /* NumNotify */,
    },
    {
        1, "\\PAC0", NULL,
        1 /* NotifyHandlerNum */,
        {AtNotifyHandler0, AtNotifyHandler0},
        {ACPI_SYSTEM_NOTIFY | ACPI_DEVICE_NOTIFY},
        {0},
        0 /* NumNotify */,
    },
    {
        1, "\\FLU0", NULL,
        1 /* NotifyHandlerNum */,
        {AtNotifyHandler0, AtNotifyHandler0},
        {ACPI_SYSTEM_NOTIFY | ACPI_DEVICE_NOTIFY},
        {0},
        0 /* NumNotify */,
    },
    {
        1, "\\EVE0", NULL,
        1 /* NotifyHandlerNum */,
        {AtNotifyHandler0, AtNotifyHandler0},
        {ACPI_SYSTEM_NOTIFY | ACPI_DEVICE_NOTIFY},
        {0},
        0 /* NumNotify */,
    },
    {
        1, "\\MMM0", NULL,
        1 /* NotifyHandlerNum */,
        {AtNotifyHandler0, AtNotifyHandler0},
        {ACPI_SYSTEM_NOTIFY | ACPI_DEVICE_NOTIFY},
        {0},
        0 /* NumNotify */,
    },
    {
        1, "\\MTX0", NULL,
        1 /* NotifyHandlerNum */,
        {AtNotifyHandler0, AtNotifyHandler0},
        {ACPI_SYSTEM_NOTIFY | ACPI_DEVICE_NOTIFY},
        {0},
        0 /* NumNotify */,
    },
    {
        1, "\\OPR0", NULL,
        1 /* NotifyHandlerNum */,
        {AtNotifyHandler0, AtNotifyHandler0},
        {ACPI_SYSTEM_NOTIFY | ACPI_DEVICE_NOTIFY},
        {0},
        0 /* NumNotify */,
    },
    {
        1, "\\PWR0", NULL,
        1 /* NotifyHandlerNum */,
        {AtNotifyHandler0, AtNotifyHandler0},
        {ACPI_SYSTEM_NOTIFY | ACPI_DEVICE_NOTIFY},
        {0},
        0 /* NumNotify */,
    },
    {
        1, "\\BUF0", NULL,
        1 /* NotifyHandlerNum */,
        {AtNotifyHandler0, AtNotifyHandler0},
        {ACPI_SYSTEM_NOTIFY | ACPI_DEVICE_NOTIFY},
        {0},
        0 /* NumNotify */,
    },
};

static AT_NOTIFY_TEST_DATA  NotifyTestDataSsdt[] = {
    {
        1, "\\AUX2.DEV0", NULL,
        2 /* NotifyHandlerNum */,
        {AtNotifyHandler0, AtNotifyHandler0},
        {ACPI_SYSTEM_NOTIFY, ACPI_DEVICE_NOTIFY},
        {0, 1},
        5 /* NumNotify */,
        {0, 0, 0, 0, 0},
        {0x00, 0x20, 0x7f, 0x80, 0xff},
    },
};

ACPI_STATUS
AtInstallNotifyHandlerCommon(
    ACPI_STRING             NotifyMethod,
    AT_NOTIFY_TEST_DATA    *TestData,
    UINT32                  NumData,
    UINT32                  CheckAction,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Object;
    UINT32                  Type;
    ACPI_NOTIFY_HANDLER     Handler;
    void                    *Context;
    UINT32                  i, j;
    UINT32                  ExpectedNotifyHandlerCounter = 0;
    UINT32                  InitStages = AAPITS_INI_DEF & ~AAPITS_INSTALL_HS;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hndl0000.aml")))
    {
        return (Status);
    }

    if (CheckAction == 1)
    {
        InitStages |= AAPITS_INSTALL_HS;
    }

    Status = AtSubsystemInit(
        InitStages,
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
    }

    for (i = 0; i < NumData; i++)
    {
        if (TestData[i].Pathname)
        {
            Status = AcpiGetHandle (NULL, TestData[i].Pathname,
                &TestData[i].Object);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                    TestData[i].Pathname, AcpiFormatException(Status));
               return (Status);
            }
        }
        else
        {
            TestData[i].Object = ACPI_ROOT_OBJECT;
        }
    }

    if (CheckAction == 1)
    {
        /* Make Device handle invalid by unloading SSDT table*/
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
    }
    else if (CheckAction == 4)
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

    NotifyHandlerCounter = 0;
    NotifyHandlerMissCounter = 0;
    NotifyHandlerTestData.NumData = NumData;
    NotifyHandlerTestData.TestData = TestData;
    for (i = 0; i < NumData; i++)
    {
        if (!TestData[i].InstallFlag)
        {
            continue;
        }

        Object = TestData[i].Object;

        for (j = 0; j < TestData[i].NotifyHandlerNum; j++)
        {
            Type = TestData[i].HandlerType[j];
            Handler = TestData[i].Handler[j];
            Context = &TestData[i].Context[j];

            if (CheckAction == 2)
            {
                Type |= (ACPI_DEVICE_NOTIFY + ACPI_SYSTEM_NOTIFY + 1);
            }
            else if (CheckAction == 3)
            {
                Handler = NULL;
            }

            Status = AcpiInstallNotifyHandler(Object, Type, Handler, Context);

            if (Status != ExpectedStatus)
            {
                AapiErrors++;
                printf ("Api Error: AcpiInstallNotifyHandler(0x%p, %d, 0x%p, 0x%p)"
                    " returned %s, expected %s\n",
                    Object, Type, Handler, Context, AcpiFormatException(Status),
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
    }

    if (CheckAction == 4)
    {
        for (i = 0; i < NumData; i++)
        {
            if (!TestData[i].InstallFlag)
            {
                continue;
            }

            Object = TestData[i].Object;

            for (j = 0; j < TestData[i].NotifyHandlerNum; j++)
            {
                Type = (j)? ACPI_DEVICE_NOTIFY: ACPI_SYSTEM_NOTIFY;
                Handler = TestData[i].Handler[
                    (j + 1) % TestData[i].NotifyHandlerNum];
                Context = NULL;

                Status = AcpiInstallNotifyHandler(Object, Type, Handler, Context);
                if (Status != AE_ALREADY_EXISTS)
                {
                    AapiErrors++;
                    printf ("Api Error: AcpiInstallNotifyHandler(0x%p, %d, 0x%p, 0x%p)"
                        " returned %s, expected %s\n",
                        Object, Type, Handler, Context, AcpiFormatException(Status),
                        AcpiFormatException(AE_ALREADY_EXISTS));
                    return (AE_ERROR);
                }
            }
        }
    }

    if (CheckAction == 0)
    {
        Status = AcpiEvaluateObject (NULL, NotifyMethod, NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiEvaluateObject(%s) returned %s\n",
                NotifyMethod, AcpiFormatException(Status));
            return (Status);
        }

        for (i = 0; i < NumData; i++)
        {
            if (!TestData[i].Pathname)
            {
                continue;
            }

            for (j = 0; j < TestData[i].NumNotify; j++)
            {
                ExpectedNotifyHandlerCounter++;
                if (TestData[i].NotifyCount[j] != 1)
                {
                    AapiErrors++;
                    printf ("Api Error: %s, %d, Notify Handlers invoked %d times instead of 1\n",
                        TestData[i].Pathname, j, TestData[i].NotifyCount[j]);
                    return (AE_ERROR);
                }
            }
        }
    }

    if (NotifyHandlerCounter != ExpectedNotifyHandlerCounter)
    {
        AapiErrors++;
        printf ("Api Error: Notify Handlers invoked %d times instead of %d\n",
            NotifyHandlerCounter, ExpectedNotifyHandlerCounter);
        return (AE_ERROR);
    }

    if (NotifyHandlerMissCounter != 0)
    {
        AapiErrors++;
        printf ("Api Error: Notify Handlers unexpectedly invoked %d times\n",
            NotifyHandlerMissCounter);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0000:
 *
 */
ACPI_STATUS
AtHndlrTest0000(void)
{
    return (AtInstallNotifyHandlerCommon("\\TST0", NotifyTestData0000,
        sizeof (NotifyTestData0000) / sizeof (AT_NOTIFY_TEST_DATA),
        0, AE_OK));
}

/*
 * ASSERTION 0001:
 *
 */
ACPI_STATUS
AtHndlrTest0001(void)
{
    return (AtInstallNotifyHandlerCommon("\\TST0", NotifyTestData0001,
        sizeof (NotifyTestData0001) / sizeof (AT_NOTIFY_TEST_DATA),
        0, AE_OK));
}

/*
 * ASSERTION 0002:
 *
 */
ACPI_STATUS
AtHndlrTest0002(void)
{
    return (AtInstallNotifyHandlerCommon("\\TST0", NotifyTestDataSsdt,
        sizeof (NotifyTestDataSsdt) / sizeof (AT_NOTIFY_TEST_DATA),
        1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0003:
 *
 */
ACPI_STATUS
AtHndlrTest0003(void)
{
    return (AtInstallNotifyHandlerCommon("\\TST0", NotifyTestData0001,
        sizeof (NotifyTestData0001) / sizeof (AT_NOTIFY_TEST_DATA),
        2, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0004:
 *
 */
ACPI_STATUS
AtHndlrTest0004(void)
{
    return (AtInstallNotifyHandlerCommon("\\TST0", NotifyTestData0001,
        sizeof (NotifyTestData0001) / sizeof (AT_NOTIFY_TEST_DATA),
        3, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0005:
 *
 */
ACPI_STATUS
AtHndlrTest0005(void)
{
    return (AtInstallNotifyHandlerCommon("\\TST0", NotifyTestData0001,
        sizeof (NotifyTestData0001) / sizeof (AT_NOTIFY_TEST_DATA),
        4, AE_ALREADY_EXISTS));
}

/*
 * ASSERTION 0006:
 *
 */
ACPI_STATUS
AtHndlrTest0006(void)
{
    return (AtInstallNotifyHandlerCommon("\\TST0", NotifyTestData0006,
        sizeof (NotifyTestData0006) / sizeof (AT_NOTIFY_TEST_DATA),
        0, AE_TYPE));
}

ACPI_STATUS
AtInstallNotifyHandlerExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark,
    AT_NOTIFY_TEST_DATA    *TestData,
    UINT32                  NumData)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_HANDLE             Object;
    UINT32                  Type;
    ACPI_NOTIFY_HANDLER     Handler;
    void                    *Context;
    UINT32                  ii, jj;

    NotifyHandlerCounter = 0;
    NotifyHandlerMissCounter = 0;
    NotifyHandlerTestData.NumData = NumData;
    NotifyHandlerTestData.TestData = TestData;

    for (ii = 0; ii < NumData; ii++)
    {
        if (!TestData[ii].InstallFlag)
        {
            continue;
        }

        for (jj = 0; jj < TestData[ii].NotifyHandlerNum; jj++)
        {
            Continue_Cond = 1;
            for (i = TFst; (i < TMax) && Continue_Cond; i++)
            {
                printf ("AtInstallGpeBlockExceptionTest: ii = %d, jj = %d, i = %d\n",
                    ii, jj, i);

                Status = AtSubsystemInit(
                    AAPITS_INI_DEF & ~AAPITS_INSTALL_HS,
                    AAPITS_EN_FLAGS, AAPITS_OI_FLAGS, AtAMLcodeFileName);
                if (ACPI_FAILURE(Status))
                {
                    return (Status);
                }

                if (TestData[ii].Pathname)
                {
                    Status = AcpiGetHandle (NULL, TestData[ii].Pathname,
                        &TestData[ii].Object);
                    if (ACPI_FAILURE(Status))
                    {
                        AapiErrors++;
                        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                            TestData[ii].Pathname, AcpiFormatException(Status));
                        return (Status);
                    }
                }
                else
                {
                    TestData[ii].Object = ACPI_ROOT_OBJECT;
                }

                Object = TestData[ii].Object;
                Type = TestData[ii].HandlerType[jj];
                Handler = TestData[ii].Handler[jj];
                Context = &TestData[ii].Context[jj];

                Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
                if (ACPI_FAILURE(Status))
                {
                    TestErrors++;
                    printf ("Test error: OsxfCtrlSet returned %s\n",
                        AcpiFormatException(Status));
                    return (Status);
                }

                Status = AcpiInstallNotifyHandler(Object, Type, Handler, Context);

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
                        printf ("API Error: AcpiInstallNotifyHandler returned %s,\n"
                            "           expected to return %s\n",
                            AcpiFormatException(Status), AcpiFormatException(Benchmark));
                        return (AE_ERROR);
                    }
                }

                if (ACPI_SUCCESS(Status))
                {
                    Status = AcpiRemoveNotifyHandler(Object, Type, Handler);
                    if (ACPI_FAILURE(Status))
                    {
                        AapiErrors++;
                        printf ("API Error: AcpiRemoveNotifyHandler returned %s\n",
                            AcpiFormatException(Status));
                        return (Status);
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
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0007:
 */
ACPI_STATUS
AtHndlrTest0007(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hndl0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtInstallNotifyHandlerExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        NotifyTestData0000,
        sizeof (NotifyTestData0000) / sizeof (AT_NOTIFY_TEST_DATA));
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    Status = AtInstallNotifyHandlerExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        NotifyTestData0000,
        sizeof (NotifyTestData0000) / sizeof (AT_NOTIFY_TEST_DATA));
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

/*
 * ASSERTION 0008:
 */
ACPI_STATUS
AtHndlrTest0008(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hndl0000.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtInstallNotifyHandlerExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        NotifyTestData0001,
        sizeof (NotifyTestData0001) / sizeof (AT_NOTIFY_TEST_DATA));
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    Status = AtInstallNotifyHandlerExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        NotifyTestData0001,
        sizeof (NotifyTestData0001) / sizeof (AT_NOTIFY_TEST_DATA));
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

ACPI_STATUS
AtRemoveNotifyHandlerCommon(
    ACPI_STRING             NotifyMethod,
    AT_NOTIFY_TEST_DATA    *TestData,
    UINT32                  NumData,
    UINT32                  CheckAction,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Object;
    UINT32                  Type;
    ACPI_NOTIFY_HANDLER     Handler;
    void                    *Context;
    UINT32                  i, j;
    UINT32                  InitStages = AAPITS_INI_DEF & ~AAPITS_INSTALL_HS;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hndl0000.aml")))
    {
        return (Status);
    }

    if (CheckAction == 1)
    {
        InitStages |= AAPITS_INSTALL_HS;
    }

    Status = AtSubsystemInit(
        InitStages,
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
    }

    for (i = 0; i < NumData; i++)
    {
        if (TestData[i].Pathname)
        {
            Status = AcpiGetHandle (NULL, TestData[i].Pathname,
                &TestData[i].Object);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                    TestData[i].Pathname, AcpiFormatException(Status));
                return (Status);
            }
        }
        else
        {
            TestData[i].Object = ACPI_ROOT_OBJECT;
        }
    }

    NotifyHandlerCounter = 0;
    NotifyHandlerMissCounter = 0;
    NotifyHandlerTestData.NumData = NumData;
    NotifyHandlerTestData.TestData = TestData;
    if (CheckAction != 4)
    {
        for (i = 0; i < NumData; i++)
        {
            if (!TestData[i].InstallFlag)
            {
                continue;
            }

            Object = TestData[i].Object;

            for (j = 0; j < TestData[i].NotifyHandlerNum; j++)
            {
                Type = TestData[i].HandlerType[j];
                Handler = TestData[i].Handler[j];
                Context = &TestData[i].Context[j];

                Status = AcpiInstallNotifyHandler(Object, Type, Handler, Context);

                if (ACPI_FAILURE(Status))
                {
                    AapiErrors++;
                    printf ("Api Error: AcpiInstallNotifyHandler(0x%p, %d, 0x%p, 0x%p)"
                        " returned %s\n",
                        Object, Type, Handler, Context, AcpiFormatException(Status));
                    return (Status);
                }
            }
        }
    }

    if (CheckAction == 1)
    {
        /* Make Device handle invalid by unloading SSDT table*/
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
    }

    for (i = 0; i < NumData; i++)
    {
        if (!TestData[i].InstallFlag)
        {
            continue;
        }

        Object = TestData[i].Object;

        for (j = 0; j < TestData[i].NotifyHandlerNum; j++)
        {
            Type = TestData[i].HandlerType[j];
            Handler = TestData[i].Handler[j];

            if (CheckAction == 2)
            {
                Type |= (ACPI_DEVICE_NOTIFY + ACPI_SYSTEM_NOTIFY + 1);
            }
            else if (CheckAction == 3)
            {
                Handler = NULL;
            }
            else if (CheckAction == 5)
            {
                Handler = AtNotifyHandler5;
            }

            Status = AcpiRemoveNotifyHandler(Object, Type, Handler);

            if (Status != ExpectedStatus)
            {
                AapiErrors++;
                printf ("Api Error: AcpiRemoveNotifyHandler(0x%p, %d, 0x%p)"
                    " returned %s, expected %s\n",
                    Object, Type, Handler, AcpiFormatException(Status),
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
    }

    if (CheckAction == 0)
    {
        Status = AcpiEvaluateObject (NULL, NotifyMethod, NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiEvaluateObject(%s) returned %s\n",
                NotifyMethod, AcpiFormatException(Status));
            return (Status);
        }

        for (i = 0; i < NumData; i++)
        {
            if (!TestData[i].Pathname)
            {
                continue;
            }

            for (j = 0; j < TestData[i].NumNotify; j++)
            {
                if (TestData[i].NotifyCount[j] != 0)
                {
                    AapiErrors++;
                    printf ("Api Error: %s, %d, Notify Handlers invoked %d times\n",
                        TestData[i].Pathname, j, TestData[i].NotifyCount[j]);
                    return (AE_ERROR);
                }
            }
        }
    }

    if (NotifyHandlerCounter != 0)
    {
        AapiErrors++;
        printf ("Api Error: Notify Handlers invoked %d times\n",
            NotifyHandlerCounter);
        return (AE_ERROR);
    }

    if (NotifyHandlerMissCounter != 0)
    {
        AapiErrors++;
        printf ("Api Error: Notify Handlers unexpectedly invoked %d times\n",
            NotifyHandlerMissCounter);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0009:
 *
 */
ACPI_STATUS
AtHndlrTest0009(void)
{
    return (AtRemoveNotifyHandlerCommon("\\TST0", NotifyTestData0000,
        sizeof (NotifyTestData0000) / sizeof (AT_NOTIFY_TEST_DATA),
        0, AE_OK));
}

/*
 * ASSERTION 0010:
 *
 */
ACPI_STATUS
AtHndlrTest0010(void)
{
    return (AtRemoveNotifyHandlerCommon("\\TST0", NotifyTestData0001,
        sizeof (NotifyTestData0001) / sizeof (AT_NOTIFY_TEST_DATA),
        0, AE_OK));
}

/*
 * ASSERTION 0011:
 *
 */
ACPI_STATUS
AtHndlrTest0011(void)
{
    return (AtRemoveNotifyHandlerCommon("\\TST0", NotifyTestDataSsdt,
        sizeof (NotifyTestDataSsdt) / sizeof (AT_NOTIFY_TEST_DATA),
        1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0012:
 *
 */
ACPI_STATUS
AtHndlrTest0012(void)
{
    return (AtRemoveNotifyHandlerCommon("\\TST0", NotifyTestData0001,
        sizeof (NotifyTestData0001) / sizeof (AT_NOTIFY_TEST_DATA),
        2, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0013:
 *
 */
ACPI_STATUS
AtHndlrTest0013(void)
{
    return (AtRemoveNotifyHandlerCommon("\\TST0", NotifyTestData0001,
        sizeof (NotifyTestData0001) / sizeof (AT_NOTIFY_TEST_DATA),
        3, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0014:
 *
 */
ACPI_STATUS
AtHndlrTest0014(void)
{
    return (AtRemoveNotifyHandlerCommon("\\TST0", NotifyTestData0001,
        sizeof (NotifyTestData0001) / sizeof (AT_NOTIFY_TEST_DATA),
        4, AE_NOT_EXIST));
}

/*
 * ASSERTION 0015:
 *
 */
ACPI_STATUS
AtHndlrTest0015(void)
{
    return (AtRemoveNotifyHandlerCommon("\\TST0", NotifyTestData0001,
        sizeof (NotifyTestData0001) / sizeof (AT_NOTIFY_TEST_DATA),
        5, AE_BAD_PARAMETER));
}

#define AT_NUM_ADR_SPACE_ID   7
#define AT_NUM_ADR_SPACE_ACC  10

typedef struct at_adr_space_inst_data
{
    ACPI_ADR_SPACE_TYPE     SpaceId;
    ACPI_ADR_SPACE_HANDLER  Handler;
    ACPI_ADR_SPACE_SETUP    Setup;
    UINT32                  Context;
    UINT32                  NumSetup;
    /* Counters */
    UINT32                  SetupInd;
    UINT32                  SetupErr;
} AT_ADR_SPACE_INST_DATA;

typedef struct at_adr_space_acc_data
{
    ACPI_STRING             RegionName;
    UINT32                  RegionSpace;
    UINT32                  Offset;
    UINT32                  Length;
    UINT32                  FieldSize;
    UINT32                  Width;
    UINT32                  NumAcc;
    ACPI_HANDLE             Object;
    /* Counters */
    ACPI_PHYSICAL_ADDRESS   AccAdr;
    UINT32                  AccInd;
    UINT32                  AccErr;
    UINT32                  AccSetupInd;
    UINT32                  AccSetupErr;
} AT_ADR_SPACE_ACC_DATA;

typedef struct at_adr_space_test_data
{
    ACPI_STRING             Pathname;
    UINT32                  AdrSpaceHandlerNum;
    AT_ADR_SPACE_INST_DATA  InstData[AT_NUM_ADR_SPACE_ID];
    ACPI_HANDLE             Device;
} AT_ADR_SPACE_TEST_DATA;

typedef struct at_adr_space_handler_test_data
{
    UINT32                  NumData;
    AT_ADR_SPACE_TEST_DATA  *TestData;
    UINT32                  NumAcc;
    AT_ADR_SPACE_ACC_DATA   *AccData;
} AT_ADR_SPACE_HANDLER_TEST_DATA;

static UINT32               AdrSpaceHandlerCounter;

static AT_ADR_SPACE_HANDLER_TEST_DATA    AdrSpaceHandlerTestData;

ACPI_STATUS
AtAdrSpaceHandlerCommon (
    UINT32                  Function,
    ACPI_PHYSICAL_ADDRESS   Address,
    UINT32                  BitWidth,
    ACPI_INTEGER            *Value,
    void                    *HandlerContext,
    void                    *RegionContext,
    UINT32                  HandlerId)
{
    AT_ADR_SPACE_ACC_DATA   *AccData = NULL;
    UINT32                  i;

    ++AdrSpaceHandlerCounter;

    printf ("AtAdrSpaceHandler%d %d: Function 0x%x, Address 0x%x,\n"
        " BitWidth 0x%x, Value 0x%p (0x%.2x), Hc 0x%p, Rc 0x%p\n",
        HandlerId, AdrSpaceHandlerCounter, Function, (UINT32)Address, BitWidth,
        Value, (UINT32)*Value, HandlerContext, RegionContext);

    /* Check the call */
    for (i = 0; i < AdrSpaceHandlerTestData.NumAcc; i++)
    {
        AccData = &AdrSpaceHandlerTestData.AccData[i];
        if (HandlerId != AccData->RegionSpace)
        {
            continue;
        }
        if (RegionContext != AccData->Object)
        {
            continue;
        }
        if (AccData->AccInd++ == 0)
        {
            AccData->AccAdr = AccData->Offset;
        }
        else if (AccData->AccErr)
        {
            break;
        }
        if (Address != AccData->AccAdr)
        {
        }
        else if (Function == ACPI_WRITE)
        {
            /* The test specific prepearing to the next call check after writing */
            AccData->AccAdr += BitWidth / 8;
        }
        return (AE_OK);
    }

    printf ("AtAdrSpaceHandler%d %d (%d) error: *RegionContext 0x%p,\n"
        " does not appropriate any Region\n",
        HandlerId, AccData->AccInd, AdrSpaceHandlerCounter,
        RegionContext);
    AccData->AccErr++;

    return (AE_OK);
}

#define DEF_ADR_SPACE_HANDLER(Hid) \
ACPI_STATUS \
AtAdrSpaceHandler##Hid (\
    UINT32                  Function,\
    ACPI_PHYSICAL_ADDRESS   Address,\
    UINT32                  BitWidth,\
    ACPI_INTEGER            *Value,\
    void                    *HandlerContext,\
    void                    *RegionContext)\
{\
    return (AtAdrSpaceHandlerCommon(Function, Address, BitWidth,\
        Value, HandlerContext, RegionContext, Hid));\
}

DEF_ADR_SPACE_HANDLER(0)
DEF_ADR_SPACE_HANDLER(1)
DEF_ADR_SPACE_HANDLER(2)
DEF_ADR_SPACE_HANDLER(3)
DEF_ADR_SPACE_HANDLER(4)
DEF_ADR_SPACE_HANDLER(5)
DEF_ADR_SPACE_HANDLER(6)

static UINT32               AdrSpaceSetupCounter;

ACPI_STATUS
AtAdrSpaceSetupCommon (
    ACPI_HANDLE             RegionHandle,
    UINT32                  Function,
    void                    *HandlerContext,
    void                    **RegionContext,
    UINT32                  HandlerId)
{
    ACPI_STATUS             Status;
    AT_ADR_SPACE_INST_DATA  *InstData = NULL;
    AT_ADR_SPACE_ACC_DATA   *AccData;
    UINT32                  i, j;


    ++AdrSpaceSetupCounter;
    printf ("AtAdrSpaceSetup%d %d: RegionHandle 0x%p, Function 0x%x, Hc 0x%p, Rc 0x%p\n",
        HandlerId, AdrSpaceSetupCounter, RegionHandle, Function,
        HandlerContext, RegionContext);

    *RegionContext = NULL;

    /* Check the call */
    for (i = 0; i < AdrSpaceHandlerTestData.NumData; i++)
    {
        for (j = 0; j < AdrSpaceHandlerTestData.TestData[i].AdrSpaceHandlerNum; j++)
        {
            InstData = &AdrSpaceHandlerTestData.TestData[i].InstData[j];
            if (HandlerId != InstData->SpaceId)
            {
                continue;
            }
            if (InstData->SetupErr)
            {
                break;
            }
            InstData->SetupInd++;
            if (HandlerContext != &InstData->Context)
            {
                printf ("AtAdrSpaceSetup%d %d (%d) error: Passed Context"
                    " 0x%p is not expected one 0x%p\n",
                    HandlerId, InstData->SetupInd, AdrSpaceHandlerCounter,
                    HandlerContext, &InstData->Context);
                InstData->SetupErr++;
            }
            break;
        }
    }

    if (!InstData)
    {
        printf ("AtAdrSpaceSetup%d (%d) error: there is no"
            " appropriate setup data\n",
            HandlerId, AdrSpaceHandlerCounter);
        return (AE_ERROR);
    }

    for (i = 0; i < AdrSpaceHandlerTestData.NumAcc; i++)
    {
        AccData = &AdrSpaceHandlerTestData.AccData[i];
        if (HandlerId != AccData->RegionSpace)
        {
            continue;
        }
        if (!AccData->Object)
        {
            /* Dynamic OpRegion */
            Status = AcpiGetHandle (NULL, AccData->RegionName,
                &AccData->Object);
            if (ACPI_FAILURE(Status))
            {
                AccData->AccSetupErr++;
                printf ("AtAdrSpaceSetup%d (%d) error: AcpiGetHandle(%s)"
                    "  returned %s\n",
                    HandlerId, AdrSpaceHandlerCounter,
                    AccData->RegionName, AcpiFormatException(Status));
                continue;
            }
            else if (AT_SKIP_ADR_SPACE_SETUP_HANDLER_CHECK)
            {
                /* Should be the actual Region object */
                AccData->Object = (void *)
                    ((ACPI_NAMESPACE_NODE *) AccData->Object)->Object;
            }
        }
        if (RegionHandle != AccData->Object)
        {
            continue;
        }

        AccData->AccSetupInd++;

        if ((AccData->AccSetupInd % 2 == 0) && Function != ACPI_REGION_DEACTIVATE)
        {
            printf ("AtAdrSpaceAccSetup%d %d (%d) error: Passed Function\n"
                " (0x%x) is not ACPI_REGION_DEACTIVATE\n",
                HandlerId, AccData->AccSetupInd, AdrSpaceHandlerCounter,
                Function);
            AccData->AccSetupErr++;
        }
        else if ((AccData->AccSetupInd % 2 == 1) && Function != ACPI_REGION_ACTIVATE)
        {
            printf ("AtAdrSpaceAccSetup%d %d (%d) error: Passed Function\n"
                " (0x%x) is not ACPI_REGION_ACTIVATE\n",
                HandlerId, AccData->AccSetupInd, AdrSpaceHandlerCounter,
                Function);
            AccData->AccSetupErr++;
        }

        *RegionContext = RegionHandle;

        break;
    }

    if (!(*RegionContext))
    {
        printf ("AtAdrSpaceSetup%d (%d) error: there is no"
            " appropriate Region data\n",
            HandlerId, AdrSpaceHandlerCounter);
        InstData->SetupErr++;
    }

    return (AE_OK);
}

#define DEF_ADR_SPACE_SETUP(Hid) \
ACPI_STATUS \
AtAdrSpaceSetup##Hid (\
    ACPI_HANDLE             RegionHandle,\
    UINT32                  Function,\
    void                    *HandlerContext,\
    void                    **RegionContext)\
{\
    return (AtAdrSpaceSetupCommon(RegionHandle, Function,\
        HandlerContext, RegionContext, Hid));\
}

DEF_ADR_SPACE_SETUP(0)
DEF_ADR_SPACE_SETUP(1)
DEF_ADR_SPACE_SETUP(2)
DEF_ADR_SPACE_SETUP(3)
DEF_ADR_SPACE_SETUP(4)
DEF_ADR_SPACE_SETUP(5)
DEF_ADR_SPACE_SETUP(6)

static AT_ADR_SPACE_ACC_DATA    AdrSpaceAccData0000[] = {
    {"\\OPR0", 0, 0x00000, 0x10000, 70, 8},
    {"\\OPR1", 1, 0x21000, 0x11000, 71, 8},
    {"\\OPR2", 2, 0x32000, 0x12000, 72, 8},
    {"\\OPR3", 3, 0x45000, 0x13000, 73, 8},
    {"\\OPR4", 4, 0x69000, 0x14000, 74, 8},
    {"\\OPR5", 5, 0x83000, 0x15000, 75, 8},
    {"\\OPR6", 6, 0x98000, 0x16000, 76, 8},
};

static AT_ADR_SPACE_ACC_DATA    AdrSpaceAccData0001[] = {
    {"\\DEV0.OPR0", 0, 0x00000, 0x10000, 70, 8},
    {"\\DEV0.OPR1", 1, 0x21000, 0x11000, 71, 8},
    {"\\CPU0.OPR2", 2, 0x32000, 0x12000, 72, 8},
    {"\\CPU0.OPR3", 3, 0x45000, 0x13000, 73, 8},
    {"\\CPU0.OPR4", 4, 0x69000, 0x14000, 74, 8},
    {"\\TZN0.OPR5", 5, 0x83000, 0x15000, 75, 8},
    {"\\TZN0.OPR6", 6, 0x98000, 0x16000, 76, 8},
};

static AT_ADR_SPACE_ACC_DATA    AdrSpaceAccData0002[] = {
    {"\\OPR0", 0, 0x00000, 0x10000, 70, 8},
    {"\\OPR1", 1, 0x21000, 0x11000, 71, 8},
    {"\\OPR2", 2, 0x32000, 0x12000, 72, 8},
    {"\\OPR5", 5, 0x83000, 0x15000, 75, 8},
    {"\\OPR6", 6, 0x98000, 0x16000, 76, 8},
};

static AT_ADR_SPACE_ACC_DATA    AdrSpaceAccData0003[] = {
    {"\\DEV0.OPR0", 0, 0x00000, 0x10000, 70, 8},
    {"\\DEV0.OPR1", 1, 0x21000, 0x11000, 71, 8},
    {"\\CPU0.OPR2", 2, 0x32000, 0x12000, 72, 8},
    {"\\TZN0.OPR5", 5, 0x83000, 0x15000, 75, 8},
    {"\\TZN0.OPR6", 6, 0x98000, 0x16000, 76, 8},
};

static AT_ADR_SPACE_TEST_DATA   AdrSpaceTestData0000[] = {
    {
        NULL, 7 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},
        {1, AtAdrSpaceHandler1, AtAdrSpaceSetup1, 1,},
        {2, AtAdrSpaceHandler2, AtAdrSpaceSetup2, 2,},
        {3, AtAdrSpaceHandler3, AtAdrSpaceSetup3, 3,},
        {4, AtAdrSpaceHandler4, AtAdrSpaceSetup4, 4,},
        {5, AtAdrSpaceHandler5, AtAdrSpaceSetup5, 5,},
        {6, AtAdrSpaceHandler6, AtAdrSpaceSetup6, 6,},}
    },
};

static AT_ADR_SPACE_TEST_DATA   AdrSpaceTestData0002[] = {
    {
        NULL, 5 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},
        {1, AtAdrSpaceHandler1, AtAdrSpaceSetup1, 1,},
        {2, AtAdrSpaceHandler2, AtAdrSpaceSetup2, 2,},
        {5, AtAdrSpaceHandler5, AtAdrSpaceSetup5, 5,},
        {6, AtAdrSpaceHandler6, AtAdrSpaceSetup6, 6,},}
    },
};

static AT_ADR_SPACE_TEST_DATA   AdrSpaceTestData0001[] = {
    {
        "\\DEV0", 2 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},
        {1, AtAdrSpaceHandler1, AtAdrSpaceSetup1, 1,},}
    },
    {
        "\\CPU0", 3 /* AdrSpaceHandlerNum */,
        {{2, AtAdrSpaceHandler2, AtAdrSpaceSetup2, 2,},
        {3, AtAdrSpaceHandler3, AtAdrSpaceSetup3, 3,},
        {4, AtAdrSpaceHandler4, AtAdrSpaceSetup4, 4,},}
    },
    {
        "\\TZN0", 2 /* AdrSpaceHandlerNum */,
        {{5, AtAdrSpaceHandler5, AtAdrSpaceSetup5, 5,},
        {6, AtAdrSpaceHandler6, AtAdrSpaceSetup6, 6,},}
    },
};

static AT_ADR_SPACE_TEST_DATA  AdrSpaceTestData0003[] = {
    {
        "\\DEV0", 2 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},
        {1, AtAdrSpaceHandler1, AtAdrSpaceSetup1, 1,},}
    },
    {
        "\\CPU0", 1 /* AdrSpaceHandlerNum */,
        {{2, AtAdrSpaceHandler2, AtAdrSpaceSetup2, 2,},}
    },
    {
        "\\TZN0", 2 /* AdrSpaceHandlerNum */,
        {{5, AtAdrSpaceHandler5, AtAdrSpaceSetup5, 5,},
        {6, AtAdrSpaceHandler6, AtAdrSpaceSetup6, 6,},}
    },
};

static AT_ADR_SPACE_TEST_DATA   AdrSpaceTestData0004[] = {
    {
        "\\INT0", 1 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},}
    },
    {
        "\\STR0", 1 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},}
    },
    {
        "\\BUF0", 1 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},}
    },
    {
        "\\PAC0", 1 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},}
    },
    {
        "\\FLU0", 1 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},}
    },
    {
        "\\EVE0", 1 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},}
    },
    {
        "\\MMM0", 1 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},}
    },
    {
        "\\MTX0", 1 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},}
    },
    {
        "\\OPR0", 1 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},}
    },
    {
        "\\PWR0", 1 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},}
    },
    {
        "\\BUF0", 1 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},}
    },
};

static AT_ADR_SPACE_TEST_DATA   AdrSpaceTestData0005[] = {
    {
        "\\CPU0", 2 /* AdrSpaceHandlerNum */,
        {{3, NULL, NULL, 3,},
        {4, NULL, NULL, 4,},}
    },
};

static AT_ADR_SPACE_TEST_DATA   AdrSpaceTestDataSsdt[] = {
    {
        "\\AUX2.DEV0", 2 /* AdrSpaceHandlerNum */,
        {{0, AtAdrSpaceHandler0, AtAdrSpaceSetup0, 0,},
        {1, AtAdrSpaceHandler1, AtAdrSpaceSetup1, 1,},}
    },
};

ACPI_STATUS
AtInstallAdrSpaceHandlerCommon(
    AT_ADR_SPACE_TEST_DATA  *TestData,
    UINT32                  NumData,
    ACPI_STRING             AdrSpaceMethod,
    AT_ADR_SPACE_ACC_DATA   *AccData,
    UINT32                  NumAcc,
    UINT32                  CheckAction,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Device;
    ACPI_ADR_SPACE_TYPE     SpaceId;
    ACPI_ADR_SPACE_HANDLER  Handler;
    ACPI_ADR_SPACE_SETUP    Setup;
    void                    *Context;
    UINT32                  i, j, ii;
    UINT32                  ExpectedAdrSpaceHandlerCounter = 0;
    UINT32                  ExpectedAdrSpaceSetupCounter = 0;
    UINT32                  InitStages = AAPITS_INI_DEF & ~AAPITS_INSTALL_HS;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hndl0016.aml")))
    {
        return (Status);
    }

    if (CheckAction == 1)
    {
        InitStages |= AAPITS_INSTALL_HS;
    }

    Status = AtSubsystemInit(
        InitStages,
        AAPITS_EN_FLAGS | ACPI_NO_ADDRESS_SPACE_INIT,
        AAPITS_OI_FLAGS, AtAMLcodeFileName);
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
    }

    for (i = 0; i < NumData; i++)
    {
        if (TestData[i].Pathname)
        {
            Status = AcpiGetHandle (NULL, TestData[i].Pathname,
                &TestData[i].Device);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                    TestData[i].Pathname, AcpiFormatException(Status));
                return (Status);
            }
        }
        else
        {
            TestData[i].Device = ACPI_ROOT_OBJECT;
        }
    }

    if (CheckAction == 0)
    {
        for (i = 0; i < NumAcc; i++)
        {
            Status = AcpiGetHandle (NULL, AccData[i].RegionName,
                &AccData[i].Object);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                    AccData[i].RegionName, AcpiFormatException(Status));
                return (Status);
            }
            else if (AT_SKIP_ADR_SPACE_SETUP_HANDLER_CHECK)
            {
                /* Should be the actual Region object */
                AccData[i].Object = ((ACPI_NAMESPACE_NODE *)AccData[i].Object)->
                    Object->CommonField.RegionObj;
            }
            if (AccData[i].RegionSpace == 4 /* SMBus */)
            {
                AccData[i].NumAcc = 1;
            }
            else
            {
                AccData[i].NumAcc = (AccData[i].FieldSize +
                    AccData[i].Width - 1) / AccData[i].Width;
                if (AccData[i].FieldSize % AccData[i].Width)
                {   /* Write operation as read/write */
                    AccData[i].NumAcc++;
                }
            }
            ExpectedAdrSpaceHandlerCounter += AccData[i].NumAcc;
        }
    }

    if (CheckAction == 1)
    {
        /* Make Device handle invalid by unloading SSDT table*/
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
    }
    else if (CheckAction == 4)
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

    AdrSpaceHandlerCounter = 0;
    AdrSpaceSetupCounter = 0;
    AdrSpaceHandlerTestData.NumData = NumData;
    AdrSpaceHandlerTestData.TestData = TestData;
    AdrSpaceHandlerTestData.NumAcc = NumAcc;
    AdrSpaceHandlerTestData.AccData = AccData;
    for (i = 0; i < NumData; i++)
    {
        Device = TestData[i].Device;

        for (j = 0; j < TestData[i].AdrSpaceHandlerNum; j++)
        {
            SpaceId = TestData[i].InstData[j].SpaceId;
            Handler = TestData[i].InstData[j].Handler;
            Setup = TestData[i].InstData[j].Setup;
            Context = &TestData[i].InstData[j].Context;

            if (CheckAction == 0 && !(Setup == ACPI_DEFAULT_HANDLER))
            {
                TestData[i].InstData[j].NumSetup = 1;
                ExpectedAdrSpaceSetupCounter += TestData[i].InstData[j].NumSetup;
                for (ii = 0; ii < NumAcc; ii++)
                {
                    if (SpaceId == AccData[ii].RegionSpace)
                    {
                        break;
                    }
                }
            }

            if (CheckAction == 2)
            {
                SpaceId += 16;
            }
            else if (CheckAction == 3)
            {
                Handler = NULL;
            }
            else if (CheckAction == 5)
            {
                Handler = ACPI_DEFAULT_HANDLER;
            }

            Status = AcpiInstallAddressSpaceHandler(Device, SpaceId,
                Handler, Setup, Context);

            if (Status != ExpectedStatus)
            {
                AapiErrors++;
                printf ("Api Error: AcpiInstallAddressSpaceHandler(0x%p, %d, 0x%p, 0x%p)"
                    " returned %s, expected %s\n",
                    Device, SpaceId, Handler, Setup, AcpiFormatException(Status),
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
    }

    if (CheckAction == 4)
    {
        for (i = 0; i < NumData; i++)
        {
            Device = TestData[i].Device;

            for (j = 0; j < TestData[i].AdrSpaceHandlerNum; j++)
            {
                SpaceId = TestData[i].InstData[j].SpaceId;
                Handler = TestData[i].InstData[(j + 1) %
                    TestData[i].AdrSpaceHandlerNum].Handler;
                Setup = TestData[i].InstData[(j + 1) %
                    TestData[i].AdrSpaceHandlerNum].Setup;
                Context = NULL;

                Status = AcpiInstallAddressSpaceHandler(Device, SpaceId,
                    Handler, Setup, Context);
                if (Status != AE_ALREADY_EXISTS)
                {
                    AapiErrors++;
                    printf ("Api Error: AcpiInstallAdrSpaceHandler(0x%p, %d, 0x%p, 0x%p)"
                        " returned %s, expected %s\n",
                        Device, SpaceId, Handler, Setup, AcpiFormatException(Status),
                        AcpiFormatException(AE_ALREADY_EXISTS));
                    return (AE_ERROR);
                }
            }
        }
    }

//    if (CheckAction == 0 && AdrSpaceMethod)
    if (AdrSpaceMethod)
    {
        Status = AcpiEvaluateObject (NULL, AdrSpaceMethod, NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiEvaluateObject(%s) returned %s\n",
                AdrSpaceMethod, AcpiFormatException(Status));
            return (Status);
        }

        /* Unload DSDT table to initiate the OpRegions deletion */
/*
        TestSkipped++;
        printf ("Test note: test actions not implemented\n");
        return (AE_ERROR);
*/
        for (i = 0; i < NumData; i++)
        {
            for (j = 0; j < TestData[i].AdrSpaceHandlerNum; j++)
            {
                if (TestData[i].InstData[j].SetupInd !=
                    TestData[i].InstData[j].NumSetup)
                {
                    AapiErrors++;
                    printf ("Api Error: %d Setup Handler number of calls %d"
                        " is not expected %d\n",
                        TestData[i].InstData[j].SpaceId,
                        TestData[i].InstData[j].SetupInd,
                        TestData[i].InstData[j].NumSetup);
                }
                if (TestData[i].InstData[j].SetupErr)
                {
                    AapiErrors++;
                    printf ("Api Error: in %d Setup Handler encountered %d errors\n",
                        TestData[i].InstData[j].SpaceId,
                        TestData[i].InstData[j].SetupErr);
                }
            }
        }

        for (i = 0; i < NumAcc; i++)
        {
            if (AccData[i].AccSetupErr)
            {
                AapiErrors++;
                printf ("Api Error: for %s Setup Handler encountered %d errors\n",
                    AccData[i].RegionName, AccData[i].AccSetupErr);
            }
            if (AccData[i].AccInd != AccData[i].NumAcc)
            {
                AapiErrors++;
                printf ("Api Error: %s Acc Handler number of calls %d"
                    " is not expected %d\n",
                    AccData[i].RegionName, AccData[i].AccInd, AccData[i].NumAcc);
            }
            if (AccData[i].AccErr)
            {
                AapiErrors++;
                printf ("Api Error: in %s Acc Handler encountered %d errors\n",
                    AccData[i].RegionName, AccData[i].AccErr);
            }
        }
    }

    if (AdrSpaceHandlerCounter != ExpectedAdrSpaceHandlerCounter)
    {
        AapiErrors++;
        printf ("Api Error: AdrSpace Handlers invoked %d times instead of %d\n",
            AdrSpaceHandlerCounter, ExpectedAdrSpaceHandlerCounter);
        return (AE_ERROR);
    }

    if (AdrSpaceSetupCounter != ExpectedAdrSpaceSetupCounter)
    {
        AapiErrors++;
        printf ("Api Error: AdrSpace Setup invoked %d times instead of %d\n",
            AdrSpaceSetupCounter, ExpectedAdrSpaceSetupCounter);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0016:
 *
 */
ACPI_STATUS
AtHndlrTest0016(void)
{
    return (AtInstallAdrSpaceHandlerCommon(AdrSpaceTestData0000,
        sizeof (AdrSpaceTestData0000) / sizeof (AT_ADR_SPACE_TEST_DATA),
        "\\TST0", AdrSpaceAccData0000,
        sizeof (AdrSpaceAccData0000) / sizeof (AT_ADR_SPACE_ACC_DATA),
        0, AE_OK));
}

/*
 * ASSERTION 0017:
 *
 */
ACPI_STATUS
AtHndlrTest0017(void)
{
    return (AtInstallAdrSpaceHandlerCommon(AdrSpaceTestData0001,
        sizeof (AdrSpaceTestData0001) / sizeof (AT_ADR_SPACE_TEST_DATA),
        "\\TST1", AdrSpaceAccData0001,
        sizeof (AdrSpaceAccData0001) / sizeof (AT_ADR_SPACE_ACC_DATA),
        0, AE_OK));
}

/*
 * ASSERTION 0018:
 *
 */
ACPI_STATUS
AtHndlrTest0018(void)
{
    return (AtInstallAdrSpaceHandlerCommon(AdrSpaceTestData0002,
        sizeof (AdrSpaceTestData0002) / sizeof (AT_ADR_SPACE_TEST_DATA),
        "\\TST2", AdrSpaceAccData0002,
        sizeof (AdrSpaceAccData0002) / sizeof (AT_ADR_SPACE_ACC_DATA),
        5, AE_OK));
}

/*
 * ASSERTION 0019:
 *
 */
ACPI_STATUS
AtHndlrTest0019(void)
{
    return (AtInstallAdrSpaceHandlerCommon(AdrSpaceTestData0003,
        sizeof (AdrSpaceTestData0003) / sizeof (AT_ADR_SPACE_TEST_DATA),
        "\\TST3", AdrSpaceAccData0003,
        sizeof (AdrSpaceAccData0003) / sizeof (AT_ADR_SPACE_ACC_DATA),
        5, AE_OK));
}

/*
 * ASSERTION 0020:
 *
 */
ACPI_STATUS
AtHndlrTest0020(void)
{
    return (AtInstallAdrSpaceHandlerCommon(AdrSpaceTestData0004,
        sizeof (AdrSpaceTestData0004) / sizeof (AT_ADR_SPACE_TEST_DATA),
        NULL, NULL, 0,
        6, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0021:
 *
 */
ACPI_STATUS
AtHndlrTest0021(void)
{
    return (AtInstallAdrSpaceHandlerCommon(AdrSpaceTestDataSsdt,
        sizeof (AdrSpaceTestDataSsdt) / sizeof (AT_ADR_SPACE_TEST_DATA),
        NULL, NULL, 0,
        1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0022:
 *
 */
ACPI_STATUS
AtHndlrTest0022(void)
{
    return (AtInstallAdrSpaceHandlerCommon(AdrSpaceTestData0001,
        sizeof (AdrSpaceTestData0001) / sizeof (AT_ADR_SPACE_TEST_DATA),
        NULL, NULL, 0,
        2, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0023:
 *
 */
ACPI_STATUS
AtHndlrTest0023(void)
{
    return (AtInstallAdrSpaceHandlerCommon(AdrSpaceTestData0001,
        sizeof (AdrSpaceTestData0001) / sizeof (AT_ADR_SPACE_TEST_DATA),
        NULL, NULL, 0,
        3, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0024:
 *
 */
ACPI_STATUS
AtHndlrTest0024(void)
{
    return (AtInstallAdrSpaceHandlerCommon(AdrSpaceTestData0001,
        sizeof (AdrSpaceTestData0001) / sizeof (AT_ADR_SPACE_TEST_DATA),
        NULL, NULL, 0,
        4, AE_ALREADY_EXISTS));
}

/*
 * ASSERTION 0025:
 *
 */
ACPI_STATUS
AtHndlrTest0025(void)
{
    return (AtInstallAdrSpaceHandlerCommon(AdrSpaceTestData0005,
        sizeof (AdrSpaceTestData0005) / sizeof (AT_ADR_SPACE_TEST_DATA),
        NULL, NULL, 0,
        5, AE_NOT_EXIST));
}

ACPI_STATUS
AtInstallAddressSpaceHandlerExceptionTest(
    ACPI_OSXF               OsxfNum,
    AT_ACTD_FLAG            ActFlag,
    UINT32                  ActCode,
    UINT32                  TFst,
    ACPI_STATUS             Benchmark,
    AT_ADR_SPACE_TEST_DATA  *TestData,
    UINT32                  NumData)
{
    ACPI_STATUS             Status;
    ACPI_OSXF               OsxfNumAct;
    UINT32                  Continue_Cond;
    UINT32                  TMax = 10000;
    UINT32                  i;
    ACPI_HANDLE             Device;
    ACPI_ADR_SPACE_TYPE     SpaceId;
    ACPI_ADR_SPACE_HANDLER  Handler;
    ACPI_ADR_SPACE_SETUP    Setup;
    void                    *Context;
    UINT32                  ii, jj;

    AdrSpaceHandlerCounter = 0;
    AdrSpaceSetupCounter = 0;
    AdrSpaceHandlerTestData.NumData = NumData;
    AdrSpaceHandlerTestData.TestData = TestData;
    AdrSpaceHandlerTestData.NumAcc = 0;
    AdrSpaceHandlerTestData.AccData = NULL;

    for (ii = 0; ii < NumData; ii++)
    {
        for (jj = 2; jj < TestData[ii].AdrSpaceHandlerNum; jj++)
        {
            Continue_Cond = 1;

            for (i = TFst; (i < TMax) && Continue_Cond; i++)
            {
                printf ("AtInstallGpeBlockExceptionTest: ii = %d, jj = %d, i = %d\n",
                    ii, jj, i);

                Status = AtSubsystemInit(
                    AAPITS_INI_DEF & ~AAPITS_INSTALL_HS,
                    AAPITS_EN_FLAGS | ACPI_NO_ADDRESS_SPACE_INIT,
                    AAPITS_OI_FLAGS, AtAMLcodeFileName);
                if (ACPI_FAILURE(Status))
                {
                    return (Status);
                }

                if (TestData[ii].Pathname)
                {
                    Status = AcpiGetHandle (NULL, TestData[ii].Pathname,
                        &TestData[ii].Device);
                    if (ACPI_FAILURE(Status))
                    {
                        AapiErrors++;
                        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                            TestData[ii].Pathname, AcpiFormatException(Status));
                        return (Status);
                    }
                }
                else
                {
                    TestData[ii].Device = ACPI_ROOT_OBJECT;
                }

                Device = TestData[ii].Device;

                SpaceId = TestData[ii].InstData[jj].SpaceId;
                Handler = TestData[ii].InstData[jj].Handler;
                Setup = TestData[ii].InstData[jj].Setup;
                Context = &TestData[ii].InstData[jj].Context;

                Status = OsxfCtrlSet(OsxfNum, i, ActFlag, ActCode);
                if (ACPI_FAILURE(Status))
                {
                    TestErrors++;
                    printf ("Test error: OsxfCtrlSet returned %s\n",
                        AcpiFormatException(Status));
                    return (Status);
                }

                Status = AcpiInstallAddressSpaceHandler(Device, SpaceId,
                    Handler, Setup, Context);

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
                        printf ("API Error: AcpiInstallAddressSpaceHandler returned %s,\n"
                            "           expected to return %s\n",
                            AcpiFormatException(Status), AcpiFormatException(Benchmark));
                        return (AE_ERROR);
                    }
                }

                if (ACPI_SUCCESS(Status))
                {
                    Status = AcpiRemoveAddressSpaceHandler(Device, SpaceId, Handler);
                    if (ACPI_FAILURE(Status))
                    {
                        AapiErrors++;
                        printf ("API Error: AcpiRemoveAddressSpaceHandler returned %s\n",
                            AcpiFormatException(Status));
                        return (Status);
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
        }
    }

    return (AE_OK);
}

/*
 * ASSERTION 0026:
 */
ACPI_STATUS
AtHndlrTest0026(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hndl0016.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtInstallAddressSpaceHandlerExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 35,
        AE_NO_MEMORY,
        AdrSpaceTestData0000,
        sizeof (AdrSpaceTestData0000) / sizeof (AT_ADR_SPACE_TEST_DATA));
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }
    return (AE_OK);

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    Status = AtInstallAddressSpaceHandlerExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        AdrSpaceTestData0000,
        sizeof (AdrSpaceTestData0000) / sizeof (AT_ADR_SPACE_TEST_DATA));
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}


/*
 * ASSERTION 0027:
 */
ACPI_STATUS
AtHndlrTest0027(void)
{
    ACPI_STATUS             Status;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hndl0016.aml")))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL permanently since the specified call
     */
    Status = AtInstallAddressSpaceHandlerExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_Permanent, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        AdrSpaceTestData0001,
        sizeof (AdrSpaceTestData0001) / sizeof (AT_ADR_SPACE_TEST_DATA));
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    /*
     * AcpiOsAllocate returns NULL one time on the specified call
     */
    Status = AtInstallAddressSpaceHandlerExceptionTest(
        OSXF_NUM(AcpiOsAllocate),
        AtActD_OneTime, AtActRet_NULL, 1,
        AE_NO_MEMORY,
        AdrSpaceTestData0001,
        sizeof (AdrSpaceTestData0001) / sizeof (AT_ADR_SPACE_TEST_DATA));
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    return (AE_OK);
}

ACPI_STATUS
AtRemoveAdrSpaceHandlerCommon(
    AT_ADR_SPACE_TEST_DATA  *TestData,
    UINT32                  NumData,
    ACPI_STRING             AdrSpaceMethod,
    AT_ADR_SPACE_ACC_DATA   *AccData,
    UINT32                  NumAcc,
    UINT32                  CheckAction,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Device;
    ACPI_ADR_SPACE_TYPE     SpaceId;
    ACPI_ADR_SPACE_HANDLER  Handler;
    ACPI_ADR_SPACE_SETUP    Setup;
    void                    *Context;
    UINT32                  i, j, ii;
    UINT32                  ExpectedAdrSpaceHandlerCounter = 0;
    UINT32                  ExpectedAdrSpaceSetupCounter = 0;
    UINT32                  InitStages = AAPITS_INI_DEF & ~AAPITS_INSTALL_HS;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hndl0016.aml")))
    {
        return (Status);
    }

    if (CheckAction == 1)
    {
        InitStages |= AAPITS_INSTALL_HS;
    }

    Status = AtSubsystemInit(
        InitStages,
        AAPITS_EN_FLAGS | ACPI_NO_ADDRESS_SPACE_INIT,
        AAPITS_OI_FLAGS, AtAMLcodeFileName);
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
    }

    for (i = 0; i < NumData; i++)
    {
        if (TestData[i].Pathname)
        {
            Status = AcpiGetHandle (NULL, TestData[i].Pathname,
                &TestData[i].Device);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                    TestData[i].Pathname, AcpiFormatException(Status));
                return (Status);
            }
        }
        else
        {
            TestData[i].Device = ACPI_ROOT_OBJECT;
        }
    }

    if (CheckAction == 0)
    {
        for (i = 0; i < NumAcc; i++)
        {
            Status = AcpiGetHandle (NULL, AccData[i].RegionName,
                &AccData[i].Object);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                    AccData[i].RegionName, AcpiFormatException(Status));
                return (Status);
            }
            AccData[i].NumAcc = 0;
            ExpectedAdrSpaceHandlerCounter += AccData[i].NumAcc;
        }
    }

    AdrSpaceHandlerCounter = 0;
    AdrSpaceSetupCounter = 0;
    AdrSpaceHandlerTestData.NumData = NumData;
    AdrSpaceHandlerTestData.TestData = TestData;
    AdrSpaceHandlerTestData.NumAcc = NumAcc;
    AdrSpaceHandlerTestData.AccData = AccData;
    for (i = 0; i < NumData; i++)
    {
        Device = TestData[i].Device;

        for (j = 0; j < TestData[i].AdrSpaceHandlerNum; j++)
        {
            SpaceId = TestData[i].InstData[j].SpaceId;
            Handler = TestData[i].InstData[j].Handler;
            Setup = TestData[i].InstData[j].Setup;
            Context = &TestData[i].InstData[j].Context;

            if (CheckAction == 0)
            {
                TestData[i].InstData[j].NumSetup = 0;
                ExpectedAdrSpaceSetupCounter += TestData[i].InstData[j].NumSetup;
                for (ii = 0; ii < NumAcc; ii++)
                {
                    if (SpaceId == AccData[ii].RegionSpace)
                    {
                        break;
                    }
                }
            }

            if (CheckAction == 5)
            {
                Handler = ACPI_DEFAULT_HANDLER;
            }

            if (CheckAction != 6)
            {
                Status = AcpiInstallAddressSpaceHandler(Device, SpaceId,
                    Handler, Setup, Context);

                if (ACPI_FAILURE(Status))
                {
                    AapiErrors++;
                    printf ("Api Error: AcpiInstallAddressSpaceHandler"
                        "(0x%p, %d, 0x%p, 0x%p) returned %s\n",
                        Device, SpaceId, Handler, Setup,
                        AcpiFormatException(Status));
                    return (Status);
                }
            }
        }
    }

    if (CheckAction == 1)
    {
        /* Make Device handle invalid by unloading SSDT table*/
        if (ACPI_FAILURE(Status = AtAuxiliarySsdt(AT_UNLOAD)))
        {
            return (Status);
        }
    }

    for (i = 0; i < NumData; i++)
    {
        Device = TestData[i].Device;

        for (j = 0; j < TestData[i].AdrSpaceHandlerNum; j++)
        {
            SpaceId = TestData[i].InstData[j].SpaceId;
            Handler = TestData[i].InstData[j].Handler;

            if (CheckAction == 2)
            {
                SpaceId += 16;
            }
            else if (CheckAction == 3)
            {
                Handler = NULL;
            }
            else if (CheckAction == 4)
            {
                Handler = TestData[i].InstData[(j + 1) %
                    TestData[i].AdrSpaceHandlerNum].Handler;
            }
            else if (CheckAction == 5)
            {
                Handler = ACPI_DEFAULT_HANDLER;
            }

            Status = AcpiRemoveAddressSpaceHandler(Device, SpaceId, Handler);

            if (CheckAction == 4)
            {
                Handler = TestData[i].InstData[(j + 1) %
                    TestData[i].AdrSpaceHandlerNum].Handler;
            }

            if (Status != ExpectedStatus)
            {
                AapiErrors++;
                printf ("Api Error: AcpiRemoveAddressSpaceHandler(0x%p, %d, 0x%p)"
                    " returned %s, expected %s\n",
                    Device, SpaceId, Handler, AcpiFormatException(Status),
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
            else if (Status == AE_OK)
            {
                Status = AcpiRemoveAddressSpaceHandler(Device, SpaceId, Handler);
                if (Status != AE_NOT_EXIST)
                {
                    AapiErrors++;
                    printf ("Api Error: AcpiRemoveAddressSpaceHandler(0x%p, %d, 0x%p)"
                        " returned %s, expected %s\n",
                        Device, SpaceId, Handler, AcpiFormatException(Status),
                        AcpiFormatException(AE_NOT_EXIST));
                    return (AE_ERROR);
                }
            }
            else if (CheckAction == 4)
            {
                Status = AcpiRemoveAddressSpaceHandler(Device, SpaceId,
                    TestData[i].InstData[j].Handler);
                if (ACPI_FAILURE(Status))
                {
                    AapiErrors++;
                    printf ("Api Error: AcpiRemoveAddressSpaceHandler(0x%p, %d, 0x%p)"
                        " returned %s, expected %s\n",
                        Device, SpaceId, TestData[i].InstData[j].Handler,
                        AcpiFormatException(Status),
                        AcpiFormatException(AE_NOT_EXIST));
                    return (Status);
                }
            }
        }
    }

    if (CheckAction == 0)
    {
        Status = AcpiEvaluateObject (NULL, AdrSpaceMethod, NULL, NULL);
        if (Status != AE_NOT_EXIST)
        {
            AapiErrors++;
            printf ("Api Error: AcpiEvaluateObject(%s) returned %s"
                " expected AE_NOT_EXIST\n",
                AdrSpaceMethod, AcpiFormatException(Status));
            return (Status);
        }

        for (i = 0; i < NumData; i++)
        {
            for (j = 0; j < TestData[i].AdrSpaceHandlerNum; j++)
            {
                if (TestData[i].InstData[j].SetupInd !=
                    TestData[i].InstData[j].NumSetup)
                {
                    AapiErrors++;
                    printf ("Api Error: %d Setup Handler number of calls %d"
                        " is not expected %d\n",
                        TestData[i].InstData[j].SpaceId,
                        TestData[i].InstData[j].SetupInd,
                        TestData[i].InstData[j].NumSetup);
                }
                if (TestData[i].InstData[j].SetupErr)
                {
                    AapiErrors++;
                    printf ("Api Error: in %d Setup Handler encountered %d errors\n",
                        TestData[i].InstData[j].SpaceId,
                        TestData[i].InstData[j].SetupErr);
                }
            }
        }

        for (i = 0; i < NumAcc; i++)
        {
            if (AccData[i].AccInd != AccData[i].NumAcc)
            {
                AapiErrors++;
                printf ("Api Error: %s Acc Handler number of calls %d"
                    " is not expected %d\n",
                    AccData[i].RegionName, AccData[i].AccInd, AccData[i].NumAcc);
            }
            if (AccData[i].AccErr)
            {
                AapiErrors++;
                printf ("Api Error: in %s Acc Handler encountered %d errors\n",
                    AccData[i].RegionName, AccData[i].AccErr);
            }
        }
    }

    if (AdrSpaceHandlerCounter != ExpectedAdrSpaceHandlerCounter)
    {
        AapiErrors++;
        printf ("Api Error: AdrSpace Handlers invoked %d times instead of %d\n",
            AdrSpaceHandlerCounter, ExpectedAdrSpaceHandlerCounter);
        return (AE_ERROR);
    }

    if (AdrSpaceSetupCounter != ExpectedAdrSpaceSetupCounter)
    {
        AapiErrors++;
        printf ("Api Error: AdrSpace Setup invoked %d times instead of %d\n",
            AdrSpaceSetupCounter, ExpectedAdrSpaceSetupCounter);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

/*
 * ASSERTION 0028:
 *
 */
ACPI_STATUS
AtHndlrTest0028(void)
{
    return (AtRemoveAdrSpaceHandlerCommon(AdrSpaceTestData0000,
        sizeof (AdrSpaceTestData0000) / sizeof (AT_ADR_SPACE_TEST_DATA),
        "\\TST0", AdrSpaceAccData0000,
        sizeof (AdrSpaceAccData0000) / sizeof (AT_ADR_SPACE_ACC_DATA),
        0, AE_OK));
}

/*
 * ASSERTION 0029:
 *
 */
ACPI_STATUS
AtHndlrTest0029(void)
{
    return (AtRemoveAdrSpaceHandlerCommon(AdrSpaceTestData0001,
        sizeof (AdrSpaceTestData0001) / sizeof (AT_ADR_SPACE_TEST_DATA),
        "\\TST1", AdrSpaceAccData0000,
        sizeof (AdrSpaceAccData0000) / sizeof (AT_ADR_SPACE_ACC_DATA),
        0, AE_OK));
}

/*
 * ASSERTION 0030:
 *
 */
ACPI_STATUS
AtHndlrTest0030(void)
{
    return (AtRemoveAdrSpaceHandlerCommon(AdrSpaceTestData0004,
        sizeof (AdrSpaceTestData0004) / sizeof (AT_ADR_SPACE_TEST_DATA),
        NULL, NULL, 0,
        6, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0031:
 *
 */
ACPI_STATUS
AtHndlrTest0031(void)
{
    return (AtRemoveAdrSpaceHandlerCommon(AdrSpaceTestDataSsdt,
        sizeof (AdrSpaceTestDataSsdt) / sizeof (AT_ADR_SPACE_TEST_DATA),
        NULL, NULL, 0,
        1, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0032:
 *
 */
ACPI_STATUS
AtHndlrTest0032(void)
{
    return (AtRemoveAdrSpaceHandlerCommon(AdrSpaceTestData0001,
        sizeof (AdrSpaceTestData0001) / sizeof (AT_ADR_SPACE_TEST_DATA),
        NULL, NULL, 0,
        2, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0033:
 *
 */
ACPI_STATUS
AtHndlrTest0033(void)
{
    return (AtRemoveAdrSpaceHandlerCommon(AdrSpaceTestData0001,
        sizeof (AdrSpaceTestData0001) / sizeof (AT_ADR_SPACE_TEST_DATA),
        NULL, NULL, 0,
        3, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0034:
 *
 */
ACPI_STATUS
AtHndlrTest0034(void)
{
    return (AtRemoveAdrSpaceHandlerCommon(AdrSpaceTestData0001,
        sizeof (AdrSpaceTestData0001) / sizeof (AT_ADR_SPACE_TEST_DATA),
        NULL, NULL, 0,
        4, AE_BAD_PARAMETER));
}

/*
 * ASSERTION 0035:
 *
 */
ACPI_STATUS
AtHndlrTest0035(void)
{
    return (AtRemoveAdrSpaceHandlerCommon(AdrSpaceTestData0001,
        sizeof (AdrSpaceTestData0001) / sizeof (AT_ADR_SPACE_TEST_DATA),
        NULL, NULL, 0,
        6, AE_NOT_EXIST));
}

/*
 * ASSERTION 0036:
 *
 */

static AT_ADR_SPACE_TEST_DATA   AdrSpaceTestData0036[] = {
    {
        "\\PCI1.DEVA", 1 /* AdrSpaceHandlerNum */,
        {{2, ACPI_DEFAULT_HANDLER, ACPI_DEFAULT_HANDLER, 0,}}
    },
};

static char             PathName0[AT_PATHNAME_MAX];
static char             PathName1[AT_PATHNAME_MAX];
static char             PathName2[AT_PATHNAME_MAX];
static char             PathName3[AT_PATHNAME_MAX];

ACPI_STATUS
AtAuxHndlrTest0036(
    ACPI_STRING             DevPath,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    ACPI_STRING             AdrSpaceMethod = PathName0;
    ACPI_STRING             RegCount = PathName1;
    ACPI_STRING             RegErrors = PathName2;
    ACPI_STRING             RegStatus = PathName3;
    ACPI_HANDLE             Device;
    ACPI_ADR_SPACE_TYPE     SpaceId = ACPI_ADR_SPACE_PCI_CONFIG;
    ACPI_ADR_SPACE_HANDLER  Handler = ACPI_DEFAULT_HANDLER;
    ACPI_ADR_SPACE_SETUP    Setup = ACPI_DEFAULT_HANDLER;
    void                    *TestSpace, *Context = &TestSpace;

    strcpy(AdrSpaceMethod, DevPath);
    strcat(AdrSpaceMethod, ".ACC0");

    Status = AcpiEvaluateObject (NULL, AdrSpaceMethod, NULL, NULL);

    if (Status != ExpectedStatus)
    {
        AapiErrors++;
        printf ("Api Error: AcpiEvaluateObject(%s)"
            " returned %s, expected %s\n",
            AdrSpaceMethod, AcpiFormatException(Status),
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

    Status = AcpiGetHandle (NULL, DevPath, &Device);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
            DevPath, AcpiFormatException(Status));
        return (Status);
    }

    strcpy(RegCount, DevPath);
    strcat(RegCount, ".REGC");
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, RegCount, 0)))
    {
        return (Status);
    }

    Status = AcpiInstallAddressSpaceHandler(Device, SpaceId,
        Handler, Setup, Context);

    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiInstallAddressSpaceHandler(0x%p, %d, 0x%p, 0x%p)"
            " returned %s\n",
            Device, SpaceId, Handler, Setup, AcpiFormatException(Status));
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, RegCount, 1)))
    {
        return (Status);
    }

    strcpy(RegErrors, DevPath);
    strcat(RegErrors, ".REGE");
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, RegErrors, 0)))
    {
        return (Status);
    }

    strcpy(RegStatus, DevPath);
    strcat(RegStatus, ".REGS");
    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, RegStatus, 1)))
    {
        return (Status);
    }

    Status = AcpiEvaluateObject (NULL, AdrSpaceMethod, NULL, NULL);
    if (ACPI_FAILURE(Status))
    {
        AapiErrors++;
        printf ("Api Error: AcpiEvaluateObject(%s) returned %s\n",
            AdrSpaceMethod, AcpiFormatException(Status));
    }

    if (ACPI_FAILURE(Status = AtCheckInteger(NULL, RegCount, 1)))
    {
        return (Status);
    }

    return (Status);
}

ACPI_STATUS
AtHndlrTest0036(void)
{
    ACPI_STATUS             Status;
    UINT32                  InitStages = AAPITS_INI_DEF & ~AAPITS_INSTALL_HS;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hndl0016.aml")))
    {
        return (Status);
    }

    Status = AtSubsystemInit(
        InitStages,
        AAPITS_EN_FLAGS | ACPI_NO_ADDRESS_SPACE_INIT,
        AAPITS_OI_FLAGS | ACPI_NO_ADDRESS_SPACE_INIT,
        AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }
/*
    if (ACPI_FAILURE(Status = AtAuxHndlrTest0036(
        "\\PCI1", AE_NOT_EXIST)))
    {
        return (Status);
    }

    if (ACPI_FAILURE(Status = AtAuxHndlrTest0036(
        "\\PCI2.DEVA", AE_NOT_EXIST)))
    {
        return (Status);
    }
*/
    if (ACPI_FAILURE(Status = AtAuxHndlrTest0036(
        "\\PCI2.DEVB", AE_NOT_EXIST)))
    {
        return (Status);
    }

    return (AE_OK);
}

ACPI_STATUS
AtHndlrTest0037(void)
{
    return (AtInstallAdrSpaceHandlerCommon(AdrSpaceTestData0036,
        sizeof (AdrSpaceTestData0036) / sizeof (AT_ADR_SPACE_TEST_DATA),
        NULL, NULL, 0,
        0, AE_OK));
}

ACPI_STATUS
AtRemoveAdrSpaceHandlerDynReg(
    AT_ADR_SPACE_TEST_DATA  *TestData,
    UINT32                  NumData,
    ACPI_STRING             AdrSpaceMethod,
    AT_ADR_SPACE_ACC_DATA   *AccData,
    UINT32                  NumAcc,
    ACPI_STATUS             ExpectedStatus)
{
    ACPI_STATUS             Status;
    ACPI_HANDLE             Device;
    ACPI_ADR_SPACE_TYPE     SpaceId;
    ACPI_ADR_SPACE_HANDLER  Handler;
    ACPI_ADR_SPACE_SETUP    Setup;
    void                    *Context;
    UINT32                  i, j, ii;
    UINT32                  ExpectedAdrSpaceHandlerCounter = 0;
    UINT32                  ExpectedAdrSpaceSetupCounter = 0;
    UINT32                  InitStages = AAPITS_INI_DEF & ~AAPITS_INSTALL_HS;

    if (ACPI_FAILURE(Status = AtAMLcodeFileNameSet("hndl0038.aml")))
    {
        return (Status);
    }

    Status = AtSubsystemInit(
        InitStages,
        AAPITS_EN_FLAGS | ACPI_NO_ADDRESS_SPACE_INIT,
        AAPITS_OI_FLAGS, AtAMLcodeFileName);
    if (ACPI_FAILURE(Status))
    {
        return (Status);
    }

    for (i = 0; i < NumData; i++)
    {
        if (TestData[i].Pathname)
        {
            Status = AcpiGetHandle (NULL, TestData[i].Pathname,
                &TestData[i].Device);
            if (ACPI_FAILURE(Status))
            {
                AapiErrors++;
                printf ("Api Error: AcpiGetHandle(%s) returned %s\n",
                    TestData[i].Pathname, AcpiFormatException(Status));
                return (Status);
            }
        }
        else
        {
            TestData[i].Device = ACPI_ROOT_OBJECT;
        }
    }

        for (i = 0; i < NumAcc; i++)
        {
            if (AccData[i].RegionSpace == 4 /* SMBus */)
            {
                AccData[i].NumAcc = 1;
            }
            else
            {
                AccData[i].NumAcc = (AccData[i].FieldSize +
                    AccData[i].Width - 1) / AccData[i].Width;
                if (AccData[i].FieldSize % AccData[i].Width)
                {   /* Write operation as read/write */
                    AccData[i].NumAcc++;
                }
            }
            ExpectedAdrSpaceHandlerCounter += AccData[i].NumAcc;
        }

    AdrSpaceHandlerCounter = 0;
    AdrSpaceSetupCounter = 0;
    AdrSpaceHandlerTestData.NumData = NumData;
    AdrSpaceHandlerTestData.TestData = TestData;
    AdrSpaceHandlerTestData.NumAcc = NumAcc;
    AdrSpaceHandlerTestData.AccData = AccData;

    /* Install Handlers */
    for (i = 0; i < NumData; i++)
    {
        Device = TestData[i].Device;

        for (j = 0; j < TestData[i].AdrSpaceHandlerNum; j++)
        {
            SpaceId = TestData[i].InstData[j].SpaceId;
            Handler = TestData[i].InstData[j].Handler;
            Setup = TestData[i].InstData[j].Setup;
            Context = &TestData[i].InstData[j].Context;
            TestData[i].InstData[j].NumSetup = 0;

            for (ii = 0; ii < NumAcc; ii++)
            {
                if (SpaceId != AccData[ii].RegionSpace)
                {
                    continue;
                }
                TestData[i].InstData[j].NumSetup += 2;
           }
            ExpectedAdrSpaceSetupCounter += TestData[i].InstData[j].NumSetup;

            Status = AcpiInstallAddressSpaceHandler(Device, SpaceId,
                Handler, Setup, Context);

            if (Status != ExpectedStatus)
            {
                AapiErrors++;
                printf ("Api Error: AcpiInstallAddressSpaceHandler(0x%p, %d, 0x%p, 0x%p)"
                    " returned %s, expected %s\n",
                    Device, SpaceId, Handler, Setup, AcpiFormatException(Status),
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
    }

    /* Access Regions */
    if (AdrSpaceMethod)
    {
        Status = AcpiEvaluateObject (NULL, AdrSpaceMethod, NULL, NULL);
        if (ACPI_FAILURE(Status))
        {
            AapiErrors++;
            printf ("Api Error: AcpiEvaluateObject(%s) returned %s\n",
                AdrSpaceMethod, AcpiFormatException(Status));
            return (Status);
        }

    }

    /* Remove Handlers */
    for (i = 0; i < NumData; i++)
    {
        Device = TestData[i].Device;

        for (j = 0; j < TestData[i].AdrSpaceHandlerNum; j++)
        {
            SpaceId = TestData[i].InstData[j].SpaceId;
            Handler = TestData[i].InstData[j].Handler;

            Status = AcpiRemoveAddressSpaceHandler(Device, SpaceId, Handler);

            if (Status != ExpectedStatus)
            {
                AapiErrors++;
                printf ("Api Error: AcpiRemoveAddressSpaceHandler(0x%p, %d, 0x%p)"
                    " returned %s, expected %s\n",
                    Device, SpaceId, Handler, AcpiFormatException(Status),
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
            else if (Status == AE_OK)
            {
                Status = AcpiRemoveAddressSpaceHandler(Device, SpaceId, Handler);
                if (Status != AE_NOT_EXIST)
                {
                    AapiErrors++;
                    printf ("Api Error: AcpiRemoveAddressSpaceHandler(0x%p, %d, 0x%p)"
                        " returned %s, expected %s\n",
                        Device, SpaceId, Handler, AcpiFormatException(Status),
                        AcpiFormatException(AE_NOT_EXIST));
                    return (AE_ERROR);
                }
            }
        }
    }

    /* Check Results */
    if (AdrSpaceMethod)
    {
        for (i = 0; i < NumData; i++)
        {
            for (j = 0; j < TestData[i].AdrSpaceHandlerNum; j++)
            {
                if (TestData[i].InstData[j].SetupInd !=
                    TestData[i].InstData[j].NumSetup)
                {
                    AapiErrors++;
                    printf ("Api Error: %d Setup Handler number of calls %d"
                        " is not expected %d\n",
                        TestData[i].InstData[j].SpaceId,
                        TestData[i].InstData[j].SetupInd,
                        TestData[i].InstData[j].NumSetup);
                }
                if (TestData[i].InstData[j].SetupErr)
                {
                    AapiErrors++;
                    printf ("Api Error: in %d Setup Handler encountered %d errors\n",
                        TestData[i].InstData[j].SpaceId,
                        TestData[i].InstData[j].SetupErr);
                }
            }
        }

        for (i = 0; i < NumAcc; i++)
        {
            if (AccData[i].AccSetupErr)
            {
                AapiErrors++;
                printf ("Api Error: for %s Setup Handler encountered %d errors\n",
                    AccData[i].RegionName, AccData[i].AccSetupErr);
            }
            if (AccData[i].AccInd != AccData[i].NumAcc)
            {
                AapiErrors++;
                printf ("Api Error: %s Acc Handler number of calls %d"
                    " is not expected %d\n",
                    AccData[i].RegionName, AccData[i].AccInd, AccData[i].NumAcc);
            }
            if (AccData[i].AccErr)
            {
                AapiErrors++;
                printf ("Api Error: in %s Acc Handler encountered %d errors\n",
                    AccData[i].RegionName, AccData[i].AccErr);
            }
        }
    }

    if (AdrSpaceHandlerCounter != ExpectedAdrSpaceHandlerCounter)
    {
        AapiErrors++;
        printf ("Api Error: AdrSpace Handlers invoked %d times instead of %d\n",
            AdrSpaceHandlerCounter, ExpectedAdrSpaceHandlerCounter);
        return (AE_ERROR);
    }

    if (AdrSpaceSetupCounter != ExpectedAdrSpaceSetupCounter)
    {
        AapiErrors++;
        printf ("Api Error: AdrSpace Setup invoked %d times instead of %d\n",
            AdrSpaceSetupCounter, ExpectedAdrSpaceSetupCounter);
        return (AE_ERROR);
    }

    return (AtTerminateCtrlCheck(AE_OK, ALL_STAT));
}

static AT_ADR_SPACE_ACC_DATA    AdrSpaceAccData0038[] = {
    {"\\OPR0", 0, 0x00000, 0x10000, 70, 8},
    {"\\OPR1", 1, 0x21000, 0x11000, 71, 8},
    {"\\OPR2", 2, 0x32000, 0x12000, 72, 8},
    {"\\OPR3", 3, 0x45000, 0x13000, 73, 8},
    {"\\OPR4", 4, 0x69000, 0x14000, 74, 8},
    {"\\OPR5", 5, 0x83000, 0x15000, 75, 8},
    {"\\OPR6", 6, 0x98000, 0x16000, 76, 8},
    {"\\DEV0.OPR0", 0, 0x100000, 0x10000, 70, 8},
    {"\\DEV0.OPR1", 1, 0x121000, 0x11000, 71, 8},
    {"\\CPU0.OPR2", 2, 0x132000, 0x12000, 72, 8},
    {"\\CPU0.OPR3", 3, 0x145000, 0x13000, 73, 8},
    {"\\CPU0.OPR4", 4, 0x169000, 0x14000, 74, 8},
    {"\\TZN0.OPR5", 5, 0x183000, 0x15000, 75, 8},
    {"\\TZN0.OPR6", 6, 0x198000, 0x16000, 76, 8},
    {"\\TST6.OPR0", 0, 0x10001, 0x10000, 70, 8},
    {"\\TST6.OPR1", 1, 0x32001, 0x11000, 71, 8},
    {"\\TST6.OPR2", 2, 0x44001, 0x12000, 72, 8},
    {"\\TST6.OPR3", 3, 0x58001, 0x13000, 73, 8},
    {"\\TST6.OPR4", 4, 0x7d001, 0x14000, 74, 8},
    {"\\TST6.OPR5", 5, 0x98001, 0x15000, 75, 8},
    {"\\TST6.OPR6", 6, 0xae001, 0x16000, 76, 8},
};

/*
 * ASSERTION 0038:
 *
 */
ACPI_STATUS
AtHndlrTest0038(void)
{
    return (AtRemoveAdrSpaceHandlerDynReg(AdrSpaceTestData0000,
        sizeof (AdrSpaceTestData0000) / sizeof (AT_ADR_SPACE_TEST_DATA),
        "\\TST7", AdrSpaceAccData0038,
        sizeof (AdrSpaceAccData0038) / sizeof (AT_ADR_SPACE_ACC_DATA),
        AE_OK));
}
