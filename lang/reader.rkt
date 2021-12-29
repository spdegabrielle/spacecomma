#lang racket/base
(require syntax/module-reader
         (only-in "../readtable.rkt" make-spacecomma-readtable))

(provide (rename-out [spacecomma-read read]
                     [spacecomma-read-syntax read-syntax]
                     [spacecomma-get-info get-info]))

(define (wrap-reader p)
  (lambda args
    (parameterize ([current-readtable (make-spacecomma-readtable)])
      (apply p args))))

(define-values (spacecomma-read spacecomma-read-syntax spacecomma-get-info)
  (make-meta-reader
   'spacecomma  ;	self-sym
   "language path" ; path-desc-str
   ; [	#:read-spec read-spec]	read-spec : (input-port? . -> . any/c) = (lambda (in) ....)
   lang-reader-module-paths ; module-path-parser : (any/c . -> . (or/c module-path? #f (vectorof module-path?)))

   wrap-reader ; convert-read : (procedure? . -> . procedure?)
   wrap-reader ; convert-read-syntax : (procedure? . -> . procedure?)
   
   ;; convert-get-info : (procedure? . -> . procedure?)
   values))
