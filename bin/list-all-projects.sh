#!/bin/sh
#
# Find every score project by looking for its Makefile, and noting the
# directory in which it is found.
#
# Without arguments, print a list formatted as "Genre: Dirname"
# With "dirs" as argument, print full paths to the project directories
# for use by other scripts for visiting all projects.
#

# Establish the repository base directory
SCORE_ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)/src

if [ "$1" == "dirs" ]; then
    for f in `find ${SCORE_ROOT}/[A-Z]* -name Makefile | sort`; do
        echo `dirname $f`
    done
else
    for f in `find ${SCORE_ROOT}/[A-Z]* -name Makefile | sort`; do
        echo `dirname $f` \
            | sed "s!$SCORE_ROOT!!" \
            | awk -F "/" '{printf "%s:\t%s\n", $2, $3}'
    done
fi
