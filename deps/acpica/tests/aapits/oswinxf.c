/******************************************************************************
 *
 * Module Name: oswinxf - Windows OSL
 *
 *****************************************************************************/

/******************************************************************************
 *
 * 1. Copyright Notice
 *
 * Some or all of this work - Copyright (c) 1999 - 2006, Intel Corp.
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


/*
 * These interfaces are required in order to link to the ACPI subsystem
 * parser. They are called during the execution of the parser, and all
 * map directly to Clibrary calls.
 */
#include "acpi.h"
#include "accommon.h"
#include "acdebug.h"
#include "atosxfwrap.h"

#ifdef WIN32
#pragma warning(disable:4115)   /* warning C4115: named type definition in parentheses (caused by rpcasync.h> */

#include <windows.h>
#include <winbase.h>
#endif

#ifdef WIN64
#include <windowsx.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <process.h>
#include <time.h>

#define _COMPONENT          ACPI_OS_SERVICES
        ACPI_MODULE_NAME    ("oswinxf")


//#define NUM_SEMAPHORES      128
#define NUM_SEMAPHORES      256

typedef struct semaphore_entry
{
    UINT16                  MaxUnits;
    UINT16                  CurrentUnits;
    void                    *OsHandle;
} SEMAPHORE_ENTRY;


SEMAPHORE_ENTRY             AcpiGbl_Semaphores[NUM_SEMAPHORES];
extern FILE                 *AcpiGbl_DebugFile;

/*
ACPI_STATUS
AeLocalGetRootPointer (
    UINT32                  Flags,
    ACPI_POINTER            *Address);
*/
ACPI_PHYSICAL_ADDRESS
AeLocalGetRootPointer (
    void);

FILE                        *AcpiGbl_OutputFile;
UINT64                      TimerFrequency;


/******************************************************************************
 *
 * FUNCTION:    OsTerminate
 *
 * PARAMETERS:  None
 *
 * RETURN:      None
 *
 * DESCRIPTION: Nothing to do for windows
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsActualTerminate (void)
{
    return (AE_OK);
}


#ifndef ACPI_EXEC_APP
/* Used by both iASL and AcpiDump applications */

CHAR                s[500];

/******************************************************************************
 *
 * FUNCTION:    OsGetTable
 *
 * PARAMETERS:  None
 *
 * RETURN:      Pointer to the table. NULL if failure
 *
 * DESCRIPTION: Get an ACPI table from the Windows registry.
 *
 *****************************************************************************/

ACPI_TABLE_HEADER *
OsGetTable (
    char                *TableName)
{
    HKEY                Handle = NULL;
    ULONG               i;
    LONG                Status;
    ULONG               Type;
    ULONG               NameSize;
    ULONG               DataSize;
    HKEY                SubKey;
    ACPI_TABLE_HEADER   *Buffer;
    char                *Signature = TableName;


    /* Get a handle to the DSDT key */

    while (1)
    {
        ACPI_STRCPY (s, "HARDWARE\\ACPI\\");
        ACPI_STRCAT (s, Signature);

        Status = RegOpenKeyEx (HKEY_LOCAL_MACHINE, s,
                    0L, KEY_ALL_ACCESS, &Handle);

        if (Status != ERROR_SUCCESS)
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
            else
            {
                AcpiOsPrintf ("Could not find %s in registry at %s\n", TableName, s);
                return (NULL);
            }
        }
        else
        {
            break;
        }
    }

    /* Actual table is down a couple of levels */

    for (i = 0; ;)
    {
        Status = RegEnumKey (Handle, i, s, sizeof(s));
        i += 1;
        if (Status == ERROR_NO_MORE_ITEMS)
        {
            break;
        }

        Status = RegOpenKey (Handle, s, &SubKey);
        if (Status != ERROR_SUCCESS)
        {
            AcpiOsPrintf ("Could not open %s entry\n", TableName);
            return (NULL);
        }

        RegCloseKey (Handle);
        Handle = SubKey;
        i = 0;
    }

    /* Find the table entry */

    for (i = 0; ;)
    {
        NameSize = sizeof (s);
        Status = RegEnumValue (Handle, i, s, &NameSize,
                    NULL, &Type, NULL, 0 );
        if (Status != ERROR_SUCCESS)
        {
            AcpiOsPrintf ("Could not get %s registry entry\n", TableName);
            return (NULL);
        }

        if (Type == REG_BINARY)
        {
            break;
        }
        i += 1;
    }

    /* Get the size of the table */

    Status = RegQueryValueEx (Handle, s, NULL, NULL, NULL, &DataSize);
    if (Status != ERROR_SUCCESS)
    {
        AcpiOsPrintf ("Could not read the %s table size\n", TableName);
        return (NULL);
    }

    /* Allocate a new buffer for the table */

    Buffer = AcpiOsAllocate (DataSize);
    if (!Buffer)
    {
        goto Cleanup;
    }

    /* Get the actual table from the registry */

    Status = RegQueryValueEx (Handle, s, NULL, NULL, (UCHAR *) Buffer, &DataSize);
    if (Status != ERROR_SUCCESS)
    {
        AcpiOsPrintf ("Could not read %s data\n", TableName);
        return (NULL);
    }

