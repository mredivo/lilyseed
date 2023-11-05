#!/bin/sh

BUNDLE=`echo $(basename $(pwd))`
BUNDLEDIR=bundle/$BUNDLE
ARCHIVE=${BUNDLE}-lilypond-src

# Ensure this program is being run in a project root directory.
if [ ! -f Makefile ] || [ ! -f titles.ily ] ; then
    echo "Cannot make distribution bundle in this directory, exiting"
    exit 1
fi

echo "Creating Lilypond source bundle in $BUNDLEDIR"

# Clean up from any prior run.
rm -r bundle/

# Create the directory structure, and copy in the source files.
mkdir -p $BUNDLEDIR/book $BUNDLEDIR/content $BUNDLEDIR/include
for f in `cat deps.mk \
    | grep pdf \
    | grep -v work-in-progress \
    | awk -F : '{print $2}'`; do
        cp $f $BUNDLEDIR/$f
done

# Create an archive of the bundle BEFORE attempting a compile.
`cd bundle && tar zcf ${ARCHIVE}.tgz $BUNDLE`
`cd bundle && zip -r ${ARCHIVE}.zip $BUNDLE > /dev/null`

# Make certain that the Lilypond project(s) can successfully build.
for s in $BUNDLEDIR/book/*.ly; do
    lilypond --output=bundle $s
done

# Remove the bundle directory, but keep the archive and build output.
rm -r ${BUNDLEDIR}

# Display the contents of the archive.
tar ztf bundle/${ARCHIVE}.tgz | sort
unzip -l bundle/${ARCHIVE}.zip
