/*
 *
 * Intel ACPI Component Architecture
 * ASL Optimizing Compiler version 20061011 [Oct 12 2006]
 * Copyright (C) 2000 - 2006 Intel Corporation
 * Supports ACPI Specification Revision 3.0a
 *
 * Compilation of "ssdt.asl" - Mon Oct 16 10:59:20 2006
 *
 */
    /*
     *       1....
     *       2....DefinitionBlock(
     *       3....    "ssdt.aml",   ** Output filename
     *       4....    "SSDT",     ** Signature
     *       5....    0x02,       ** DSDT Revision
     *       6....    "Intel",    ** OEMID
     *       7....    "Many",     ** TABLE ID
     *       8....    0x00000001  ** OEM Revision
     *       9....    ) {
     */
    unsigned char    SSDT_Many_Header [] =
    {
        0x53,0x53,0x44,0x54,0x42,0x00,0x00,0x00,0x02,0x81,0x49,0x6E,0x74,0x65,0x6C,0x00,    /* 00000000    "SSDTB.....Intel." */
        0x4D,0x61,0x6E,0x79,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,    /* 00000010    "Many........INTL" */
        0x11,0x10,0x06,0x20,                                                                /* 00000014    "... " */
    };

    /*
     *      10....
     *      11....    Device(AUXD) {
     */
    unsigned char    SSDT_Many_AUXD [] =
    {
        0x5B,0x82,0x1C,0x41,0x55,0x58,0x44,                                                 /* 0000001B    "[..AUXD" */
    };

    /*
     *      12....        Method(M000) {Return ("\\AUXD.M000 ()")}
     */
    unsigned char    SSDT_Many_AUXD_M000 [] =
    {
        0x14,0x16,0x4D,0x30,0x30,0x30,0x00,                                                 /* 00000022    "..M000." */
        0xA4,0x0D,0x5C,0x41,0x55,0x58,0x44,0x2E,0x4D,0x30,0x30,0x30,0x20,0x28,0x29,0x00,    /* 00000032    "..\AUXD.M000 ()." */
    /*
     *      13....    }
     *      14....}
     *      15....
     */
    };

