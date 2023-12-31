%
% Determine whether to produce MIDI output.
%
% Usage: lilypond -d midi FILE.ly
%
% To produce MIDI output unconditionally without needing a command line
% argument (for example when using Frescobaldi), use the following
% construct:
%
%   \include "../include/midi.ily"
%   #(define *makeMidi* #t)
%
% Extract the command-line argument and store it.
#(define *makeMidi* (if (ly:get-option 'midi) #t #f))

% Call this to generate MIDI output where you would put "\midi" in the book.
%   Optionally, set the tempo in whole notes per minute; zero to use current tempi.
insertMidi = #(define-scheme-function (wholeNotesPerMinute) (number?)
    (if *makeMidi*
        (if (= wholeNotesPerMinute 0)
            #{ \midi {} #}
            #{ \midi { \context { \Score
                    tempoWholesPerMinute = #(ly:make-moment wholeNotesPerMinute 1)
                }}
            #}
        )
    )
)

