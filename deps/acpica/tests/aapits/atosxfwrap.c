/******************************************************************************
 *
 * Module Name: atosxfwrap.c - ACPICA OSL wrapper
 *
 * supporting the ACPICA API test suite actions
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

#include <stdio.h>

#include "acpi.h"
#include "accommon.h"

#include "atcommon.h"
#include "atosxfctrl.h"
#include "atosxfwrap.h"

#define _COMPONENT          ACPI_OS_SERVICES
        ACPI_MODULE_NAME    ("atosxfwrap")


ACPI_STATUS
AcpiOsInitialize (void)
{
    UINT64                  Calls = OsxfGetCallsDiff();
    AT_CTRL_DECL(AcpiOsInitialize);

    if (OsInitialized)
    {
        printf("AcpiOsInitialize: OSL has already been initialized\n");
        return (AE_ERROR);
    }
    if (Calls)
    {
        printf("AcpiOsInitialize: there were %u OSL interfaces calls"
            " done ahead of OsInitialize\n", (UINT32)Calls);
        return (AE_ERROR);
    }

    AT_CHCK_RET_STATUS(AcpiOsInitialize);
    AT_CHCK_RET_ERROR(AcpiOsInitialize);

    Status = AcpiOsActualInitialize();

    AT_CTRL_SUCCESS(AcpiOsInitialize);

    if (ACPI_SUCCESS(Status))
    {
        OsInitialized = 1;
    }

    return (Status);
}


ACPI_STATUS
AcpiOsTerminate (void)
{
    AT_CTRL_DECL(AcpiOsTerminate);

    OsxfUpdateCallsMark();

    AT_CHCK_RET_STATUS(AcpiOsTerminate);

    if (!OsInitialized)
    {
        printf("AcpiOsTerminate: OSL has not been initialized\n");
//        return (AE_ERROR);
    }

#ifdef ACPI_DBG_TRACK_ALLOCATIONS
    if (AT_SKIP_LIST_FREE_CHECK)
    {
        /* update for components\utilities\utinit.c(360) */
        if (AcpiGbl_GlobalList)
        {
            AcpiOsFree (AcpiGbl_GlobalList);
            AcpiGbl_GlobalList = NULL;
        }
        if (AcpiGbl_NsNodeList)
        {
            AcpiOsFree (AcpiGbl_NsNodeList);
            AcpiGbl_NsNodeList = NULL;
        }
    }
#endif

    Status = AcpiOsActualTerminate();

    AT_CTRL_SUCCESS(AcpiOsInitialize);

    OsInitialized = 0;

    OsxfUpdateCallsMark();

    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsGetRootPointer
 *
 * PARAMETERS:  Flags   - Logical or physical addressing mode
 *              Address - Where the address is returned
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Gets the root pointer (RSDP)
 *
 *****************************************************************************/
