\version "2.24.2"

\include "../include/site-parameters.ily"
\include "../include/baroque-paper.ily"
\include "../include/midi.ily"

%#(set-global-staff-size 20.0)

% Global settings should be applied to every staff.
staffGlobalSettings = {
  %\override Score.BarNumber.font-size = #0
  \numericTimeSignature
  \compressEmptyMeasures
}

% Staff A settings should be applied to every treble staff.
staffASettings = {
  %\set Staff.instrumentName = #"Flute"
  \clef treble
}

% Staff B settings should be applied to every bass staff.
staffBSettings = {
  %\set Staff.instrumentName = #"Cello"
  \clef bass
}

% Text to be inserted in title pages, headers, and footers.
\header {
  \include "../distribution-header.ily"
}

% Include all the music files
\include "../content/piece_001.ily"

\book {

  \score {
    \new Staff {
      \staffGlobalSettings
      \staffASettings
      \pieceIPartI
    }
    \header {
      piece = \pieceIPiece
      opus = \markup { \italic { \pieceIOpus }}
    }
    \include "../include/layout.ily"
    \insertMidi \pieceIMidiTempo
  }
}
