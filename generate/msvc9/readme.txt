/*
 * Generation of ACPICA with MS Visual Studio 2008
 */
Last update 9 December 2013.


The Visual Studio project file (for Visual Studio 2008)
appears in this directory:

    generate/msvc9/AcpiComponents.sln

ACPICA generates with all MS C language extensions disabled, since the
code is ANSI conformant and is meant to be highly portable.

There are a couple of include files in MS Visual Studio 2008 that
unfortunately contain non-ANSI "//" style comments. These will be flagged
as warnings since language extensions are disabled.

The VC include files are under one of these directories:

    \Program Files\Microsoft Visual Studio 9.0\VC\include
    \Program Files (x86)\Microsoft Visual Studio 9.0\VC\include

To eliminate these warnings, modify each of these include files:

    sal.h
    stdlib.h

For each file, add this statement to the start of the file:

    #pragma warning( disable : 4001 ) /* no warning about "//" comments */

and add this statement to the end of the file:

    #pragma warning( default : 4001 )

For stdlib.h, you may also need to disable warning 4001 again before this line, near line 774:

    #pragma warning (disable:6540) // the functions below have declspecs in their declarations in the windows headers, causing PREfast to fire 6540 here


Note: you may have to change the permissions on these files in order
to write to them.
