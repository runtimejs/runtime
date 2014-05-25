DefinitionBlock(
	"nmsp0126.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0126
	 * BZ 7689 AE_AML_BUFFER_LIMIT reprodusing
	 */

    Scope (\_SB)
    {
        Device (C002)
        {
            Name (_HID, EisaId ("PNP0A08"))
            Name (_CID, 0x030AD041)
            Name (_ADR, 0x00)
		}
        Name (C241, 0x00)
        Name (C242, Buffer (0x07)
        {
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        })
	}

	// From nx7400 SSDT1
    Scope (\_SB.C002)
    {
        Device (C341)
        {
            Name (_ADR, 0x001F0002)
            Device (C0F3)
            {
                Name (_ADR, 0xFFFF)
                Method (_SDD, 1, NotSerialized)
                {
                    If (And (DerefOf (Index (Arg0, 0x0100)), 0x02))
                    {
                        Store (0x01, C241)
                    }

                    Name (C342, Buffer (0x07)
                    {
                        0x00, 0x00, 0x00, 0x00, 0x00, 0xA0, 0x00
                    })
                    CreateByteField (C342, 0x00, C343)
                    CreateByteField (C342, 0x01, C344)
                    CreateByteField (C342, 0x02, C345)
                    CreateByteField (C342, 0x03, C346)
                    CreateByteField (C342, 0x04, C347)
                    CreateByteField (C342, 0x05, C348)
                    CreateByteField (C342, 0x06, C349)
                    If (LEqual (SizeOf (Arg0), 0x0200))
                    {
                        CreateWordField (Arg0, 0x9C, C34A)
                        If (And (C34A, 0x08))
                        {
                            Store (0x10, C343)
                            Store (0x03, C344)
                            Store (0xEF, C349)
                        }
                        Else
                        {
                            Store (0x90, C343)
                            Store (0x03, C344)
                            Store (0xEF, C349)
                        }
                    }

                    Store (C342, C242)
                }

                Method (_GTF, 0, NotSerialized)
                {
                    Return (C242)
                }
            }
        }
    }
}
