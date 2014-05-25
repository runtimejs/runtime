# Microsoft Developer Studio Project File - Name="AcpiSubsystem64" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=AcpiSubsystem64 - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "AcpiSubsystem64.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "AcpiSubsystem64.mak" CFG="AcpiSubsystem64 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "AcpiSubsystem64 - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "AcpiSubsystem64 - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "/acpica/generate/msvc/AcpiSubsystem64"
# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiSubsystem64"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD CPP /nologo /MT /Za /W4 /O1 /I "..\..\source\Include" /D "NDEBUG" /D "DRIVER" /D "_USE_INTEL_COMPILER" /D "ACPI_LIBRARY" /D "_WINDOWS" /D PROCESSOR_ARCHITECTURE=x86 /D "WIN64" /FR /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"AcpiSubsystem64\acpica64.lib" /machine:IA64
# Begin Special Build Tool
SOURCE="$(InputPath)"
PreLink_Desc=Checking existence of acpi/libraries directory
PreLink_Cmds=if NOT EXIST ..\..\libraries mkdir ..\..\libraries
PostBuild_Desc=Copy library to libraries
PostBuild_Cmds=copy AcpiSubsystem64\acpica64.lib ..\..\libraries	dir ..\..\libraries\acpica64.lib
# End Special Build Tool

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "/acpica/generate/msvc/AcpiSubsystem64Debug"
# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiSubsystem64Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD CPP /nologo /MTd /Za /W4 /Od /Oy /Gf /I "..\..\source\Include" /D "DEBUG" /D "DRIVER" /D "ACPI_FULL_DEBUG" /D "_USE_INTEL_COMPILER" /D "ACPI_LIBRARY" /D "_WINDOWS" /D PROCESSOR_ARCHITECTURE=x86 /D "WIN64" /FR /FD /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo /o"/acpica/generate/msvc/AcpiSubsystem64Debug/AcpiSubsystem64Debug.bsc"
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"AcpiSubsystem64Debug\acpica64_dbg.lib" /machine:IA64
# Begin Special Build Tool
SOURCE="$(InputPath)"
PreLink_Desc=Checking existence of acpi/libraries directory
PreLink_Cmds=if NOT EXIST ..\..\libraries mkdir ..\..\libraries
PostBuild_Desc=Copy library to libraries
PostBuild_Cmds=copy AcpiSubsystem64Debug\acpica64_dbg.lib ..\..\libraries	dir ..\..\libraries\acpica64_dbg.lib
# End Special Build Tool

!ENDIF 

# Begin Target

# Name "AcpiSubsystem64 - Win32 Release"
# Name "AcpiSubsystem64 - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Group "Utilities"

# PROP Default_Filter ".c"
# Begin Source File

SOURCE=..\..\source\components\utilities\utalloc.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utalloc.c
InputName=utalloc

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utalloc.c
InputName=utalloc

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utcache.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utcache.c
InputName=utcache

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utcache.c
InputName=utcache

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utclib.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utclib.c
InputName=utclib

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utclib.c
InputName=utclib

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utcopy.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utcopy.c
InputName=utcopy

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utcopy.c
InputName=utcopy

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utdebug.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utdebug.c
InputName=utdebug

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utdebug.c
InputName=utdebug

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utdelete.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utdelete.c
InputName=utdelete

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utdelete.c
InputName=utdelete

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\uteval.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\uteval.c
InputName=uteval

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\uteval.c
InputName=uteval

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utglobal.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utglobal.c
InputName=utglobal

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utglobal.c
InputName=utglobal

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utids.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utinit.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utinit.c
InputName=utinit

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utinit.c
InputName=utinit

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utmath.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utmath.c
InputName=utmath

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utmath.c
InputName=utmath

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utmisc.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utmisc.c
InputName=utmisc

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utmisc.c
InputName=utmisc

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utmutex.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utmutex.c
InputName=utmutex

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utmutex.c
InputName=utmutex

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utobject.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utobject.c
InputName=utobject

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utobject.c
InputName=utobject

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utosi.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utresrc.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utresrc.c
InputName=utresrc

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utresrc.c
InputName=utresrc

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utstate.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utstate.c
InputName=utstate

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utstate.c
InputName=utstate

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utxface.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utxface.c
InputName=utxface

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\utilities\utxface.c
InputName=utxface

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utxferror.c
# End Source File
# End Group
# Begin Group "Events"