/*
ACPI_STATUS
AcpiOsGetRootPointer (
    UINT32                  Flags,
    ACPI_POINTER            *Address)
{
    AT_CTRL_DECL(AcpiOsGetRootPointer);

    AT_CHCK_RET_STATUS(AcpiOsGetRootPointer);
    AT_CHCK_RET_ERROR(AcpiOsGetRootPointer);

    if (AtTryAcpiFindRootPointer)
    {
        Status = AcpiFindRootPointer(Flags, Address);
    }
    else
    {
        Status = AcpiOsActualGetRootPointer(Flags, Address);
    }

    AT_CTRL_SUCCESS(AcpiOsGetRootPointer);

    return (Status);
}
*/
ACPI_PHYSICAL_ADDRESS
AcpiOsGetRootPointer (
    void)
{
    ACPI_PHYSICAL_ADDRESS   Pointer;
    AT_CTRL_DECL0(AcpiOsGetRootPointer);

    AT_CHCK_RET_ZERO(AcpiOsGetRootPointer);

    Pointer = AcpiOsActualGetRootPointer();

    if (Pointer != 0)
    {
        AT_CTRL_SUCCESS0(AcpiOsGetRootPointer);
    }

    return (Pointer);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsPredefinedOverride
 *
 * PARAMETERS:  InitVal     - Initial value of the predefined object
 *              NewVal      - The new value for the object
 *
 * RETURN:      Status, pointer to value. Null pointer returned if not
 *              overriding.
 *
 * DESCRIPTION: Allow the OS to override predefined names
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsPredefinedOverride (
    const ACPI_PREDEFINED_NAMES *InitVal,
    ACPI_STRING                 *NewVal)
{
    AT_CTRL_DECL(AcpiOsPredefinedOverride);

    if (!AT_SKIP_OS_PRED_OVERRIDE_CTRL)
    {
        AT_CHCK_RET_STATUS(AcpiOsPredefinedOverride);
    }

    Status = AcpiOsActualPredefinedOverride(InitVal, NewVal);

    AT_CTRL_SUCCESS(AcpiOsPredefinedOverride);

    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsTableOverride
 *
 * PARAMETERS:  ExistingTable   - Header of current table (probably firmware)
 *              NewTable        - Where an entire new table is returned.
 *
 * RETURN:      Status, pointer to new table. Null pointer returned if no
 *              table is available to override
 *
 * DESCRIPTION: Return a different version of a table if one is available
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsTableOverride (
    ACPI_TABLE_HEADER       *ExistingTable,
    ACPI_TABLE_HEADER       **NewTable)
{
    AT_CTRL_DECL(AcpiOsTableOverride);

    AT_CHCK_RET_STATUS(AcpiOsTableOverride);

    Status = AcpiOsActualTableOverride(ExistingTable, NewTable);

    AT_CTRL_SUCCESS(AcpiOsTableOverride);

    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsPhysicalTableOverride
 *
 * PARAMETERS:  ExistingTable       - Header of current table (probably firmware)
 *              NewAddress          - Where new table address is returned
 *                                    (Physical address)
 *              NewTableLength      - Where new table length is returned
 *
 * RETURN:      Status, address/length of new table. Null pointer returned
 *              if no table is available to override.
 *
 * DESCRIPTION: Returns AE_SUPPORT, function not used in user space.
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsPhysicalTableOverride (
    ACPI_TABLE_HEADER       *ExistingTable,
    ACPI_PHYSICAL_ADDRESS   *NewAddress,
    UINT32                  *NewTableLength)
{

    return (AE_SUPPORT);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsGetTimer
 *
 * PARAMETERS:  None
 *
 * RETURN:      Current ticks in 100-nanosecond units
 *
 * DESCRIPTION: Get the value of a system timer
 *
 ******************************************************************************/

UINT64
AcpiOsGetTimer (
    void)
{
    AT_CTRL_DECL0(AcpiOsGetTimer);

    AT_CTRL_SUCCESS0(AcpiOsGetTimer);

    return (AcpiOsActualGetTimer());
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsReadable
 *
 * PARAMETERS:  Pointer             - Area to be verified
 *              Length              - Size of area
 *
 * RETURN:      TRUE if readable for entire length
 *
 * DESCRIPTION: Verify that a pointer is valid for reading
 *
 *****************************************************************************/

BOOLEAN
AcpiOsReadable (
    void                    *Pointer,
    ACPI_SIZE               Length)
{
    AT_CTRL_DECL0(AcpiOsReadable);

    AT_CTRL_SUCCESS0(AcpiOsReadable);

    return (AcpiOsActualReadable(Pointer, Length));
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsWritable
 *
 * PARAMETERS:  Pointer             - Area to be verified
 *              Length              - Size of area
 *
 * RETURN:      TRUE if writable for entire length
 *
 * DESCRIPTION: Verify that a pointer is valid for writing
 *
 *****************************************************************************/

BOOLEAN
AcpiOsWritable (
    void                    *Pointer,
    ACPI_SIZE               Length)
{
    AT_CTRL_DECL0(AcpiOsWritable);

    AT_CTRL_SUCCESS0(AcpiOsWritable);

    return (AcpiOsActualWritable(Pointer, Length));
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsRedirectOutput
 *
 * PARAMETERS:  Destination         - An open file handle/pointer
 *
 * RETURN:      None
 *
 * DESCRIPTION: Causes redirect of AcpiOsPrintf and AcpiOsVprintf
 *
 *****************************************************************************/

void
AcpiOsRedirectOutput (
    void                    *Destination)
{
    AT_CTRL_DECL0(AcpiOsRedirectOutput);

    AT_CTRL_SUCCESS0(AcpiOsRedirectOutput);

    AcpiOsActualRedirectOutput(Destination);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsPrintf
 *
 * PARAMETERS:  fmt, ...            Standard printf format
 *
 * RETURN:      None
 *
 * DESCRIPTION: Formatted output
 *
 *****************************************************************************/

void ACPI_INTERNAL_VAR_XFACE
AcpiOsPrintf (
    const char              *Fmt,
    ...)
{
    va_list                 Args;
    AT_CTRL_DECL0(AcpiOsPrintf);


    va_start (Args, Fmt);

    AcpiOsActualVprintf (Fmt, Args);

    va_end (Args);

    AT_CTRL_SUCCESS0(AcpiOsPrintf);

    return;
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsVprintf
 *
 * PARAMETERS:  fmt                 Standard printf format
 *              args                Argument list
 *
 * RETURN:      None
 *
 * DESCRIPTION: Formatted output with argument list pointer
 *
 *****************************************************************************/

void
AcpiOsVprintf (
    const char              *Fmt,
    va_list                 Args)
{
    AT_CTRL_DECL0(AcpiOsVprintf);

    AcpiOsActualVprintf(Fmt, Args);

    AT_CTRL_SUCCESS0(AcpiOsVprintf);

    return;
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsGetLine
 *
 * PARAMETERS:  Buffer
 *
 * RETURN:      Actual bytes read
 *
 * DESCRIPTION: Formatted input with argument list pointer
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsGetLine (
    char                    *Buffer,
    UINT32                  BufferLength,
    UINT32                  *BytesRead)
{
    UINT32                  Actual;


    AT_CTRL_DECL0(AcpiOsGetLine);

    AT_CTRL_SUCCESS0(AcpiOsGetLine);

    Actual = AcpiOsActualGetLine(Buffer);
    if (BytesRead)
    {
        *BytesRead = Actual;
    }
    return (AE_OK);
}

/******************************************************************************
 *
 * FUNCTION:    AcpiOsMapMemory
 *
 * PARAMETERS:  where               Physical address of memory to be mapped
 *              length              How much memory to map
 *              there               Logical address of mapped memory
 *
 * RETURN:      Pointer to mapped memory. Null on error.
 *
 * DESCRIPTION: Map physical memory into caller's address space
 *
 *****************************************************************************/
/*
ACPI_STATUS
AcpiOsMapMemory (
    UINT64                  where,
    ACPI_SIZE               length,
    void                    **there)
{
    AT_CTRL_DECL(AcpiOsMapMemory);

    AT_CHCK_RET_STATUS(AcpiOsMapMemory);

    Status = AcpiOsActualMapMemory(where, length, there);

    AT_CTRL_SUCCESS(AcpiOsMapMemory);

    return (Status);
}
*/
void *
AcpiOsMapMemory (
    ACPI_PHYSICAL_ADDRESS   Where,
    ACPI_SIZE               Length)
{
    void                    *Mem;
    AT_CTRL_DECL0(AcpiOsMapMemory);

    AT_CHCK_RET_NULL(AcpiOsMapMemory);

    Mem = AcpiOsActualMapMemory(Where, Length);

/*
    printf("AcpiOsMapMemory: Where 0x%X, Length 0x%X, Mem  0x%X\n",
        Where, Length,  Mem);
*/

    if (Mem != NULL)
    {
        AT_CTRL_SUCCESS0(AcpiOsMapMemory);
    }

    return (Mem);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsUnmapMemory
 *
 * PARAMETERS:  where               Logical address of memory to be unmapped
 *              length              How much memory to unmap
 *
 * RETURN:      None.
 *
 * DESCRIPTION: Delete a previously created mapping. Where and Length must
 *              correspond to a previous mapping exactly.
 *
 *****************************************************************************/

void
AcpiOsUnmapMemory (
    void                    *where,
    ACPI_SIZE               length)
{
    AT_CTRL_DECL0(AcpiOsUnmapMemory);

    AT_CTRL_SUCCESS0(AcpiOsUnmapMemory);

/*
    printf("AcpiOsUnmapMemory: Where 0x%X, Length 0x%X\n",
        where, length);
*/

    AcpiOsActualUnmapMemory(where, length);

    return;
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsAllocate
 *
 * PARAMETERS:  Size                Amount to allocate, in bytes
 *
 * RETURN:      Pointer to the new allocation. Null on error.
 *
 * DESCRIPTION: Allocate memory. Algorithm is dependent on the OS.
 *
 *****************************************************************************/

void *
AcpiOsAllocate (
    ACPI_SIZE               size)
{
    void                    *Mem;
    AT_CTRL_DECL0(AcpiOsAllocate);

    AT_CHCK_RET_NULL(AcpiOsAllocate);

    Mem = AcpiOsActualAllocate(size);

    if (Mem != NULL)
    {
        AT_CTRL_SUCCESS0(AcpiOsAllocate);
    }

    return (Mem);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsFree
 *
 * PARAMETERS:  mem                 Pointer to previously allocated memory
 *
 * RETURN:      None.
 *
 * DESCRIPTION: Free memory allocated via AcpiOsAllocate
 *
 *****************************************************************************/

void
AcpiOsFree (
    void                    *Mem)
{
    AT_CTRL_DECL0(AcpiOsFree);

    AcpiOsActualFree(Mem);

    AT_CTRL_SUCCESS0(AcpiOsFree);

    return;
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsCreateSemaphore
 *
 * PARAMETERS:  MaxUnits            - Maximum units that can be sent
 *              InitialUnits        - Units to be assigned to the new semaphore
 *              OutHandle           - Where a handle will be returned
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Create an OS semaphore
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsCreateSemaphore (
    UINT32              MaxUnits,
    UINT32              InitialUnits,
    ACPI_HANDLE         *OutHandle)
{
    AT_CTRL_DECL(AcpiOsCreateSemaphore);

    AT_CHCK_RET_STATUS(AcpiOsCreateSemaphore);

    AT_CHCK_RET_NO_MEMORY(AcpiOsCreateSemaphore);

    Status = AcpiOsActualCreateSemaphore(MaxUnits, InitialUnits, OutHandle);

    AT_CTRL_SUCCESS(AcpiOsCreateSemaphore);

    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsDeleteSemaphore
 *
 * PARAMETERS:  Handle              - Handle returned by AcpiOsCreateSemaphore
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Delete an OS semaphore
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsDeleteSemaphore (
    ACPI_HANDLE         Handle)
{
    AT_CTRL_DECL(AcpiOsDeleteSemaphore);

    AT_CHCK_RET_STATUS(AcpiOsDeleteSemaphore);

    Status = AcpiOsActualDeleteSemaphore(Handle);

    AT_CTRL_SUCCESS(AcpiOsDeleteSemaphore);

    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsWaitSemaphore
 *
 * PARAMETERS:  Handle              - Handle returned by AcpiOsCreateSemaphore
 *              Units               - How many units to wait for
 *              Timeout             - How long to wait
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Wait for units
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsWaitSemaphore (
    ACPI_HANDLE         Handle,
    UINT32              Units,
    UINT16              Timeout)
{
    AT_CTRL_DECL(AcpiOsWaitSemaphore);

    AT_CHCK_RET_STATUS(AcpiOsWaitSemaphore);

    Status = AcpiOsActualWaitSemaphore(Handle, Units, Timeout);

    AT_CTRL_SUCCESS(AcpiOsWaitSemaphore);

    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsSignalSemaphore
 *
 * PARAMETERS:  Handle              - Handle returned by AcpiOsCreateSemaphore
 *              Units               - Number of units to send
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Send units
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsSignalSemaphore (
    ACPI_HANDLE         Handle,
    UINT32              Units)
{
    AT_CTRL_DECL(AcpiOsSignalSemaphore);

    if (!AT_SKIP_OS_SIGNAL_SEM_CTRL)
    {
        AT_CHCK_RET_STATUS(AcpiOsSignalSemaphore);
    }

    Status = AcpiOsActualSignalSemaphore(Handle, Units);

    AT_CTRL_SUCCESS(AcpiOsSignalSemaphore);

    return (Status);
}


ACPI_STATUS
AcpiOsCreateLock (
    ACPI_HANDLE             *OutHandle)
{
    AT_CTRL_DECL(AcpiOsCreateLock);

    AT_CHCK_RET_STATUS(AcpiOsCreateLock);

    AT_CHCK_RET_NO_MEMORY(AcpiOsCreateLock);

    Status = AcpiOsActualCreateLock(OutHandle);

    AT_CTRL_SUCCESS(AcpiOsCreateLock);

    return (Status);
}

void
AcpiOsDeleteLock (
    ACPI_HANDLE             Handle)
{
    AT_CTRL_DECL0(AcpiOsDeleteLock);

    AcpiOsActualDeleteLock(Handle);

    AT_CTRL_SUCCESS0(AcpiOsDeleteLock);

    return;
}


ACPI_CPU_FLAGS
AcpiOsAcquireLock (
    ACPI_HANDLE             Handle)
{
    AT_CTRL_DECL0(AcpiOsAcquireLock);

    AT_CTRL_SUCCESS0(AcpiOsAcquireLock);

    return (AcpiOsActualAcquireLock(Handle));
}


void
AcpiOsReleaseLock (
    ACPI_HANDLE             Handle,
    ACPI_CPU_FLAGS          Flags)
{
    AT_CTRL_DECL0(AcpiOsReleaseLock);

    AT_CTRL_SUCCESS0(AcpiOsReleaseLock);

    AcpiOsActualReleaseLock (Handle, Flags);

    return;
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsInstallInterruptHandler
 *
 * PARAMETERS:  InterruptNumber     Level handler should respond to.
 *              Isr                 Address of the ACPI interrupt handler
 *              ExceptPtr           Where status is returned
 *
 * RETURN:      Handle to the newly installed handler.
 *
 * DESCRIPTION: Install an interrupt handler. Used to install the ACPI
 *              OS-independent handler.
 *
 *****************************************************************************/

UINT32
AcpiOsInstallInterruptHandler (
    UINT32                  InterruptNumber,
    ACPI_OSD_HANDLER        ServiceRoutine,
    void                    *Context)
{
    AT_CTRL_DECL0(AcpiOsInstallInterruptHandler);

    AT_CTRL_SUCCESS0(AcpiOsInstallInterruptHandler);

    return (AcpiOsActualInstallInterruptHandler(
        InterruptNumber, ServiceRoutine, Context));
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsRemoveInterruptHandler
 *
 * PARAMETERS:  Handle              Returned when handler was installed
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Uninstalls an interrupt handler.
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsRemoveInterruptHandler (
    UINT32                  InterruptNumber,
    ACPI_OSD_HANDLER        ServiceRoutine)
{
    AT_CTRL_DECL0(AcpiOsRemoveInterruptHandler);

    AT_CTRL_SUCCESS0(AcpiOsRemoveInterruptHandler);

    return (AcpiOsActualRemoveInterruptHandler(
        InterruptNumber, ServiceRoutine));
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsGetThreadId
 *
 * PARAMETERS:  None
 *
 * RETURN:      Id of the running thread
 *
 * DESCRIPTION: Get the Id of the current (running) thread
 *
 *****************************************************************************/

ACPI_THREAD_ID
AcpiOsGetThreadId (
    void)
{
    AT_CTRL_DECL0(AcpiOsGetThreadId);

    AT_CTRL_SUCCESS0(AcpiOsGetThreadId);

    return (AcpiOsActualGetThreadId());
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsExecute
 *
 * PARAMETERS:  Type            - Type of execution
 *              Function        - Address of the function to execute
 *              Context         - Passed as a parameter to the function
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Execute a new thread
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsExecute (
    ACPI_EXECUTE_TYPE       Type,
    ACPI_OSD_EXEC_CALLBACK  Function,
    void                    *Context)
{
    AT_CTRL_DECL(AcpiOsExecute);

    AT_CHCK_RET_STATUS(AcpiOsExecute);

    Status = AcpiOsActualExecute(Type, Function, Context);

    AT_CTRL_SUCCESS(AcpiOsExecute);

    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsStall
 *
 * PARAMETERS:  microseconds        To sleep
 *
 * RETURN:      Blocks until sleep is completed.
 *
 * DESCRIPTION: Sleep at microsecond granularity
 *
 *****************************************************************************/

void
AcpiOsStall (
    UINT32                  microseconds)
{
    AT_CTRL_DECL0(AcpiOsStall);

    AT_CTRL_SUCCESS0(AcpiOsStall);

    AcpiOsActualStall(microseconds);

    return;
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsSleep
 *
 * PARAMETERS:  milliseconds        To sleep
 *
 * RETURN:      Blocks until sleep is completed.
 *
 * DESCRIPTION: Sleep at millisecond granularity
 *
 *****************************************************************************/

void
AcpiOsSleep (
    ACPI_INTEGER            milliseconds)
{
    AT_CTRL_DECL0(AcpiOsSleep);

    AT_CTRL_SUCCESS0(AcpiOsSleep);

    AcpiOsActualSleep(milliseconds);

    return;
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsValidateInterface
 *
 * PARAMETERS:  Interface           - Requested interface to be validated
 *
 * RETURN:      AE_OK if interface is supported, AE_SUPPORT otherwise
 *
 * DESCRIPTION: Match an interface string to the interfaces supported by the
 *              host. Strings originate from an AML call to the _OSI method.
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsValidateInterface (
    char                    *Interface)
{
    AT_CTRL_DECL(AcpiOsValidateInterface);

    AT_CHCK_RET_STATUS(AcpiOsValidateInterface);

    Status = AcpiOsActualValidateInterface(Interface);

    AT_CTRL_SUCCESS(AcpiOsValidateInterface);

    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsValidateAddress
 *
 * PARAMETERS:  SpaceId             - ACPI space ID
 *              Address             - Physical address
 *              Length              - Address length
 *
 * RETURN:      AE_OK if Address/Length is valid for the SpaceId. Otherwise,
 *              should return AE_AML_ILLEGAL_ADDRESS.
 *
 * DESCRIPTION: Validate a system address via the host OS. Used to validate
 *              the addresses accessed by AML operation regions.
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsValidateAddress (
    UINT8                   SpaceId,
    ACPI_PHYSICAL_ADDRESS   Address,
    ACPI_SIZE               Length)
{
    AT_CTRL_DECL(AcpiOsValidateAddress);

    AT_CHCK_RET_STATUS(AcpiOsValidateAddress);

    Status = AcpiOsActualValidateAddress(SpaceId, Address, Length);

    AT_CTRL_SUCCESS(AcpiOsValidateAddress);

    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsReadPciConfiguration
 *
 * PARAMETERS:  PciId               Seg/Bus/Dev
 *              Register            Device Register
 *              Value               Buffer where value is placed
 *              Width               Number of bits
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Read data from PCI configuration space
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsReadPciConfiguration (
    ACPI_PCI_ID             *PciId,
    UINT32                  Register,
    UINT64                  *Value,
    UINT32                  Width)
{
    AT_CTRL_DECL(AcpiOsReadPciConfiguration);

    AT_CHCK_RET_STATUS(AcpiOsReadPciConfiguration);

    Status = AcpiOsActualReadPciConfiguration(PciId, Register, Value, Width);

    AT_CTRL_SUCCESS(AcpiOsReadPciConfiguration);

    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsWritePciConfiguration
 *
 * PARAMETERS:  PciId               Seg/Bus/Dev
 *              Register            Device Register
 *              Value               Value to be written
 *              Width               Number of bits
 *
 * RETURN:      Status.
 *
 * DESCRIPTION: Write data to PCI configuration space
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsWritePciConfiguration (
    ACPI_PCI_ID             *PciId,
    UINT32                  Register,
    ACPI_INTEGER            Value,
    UINT32                  Width)
{
    AT_CTRL_DECL(AcpiOsWritePciConfiguration);

    AT_CHCK_RET_STATUS(AcpiOsWritePciConfiguration);

    Status = AcpiOsActualWritePciConfiguration(PciId, Register, Value, Width);

    AT_CTRL_SUCCESS(AcpiOsWritePciConfiguration);

    return (Status);
}

/* TEMPORARY STUB FUNCTION */
void
AcpiOsDerivePciId(
    ACPI_HANDLE             rhandle,
    ACPI_HANDLE             chandle,
    ACPI_PCI_ID             **PciId)
{
    AT_CTRL_DECL0(AcpiOsDerivePciId);

    AcpiOsActualDerivePciId(rhandle, chandle, PciId);

    AT_CTRL_SUCCESS0(AcpiOsDerivePciId);

    return;
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsReadPort
 *
 * PARAMETERS:  Address             Address of I/O port/register to read
 *              Value               Where value is placed
 *              Width               Number of bits
 *
 * RETURN:      Value read from port
 *
 * DESCRIPTION: Read data from an I/O port or register
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsReadPort (
    ACPI_IO_ADDRESS         Address,
    UINT32                  *Value,
    UINT32                  Width)
{
    AT_CTRL_DECL(AcpiOsReadPort);

    AT_CHCK_RET_STATUS(AcpiOsReadPort);

    if (!EMUL_REG_MODE) {
        Status = AcpiOsActualReadPort(Address, Value, Width);
    }
    else
    {
        Status = OsxfCtrlReadReg(EMUL_REG_IO, Address, Value, Width);
    }

    AT_CTRL_SUCCESS(AcpiOsReadPort);

    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsWritePort
 *
 * PARAMETERS:  Address             Address of I/O port/register to write
 *              Value               Value to write
 *              Width               Number of bits
 *
 * RETURN:      None
 *
 * DESCRIPTION: Write data to an I/O port or register
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsWritePort (
    ACPI_IO_ADDRESS         Address,
    UINT32                  Value,
    UINT32                  Width)
{
    AT_CTRL_DECL(AcpiOsWritePort);

    AT_CHCK_RET_STATUS(AcpiOsWritePort);

    AT_CHCK_RET_ERROR(AcpiOsWritePort);

    if (!EMUL_REG_MODE) {
        Status = AcpiOsActualWritePort(Address, Value, Width);
    }
    else
    {
        Status = OsxfCtrlWriteReg(EMUL_REG_IO, Address, Value, Width);
    }

    AT_CTRL_SUCCESS(AcpiOsWritePort);

    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsReadMemory
 *
 * PARAMETERS:  Address             Physical Memory Address to read
 *              Value               Where value is placed
 *              Width               Number of bits
 *
 * RETURN:      Value read from physical memory address. Always returned
 *              as a 64-bit integer, regardless of the read width.
 *
 * DESCRIPTION: Read data from a physical memory address
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsReadMemory (
    ACPI_PHYSICAL_ADDRESS   Address,
    UINT64                  *Value,
    UINT32                  Width)
{
    UINT32                  Value32;


    AT_CTRL_DECL(AcpiOsReadMemory);

    AT_CHCK_RET_STATUS(AcpiOsReadMemory);

    if (!EMUL_REG_MODE) {
        Status = AcpiOsActualReadMemory(Address, Value, Width);
    }
    else
    {
        Status = OsxfCtrlReadReg(EMUL_REG_SYS, Address, &Value32, Width);
        *Value = (UINT64) Value32;
    }

    AT_CTRL_SUCCESS(AcpiOsReadMemory);

    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsWriteMemory
 *
 * PARAMETERS:  Address             Physical Memory Address to write
 *              Value               Value to write
 *              Width               Number of bits
 *
 * RETURN:      None
 *
 * DESCRIPTION: Write data to a physical memory address
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsWriteMemory (
    ACPI_PHYSICAL_ADDRESS   Address,
    UINT64                  Value,
    UINT32                  Width)
{
    AT_CTRL_DECL(AcpiOsWriteMemory);

    AT_CHCK_RET_STATUS(AcpiOsWriteMemory);

    if (!EMUL_REG_MODE) {
        Status = AcpiOsActualWriteMemory(Address, Value, Width);
    }
    else
    {
        Status = OsxfCtrlWriteReg(EMUL_REG_SYS, Address, (UINT32) Value, Width);
    }

    AT_CTRL_SUCCESS(AcpiOsWriteMemory);

    return (Status);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsSignal
 *
 * PARAMETERS:  Function            ACPI CA signal function code
 *              Info                Pointer to function-dependent structure
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Miscellaneous functions
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsSignal (
    UINT32                  Function,
    void                    *Info)
{
    AT_CTRL_DECL(AcpiOsSignal);

    AT_CHCK_RET_STATUS(AcpiOsSignal);

    Status = AcpiOsActualSignal(Function, Info);

    AT_CTRL_SUCCESS(AcpiOsSignal);

    return (Status);
}
