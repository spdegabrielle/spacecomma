#lang racket/base

;(with-input-from-string "[a, b, c, d]" read)

(provide make-spacecomma-readtable)

(define (make-spacecomma-readtable)
  (define previous-readtable (current-readtable))
   (make-readtable
  previous-readtable
  #\~ #\, #f
  #\, #\space #f))




