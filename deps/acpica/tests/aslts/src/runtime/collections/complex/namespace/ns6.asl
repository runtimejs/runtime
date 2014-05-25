// in progress

Name(z160, 160)

Method(m600,, Serialized)
{
	Name(ts, "m600")
	Name(i000, 0xabcd0000)
	Method(m000, 1)
	{
		Store(0x11223344, i000)
		if (LNotEqual(arg0, 0xabcd0000)) {
			err(ts, z160, 0x000, 0, 0, arg0, 0xabcd0000)
		}
	}

	m000(i000)

	if (LNotEqual(i000, 0x11223344)) {
		err(ts, z160, 0x001, 0, 0, i000, 0x11223344)
	}
}

/*
do these

	Method(m003)
	{
		Name(i000, 0x00000001)

		Method(m001, 1)
		{
			Store(0x00000020, i000)
			Return (arg0)
		}
		Store(Add(i000, m001(i000)), Local0)

		if (LNotEqual(Local0, 0x00000002)) {
			Store("Error 2", Debug)
			Store(Local0, Debug)
		} else {
			Store("Ok 2", Debug)
		}

		if (LNotEqual(i000, 0x00000020)) {
			Store("Error 3", Debug)
		} else {
			Store("Ok 3", Debug)
		}
	}
*/

Method(n006)
{
if (1) {
	SRMT("m600")
	m600()
} else {
	SRMT("m600")
	m600()
}
}


