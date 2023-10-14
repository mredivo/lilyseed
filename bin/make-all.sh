#!/bin/sh

# Establish the repository base directory and root directory for scores
REPO_BASE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)

for p in `$REPO_BASE/bin/list-all-projects.sh dirs`; do
    echo "Visiting: $p"
    cd $p && make clean deps all
done
