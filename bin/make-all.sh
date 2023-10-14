#!/bin/sh

for p in `list-all-projects.sh dirs`; do
    cd $p && make clean deps all
done
