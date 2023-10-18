#!/bin/sh
#
# Determine all the differences between the template include files and
# the includes in the src/include/ directory.
#

# First, the details
for i in `ls -1 template/include/`; do
    diff -u template/include/$i src/include/$i
done

# Then, summarize
for i in `ls -1 template/include/`; do
    diff -q template/include/$i src/include/$i
done
