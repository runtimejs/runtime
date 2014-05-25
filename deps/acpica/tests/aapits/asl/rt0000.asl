DefinitionBlock(
	"rt0000.aml", // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * DSDT table of Resource managment interfaces test #0000
	 */

	Include("../asl/tblm_aux.asl")
	
	Device (DEV0)
	{
		Name (_PRS, ResourceTemplate () {

		IRQ (Level, ActiveLow, Shared) {0}
		IRQNoFlags () {1}
		DMA (Compatibility, NotBusMaster, Transfer16) {2}
		IO (Decode16, 0xf0f1, 0xf2f3, 0xf4, 0xf5)
		FixedIO (0xf0f1, 0xf2)
		VendorShort () {0x00, 0xa2, 0xb3, 0x76, 0xd5, 0xe6, 0xf7}
		Memory24 (ReadWrite, 0xf0f1, 0xf2f3, 0xf4f5, 0xf6f7)
		Memory32 (ReadWrite, 0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff)
		Memory32Fixed (ReadOnly, 0xf0f1f2f3, 0xf4f5f6f7)
		VendorLong () {0x9f,
			0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
			0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
			0x00, 0x01, 0x02, 0x03}
		QWordIO (ResourceConsumer, MinFixed, MaxFixed, SubDecode, EntireRange,
			0xd8d9dadbdcdddedf, 0xe0e1e2e3e4e5e6e7, 0xe8e9eaebecedeeef,
			0xf0f1f2f3f4f5f6f7, 0xf8f9fafbfcfdfeff,
			0xff, "PATHPATHPATH", QIOX, TypeTranslation, SparseTranslation)
		DWordIO (ResourceConsumer, MinFixed, MaxFixed, SubDecode, EntireRange,
			0xecedeeef, 0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff,
			0xff, "PATHPATHPATH", DIOX, TypeTranslation, SparseTranslation)
		WordIO (ResourceConsumer, MinFixed, MaxFixed, SubDecode, EntireRange,
			0xf6f7, 0xf8f9, 0xfafb, 0xfcfd, 0xfeff,
			0xff, "PATHPATHPATH", WIOX, TypeTranslation, SparseTranslation)
		QWordMemory (ResourceConsumer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadOnly,
			0xd8d9dadbdcdddedf, 0xe0e1e2e3e4e5e6e7, 0xe8e9eaebecedeeef,
			0xf0f1f2f3f4f5f6f7, 0xf8f9fafbfcfdfeff,
			0xff, "PATHPATHPATH", QMEX, AddressRangeACPI, TypeTranslation)
		DWordMemory (ResourceConsumer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadOnly,
			0xecedeeef, 0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff,
			0xff, "PATHPATHPATH", DMEX, AddressRangeACPI, TypeTranslation)
		WordBusNumber (ResourceConsumer, MinFixed, MaxFixed, SubDecode,
			0xf6f7, 0xf8f9, 0xfafb, 0xfcfd, 0xfeff,
			0xff, "PATHPATHPATH", WBNX)
		Interrupt (ResourceConsumer, Edge, ActiveLow, Shared,
			0xff,
//			"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*",
			"*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ !\"#$%&'()*",
			INTX) {
			  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
			 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
			 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
			 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
			 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
			 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96,
			 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111,112,
			113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,
			129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,
			145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,
			161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,
			177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,
			193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,
			209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,
			225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,
			241,242,243,244,245,246,247,248,249,250,251,252,253,254,255}
		Register (FFixedHW, 0xf0, 0xf1, 0xf2f3f4f5f6f7f8f9)
		ExtendedIO (ResourceConsumer, MinFixed, MaxFixed, SubDecode, EntireRange,
			0xd0d1d2d3d4d5d6d7, 0xd8d9dadbdcdddedf, 0xe0e1e2e3e4e5e6e7,
			0xe8e9eaebecedeeef, 0xf0f1f2f3f4f5f6f7, 0xf8f9fafbfcfdfeff,
			EIOX, TypeTranslation, SparseTranslation)
		ExtendedMemory (ResourceConsumer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadOnly,
			0xd0d1d2d3d4d5d6d7, 0xd8d9dadbdcdddedf, 0xe0e1e2e3e4e5e6e7,
			0xe8e9eaebecedeeef, 0xf0f1f2f3f4f5f6f7, 0xf8f9fafbfcfdfeff,
			EMEX, AddressRangeACPI, TypeTranslation)
		ExtendedSpace (0xc0, ResourceConsumer, SubDecode, MinFixed, MaxFixed, 0x5a,
			0xd0d1d2d3d4d5d6d7, 0xd8d9dadbdcdddedf, 0xe0e1e2e3e4e5e6e7,
			0xe8e9eaebecedeeef, 0xf0f1f2f3f4f5f6f7, 0xf8f9fafbfcfdfeff,
			ESPX)
		DWordSpace (0xc0, ResourceConsumer, SubDecode, MinFixed, MaxFixed, 0x5a,
			0xecedeeef, 0xf0f1f2f3, 0xf4f5f6f7, 0xf8f9fafb, 0xfcfdfeff,
			0xff, "PATHPATHPATH", DSPX)
		QWordSpace (0xc0, ResourceConsumer, SubDecode, MinFixed, MaxFixed, 0x5a,
			0xd8d9dadbdcdddedf, 0xe0e1e2e3e4e5e6e7, 0xe8e9eaebecedeeef,
			0xf0f1f2f3f4f5f6f7, 0xf8f9fafbfcfdfeff,
			0xff, "PATHPATHPATH", QSPX)
		WordSpace (0xc0, ResourceConsumer, SubDecode, MinFixed, MaxFixed, 0x5a,
			0xf6f7, 0xf8f9, 0xfafb, 0xfcfd, 0xfeff,
			0xff, "PATHPATHPATH", WSPX)
		})

		Method (_CRS)
		{
			Return (^_PRS)
		}

		Name (ECRS, 1)

		Method (_SRS, 1)
		{
			Store (ECRS, Debug)
			CopyObject (Arg0, ECRS)
			Store (Arg0, Debug)
			Store (ECRS, Debug)
		}
		Device (LNKA)
		{
			Name (N000, "LNKA")
		}
		Device (LNKB)
		{
			Name (N000, "LNKB")
		}
		Device (LNKC)
		{
			Name (N000, "LNKC")
		}
		Device (LNKD)
		{
			Name (N000, "LNKD")
		}
/*
 * Extracted from Acpi/source_asl/intel/hawk.asl
 */
            // _PRT - PCI Routing Table
            //
            // PCI interrupts are inherently non
            // -hierarchical. PCI interrupt pins are
            // wired to interrupt inputs of the
            // interrupt controllers. _PRT provides a
            // mapping from PCI interrupt pins to the
            // interrupt inputs of the interrupt
            // controllers. _PRT is required under all
            // PCI root bridges. _PRT evaluates to a
            // package containing an array of
            // packages, each of which describes the
            // mapping of a PCI interrupt pin. Note:
            // The function number in the _PRT
            // packages must be FFFF, that is, any
            // function number. The format of each
            // package is:
            //
            // Entry Type     Description
            // ----------------------------------------
            //
            // 0     Integer  Address of the device
            // 1     Integer  PCI pin number of the
            //                device (0=INTA#,
            //                1=INTB#, 2=INTC#,
            //                3=INTD#)
            // 2     Name     Name of the device which
            //                the pin is connected or
            //                0 if the global pool
            // 3     Integer  Index of the interrupt in
            //                the specified device
            //
            Name(_PRT,Package(0x05){
                Package(0x04){
                        0x001FFFFF,
                        0x00,
                        \DEV0.LNKA,
                        0x00
                    },
                Package(0x04){
                        0x001FFFFF,
                        0x01,
                        \DEV0.LNKB,
                        0x00
                    },
                Package(0x04){
                        0x001FFFFF,
                        0x02,
                        \DEV0.LNKC,
                        0x00
                    },
                Package(0x04){
                        0x001FFFFF,
                        0x03,
                        \DEV0.LNKD,
                        0x00
                    },
                Package(0x04){
                        0x0001FFFF,
                        0x00,
                        \DEV0.LNKA,
                        0x00
                    }
            })
	}

	Method (m000)
	{
		Store("\\DEV0._CRS Resource Template:", Debug)
		Store(\DEV0._CRS, Debug)
	}
}
