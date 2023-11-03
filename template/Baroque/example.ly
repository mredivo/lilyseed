\version "2.24.2"

\include "../include/site-parameters.ily"
\include "../include/baroque-paper.ily"
\include "../include/midi.ily"

#(set-global-staff-size 20.0)

% Global settings should be applied to every staff.
staffGlobalSettings = {

  %\override Score.BarNumber.font-size = #0
  \set Score.barNumberVisibility = #(every-nth-bar-number-visible 5)
  \override Score.BarNumber.self-alignment-X = #0
  \override Score.BarNumber.break-visibility = #end-of-line-invisible
  \set Score.doubleRepeatBarType = #":|.|:"

  \override Voice.NoteHead.style = #'baroque
  \override Accidental.hide-tied-accidental-after-break = ##t

  \numericTimeSignature
  \compressEmptyMeasures
}

% Staff A settings should be applied to every treble staff.
staffASettings = {
  %\set Staff.instrumentName = #"Text"
  \clef treble
}

% Staff B settings should be applied to every bass staff.
staffBSettings = {
  %\set Staff.instrumentName = #"Text"
  \clef bass
}

% Text to be inserted in title pages, headers, and footers.
\header {
  \include "../titles.ily"
}

% Include all the music
\include "../content/piece_001.ily"

\book {

  \score {
  \new ChoirStaff <<
    \new Staff  \with { midiInstrument = "acoustic grand" }
    {
      \staffGlobalSettings
      \staffASettings
      \SaaPaaVaa
    }
    \new FiguredBass = "figuredStaff"  \with { midiInstrument = "acoustic bass" }
    \SaaPaaFig
    \context Staff = "figuredStaff"
    {
      \staffGlobalSettings
      \staffBSettings
      \SaaPaaVab
    }
  >>
  \header {
    piece = \SaaPaaPiece
    opus = \markup { \italic { \SaaPaaOpus }}
  }
    \include "../include/baroque-layout.ily"
    \insertMidi \SaaPaaMidiTempo
  }
}
