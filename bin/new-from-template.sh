#!/bin/sh
#
# Create a directory structure for a new Lilypond score, and populate it
# with skeleton score files from the template/ directory.
#

# Establish the repository base directory and root directory for scores
REPO_BASE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)
SCORE_ROOT=$REPO_BASE/src

# Perform validation of the input
usage() {
    echo "Usage: `basename $0` era opus\nSelect Era category from:"
    ls -1 $SCORE_ROOT | grep '^[A-Z]' | awk '{printf "    %s\n", $1}'
    exit 1
}

if [ -z "$1" ]; then
    echo "No Era category provided"
    usage
fi

if [ ! -d "$SCORE_ROOT/$1" ]; then
    echo "Era category \"$1\" does not exist"
    usage
fi

if [ -z "$2" ]; then
    echo "No opus name provided"
    usage
fi

if [ -d "$SCORE_ROOT/$1/$2" ]; then
    echo "Opus \"$2\" already exists in Era category $1"
    usage
fi

# Record the path to the project directory
PROJECTDIR="$SCORE_ROOT/$1/$2"
echo "Creating new project for opus $2 in \"$PROJECTDIR\""

# Create the directory structure
for d in book content output; do
    echo "    /$d"
    mkdir -p $PROJECTDIR/$d
done

# Calculate the project depth and symlink the /include directory
DEPTH=..
NXTLVL=$(echo "`dirname $PROJECTDIR`/`basename $PROJECTDIR`")
if [[ ! $NXTLVL == $REPO_BASE ]]; then
    while : ; do
        CURLVL=`basename $NXTLVL`
        NXTLVL=`dirname $NXTLVL`
        [[ $NXTLVL == $REPO_BASE ]] && break
        DEPTH=$DEPTH/..
    done
fi
echo "    /include --> $DEPTH/include"
ln -s $DEPTH/include $PROJECTDIR/include

# Copy in the template files
if [ ! -f "$REPO_BASE/site-parameters.ily" ]; then
    echo "\nCreating new \"/site-parameters.ily\" -- **EDIT TO SUIT YOUR REQUIREMENTS**\n"
    cp $REPO_BASE/template/site-parameters.ily $REPO_BASE
fi

# Copy in the template files
echo "    copying files"
cp $REPO_BASE/template/distribution-header.ily $PROJECTDIR
if [ -d "$REPO_BASE/template/$1" ]; then
    cp $REPO_BASE/template/$1/example.ly $PROJECTDIR/book/${2}-0-score.ly
    cp $REPO_BASE/template/$1/piece_001.ily $PROJECTDIR/content
else
    cp $REPO_BASE/template/example.ly $PROJECTDIR/book/${2}-0-score.ly
    cp $REPO_BASE/template/piece_001.ily $PROJECTDIR/content
fi
# Anchor the Makefile to its depth in the filesystem hierarchy
sed \
    -e "s!XX_DEPTH_XX!$DEPTH!" \
    -e "s!XX_REPO_BASE_XX!$REPO_BASE!" \
    $REPO_BASE/template/Makefile > $PROJECTDIR/Makefile

# Build the example project
cd $PROJECTDIR && make deps midi=1 all

echo "Done."