# PROP Default_Filter ".c"
# Begin Source File

SOURCE=..\..\source\components\events\evevent.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evevent.c
InputName=evevent

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evevent.c
InputName=evevent

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\EVENTS\evgpe.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\EVENTS\evgpe.c
InputName=evgpe

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\EVENTS\evgpe.c
InputName=evgpe

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\SOURCE\COMPONENTS\EVENTS\evgpeblk.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\SOURCE\COMPONENTS\EVENTS\evgpeblk.c
InputName=evgpeblk

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\SOURCE\COMPONENTS\EVENTS\evgpeblk.c
InputName=evgpeblk

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\events\evgpeinit.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\events\evgpeutil.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evmisc.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evmisc.c
InputName=evmisc

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evmisc.c
InputName=evmisc

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evregion.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evregion.c
InputName=evregion

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evregion.c
InputName=evregion

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evrgnini.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evrgnini.c
InputName=evrgnini

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evrgnini.c
InputName=evrgnini

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evsci.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evsci.c
InputName=evsci

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evsci.c
InputName=evsci

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evxface.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evxface.c
InputName=evxface

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evxface.c
InputName=evxface

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evxfevnt.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evxfevnt.c
InputName=evxfevnt

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evxfevnt.c
InputName=evxfevnt

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evxfgpe.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evxfregn.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evxfregn.c
InputName=evxfregn

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\events\evxfregn.c
InputName=evxfregn

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# End Group
# Begin Group "Hardware"

# PROP Default_Filter ".c"
# Begin Source File

SOURCE=..\..\source\components\hardware\hwacpi.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\hardware\hwacpi.c
InputName=hwacpi

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\hardware\hwacpi.c
InputName=hwacpi

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\hardware\hwgpe.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\hardware\hwgpe.c
InputName=hwgpe

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\hardware\hwgpe.c
InputName=hwgpe

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\hardware\hwpci.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\hardware\hwregs.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\hardware\hwregs.c
InputName=hwregs

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\hardware\hwregs.c
InputName=hwregs

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\hardware\hwsleep.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\hardware\hwsleep.c
InputName=hwsleep

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\hardware\hwsleep.c
InputName=hwsleep

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\hardware\hwtimer.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\hardware\hwtimer.c
InputName=hwtimer

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\hardware\hwtimer.c
InputName=hwtimer

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\hardware\hwxface.c
# End Source File
# End Group
# Begin Group "Namespace"

# PROP Default_Filter ".c"
# Begin Source File

SOURCE=..\..\source\components\namespace\nsaccess.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsaccess.c
InputName=nsaccess

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsaccess.c
InputName=nsaccess

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsalloc.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsalloc.c
InputName=nsalloc

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsalloc.c
InputName=nsalloc

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsdump.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsdump.c
InputName=nsdump

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsdump.c
InputName=nsdump

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\NAMESPACE\nsdumpdv.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\NAMESPACE\nsdumpdv.c
InputName=nsdumpdv

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\NAMESPACE\nsdumpdv.c
InputName=nsdumpdv

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nseval.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nseval.c
InputName=nseval

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nseval.c
InputName=nseval

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsinit.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsinit.c
InputName=nsinit

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsinit.c
InputName=nsinit

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsload.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsload.c
InputName=nsload

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsload.c
InputName=nsload

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsnames.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsnames.c
InputName=nsnames

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsnames.c
InputName=nsnames

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsobject.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsobject.c
InputName=nsobject

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsobject.c
InputName=nsobject

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\NAMESPACE\nsparse.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\NAMESPACE\nsparse.c
InputName=nsparse

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\NAMESPACE\nsparse.c
InputName=nsparse

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nspredef.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\components\namespace\nsrepair.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nssearch.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nssearch.c
InputName=nssearch

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nssearch.c
InputName=nssearch

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsutils.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsutils.c
InputName=nsutils

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsutils.c
InputName=nsutils

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nswalk.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nswalk.c
InputName=nswalk

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nswalk.c
InputName=nswalk

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\NAMESPACE\nsxfeval.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\NAMESPACE\nsxfeval.c
InputName=nsxfeval

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\NAMESPACE\nsxfeval.c
InputName=nsxfeval

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsxfname.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsxfname.c
InputName=nsxfname

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsxfname.c
InputName=nsxfname

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsxfobj.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsxfobj.c
InputName=nsxfobj

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\namespace\nsxfobj.c
InputName=nsxfobj

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# End Group
# Begin Group "Resources"

