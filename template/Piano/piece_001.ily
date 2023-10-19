\version "2.24.2"

pieceIPiece = ""
pieceIOpus = ""
pieceIMidiTempo = 30

pieceITrebleStaff = \relative c'' {
  \key g \major
  \time 3/4
  \repeat volta 2 {
    g8 b d g a, fis' |
    g4 g, g |
    g8 b d g a, fis' |
    g4 g, g |
    e'4 e e8 g |
    d4 d d8 g |
    c,4 d8 c b c |
    a2. |
    g8 b d g a, fis' |
    g4 g, g |
    g8 b d g a, fis' |
    g4 g, g |
    e'4 d8 c b a|
    d4 c8 b a g |
    \tuplet 3/2 { a8 b c } d,4 fis |
    g2. |
  }
  \repeat volta 2 {
    g8 a b a g fis |
    g4 e e |
    g'8 fis e g fis e |
    fis4 b, b |
    g'8 fis e g fis e |
    fis4 b, e |
    \tuplet 3/2 { fis8 g a } b,4 dis |
    e4 d8 e fis4 |
    g4 g8 fis e d |
    e4 e8 d c b |
    c4 c8 b a g |
    fis4 e8 fis d4 |
    a'4 d, d |
    b'4 d, d |
    c'4 d8 c b c |
    a2. |
    g8 b d g a, fis' |
    g4 g, g |
    g8 b d g a, fis' |
    g4 g, g |
    e'4 d8 c b a |
    d4 c8 b a g |
    a8 b d,4 fis g2. |
  }
}

pieceIBassStaff= \relative c' {
  \key g \major
  \time 3/4
  g2 d4 |
  g,8 b d g d b |
  g2 d'4 |
  g,8 b d g d b |
  c4 g' c, |
  b4 g' b, |
  a4 fis' g |
  d8 e fis d e fis |
  g2 d4 |
  g,8 b d g d b |
  g2 d'4 |
  g,8 b d g d b |
  c4 e g |
  b,4 d g |
  c,4 c d |
  g4 d g, |
  % Second section
  e'4 dis b |
  e4 b e, |
  e'4 g b |
  b,8 dis fis b fis dis |
  e4 g b |
  b,4 a' g |
  a4 b b, |
  e2. |
  b4 d g |
  c,4 d e |
  a,4 b c |
  d4 a d, |
  fis'8 d fis d fis d |
  g8 d g d g d |
  fis4 d g |
  d8 e fis d e fis |
  g2 d4 |
  g,8 b d g d b |
  g2 d'4 |
  g,8 b d g d b |
  c4 e g |
  b,4 d g |
  c,2 d4 |
  g4 d g, |
}