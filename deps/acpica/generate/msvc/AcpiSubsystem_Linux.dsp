# Microsoft Developer Studio Project File - Name="AcpiSubsystem_Linux" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=AcpiSubsystem_Linux - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "AcpiSubsystem_Linux.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "AcpiSubsystem_Linux.mak" CFG="AcpiSubsystem_Linux - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "AcpiSubsystem_Linux - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "AcpiSubsystem_Linux - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "/acpica/generate/msvc/AcpiSubsystemLinux"
# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiSubsystemLinux"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD CPP /nologo /Gr /MT /Za /W4 /O1 /I "..\..\source_linux\Include" /D "ACPI_LIBRARY" /D "NDEBUG" /D "DRIVER" /D "_NDEBUG" /D "_WINDOWS" /D PROCESSOR_ARCHITECTURE=x86 /D "WIN32" /D "_WIN_VER" /D "ACPI_DEFINE_ALTERNATE_TYPES" /FR /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo /o"/acpica/generate/msvc/AcpiSubsystemLinux/AcpiSubsystemLinux.bsc"
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"AcpiSubsystemLinux\acpicalinux.lib"

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "/acpica/generate/msvc/AcpiSubsystemLinuxDebug"
# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiSubsystemLinuxDebug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD CPP /nologo /Gr /MTd /Za /W4 /Od /Gf /I "..\..\source_linux\Include" /D "ACPI_LIBRARY" /D "ACPI_FULL_DEBUG" /D "_DEBUG" /D "_WINDOWS" /D PROCESSOR_ARCHITECTURE=x86 /D "WIN32" /D "_WIN_VER" /D "ACPI_DEFINE_ALTERNATE_TYPES" /FR /FD /GZ /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo /o"/acpica/generate/msvc/AcpiSubsystemLinuxDebug/AcpiSubsystem_LinuxDebug.bsc" /o"/acpica/generate/msvc/AcpiSubsystemLinuxDebug/AcpiSubsystemLinux.bsc"
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"AcpiSubsystemLinuxDebug\acpicalinux_dbg.lib"

!ENDIF 

# Begin Target

# Name "AcpiSubsystem_Linux - Win32 Release"
# Name "AcpiSubsystem_Linux - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter ""
# Begin Group "Utilities"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source_linux\components\utilities\utalloc.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\utilities\utcache.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\utilities\utclib.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\utilities\utcopy.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\utilities\utdebug.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\utilities\utdelete.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\utilities\uteval.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\utilities\utglobal.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\utilities\utids.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\utilities\utinit.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\utilities\utlock.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\utilities\utmath.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

# ADD CPP /Ze

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\utilities\utmisc.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\utilities\utmutex.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\utilities\utobject.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\utilities\utosi.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\utilities\utresrc.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\utilities\utstate.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\utilities\utxface.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\utilities\utxferror.c
# End Source File
# End Group
# Begin Group "Events"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\EVENTS\evevent.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\EVENTS\evgpe.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\events\evgpeblk.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\events\evgpeinit.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\events\evgpeutil.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\EVENTS\evmisc.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\EVENTS\evregion.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\EVENTS\evrgnini.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\EVENTS\evsci.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\EVENTS\evxface.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\EVENTS\evxfevnt.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\events\evxfgpe.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\EVENTS\evxfregn.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Group "Hardware"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\HARDWARE\hwacpi.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\HARDWARE\hwgpe.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\hardware\hwpci.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\HARDWARE\hwregs.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\HARDWARE\hwsleep.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\HARDWARE\hwtimer.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

# ADD CPP /Ze

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\hardware\hwvalid.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\hardware\hwxface.c
# End Source File
# End Group
# Begin Group "Namespace"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nsaccess.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nsalloc.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nsdump.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nsdumpdv.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nseval.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nsinit.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nsload.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nsnames.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nsobject.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nsparse.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\namespace\nspredef.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\namespace\nsrepair.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\namespace\nsrepair2.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nssearch.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nsutils.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nswalk.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nsxfeval.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nsxfname.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\NAMESPACE\nsxfobj.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Group "Resources"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\resources\rsaddr.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\resources\rscalc.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\resources\rscreate.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\resources\rsdump.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\resources\rsinfo.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\resources\rsio.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\resources\rsirq.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\resources\rslist.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\resources\rsmemory.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\resources\rsmisc.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\resources\rsutils.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\resources\rsxface.c
# End Source File
# End Group
# Begin Group "Tables"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source_linux\components\tables\tbfadt.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\tables\tbfind.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\tables\tbinstal.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\tables\tbutils.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\tables\tbxface.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\tables\tbxfroot.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Group "Disassembler"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\Disassembler\dmbuffer.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\Disassembler\dmnames.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\disassembler\dmobject.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\Disassembler\dmopcode.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\Disassembler\dmresrc.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\Disassembler\dmresrcl.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\Disassembler\dmresrcs.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\Disassembler\dmutils.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\Disassembler\dmwalk.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Group "Debugger"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\DEBUGGER\dbcmds.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\DEBUGGER\dbdisply.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\DEBUGGER\dbexec.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\DEBUGGER\dbfileio.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\DEBUGGER\dbhistry.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\DEBUGGER\dbinput.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\DEBUGGER\dbstats.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\DEBUGGER\dbutils.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\COMPONENTS\DEBUGGER\dbxface.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Group "Interpreter"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exconfig.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exconvrt.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\excreate.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exdump.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exfield.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exfldio.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exmisc.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exmutex.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exnames.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exoparg1.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exoparg2.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exoparg3.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exoparg6.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exprep.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exregion.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exresnte.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exresolv.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exresop.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exstore.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exstoren.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exstorob.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exsystem.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\executer\exutils.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Group "Dispatcher"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source_linux\components\dispatcher\dsfield.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\dispatcher\dsinit.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\dispatcher\dsmethod.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\dispatcher\dsmthdat.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\dispatcher\dsobject.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\dispatcher\dsopcode.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\dispatcher\dsutils.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\dispatcher\dswexec.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\dispatcher\dswload.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\dispatcher\dswscope.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\dispatcher\dswstate.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Group "Parser"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source_linux\components\parser\psargs.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\parser\psloop.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\parser\psopcode.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\parser\psparse.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\parser\psscope.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\parser\pstree.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\parser\psutils.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\parser\pswalk.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\parser\psxface.c

!IF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Release"

# ADD CPP /Za
# SUBTRACT CPP /Gy

!ELSEIF  "$(CFG)" == "AcpiSubsystem_Linux - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# End Group
# Begin Group "Header Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source_linux\Include\acconfig.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acdebug.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\INCLUDE\acdisasm.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acdispat.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\platform\acefi.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\platform\acenv.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acevents.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acexcep.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\platform\acfreebsd.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\platform\acgcc.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acglobal.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\achware.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acinterp.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\platform\aclinux.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\aclocal.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acmacros.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\platform\acmsvc.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acnamesp.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acobject.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acoutput.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acparser.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acpi.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acpiosxf.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acpixf.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acresrc.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\include\acstruct.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\actables.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\actbl.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\actbl1.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\actbl2.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\actypes.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\acutils.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\platform\acwin.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\Include\amlcode.h
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\INCLUDE\amlresrc.h
# End Source File
# End Group
# Begin Source File

SOURCE=..\..\source\include\acnames.h
# End Source File
# Begin Source File

SOURCE=..\..\source\include\acopcode.h
# End Source File
# End Target
# End Project
