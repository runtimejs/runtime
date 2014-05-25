DefinitionBlock(
	"nmsp0074.aml",   // Output filename
	"DSDT",     // Signature
	0x02,       // DSDT Revision
	"Intel",    // OEMID
	"Many",     // TABLE ID
	0x00000001  // OEM Revision
	) {

	/*
	 * ACPICA API Test Suite
	 * Namespace test 0074
	 */

	Name(n0l0, 0x0000)
	Name(n0l1, 0x0001)
	Name(n0l2, 0x0002)
	Name(n0l3, 0x0003)
	Name(l4, 0x0004)

	Device(d1l0) {
	}
	Device(d1l1) {
		Device(d2l0) {
			Device(d3l0) {
				Device(d4l) {
					Device(d5l0) {
						Device(d6l0) {
							Device(d7l0) {
								Device(d8l0) {
									Device(d9l0) {
									}
								}
							}
						}
					}
				}
			}
		}
	}
	Device(d1l2) {
	}
	Scope (d1l0) {
		Name(n0l0, 0x0100)
		Name(n0l1, 0x0101)
		Name(n0l2, 0x0102)
		Name(n0l3, 0x0103)
		Name(l4, 0x0104)
	}
	Scope (d1l1) {
		Name(n0l0, 0x0110)
		Name(n1l1, 0x0111)
		Name(n0l2, 0x0112)
		Name(n1l3, 0x0113)
		Name(l4, 0x0114)
		Scope (d2l0) {
			Name(n0l0, 0x0120)
			Name(n1l1, 0x0121)
			Name(n0l2, 0x0122)
			Name(n1l3, 0x0123)
			Name(l4, 0x0124)
			Scope (d3l0) {
				Name(n0l0, 0x0130)
				Name(n1l1, 0x0131)
				Name(n0l2, 0x0132)
				Name(n1l3, 0x0133)
				Name(l4, 0x0134)
				Scope (d4l) {
					Name(n0l0, 0x0140)
					Name(n1l1, 0x0141)
					Name(n0l2, 0x0142)
					Name(n1l3, 0x0143)
					Name(l4, 0x0144)
					Scope (d5l0) {
						Name(n0l0, 0x0150)
						Name(n1l1, 0x0151)
						Name(n0l2, 0x0152)
						Name(n1l3, 0x0153)
						Name(l4, 0x0154)
						Scope (d6l0) {
							Name(n0l0, 0x0160)
							Name(n1l1, 0x0161)
							Name(n0l2, 0x0162)
							Name(n1l3, 0x0163)
							Name(l4, 0x0164)
							Scope (d7l0) {
								Name(n0l0, 0x0170)
								Name(n1l1, 0x0171)
								Name(n0l2, 0x0172)
								Name(n1l3, 0x0173)
								Name(l4, 0x0174)
								Scope (d8l0) {
									Name(n0l0, 0x0180)
									Name(n1l1, 0x0181)
									Name(n0l2, 0x0182)
									Name(n1l3, 0x0183)
									Name(l4, 0x0184)
									Scope (d9l0) {
										Name(n0l0, 0x0190)
										Name(n1l1, 0x0191)
										Name(n0l2, 0x0192)
										Name(n1l3, 0x0193)
										Name(l4, 0x0194)
									}
								}
							}
						}
					}
				}
			}
		}
	}
	Scope (d1l2) {
		Name(n0l0, 0x0210)
		Name(n1l1, 0x0211)
		Name(n0l2, 0x0212)
		Name(n2l3, 0x0213)
		Name(l4, 0x0214)
	}

	Method(MAIN)
	{
		Method(m000)
		{
			Name(i000, 0x574)

			Return (i000)
		}

		Store(m000(), Debug)
	}
}
