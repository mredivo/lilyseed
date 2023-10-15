# Directory Structure
All **lilyseed** files are contained in either the `bin/` directory or the the
`template/` directory and its subdirectories.

## Synopsis
```
bin/
template/
template/Category1/
template/Category2/
src/
src/Category1/
src/Category2/
src/Category3/
src/include/

# Per project:
src/Category/Project/
src/Category/Project/Makefile
src/Category/Project/book/
src/Category/Project/book/Project-0-score.ly
src/Category/Project/content/
src/Category/Project/content/piece_001.ily
src/Category/Project/deps.mk
src/Category/Project/include/ -> ../../include/
src/Category/Project/output/
src/Category/Project/referenced-includes.txt
```

## Directory Contents

### bin/
- all the shell scripts provided with **lilyseed**, described elsewhere.

### template/
- a Makefile template
- an `include/` directory containing a base set of .ily include files
- generic score file templates
- category-specific music templates in subdirectories named by category

### src/
All user files are contained in the `src/` directory, which does not exist in this
repository. It is created either:
- during the first running of `bin/new-from-template.sh`
- by the user

### src/include/
The `src/` directory must contain a directory named `include/`. This directory will
contain all files that are shared in common by all scores. (For example, `src/include/paper.ily`,
`src/include/layout.ily`.)

### src/[A-Z]...
Any directory in `src/` whose name starts with a capital letter defines a Category
in **lilyseed**. All music score projects will be located in these directories, or
their subdirectories.

## Project Files
*in progress*
