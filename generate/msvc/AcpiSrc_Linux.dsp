# Microsoft Developer Studio Project File - Name="AcpiSrc_Linux" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=AcpiSrc_Linux - Win32 Release
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "AcpiSrc_Linux.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "AcpiSrc_Linux.mak" CFG="AcpiSrc_Linux - Win32 Release"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "AcpiSrc_Linux - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "AcpiSrc_Linux - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "AcpiSrc_Linux - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "/acpica/generate/msvc/AcpiSrcLinux"
# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiSrcLinux"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /Gr /W4 /O2 /I "..\..\source_linux\Include" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "ACPI_DEBUG" /D "ACPI_APPLICATION" /D "_IA32" /D "ACPI_DEFINE_ALTERNATE_TYPES" /FR /FD /c
# SUBTRACT CPP /YX /Yc /Yu
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo /o"/acpica/generate/msvc/AcpiSrcLinux/AcpiSrcLinux.bsc"
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# Begin Special Build Tool
SOURCE="$(InputPath)"
PreLink_Desc=Checking existence of acpi/libraries directory
PreLink_Cmds=if NOT EXIST ..\..\libraries mkdir ..\..\libraries
PostBuild_Desc=Copy executable to libraries
PostBuild_Cmds=copy AcpiSrcLinux\AcpiSrcLinux.exe ..\..\libraries	dir ..\..\libraries\AcpiSrcLinux.exe
# End Special Build Tool

!ELSEIF  "$(CFG)" == "AcpiSrc_Linux - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "/acpica/generate/msvc/AcpiSrcLinuxDebug"
# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiSrcLinuxDebug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /Gr /W4 /Zi /Od /Gf /I "..\..\source_linux\Include" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "ACPI_DEBUG" /D "ACPI_APPLICATION" /D "_IA32" /D "ACPI_DEFINE_ALTERNATE_TYPES" /FR /FD /GZ /c
# SUBTRACT CPP /YX /Yc /Yu
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo /o"/acpica/generate/msvc/AcpiSrcLinuxDebug/AcpiSrc_LinuxDebug.bsc" /o"/acpica/generate/msvc/AcpiSrcLinuxDebug/AcpiSrcLinux.bsc"
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept /out:"/acpica/generate/msvc/AcpiSrcLinuxDebug/AcpiSrc_LinuxDebug.exe" /out:"/acpica/generate/msvc/AcpiSrcLinuxDebug\AcpiSrcLinuxDebug.exe"
# Begin Special Build Tool
SOURCE="$(InputPath)"
PreLink_Desc=Checking existence of acpi/components/libraries directory
PreLink_Cmds=if NOT EXIST ..\..\libraries mkdir ..\..\libraries
PostBuild_Desc=Copy executable to libraries
PostBuild_Cmds=copy AcpiSrcLinuxDebug\AcpiSrcLinuxdebug.exe ..\..\libraries	dir ..\..\libraries\AcpiSrcLinuxdebug.exe
# End Special Build Tool

!ENDIF 

# Begin Target

# Name "AcpiSrc_Linux - Win32 Release"
# Name "AcpiSrc_Linux - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Group "AcpiSrc_Linux"

# PROP Default_Filter ".c"
# Begin Source File

SOURCE=..\..\source_linux\TOOLS\acpisrc\ascase.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\tools\AcpiSrc\asconvrt.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\tools\AcpiSrc\asfile.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\tools\AcpiSrc\asmain.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\TOOLS\acpisrc\asremove.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\tools\AcpiSrc\asutils.c
# End Source File
# End Group
# Begin Group "Common"

# PROP Default_Filter ".c"
# Begin Source File

SOURCE=..\..\source_linux\common\getopt.c
# End Source File
# Begin Source File

SOURCE=..\..\source_linux\os_specific\SERVICE_LAYERS\oswindir.c
# End Source File
# End Group
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\..\source_linux\tools\AcpiSrc\acpisrc.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# End Target
# End Project
