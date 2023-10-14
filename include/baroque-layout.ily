\version "2.24.2"

\layout {

  indent = 5 \mm

  \context {
    \Voice
    \consists Custos_engraver
    \override Custos.style = #'mensural
  }

  \context {
    \Score
    \override SpacingSpanner.common-shortest-duration = #(ly:make-moment 1/2)
  }

}
