#!/bin/sh
#
# Generate a CSV file listing every reference to a file in the /include
# directory from any Lilypond source file.
#
# This depends on finding the "referenced-includes.txt" file created by
# running "make deps" to update project dependencies.

# Establish the repository base directory and root directory for scores
REPO_BASE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)
SCORE_ROOT=$REPO_BASE/src

# The name of the CSV file where the results should be written
XREFFILE=${SCORE_ROOT}/usage-of-includes.csv

# Create a temporary file to accumulate references from each project
tmpbasename=`basename $0`
TMPFILE=`mktemp -q -t ${tmpbasename}`
if [ $? -ne 0 ]; then
    echo "$0: Can't create temp file, exiting..."
    exit 1
fi

# Walk the repository, concatenating all the files found
for f in `find ${SCORE_ROOT}/[A-Z]* -name referenced-includes.txt | sort`; do
    for i in `cat $f`; do
        proj=$(echo `dirname $f` \
            | sed "s!$SCORE_ROOT!!" \
            | awk -F "/" '{printf "%s,%s\n", $2, $3}')
        echo "$i,$proj" >> $TMPFILE
    done
done

# Also insert a line for each include file, to identify unreferenced files
for f in `find ${SCORE_ROOT}/include -type f -name '*ly'`; do
    echo "$f,," | sed "s!$SCORE_ROOT!.!" >> $TMPFILE
done

# Put the CSV headers into the output file, followed by sorted unique list
echo "File,Category,Opus" > $XREFFILE
sort -u $TMPFILE >> $XREFFILE
rm $TMPFILE
