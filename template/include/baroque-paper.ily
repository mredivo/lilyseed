\version "2.24.2"

% Provide a helper function to insert subtitles into the Table of Contents
tocSubtitle =
#(define-music-function (label text) (symbol? markup?)
   (add-toc-item! 'tocSubtitleMarkup text label))

\paper {
  #(include-special-characters) % for copyright symbol

  print-first-page-number = ##f
  ragged-bottom = ##t
  ragged-last-bottom = ##t
  print-all-headers = ##f

  % Leave room for the punched holes.
  left-margin = 12\mm
  right-margin = 12\mm

  % evenFooterMarkup inherits the value of oddFooterMarkup unless redefined
  oddFooterMarkup = \markup {
    \column {
      % Copyright header field prints only on the first page
      \if \on-first-page {
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
      %  A short horizontal line prints on all other pages
      \unless \on-page #0 \unless \on-first-page \unless \on-last-page
      \fill-line {
        \null \override #'(span-factor . 1/3) \draw-hline \null
      }
    }
  }

  % Table of Contents title
  tocTitleMarkup = \markup \abs-fontsize #16 \bold \column {
    \fill-line { \null "Table of Contents" \null }
    \null
  }

  % Table of Contents subtitles
  tocSubtitleMarkup = \markup {
    \vspace #2
    \column {
      \huge \bold \italic \fill-line {
        \null \fromproperty #'toc:text \null
      }
    }
  }

  % Table of Contents line items
  tocItemMarkup = \markup {
    % This formatting took a long time to get properly centered at the
    % correct width.
    % Be prepared to spend a LOT of time if you want to change it.
    \override #'(line-width . 65)
    \fill-line {
      \hspace #1 " "
      \fill-with-pattern #1 #RIGHT .
        \fromproperty #'toc:text \fromproperty #'toc:page
      \hspace #1 " "
    }
  }
}
