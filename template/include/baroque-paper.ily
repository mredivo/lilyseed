\version "2.24.2"

#(define inputFilename (cadr (string-split input-file-name #\/)))

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
      \fill-line {
        \if \on-first-page-of-part { \teeny #(string-append "File: " inputFilename) }
        % Copyright header field only on first page in each bookpart.
        \if \on-first-page-of-part \fromproperty #'header:copyright
      }
      \fill-line {
        % Tagline header field only on last page in the book.
        \if \on-last-page \fromproperty #'header:tagline
      }
    }
  }

  %% evenFooterMarkup would inherit the value of
  %% oddFooterMarkup if it were not defined here
  evenFooterMarkup = \markup {
    \column {
      \fill-line {
        % Copyright header field only on first page in each bookpart.
        \if \on-first-page-of-part \fromproperty #'header:copyright
        \if \on-first-page-of-part { \teeny #(string-append "File: " inputFilename) }
      }
      \fill-line {
        % Tagline header field only on last page in the book.
        \if \on-last-page \fromproperty #'header:tagline
      }
    }
  }
}
