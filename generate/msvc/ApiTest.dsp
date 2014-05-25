# Microsoft Developer Studio Project File - Name="ApiTest" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=ApiTest - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "ApiTest.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "ApiTest.mak" CFG="ApiTest - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "ApiTest - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "ApiTest - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""$/Acpi/Generate/msvc", SVBAAAAA"
# PROP Scc_LocalPath "."
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "ApiTest - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "ApiTest\NoDebug"
# PROP Intermediate_Dir "ApiTest\NoDebug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /Gz /MT /W4 /GX /O1 /Ob0 /I "..\..\source\include" /D "NDEBUG" /D "WIN32" /D "WIN32_LEAN_AND_MEAN" /D "_CONSOLE" /D "_MBCS" /D "ACPI_EXEC_APP" /D "ACPI_LIBRARY" /D "ACPI_APITS" /FR /FD /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /map /machine:I386 /out:"bin/ApiTest.exe"
# Begin Special Build Tool
SOURCE="$(InputPath)"
PreLink_Desc=Checking existence of acpi/libraries directory
PreLink_Cmds=if NOT EXIST ..\..\libraries mkdir ..\..\libraries
PostBuild_Desc=Copy executable to acpi/libraries
PostBuild_Cmds=copy bin\apitest.exe ..\..\libraries\apitest.exe	dir ..\..\libraries\ApiTest.exe
# End Special Build Tool

!ELSEIF  "$(CFG)" == "ApiTest - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "ApiTest\Debug"
# PROP Intermediate_Dir "ApiTest\Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /Gz /MT /W4 /Gm /ZI /Oa /Os /Oy /I "..\..\source\include" /D "WIN32" /D "WIN32_LEAN_AND_MEAN" /D "_CONSOLE" /D "_MBCS" /D "ACPI_EXEC_APP" /D "ACPI_LIBRARY" /D "ACPI_APITS" /FR /FD /D /GZ /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo /o"ApiTest\Debug\ApiTestDebug.bsc"
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 libcmtd.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /map /debug /machine:I386 /nodefaultlib:"libcmt.lib" /out:"bin/ApiTestDebug.exe" /pdbtype:sept
# SUBTRACT LINK32 /verbose
# Begin Special Build Tool
SOURCE="$(InputPath)"
PreLink_Desc=Checking existence of acpi/libraries directory
PreLink_Cmds=if NOT EXIST ..\..\libraries mkdir ..\..\libraries
PostBuild_Desc=Copy executable to acpi/libraries
PostBuild_Cmds=copy bin\apitestdebug.exe ..\..\libraries\apitestdebug.exe	dir ..\..\libraries\ApiTestdebug.exe
# End Special Build Tool

!ENDIF 

# Begin Target

# Name "ApiTest - Win32 Release"
# Name "ApiTest - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Group "Utilities"

# PROP Default_Filter ".c"
# Begin Source File

SOURCE=..\..\source\components\utilities\utalloc.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utcache.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utclib.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utcopy.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utdebug.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utdelete.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\uteval.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utglobal.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utids.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utinit.c
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

!IF  "$(CFG)" == "ApiTest - Win32 Release"

!ELSEIF  "$(CFG)" == "ApiTest - Win32 Debug"

# ADD CPP /Za /FAcs

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

SOURCE=..\..\source\components\utilities\utresrc.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utstate.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\uttrack.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utxface.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\utilities\utxferror.c
# End Source File
# End Group
# Begin Group "Interpreter"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\executer\exconfig.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exconvrt.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\excreate.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exdebug.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exdump.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exfield.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exfldio.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exmisc.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exmutex.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exnames.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exoparg1.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exoparg2.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exoparg3.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exoparg6.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exprep.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exregion.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exresnte.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exresolv.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exresop.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exstore.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exstoren.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exstorob.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exsystem.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\executer\exutils.c
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

SOURCE=..\..\source\COMPONENTS\NAMESPACE\nsdumpdv.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nseval.c
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

SOURCE=..\..\source\COMPONENTS\NAMESPACE\nsparse.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nspredef.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsrepair.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\namespace\nsrepair2.c
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

SOURCE=..\..\source\COMPONENTS\NAMESPACE\nsxfeval.c
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
# Begin Group "Hardware"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\hardware\hwacpi.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\hardware\hwgpe.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\hardware\hwpci.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\hardware\hwregs.c
# End Source File
# Begin Source File

