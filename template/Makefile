# Engrave each of the files in the /books directory.

# DEPTH and REPO_BASE are set by /bin/new-from-template.sh
DEPTH		:= XX_DEPTH_XX	# usually "../../.."
REPO_BASE	:= XX_REPO_BASE_XX

DISTHEADER	:= ./distribution-header.ly
SOURCEDIR	:= ./book
INCLUDEDIR	:= ./include
CONTENTDIR	:= ./content
TARGETDIR	:= ./output

ifdef midi
	MIDI	:= -dmidi
else
	MIDI	:=
endif

SOURCES		:= $(wildcard $(SOURCEDIR)/*.ly)
INCLUDES	:= $(wildcard $(INCLUDEDIR)/*.ly) $(wildcard $(INCLUDEDIR)/*.ily)
CONTENT		:= $(wildcard $(CONTENTDIR)/*.ily)
PDFS		:= $(patsubst $(SOURCEDIR)/%.ly,$(TARGETDIR)/%.pdf,$(wildcard $(SOURCES)))
MIDIS		:= $(patsubst $(SOURCEDIR)/%.ly,$(TARGETDIR)/%.midi,$(wildcard $(SOURCES)))

$(TARGETDIR)/%.pdf: $(SOURCEDIR)/%.ly
	@echo "Engraving $@"
	lilypond \
		--output=$(TARGETDIR) \
		-ddelete-intermediate-files \
		-dno-point-and-click \
		--loglevel=PROGRESS \
		--pdf \
		$(CLEFS) $(MIDI) $(PAPER) \
		$<

$(TARGETDIR)/%.midi: $(SOURCEDIR)/%.ly
	@echo "Producing $@"
	lilypond \
		--output=$(TARGETDIR) \
		-ddelete-intermediate-files \
		-dno-point-and-click \
		--loglevel=PROGRESS \
		--pdf \
		-dmidi $(CLEFS) $(PAPER) \
		$<

.PHONY: all
all: $(PDFS)

.PHONY: midi
midi: $(MIDIS)

.PHONY: deps.mk	# Without this, make won't run if the file deps.mk does not exist.
.PHONY: deps	# Run "make deps" to create the dependency file.
deps:
	$(REPO_BASE)/bin/generate-dependencies.sh $(SOURCEDIR)

.PHONY: clean
clean: cleanpdf cleanmidi

.PHONY: cleanpdf
# Frescobaldi writes its output to the source dir.
cleanpdf:
	rm -f $(TARGETDIR)/*pdf
	rm -f $(SOURCEDIR)/*pdf

.PHONY: cleanmidi
# Frescobaldi writes its output to the source dir.
cleanmidi:
	rm -f $(TARGETDIR)/*midi
	rm -f $(SOURCEDIR)/*midi

include deps.mk