Cleanup:
    RegCloseKey (Handle);
    return (Buffer);
}

#endif

/******************************************************************************
 *
 * FUNCTION:    AcpiOsInitialize, AcpiOsTerminate
 *
 * PARAMETERS:  None
 *
 * RETURN:      Status
 *
 * DESCRIPTION: Init this OSL
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsActualInitialize (void)
{
    UINT32                  i;
    LARGE_INTEGER           LocalTimerFrequency;


    AcpiGbl_OutputFile = stdout;

    for (i = 0; i < NUM_SEMAPHORES; i++)
    {
        AcpiGbl_Semaphores[i].OsHandle = NULL;
    }

    TimerFrequency = 0;
    if (QueryPerformanceFrequency (&LocalTimerFrequency))
    {
        /* Frequency is in ticks per second */

        TimerFrequency = LocalTimerFrequency.QuadPart;
    }

    return (AE_OK);
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
AcpiOsActualGetRootPointer (
    UINT32                  Flags,
    ACPI_POINTER           *Address)
{

    return (AeLocalGetRootPointer (Flags, Address));
}
*/
ACPI_PHYSICAL_ADDRESS
AcpiOsActualGetRootPointer (
    void)
{
    return (AeLocalGetRootPointer ());
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
AcpiOsActualPredefinedOverride (
    const ACPI_PREDEFINED_NAMES *InitVal,
    ACPI_STRING                 *NewVal)
{

    if (!InitVal || !NewVal)
    {
        return (AE_BAD_PARAMETER);
    }

    *NewVal = NULL;
    return (AE_OK);
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
AcpiOsActualTableOverride (
    ACPI_TABLE_HEADER       *ExistingTable,
    ACPI_TABLE_HEADER       **NewTable)
{
#ifndef ACPI_EXEC_APP
    char                    TableName[ACPI_NAME_SIZE + 1];
#endif


    if (!ExistingTable || !NewTable)
    {
        return (AE_BAD_PARAMETER);
    }

    *NewTable = NULL;


#ifdef ACPI_EXEC_APP

    /* This code exercises the table override mechanism in the core */

#ifdef OBSOLETE_CODE
    if (ACPI_COMPARE_NAME (ExistingTable->Signature, ACPI_SIG_DSDT))
    {
        /* override DSDT with itself */

        *NewTable = AcpiGbl_DbTablePtr;
    }
#endif


#else

    /* Construct a null-terminated string from table signature */

    TableName[ACPI_NAME_SIZE] = 0;
    ACPI_STRNCPY (TableName, ExistingTable->Signature, ACPI_NAME_SIZE);

    *NewTable = OsGetTable (TableName);
    if (*NewTable)
    {
        AcpiOsPrintf ("%s obtained from registry, %d bytes\n",
            TableName, (*NewTable)->Length);
    }
    else
    {
        AcpiOsPrintf ("Could not read %s from registry\n", TableName);
    }
#endif

    return (AE_OK);
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
AcpiOsActualGetTimer (
    void)
{
    LARGE_INTEGER           Timer;


//        return ((UINT64) GetTickCount() * 10000);

    /* Attempt to use hi-granularity timer first */

    if (TimerFrequency &&
        QueryPerformanceCounter (&Timer))
    {
        /* Convert to 100 nanosecond ticks */

        return ((UINT64) ((Timer.QuadPart * (UINT64) 10000000) / TimerFrequency));
    }

    /* Fall back to the lo-granularity timer */

    else
    {
        /* Convert milliseconds to 100 nanosecond ticks */

        return ((UINT64) GetTickCount() * 10000);
    }
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
AcpiOsActualReadable (
    void                    *Pointer,
    ACPI_SIZE               Length)
{

    return ((BOOLEAN) !IsBadReadPtr (Pointer, Length));
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
AcpiOsActualWritable (
    void                    *Pointer,
    ACPI_SIZE               Length)
{

    return ((BOOLEAN) !IsBadWritePtr (Pointer, Length));
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
AcpiOsActualRedirectOutput (
    void                    *Destination)
{

    AcpiGbl_OutputFile = Destination;
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
AcpiOsActualPrintf (
    const char              *Fmt,
    ...)
{
    va_list                 Args;


    va_start (Args, Fmt);

    AcpiOsVprintf (Fmt, Args);

    va_end (Args);
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
AcpiOsActualVprintf (
    const char              *Fmt,
    va_list                 Args)
{
    INT32                   Count = 0;
    UINT8                   Flags;


    Flags = AcpiGbl_DbOutputFlags;
    if (Flags & ACPI_DB_REDIRECTABLE_OUTPUT)
    {
        /* Output is directable to either a file (if open) or the console */

        if (AcpiGbl_DebugFile)
        {
            /* Output file is open, send the output there */

            Count = vfprintf (AcpiGbl_DebugFile, Fmt, Args);
        }
        else
        {
            /* No redirection, send output to console (once only!) */

            Flags |= ACPI_DB_CONSOLE_OUTPUT;
        }
    }

    if (Flags & ACPI_DB_CONSOLE_OUTPUT)
    {
        Count = vfprintf (AcpiGbl_OutputFile, Fmt, Args);
    }

    return;
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsGetLine
 *
 * PARAMETERS:  fmt                 Standard printf format
 *              args                Argument list
 *
 * RETURN:      Actual bytes read
 *
 * DESCRIPTION: Formatted input with argument list pointer
 *
 *****************************************************************************/

UINT32
AcpiOsActualGetLine (
    char                    *Buffer)
{
    char                    Temp;
    UINT32                  i;


    for (i = 0; ; i++)
    {
        scanf ("%1c", &Temp);
        if (!Temp || Temp == '\n')
        {
            break;
        }

        Buffer [i] = Temp;
    }

    /* Null terminate the buffer */

    Buffer [i] = 0;

    /* Return the number of bytes in the string */

    return (i);
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
AcpiOsActualMapMemory (
    UINT64                  where,
    ACPI_SIZE               length,
    void                    **there)
{

    *there = ACPI_TO_POINTER ((ACPI_NATIVE_UINT) where);

    return (AE_OK);
}
*/
void *
AcpiOsActualMapMemory (
    ACPI_PHYSICAL_ADDRESS   Where,
    ACPI_SIZE               Length)
{
    return ((void *)Where);
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
AcpiOsActualUnmapMemory (
    void                    *where,
    ACPI_SIZE               length)
{

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
AcpiOsActualAllocate (
    ACPI_SIZE               size)
{
    void                    *Mem;


    Mem = (void *) malloc ((size_t) size);

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
AcpiOsActualFree (
    void                    *Mem)
{

    free (Mem);
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
AcpiOsActualCreateSemaphore (
    UINT32              MaxUnits,
    UINT32              InitialUnits,
    ACPI_HANDLE         *OutHandle)
{
#ifdef _MULTI_THREADED
    void                *Mutex;
    UINT32              i;

    ACPI_FUNCTION_NAME (OsCreateSemaphore);
#endif


    if (MaxUnits == ACPI_UINT32_MAX)
    {
        MaxUnits = 255;
    }

    if (InitialUnits == ACPI_UINT32_MAX)
    {
        InitialUnits = MaxUnits;
    }

    if (InitialUnits > MaxUnits)
    {
        return (AE_BAD_PARAMETER);
    }

#ifdef _MULTI_THREADED

    /* Find an empty slot */

    for (i = 0; i < NUM_SEMAPHORES; i++)
    {
        if (!AcpiGbl_Semaphores[i].OsHandle)
        {
            break;
        }
    }
    if (i >= NUM_SEMAPHORES)
    {
        return (AE_LIMIT);
    }

    /* Create an OS semaphore */

    Mutex = CreateSemaphore (NULL, InitialUnits, MaxUnits, NULL);
    if (!Mutex)
    {
        ACPI_ERROR ((AE_INFO, "Could not create semaphore"));
        return (AE_NO_MEMORY);
    }

    AcpiGbl_Semaphores[i].MaxUnits = (UINT16) MaxUnits;
    AcpiGbl_Semaphores[i].CurrentUnits = (UINT16) InitialUnits;
    AcpiGbl_Semaphores[i].OsHandle = Mutex;

    ACPI_DEBUG_PRINT ((ACPI_DB_MUTEX, "Handle=%d, Max=%d, Current=%d, OsHandle=%p\n",
            i, MaxUnits, InitialUnits, Mutex));

    *OutHandle = (void *) i;
#endif

    return (AE_OK);
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
AcpiOsActualDeleteSemaphore (
    ACPI_HANDLE         Handle)
{
    UINT32              Index = (UINT32) Handle;


    if ((Index >= NUM_SEMAPHORES) ||
        !AcpiGbl_Semaphores[Index].OsHandle)
    {
        return (AE_BAD_PARAMETER);
    }


#ifdef _MULTI_THREADED

    CloseHandle (AcpiGbl_Semaphores[Index].OsHandle);
    AcpiGbl_Semaphores[Index].OsHandle = NULL;
#endif

    return (AE_OK);
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
AcpiOsActualWaitSemaphore (
    ACPI_HANDLE         Handle,
    UINT32              Units,
    UINT16              Timeout)
{
#ifdef _MULTI_THREADED
    UINT32              Index = (UINT32) Handle;
    UINT32              WaitStatus;
    UINT32              OsTimeout = Timeout;


    ACPI_FUNCTION_ENTRY ();


    if ((Index >= NUM_SEMAPHORES) ||
        !AcpiGbl_Semaphores[Index].OsHandle)
    {
        return (AE_BAD_PARAMETER);
    }

    if (Units > 1)
    {
        printf ("WaitSemaphore: Attempt to receive %d units\n", Units);
        return (AE_NOT_IMPLEMENTED);
    }


/* TBD: Make this a command line option so that we can catch
 * synchronization deadlocks
 *
    if (Timeout == INFINITE)
        Timeout = 400000;
*/

    if (Timeout == ACPI_WAIT_FOREVER)
    {
        OsTimeout = INFINITE;
    }
    else
    {
        /* Add 10ms to account for clock tick granularity */

        OsTimeout += 10;
    }

    WaitStatus = WaitForSingleObject (AcpiGbl_Semaphores[Index].OsHandle, OsTimeout);
    if (WaitStatus == WAIT_TIMEOUT)
    {
/* Make optional -- wait of 0 is used to detect if unit is available
        ACPI_ERROR ((AE_INFO, "Timeout on semaphore %d",
            Handle));
*/
        return (AE_TIME);
    }

    if (AcpiGbl_Semaphores[Index].CurrentUnits == 0)
    {
        ACPI_ERROR ((AE_INFO, "%s - No unit received. Timeout %X, OSstatus 0x%X",
            AcpiUtGetMutexName (Index), Timeout, WaitStatus));

        return (AE_OK);
    }

    AcpiGbl_Semaphores[Index].CurrentUnits--;
#endif

    return (AE_OK);
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
AcpiOsActualSignalSemaphore (
    ACPI_HANDLE         Handle,
    UINT32              Units)
{
#ifdef _MULTI_THREADED

    UINT32              Index = (UINT32) Handle;


    ACPI_FUNCTION_ENTRY ();


    if (Index >= NUM_SEMAPHORES)
    {
        printf ("SignalSemaphore: Index/Handle out of range: %2.2X\n", Index);
        return (AE_BAD_PARAMETER);
    }

    if (!AcpiGbl_Semaphores[Index].OsHandle)
    {
        printf ("SignalSemaphore: Null OS handle, Index %2.2X\n", Index);
        return (AE_BAD_PARAMETER);
    }

    if (Units > 1)
    {
        printf ("SignalSemaphore: Attempt to signal %d units, Index %2.2X\n", Units, Index);
        return (AE_NOT_IMPLEMENTED);
    }

    if ((AcpiGbl_Semaphores[Index].CurrentUnits + 1) >
        AcpiGbl_Semaphores[Index].MaxUnits)
    {
        ACPI_ERROR ((AE_INFO, "Oversignalled semaphore[%d]! Current %d Max %d",
            Index, AcpiGbl_Semaphores[Index].CurrentUnits, AcpiGbl_Semaphores[Index].MaxUnits));

        return (AE_LIMIT);
    }

    AcpiGbl_Semaphores[Index].CurrentUnits++;
    ReleaseSemaphore (AcpiGbl_Semaphores[Index].OsHandle, Units, NULL);

#endif

    return (AE_OK);
}


ACPI_STATUS
AcpiOsActualCreateLock (
    ACPI_HANDLE             *OutHandle)
{

    return (AcpiOsCreateSemaphore (1, 1, OutHandle));
}

void
AcpiOsActualDeleteLock (
    ACPI_HANDLE             Handle)
{
    AcpiOsDeleteSemaphore (Handle);
}


ACPI_CPU_FLAGS
AcpiOsActualAcquireLock (
    ACPI_HANDLE             Handle)
{
    AcpiOsWaitSemaphore (Handle, 1, 0xFFFF);
    return (0);
}


void
AcpiOsActualReleaseLock (
    ACPI_HANDLE             Handle,
    ACPI_CPU_FLAGS          Flags)
{
    AcpiOsSignalSemaphore (Handle, 1);
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
AcpiOsActualInstallInterruptHandler (
    UINT32                  InterruptNumber,
    ACPI_OSD_HANDLER        ServiceRoutine,
    void                    *Context)
{

    return (AE_OK);
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
AcpiOsActualRemoveInterruptHandler (
    UINT32                  InterruptNumber,
    ACPI_OSD_HANDLER        ServiceRoutine)
{

    return (AE_OK);
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
AcpiOsActualGetThreadId (
    void)
{

    return (GetCurrentThreadId ());
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
AcpiOsActualExecute (
    ACPI_EXECUTE_TYPE       Type,
    ACPI_OSD_EXEC_CALLBACK  Function,
    void                    *Context)
{

#ifdef _MULTI_THREADED
    _beginthread (Function, (unsigned) 0, Context);
#endif

    return (0);
}


/******************************************************************************
 *
 * FUNCTION:    AcpiOsWaitEventsComplete
 *
 * PARAMETERS:  None
 *
 * RETURN:      None
 *
 * DESCRIPTION: Wait for all asynchronous events to complete. This
 *              implementation does nothing.
 *
 *****************************************************************************/

void
AcpiOsWaitEventsComplete (
    void)
{
    return;
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
AcpiOsActualStall (
    UINT32                  microseconds)
{

    Sleep ((microseconds / 1000) + 1);
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
AcpiOsActualSleep (
    ACPI_INTEGER            milliseconds)
{

    /* Add 10ms to account for clock tick granularity */

    Sleep (((unsigned long) milliseconds) + 10);
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
AcpiOsActualValidateInterface (
    char                    *Interface)
{

    return (AE_SUPPORT);
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
AcpiOsActualValidateAddress (
    UINT8                   SpaceId,
    ACPI_PHYSICAL_ADDRESS   Address,
    ACPI_SIZE               Length)
{

    return (AE_OK);
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
AcpiOsActualReadPciConfiguration (
    ACPI_PCI_ID             *PciId,
    UINT32                  Register,
    UINT64                  *Value,
    UINT32                  Width)
{

    return (AE_OK);
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
AcpiOsActualWritePciConfiguration (
    ACPI_PCI_ID             *PciId,
    UINT32                  Register,
    ACPI_INTEGER            Value,
    UINT32                  Width)
{

    return (AE_OK);
}

/* TEMPORARY STUB FUNCTION */
void
AcpiOsActualDerivePciId(
    ACPI_HANDLE             rhandle,
    ACPI_HANDLE             chandle,
    ACPI_PCI_ID             **PciId)
{

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
AcpiOsActualReadPort (
    ACPI_IO_ADDRESS         Address,
    UINT32                  *Value,
    UINT32                  Width)
{

    switch (Width)
    {
    case 8:
        *Value = 0xFF;
        break;

    case 16:
        *Value = 0xFFFF;
        break;

    case 32:
        *Value = 0xFFFFFFFF;
        break;

    default:
        return (AE_BAD_PARAMETER);
    }

    return (AE_OK);
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
AcpiOsActualWritePort (
    ACPI_IO_ADDRESS         Address,
    UINT32                  Value,
    UINT32                  Width)
{

    return (AE_OK);
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
 *              as a 32-bit integer, regardless of the read width.
 *
 * DESCRIPTION: Read data from a physical memory address
 *
 *****************************************************************************/

ACPI_STATUS
AcpiOsActualReadMemory (
    ACPI_PHYSICAL_ADDRESS   Address,
    UINT64                  *Value,
    UINT32                  Width)
{

    switch (Width)
    {
    case 8:
    case 16:
    case 32:
    case 64:
        *Value = 0;
        break;

    default:
        return (AE_BAD_PARAMETER);
        break;
    }

    return (AE_OK);
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
AcpiOsActualWriteMemory (
    ACPI_PHYSICAL_ADDRESS   Address,
    UINT64                  Value,
    UINT32                  Width)
{

    return (AE_OK);
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
AcpiOsActualSignal (
    UINT32                  Function,
    void                    *Info)
{

    switch (Function)
    {
    case ACPI_SIGNAL_FATAL:
        break;

    case ACPI_SIGNAL_BREAKPOINT:

        if (Info)
        {
            AcpiOsPrintf ("AcpiOsBreakpoint: %s ****\n", Info);
        }
        else
        {
            AcpiOsPrintf ("At AcpiOsBreakpoint ****\n");
        }

        break;
    }

    return (AE_OK);
}
