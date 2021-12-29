#lang racket/base

;(with-input-from-string "[a, b, c, d]" read)

(provide make-csv-readtable)

(define (make-csv-readtable)
  (define previous-readtable (current-readtable))
   (make-readtable
  previous-readtable
  #\~ #\, #f
  #\, #\space #f))




