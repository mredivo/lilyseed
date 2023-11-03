\version "2.24.2"

\paper {
  #(include-special-characters) % for copyright symbol

  print-first-page-number = ##f
  ragged-bottom = ##t
  ragged-last-bottom = ##t
  print-all-headers = ##f

  % Leave room for the punched holes.
  left-margin = 12\mm
  right-margin = 12\mm

  oddFooterMarkup = \markup {
    \column {
      % Copyright header field prints only on the first page in each bookpart
      \if \on-first-page-of-part {
        \fill-line {
          \fromproperty #'header:copyright
          \fromproperty #'header:inputFilename
        }
      }
      % Tagline header field prints only on the final page
      \if \on-last-page {
        \fill-line {
          \fromproperty #'header:tagline
        }
      }
    }
  }

  % evenFooterMarkup inherits the value of oddFooterMarkup unless defined here
}
