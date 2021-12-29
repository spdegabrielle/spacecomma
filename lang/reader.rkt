#lang racket/base
(require syntax/module-reader
         (only-in "../readtable.rkt" make-csv-readtable))

(provide (rename-out [csv-read read]
                     [csv-read-syntax read-syntax]
                     [csv-get-info get-info]))

(define (wrap-reader p)
  (lambda args
    (parameterize ([current-readtable (make-csv-readtable)])
      (apply p args))))

(define-values (csv-read csv-read-syntax csv-get-info)
  (make-meta-reader
   'csv  ;	self-sym
   "language path" ; path-desc-str
   ; [	#:read-spec read-spec]	read-spec : (input-port? . -> . any/c) = (lambda (in) ....)
   lang-reader-module-paths ; module-path-parser : (any/c . -> . (or/c module-path? #f (vectorof module-path?)))

   wrap-reader ; convert-read : (procedure? . -> . procedure?)
   wrap-reader ; convert-read-syntax : (procedure? . -> . procedure?)
   
   ;; convert-get-info : (procedure? . -> . procedure?)
   values))