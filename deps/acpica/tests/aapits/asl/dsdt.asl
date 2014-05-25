/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20060217
 *
 * Disassembly of dsdt.dat, Thu Mar  9 15:54:05 2006
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x0000685F (26719)
 *     Revision         0x01
 *     OEM ID           "INTEL "
 *     OEM Table ID     "CALISTGA"
 *     OEM Revision     0x06040000 (100925440)
 *     Creator ID       "INTL"
 *     Creator Revision 0x20050624 (537200164)
 */
DefinitionBlock ("dsdt.aml", "DSDT", 1, "INTEL ", "CALISTGA", 0x06040000)
{
    External (\CFGD, IntObj)
    External (\PDC0, IntObj)
    External (\PDC1, IntObj)

    OperationRegion (PRT0, SystemIO, 0x80, 0x04)
    Field (PRT0, DWordAcc, Lock, Preserve)
    {
        P80H,   32
    }

    OperationRegion (S_IO, SystemIO, 0x06B0, 0x11)
    Field (S_IO, ByteAcc, NoLock, Preserve)
    {
        PMS0,   8,
        PME0,   8,
        PMS1,   8,
        PMS2,   8,
        PMS3,   8,
        PME1,   8,
        PME2,   8,
        PME3,   8,
        SMS1,   8,
        SMS2,   8,
        SME1,   8,
        SME2,   8,
        RT10,   1,
        RT11,   1,
            ,   1,
        RT13,   1,
        Offset (0x0E),
        RT30,   1,
        RT31,   1,
        RT32,   1,
        RT33,   1,
        RT34,   1,
        RT35,   1,
        RT36,   1,
        RT37,   1,
        Offset (0x10),
        DLPC,   1,
        CK33,   1,
        CK14,   1
    }

    OperationRegion (IO_T, SystemIO, 0x0800, 0x10)
    Field (IO_T, ByteAcc, NoLock, Preserve)
    {
        Offset (0x02),
        Offset (0x04),
        Offset (0x06),
        Offset (0x08),
        TRP0,   8,
        Offset (0x0A),
        Offset (0x0B),
        Offset (0x0C),
        Offset (0x0D),
        Offset (0x0E),
        Offset (0x0F),
        Offset (0x10)
    }

    OperationRegion (PMIO, SystemIO, 0x1000, 0x80)
    Field (PMIO, ByteAcc, NoLock, Preserve)
    {
        Offset (0x42),
            ,   1,
        GPEC,   1
    }

    OperationRegion (GPIO, SystemIO, 0x1180, 0x3C)
    Field (GPIO, ByteAcc, NoLock, Preserve)
    {
        GU00,   8,
        GU01,   8,
        GU02,   8,
        GU03,   8,
        GIO0,   8,
        GIO1,   8,
        GIO2,   8,
        GIO3,   8,
        Offset (0x0C),
        GL00,   8,
            ,   4,
        GP12,   1,
        Offset (0x0E),
        GL02,   8,
        GL03,   8,
        Offset (0x18),
        GB00,   8,
        GB01,   8,
        GB02,   8,
        GB03,   8,
        Offset (0x2C),
        GIV0,   8,
        GIV1,   8,
        GIV2,   8,
        GIV3,   8,
        GU04,   8,
        GU05,   8,
        GU06,   8,
        GU07,   8,
        GIO4,   8,
        GIO5,   8,
        GIO6,   8,
        GIO7,   8,
            ,   7,
        GP39,   1,
        GL05,   8,
        GL06,   8,
        GL07,   8
    }

    OperationRegion (GNVS, SystemMemory, 0x3F692E4C, 0x0100)
    Field (GNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16,
        SMIF,   8,
        PRM0,   8,
        PRM1,   8,
        SCIF,   8,
        PRM2,   8,
        PRM3,   8,
        LCKF,   8,
        PRM4,   8,
        PRM5,   8,
        P80D,   32,
        LIDS,   8,
        PWRS,   8,
        DBGS,   8,
        Offset (0x14),
        ACTT,   8,
        PSVT,   8,
        TC1V,   8,
        TC2V,   8,
        TSPV,   8,
        CRTT,   8,
        DTSE,   8,
        DTS1,   8,
        DTS2,   8,
        Offset (0x1E),
        BNUM,   8,
        B0SC,   8,
        B1SC,   8,
        B2SC,   8,
        B0SS,   8,
        B1SS,   8,
        B2SS,   8,
        Offset (0x28),
        APIC,   8,
        MPEN,   8,
        PPCS,   8,
        PPCM,   8,
        Offset (0x32),
        NATP,   8,
        CMAP,   8,
        CMBP,   8,
        LPTP,   8,
        FDCP,   8,
        CMCP,   8,
        CIRP,   8,
        Offset (0x3C),
        IGDS,   8,
        TLST,   8,
        CADL,   8,
        PADL,   8,
        CSTE,   16,
        NSTE,   16,
        SSTE,   16,
        NDID,   8,
        DID1,   32,
        DID2,   32,
        DID3,   32,
        DID4,   32,
        DID5,   32,
        Offset (0x67),
        BLCS,   8,
        BRTL,   8,
        ALSE,   8,
        ALAF,   8,
        LLOW,   8,
        LHIH,   8,
        Offset (0x6E),
        EMAE,   8,
        EMAP,   16,
        EMAL,   16,
        ECPC,   8,
        MEFE,   8,
        Offset (0x82),
        GTF0,   56,
        GTF2,   56,
        IDEM,   8
    }

    OperationRegion (RCRB, SystemMemory, 0xFED1C000, 0x4000)
    Field (RCRB, DWordAcc, Lock, Preserve)
    {
        Offset (0x1000),
        Offset (0x3000),
        Offset (0x3404),
        HPAS,   2,
            ,   5,
        HPAE,   1,
        Offset (0x3418),
            ,   1,
        PATD,   1,
        SATD,   1,
        SMBD,   1,
        HDAD,   1,
        A97D,   1,
        Offset (0x341A),
        RP1D,   1,
        RP2D,   1,
        RP3D,   1,
        RP4D,   1,
        RP5D,   1,
        RP6D,   1
    }

    Mutex (MUTX, 0x00)
    Name (_S0, Package (0x03)
    {
        Zero,
        Zero,
        Zero
    })
    Name (_S3, Package (0x03)
    {
        0x05,
        0x05,
        Zero
    })
    Name (_S4, Package (0x03)
    {
        0x06,
        0x06,
        Zero
    })
    Name (_S5, Package (0x03)
    {
        0x07,
        0x07,
        Zero
    })
    Scope (_PR)
    {
        Processor (CPU0, 0x00, 0x00001010, 0x06) {}
        Processor (CPU1, 0x01, 0x00001010, 0x06)
        {
            Method (_INI, 0, NotSerialized)
            {
                If (DTSE)
                {
                    TRAP (0x46)
                }
            }
        }
    }

    Name (DSEN, One)
    Name (ECON, Zero)
    Name (GPIC, Zero)
    Name (CTYP, Zero)
    Name (L01C, Zero)
    Name (VFN0, Zero)
    Name (VFN1, Zero)
    Method (_PIC, 1, NotSerialized)
    {
        Store (Arg0, GPIC)
    }

    Method (_PTS, 1, NotSerialized)
    {
        Store (Zero, P80D)
        P8XH (Zero, Arg0)
        If (LEqual (DBGS, Zero))
        {
            Store (Zero, RT10)
            Store (0x20, PME1)
            Store (One, PME0)
            Store (0x20, PMS1)
            Store (One, PMS0)
        }
    }

    Method (_WAK, 1, NotSerialized)
    {
        P8XH (Zero, Zero)
        If (LEqual (Arg0, 0x03))
        {
            If (LAnd (DTSE, MPEN))
            {
                TRAP (0x46)
            }
        }

        If (LOr (LEqual (Arg0, 0x03), LEqual (Arg0, 0x04)))
        {
            If (And (CFGD, 0x01000000))
            {
                If (LAnd (And (CFGD, 0xF0), LAnd (LEqual (OSYS, 0x07D1), LNot (And (PDC0, 0x10)))))
                {
                    TRAP (0x3D)
                }

                If (LAnd (And (CFGD, One), LEqual (And (PDC0, 0x29), 0x29)))
                {
                    TRAP (0x3E)
                }
            }
        }

        If (LEqual (Arg0, 0x03))
        {
            If (LEqual (Zero, ACTT))
            {
                Store (Zero, \_SB.PCI0.LPCB.H_EC.CFAN)
            }
        }

        If (LAnd (LEqual (Arg0, 0x04), LEqual (OSYS, 0x07D1)))
        {
            If (And (CFGD, One))
            {
                If (LGreater (PPCS, Zero))
                {
                    Subtract (PPCS, One, PPCS)
                    PNOT ()
                    Add (PPCS, One, PPCS)
                    PNOT ()
                }
                Else
                {
                    Add (PPCS, One, PPCS)
                    PNOT ()
                    Subtract (PPCS, One, PPCS)
                    PNOT ()
                }
            }
        }

        Notify (\_SB.PCI0, Zero)
        Return (Package (0x02)
        {
            Zero,
            Zero
        })
    }

    Scope (_GPE)
    {
        Method (_L01, 0, NotSerialized)
        {
            Add (L01C, One, L01C)
            P8XH (Zero, One)
            P8XH (One, L01C)
            Sleep (0x64)
            If (LAnd (LEqual (RP1D, Zero), \_SB.PCI0.RP01.HPCS))
            {
                If (\_SB.PCI0.RP01.PDC1)
                {
                    Store (One, \_SB.PCI0.RP01.PDC1)
                    Store (One, \_SB.PCI0.RP01.HPCS)
                    Notify (\_SB.PCI0.RP01, Zero)
                }
                Else
                {
                    Store (One, \_SB.PCI0.RP01.HPCS)
                }
            }

            If (LAnd (LEqual (RP2D, Zero), \_SB.PCI0.RP02.HPCS))
            {
                If (\_SB.PCI0.RP02.PDC2)
                {
                    Store (One, \_SB.PCI0.RP02.PDC2)
                    Store (One, \_SB.PCI0.RP02.HPCS)
                    Notify (\_SB.PCI0.RP02, Zero)
                }
                Else
                {
                    Store (One, \_SB.PCI0.RP02.HPCS)
                }
            }

            If (LAnd (LEqual (RP3D, Zero), \_SB.PCI0.RP03.HPCS))
            {
                If (\_SB.PCI0.RP03.PDC3)
                {
                    Store (One, \_SB.PCI0.RP03.PDC3)
                    Store (One, \_SB.PCI0.RP03.HPCS)
                    Notify (\_SB.PCI0.RP03, Zero)
                }
                Else
                {
                    Store (One, \_SB.PCI0.RP03.HPCS)
                }
            }

            If (LAnd (LEqual (RP4D, Zero), \_SB.PCI0.RP04.HPCS))
            {
                If (\_SB.PCI0.RP04.PDC4)
                {
                    Store (One, \_SB.PCI0.RP04.PDC4)
                    Store (One, \_SB.PCI0.RP04.HPCS)
                    Notify (\_SB.PCI0.RP04, Zero)
                }
                Else
                {
                    Store (One, \_SB.PCI0.RP04.HPCS)
                }
            }

            If (LAnd (LEqual (RP5D, Zero), \_SB.PCI0.RP05.HPCS))
            {
                If (\_SB.PCI0.RP05.PDC5)
                {
                    Store (One, \_SB.PCI0.RP05.PDC5)
                    Store (One, \_SB.PCI0.RP05.HPCS)
                    Notify (\_SB.PCI0.RP05, Zero)
                }
                Else
                {
                    Store (One, \_SB.PCI0.RP05.HPCS)
                }
            }

            If (LAnd (LEqual (RP6D, Zero), \_SB.PCI0.RP06.HPCS))
            {
                If (\_SB.PCI0.RP06.PDC6)
                {
                    Store (One, \_SB.PCI0.RP06.PDC6)
                    Store (One, \_SB.PCI0.RP06.HPCS)
                    Notify (\_SB.PCI0.RP06, Zero)
                }
                Else
                {
                    Store (One, \_SB.PCI0.RP06.HPCS)
                }
            }
        }

        Method (_L02, 0, NotSerialized)
        {
            Store (Zero, GPEC)
            Notify (\_TZ.TZ01, 0x80)
        }

        Method (_L03, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB1, 0x02)
        }

        Method (_L04, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB2, 0x02)
        }

        Method (_L05, 0, NotSerialized)
        {
            If (HDAD)
            {
                Notify (\_SB.PCI0.MODM, 0x02)
            }
            Else
            {
                Notify (\_SB.PCI0.HDEF, 0x02)
            }
        }

        Method (_L07, 0, NotSerialized)
        {
            Store (0x20, \_SB.PCI0.SBUS.HSTS)
        }

        Method (_L08, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.LPCB.N207.UART, 0x02)
        }

        Method (_L09, 0, NotSerialized)
        {
            If (\_SB.PCI0.RP01.PSP1)
            {
                Store (One, \_SB.PCI0.RP01.PSP1)
                Store (One, \_SB.PCI0.RP01.PMCS)
                Notify (\_SB.PCI0.RP01, 0x02)
            }

            If (\_SB.PCI0.RP02.PSP2)
            {
                Store (One, \_SB.PCI0.RP02.PSP2)
                Store (One, \_SB.PCI0.RP02.PMCS)
                Notify (\_SB.PCI0.RP02, 0x02)
            }

            If (\_SB.PCI0.RP03.PSP3)
            {
                Store (One, \_SB.PCI0.RP03.PSP3)
                Store (One, \_SB.PCI0.RP03.PMCS)
                Notify (\_SB.PCI0.RP03, 0x02)
            }

            If (\_SB.PCI0.RP04.PSP4)
            {
                Store (One, \_SB.PCI0.RP04.PSP4)
                Store (One, \_SB.PCI0.RP04.PMCS)
                Notify (\_SB.PCI0.RP04, 0x02)
            }

            If (\_SB.PCI0.RP05.PSP5)
            {
                Store (One, \_SB.PCI0.RP05.PSP5)
                Store (One, \_SB.PCI0.RP05.PMCS)
                Notify (\_SB.PCI0.RP05, 0x02)
            }

            If (\_SB.PCI0.RP06.PSP6)
            {
                Store (One, \_SB.PCI0.RP06.PSP6)
                Store (One, \_SB.PCI0.RP06.PMCS)
                Notify (\_SB.PCI0.RP06, 0x02)
            }
        }

        Method (_L0B, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.PCIB, 0x02)
        }

        Method (_L0C, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB3, 0x02)
        }

        Method (_L0D, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB7, 0x02)
        }

        Method (_L0E, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB4, 0x02)
        }

        Method (_L1D, 0, NotSerialized)
        {
            If (LNot (LEqual (LIDS, \_SB.PCI0.LPCB.H_EC.LSTE)))
            {
                Store (\_SB.PCI0.LPCB.H_EC.LSTE, LIDS)
                If (IGDS)
                {
                    LSDS (LIDS)
                }

                Notify (\_SB.LID0, 0x80)
            }
            Else
            {
                If (LEqual (BNUM, Zero))
                {
                    If (LNot (LEqual (PWRS, \_SB.PCI0.LPCB.H_EC.VPWR)))
                    {
                        Store (\_SB.PCI0.LPCB.H_EC.VPWR, PWRS)
                        TRAP (0x2B)
                        PNOT ()
                    }
                }
            }
        }
    }

    Method (BRTW, 1, Serialized)
    {
        Store (Arg0, Local1)
        If (LEqual (ALSE, 0x02))
        {
            Store (Divide (Multiply (ALAF, Arg0), 0x64, ), Local1)
            If (LGreater (Local1, 0x64))
            {
                Store (0x64, Local1)
            }
        }

        Store (Divide (Multiply (0xFF, Local1), 0x64, ), Local0)
        Store (Local0, PRM0)
        If (LEqual (TRAP (0x12), Zero))
        {
            P8XH (0x02, Local0)
            Store (Arg0, BRTL)
        }
    }

    Method (BTTM, 1, Serialized)
    {
        If (PWRS)
        {
            If (LNot (LLess (Arg0, B0SC)))
            {
                Store (Arg0, B0SC)
                Notify (\_SB.BAT0, 0x80)
            }
        }
        Else
        {
            If (LNot (LGreater (Arg0, B0SC)))
            {
                Store (Arg0, B0SC)
                Notify (\_SB.BAT0, 0x80)
            }
        }
    }

    Method (GETB, 3, Serialized)
    {
        Multiply (Arg0, 0x08, Local0)
        Multiply (Arg1, 0x08, Local1)
        CreateField (Arg2, Local0, Local1, TBF3)
        Return (TBF3)
    }

    Method (HKDS, 1, Serialized)
    {
        If (LEqual (Zero, DSEN))
        {
            If (LEqual (TRAP (Arg0), Zero))
            {
                If (LNot (LEqual (CADL, PADL)))
                {
                    Store (CADL, PADL)
                    If (LEqual (OSYS, 0x07D1))
                    {
                        Notify (\_SB.PCI0, Zero)
                    }
                    Else
                    {
                        Notify (\_SB.PCI0.GFX0, Zero)
                    }

                    Sleep (0x02EE)
                }

                Notify (\_SB.PCI0.GFX0, 0x80)
            }
        }

        If (LEqual (One, DSEN))
        {
            If (LEqual (TRAP (Increment (Arg0)), Zero))
            {
                Notify (\_SB.PCI0.GFX0, 0x81)
            }
        }
    }

    Method (LSDS, 1, Serialized)
    {
        If (Arg0)
        {
            HKDS (0x0C)
        }
        Else
        {
            HKDS (0x0E)
        }

        If (LNot (LEqual (DSEN, One)))
        {
            Sleep (0x32)
            While (LEqual (DSEN, 0x02))
            {
                Sleep (0x32)
            }
        }
    }

    Method (P8XH, 2, Serialized)
    {
        If (LEqual (Arg0, Zero))
        {
            Store (Or (And (P80D, 0xFFFFFF00), Arg1), P80D)
        }

        If (LEqual (Arg0, One))
        {
            Store (Or (And (P80D, 0xFFFF00FF), ShiftLeft (Arg1, 0x08)), P80D)
        }

        If (LEqual (Arg0, 0x02))
        {
            Store (Or (And (P80D, 0xFF00FFFF), ShiftLeft (Arg1, 0x10)), P80D)
        }

        If (LEqual (Arg0, 0x03))
        {
            Store (Or (And (P80D, 0x00FFFFFF), ShiftLeft (Arg1, 0x18)), P80D)
        }

        Store (P80D, P80H)
    }

    Method (PNOT, 0, Serialized)
    {
        If (MPEN)
        {
            If (And (PDC0, 0x08))
            {
                Notify (\_PR.CPU0, 0x80)
                If (And (PDC0, 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU0, 0x81)
                }
            }

            If (And (PDC1, 0x08))
            {
                Notify (\_PR.CPU1, 0x80)
                If (And (PDC1, 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU1, 0x81)
                }
            }
        }
        Else
        {
            Notify (\_PR.CPU0, 0x80)
            Sleep (0x64)
            Notify (\_PR.CPU0, 0x81)
        }

        Store (\_SB.PCI0.LPCB.H_EC.B1CC, B1SC)
        Store (\_SB.PCI0.LPCB.H_EC.B1ST, B1SS)
        Store (\_SB.PCI0.LPCB.H_EC.B2CC, B2SC)
        Store (\_SB.PCI0.LPCB.H_EC.B2ST, B2SS)
        Notify (\_SB.BAT0, 0x80)
        Notify (\_SB.BAT1, 0x80)
        Notify (\_SB.BAT2, 0x80)
    }

    Method (TRAP, 1, Serialized)
    {
        Store (Arg0, SMIF)
        Store (Zero, TRP0)
        Return (SMIF)
    }

    Method (GETP, 1, Serialized)
    {
        If (LEqual (And (Arg0, 0x09), Zero))
        {
            Return (Ones)
        }

        If (LEqual (And (Arg0, 0x09), 0x08))
        {
            Return (0x0384)
        }

        ShiftRight (And (Arg0, 0x0300), 0x08, Local0)
        ShiftRight (And (Arg0, 0x3000), 0x0C, Local1)
        Return (Multiply (0x1E, Subtract (0x09, Add (Local0, Local1))))
    }

    Method (GDMA, 5, Serialized)
    {
        If (Arg0)
        {
            If (LAnd (Arg1, Arg4))
            {
                Return (0x14)
            }

            If (LAnd (Arg2, Arg4))
            {
                Return (Multiply (Subtract (0x04, Arg3), 0x0F))
            }

            Return (Multiply (Subtract (0x04, Arg3), 0x1E))
        }

        Return (Ones)
    }

    Method (GETT, 1, Serialized)
    {
        Return (Multiply (0x1E, Subtract (0x09, Add (And (ShiftRight (Arg0, 0x02), 0x03), And (Arg0, 0x03)))))
    }

    Method (GETF, 3, Serialized)
    {
        Name (TMPF, Zero)
        If (Arg0)
        {
            Or (TMPF, One, TMPF)
        }

        If (And (Arg2, 0x02))
        {
            Or (TMPF, 0x02, TMPF)
        }

        If (Arg1)
        {
            Or (TMPF, 0x04, TMPF)
        }

        If (And (Arg2, 0x20))
        {
            Or (TMPF, 0x08, TMPF)
        }

        If (And (Arg2, 0x4000))
        {
            Or (TMPF, 0x10, TMPF)
        }

        Return (TMPF)
    }

    Method (SETP, 3, Serialized)
    {
        If (LGreater (Arg0, 0xF0))
        {
            Return (0x08)
        }
        Else
        {
            If (And (Arg1, 0x02))
            {
                If (LAnd (LNot (LGreater (Arg0, 0x78)), And (Arg2, 0x02)))
                {
                    Return (0x2301)
                }

                If (LAnd (LNot (LGreater (Arg0, 0xB4)), And (Arg2, One)))
                {
                    Return (0x2101)
                }
            }

            Return (0x1001)
        }
    }

    Method (SDMA, 1, Serialized)
    {
        If (LNot (LGreater (Arg0, 0x14)))
        {
            Return (One)
        }

        If (LNot (LGreater (Arg0, 0x1E)))
        {
            Return (0x02)
        }

        If (LNot (LGreater (Arg0, 0x2D)))
        {
            Return (One)
        }

        If (LNot (LGreater (Arg0, 0x3C)))
        {
            Return (0x02)
        }

        If (LNot (LGreater (Arg0, 0x5A)))
        {
            Return (One)
        }

        Return (Zero)
    }

    Method (SETT, 3, Serialized)
    {
        If (And (Arg1, 0x02))
        {
            If (LAnd (LNot (LGreater (Arg0, 0x78)), And (Arg2, 0x02)))
            {
                Return (0x0B)
            }

            If (LAnd (LNot (LGreater (Arg0, 0xB4)), And (Arg2, One)))
            {
                Return (0x09)
            }
        }

        Return (0x04)
    }

    Scope (_TZ)
    {
        PowerResource (FN00, 0x00, 0x0000)
        {
            Method (_STA, 0, Serialized)
            {
                Return (VFN0)
            }

            Method (_ON, 0, Serialized)
            {
                Store (One, VFN0)
                If (ECON)
                {
                    Store (One, \_SB.PCI0.LPCB.H_EC.CFAN)
                }
            }

            Method (_OFF, 0, Serialized)
            {
                Store (Zero, VFN0)
                If (ECON)
                {
                    Store (Zero, \_SB.PCI0.LPCB.H_EC.CFAN)
                }
            }
        }

        Device (FAN0)
        {
            Name (_HID, EisaId ("PNP0C0B"))
            Name (_UID, Zero)
            Name (_PR0, Package (0x01)
            {
                FN00
            })
        }

        ThermalZone (TZ00)
        {
            Method (_CRT, 0, Serialized)
            {
                Return (0x0FA2)
            }

            Method (_TMP, 0, Serialized)
            {
                If (ECON)
                {
                    Store (\_SB.PCI0.LPCB.H_EC.DTMP, Local0)
                    If (And (Local0, 0x80))
                    {
                        Subtract (Local0, 0x0100, Local0)
                    }

                    Return (Add (0x0AAC, Multiply (Local0, 0x0A)))
                }

                Return (0x0BB8)
            }
        }

        ThermalZone (TZ01)
        {
            Method (_AC0, 0, Serialized)
            {
                Return (Add (0x0AAC, Multiply (ACTT, 0x0A)))
            }

            Name (_AL0, Package (0x01)
            {
                FAN0
            })
            Method (_CRT, 0, Serialized)
            {
                Return (Add (0x0AAC, Multiply (CRTT, 0x0A)))
            }

            Method (_SCP, 1, Serialized)
            {
                Store (Arg0, CTYP)
            }

            Method (_TMP, 0, Serialized)
            {
                If (DTSE)
                {
                    If (LNot (LLess (DTS1, DTS2)))
                    {
                        Return (Add (0x0AAC, Multiply (DTS1, 0x0A)))
                    }

                    Return (Add (0x0AAC, Multiply (DTS2, 0x0A)))
                }

                If (ECON)
                {
                    Store (\_SB.PCI0.LPCB.H_EC.DTMP, Local0)
                    If (And (Local0, 0x80))
                    {
                        Subtract (Local0, 0x0100, Local0)
                    }

                    Return (Add (0x0AAC, Multiply (Local0, 0x0A)))
                }

                Return (0x0BB8)
            }

            Method (_PSL, 0, Serialized)
            {
                If (MPEN)
                {
                    Return (Package (0x02)
                    {
                        \_PR.CPU0,
                        \_PR.CPU1
                    })
                }

                Return (Package (0x01)
                {
                    \_PR.CPU0
                })
            }

            Method (_PSV, 0, Serialized)
            {
                Return (Add (0x0AAC, Multiply (PSVT, 0x0A)))
            }

            Method (_TC1, 0, Serialized)
            {
                Return (TC1V)
            }

            Method (_TC2, 0, Serialized)
            {
                Return (TC2V)
            }

            Method (_TSP, 0, Serialized)
            {
                Return (TSPV)
            }
        }
    }

    Scope (_SB)
    {
        Device (ADP1)
        {
            Name (_HID, "ACPI0003")
            Method (_PSR, 0, NotSerialized)
            {
                Return (PWRS)
            }

            Method (_PCL, 0, NotSerialized)
            {
                Return (_SB)
            }
        }

        Device (BAT0)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, Zero)
            Method (_STA, 0, NotSerialized)
            {
                If (And (BNUM, 0x03))
                {
                    Return (0x0B)
                }

                If (B0SC)
                {
                    Return (0x1F)
                }

                Return (Zero)
            }

            Method (_BIF, 0, NotSerialized)
            {
                Return (Package (0x0D)
                {
                    Zero,
                    0x2710,
                    0x2710,
                    One,
                    Ones,
                    0x03E8,
                    0x0190,
                    0x64,
                    0x64,
                    "CRB Battery 0",
                    "Battery 0",
                    "Fake",
                    "-Virtual Battery 0-"
                })
            }

            Method (_BST, 0, NotSerialized)
            {
                Name (PKG0, Package (0x04)
                {
                    Ones,
                    Ones,
                    Ones,
                    Ones
                })
                If (PWRS)
                {
                    Store (0x02, Index (PKG0, Zero))
                }
                Else
                {
                    Store (One, Index (PKG0, Zero))
                }

                Store (Multiply (B0SC, 0x64), Index (PKG0, 0x02))
                Return (PKG0)
            }

            Method (_PCL, 0, NotSerialized)
            {
                Return (_SB)
            }
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, One)
            Method (_STA, 0, NotSerialized)
            {
                If (And (BNUM, One))
                {
                    Return (0x1F)
                }

                If (B0SC)
                {
                    Return (0x0B)
                }

                Return (Zero)
            }

            Method (_BIF, 0, NotSerialized)
            {
                Return (Package (0x0D)
                {
                    Zero,
                    0x2710,
                    0x2710,
                    One,
                    Ones,
                    0x03E8,
                    0x0190,
                    0x64,
                    0x64,
                    "CRB Battery 1",
                    "Battery 1",
                    "Real",
                    "-Real Battery 1-"
                })
            }

            Method (_BST, 0, NotSerialized)
            {
                Name (PKG1, Package (0x04)
                {
                    Ones,
                    Ones,
                    Ones,
                    Ones
                })
                Store (And (B1SS, 0x07), Index (PKG1, Zero))
                Store (Multiply (B1SC, 0x64), Index (PKG1, 0x02))
                Return (PKG1)
            }

            Method (_PCL, 0, NotSerialized)
            {
                Return (_SB)
            }
        }

        Device (BAT2)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x02)
            Method (_STA, 0, NotSerialized)
            {
                If (And (BNUM, 0x02))
                {
                    Return (0x1F)
                }

                If (B0SC)
                {
                    Return (0x0B)
                }

                Return (Zero)
            }

            Method (_BIF, 0, NotSerialized)
            {
                Return (Package (0x0D)
                {
                    Zero,
                    0x2710,
                    0x2710,
                    One,
                    Ones,
                    0x03E8,
                    0x0190,
                    0x64,
                    0x64,
                    "CRB Battery 2",
                    "Battery 2",
                    "Real",
                    "-Real Battery 2-"
                })
            }

            Method (_BST, 0, NotSerialized)
            {
                Name (PKG2, Package (0x04)
                {
                    Ones,
                    Ones,
                    Ones,
                    Ones
                })
                Store (And (B2SS, 0x07), Index (PKG2, Zero))
                Store (Multiply (B2SC, 0x64), Index (PKG2, 0x02))
                Return (PKG2)
            }

            Method (_PCL, 0, NotSerialized)
            {
                Return (_SB)
            }
        }

        Device (LID0)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Method (_LID, 0, NotSerialized)
            {
                Return (LIDS)
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C"))
            Name (_PRW, Package (0x02)
            {
                0x1D,
                0x04
            })
        }

        Device (PCI0)
        {
            Method (_INI, 0, NotSerialized)
            {
                Store (0x07D0, OSYS)
                If (CondRefOf (_OSI, Local0))
                {
                    If (_OSI ("Linux"))
                    {
                        Store (0x03E8, OSYS)
                    }
                    Else
                    {
                        Store (0x07D1, OSYS)
                        If (MPEN)
                        {
                            TRAP (0x3D)
                        }
                    }
                }
            }

            Name (_HID, EisaId ("PNP0A08"))
            Name (_CID, 0x030AD041)
            Name (_ADR, Zero)
            Name (_BBN, Zero)
            OperationRegion (HBUS, PCI_Config, 0x40, 0xC0)
            Field (HBUS, DWordAcc, NoLock, Preserve)
            {
                Offset (0x50),
                    ,   4,
                PM0H,   2,
                Offset (0x51),
                PM1L,   2,
                    ,   2,
                PM1H,   2,
                Offset (0x52),
                PM2L,   2,
                    ,   2,
                PM2H,   2,
                Offset (0x53),
                PM3L,   2,
                    ,   2,
                PM3H,   2,
                Offset (0x54),
                PM4L,   2,
                    ,   2,
                PM4H,   2,
                Offset (0x55),
                PM5L,   2,
                    ,   2,
                PM5H,   2,
                Offset (0x56),
                PM6L,   2,
                    ,   2,
                PM6H,   2,
                Offset (0x57),
                    ,   7,
                HENA,   1,
                Offset (0x5C),
                    ,   3,
                TOUD,   5
            }

            Name (BUF0, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Address Space Granularity
                    0x0000,             // Address Range Minimum
                    0x00FF,             // Address Range Maximum
                    0x0000,             // Address Translation Offset
                    0x0100,             // Address Length
                    ,,)
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Address Space Granularity
                    0x00000000,         // Address Range Minimum
                    0x00000CF7,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00000CF8,         // Address Length
                    ,,, TypeStatic)
                IO (Decode16,
                    0x0CF8,             // Address Range Minimum
                    0x0CF8,             // Address Range Maximum
                    0x01,               // Address Alignment
                    0x08,               // Address Length
                    )
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Address Space Granularity
                    0x00000D00,         // Address Range Minimum
                    0x0000FFFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x0000F300,         // Address Length
                    ,,, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Address Space Granularity
                    0x000A0000,         // Address Range Minimum
                    0x000BFFFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00020000,         // Address Length
                    ,,, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Address Space Granularity
                    0x000C0000,         // Address Range Minimum
                    0x000C3FFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00004000,         // Address Length
                    ,,, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Address Space Granularity
                    0x000C4000,         // Address Range Minimum
                    0x000C7FFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00004000,         // Address Length
                    ,,, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Address Space Granularity
                    0x000C8000,         // Address Range Minimum
                    0x000CBFFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00004000,         // Address Length
                    ,,, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Address Space Granularity
                    0x000CC000,         // Address Range Minimum
                    0x000CFFFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00004000,         // Address Length
                    ,,, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Address Space Granularity
                    0x000D0000,         // Address Range Minimum
                    0x000D3FFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00004000,         // Address Length
                    ,,, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Address Space Granularity
                    0x000D4000,         // Address Range Minimum
                    0x000D7FFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00004000,         // Address Length
                    ,,, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Address Space Granularity
                    0x000D8000,         // Address Range Minimum
                    0x000DBFFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00004000,         // Address Length
                    ,,, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Address Space Granularity
                    0x000DC000,         // Address Range Minimum
                    0x000DFFFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00004000,         // Address Length
                    ,,, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Address Space Granularity
                    0x000E0000,         // Address Range Minimum
                    0x000E3FFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00004000,         // Address Length
                    ,,, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Address Space Granularity
                    0x000E4000,         // Address Range Minimum
                    0x000E7FFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00004000,         // Address Length
                    ,,, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Address Space Granularity
                    0x000E8000,         // Address Range Minimum
                    0x000EBFFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00004000,         // Address Length
                    ,,, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Address Space Granularity
                    0x000EC000,         // Address Range Minimum
                    0x000EFFFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00004000,         // Address Length
                    ,,, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Address Space Granularity
                    0x000F0000,         // Address Range Minimum
                    0x000FFFFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00010000,         // Address Length
                    ,,, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Address Space Granularity
                    0x00000000,         // Address Range Minimum
                    0xFEBFFFFF,         // Address Range Maximum
                    0x00000000,         // Address Translation Offset
                    0x00000000,         // Address Length
                    ,,, AddressRangeMemory, TypeStatic)
            })
            Method (_CRS, 0, Serialized)
            {
                If (PM1L)
                {
                    CreateDWordField (BUF0, 0x7C, C0LN)
                    Store (Zero, C0LN)
                }

                If (LEqual (PM1L, One))
                {
                    CreateBitField (BUF0, 0x0358, C0RW)
                    Store (Zero, C0RW)
                }

                If (PM1H)
                {
                    CreateDWordField (BUF0, 0x96, C4LN)
                    Store (Zero, C4LN)
                }

                If (LEqual (PM1H, One))
                {
                    CreateBitField (BUF0, 0x0428, C4RW)
                    Store (Zero, C4RW)
                }

                If (PM2L)
                {
                    CreateDWordField (BUF0, 0xB0, C8LN)
                    Store (Zero, C8LN)
                }

                If (LEqual (PM2L, One))
                {
                    CreateBitField (BUF0, 0x04F8, C8RW)
                    Store (Zero, C8RW)
                }

                If (PM2H)
                {
                    CreateDWordField (BUF0, 0xCA, CCLN)
                    Store (Zero, CCLN)
                }

                If (LEqual (PM2H, One))
                {
                    CreateBitField (BUF0, 0x05C8, CCRW)
                    Store (Zero, CCRW)
                }

                If (PM3L)
                {
                    CreateDWordField (BUF0, 0xE4, D0LN)
                    Store (Zero, D0LN)
                }

                If (LEqual (PM3L, One))
                {
                    CreateBitField (BUF0, 0x0698, D0RW)
                    Store (Zero, D0RW)
                }

                If (PM3H)
                {
                    CreateDWordField (BUF0, 0xFE, D4LN)
                    Store (Zero, D4LN)
                }

                If (LEqual (PM3H, One))
                {
                    CreateBitField (BUF0, 0x0768, D4RW)
                    Store (Zero, D4RW)
                }

                If (PM4L)
                {
                    CreateDWordField (BUF0, 0x0118, D8LN)
                    Store (Zero, D8LN)
                }

                If (LEqual (PM4L, One))
                {
                    CreateBitField (BUF0, 0x0838, D8RW)
                    Store (Zero, D8RW)
                }

                If (PM4H)
                {
                    CreateDWordField (BUF0, 0x0132, DCLN)
                    Store (Zero, DCLN)
                }

                If (LEqual (PM4H, One))
                {
                    CreateBitField (BUF0, 0x0908, DCRW)
                    Store (Zero, DCRW)
                }

                If (PM5L)
                {
                    CreateDWordField (BUF0, 0x014C, E0LN)
                    Store (Zero, E0LN)
                }

                If (LEqual (PM5L, One))
                {
                    CreateBitField (BUF0, 0x09D8, E0RW)
                    Store (Zero, E0RW)
                }

                If (PM5H)
                {
                    CreateDWordField (BUF0, 0x0166, E4LN)
                    Store (Zero, E4LN)
                }

                If (LEqual (PM5H, One))
                {
                    CreateBitField (BUF0, 0x0AA8, E4RW)
                    Store (Zero, E4RW)
                }

                If (PM6L)
                {
                    CreateDWordField (BUF0, 0x0180, E8LN)
                    Store (Zero, E8LN)
                }

                If (LEqual (PM6L, One))
                {
                    CreateBitField (BUF0, 0x0B78, E8RW)
                    Store (Zero, E8RW)
                }

                If (PM6H)
                {
                    CreateDWordField (BUF0, 0x019A, ECLN)
                    Store (Zero, ECLN)
                }

                If (LEqual (PM6H, One))
                {
                    CreateBitField (BUF0, 0x0C48, ECRW)
                    Store (Zero, ECRW)
                }

                If (PM0H)
                {
                    CreateDWordField (BUF0, 0x01B4, F0LN)
                    Store (Zero, F0LN)
                }

                If (LEqual (PM0H, One))
                {
                    CreateBitField (BUF0, 0x0D18, F0RW)
                    Store (Zero, F0RW)
                }

                CreateDWordField (BUF0, 0x01C2, M1MN)
                CreateDWordField (BUF0, 0x01C6, M1MX)
                CreateDWordField (BUF0, 0x01CE, M1LN)
                ShiftLeft (TOUD, 0x1B, M1MN)
                Add (Subtract (M1MX, M1MN), One, M1LN)
                Return (BUF0)
            }

            Method (_PRT, 0, NotSerialized)
            {
                If (GPIC)
                {
                    Return (Package (0x11)
                    {
                        Package (0x04)
                        {
                            0x0001FFFF,
                            Zero,
                            Zero,
                            0x10
                        },

                        Package (0x04)
                        {
                            0x0002FFFF,
                            Zero,
                            Zero,
                            0x10
                        },

                        Package (0x04)
                        {
                            0x0007FFFF,
                            Zero,
                            Zero,
                            0x10
                        },

                        Package (0x04)
                        {
                            0x001BFFFF,
                            Zero,
                            Zero,
                            0x16
                        },

                        Package (0x04)
                        {
                            0x001CFFFF,
                            Zero,
                            Zero,
                            0x11
                        },

                        Package (0x04)
                        {
                            0x001CFFFF,
                            One,
                            Zero,
                            0x10
                        },

                        Package (0x04)
                        {
                            0x001CFFFF,
                            0x02,
                            Zero,
                            0x12
                        },

                        Package (0x04)
                        {
                            0x001CFFFF,
                            0x03,
                            Zero,
                            0x13
                        },

                        Package (0x04)
                        {
                            0x001DFFFF,
                            Zero,
                            Zero,
                            0x17
                        },

                        Package (0x04)
                        {
                            0x001DFFFF,
                            One,
                            Zero,
                            0x13
                        },

                        Package (0x04)
                        {
                            0x001DFFFF,
                            0x02,
                            Zero,
                            0x12
                        },

                        Package (0x04)
                        {
                            0x001DFFFF,
                            0x03,
                            Zero,
                            0x10
                        },

                        Package (0x04)
                        {
                            0x001EFFFF,
                            Zero,
                            Zero,
                            0x16
                        },

                        Package (0x04)
                        {
                            0x001EFFFF,
                            One,
                            Zero,
                            0x14
                        },

                        Package (0x04)
                        {
                            0x001FFFFF,
                            Zero,
                            Zero,
                            0x12
                        },

                        Package (0x04)
                        {
                            0x001FFFFF,
                            One,
                            Zero,
                            0x13
                        },

                        Package (0x04)
                        {
                            0x001FFFFF,
                            0x03,
                            Zero,
                            0x10
                        }
                    })
                }
                Else
                {
                    Return (Package (0x11)
                    {
                        Package (0x04)
                        {
                            0x0001FFFF,
                            Zero,
                            ^LPCB.LNKA,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x0002FFFF,
                            Zero,
                            ^LPCB.LNKA,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x0007FFFF,
                            Zero,
                            ^LPCB.LNKA,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x001BFFFF,
                            Zero,
                            ^LPCB.LNKG,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x001CFFFF,
                            Zero,
                            ^LPCB.LNKB,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x001CFFFF,
                            One,
                            ^LPCB.LNKA,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x001CFFFF,
                            0x02,
                            ^LPCB.LNKC,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x001CFFFF,
                            0x03,
                            ^LPCB.LNKD,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x001DFFFF,
                            Zero,
                            ^LPCB.LNKH,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x001DFFFF,
                            One,
                            ^LPCB.LNKD,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x001DFFFF,
                            0x02,
                            ^LPCB.LNKC,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x001DFFFF,
                            0x03,
                            ^LPCB.LNKA,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x001EFFFF,
                            Zero,
                            ^LPCB.LNKG,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x001EFFFF,
                            One,
                            ^LPCB.LNKE,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x001FFFFF,
                            Zero,
                            ^LPCB.LNKC,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x001FFFFF,
                            One,
                            ^LPCB.LNKD,
                            Zero
                        },

                        Package (0x04)
                        {
                            0x001FFFFF,
                            0x03,
                            ^LPCB.LNKA,
                            Zero
                        }
                    })
                }
            }

            Device (PDRC)
            {
                Name (_HID, EisaId ("PNP0C02"))
                Name (_UID, One)
                Name (_CRS, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0xE0000000,         // Address Base
                        0x10000000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFED14000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFED18000,         // Address Base
                        0x00001000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFED19000,         // Address Base
                        0x00001000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFED1C000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFED20000,         // Address Base
                        0x00070000,         // Address Length
                        )
                })
            }

            Device (PEGP)
            {
                Name (_ADR, 0x00010000)
                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                Zero,
                                0x10
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                Zero,
                                0x11
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                Zero,
                                0x12
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                Zero,
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                ^^LPCB.LNKA,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                ^^LPCB.LNKB,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                ^^LPCB.LNKC,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                ^^LPCB.LNKD,
                                Zero
                            }
                        })
                    }
                }
            }

            Device (GFX0)
            {
                Name (_ADR, 0x00020000)
                Method (_DOS, 1, NotSerialized)
                {
                    Store (And (Arg0, 0x03), DSEN)
                }

                Method (_DOD, 0, NotSerialized)
                {
                    If (LEqual (NDID, One))
                    {
                        Name (TMP1, Package (0x01)
                        {
                            Ones
                        })
                        Store (Or (0x00010000, DID1), Index (TMP1, Zero))
                        Return (TMP1)
                    }

                    If (LEqual (NDID, 0x02))
                    {
                        Name (TMP2, Package (0x02)
                        {
                            Ones,
                            Ones
                        })
                        Store (Or (0x00010000, DID1), Index (TMP2, Zero))
                        Store (Or (0x00010000, DID2), Index (TMP2, One))
                        Return (TMP2)
                    }

                    If (LEqual (NDID, 0x03))
                    {
                        Name (TMP3, Package (0x03)
                        {
                            Ones,
                            Ones,
                            Ones
                        })
                        Store (Or (0x00010000, DID1), Index (TMP3, Zero))
                        Store (Or (0x00010000, DID2), Index (TMP3, One))
                        Store (Or (0x00010000, DID3), Index (TMP3, 0x02))
                        Return (TMP3)
                    }

                    If (LEqual (NDID, 0x04))
                    {
                        Name (TMP4, Package (0x04)
                        {
                            Ones,
                            Ones,
                            Ones,
                            Ones
                        })
                        Store (Or (0x00010000, DID1), Index (TMP4, Zero))
                        Store (Or (0x00010000, DID2), Index (TMP4, One))
                        Store (Or (0x00010000, DID3), Index (TMP4, 0x02))
                        Store (Or (0x00010000, DID4), Index (TMP4, 0x03))
                        Return (TMP4)
                    }

                    Name (TMP5, Package (0x05)
                    {
                        Ones,
                        Ones,
                        Ones,
                        Ones,
                        Ones
                    })
                    Store (Or (0x00010000, DID1), Index (TMP5, Zero))
                    Store (Or (0x00010000, DID2), Index (TMP5, One))
                    Store (Or (0x00010000, DID3), Index (TMP5, 0x02))
                    Store (Or (0x00010000, DID4), Index (TMP5, 0x03))
                    Store (Or (0x00010000, DID5), Index (TMP5, 0x04))
                    Return (TMP5)
                }

                Device (DD01)
                {
                    Method (_ADR, 0, Serialized)
                    {
                        Return (And (0xFFFF, DID1))
                    }

                    Method (_DCS, 0, NotSerialized)
                    {
                        TRAP (One)
                        If (And (CSTE, One))
                        {
                            Return (0x1F)
                        }

                        Return (0x1D)
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        If (And (NSTE, One))
                        {
                            Return (One)
                        }

                        Return (Zero)
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE)
                        }
                    }
                }

                Device (DD02)
                {
                    Method (_ADR, 0, Serialized)
                    {
                        Return (And (0xFFFF, DID2))
                    }

                    Method (_DCS, 0, NotSerialized)
                    {
                        TRAP (One)
                        If (And (CSTE, 0x02))
                        {
                            Return (0x1F)
                        }

                        Return (0x1D)
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        If (And (NSTE, 0x02))
                        {
                            Return (One)
                        }

                        Return (Zero)
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE)
                        }
                    }
                }

                Device (DD03)
                {
                    Method (_ADR, 0, Serialized)
                    {
                        Return (And (0xFFFF, DID3))
                    }

                    Method (_DCS, 0, NotSerialized)
                    {
                        TRAP (One)
                        If (And (CSTE, 0x04))
                        {
                            Return (0x1F)
                        }

                        Return (0x1D)
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        If (And (NSTE, 0x04))
                        {
                            Return (One)
                        }

                        Return (Zero)
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE)
                        }
                    }
                }

                Device (DD04)
                {
                    Method (_ADR, 0, Serialized)
                    {
                        Return (And (0xFFFF, DID4))
                    }

                    Method (_DCS, 0, NotSerialized)
                    {
                        TRAP (One)
                        If (And (CSTE, 0x08))
                        {
                            Return (0x1F)
                        }

                        Return (0x1D)
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        If (And (NSTE, 0x08))
                        {
                            Return (One)
                        }

                        Return (Zero)
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE)
                        }
                    }
                }

                Device (DD05)
                {
                    Method (_ADR, 0, Serialized)
                    {
                        Return (And (0xFFFF, DID5))
                    }

                    Method (_DCS, 0, NotSerialized)
                    {
                        TRAP (One)
                        If (And (CSTE, 0x10))
                        {
                            Return (0x1F)
                        }

                        Return (0x1D)
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        If (And (NSTE, 0x10))
                        {
                            Return (One)
                        }

                        Return (Zero)
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE)
                        }
                    }
                }
            }

            Device (HDEF)
            {
                Name (_ADR, 0x001B0000)
                Name (_PRW, Package (0x02)
                {
                    0x05,
                    0x04
                })
            }

            Device (RP01)
            {
                Name (_ADR, 0x001C0000)
                OperationRegion (P1CS, PCI_Config, 0x40, 0x0100)
                Field (P1CS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x1A),
                    ABP1,   1,
                        ,   2,
                    PDC1,   1,
                        ,   2,
                    PDS1,   1,
                    Offset (0x20),
                    Offset (0x22),
                    PSP1,   1,
                    Offset (0x9C),
                        ,   30,
                    HPCS,   1,
                    PMCS,   1
                }

                Device (PXS1)
                {
                    Name (_ADR, Zero)
                    Name (_PRW, Package (0x02)
                    {
                        0x09,
                        0x04
                    })
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                Zero,
                                0x10
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                Zero,
                                0x11
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                Zero,
                                0x12
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                Zero,
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                ^^LPCB.LNKA,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                ^^LPCB.LNKB,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                ^^LPCB.LNKC,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                ^^LPCB.LNKD,
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP02)
            {
                Name (_ADR, 0x001C0001)
                OperationRegion (P2CS, PCI_Config, 0x40, 0x0100)
                Field (P2CS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x1A),
                    ABP2,   1,
                        ,   2,
                    PDC2,   1,
                        ,   2,
                    PDS2,   1,
                    Offset (0x20),
                    Offset (0x22),
                    PSP2,   1,
                    Offset (0x9C),
                        ,   30,
                    HPCS,   1,
                    PMCS,   1
                }

                Device (PXS2)
                {
                    Name (_ADR, Zero)
                    Method (_RMV, 0, NotSerialized)
                    {
                        Return (One)
                    }

                    Name (_PRW, Package (0x02)
                    {
                        0x09,
                        0x04
                    })
                    Name (_EJD, "\\_SB.PCI0.USB7.HUB7.PRT7")
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                Zero,
                                0x11
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                Zero,
                                0x12
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                Zero,
                                0x13
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                Zero,
                                0x10
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                ^^LPCB.LNKB,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                ^^LPCB.LNKC,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                ^^LPCB.LNKD,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                ^^LPCB.LNKA,
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP03)
            {
                Name (_ADR, 0x001C0002)
                OperationRegion (P3CS, PCI_Config, 0x40, 0x0100)
                Field (P3CS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x1A),
                    ABP3,   1,
                        ,   2,
                    PDC3,   1,
                        ,   2,
                    PDS3,   1,
                    Offset (0x20),
                    Offset (0x22),
                    PSP3,   1,
                    Offset (0x9C),
                        ,   30,
                    HPCS,   1,
                    PMCS,   1
                }

                Device (PXS3)
                {
                    Name (_ADR, Zero)
                    Method (_RMV, 0, NotSerialized)
                    {
                        Return (One)
                    }

                    Name (_PRW, Package (0x02)
                    {
                        0x09,
                        0x04
                    })
                    Name (_EJD, "\\_SB.PCI0.USB7.HUB7.PRT5")
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                Zero,
                                0x12
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                Zero,
                                0x13
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                Zero,
                                0x10
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                Zero,
                                0x11
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                ^^LPCB.LNKC,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                ^^LPCB.LNKD,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                ^^LPCB.LNKA,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                ^^LPCB.LNKB,
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP04)
            {
                Name (_ADR, 0x001C0003)
                OperationRegion (P4CS, PCI_Config, 0x40, 0x0100)
                Field (P4CS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x1A),
                    ABP4,   1,
                        ,   2,
                    PDC4,   1,
                        ,   2,
                    PDS4,   1,
                    Offset (0x20),
                    Offset (0x22),
                    PSP4,   1,
                    Offset (0x9C),
                        ,   30,
                    HPCS,   1,
                    PMCS,   1
                }

                Device (PXS4)
                {
                    Name (_ADR, Zero)
                    Method (_RMV, 0, NotSerialized)
                    {
                        Return (One)
                    }

                    Name (_PRW, Package (0x02)
                    {
                        0x09,
                        0x04
                    })
                    Name (_EJD, "\\_SB.PCI0.USB7.HUB7.PRT3")
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                Zero,
                                0x13
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                Zero,
                                0x10
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                Zero,
                                0x11
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                Zero,
                                0x12
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                ^^LPCB.LNKD,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                ^^LPCB.LNKA,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                ^^LPCB.LNKB,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                ^^LPCB.LNKC,
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP05)
            {
                Name (_ADR, 0x001C0004)
                OperationRegion (P5CS, PCI_Config, 0x40, 0x0100)
                Field (P5CS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x1A),
                    ABP5,   1,
                        ,   2,
                    PDC5,   1,
                        ,   2,
                    PDS5,   1,
                    Offset (0x20),
                    Offset (0x22),
                    PSP5,   1,
                    Offset (0x9C),
                        ,   30,
                    HPCS,   1,
                    PMCS,   1
                }

                Device (PXS5)
                {
                    Name (_ADR, Zero)
                    Name (_PRW, Package (0x02)
                    {
                        0x09,
                        0x04
                    })
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                Zero,
                                0x10
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                Zero,
                                0x11
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                Zero,
                                0x12
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                Zero,
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                ^^LPCB.LNKA,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                ^^LPCB.LNKB,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                ^^LPCB.LNKC,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                ^^LPCB.LNKD,
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP06)
            {
                Name (_ADR, 0x001C0005)
                OperationRegion (P6CS, PCI_Config, 0x40, 0x0100)
                Field (P6CS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x1A),
                    ABP6,   1,
                        ,   2,
                    PDC6,   1,
                        ,   2,
                    PDS6,   1,
                    Offset (0x20),
                    Offset (0x22),
                    PSP6,   1,
                    Offset (0x9C),
                        ,   30,
                    HPCS,   1,
                    PMCS,   1
                }

                Device (PXS6)
                {
                    Name (_ADR, Zero)
                    Name (_PRW, Package (0x02)
                    {
                        0x09,
                        0x04
                    })
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                Zero,
                                0x11
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                Zero,
                                0x12
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                Zero,
                                0x13
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                Zero,
                                0x10
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                ^^LPCB.LNKB,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                ^^LPCB.LNKC,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                ^^LPCB.LNKD,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                ^^LPCB.LNKA,
                                Zero
                            }
                        })
                    }
                }
            }

            Device (USB1)
            {
                Name (_ADR, 0x001D0000)
                Device (HUB1)
                {
                    Name (_ADR, Zero)
                    Device (PRT1)
                    {
                        Name (_ADR, One)
                    }

                    Device (PRT2)
                    {
                        Name (_ADR, 0x02)
                    }
                }

                OperationRegion (U1CS, PCI_Config, 0xC4, 0x04)
                Field (U1CS, DWordAcc, NoLock, Preserve)
                {
                    U1EN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x03,
                    0x04
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, U1EN)
                    }
                    Else
                    {
                        Store (Zero, U1EN)
                    }
                }
            }

            Device (USB2)
            {
                Name (_ADR, 0x001D0001)
                Device (HUB2)
                {
                    Name (_ADR, Zero)
                    Device (PRT1)
                    {
                        Name (_ADR, One)
                        Name (_EJD, "\\_SB.PCI0.RP04.PXS4")
                    }

                    Device (PRT2)
                    {
                        Name (_ADR, 0x02)
                    }
                }

                OperationRegion (U2CS, PCI_Config, 0xC4, 0x04)
                Field (U2CS, DWordAcc, NoLock, Preserve)
                {
                    U2EN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x04,
                    0x04
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, U2EN)
                    }
                    Else
                    {
                        Store (Zero, U2EN)
                    }
                }
            }

            Device (USB3)
            {
                Name (_ADR, 0x001D0002)
                Device (HUB3)
                {
                    Name (_ADR, Zero)
                    Device (PRT1)
                    {
                        Name (_ADR, One)
                        Name (_EJD, "\\_SB.PCI0.RP03.PXS3")
                    }

                    Device (PRT2)
                    {
                        Name (_ADR, 0x02)
                    }
                }

                OperationRegion (U2CS, PCI_Config, 0xC4, 0x04)
                Field (U2CS, DWordAcc, NoLock, Preserve)
                {
                    U3EN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x0C,
                    0x04
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, U3EN)
                    }
                    Else
                    {
                        Store (Zero, U3EN)
                    }
                }
            }

            Device (USB4)
            {
                Name (_ADR, 0x001D0003)
                Device (HUB4)
                {
                    Name (_ADR, Zero)
                    Device (PRT1)
                    {
                        Name (_ADR, One)
                        Name (_EJD, "\\_SB.PCI0.RP02.PXS2")
                    }

                    Device (PRT2)
                    {
                        Name (_ADR, 0x02)
                    }
                }

                OperationRegion (U4CS, PCI_Config, 0xC4, 0x04)
                Field (U4CS, DWordAcc, NoLock, Preserve)
                {
                    U4EN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x0E,
                    0x04
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, U4EN)
                    }
                    Else
                    {
                        Store (Zero, U4EN)
                    }
                }
            }

            Device (USB7)
            {
                Name (_ADR, 0x001D0007)
                Device (HUB7)
                {
                    Name (_ADR, Zero)
                    Device (PRT1)
                    {
                        Name (_ADR, One)
                    }

                    Device (PRT2)
                    {
                        Name (_ADR, 0x02)
                    }

                    Device (PRT3)
                    {
                        Name (_ADR, 0x03)
                        Name (_EJD, "\\_SB.PCI0.RP04.PXS4")
                    }

                    Device (PRT4)
                    {
                        Name (_ADR, 0x04)
                    }

                    Device (PRT5)
                    {
                        Name (_ADR, 0x05)
                        Name (_EJD, "\\_SB.PCI0.RP03.PXS3")
                    }

                    Device (PRT6)
                    {
                        Name (_ADR, 0x06)
                    }

                    Device (PRT7)
                    {
                        Name (_ADR, 0x07)
                        Name (_EJD, "\\_SB.PCI0.RP02.PXS2")
                    }

                    Device (PRT8)
                    {
                        Name (_ADR, 0x08)
                    }
                }

                Name (_PRW, Package (0x02)
                {
                    0x0D,
                    0x04
                })
            }

            Device (PCIB)
            {
                Name (_ADR, 0x001E0000)
                Device (SLT0)
                {
                    Name (_ADR, Zero)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B,
                        0x04
                    })
                }

                Device (SLT1)
                {
                    Name (_ADR, 0x00010000)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B,
                        0x04
                    })
                }

                Device (SLT2)
                {
                    Name (_ADR, 0x00020000)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B,
                        0x04
                    })
                }

                Device (SLT3)
                {
                    Name (_ADR, 0x00030000)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B,
                        0x04
                    })
                }

                Device (SLT6)
                {
                    Name (_ADR, 0x00050000)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B,
                        0x04
                    })
                }

                Device (LANC)
                {
                    Name (_ADR, 0x00080000)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B,
                        0x04
                    })
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (GPIC)
                    {
                        Return (Package (0x15)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                Zero,
                                0x15
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                Zero,
                                0x16
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                Zero,
                                0x17
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                Zero,
                                0x14
                            },

                            Package (0x04)
                            {
                                0x0001FFFF,
                                Zero,
                                Zero,
                                0x16
                            },

                            Package (0x04)
                            {
                                0x0001FFFF,
                                One,
                                Zero,
                                0x15
                            },

                            Package (0x04)
                            {
                                0x0001FFFF,
                                0x02,
                                Zero,
                                0x14
                            },

                            Package (0x04)
                            {
                                0x0001FFFF,
                                0x03,
                                Zero,
                                0x17
                            },

                            Package (0x04)
                            {
                                0x0002FFFF,
                                Zero,
                                Zero,
                                0x12
                            },

                            Package (0x04)
                            {
                                0x0002FFFF,
                                One,
                                Zero,
                                0x13
                            },

                            Package (0x04)
                            {
                                0x0002FFFF,
                                0x02,
                                Zero,
                                0x11
                            },

                            Package (0x04)
                            {
                                0x0002FFFF,
                                0x03,
                                Zero,
                                0x10
                            },

                            Package (0x04)
                            {
                                0x0003FFFF,
                                Zero,
                                Zero,
                                0x13
                            },

                            Package (0x04)
                            {
                                0x0003FFFF,
                                One,
                                Zero,
                                0x12
                            },

                            Package (0x04)
                            {
                                0x0003FFFF,
                                0x02,
                                Zero,
                                0x15
                            },

                            Package (0x04)
                            {
                                0x0003FFFF,
                                0x03,
                                Zero,
                                0x16
                            },

                            Package (0x04)
                            {
                                0x0005FFFF,
                                Zero,
                                Zero,
                                0x11
                            },

                            Package (0x04)
                            {
                                0x0005FFFF,
                                One,
                                Zero,
                                0x14
                            },

                            Package (0x04)
                            {
                                0x0005FFFF,
                                0x02,
                                Zero,
                                0x16
                            },

                            Package (0x04)
                            {
                                0x0005FFFF,
                                0x03,
                                Zero,
                                0x15
                            },

                            Package (0x04)
                            {
                                0x0008FFFF,
                                Zero,
                                Zero,
                                0x14
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x15)
                        {
                            Package (0x04)
                            {
                                0xFFFF,
                                Zero,
                                ^^LPCB.LNKF,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                One,
                                ^^LPCB.LNKG,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x02,
                                ^^LPCB.LNKH,
                                Zero
                            },

                            Package (0x04)
                            {
                                0xFFFF,
                                0x03,
                                ^^LPCB.LNKE,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0001FFFF,
                                Zero,
                                ^^LPCB.LNKG,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0001FFFF,
                                One,
                                ^^LPCB.LNKF,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0001FFFF,
                                0x02,
                                ^^LPCB.LNKE,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0001FFFF,
                                0x03,
                                ^^LPCB.LNKH,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0002FFFF,
                                Zero,
                                ^^LPCB.LNKC,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0002FFFF,
                                One,
                                ^^LPCB.LNKD,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0002FFFF,
                                0x02,
                                ^^LPCB.LNKB,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0002FFFF,
                                0x03,
                                ^^LPCB.LNKA,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0003FFFF,
                                Zero,
                                ^^LPCB.LNKD,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0003FFFF,
                                One,
                                ^^LPCB.LNKC,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0003FFFF,
                                0x02,
                                ^^LPCB.LNKF,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0003FFFF,
                                0x03,
                                ^^LPCB.LNKG,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0005FFFF,
                                Zero,
                                ^^LPCB.LNKB,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0005FFFF,
                                One,
                                ^^LPCB.LNKE,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0005FFFF,
                                0x02,
                                ^^LPCB.LNKG,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0005FFFF,
                                0x03,
                                ^^LPCB.LNKF,
                                Zero
                            },

                            Package (0x04)
                            {
                                0x0008FFFF,
                                Zero,
                                ^^LPCB.LNKE,
                                Zero
                            }
                        })
                    }
                }
            }

            Device (AUD0)
            {
                Name (_ADR, 0x001E0002)
            }

            Device (MODM)
            {
                Name (_ADR, 0x001E0003)
                Name (_PRW, Package (0x02)
                {
                    0x05,
                    0x04
                })
            }

            Device (LPCB)
            {
                Name (_ADR, 0x001F0000)
                OperationRegion (LPC0, PCI_Config, 0x40, 0xC0)
                Field (LPC0, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x20),
                    PARC,   8,
                    PBRC,   8,
                    PCRC,   8,
                    PDRC,   8,
                    Offset (0x28),
                    PERC,   8,
                    PFRC,   8,
                    PGRC,   8,
                    PHRC,   8,
                    Offset (0x40),
                    IOD0,   8,
                    IOD1,   8
                }

                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, One)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PARC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared)
                            {1,3,4,5,6,7,10,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLA, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared)
                                {}
                        })
                        CreateWordField (RTLA, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PARC, 0x0F), IRQ0)
                        Return (RTLA)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PARC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PARC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKB)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x02)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PBRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared)
                            {1,3,4,5,6,7,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLB, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared)
                                {}
                        })
                        CreateWordField (RTLB, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PBRC, 0x0F), IRQ0)
                        Return (RTLB)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PBRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PBRC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKC)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x03)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PCRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared)
                            {1,3,4,5,6,7,10,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLC, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared)
                                {}
                        })
                        CreateWordField (RTLC, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PCRC, 0x0F), IRQ0)
                        Return (RTLC)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PCRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PCRC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKD)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x04)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PDRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared)
                            {1,3,4,5,6,7,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLD, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared)
                                {}
                        })
                        CreateWordField (RTLD, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PDRC, 0x0F), IRQ0)
                        Return (RTLD)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PDRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PDRC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKE)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x05)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PERC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared)
                            {1,3,4,5,6,7,10,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLE, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared)
                                {}
                        })
                        CreateWordField (RTLE, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PERC, 0x0F), IRQ0)
                        Return (RTLE)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PERC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PERC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKF)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x06)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PFRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared)
                            {1,3,4,5,6,7,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLF, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared)
                                {}
                        })
                        CreateWordField (RTLF, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PFRC, 0x0F), IRQ0)
                        Return (RTLF)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PFRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PFRC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKG)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x07)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PGRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared)
                            {1,3,4,5,6,7,10,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLG, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared)
                                {}
                        })
                        CreateWordField (RTLG, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PGRC, 0x0F), IRQ0)
                        Return (RTLG)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PGRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PGRC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (LNKH)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x08)
                    Method (_DIS, 0, Serialized)
                    {
                        Store (0x80, PHRC)
                    }

                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared)
                            {3,4,5,6,7,11,12,14,15}
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        Name (RTLH, ResourceTemplate ()
                        {
                            IRQ (Level, ActiveLow, Shared)
                                {}
                        })
                        CreateWordField (RTLH, One, IRQ0)
                        Store (Zero, IRQ0)
                        ShiftLeft (One, And (PHRC, 0x0F), IRQ0)
                        Return (RTLH)
                    }

                    Method (_SRS, 1, Serialized)
                    {
                        CreateWordField (Arg0, One, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Store (Local0, PHRC)
                    }

                    Method (_STA, 0, Serialized)
                    {
                        If (And (PHRC, 0x80))
                        {
                            Return (0x09)
                        }
                        Else
                        {
                            Return (0x0B)
                        }
                    }
                }

                Device (H_EC)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_UID, One)
                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BFFR, ResourceTemplate ()
                        {
                            IO (Decode16,
                                0x0062,             // Address Range Minimum
                                0x0062,             // Address Range Maximum
                                0x00,               // Address Alignment
                                0x01,               // Address Length
                                )
                            IO (Decode16,
                                0x0066,             // Address Range Minimum
                                0x0066,             // Address Range Maximum
                                0x00,               // Address Alignment
                                0x01,               // Address Length
                                )
                        })
                        Return (BFFR)
                    }

                    OperationRegion (ECF2, EmbeddedControl, Zero, 0xFF)
                    Field (ECF2, ByteAcc, Lock, Preserve)
                    {
                        Offset (0x01),
                        DTMP,   8,
                        LTMP,   8,
                        RPWR,   1,
                            ,   2,
                        CFAN,   1,
                            ,   2,
                        LSTE,   1,
                        Offset (0x04),
                        SPTR,   8,
                        SSTS,   8,
                        SADR,   8,
                        SCMD,   8,
                        SBFR,   256,
                        SCNT,   8,
                        Offset (0x2F),
                        CTMP,   8,
                            ,   3,
                        PBNS,   1,
                        VPWR,   1,
                        Offset (0x31),
                        SCAN,   8,
                        B1ST,   8,
                        B1CR,   8,
                        B1CC,   8,
                        B1VT,   8,
                        B2ST,   8,
                        B2CR,   8,
                        B2CC,   8,
                        B2VT,   8,
                        CMDR,   8,
                        LUXH,   8,
                        LUXL,   8,
                        ACH0,   8,
                        ACH1,   8
                    }

                    Device (ALSD)
                    {
                        Name (_HID, "ACPI0008")
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (ALSE, 0x02))
                            {
                                Return (0x0F)
                            }

                            Return (Zero)
                        }

                        Method (_ALI, 0, NotSerialized)
                        {
                            Return (Or (ShiftLeft (LHIH, 0x08), LLOW))
                        }

                        Name (_ALR, Package (0x05)
                        {
                            Package (0x02)
                            {
                                0x46,
                                Zero
                            },

                            Package (0x02)
                            {
                                0x49,
                                0x0A
                            },

                            Package (0x02)
                            {
                                0x55,
                                0x50
                            },

                            Package (0x02)
                            {
                                0x64,
                                0x012C
                            },

                            Package (0x02)
                            {
                                0x96,
                                0x03E8
                            }
                        })
                        Method (ALA, 1, NotSerialized)
                        {
                            Store (Arg0, ALAF)
                            BRTW (BRTL)
                        }
                    }

                    Device (EMAD)
                    {
                        Name (_HID, "ACPIEMAD")
                        OperationRegion (PRVT, SystemIO, 0x06A0, 0x08)
                        Field (PRVT, ByteAcc, NoLock, Preserve)
                        {
                            PVT0,   8,
                            Offset (0x04),
                            PVT1,   8
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            If (EMAE)
                            {
                                Return (0x0F)
                            }

                            Return (Zero)
                        }

                        Method (BLKW, 3, Serialized)
                        {
                            If (PIBC (0x1388))
                            {
                                Return (Zero)
                            }

                            Store (Zero, EMAP)
                            If (LLess (SizeOf (Arg2), 0x20))
                            {
                                Store (SizeOf (Arg2), EMAL)
                            }
                            Else
                            {
                                Store (0x20, EMAL)
                            }

                            While (LLess (EMAP, SizeOf (Arg2)))
                            {
                                Store (0xAC, PVT0)
                                If (IBFC (0x03E8))
                                {
                                    Return (Zero)
                                }

                                Store (Arg0, PVT0)
                                If (IBFC (0x03E8))
                                {
                                    Return (Zero)
                                }

                                Store (Arg1, PVT0)
                                If (IBFC (0x03E8))
                                {
                                    Return (Zero)
                                }

                                Store (EMAL, PVT0)
                                If (IBFC (0x03E8))
                                {
                                    Return (Zero)
                                }

                                Store (Zero, Local0)
                                While (LLess (Local0, EMAL))
                                {
                                    Store (DerefOf (Index (Arg2, EMAP)), PVT0)
                                    If (IBFC (0x03E8))
                                    {
                                        Return (Zero)
                                    }

                                    Increment (Local0)
                                    Increment (EMAP)
                                }

                                If (PIBC (0x1388))
                                {
                                    Return (Zero)
                                }

                                If (LGreater (Add (EMAP, EMAL), SizeOf (Arg2)))
                                {
                                    Subtract (SizeOf (Arg2), EMAP, EMAL)
                                }
                            }

                            Return (One)
                        }

                        Method (GSTS, 1, Serialized)
                        {
                            If (PIBC (0x1388))
                            {
                                Return (0xFFFF)
                            }

                            Store (0xAD, PVT0)
                            If (IBFC (0x03E8))
                            {
                                Return (0xFFFF)
                            }

                            Store (Arg0, PVT0)
                            If (IBFC (0x03E8))
                            {
                                Return (0xFFFF)
                            }

                            If (OBFC (0x09C4))
                            {
                                Return (PVT0)
                            }
                            Else
                            {
                                Return (0xFFFF)
                            }
                        }

                        Method (IBFC, 1, Serialized)
                        {
                            Store (Arg0, Local0)
                            While (LAnd (And (PVT1, 0x02), Local0))
                            {
                                Decrement (Local0)
                                Stall (One)
                            }

                            Return (And (PVT1, 0x02))
                        }

                        Method (OBFC, 1, Serialized)
                        {
                            Store (Arg0, Local0)
                            While (LAnd (LEqual (And (PVT1, One), Zero), Local0))
                            {
                                Decrement (Local0)
                                Stall (0x0A)
                            }

                            Return (And (PVT1, One))
                        }

                        Method (PIBC, 1, Serialized)
                        {
                            Store (Arg0, Local0)
                            While (LAnd (And (PVT1, 0x04), Local0))
                            {
                                Decrement (Local0)
                                Stall (0x64)
                            }

                            Return (And (PVT1, 0x04))
                        }
                    }

                    Device (MEFD)
                    {
                        Name (_HID, "AWY0001")
                        Method (_STA, 0, NotSerialized)
                        {
                            If (MEFE)
                            {
                                Return (0x0F)
                            }

                            Return (Zero)
                        }

                        Method (ARPB, 0, Serialized)
                        {
                            If (ECON)
                            {
                                Store (0x73, CMDR)
                                Return (One)
                            }

                            Return (Zero)
                        }

                        Method (DAPB, 0, Serialized)
                        {
                            If (ECON)
                            {
                                Store (0x74, CMDR)
                                Return (One)
                            }

                            Return (Zero)
                        }

                        Method (GPBS, 0, Serialized)
                        {
                            If (ECON)
                            {
                                Return (XOr (PBNS, One))
                            }

                            Return (Zero)
                        }

                        Method (SMOD, 1, Serialized)
                        {
                            If (Arg0)
                            {
                                P8XH (Zero, 0x55)
                                P8XH (One, 0x55)
                            }
                            Else
                            {
                                P8XH (Zero, 0xAA)
                                P8XH (One, 0xAA)
                            }
                        }
                    }

                    Method (_REG, 2, NotSerialized)
                    {
                        If (LAnd (LEqual (Arg0, 0x03), LEqual (Arg1, One)))
                        {
                            Store (One, ECON)
                            If (LEqual (Zero, ACTT))
                            {
                                Store (Zero, CFAN)
                            }

                            Store (LUXH, LHIH)
                            Store (LUXL, LLOW)
                            If (LAnd (LEqual (ALSE, One), IGDS))
                            {
                                TRAP (0x13)
                            }

                            If (LNot (LEqual (LSTE, LIDS)))
                            {
                                Store (LSTE, LIDS)
                                If (IGDS)
                                {
                                    LSDS (LIDS)
                                }
                                Else
                                {
                                    TRAP (0x2A)
                                }

                                Notify (LID0, 0x80)
                            }

                            Store (Zero, BNUM)
                            Or (BNUM, ShiftRight (And (B1ST, 0x08), 0x03), BNUM)
                            Or (BNUM, ShiftRight (And (B2ST, 0x08), 0x02), BNUM)
                            If (LEqual (BNUM, Zero))
                            {
                                Store (VPWR, PWRS)
                            }
                            Else
                            {
                                Store (RPWR, PWRS)
                            }

                            TRAP (0x2B)
                            PNOT ()
                        }
                    }

                    Name (_GPE, 0x17)
                    Method (_Q30, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x30)
                        Store (One, PWRS)
                        TRAP (0x2B)
                        PNOT ()
                    }

                    Method (_Q31, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x31)
                        Store (Zero, PWRS)
                        TRAP (0x2B)
                        PNOT ()
                    }

                    Method (_Q32, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x32)
                        PNOT ()
                    }

                    Method (_Q33, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x33)
                        Store (Zero, BNUM)
                        Or (BNUM, ShiftRight (And (B1ST, 0x08), 0x03), BNUM)
                        Or (BNUM, ShiftRight (And (B2ST, 0x08), 0x02), BNUM)
                        PNOT ()
                    }

                    Method (_Q51, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x51)
                        Store (LSTE, LIDS)
                        If (IGDS)
                        {
                            LSDS (LIDS)
                        }
                        Else
                        {
                            TRAP (0x2A)
                        }

                        Notify (LID0, 0x80)
                    }

                    Method (_Q52, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x52)
                        P8XH (One, SCAN)
                        If (LEqual (BNUM, Zero))
                        {
                            If (LEqual (SCAN, 0x02))
                            {
                                BTTM (0x0A)
                            }

                            If (LEqual (SCAN, 0x03))
                            {
                                BTTM (0x14)
                            }

                            If (LEqual (SCAN, 0x04))
                            {
                                BTTM (0x1E)
                            }

                            If (LEqual (SCAN, 0x05))
                            {
                                BTTM (0x28)
                            }

                            If (LEqual (SCAN, 0x06))
                            {
                                BTTM (0x32)
                            }

                            If (LEqual (SCAN, 0x07))
                            {
                                BTTM (0x3C)
                            }

                            If (LEqual (SCAN, 0x08))
                            {
                                BTTM (0x46)
                            }

                            If (LEqual (SCAN, 0x09))
                            {
                                BTTM (0x50)
                            }

                            If (LEqual (SCAN, 0x0A))
                            {
                                BTTM (0x5A)
                            }

                            If (LEqual (SCAN, 0x0B))
                            {
                                BTTM (0x64)
                            }

                            If (LEqual (SCAN, 0x0C))
                            {
                                If (LNot (LLess (B0SC, 0x02)))
                                {
                                    BTTM (Subtract (B0SC, 0x02))
                                }
                            }

                            If (LEqual (SCAN, 0x0D))
                            {
                                If (LNot (LGreater (B0SC, 0x62)))
                                {
                                    BTTM (Add (B0SC, 0x02))
                                }
                            }
                        }

                        If (LEqual (SCAN, 0x33))
                        {
                            If (LLess (PPCS, PPCM))
                            {
                                Add (PPCS, One, PPCS)
                            }

                            PNOT ()
                        }

                        If (LEqual (SCAN, 0x34))
                        {
                            If (LGreater (PPCS, Zero))
                            {
                                Subtract (PPCS, One, PPCS)
                            }

                            PNOT ()
                        }

                        If (LEqual (SCAN, 0x3B))
                        {
                            If (IGDS)
                            {
                                Store (One, TLST)
                                HKDS (0x0A)
                            }
                        }

                        If (LEqual (SCAN, 0x3C))
                        {
                            If (IGDS)
                            {
                                Store (0x02, TLST)
                                HKDS (0x0A)
                            }
                        }

                        If (LEqual (SCAN, 0x3D))
                        {
                            If (IGDS)
                            {
                                Store (0x03, TLST)
                                HKDS (0x0A)
                            }
                        }

                        If (LEqual (SCAN, 0x3E))
                        {
                            If (IGDS)
                            {
                                Store (0x04, TLST)
                                HKDS (0x0A)
                            }
                        }

                        If (LEqual (SCAN, 0x3F))
                        {
                            If (LEqual (BNUM, Zero))
                            {
                                XOr (PWRS, One, PWRS)
                                TRAP (0x2B)
                                PNOT ()
                            }
                        }

                        If (LEqual (SCAN, 0x42))
                        {
                            If (IGDS)
                            {
                                TRAP (0x11)
                            }
                        }

                        If (LEqual (SCAN, 0x43))
                        {
                            If (IGDS)
                            {
                                If (LGreater (BRTL, Zero))
                                {
                                    BRTW (Subtract (BRTL, 0x0A))
                                }
                            }
                        }

                        If (LEqual (SCAN, 0x44))
                        {
                            If (IGDS)
                            {
                                If (LLess (BRTL, 0x64))
                                {
                                    BRTW (Add (BRTL, 0x0A))
                                }
                            }
                        }

                        If (LEqual (SCAN, 0x58))
                        {
                            If (IGDS)
                            {
                                TRAP (0x10)
                            }
                        }

                        If (LEqual (SCAN, 0x10))
                        {
                            XOr (GP12, One, GP12)
                            Sleep (0x01F4)
                            If (GP12)
                            {
                                If (IDEM)
                                {
                                    Store (One, ^^^PATA.ICR4)
                                    Notify (^^^PATA.PRID, Zero)
                                }
                                Else
                                {
                                    Store (0x04, ^^^SATA.ICR4)
                                    Notify (SATA, Zero)
                                }
                            }
                            Else
                            {
                                If (IDEM)
                                {
                                    Store (Zero, ^^^SATA.MAPV)
                                    Store (Zero, ^^^PATA.ICR4)
                                    Sleep (0x01F4)
                                    Notify (^^^PATA.PRID, Zero)
                                }
                                Else
                                {
                                    Store (0x02, ^^^SATA.MAPV)
                                    Store (Zero, ^^^SATA.ICR4)
                                    Sleep (0x01F4)
                                    Notify (SATA, Zero)
                                }
                            }
                        }

                        If (LEqual (SCAN, 0x4A))
                        {
                            Store (Zero, DBGS)
                        }

                        If (LEqual (SCAN, 0x4E))
                        {
                            Store (One, DBGS)
                        }

                        If (LEqual (SCAN, 0x1C))
                        {
                            BreakPoint
                        }

                        If (LAnd (DTSE, LEqual (SCAN, 0x2C)))
                        {
                            TRAP (0x47)
                        }

                        If (LAnd (DTSE, LEqual (SCAN, 0x2D)))
                        {
                            TRAP (0x48)
                        }

                        If (LAnd (DTSE, LEqual (SCAN, 0x2E)))
                        {
                            TRAP (0x49)
                        }

                        If (LAnd (DTSE, LEqual (SCAN, 0x2F)))
                        {
                            TRAP (0x4A)
                        }

                        If (LAnd (DTSE, LEqual (SCAN, 0x30)))
                        {
                            TRAP (0x4B)
                        }
                    }

                    Method (_Q53, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x53)
                        If (LEqual (BNUM, Zero))
                        {
                            If (LNot (LEqual (VPWR, PWRS)))
                            {
                                Store (VPWR, PWRS)
                                TRAP (0x2B)
                                PNOT ()
                            }
                        }
                    }

                    Method (_Q54, 0, NotSerialized)
                    {
                        P8XH (Zero, 0x54)
                        Notify (MEFD, 0x81)
                    }

                    Method (_Q70, 0, NotSerialized)
                    {
                        Store (LUXH, LHIH)
                        Store (LUXL, LLOW)
                        If (LEqual (ALSE, 0x02))
                        {
                            Notify (ALSD, 0x80)
                        }
                        Else
                        {
                            If (LAnd (IGDS, LEqual (ALSE, One)))
                            {
                                TRAP (0x13)
                            }
                        }
                    }

                    Method (_QD0, 0, NotSerialized)
                    {
                        P8XH (Zero, 0xD0)
                        Notify (EMAD, 0x80)
                    }

                    Method (_QD1, 0, NotSerialized)
                    {
                        P8XH (Zero, 0xD1)
                        Notify (EMAD, 0x81)
                    }

                    Method (_QD2, 0, NotSerialized)
                    {
                        P8XH (Zero, 0xD2)
                        Notify (EMAD, 0x82)
                    }

                    Method (_QD3, 0, NotSerialized)
                    {
                        P8XH (Zero, 0xD3)
                        Notify (EMAD, 0x83)
                    }

                    Method (_QD4, 0, NotSerialized)
                    {
                        P8XH (Zero, 0xD4)
                        Notify (EMAD, 0x84)
                    }

                    Method (_QF0, 0, NotSerialized)
                    {
                        If (LEqual (DBGS, Zero))
                        {
                            Notify (\_TZ.TZ00, 0x80)
                            Notify (\_TZ.TZ01, 0x80)
                        }
                    }
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0000,             // Address Range Minimum
                            0x0000,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x20,               // Address Length
                            )
                        IO (Decode16,
                            0x0081,             // Address Range Minimum
                            0x0081,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x11,               // Address Length
                            )
                        IO (Decode16,
                            0x0093,             // Address Range Minimum
                            0x0093,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x0D,               // Address Length
                            )
                        IO (Decode16,
                            0x00C0,             // Address Range Minimum
                            0x00C0,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x20,               // Address Length
                            )
                        DMA (Compatibility, NotBusMaster, Transfer8_16)
                            {4}
                    })
                }

                Device (FWHD)
                {
                    Name (_HID, EisaId ("INT0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0xFF000000,         // Address Base
                            0x01000000,         // Address Length
                            )
                    })
                }

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103"))
                    Name (BUF0, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            )
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LNot (LLess (OSYS, 0x07D1)))
                        {
                            If (HPAE)
                            {
                                Return (0x0F)
                            }
                        }
                        Else
                        {
                            If (HPAE)
                            {
                                Return (0x0B)
                            }
                        }

                        Return (Zero)
                    }

                    Method (_CRS, 0, Serialized)
                    {
                        If (HPAE)
                        {
                            CreateDWordField (BUF0, 0x04, HPT0)
                            If (LEqual (HPAS, One))
                            {
                                Store (0xFED01000, HPT0)
                            }

                            If (LEqual (HPAS, 0x02))
                            {
                                Store (0xFED02000, HPT0)
                            }

                            If (LEqual (HPAS, 0x03))
                            {
                                Store (0xFED03000, HPT0)
                            }
                        }

                        Return (BUF0)
                    }
                }

                Device (IPIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0020,             // Address Range Minimum
                            0x0020,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x0024,             // Address Range Minimum
                            0x0024,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x0028,             // Address Range Minimum
                            0x0028,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x002C,             // Address Range Minimum
                            0x002C,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x0030,             // Address Range Minimum
                            0x0030,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x0034,             // Address Range Minimum
                            0x0034,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x0038,             // Address Range Minimum
                            0x0038,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x003C,             // Address Range Minimum
                            0x003C,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x00A0,             // Address Range Minimum
                            0x00A0,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x00A4,             // Address Range Minimum
                            0x00A4,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x00A8,             // Address Range Minimum
                            0x00A8,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x00AC,             // Address Range Minimum
                            0x00AC,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x00B0,             // Address Range Minimum
                            0x00B0,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x00B4,             // Address Range Minimum
                            0x00B4,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x00B8,             // Address Range Minimum
                            0x00B8,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x00BC,             // Address Range Minimum
                            0x00BC,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x04D0,             // Address Range Minimum
                            0x04D0,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IRQNoFlags ()
                            {2}
                    })
                }

                Device (MATH)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x00F0,             // Address Range Minimum
                            0x00F0,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x01,               // Address Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                }

                Device (LDRC)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x02)
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x002E,             // Address Range Minimum
                            0x002E,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x004E,             // Address Range Minimum
                            0x004E,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x0061,             // Address Range Minimum
                            0x0061,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x01,               // Address Length
                            )
                        IO (Decode16,
                            0x0063,             // Address Range Minimum
                            0x0063,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x01,               // Address Length
                            )
                        IO (Decode16,
                            0x0065,             // Address Range Minimum
                            0x0065,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x01,               // Address Length
                            )
                        IO (Decode16,
                            0x0067,             // Address Range Minimum
                            0x0067,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x01,               // Address Length
                            )
                        IO (Decode16,
                            0x0070,             // Address Range Minimum
                            0x0070,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x01,               // Address Length
                            )
                        IO (Decode16,
                            0x0080,             // Address Range Minimum
                            0x0080,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x01,               // Address Length
                            )
                        IO (Decode16,
                            0x0092,             // Address Range Minimum
                            0x0092,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x01,               // Address Length
                            )
                        IO (Decode16,
                            0x00B2,             // Address Range Minimum
                            0x00B2,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x02,               // Address Length
                            )
                        IO (Decode16,
                            0x0680,             // Address Range Minimum
                            0x0680,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x20,               // Address Length
                            )
                        IO (Decode16,
                            0x0800,             // Address Range Minimum
                            0x0800,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x10,               // Address Length
                            )
                        IO (Decode16,
                            0x1000,             // Address Range Minimum
                            0x1000,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x80,               // Address Length
                            )
                        IO (Decode16,
                            0x1180,             // Address Range Minimum
                            0x1180,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x40,               // Address Length
                            )
                        IO (Decode16,
                            0x1640,             // Address Range Minimum
                            0x1640,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x10,               // Address Length
                            )
                    })
                }

                Device (CDRC)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x03)
                    Name (BUF0, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x06B0,             // Address Range Minimum
                            0x06B0,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x40,               // Address Length
                            )
                    })
                    Name (BUF1, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x06B0,             // Address Range Minimum
                            0x06B0,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x50,               // Address Length
                            )
                    })
                    Name (BUF2, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x06A0,             // Address Range Minimum
                            0x06A0,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x10,               // Address Length
                            )
                        IO (Decode16,
                            0x06B0,             // Address Range Minimum
                            0x06B0,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x40,               // Address Length
                            )
                    })
                    Name (BUF3, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x06A0,             // Address Range Minimum
                            0x06A0,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x10,               // Address Length
                            )
                        IO (Decode16,
                            0x06B0,             // Address Range Minimum
                            0x06B0,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x50,               // Address Length
                            )
                    })
                    Method (_CRS, 0, Serialized)
                    {
                        If (LOr (EMAE, LNot (ECPC)))
                        {
                            If (CIRP)
                            {
                                Return (BUF0)
                            }

                            Return (BUF1)
                        }
                        Else
                        {
                            If (CIRP)
                            {
                                Return (BUF2)
                            }

                            Return (BUF3)
                        }
                    }
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Address Range Minimum
                            0x0070,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x08,               // Address Length
                            )
                        IRQNoFlags ()
                            {8}
                    })
                }

                Device (TIMR)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Address Range Minimum
                            0x0040,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x04,               // Address Length
                            )
                        IO (Decode16,
                            0x0050,             // Address Range Minimum
                            0x0050,             // Address Range Maximum
                            0x10,               // Address Alignment
                            0x04,               // Address Length
                            )
                        IRQNoFlags ()
                            {0}
                    })
                }

                Device (N393)
                {
                    Name (_HID, EisaId ("PNP0A05"))
                    Name (_UID, One)
                    Method (_STA, 0, Serialized)
                    {
                        If (NATP)
                        {
                            Return (0x0F)
                        }

                        Return (Zero)
                    }

                    OperationRegion (N393, SystemIO, 0x2E, 0x02)
                    Field (N393, ByteAcc, Lock, Preserve)
                    {
                        INDX,   8,
                        DATA,   8
                    }

                    IndexField (INDX, DATA, ByteAcc, Lock, Preserve)
                    {
                        Offset (0x07),
                        R07H,   8,
                        Offset (0x20),
                        R20H,   8,
                        R21H,   8,
                        R22H,   8,
                        R23H,   8,
                        R24H,   8,
                        R25H,   8,
                        R26H,   8,
                        R27H,   8,
                        R28H,   8,
                        R29H,   8,
                        R2AH,   8,
                        Offset (0x30),
                        R30H,   8,
                        Offset (0x60),
                        R60H,   8,
                        R61H,   8,
                        Offset (0x70),
                        R70H,   8,
                        R71H,   8,
                        Offset (0x74),
                        R74H,   8,
                        R75H,   8,
                        Offset (0xF0),
                        RF0H,   8,
                        RF1H,   8
                    }

                    Device (COMA)
                    {
                        Name (_HID, EisaId ("PNP0501"))
                        Name (_UID, 0x02)
                        Method (_STA, 0, Serialized)
                        {
                            If (LAnd (NATP, CMAP))
                            {
                                Store (0x03, R07H)
                                If (R30H)
                                {
                                    Return (0x0F)
                                }

                                Return (0x0D)
                            }

                            Return (Zero)
                        }

                        Method (_DIS, 0, Serialized)
                        {
                            Store (0x03, R07H)
                            Store (Zero, R30H)
                        }

                        Method (_CRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x03F8,             // Address Range Minimum
                                    0x03F8,             // Address Range Maximum
                                    0x01,               // Address Alignment
                                    0x08,               // Address Length
                                    )
                                IRQNoFlags ()
                                    {4}
                            })
                            Store (0x03, R07H)
                            If (LAnd (NATP, CMAP))
                            {
                                CreateByteField (BUF0, 0x02, IOL0)
                                CreateByteField (BUF0, 0x03, IOH0)
                                CreateByteField (BUF0, 0x04, IOL1)
                                CreateByteField (BUF0, 0x05, IOH1)
                                CreateByteField (BUF0, 0x07, LEN0)
                                CreateWordField (BUF0, 0x09, IRQW)
                                Store (R60H, IOH0)
                                Store (R61H, IOL0)
                                Store (R60H, IOH1)
                                Store (R61H, IOL1)
                                Store (0x08, LEN0)
                                And (R70H, 0x0F, Local0)
                                If (Local0)
                                {
                                    ShiftLeft (One, Local0, IRQW)
                                }
                                Else
                                {
                                    Store (Zero, IRQW)
                                }
                            }

                            Return (BUF0)
                        }

                        Method (_PRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02E8,             // Address Range Minimum
                                        0x02E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02F8,             // Address Range Minimum
                                        0x02F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03E8,             // Address Range Minimum
                                        0x03E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03F8,             // Address Range Minimum
                                        0x03F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02E8,             // Address Range Minimum
                                        0x02E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02F8,             // Address Range Minimum
                                        0x02F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03E8,             // Address Range Minimum
                                        0x03E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03F8,             // Address Range Minimum
                                        0x03F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                }
                                EndDependentFn ()
                            })
                            Return (BUF0)
                        }

                        Method (_SRS, 1, Serialized)
                        {
                            CreateByteField (Arg0, 0x02, IOLO)
                            CreateByteField (Arg0, 0x03, IOHI)
                            CreateWordField (Arg0, 0x09, IRQW)
                            Store (0x03, R07H)
                            Store (Zero, R30H)
                            Store (IOLO, R61H)
                            Store (IOHI, R60H)
                            FindSetRightBit (IRQW, Local0)
                            If (LNot (LEqual (IRQW, Zero)))
                            {
                                Decrement (Local0)
                            }

                            Store (Local0, R70H)
                            And (IOD0, 0xF8, IOD0)
                            If (LEqual (IOHI, 0x03))
                            {
                                If (LEqual (IOLO, 0xF8))
                                {
                                    Or (IOD0, Zero, IOD0)
                                }
                                Else
                                {
                                    Or (IOD0, 0x07, IOD0)
                                }
                            }
                            Else
                            {
                                If (LEqual (IOLO, 0xF8))
                                {
                                    Or (IOD0, One, IOD0)
                                }
                                Else
                                {
                                    Or (IOD0, 0x05, IOD0)
                                }
                            }

                            Store (One, R30H)
                        }

                        Method (_PS0, 0, Serialized)
                        {
                            Store (0x03, R07H)
                            Store (One, R30H)
                        }

                        Method (_PS3, 0, Serialized)
                        {
                            Store (0x03, R07H)
                            Store (Zero, R30H)
                        }
                    }

                    Device (COMB)
                    {
                        Name (_HID, EisaId ("PNP0501"))
                        Name (_UID, 0x03)
                        Method (_STA, 0, Serialized)
                        {
                            If (LAnd (NATP, CMBP))
                            {
                                Store (0x02, R07H)
                                If (R30H)
                                {
                                    Return (0x0F)
                                }

                                Return (0x0D)
                            }

                            Return (Zero)
                        }

                        Method (_DIS, 0, Serialized)
                        {
                            Store (0x02, R07H)
                            Store (Zero, R30H)
                        }

                        Method (_CRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x02F8,             // Address Range Minimum
                                    0x02F8,             // Address Range Maximum
                                    0x01,               // Address Alignment
                                    0x08,               // Address Length
                                    )
                                IRQNoFlags ()
                                    {3}
                            })
                            Store (0x02, R07H)
                            If (LAnd (NATP, CMBP))
                            {
                                CreateByteField (BUF0, 0x02, IOL0)
                                CreateByteField (BUF0, 0x03, IOH0)
                                CreateByteField (BUF0, 0x04, IOL1)
                                CreateByteField (BUF0, 0x05, IOH1)
                                CreateByteField (BUF0, 0x07, LEN0)
                                CreateWordField (BUF0, 0x09, IRQW)
                                Store (R60H, IOH0)
                                Store (R61H, IOL0)
                                Store (R60H, IOH1)
                                Store (R61H, IOL1)
                                Store (0x08, LEN0)
                                And (R70H, 0x0F, Local0)
                                If (Local0)
                                {
                                    ShiftLeft (One, Local0, IRQW)
                                }
                                Else
                                {
                                    Store (Zero, IRQW)
                                }
                            }

                            Return (BUF0)
                        }

                        Method (_PRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02E8,             // Address Range Minimum
                                        0x02E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02F8,             // Address Range Minimum
                                        0x02F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03E8,             // Address Range Minimum
                                        0x03E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03F8,             // Address Range Minimum
                                        0x03F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02E8,             // Address Range Minimum
                                        0x02E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02F8,             // Address Range Minimum
                                        0x02F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03E8,             // Address Range Minimum
                                        0x03E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03F8,             // Address Range Minimum
                                        0x03F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                }
                                EndDependentFn ()
                            })
                            Return (BUF0)
                        }

                        Method (_SRS, 1, Serialized)
                        {
                            CreateByteField (Arg0, 0x02, IOLO)
                            CreateByteField (Arg0, 0x03, IOHI)
                            CreateWordField (Arg0, 0x09, IRQW)
                            Store (0x02, R07H)
                            Store (Zero, R30H)
                            Store (IOLO, R61H)
                            Store (IOHI, R60H)
                            FindSetRightBit (IRQW, Local0)
                            If (LNot (LEqual (IRQW, Zero)))
                            {
                                Decrement (Local0)
                            }

                            Store (Local0, R70H)
                            And (IOD0, 0x8F, IOD0)
                            If (LEqual (IOHI, 0x03))
                            {
                                If (LEqual (IOLO, 0xF8))
                                {
                                    Or (IOD0, Zero, IOD0)
                                }
                                Else
                                {
                                    Or (IOD0, 0x70, IOD0)
                                }
                            }
                            Else
                            {
                                If (LEqual (IOLO, 0xF8))
                                {
                                    Or (IOD0, 0x10, IOD0)
                                }
                                Else
                                {
                                    Or (IOD0, 0x50, IOD0)
                                }
                            }

                            Store (One, R30H)
                        }

                        Method (_PS0, 0, Serialized)
                        {
                            Store (0x02, R07H)
                            Store (One, R30H)
                        }

                        Method (_PS3, 0, Serialized)
                        {
                            Store (0x02, R07H)
                            Store (Zero, R30H)
                        }
                    }

                    Device (FDSK)
                    {
                        Name (_HID, EisaId ("PNP0700"))
                        Method (_STA, 0, Serialized)
                        {
                            If (LAnd (NATP, FDCP))
                            {
                                Store (Zero, R07H)
                                If (R30H)
                                {
                                    Return (0x0F)
                                }

                                Return (0x0D)
                            }

                            Return (Zero)
                        }

                        Method (_DIS, 0, Serialized)
                        {
                            Store (Zero, R07H)
                            Store (Zero, R30H)
                        }

                        Method (_CRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x03F0,             // Address Range Minimum
                                    0x03F0,             // Address Range Maximum
                                    0x01,               // Address Alignment
                                    0x06,               // Address Length
                                    )
                                IO (Decode16,
                                    0x03F7,             // Address Range Minimum
                                    0x03F7,             // Address Range Maximum
                                    0x01,               // Address Alignment
                                    0x01,               // Address Length
                                    )
                                IRQNoFlags ()
                                    {6}
                                DMA (Compatibility, NotBusMaster, Transfer8_16)
                                    {2}
                            })
                            Store (Zero, R07H)
                            If (LAnd (NATP, FDCP))
                            {
                                CreateByteField (BUF0, 0x02, IOL0)
                                CreateByteField (BUF0, 0x03, IOH0)
                                CreateByteField (BUF0, 0x04, IOL1)
                                CreateByteField (BUF0, 0x05, IOH1)
                                CreateByteField (BUF0, 0x07, LEN0)
                                CreateByteField (BUF0, 0x0A, IOL2)
                                CreateByteField (BUF0, 0x0B, IOH2)
                                CreateByteField (BUF0, 0x0C, IOL3)
                                CreateByteField (BUF0, 0x0D, IOH3)
                                CreateByteField (BUF0, 0x0F, LEN1)
                                CreateWordField (BUF0, 0x11, IRQW)
                                CreateByteField (BUF0, 0x14, DMA0)
                                Store (And (R61H, 0xF0), IOL0)
                                Store (R60H, IOH0)
                                If (LAnd (IOL0, IOH0))
                                {
                                    Store (IOL0, IOL1)
                                    Store (IOH0, IOH1)
                                    Store (Or (IOL0, 0x07), IOL2)
                                    Store (IOH0, IOH2)
                                    Store (IOL2, IOL3)
                                    Store (IOH2, IOH3)
                                    Store (0x06, LEN0)
                                    Store (One, LEN1)
                                }

                                And (R70H, 0x0F, Local0)
                                If (Local0)
                                {
                                    ShiftLeft (One, Local0, IRQW)
                                }
                                Else
                                {
                                    Store (Zero, IRQW)
                                }

                                Store (R74H, Local0)
                                If (LEqual (Local0, 0x04))
                                {
                                    Store (Zero, DMA0)
                                }
                                Else
                                {
                                    ShiftLeft (One, Local0, DMA0)
                                }
                            }

                            Return (BUF0)
                        }

                        Method (_PRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03F0,             // Address Range Minimum
                                        0x03F0,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x06,               // Address Length
                                        )
                                    IO (Decode16,
                                        0x03F7,             // Address Range Minimum
                                        0x03F7,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x01,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {6}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {2}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0370,             // Address Range Minimum
                                        0x0370,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x06,               // Address Length
                                        )
                                    IO (Decode16,
                                        0x0377,             // Address Range Minimum
                                        0x0377,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x01,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {6}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {2}
                                }
                                EndDependentFn ()
                            })
                            Return (BUF0)
                        }

                        Method (_SRS, 1, Serialized)
                        {
                            CreateByteField (Arg0, 0x02, IOLO)
                            CreateByteField (Arg0, 0x03, IOHI)
                            CreateWordField (Arg0, 0x11, IRQW)
                            CreateWordField (Arg0, 0x14, DMAC)
                            Store (Zero, R07H)
                            Store (Zero, R30H)
                            Store (IOLO, R61H)
                            Store (IOHI, R60H)
                            FindSetRightBit (IRQW, Local0)
                            If (LNot (LEqual (IRQW, Zero)))
                            {
                                Decrement (Local0)
                            }

                            Store (Local0, R70H)
                            FindSetRightBit (DMAC, Local0)
                            If (LNot (LEqual (DMAC, Zero)))
                            {
                                Decrement (Local0)
                            }

                            Store (Local0, R74H)
                            If (LEqual (IOLO, 0xF0))
                            {
                                And (IOD1, 0xEF, IOD1)
                            }
                            Else
                            {
                                Or (IOD1, 0x10, IOD1)
                            }

                            Store (One, R30H)
                        }

                        Method (_PS0, 0, Serialized)
                        {
                            Store (Zero, R07H)
                            Store (One, R30H)
                        }

                        Method (_PS3, 0, Serialized)
                        {
                            Store (Zero, R07H)
                            Store (Zero, R30H)
                        }
                    }

                    Device (POUT)
                    {
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_UID, One)
                        Method (_STA, 0, Serialized)
                        {
                            If (LEqual (And (RF0H, 0xE0), Zero))
                            {
                                If (LAnd (NATP, LPTP))
                                {
                                    Store (One, R07H)
                                    If (R30H)
                                    {
                                        Return (0x0F)
                                    }

                                    Return (0x0D)
                                }
                            }

                            Return (Zero)
                        }

                        Method (_DIS, 0, Serialized)
                        {
                            Store (One, R07H)
                            If (LEqual (And (RF0H, 0xE0), Zero))
                            {
                                Store (Zero, R30H)
                            }
                        }

                        Method (_CRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x0378,             // Address Range Minimum
                                    0x0378,             // Address Range Maximum
                                    0x01,               // Address Alignment
                                    0x04,               // Address Length
                                    )
                                IRQNoFlags ()
                                    {7}
                            })
                            If (LEqual (And (RF0H, 0xE0), Zero))
                            {
                                CreateByteField (BUF0, 0x02, IOL0)
                                CreateByteField (BUF0, 0x03, IOH0)
                                CreateByteField (BUF0, 0x04, IOL1)
                                CreateByteField (BUF0, 0x05, IOH1)
                                CreateByteField (BUF0, 0x07, LEN0)
                                CreateWordField (BUF0, 0x09, IRQW)
                                Store (One, R07H)
                                Store (R61H, IOL0)
                                Store (R60H, IOH0)
                                Store (IOL0, IOL1)
                                Store (IOH0, IOH1)
                                Store (0x04, LEN0)
                                If (And (R70H, 0x0F))
                                {
                                    ShiftLeft (One, And (R70H, 0x0F), IRQW)
                                }
                                Else
                                {
                                    Store (Zero, IRQW)
                                }
                            }

                            Return (BUF0)
                        }

                        Method (_PRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0378,             // Address Range Minimum
                                        0x0378,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x04,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {7}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0278,             // Address Range Minimum
                                        0x0278,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x04,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {7}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03BC,             // Address Range Minimum
                                        0x03BC,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x04,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {7}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0378,             // Address Range Minimum
                                        0x0378,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x04,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {5}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0278,             // Address Range Minimum
                                        0x0278,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x04,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {5}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03BC,             // Address Range Minimum
                                        0x03BC,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x04,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {5}
                                }
                                EndDependentFn ()
                            })
                            Return (BUF0)
                        }

                        Method (_SRS, 1, Serialized)
                        {
                            CreateByteField (Arg0, 0x02, IOL0)
                            CreateByteField (Arg0, 0x03, IOH0)
                            CreateWordField (Arg0, 0x09, IRQW)
                            Store (One, R07H)
                            Store (Zero, R30H)
                            And (RF0H, 0x0F, RF0H)
                            Store (0x04, R74H)
                            Store (IOL0, R61H)
                            Store (IOH0, R60H)
                            FindSetRightBit (IRQW, Local0)
                            If (LNot (LEqual (IRQW, Zero)))
                            {
                                Decrement (Local0)
                            }

                            Store (Local0, R70H)
                            And (IOD1, 0xFC, IOD1)
                            If (LEqual (IOH0, 0x03))
                            {
                                If (LEqual (IOL0, 0x78))
                                {
                                    Or (IOD1, Zero, IOD1)
                                }
                                Else
                                {
                                    Or (IOD1, 0x02, IOD1)
                                }
                            }
                            Else
                            {
                                Or (IOD1, One, IOD1)
                            }

                            Store (One, R30H)
                        }

                        Method (_PS0, 0, Serialized)
                        {
                            Store (One, R07H)
                            Store (One, R30H)
                        }

                        Method (_PS3, 0, Serialized)
                        {
                            Store (One, R07H)
                            Store (Zero, R30H)
                        }
                    }

                    Device (PBID)
                    {
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_UID, 0x02)
                        Method (_STA, 0, Serialized)
                        {
                            Store (One, R07H)
                            If (LEqual (And (RF0H, 0xE0), 0x20))
                            {
                                If (LAnd (NATP, LPTP))
                                {
                                    If (R30H)
                                    {
                                        Return (0x0F)
                                    }

                                    Return (0x0D)
                                }
                            }

                            Return (Zero)
                        }

                        Method (_DIS, 0, Serialized)
                        {
                            Store (One, R07H)
                            If (LEqual (And (RF0H, 0xE0), 0x20))
                            {
                                Store (Zero, R30H)
                            }
                        }

                        Method (_CRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x0378,             // Address Range Minimum
                                    0x0378,             // Address Range Maximum
                                    0x01,               // Address Alignment
                                    0x04,               // Address Length
                                    )
                                IRQNoFlags ()
                                    {7}
                            })
                            If (LEqual (And (RF0H, 0xE0), 0x20))
                            {
                                CreateByteField (BUF0, 0x02, IOL0)
                                CreateByteField (BUF0, 0x03, IOH0)
                                CreateByteField (BUF0, 0x04, IOL1)
                                CreateByteField (BUF0, 0x05, IOH1)
                                CreateByteField (BUF0, 0x07, LEN0)
                                CreateWordField (BUF0, 0x09, IRQW)
                                Store (One, R07H)
                                Store (R61H, IOL0)
                                Store (R60H, IOH0)
                                Store (IOL0, IOL1)
                                Store (IOH0, IOH1)
                                Store (0x04, LEN0)
                                If (And (R70H, 0x0F))
                                {
                                    ShiftLeft (One, And (R70H, 0x0F), IRQW)
                                }
                                Else
                                {
                                    Store (Zero, IRQW)
                                }
                            }

                            Return (BUF0)
                        }

                        Method (_PRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0378,             // Address Range Minimum
                                        0x0378,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x04,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {7}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0278,             // Address Range Minimum
                                        0x0278,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x04,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {7}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03BC,             // Address Range Minimum
                                        0x03BC,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x04,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {7}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0378,             // Address Range Minimum
                                        0x0378,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x04,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {5}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0278,             // Address Range Minimum
                                        0x0278,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x04,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {5}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03BC,             // Address Range Minimum
                                        0x03BC,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x04,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {5}
                                }
                                EndDependentFn ()
                            })
                            Return (BUF0)
                        }

                        Method (_SRS, 1, Serialized)
                        {
                            CreateByteField (Arg0, 0x02, IOL0)
                            CreateByteField (Arg0, 0x03, IOH0)
                            CreateWordField (Arg0, 0x09, IRQW)
                            Store (One, R07H)
                            Store (Zero, R30H)
                            Or (And (RF0H, 0x0F), 0x20, RF0H)
                            Store (0x04, R74H)
                            Store (IOL0, R61H)
                            Store (IOH0, R60H)
                            FindSetRightBit (IRQW, Local0)
                            If (LNot (LEqual (IRQW, Zero)))
                            {
                                Decrement (Local0)
                            }

                            Store (Local0, R70H)
                            And (IOD1, 0xFC, IOD1)
                            If (LEqual (IOH0, 0x03))
                            {
                                If (LEqual (IOL0, 0x78))
                                {
                                    Or (IOD1, Zero, IOD1)
                                }
                                Else
                                {
                                    Or (IOD1, 0x02, IOD1)
                                }
                            }
                            Else
                            {
                                Or (IOD1, One, IOD1)
                            }

                            Store (One, R30H)
                        }

                        Method (_PS0, 0, Serialized)
                        {
                            Store (One, R07H)
                            Store (One, R30H)
                        }

                        Method (_PS3, 0, Serialized)
                        {
                            Store (One, R07H)
                            Store (Zero, R30H)
                        }
                    }

                    Device (PEPP)
                    {
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_UID, 0x03)
                        Method (_STA, 0, Serialized)
                        {
                            Store (One, R07H)
                            If (LEqual (And (RF0H, 0xE0), 0x60))
                            {
                                If (LAnd (NATP, LPTP))
                                {
                                    If (R30H)
                                    {
                                        Return (0x0F)
                                    }
                                    Else
                                    {
                                        Return (0x0D)
                                    }
                                }
                            }

                            Return (Zero)
                        }

                        Method (_DIS, 0, Serialized)
                        {
                            Store (One, R07H)
                            If (LEqual (And (RF0H, 0xE0), 0x60))
                            {
                                Store (Zero, R30H)
                            }
                        }

                        Method (_CRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x0378,             // Address Range Minimum
                                    0x0378,             // Address Range Maximum
                                    0x01,               // Address Alignment
                                    0x08,               // Address Length
                                    )
                                IRQNoFlags ()
                                    {7}
                            })
                            If (LEqual (And (RF0H, 0xE0), 0x60))
                            {
                                CreateByteField (BUF0, 0x02, IOL0)
                                CreateByteField (BUF0, 0x03, IOH0)
                                CreateByteField (BUF0, 0x04, IOL1)
                                CreateByteField (BUF0, 0x05, IOH1)
                                CreateByteField (BUF0, 0x07, LEN0)
                                CreateWordField (BUF0, 0x09, IRQW)
                                Store (One, R07H)
                                Store (R61H, IOL0)
                                Store (R60H, IOH0)
                                Store (IOL0, IOL1)
                                Store (IOH0, IOH1)
                                Store (0x08, LEN0)
                                If (And (R70H, 0x0F))
                                {
                                    ShiftLeft (One, And (R70H, 0x0F), IRQW)
                                }
                                Else
                                {
                                    Store (Zero, IRQW)
                                }
                            }

                            Return (BUF0)
                        }

                        Method (_PRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0378,             // Address Range Minimum
                                        0x0378,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {7}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0278,             // Address Range Minimum
                                        0x0278,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {7}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0378,             // Address Range Minimum
                                        0x0378,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {5}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0278,             // Address Range Minimum
                                        0x0278,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {5}
                                }
                                EndDependentFn ()
                            })
                            Return (BUF0)
                        }

                        Method (_SRS, 1, Serialized)
                        {
                            CreateByteField (Arg0, 0x02, IOL0)
                            CreateByteField (Arg0, 0x03, IOH0)
                            CreateWordField (Arg0, 0x09, IRQW)
                            Store (One, R07H)
                            Store (Zero, R30H)
                            Or (And (RF0H, 0x0F), 0x60, RF0H)
                            Store (0x04, R74H)
                            Store (IOL0, R61H)
                            Store (IOH0, R60H)
                            FindSetRightBit (IRQW, Local0)
                            If (LNot (LEqual (IRQW, Zero)))
                            {
                                Decrement (Local0)
                            }

                            Store (Local0, R70H)
                            And (IOD1, 0xFC, IOD1)
                            If (LEqual (IOH0, 0x03))
                            {
                                Or (IOD1, Zero, IOD1)
                            }
                            Else
                            {
                                Or (IOD1, One, IOD1)
                            }

                            Store (One, R30H)
                        }

                        Method (_PS0, 0, Serialized)
                        {
                            Store (One, R07H)
                            Store (One, R30H)
                        }

                        Method (_PS3, 0, Serialized)
                        {
                            Store (One, R07H)
                            Store (Zero, R30H)
                        }
                    }

                    Device (PECP)
                    {
                        Name (_HID, EisaId ("PNP0401"))
                        Name (_UID, 0x04)
                        Method (_STA, 0, Serialized)
                        {
                            Store (One, R07H)
                            If (LEqual (And (RF0H, 0xE0), 0xE0))
                            {
                                If (LAnd (NATP, LPTP))
                                {
                                    If (R30H)
                                    {
                                        Return (0x0F)
                                    }
                                    Else
                                    {
                                        Return (0x0D)
                                    }
                                }
                            }

                            Return (Zero)
                        }

                        Method (_DIS, 0, Serialized)
                        {
                            Store (One, R07H)
                            If (LEqual (And (RF0H, 0xE0), 0xE0))
                            {
                                Store (Zero, R30H)
                            }
                        }

                        Method (_CRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x0378,             // Address Range Minimum
                                    0x0378,             // Address Range Maximum
                                    0x01,               // Address Alignment
                                    0x08,               // Address Length
                                    )
                                IO (Decode16,
                                    0x0778,             // Address Range Minimum
                                    0x0778,             // Address Range Maximum
                                    0x01,               // Address Alignment
                                    0x08,               // Address Length
                                    )
                                IRQNoFlags ()
                                    {7}
                                DMA (Compatibility, NotBusMaster, Transfer8_16)
                                    {1}
                            })
                            If (LEqual (And (RF0H, 0xE0), 0xE0))
                            {
                                CreateByteField (BUF0, 0x02, IOL0)
                                CreateByteField (BUF0, 0x03, IOH0)
                                CreateByteField (BUF0, 0x04, IOL1)
                                CreateByteField (BUF0, 0x05, IOH1)
                                CreateByteField (BUF0, 0x07, LEN0)
                                CreateByteField (BUF0, 0x0A, IOL2)
                                CreateByteField (BUF0, 0x0B, IOH2)
                                CreateByteField (BUF0, 0x0C, IOL3)
                                CreateByteField (BUF0, 0x0D, IOH3)
                                CreateByteField (BUF0, 0x0F, LEN1)
                                CreateWordField (BUF0, 0x11, IRQW)
                                CreateByteField (BUF0, 0x14, DMA0)
                                Store (One, R07H)
                                Store (R61H, IOL0)
                                Store (R60H, IOH0)
                                Store (IOL0, IOL1)
                                Store (IOH0, IOH1)
                                Store (IOL0, IOL2)
                                Store (Add (0x04, IOH0), IOH2)
                                Store (IOL0, IOL3)
                                Store (Add (0x04, IOH0), IOH3)
                                Store (0x08, LEN0)
                                Store (0x08, LEN1)
                                And (R70H, 0x0F, Local0)
                                If (Local0)
                                {
                                    ShiftLeft (One, Local0, IRQW)
                                }
                                Else
                                {
                                    Store (Zero, IRQW)
                                }

                                Store (R74H, Local0)
                                If (LEqual (Local0, 0x04))
                                {
                                    Store (Zero, DMA0)
                                }
                                Else
                                {
                                    ShiftLeft (One, Local0, DMA0)
                                }
                            }

                            Return (BUF0)
                        }

                        Method (_PRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0378,             // Address Range Minimum
                                        0x0378,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IO (Decode16,
                                        0x0778,             // Address Range Minimum
                                        0x0778,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {7}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0278,             // Address Range Minimum
                                        0x0278,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IO (Decode16,
                                        0x0678,             // Address Range Minimum
                                        0x0678,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {7}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0378,             // Address Range Minimum
                                        0x0378,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IO (Decode16,
                                        0x0778,             // Address Range Minimum
                                        0x0778,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {5}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0278,             // Address Range Minimum
                                        0x0278,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IO (Decode16,
                                        0x0678,             // Address Range Minimum
                                        0x0678,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {5}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0378,             // Address Range Minimum
                                        0x0378,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IO (Decode16,
                                        0x0778,             // Address Range Minimum
                                        0x0778,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {7}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {1}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0278,             // Address Range Minimum
                                        0x0278,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IO (Decode16,
                                        0x0678,             // Address Range Minimum
                                        0x0678,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {7}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {1}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0378,             // Address Range Minimum
                                        0x0378,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IO (Decode16,
                                        0x0778,             // Address Range Minimum
                                        0x0778,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {5}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {1}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x0278,             // Address Range Minimum
                                        0x0278,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IO (Decode16,
                                        0x0678,             // Address Range Minimum
                                        0x0678,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {5}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {1}
                                }
                                EndDependentFn ()
                            })
                            Return (BUF0)
                        }

                        Method (_SRS, 1, Serialized)
                        {
                            CreateByteField (Arg0, 0x02, IOL0)
                            CreateByteField (Arg0, 0x03, IOH0)
                            CreateWordField (Arg0, 0x11, IRQW)
                            CreateByteField (Arg0, 0x14, DMA0)
                            Store (One, R07H)
                            Store (Zero, R30H)
                            Or (RF0H, 0xF0, RF0H)
                            Store (IOL0, R61H)
                            Store (IOH0, R60H)
                            FindSetRightBit (IRQW, Local0)
                            If (LNot (LEqual (IRQW, Zero)))
                            {
                                Decrement (Local0)
                            }

                            Store (Local0, R70H)
                            FindSetRightBit (DMA0, Local0)
                            If (LNot (LEqual (DMA0, Zero)))
                            {
                                Decrement (Local0)
                            }

                            Store (Local0, R74H)
                            And (IOD1, 0xFC, IOD1)
                            If (LEqual (IOH0, 0x03))
                            {
                                Or (IOD1, Zero, IOD1)
                            }
                            Else
                            {
                                Or (IOD1, One, IOD1)
                            }

                            Store (One, R30H)
                        }

                        Method (_PS0, 0, Serialized)
                        {
                            Store (One, R07H)
                            Store (One, R30H)
                        }

                        Method (_PS3, 0, Serialized)
                        {
                            Store (One, R07H)
                            Store (Zero, R30H)
                        }
                    }
                }

                Device (N207)
                {
                    Name (_HID, EisaId ("PNP0A05"))
                    Name (_UID, 0x02)
                    OperationRegion (N207, SystemIO, 0x164E, 0x02)
                    Field (N207, ByteAcc, Lock, Preserve)
                    {
                        INDX,   8,
                        DATA,   8
                    }

                    IndexField (INDX, DATA, ByteAcc, Lock, Preserve)
                    {
                        Offset (0x02),
                        CR02,   8,
                        Offset (0x24),
                        CR24,   8,
                        CR25,   8,
                        Offset (0x28),
                        CR28,   8,
                        Offset (0x3A),
                        CR3A,   8,
                        CR3B,   8,
                        CR3C,   8,
                        Offset (0x55),
                        CR55,   8,
                        Offset (0xAA),
                        CRAA,   8
                    }

                    Device (UART)
                    {
                        Name (_HID, EisaId ("PNP0501"))
                        Name (_UID, One)
                        Name (_PRW, Package (0x02)
                        {
                            0x08,
                            0x03
                        })
                        Method (_STA, 0, Serialized)
                        {
                            If (CMCP)
                            {
                                Store (Zero, CR55)
                                Store (CR02, Local0)
                                Store (Zero, CRAA)
                                If (And (Local0, 0x08))
                                {
                                    Return (0x0F)
                                }

                                Return (0x0D)
                            }

                            Return (Zero)
                        }

                        Method (_DIS, 0, Serialized)
                        {
                            Store (Zero, CR55)
                            Store (And (CR02, 0xF0), CR02)
                            Store (Zero, CRAA)
                        }

                        Method (_CRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x03F8,             // Address Range Minimum
                                    0x03F8,             // Address Range Maximum
                                    0x01,               // Address Alignment
                                    0x08,               // Address Length
                                    )
                                IRQNoFlags ()
                                    {4}
                            })
                            If (CMCP)
                            {
                                CreateByteField (BUF0, 0x02, IOL0)
                                CreateByteField (BUF0, 0x03, IOH0)
                                CreateByteField (BUF0, 0x04, IOL1)
                                CreateByteField (BUF0, 0x05, IOH1)
                                CreateByteField (BUF0, 0x07, LEN0)
                                CreateWordField (BUF0, 0x09, IRQW)
                                Store (Zero, CR55)
                                ShiftLeft (CR24, 0x02, IOL0)
                                ShiftLeft (CR24, 0x02, IOL1)
                                ShiftRight (CR24, 0x06, IOH0)
                                ShiftRight (CR24, 0x06, IOH1)
                                Store (0x08, LEN0)
                                ShiftLeft (One, ShiftRight (And (CR28, 0xF0), 0x04), IRQW)
                                Store (Zero, CRAA)
                            }

                            Return (BUF0)
                        }

                        Method (_PRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02E8,             // Address Range Minimum
                                        0x02E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02F8,             // Address Range Minimum
                                        0x02F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03E8,             // Address Range Minimum
                                        0x03E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03F8,             // Address Range Minimum
                                        0x03F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02E8,             // Address Range Minimum
                                        0x02E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02F8,             // Address Range Minimum
                                        0x02F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03E8,             // Address Range Minimum
                                        0x03E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03F8,             // Address Range Minimum
                                        0x03F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                }
                                EndDependentFn ()
                            })
                            Return (BUF0)
                        }

                        Method (_SRS, 1, Serialized)
                        {
                            CreateByteField (Arg0, 0x02, IOLO)
                            CreateByteField (Arg0, 0x03, IOHI)
                            CreateWordField (Arg0, 0x09, IRQW)
                            Store (Zero, CR55)
                            Store (And (CR02, 0xF0), CR02)
                            Store (ShiftRight (IOLO, 0x02), CR24)
                            Or (CR24, ShiftLeft (IOHI, 0x06), CR24)
                            And (CR28, 0x0F, CR28)
                            Or (CR28, ShiftLeft (Subtract (FindSetRightBit (IRQW), One), 0x04), CR28)
                            And (IOD0, 0xF8, IOD0)
                            If (LEqual (IOHI, 0x03))
                            {
                                If (LEqual (IOLO, 0xF8))
                                {
                                    Or (IOD0, Zero, IOD0)
                                }
                                Else
                                {
                                    Or (IOD0, 0x07, IOD0)
                                }
                            }
                            Else
                            {
                                If (LEqual (IOLO, 0xF8))
                                {
                                    Or (IOD0, One, IOD0)
                                }
                                Else
                                {
                                    Or (IOD0, 0x05, IOD0)
                                }
                            }

                            Store (Or (CR02, 0x08), CR02)
                            Store (Zero, CRAA)
                        }

                        Method (_PS0, 0, Serialized)
                        {
                            Store (Zero, CR55)
                            Store (Or (CR02, 0x08), CR02)
                            Store (Zero, CRAA)
                        }

                        Method (_PS3, 0, Serialized)
                        {
                            Store (Zero, CR55)
                            Store (And (CR02, 0xF0), CR02)
                            Store (Zero, CRAA)
                        }
                    }

                    Device (URT2)
                    {
                        Name (_HID, EisaId ("PNP0510"))
                        Method (_STA, 0, Serialized)
                        {
                            If (CIRP)
                            {
                                Store (Zero, CR55)
                                Store (CR02, Local0)
                                Store (Zero, CRAA)
                                If (And (Local0, 0x80))
                                {
                                    Return (0x0F)
                                }

                                Return (0x0D)
                            }

                            Return (Zero)
                        }

                        Method (_DIS, 0, Serialized)
                        {
                            Store (Zero, CR55)
                            Store (And (CR02, 0x0F), CR02)
                            Store (Zero, CRAA)
                        }

                        Method (_CRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x03E8,             // Address Range Minimum
                                    0x03E8,             // Address Range Maximum
                                    0x01,               // Address Alignment
                                    0x08,               // Address Length
                                    )
                                IRQNoFlags ()
                                    {3}
                                DMA (Compatibility, NotBusMaster, Transfer8_16)
                                    {2}
                                IO (Decode16,
                                    0x06F0,             // Address Range Minimum
                                    0x06F0,             // Address Range Maximum
                                    0x01,               // Address Alignment
                                    0x08,               // Address Length
                                    )
                            })
                            If (CIRP)
                            {
                                CreateByteField (BUF0, 0x02, IOL0)
                                CreateByteField (BUF0, 0x03, IOH0)
                                CreateByteField (BUF0, 0x04, IOL1)
                                CreateByteField (BUF0, 0x05, IOH1)
                                CreateByteField (BUF0, 0x07, LEN0)
                                CreateWordField (BUF0, 0x09, IRQW)
                                Store (Zero, CR55)
                                ShiftLeft (CR25, 0x02, IOL0)
                                ShiftLeft (CR25, 0x02, IOL1)
                                ShiftRight (CR25, 0x06, IOH0)
                                ShiftRight (CR25, 0x06, IOH1)
                                Store (0x08, LEN0)
                                ShiftLeft (One, And (CR28, 0xF0), IRQW)
                                Store (Zero, CRAA)
                            }

                            Return (BUF0)
                        }

                        Method (_PRS, 0, Serialized)
                        {
                            Name (BUF0, ResourceTemplate ()
                            {
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02E8,             // Address Range Minimum
                                        0x02E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {2}
                                    IO (Decode16,
                                        0x06F0,             // Address Range Minimum
                                        0x06F0,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02F8,             // Address Range Minimum
                                        0x02F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {2}
                                    IO (Decode16,
                                        0x06F0,             // Address Range Minimum
                                        0x06F0,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03E8,             // Address Range Minimum
                                        0x03E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {2}
                                    IO (Decode16,
                                        0x06F0,             // Address Range Minimum
                                        0x06F0,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03F8,             // Address Range Minimum
                                        0x03F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {2}
                                    IO (Decode16,
                                        0x06F0,             // Address Range Minimum
                                        0x06F0,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02E8,             // Address Range Minimum
                                        0x02E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {2}
                                    IO (Decode16,
                                        0x06F0,             // Address Range Minimum
                                        0x06F0,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x02F8,             // Address Range Minimum
                                        0x02F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {2}
                                    IO (Decode16,
                                        0x06F0,             // Address Range Minimum
                                        0x06F0,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03E8,             // Address Range Minimum
                                        0x03E8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {2}
                                    IO (Decode16,
                                        0x06F0,             // Address Range Minimum
                                        0x06F0,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                }
                                StartDependentFn (0x00, 0x02)
                                {
                                    IO (Decode16,
                                        0x03F8,             // Address Range Minimum
                                        0x03F8,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                    IRQNoFlags ()
                                        {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8_16)
                                        {2}
                                    IO (Decode16,
                                        0x06F0,             // Address Range Minimum
                                        0x06F0,             // Address Range Maximum
                                        0x01,               // Address Alignment
                                        0x08,               // Address Length
                                        )
                                }
                                EndDependentFn ()
                            })
                            Return (BUF0)
                        }

                        Method (_SRS, 1, Serialized)
                        {
                            CreateByteField (Arg0, 0x02, IOLO)
                            CreateByteField (Arg0, 0x03, IOHI)
                            CreateWordField (Arg0, 0x09, IRQW)
                            Store (Zero, CR55)
                            Store (And (CR02, 0x0F), CR02)
                            Store (ShiftRight (IOLO, 0x02), CR25)
                            Or (CR25, ShiftLeft (IOHI, 0x06), CR25)
                            And (CR28, 0xF0, CR28)
                            Or (CR28, Subtract (FindSetRightBit (IRQW), One), CR28)
                            And (IOD0, 0xF8, IOD0)
                            If (LEqual (IOHI, 0x03))
                            {
                                If (LEqual (IOLO, 0xF8))
                                {
                                    Or (IOD0, Zero, IOD0)
                                }
                                Else
                                {
                                    Or (IOD0, 0x07, IOD0)
                                }
                            }
                            Else
                            {
                                If (LEqual (IOLO, 0xF8))
                                {
                                    Or (IOD0, One, IOD0)
                                }
                                Else
                                {
                                    Or (IOD0, 0x05, IOD0)
                                }
                            }

                            Store (Or (CR02, 0x80), CR02)
                            Store (Zero, CRAA)
                        }

                        Method (_PS0, 0, Serialized)
                        {
                            Store (Zero, CR55)
                            Store (Or (CR02, 0x80), CR02)
                            Store (Zero, CRAA)
                        }

                        Method (_PS3, 0, Serialized)
                        {
                            Store (Zero, CR55)
                            Store (And (CR02, 0x0F), CR02)
                            Store (Zero, CRAA)
                        }
                    }
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0060,             // Address Range Minimum
                            0x0060,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x01,               // Address Length
                            )
                        IO (Decode16,
                            0x0064,             // Address Range Minimum
                            0x0064,             // Address Range Maximum
                            0x01,               // Address Alignment
                            0x01,               // Address Length
                            )
                        IRQ (Edge, ActiveHigh, Exclusive)
                            {1}
                    })
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("PNP0F13"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQ (Edge, ActiveHigh, Exclusive)
                            {12}
                    })
                }
            }

            Device (PATA)
            {
                Name (_ADR, 0x001F0001)
                OperationRegion (PACS, PCI_Config, 0x40, 0xC0)
                Field (PACS, DWordAcc, NoLock, Preserve)
                {
                    PRIT,   16,
                    Offset (0x04),
                    PSIT,   4,
                    Offset (0x08),
                    SYNC,   4,
                    Offset (0x0A),
                    SDT0,   2,
                        ,   2,
                    SDT1,   2,
                    Offset (0x14),
                    ICR0,   4,
                    ICR1,   4,
                    ICR2,   4,
                    ICR3,   4,
                    ICR4,   4,
                    ICR5,   4
                }

                Device (PRID)
                {
                    Name (_ADR, Zero)
                    Method (_GTM, 0, NotSerialized)
                    {
                        Name (PBUF, Buffer (0x14)
                        {
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                            0x00, 0x00, 0x00, 0x00
                        })
                        CreateDWordField (PBUF, Zero, PIO0)
                        CreateDWordField (PBUF, 0x04, DMA0)
                        CreateDWordField (PBUF, 0x08, PIO1)
                        CreateDWordField (PBUF, 0x0C, DMA1)
                        CreateDWordField (PBUF, 0x10, FLAG)
                        Store (GETP (PRIT), PIO0)
                        Store (GDMA (And (SYNC, One), And (ICR3, One), And (ICR0, One), SDT0, And (ICR1, One)), DMA0)
                        If (LEqual (DMA0, Ones))
                        {
                            Store (PIO0, DMA0)
                        }

                        If (And (PRIT, 0x4000))
                        {
                            If (LEqual (And (PRIT, 0x90), 0x80))
                            {
                                Store (0x0384, PIO1)
                            }
                            Else
                            {
                                Store (GETT (PSIT), PIO1)
                            }
                        }
                        Else
                        {
                            Store (Ones, PIO1)
                        }

                        Store (GDMA (And (SYNC, 0x02), And (ICR3, 0x02), And (ICR0, 0x02), SDT1, And (ICR1, 0x02)), DMA1)
                        If (LEqual (DMA1, Ones))
                        {
                            Store (PIO1, DMA1)
                        }

                        Store (GETF (And (SYNC, One), And (SYNC, 0x02), PRIT), FLAG)
                        If (And (LEqual (PIO0, Ones), LEqual (DMA0, Ones)))
                        {
                            Store (0x78, PIO0)
                            Store (0x14, DMA0)
                            Store (0x03, FLAG)
                        }

                        Return (PBUF)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        CreateDWordField (Arg0, Zero, PIO0)
                        CreateDWordField (Arg0, 0x04, DMA0)
                        CreateDWordField (Arg0, 0x08, PIO1)
                        CreateDWordField (Arg0, 0x0C, DMA1)
                        CreateDWordField (Arg0, 0x10, FLAG)
                        If (LEqual (SizeOf (Arg1), 0x0200))
                        {
                            And (PRIT, 0x40F0, PRIT)
                            And (SYNC, 0x02, SYNC)
                            Store (Zero, SDT0)
                            And (ICR0, 0x02, ICR0)
                            And (ICR1, 0x02, ICR1)
                            And (ICR3, 0x02, ICR3)
                            And (ICR5, 0x02, ICR5)
                            CreateWordField (Arg1, 0x62, W490)
                            CreateWordField (Arg1, 0x6A, W530)
                            CreateWordField (Arg1, 0x7E, W630)
                            CreateWordField (Arg1, 0x80, W640)
                            CreateWordField (Arg1, 0xB0, W880)
                            CreateWordField (Arg1, 0xBA, W930)
                            Or (PRIT, 0x8004, PRIT)
                            If (LAnd (And (FLAG, 0x02), And (W490, 0x0800)))
                            {
                                Or (PRIT, 0x02, PRIT)
                            }

                            Or (PRIT, SETP (PIO0, W530, W640), PRIT)
                            If (And (FLAG, One))
                            {
                                Or (SYNC, One, SYNC)
                                Store (SDMA (DMA0), SDT0)
                                If (LLess (DMA0, 0x1E))
                                {
                                    Or (ICR3, One, ICR3)
                                }

                                If (LLess (DMA0, 0x3C))
                                {
                                    Or (ICR0, One, ICR0)
                                }

                                If (And (W930, 0x2000))
                                {
                                    Or (ICR1, One, ICR1)
                                }
                            }
                        }

                        If (LEqual (SizeOf (Arg2), 0x0200))
                        {
                            And (PRIT, 0x3F0F, PRIT)
                            Store (Zero, PSIT)
                            And (SYNC, One, SYNC)
                            Store (Zero, SDT1)
                            And (ICR0, One, ICR0)
                            And (ICR1, One, ICR1)
                            And (ICR3, One, ICR3)
                            And (ICR5, One, ICR5)
                            CreateWordField (Arg2, 0x62, W491)
                            CreateWordField (Arg2, 0x6A, W531)
                            CreateWordField (Arg2, 0x7E, W631)
                            CreateWordField (Arg2, 0x80, W641)
                            CreateWordField (Arg2, 0xB0, W881)
                            CreateWordField (Arg2, 0xBA, W931)
                            Or (PRIT, 0x8040, PRIT)
                            If (LAnd (And (FLAG, 0x08), And (W491, 0x0800)))
                            {
                                Or (PRIT, 0x20, PRIT)
                            }

                            If (And (FLAG, 0x10))
                            {
                                Or (PRIT, 0x4000, PRIT)
                                If (LGreater (PIO1, 0xF0))
                                {
                                    Or (PRIT, 0x80, PRIT)
                                }
                                Else
                                {
                                    Or (PRIT, 0x10, PRIT)
                                    Store (SETT (PIO1, W531, W641), PSIT)
                                }
                            }

                            If (And (FLAG, 0x04))
                            {
                                Or (SYNC, 0x02, SYNC)
                                Store (SDMA (DMA1), SDT1)
                                If (LLess (DMA1, 0x1E))
                                {
                                    Or (ICR3, 0x02, ICR3)
                                }

                                If (LLess (DMA1, 0x3C))
                                {
                                    Or (ICR0, 0x02, ICR0)
                                }

                                If (And (W931, 0x2000))
                                {
                                    Or (ICR1, 0x02, ICR1)
                                }
                            }
                        }
                    }

                    Device (P_D0)
                    {
                        Name (_ADR, Zero)
                        Method (_RMV, 0, NotSerialized)
                        {
                            Return (XOr (SATD, One))
                        }

                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (PIB0, Buffer (0x0E)
                            {
                                0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF, 0x03,
                                0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                            })
                            CreateByteField (PIB0, One, PMD0)
                            CreateByteField (PIB0, 0x08, DMD0)
                            If (And (PRIT, 0x02))
                            {
                                If (LEqual (And (PRIT, 0x09), 0x08))
                                {
                                    Store (0x08, PMD0)
                                }
                                Else
                                {
                                    Store (0x0A, PMD0)
                                    ShiftRight (And (PRIT, 0x0300), 0x08, Local0)
                                    ShiftRight (And (PRIT, 0x3000), 0x0C, Local1)
                                    Add (Local0, Local1, Local2)
                                    If (LEqual (0x03, Local2))
                                    {
                                        Store (0x0B, PMD0)
                                    }

                                    If (LEqual (0x05, Local2))
                                    {
                                        Store (0x0C, PMD0)
                                    }
                                }
                            }
                            Else
                            {
                                Store (One, PMD0)
                            }

                            If (And (SYNC, One))
                            {
                                Store (Or (SDT0, 0x40), DMD0)
                                If (And (ICR1, One))
                                {
                                    If (And (ICR0, One))
                                    {
                                        Add (DMD0, 0x02, DMD0)
                                    }

                                    If (And (ICR3, One))
                                    {
                                        Store (0x45, DMD0)
                                    }
                                }
                            }
                            Else
                            {
                                Or (Subtract (And (PMD0, 0x07), 0x02), 0x20, DMD0)
                            }

                            Return (PIB0)
                        }
                    }

                    Device (P_D1)
                    {
                        Name (_ADR, One)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Name (PIB1, Buffer (0x0E)
                            {
                                0x03, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF, 0x03,
                                0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF
                            })
                            CreateByteField (PIB1, One, PMD1)
                            CreateByteField (PIB1, 0x08, DMD1)
                            If (And (PRIT, 0x20))
                            {
                                If (LEqual (And (PRIT, 0x90), 0x80))
                                {
                                    Store (0x08, PMD1)
                                }
                                Else
                                {
                                    Add (And (PSIT, 0x03), ShiftRight (And (PSIT, 0x0C), 0x02), Local0)
                                    If (LEqual (0x05, Local0))
                                    {
                                        Store (0x0C, PMD1)
                                    }
                                    Else
                                    {
                                        If (LEqual (0x03, Local0))
                                        {
                                            Store (0x0B, PMD1)
                                        }
                                        Else
                                        {
                                            Store (0x0A, PMD1)
                                        }
                                    }
                                }
                            }
                            Else
                            {
                                Store (One, PMD1)
                            }

                            If (And (SYNC, 0x02))
                            {
                                Store (Or (SDT1, 0x40), DMD1)
                                If (And (ICR1, 0x02))
                                {
                                    If (And (ICR0, 0x02))
                                    {
                                        Add (DMD1, 0x02, DMD1)
                                    }

                                    If (And (ICR3, 0x02))
                                    {
                                        Store (0x45, DMD1)
                                    }
                                }
                            }
                            Else
                            {
                                Or (Subtract (And (PMD1, 0x07), 0x02), 0x20, DMD1)
                            }

                            Return (PIB1)
                        }
                    }
                }
            }

            Device (SATA)
            {
                Name (_ADR, 0x001F0002)
                OperationRegion (SACS, PCI_Config, 0x40, 0xC0)
                Field (SACS, DWordAcc, NoLock, Preserve)
                {
                    PRIT,   16,
                    SECT,   16,
                    PSIT,   4,
                    SSIT,   4,
                    Offset (0x08),
                    SYNC,   4,
                    Offset (0x0A),
                    SDT0,   2,
                        ,   2,
                    SDT1,   2,
                    Offset (0x0B),
                    SDT2,   2,
                        ,   2,
                    SDT3,   2,
                    Offset (0x14),
                    ICR0,   4,
                    ICR1,   4,
                    ICR2,   4,
                    ICR3,   4,
                    ICR4,   4,
                    ICR5,   4,
                    Offset (0x50),
                    MAPV,   2
                }
            }

            Device (SBUS)
            {
                Name (_ADR, 0x001F0003)
                OperationRegion (SMBP, PCI_Config, 0x40, 0xC0)
                Field (SMBP, DWordAcc, NoLock, Preserve)
                {
                        ,   2,
                    I2CE,   1
                }

                OperationRegion (SMBI, SystemIO, 0x18E0, 0x10)
                Field (SMBI, ByteAcc, NoLock, Preserve)
                {
                    HSTS,   8,
                    Offset (0x02),
                    HCON,   8,
                    HCOM,   8,
                    TXSA,   8,
                    DAT0,   8,
                    DAT1,   8,
                    HBDR,   8,
                    PECR,   8,
                    RXSA,   8,
                    SDAT,   16
                }

                Method (SSXB, 2, Serialized)
                {
                    If (STRT ())
                    {
                        Return (Zero)
                    }

                    Store (Zero, I2CE)
                    Store (0xBF, HSTS)
                    Store (Arg0, TXSA)
                    Store (Arg1, HCOM)
                    Store (0x48, HCON)
                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS)
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (SRXB, 1, Serialized)
                {
                    If (STRT ())
                    {
                        Return (0xFFFF)
                    }

                    Store (Zero, I2CE)
                    Store (0xBF, HSTS)
                    Store (Or (Arg0, One), TXSA)
                    Store (0x44, HCON)
                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS)
                        Return (DAT0)
                    }

                    Return (0xFFFF)
                }

                Method (SWRB, 3, Serialized)
                {
                    If (STRT ())
                    {
                        Return (Zero)
                    }

                    Store (Zero, I2CE)
                    Store (0xBF, HSTS)
                    Store (Arg0, TXSA)
                    Store (Arg1, HCOM)
                    Store (Arg2, DAT0)
                    Store (0x48, HCON)
                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS)
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (SRDB, 2, Serialized)
                {
                    If (STRT ())
                    {
                        Return (0xFFFF)
                    }

                    Store (Zero, I2CE)
                    Store (0xBF, HSTS)
                    Store (Or (Arg0, One), TXSA)
                    Store (Arg1, HCOM)
                    Store (0x48, HCON)
                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS)
                        Return (DAT0)
                    }

                    Return (0xFFFF)
                }

                Method (SBLW, 4, Serialized)
                {
                    If (STRT ())
                    {
                        Return (Zero)
                    }

                    Store (Arg3, I2CE)
                    Store (0xBF, HSTS)
                    Store (Arg0, TXSA)
                    Store (Arg1, HCOM)
                    Store (SizeOf (Arg2), DAT0)
                    Store (Zero, Local1)
                    Store (DerefOf (Index (Arg2, Zero)), HBDR)
                    Store (0x54, HCON)
                    While (LGreater (SizeOf (Arg2), Local1))
                    {
                        Store (0x0FA0, Local0)
                        While (LAnd (LNot (And (HSTS, 0x80)), Local0))
                        {
                            Decrement (Local0)
                            Stall (0x32)
                        }

                        If (LNot (Local0))
                        {
                            KILL ()
                            Return (Zero)
                        }

                        Store (0x80, HSTS)
                        Increment (Local1)
                        If (LGreater (SizeOf (Arg2), Local1))
                        {
                            Store (DerefOf (Index (Arg2, Local1)), HBDR)
                        }
                    }

                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS)
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (SBLR, 3, Serialized)
                {
                    Name (TBUF, Buffer (0x0100) {})
                    If (STRT ())
                    {
                        Return (Zero)
                    }

                    Store (Arg2, I2CE)
                    Store (0xBF, HSTS)
                    Store (Or (Arg0, One), TXSA)
                    Store (Arg1, HCOM)
                    Store (0x54, HCON)
                    Store (0x0FA0, Local0)
                    While (LAnd (LNot (And (HSTS, 0x80)), Local0))
                    {
                        Decrement (Local0)
                        Stall (0x32)
                    }

                    If (LNot (Local0))
                    {
                        KILL ()
                        Return (Zero)
                    }

                    Store (DAT0, Index (TBUF, Zero))
                    Store (0x80, HSTS)
                    Store (One, Local1)
                    While (LLess (Local1, DerefOf (Index (TBUF, Zero))))
                    {
                        Store (0x0FA0, Local0)
                        While (LAnd (LNot (And (HSTS, 0x80)), Local0))
                        {
                            Decrement (Local0)
                            Stall (0x32)
                        }

                        If (LNot (Local0))
                        {
                            KILL ()
                            Return (Zero)
                        }

                        Store (HBDR, Index (TBUF, Local1))
                        Store (0x80, HSTS)
                        Increment (Local1)
                    }

                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS)
                        Return (TBUF)
                    }

                    Return (Zero)
                }

                Method (STRT, 0, Serialized)
                {
                    Store (0xC8, Local0)
                    While (Local0)
                    {
                        If (And (HSTS, 0x40))
                        {
                            Decrement (Local0)
                            Sleep (One)
                            If (LEqual (Local0, Zero))
                            {
                                Return (One)
                            }
                        }
                        Else
                        {
                            Store (Zero, Local0)
                        }
                    }

                    Store (0x0FA0, Local0)
                    While (Local0)
                    {
                        If (And (HSTS, One))
                        {
                            Decrement (Local0)
                            Stall (0x32)
                            If (LEqual (Local0, Zero))
                            {
                                KILL ()
                            }
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Return (One)
                }

                Method (COMP, 0, Serialized)
                {
                    Store (0x0FA0, Local0)
                    While (Local0)
                    {
                        If (And (HSTS, 0x02))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Decrement (Local0)
                            Stall (0x32)
                            If (LEqual (Local0, Zero))
                            {
                                KILL ()
                            }
                        }
                    }

                    Return (Zero)
                }

                Method (KILL, 0, Serialized)
                {
                    Or (HCON, 0x02, HCON)
                    Or (HSTS, 0xFF, HSTS)
                }
            }
        }
    }
}