SOURCE=..\..\Source\components\hardware\hwsleep.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\hardware\hwtimer.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\hardware\hwvalid.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\hardware\hwxface.c
# End Source File
# End Group
# Begin Group "Events"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\events\evevent.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\EVENTS\evgpe.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\EVENTS\evgpeblk.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evgpeinit.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evgpeutil.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evmisc.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evregion.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evrgnini.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evsci.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evxface.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evxfevnt.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evxfgpe.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\events\evxfregn.c
# End Source File
# End Group
# Begin Group "Debugger"

# PROP Default_Filter ".c"
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbcmds.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbdisply.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbexec.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbfileio.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbhistry.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbinput.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbstats.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbutils.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\DEBUGGER\dbxface.c
# End Source File
# End Group
# Begin Group "Dispatcher"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsfield.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\DISPATCHER\dsinit.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsmethod.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsmthdat.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsobject.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsopcode.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dsutils.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\dispatcher\dswexec.c
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
# Begin Group "Tables"

# PROP Default_Filter ".c"
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
# Begin Group "Common"

# PROP Default_Filter ".c"
# Begin Source File

SOURCE=..\..\source\common\getopt.c
# End Source File
# End Group
# Begin Group "Resources"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\components\resources\rsaddr.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rscalc.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rscreate.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsdump.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsinfo.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsio.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsirq.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rslist.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsmemory.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsmisc.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsutils.c
# End Source File
# Begin Source File

SOURCE=..\..\source\components\resources\rsxface.c
# End Source File
# End Group
# Begin Group "Disassembler"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmbuffer.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmnames.c
# End Source File
# Begin Source File

SOURCE=..\..\SOURCE\COMPONENTS\disassembler\dmobject.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmopcode.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmresrc.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmresrcl.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmresrcs.c
# End Source File
# Begin Source File

SOURCE=..\..\source\common\dmtbinfo.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmutils.c
# End Source File
# Begin Source File

SOURCE=..\..\source\COMPONENTS\Disassembler\dmwalk.c
# End Source File
# End Group
# Begin Group "ApiTest"

# PROP Default_Filter ""
# Begin Group "Spec"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\tests\aapits\spec\concepts.txt
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\spec\fixed.txt
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\spec\general.txt
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\spec\handlers.txt
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\spec\hardware.txt
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\spec\init.txt
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\spec\memory.txt
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\spec\namespace.txt
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\spec\README
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\spec\resource.txt
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\spec\table.txt
# End Source File
# End Group
# Begin Group "bin"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\tests\aapits\bin\aapitsrun
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\bin\README
# End Source File
# End Group
# Begin Group "asl"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\tests\aapits\asl\dsdt.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\dsdt0.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\dsdt1.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\dsdt2.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\gpev0000.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\hdwr0015.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\hdwr0018.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\hdwr0019.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\hdwr0020.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\hdwr0022.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\hdwr0040.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\hdwr0041.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\hndl0000.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\hndl0015.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\hndl0016.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\hndl0038.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\hndl0115.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\init0030.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\init0032.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\init0034.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\init0058.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\init0059.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\init0066.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\init0121.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\init1065.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\Makefile
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0000.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0010.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0011.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0012.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0013.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0014.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0015.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0016.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0017.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0018.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0019.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0020.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0021.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0022.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0023.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0025.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0037.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0038.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0052.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0074.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0089.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\nmsp0126.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\README
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\rt0000.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\rt0035.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\rt0036.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\ssdt1.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\ssdt2.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\ssdt_aux.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\tblm0037.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\tblm0047.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\tblm0058.asl
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\asl\tblm_aux.asl
# End Source File
# End Group
# Begin Source File

SOURCE=..\..\tests\aapits\atexec.c
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\atfixedevent.c
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\atgpe.c
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\athandlers.c
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\athardware.c
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\atinit.c
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\atmain.c
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\atmemory.c
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\atnamespace.c
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\atosxfctrl.c
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\atosxfwrap.c
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\atresource.c
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\attable.c
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\oswinxf.c
# End Source File
# Begin Source File

SOURCE=..\..\tests\aapits\README
# End Source File
# End Group
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# End Target
# End Project
