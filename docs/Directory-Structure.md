# Directory Structure
All **lilyseed** files are contained in either the `bin/` directory or the the
`template/` directory and its subdirectories.

## Synopsis
```
bin/
docs/
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

### docs/
- project documentation

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

**lilyseed** will create the following default categories if the `src/` directory
does not exist the first time it is run:
- Piano
- Choir
- Medieval
- Renaissance
- Baroque
- Classical
- Modern

## Project Files
**lilyseed** projects keep all the music for a score in one directory (`content/`), and
all the layout information in another (`book/`). The files in the `book/` directory
use Lilypond `\include` statements to bring in the actual notes for the score from
the files in the `content/` directory. Likewise, common elements are included from
the local `include/` directory (which is a symlink to `src/include/`).

Every file in the `book/` directory whose name ends in `.ly` will be considered
a build target, whereas other endings will not. For example:
```
book/Project-0-score.ly
book/Project-1-bass.ly
book/Project-1-treble.ly
book/Project-2-common-elements.ily
```

When `make` is run, it will build the following:
```
output/Project-0-score.pdf
output/Project-1-bass.pdf
output/Project-1-treble.pdf
```

`Project-2-common-elements.ily` will be included as needed, will trigger builds if
it changes, but will not be processed as a build target.
