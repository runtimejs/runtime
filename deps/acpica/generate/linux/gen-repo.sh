#!/bin/bash
#
# NAME:
#         gen-repo.sh - extract linuxized sources from the ACPICA git
#                       repository
#
# SYNOPSIS:
#         gen-repo.sh [-c] <commit>
#
# DESCRIPTION:
#         Extract linuxized repository from the git repository.
#         Options:
#          -c       Force regeneration of acpisrc.
#	  NOTE: Be careful using this script on a repo in detached HEAD mode.
#

usage() {
	echo "Usage: `basename $0` [-c] <commit>"
	echo "Where:"
	echo "     -c: Force regeneration of acpisrc."
	echo " commit: GIT commit (default to HEAD)."
	exit 1
}

INDEX=0

while getopts "c" opt
do
	case $opt in
	c) FORCE_ACPISRC=force;;
	?) echo "Invalid argument $opt"
	   usage;;
	esac
done
shift $(($OPTIND - 1))

version=`git log -1 -c $1 --format=%H | cut -c1-8`

SCRIPT=`(cd \`dirname $0\`; pwd)`
. $SCRIPT/libacpica.sh

GR_acpica_repo=$CURDIR/acpica-$version
GR_linux_repo=$CURDIR/linux-$version

linuxize()
{
	local repo_acpica repo_linux

	# Be careful with local variable namings
	repo_acpica=$1
	repo_linux=$2

	mkdir -p $repo_linux/source
	cp -rf $repo_acpica/source $repo_linux/

	echo "[gen-repo.sh]  Converting hierarchy..."
	linuxize_hierarchy_noref $repo_linux

	echo "[gen-repo.sh]  Converting format..."
	linuxize_format $repo_linux
}

echo "[gen-repo.sh] Extracting GIT ($SRCDIR)..."
# Cleanup
rm -rf $GR_acpica_repo
git clone $SRCDIR $GR_acpica_repo > /dev/null || exit 2

echo "[gen-repo.sh] Creating ACPICA repository (acpica-$version)..."
(
	cd $GR_acpica_repo
	git reset $version --hard >/dev/null 2>&1
)

echo "[gen-repo.sh] Generating tool (acpisrc)..."
make_acpisrc $GR_acpica_repo $FORCE_ACPISRC > /dev/null

# Cleanup
rm -rf $GR_linux_repo

echo "[gen-repo.sh] Creating Linux repository (linux-$version)..."
linuxize $GR_acpica_repo $GR_linux_repo
