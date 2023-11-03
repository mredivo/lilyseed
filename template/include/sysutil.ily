\version "2.24.2"

% ly:get-subpath
%
% This function accepts a file path and an anchor point.
% It returns that portion of the path that is to the right of the
% given anchor point, without a leading "/".
#(define (ly:get-subpath p anchor)
   (define result "")
   (define (re-assemble l)
     (if (or (zero? (length (cdr l)))
             (equal? (car l) anchor))
         result
         (begin
          (if (equal? result "")
              (set! result (car l))
              (set! result (string-append (car l) "/" result)))
          (re-assemble (cdr l))
          )
         ))
   (re-assemble (reverse (string-split p #\/)))
   )

% Make the date available in various formats
%
now-YY = #(strftime "%Y" (localtime (current-time)))
now-YMD = #(strftime "%Y-%m-%d" (localtime (current-time)))
now-YMD-HMS = #(strftime "%Y-%m-%d %H:%M:%S" (localtime (current-time)))
