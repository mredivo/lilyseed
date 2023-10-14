\version "2.24.2"

% Lilypond default paper size is a4; override it globally here.
%#(set-default-paper-size "letter")

%
% Make the current date available for printing.
%
fullDate = #(strftime "%Y-%m-%d" (localtime (current-time)))
dateYear = #(strftime "%Y" (localtime (current-time)))

\header {

  % Set up the copyright statement (prints at bottom of first page).
  %{
  copyright = \markup {
    \teeny
    \concat {
      "&copyright; " \dateYear " CC BY-NC 4.0 Your Name  <your.name@yourdomain.com>"
    }
  }
  %}

  % Set up the tagline (prints at bottom of last page).
  %{
  tagline = \markup {
    \teeny {
      Lilypond #(lilypond-version) engraving by Your Name <your.name@yourdomain.com>
    }
  }
  %}

  % Or, disable the tagline.
  %tagline = #'f
}
