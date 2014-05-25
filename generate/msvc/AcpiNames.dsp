# Microsoft Developer Studio Project File - Name="AcpiNames" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=AcpiNames - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "AcpiNames.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "AcpiNames.mak" CFG="AcpiNames - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "AcpiNames - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "AcpiNames - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "AcpiNames - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "/acpica/generate/msvc/AcpiNames"
# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiNames"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /Gr /Za /W4 /Gi /GX /O2 /I "..\..\source\Include" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "ACPI_APPLICATION" /D "ACPI_SINGLE_THREADED" /D "ACPI_DEBUGGER" /FR /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=copy AcpiNames\AcpiNames.exe ..\..\libraries
# End Special Build Tool

!ELSEIF  "$(CFG)" == "AcpiNames - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "/acpica/generate/msvc/AcpiNamesDebug"
# PROP Intermediate_Dir "/acpica/generate/msvc/AcpiNamesDebug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /Gr /Za /W4 /Gm /Gi /GX /ZI /Od /I "..\..\source\Include" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "ACPI_APPLICATION" /D "ACPI_SINGLE_THREADED" /D "ACPI_DEBUGGER" /FR /FD /GZ /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=copy AcpiNamesdebug\AcpiNames.exe ..\..\libraries\AcpiNamesdebug.exe
# End Special Build Tool

!ENDIF 

# Begin Target

# Name "AcpiNames - Win32 Release"
# Name "AcpiNames - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Group "Common"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\common\getopt.c
# End Source File
# Begin Source File

SOURCE=..\..\source\os_specific\service_layers\oswinxf.c
# ADD CPP /Ze
# End Source File
# End Group
# Begin Group "Utilities"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\utilities\utalloc.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utcache.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utdelete.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utglobal.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utlock.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utmath.c
# ADD CPP /Ze
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utmisc.c

!IF  "$(CFG)" == "AcpiNames - Win32 Release"

!ELSEIF  "$(CFG)" == "AcpiNames - Win32 Debug"

# ADD CPP /Za

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utmutex.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utobject.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utosi.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utstate.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utxface.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utxferror.c
# End Source File
# End Group
# Begin Group "Tables"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\tables\tbfadt.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\tables\tbfind.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\tables\tbinstal.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\tables\tbutils.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\tables\tbxface.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\tables\tbxfroot.c
# End Source File
# End Group
# Begin Group "Namespace"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\namespace\nsaccess.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsalloc.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsdump.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsinit.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsload.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsnames.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsobject.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsparse.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nssearch.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsutils.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nswalk.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsxfeval.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsxfname.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsxfobj.c
# End Source File
# End Group
# Begin Group "Parser"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\parser\psargs.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\psloop.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\psopcode.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\psparse.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\psscope.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\pstree.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\psutils.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\pswalk.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\parser\psxface.c
# End Source File
# End Group
# Begin Group "Debugger"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\debugger\dbfileio.c
# End Source File
# End Group
# Begin Group "Dispatcher"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsfield.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsmthdat.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsobject.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsutils.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dswload.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dswscope.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dswstate.c
# End Source File
# End Group
# Begin Group "Interpreter"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\executer\excreate.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exnames.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exresnte.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exresolv.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exutils.c
# End Source File
# End Group
# Begin Source File

SOURCE=..\..\source\tools\AcpiNames\anmain.c
# End Source File
# Begin Source File

SOURCE=..\..\source\tools\AcpiNames\anstubs.c
# End Source File
# Begin Source File

SOURCE=..\..\source\tools\AcpiNames\antables.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\..\source\tools\AcpiNames\AcpiNames.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# End Target
# End Project
