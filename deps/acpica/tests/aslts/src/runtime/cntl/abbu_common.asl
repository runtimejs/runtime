/*
 * Flag, compiler the test in the abbu layout
 */
Name(ABUU, 1)

/*
 * Internal objects used in this file only
 */
Name (AI03, 1)	// Print out the name of test-case
Name (AI05, 0)	// Print out the name of test
Name (AI06, 1)	// Print out additional parameters of errors

/*
 * Objects from the common.asl used there also
 */
Name(TCLT, 7)	// Identity2MS test case ID
Name(ERRS, 0)	// Errors counter
Name(RMRC, 0)	// Current number of root Methods runs
// Types, as returned by ObjectType
Name(c008, 0)	// Uninitialized
Name(c009, 1)	// Integer
Name(c00a, 2)	// String
Name(c00b, 3)	// Buffer
Name(c00c, 4)	// Package
Name(c00d, 5)	// Field Unit
Name(c00e, 6)	// Device
Name(c00f, 7)	// Event
Name(c010, 8)	// Method
Name(c011, 9)	// Mutex
Name(c012, 10)	// Operation Region
Name(c013, 11)	// Power Resource
Name(c014, 12)	// Processor
Name(c015, 13)	// Thermal Zone
Name(c016, 14)	// Buffer Field
Name(c017, 15)	// DDB Handle
Name(c018, 16)	// Debug Object
Name(c019, 17)	// LOCAL_REGION_FIELD
Name(c01a, 18)	// LOCAL_BANK_FIELD
Name(c01b, 19)	// LOCAL_INDEX_FIELD
Name(c01c, 20)	// LOCAL_REFERENCE
Name(c01d, 21)	// LOCAL_ALIAS
Name(c01e, 22)	// LOCAL_METHOD_ALIAS
Name(c01f, 23)	// LOCAL_NOTIFY
Name(c020, 24)	// LOCAL_ADDRESS_HANDLER
Name(c021, 25)	// LOCAL_RESOURCE
Name(c022, 26)	// LOCAL_RESOURCE_FIELD
Name(c023, 27)	// LOCAL_SCOPE
Name(c024, 28)	// LOCAL_EXTRA
Name(c025, 29)	// LOCAL_DATA
Name(c027, 30)	// Number of different types

/*
 * Methods from common.asl
 */

Method(STRT, 1)
{
	/* Adjust some skippings of tests for different ACPICA rereales */
	SET2(SETN)
}

Method(FNSH)
{

	/* The usual layout of aslts summary lines */

	if (ERRS) {
		OUUP("\":STST:Identity2MS:abbu:mmmm:FAIL:Errors # 12 34 56 78:\"", 1)
	} else {
		OUUP("\":STST:Identity2MS:abbu:mmmm:PASS:\"", 1)
	}

	OUUP(ERRS, 1)

	OUUP("The number of tests has been executed:", 1)
	OUUP(RMRC, 1)

	return (ERRS)
}

Method(STTT, 4)
{
	if (AI03) {
		OUTP(arg0)
	}

	return (1)
}

Method(SRMT, 1)
{
	if (AI05) {
		OUTP(arg0)
	}

	Increment(RMRC)
}


Method(err, 7)
{
	OUTP(arg0)
	if (AI06) {
		OUTP(arg2)
		OUTP(arg5)
	}

	Increment(ERRS)
}

Method(FTTT) {}
Method(BLCK) {}


/*
 * Methods from ehandle.asl
 */
Method(CH02)	{ return (0) }
Method(CH03, 5)	{ return (0) }
Method(CH04, 7)	{ return (0) }

