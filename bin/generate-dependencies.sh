#!/bin/sh
#
# Generate a dependency list for each .ly file in the /books directory.
#

# The name of the include file; must sync with Makefile.
DEPSFILE=./deps.mk

# The name of the file that lists all /include references in this project.
INCLUDELIST=./referenced-includes.txt
TMPFILE=${INCLUDELIST}.tmp

# Confirm we have a directory name from the command line, and confirm it exists.
if [ -z "$1" ]; then
    echo "No directory specified"
    exit 1
fi
if [ ! -d "$1" ]; then
    echo "Directory \"$1\" does not exist"
    exit 1
fi

# Write the header comment.
echo "# Auto-generated dependencies - DO NOT EDIT. Re-create with \"make deps\".\n" > $DEPSFILE

# Ensure the scratch file is empty.
rm -f $TMPFILE

# Iterate over the *.ly files in the target directory.
for srcbook in $1/*\.ly; do

    echo "Generating dependencies for \"$srcbook\""

    # Build the full names of the target PDF and MIDI output files.
    PDFTARGET=$(echo "\$(TARGETDIR)/`basename $srcbook .ly`.pdf")
    MIDITARGET=$(echo "\$(TARGETDIR)/`basename $srcbook .ly`.midi")

    # Collect any dependencies not in the /book, /include or /content directories.
    # Note: "egrep -v '^\s*%'" strips commented-out "\include" statements.
    DISTHEADER=`egrep -v '^\s*%' $srcbook | grep '\\\\include' | \
        egrep -v -e '/book/' -e '/include/' -e '/content/' -e '[^.]\./[A-Za-z]' | \
        awk -F '"' '{print $2}' | \
        sort -u | \
        sed 's/\.\././'`

    # Collect the dependencies in the /content directory.
    CONTENTS=`egrep -v '^\s*%' $srcbook | grep '\\\\include' | \
        grep '/content/' | \
        awk -F '"' '{print $2}' | \
        sort -u | \
        sed 's/\.\././'`

    # Collect the dependencies in the /include directory.
    INCLUDES=`egrep -v '^\s*%' $srcbook | grep '\\\\include' | \
        grep '/include/' | \
        awk -F '"' '{print $2}' | \
        sort -u | \
        sed 's/\.\././'`

    # Collect dependencies in the /book directory, and recursively examine those.
    BOOKS=`egrep -v '^\s*%' $srcbook | grep '\\\\include' | \
        egrep '[^.]\./[A-Za-z]' | \
        awk -F '"' '{print $2}' | \
        sort -u | \
        sed 's!\./!./book/!'`

    for srcsubbook in $BOOKS; do

        # Collect any dependencies not in the /book, /include or /content directories.
        DISTHEADER="$DISTHEADER `egrep -v '^\s*%' $srcsubbook | grep '\\\\include' | \
            grep -v -e '/book/' -e '/include/' -e '/content/' | \
            awk -F '"' '{print $2}' | \
            sort -u | \
            sed 's!^\./!./book/!' |
            sed 's/^\.\././'`"

        # Collect the dependencies in the /include directory.
        INCLUDES="$INCLUDES `egrep -v '^\s*%' $srcsubbook | grep '\\\\include' | \
            grep '/include/' | \
            awk -F '"' '{print $2}' | \
            sort -u | \
            sed 's/\.\././'`"

        # Collect the dependencies in the /content directory.
        CONTENTS="$CONTENTS `egrep -v '^\s*%' $srcsubbook | grep '\\\\include' | \
            grep '/content/' | \
            awk -F '"' '{print $2}' | \
            sort -u | \
            sed 's/\.\././'`"

    done

    # Recursively examine the files in the /content directory..
    for srcinclude in $CONTENTS; do

        # Collect the dependencies in the /include directory.
        INCLUDES="$INCLUDES `egrep -v '^\s*%' $srcinclude | grep '\\\\include' | \
            grep '/include/' | \
            awk -F '"' '{print $2}' | \
            sort -u | \
            sed 's/\.\././'`"

    done

    # Assemble the full dependency lists for the PDF and MIDI targets.
    PDFDEP=`echo "$PDFTARGET: $srcbook $BOOKS $DISTHEADER $CONTENTS $INCLUDES"`
    MIDIDEP=`echo "$MIDITARGET: $srcbook $BOOKS $DISTHEADER $CONTENTS $INCLUDES"`

    # Keep a record of every /include reference.
    for i in $INCLUDES; do
        echo $i >> $TMPFILE
    done

    # Write the dependency file.
    echo $PDFDEP    >> $DEPSFILE
    echo            >> $DEPSFILE
    echo $MIDIDEP   >> $DEPSFILE
    echo            >> $DEPSFILE

done

# Sort list of includes and remove duplicates.
sort -u $TMPFILE > $INCLUDELIST
rm -f $TMPFILE
