# Command Reference
All the **lilyseed** commands are implemented as individual shell scripts.

- [new-from-template.sh](#new-from-templatesh)
- [list-all-projects.sh](#list-all-projectssh)
- [list-all-includerefs.sh](#list-all-includerefssh)
- [make-all.sh](#make-allsh)
- [generate-dependencies.sh](#generate-dependenciessh)

## new-from-template.sh
Synopsis: `new-from-template.sh category opus`

Inputs: Command line arguments; files under `templates/`

Outputs: compilable skeleton project under `src/<category>/<opus>/`

The `category` command-line argument is the name of a directory under `src/`.
If this directory does not exist, the command fails and prints a usage
message, which lists all the valid categories. The `category` argument can
also be a path whose first element is the name of a valid category, if every
element of the path already exists.

The `opus` command-line argument is the name you want to give your new project.

Running this command creates the following files and directories under
`src/category/opus/`:
```
Makefile
book/opus-0-score.ly
content/piece_001.ily
deps.mk
distribution-header.ily
include -> ../../include
output/opus-0-score.midi
output/opus-0-score.pdf
referenced-includes.txt
```

You may now begin creating your score by editing `distribution-header.ily` and
the files in `book/` and `content/`.

Execute `make` in the project directory (containing the `Makefile`) each time you
want to create your PDF output file.

If you add more Lilypond `\include` statements to bring in additional files,
run `make deps` to ensure that your project is rebuilt by Make if those
additional files have been modified.

## list-all-projects.sh
Synopsis: `list-all-projects.sh [dirs]`

Output (to stdout):
- without arguments: a two-column list of projects by category
```
Baroque:	Corrette-Opus5
Baroque:	Handel-Op1No7
Modern:	demo-score
```
- with `dirs` argument: the full path to each directory containing a `makefile`
```
lilyseed$ list-all-projects.sh dirs
/.../lilyseed/src/Baroque/Corrette-Opus5
/.../lilyseed/src/Baroque/Handel-Op1No7
/.../lilyseed/src/Modern/demo-score
```

## list-all-includerefs.sh
Synopsis: `list-all-includerefs.sh`

Output: `src/usage-of-includes.csv`

Generate a CSV file listing every reference to a file in the `src/include/`
directory from any Lilypond source file.

This depends on finding the `referenced-includes.txt` file created by
running `make deps` to update project dependencies.

Sample output:
```
File,Category,Opus
./include/baroque-layout.ily,,
./include/baroque-layout.ily,Baroque,Corrette-Opus5
./include/baroque-layout.ily,Baroque,Handel-Op1No7
./include/baroque-paper.ily,,
./include/baroque-paper.ily,Baroque,Corrette-Opus5
./include/baroque-paper.ily,Baroque,Handel-Op1No7
./include/layout.ily,,
./include/paper.ily,,
<...>
```

## make-all.sh
Synopsis: `make-all.sh`

Output: Build every project in the entire directory structure under `src/`.

This command depends on `list-all-projects.sh` to visit them in turn and
execute `make` in their project directories. It can be useful when upgrading
Lilypond to ensure that all your scores still build successfully.

## generate-dependencies.sh
Synopsis: `generate-dependencies.sh bookdir`

Output: `deps.mk`, `referenced-includes.txt`

For internal use by the Makefiles.
