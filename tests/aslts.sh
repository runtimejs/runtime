#!/bin/bash
#
# aslts - execute ASL test suite
#

# Will build temporary versions of iASL and acpiexec
postfix=`date +%H%M%S`
tmp_iasl=/tmp/iasl-$postfix
tmp_acpiexec=/tmp/acpiexec-$postfix

TEST_CASES=
TEST_MODES=
REBUILD_TOOLS=yes

usage() {

	echo "Usage:"
	echo "`basename $0` [-c case] [-m mode] [-u]"
	echo "Where:"
	echo "  -c:	Specify individual test cases (can be used multiple times)"
	echo "  -m:	Specify individual test modes (can be used multiple times)"
	echo "  -u:	Do not force rebuilding of ACPICA utilities (acpiexec, iasl)"
	echo ""

	echo "Available test modes:"
	echo "  n32	32-bit normal mode"
	echo "  n64	64-bit normal mode"
	echo "  s32	32-bit slack mode"
	echo "  s64	64-bit slack mode"
	echo ""

	Do 3
	exit 1
}

# Setup environment and variables.
# Need a path to ASLTS and iasl,acpiexec generation dir
setup_environment() {

	aslts_dir=$1
	generation_dir=$2

	if [ -z "$generation_dir" ] ; then
		echo "missing generation directory argument"
		exit
	elif [ -z "$aslts_dir" ] ; then
		echo "missing aslts directory argument"
		exit
	elif [ ! -d "$generation_dir" ] ; then
		echo $generation_dir is not a dir
		exit
	elif [ ! -d "$aslts_dir" ] ; then
		echo $aslts_dir is not a dir
		exit
	fi

	# Variables required by ASLTS
	unset ASL
	unset acpiexec
	unset ASLTSDIR

	export ASL=$tmp_iasl
	export acpiexec=$tmp_acpiexec		
	export ASLTSDIR=$aslts_dir
	export PATH=$ASLTSDIR/bin:$PATH
}


# Generate both iASL and acpiexec from source
build_acpi_tools() {

	restore_dir=$PWD
	cd ${generation_dir}
	rm -f $tmp_iasl $tmp_acpiexec

	# Build native-width iASL compiler and acpiexec
	if [ ! -e bin/iasl -o ! -e bin/acpiexec ]; then
		REBUILD_TOOLS=yes
	fi
	if [ "x$REBUILD_TOOLS" = "xyes" ]; then
		make clean
		make iasl ASLTS=TRUE
		make acpiexec ASLTS=TRUE
	fi

	if [ -d "bin" ] && [ -f "bin/iasl" ]; then
		echo "Installing ACPICA tools"
		cp bin/iasl $tmp_iasl
		cp bin/acpiexec $tmp_acpiexec
	else
		echo "Could not find iASL/acpiexec tools"
		exit
	fi

	# Ensure that the tools are available
	if [ ! -f $tmp_iasl ] ; then
		echo "iasl compiler not found"
		exit
	elif [ ! -f $tmp_acpiexec ] ; then
		echo "acpiexec utility not found"
		exit
	fi

	cd $restore_dir
}


# Compile and run the ASLTS suite
run_aslts() {

	# Remove a previous version of the AML test code
	version=`$ASL | grep version | awk '{print $5}'`
	rm -rf $ASLTSDIR/tmp/aml/$version

	if [ "x$TEST_CASES" = "x" ]; then
		# Compile all ASL test modules
		Do 0 aslts
	else
		Do 0 $TEST_CASES
	fi

	# Execute the test suite
	echo ""
	echo "ASL Test Suite Started: `date`"
	start_time=$(date)

	if [ "x$TEST_MODES" = "x" ]; then
		TEST_MODES="n32 n64 s32 s64"
	fi
	Do 1 $TEST_MODES $TEST_CASES

	echo ""
	echo "ASL Test Suite Finished: `date`"
	echo "                Started: $start_time"

	rm -f $tmp_iasl $tmp_acpiexec
}

SRCDIR=`(cd \`dirname $0\`; cd ..; pwd)`
setup_environment $SRCDIR/tests/aslts $SRCDIR/generate/unix

# To use common utilities
. $SRCDIR/tests/aslts/bin/common
. $SRCDIR/tests/aslts/bin/settings
RESET_SETTINGS
INIT_ALL_AVAILABLE_CASES
INIT_ALL_AVAILABLE_MODES

while getopts "c:m:u" opt
do
	case $opt in
	c)
		get_collection_opcode "$OPTARG"
		if [ $? -eq $COLLS_NUM ]; then
			echo "Invalid test case: $OPTARG"
			usage
		else
			TEST_CASES="$OPTARG $TEST_CASES"
		fi
	;;
	m)
		check_mode_id "$OPTARG"
		if [ $? -eq 1 ]; then
			echo "Invalid test mode: $OPTARG"
			usage
		else
			TEST_MODES="$OPTARG $TEST_MODES"
		fi
	;;
	u)
		REBUILD_TOOLS=no
	;;
	?)
		echo "Invalid argument: $opt"
		usage
	;;
	esac
done
shift $(($OPTIND - 1))

build_acpi_tools
run_aslts

