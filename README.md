# lilyseed
Command-line tools for creating and building Lilypond music engraving projects

## Background
[Lilypond](https://lilypond.org/doc/v2.24/Documentation/web/index) is free software
from the [GNU Project](https://www.gnu.org/) that produces beautiful sheet music
from plain-text source files.

While very little source text is needed to get started, music of any size requires
a thoughtful organization of file layout and contents, very similar to any
non-trivial software project. As a long-time software developer, this project is
the result of developing what I wished was available to me when I first started
using Lilypond.

I explored a number of different way of organizing my Lilypond projects, cribbing hints
and tips from a number of sources. Things finally fell into place for me when I became
aware of long-time Lilypond user Allen Garvin's
[GitHub Lilypond repository](https://github.com/allengarvin/typeset), and his work inspires
mine.

## Overview
**lilyseed** offers:
- templates of multiple types of scores
- generation of project skeletons from a template
- automated builds using Makefiles
- automated dependency list generation
- automated listing of references to \incude files

## Installation
`git clone ssh://git@github.com/mredivo/lilyseed lilyseed`

You will probably want to add the `bin/` directory to your `$PATH`.

## Setup and Configuration
**lilyseed** expects to find all Lilypond projects in subdirectories of a
directory called `src/` in its own root directory. If it doesn't already exist,
**lilyseed** will create it the first time you run `bin/new-from-template.sh`.

Every immediate subdirectory of `src/` whose name starts with an uppercase letter
is considered a **Category** for the purpose of generating new project skeletons.
If `src/` doesn't exist the first time `bin/new-from-template.sh` is run, it
will also populate it with some categories:
- Piano
- Choir
- Medieval
- Renaissance
- Baroque
- Classical
- Modern

Each of these categories can have its own template files for project skeleton
generation (See: `templates/` directory).

## Creating your first Lilypond project with lilyseed
Run `bin/new-from-template.sh` to create a project `demo-score` in the `Modern` category, which will:
- perform all first-time setup
- create directories and copy template files into them
- build the new Lilypond project, producing
  - a PDF of the score
  - a MIDI file

The command, and its output:
```
lilyseed$ new-from-template.sh Modern demo-score
Creating new project for opus demo-score in "src/Modern/demo-score"
    /book
    /content
    /output
    /include --> ../../include
    copying files
Makefile:73: deps.mk: No such file or directory
bin/generate-dependencies.sh ./book
Generating dependencies for "./book/demo-score-0-score.ly"
Engraving output/demo-score-0-score.pdf
lilypond \
		--output=./output \
		-ddelete-intermediate-files \
		-dno-point-and-click \
		--loglevel=PROGRESS \
		--pdf \
		 -dmidi  \
		book/demo-score-0-score.ly
GNU LilyPond 2.24.2 (running Guile 3.0)
warning: no such internal option: midi
Processing `book/demo-score-0-score.ly'
Success: compilation successfully completed
Done.
```

The following project files are created:
```
src/Modern/demo-score/Makefile
src/Modern/demo-score/book/demo-score-0-score.ly
src/Modern/demo-score/content/piece_001.ily
src/Modern/demo-score/deps.mk
src/Modern/demo-score/distribution-header.ily
src/Modern/demo-score/include
src/Modern/demo-score/output/demo-score-0-score.midi
src/Modern/demo-score/output/demo-score-0-score.pdf
src/Modern/demo-score/referenced-includes.txt
```
The generated PDF: [demo-score-0-score.pdf](https://github.com/mredivo/lilyseed/files/12910466/demo-score-0-score.pdf)

### One-time Customization
Now is the time to do the one-time personalizing of the configuration in
`src/site-parameters.ily`. In here, you can:
- choose your default paper size (US Letter or A4)
- Enter your copyright information (which prints on the first page of your score)
- choose a customized tagline (which prints on the last page of your score)

### Customization for each Project
`distribution-header.ily` contains the title, composer, opus, and other such information
to be printed as heading matter. This should of course be edited for each new project.

## Rebuilding your project
Make some changes to `distribution-header.ily`. To rebuild the project from the command
line, go to the `src/Modern/demo-score` directory, and type `make`:
```
demo-score$ make
Engraving output/demo-score-0-score.pdf
lilypond \
		--output=./output \
		-ddelete-intermediate-files \
		-dno-point-and-click \
		--loglevel=PROGRESS \
		--pdf \
		   \
		book/demo-score-0-score.ly
GNU LilyPond 2.24.2 (running Guile 3.0)
Processing `book/demo-score-0-score.ly'
Success: compilation successfully completed
```
Examine the PDF in `output/`, and see your changes.

## Adding files to your project
If your projects were to consist of only two source files, you wouldn't need
any tools to manage them. So once you add another file to your project and
`\include` it, you will need to ensure Make is aware that the project should be
rebuilt if that file changes. Execute the following:

`make deps`

Now Make will rebuild your project if the new file is changed.

## Cleaning up the demo project
Once you are done with project `demo-score`, it can simply be removed with:

`rm -f src/Modern/demo-score`

This will remove all traces of the project, without any collateral damage.

## Further Reading
In progress.
