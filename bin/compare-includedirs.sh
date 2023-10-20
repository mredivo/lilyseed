#!/bin/sh
#
# Determine all the differences between the template include files and
# the includes in the src/include/ directory.
#

# Establish the repository base directory and root directory for scores
REPO_BASE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)
SCORE_ROOT=$REPO_BASE/src
DIR_A="$REPO_BASE/template/include"
DIR_B="$SCORE_ROOT/include"

echo "Comparing:\n\t $DIR_A\n\t $DIR_B"

# First, the details
for i in `ls -1 $DIR_A/`; do
    diff -u $DIR_A/$i $DIR_B/$i
done

# Then, summarize
for i in `ls -1 $DIR_A/`; do
    diff -q $DIR_A/$i $DIR_B/$i
done
