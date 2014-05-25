#!/bin/bash
#
# NAME:
#         gen-patch.sh - extract linuxized patches from the ACPICA git
#                        repository
#
# SYNOPSIS:
#         gen-patch.sh [-f from] [-i index] [-s sign] <commit>
#
# DESCRIPTION:
#         Extract linuxized patches from the git repository.
#         Options:
#          -f from  Specify name <email> for From field.
#          -i index Specify patch index.
#          -s sign  Specify name <email> for Signed-off-by field.
#

usage() {
	echo "Usage: `basename $0` [-f from] [-i index] [-s sign] <commit>"
	echo "Where:"
	echo "     -f: Specify name <email> for From field (default to author)."
	echo "     -i: Specify patch index (default to 0)."
	echo "     -s: Specify name <email> for Signed-off-by field."
	echo " commit: GIT commit (default to HEAD)."
	exit 1
}

FROM_EMAIL="%aN <%aE>"
INDEX=0

while getopts "f:i:s:" opt
do
	case $opt in
	s) SIGNED_OFF_BY=$OPTARG;;
	f) FROM_EMAIL=$OPTARG;;
	i) INDEX=$OPTARG;;
	?) echo "Invalid argument $opt"
	   usage;;
	esac
done
shift $(($OPTIND - 1))

after=`git log -1 -c $1 --format=%H | cut -c1-8`
before=`git log -1 -c $1^1 --format=%H | cut -c1-8`

SCRIPT=`(cd \`dirname $0\`; pwd)`
. $SCRIPT/libacpica.sh

GP_acpica_repo=$CURDIR/acpica.repo
GP_linux_before=$CURDIR/linux.before
GP_linux_after=$CURDIR/linux.after
GP_acpica_patch=$CURDIR/acpica-$after.patch
GP_linux_patch=$CURDIR/linux-$after.patch

FORMAT="From %H Mon Sep 17 00:00:00 2001%nFrom: $FROM_EMAIL%nData: %aD%nSubject: [PATCH $INDEX] ACPICA: %s%n%n%b"

echo "[gen-patch.sh] Extracting GIT ($SRCDIR)..."
# Cleanup
rm -rf $GP_linux_before
rm -rf $GP_linux_after
rm -rf $GP_acpica_repo
git clone $SRCDIR $GP_acpica_repo > /dev/null || exit 2

echo "[gen-patch.sh] Creating ACPICA repository ($after)..."
(
	cd $GP_acpica_repo
	git reset $after --hard >/dev/null 2>&1
)

echo "[gen-patch.sh] Creating ACPICA patch (acpica-$after.patch)..."
(
	cd $GP_acpica_repo
	git format-patch -1 --stdout >> $GP_acpica_patch
)

echo "[gen-patch.sh] Creating Linux repository ($after)..."
(
	cd $GP_acpica_repo/generate/linux
	if [ ! -f ./gen-repo.sh ]; then
		cp $SRCDIR/generate/linux/gen-repo.sh ./
	fi
	./gen-repo.sh -c $after
)
mv -f $GP_acpica_repo/generate/linux/linux-$after $GP_linux_after

echo "[gen-patch.sh] Creating ACPICA repository ($before)..."
(
	cd $GP_acpica_repo
	git reset $before --hard >/dev/null 2>&1
)

echo "[gen-patch.sh] Creating Linux repository ($before)..."
(
	cd $GP_acpica_repo/generate/linux
	if [ ! -f ./gen-repo.sh ]; then
		cp $SRCDIR/generate/linux/gen-repo.sh ./
	fi
	./gen-repo.sh -c $before
)
mv -f $GP_acpica_repo/generate/linux/linux-$before $GP_linux_before

(
	echo "[gen-patch.sh] Creating Linux patch (linux-$after.patch)..."
	cd $CURDIR
	tmpfile=`tempfile`
	diff -Nurp linux.before linux.after >> $tmpfile

	if [ $? -ne 0 ]; then
		GIT_LOG_FORMAT=`echo $FORMAT`
		eval "git log -c $after -1 --format=\"$GIT_LOG_FORMAT\" > $GP_linux_patch"
		if [ "x$SIGNED_OFF_BY" != "x" ]; then
			echo "" >> $GP_linux_patch
			echo "Signed-off-by: $SIGNED_OFF_BY" >> $GP_linux_patch
		fi
		$ACPISRC -ldqy $GP_linux_patch $GP_linux_patch > /dev/null
		echo "---" >> $GP_linux_patch
		diffstat $tmpfile >> $GP_linux_patch
		echo >> $GP_linux_patch
		cat $tmpfile >> $GP_linux_patch
	else
		echo "Warning: Linux version is empty, skipping $after..."
	fi
	rm -f $tmpfile
)

# Cleanup temporary directories
rm -rf $GP_linux_before
rm -rf $GP_linux_after
rm -rf $GP_acpica_repo
