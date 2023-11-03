\version "2.24.2"

% Bring in various local shortcuts and helpers.
\include "./include/sysutil.ily"

% Lilypond default paper size is a4; override it globally here.
%#(set-default-paper-size "letter")

% Author information for footers
author = "Your Name <your.name@yourdomain.com>"

\header {

  % Define a custom header field containing the input source filename
  #(define sourceFile (ly:get-subpath input-file-name "Lilypond_Root"))
  inputFilename = \markup { \teeny \sourceFile }

  % Set up the copyright statement (prints at bottom of first page).
  copyright = \markup {
    \teeny
    \concat {
      "&copyright; " \now-YY " CC BY-NC 4.0 " \author
    }
  }

  % Set up the tagline (prints at bottom of last page).
  tagline = \markup {
    \teeny {
      Lilypond #(lilypond-version) engraving by
      \author on \now-YMD-HMS
    }
  }

  % Or, disable the tagline.
  %tagline = #'f
}