# PROP Default_Filter ".c"
# Begin Source File

SOURCE=..\..\source\components\resources\rsaddr.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsaddr.c
InputName=rsaddr

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsaddr.c
InputName=rsaddr

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rscalc.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rscalc.c
InputName=rscalc

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rscalc.c
InputName=rscalc

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rscreate.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rscreate.c
InputName=rscreate

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rscreate.c
InputName=rscreate

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsdump.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsdump.c
InputName=rsdump

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsdump.c
InputName=rsdump

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsinfo.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsinfo.c
InputName=rsinfo

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsinfo.c
InputName=rsinfo

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsio.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsio.c
InputName=rsio

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsio.c
InputName=rsio

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsirq.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsirq.c
InputName=rsirq

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsirq.c
InputName=rsirq

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rslist.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rslist.c
InputName=rslist

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rslist.c
InputName=rslist

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsmemory.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsmemory.c
InputName=rsmemory

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsmemory.c
InputName=rsmemory

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsmisc.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsmisc.c
InputName=rsmisc

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsmisc.c
InputName=rsmisc

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsutils.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsutils.c
InputName=rsutils

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsutils.c
InputName=rsutils

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsxface.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsxface.c
InputName=rsxface

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\resources\rsxface.c
InputName=rsxface

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# End Group
# Begin Group "Tables"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\tables\tbfadt.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\tables\tbfadt.c
InputName=tbfadt

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\tables\tbfadt.c
InputName=tbfadt

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\tables\tbfind.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\tables\tbfind.c
InputName=tbfind

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\tables\tbfind.c
InputName=tbfind

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\tables\tbinstal.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\tables\tbinstal.c
InputName=tbinstal

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\tables\tbinstal.c
InputName=tbinstal

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\tables\tbutils.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\tables\tbutils.c
InputName=tbutils

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\tables\tbutils.c
InputName=tbutils

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\tables\tbxface.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\tables\tbxface.c
InputName=tbxface

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\tables\tbxface.c
InputName=tbxface

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\tables\tbxfroot.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\tables\tbxfroot.c
InputName=tbxfroot

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\tables\tbxfroot.c
InputName=tbxfroot

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# End Group
# Begin Group "Disassembler"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmbuffer.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmbuffer.c
InputName=dmbuffer

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmbuffer.c
InputName=dmbuffer

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmnames.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmnames.c
InputName=dmnames

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmnames.c
InputName=dmnames

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\SOURCE\COMPONENTS\disassembler\dmobject.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\SOURCE\COMPONENTS\disassembler\dmobject.c
InputName=dmobject

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\SOURCE\COMPONENTS\disassembler\dmobject.c
InputName=dmobject

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmopcode.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmopcode.c
InputName=dmopcode

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmopcode.c
InputName=dmopcode

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmresrc.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmresrc.c
InputName=dmresrc

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmresrc.c
InputName=dmresrc

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmresrcl.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmresrcl.c
InputName=dmresrcl

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmresrcl.c
InputName=dmresrcl

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmresrcs.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmresrcs.c
InputName=dmresrcs

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmresrcs.c
InputName=dmresrcs

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmutils.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmutils.c
InputName=dmutils

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmutils.c
InputName=dmutils

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmwalk.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmwalk.c
InputName=dmwalk

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\Disassembler\dmwalk.c
InputName=dmwalk

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# End Group
# Begin Group "Debugger"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbcmds.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbcmds.c
InputName=dbcmds

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbcmds.c
InputName=dbcmds

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbdisply.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbdisply.c
InputName=dbdisply

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbdisply.c
InputName=dbdisply

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbexec.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbexec.c
InputName=dbexec

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbexec.c
InputName=dbexec

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbfileio.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbfileio.c
InputName=dbfileio

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbfileio.c
InputName=dbfileio

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbhistry.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbhistry.c
InputName=dbhistry

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbhistry.c
InputName=dbhistry

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbinput.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbinput.c
InputName=dbinput

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbinput.c
InputName=dbinput

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbstats.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbstats.c
InputName=dbstats

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbstats.c
InputName=dbstats

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbutils.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbutils.c
InputName=dbutils

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbutils.c
InputName=dbutils

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbxface.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbxface.c
InputName=dbxface

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\COMPONENTS\DEBUGGER\dbxface.c
InputName=dbxface

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# End Group
# Begin Group "Interpreter"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\executer\exconfig.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exconfig.c
InputName=exconfig

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exconfig.c
InputName=exconfig

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exconvrt.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exconvrt.c
InputName=exconvrt

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exconvrt.c
InputName=exconvrt

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\excreate.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\excreate.c
InputName=excreate

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\excreate.c
InputName=excreate

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exdump.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exdump.c
InputName=exdump

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exdump.c
InputName=exdump

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exfield.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exfield.c
InputName=exfield

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exfield.c
InputName=exfield

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exfldio.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exfldio.c
InputName=exfldio

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exfldio.c
InputName=exfldio

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exmisc.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exmisc.c
InputName=exmisc

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exmisc.c
InputName=exmisc

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exmutex.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exmutex.c
InputName=exmutex

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exmutex.c
InputName=exmutex

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exnames.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exnames.c
InputName=exnames

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exnames.c
InputName=exnames

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exoparg1.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exoparg1.c
InputName=exoparg1

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exoparg1.c
InputName=exoparg1

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exoparg2.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exoparg2.c
InputName=exoparg2

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exoparg2.c
InputName=exoparg2

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exoparg3.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exoparg3.c
InputName=exoparg3

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exoparg3.c
InputName=exoparg3

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exoparg6.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exoparg6.c
InputName=exoparg6

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exoparg6.c
InputName=exoparg6

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exprep.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exprep.c
InputName=exprep

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exprep.c
InputName=exprep

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exregion.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exregion.c
InputName=exregion

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exregion.c
InputName=exregion

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exresnte.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exresnte.c
InputName=exresnte

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exresnte.c
InputName=exresnte

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exresolv.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exresolv.c
InputName=exresolv

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exresolv.c
InputName=exresolv

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exresop.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exresop.c
InputName=exresop

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exresop.c
InputName=exresop

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exstore.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exstore.c
InputName=exstore

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exstore.c
InputName=exstore

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exstoren.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exstoren.c
InputName=exstoren

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exstoren.c
InputName=exstoren

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exstorob.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exstorob.c
InputName=exstorob

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exstorob.c
InputName=exstorob

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exsystem.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exsystem.c
InputName=exsystem

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exsystem.c
InputName=exsystem

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exutils.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exutils.c
InputName=exutils

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\executer\exutils.c
InputName=exutils

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# End Group
# Begin Group "Parser"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\parser\psargs.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\psargs.c
InputName=psargs

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\psargs.c
InputName=psargs

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\psloop.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\psloop.c
InputName=psloop

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\psloop.c
InputName=psloop

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\psopcode.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\psopcode.c
InputName=psopcode

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\psopcode.c
InputName=psopcode

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\psparse.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\psparse.c
InputName=psparse

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\psparse.c
InputName=psparse

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\psscope.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\psscope.c
InputName=psscope

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\psscope.c
InputName=psscope

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\pstree.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\pstree.c
InputName=pstree

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\pstree.c
InputName=pstree

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\psutils.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\psutils.c
InputName=psutils

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\psutils.c
InputName=psutils

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\pswalk.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\pswalk.c
InputName=pswalk

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\pswalk.c
InputName=pswalk

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\psxface.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\psxface.c
InputName=psxface

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\parser\psxface.c
InputName=psxface

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# End Group
# Begin Group "Dispatcher"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsfield.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dsfield.c
InputName=dsfield

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dsfield.c
InputName=dsfield

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsinit.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dsinit.c
InputName=dsinit

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dsinit.c
InputName=dsinit

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsmethod.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dsmethod.c
InputName=dsmethod

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dsmethod.c
InputName=dsmethod

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsmthdat.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dsmthdat.c
InputName=dsmthdat

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dsmthdat.c
InputName=dsmthdat

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsobject.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dsobject.c
InputName=dsobject

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dsobject.c
InputName=dsobject

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsopcode.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dsopcode.c
InputName=dsopcode

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dsopcode.c
InputName=dsopcode

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsutils.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dsutils.c
InputName=dsutils

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dsutils.c
InputName=dsutils

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dswexec.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dswexec.c
InputName=dswexec

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dswexec.c
InputName=dswexec

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dswload.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dswload.c
InputName=dswload

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dswload.c
InputName=dswload

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dswscope.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dswscope.c
InputName=dswscope

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dswscope.c
InputName=dswscope

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dswstate.c

!IF  "$(CFG)" == "AcpiSubsystem64 - Win32 Release"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dswstate.c
InputName=dswstate

"AcpiSubsystem64\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /FoAcpiSubsystem64/ /WL /W4 /Wcheck /Wp64 /nologo /Qtrapuv /Wcheck /Wport /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D IA64 /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER $(InputPath)

# End Custom Build

!ELSEIF  "$(CFG)" == "AcpiSubsystem64 - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build
InputPath=..\..\source\components\dispatcher\dswstate.c
InputName=dswstate

"AcpiSubsystem64Debug\$(InputName).obj" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	icl /W4 /FoAcpiSubsystem64/ /Qms0 /Zc:forScope /WL /D ACPI_DEBUG_OUTPUT /D ACPI_DISASSEMBLER /D IA64 /Qstd=c99 /Za /Ob1 /c /I..\..\source\include /D ACPI_MACHINE_WIDTH=64 /D ACPI_LIBRARY /D ACPI_DEBUGGER /nologo /Qtrapuv /RTCu /Wcheck /Wport $(InputPath)

# End Custom Build

!ENDIF 

# End Source File
# End Group
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\..\source\Include\acconfig.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acdebug.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acdispat.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\platform\acefi.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\platform\acenv.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acevents.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acexcep.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\platform\acfreebsd.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\platform\acgcc.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acglobal.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\achware.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acinterp.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\platform\aclinux.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\aclocal.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acmacros.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\platform\acmsvc.h
# End Source File
# Begin Source File

SOURCE=..\..\source\include\acnames.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acnamesp.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acobject.h
# End Source File
# Begin Source File

SOURCE=..\..\source\include\acopcode.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acoutput.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acparser.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acpi.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acpiosxf.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acpixf.h
# End Source File
# Begin Source File

SOURCE=..\..\source\include\acpredef.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acresrc.h
# End Source File
# Begin Source File

SOURCE=..\..\source\include\acstruct.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\actables.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\actbl.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\actbl1.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\actbl2.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\actypes.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\acutils.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\platform\acwin.h
# End Source File
# Begin Source File

SOURCE=..\..\source\Include\amlcode.h
# End Source File
# End Group
# Begin Source File

SOURCE=.\AcpiSubsystem64.plg
# End Source File
# End Target
# End Project
