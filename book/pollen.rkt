#lang racket

(require pollen/decode txexpr)
(define (root . elements)
   (make-txexpr 'root null (decode-elements elements
     #:txexpr-elements-proc detect-paragraphs
     #:string-proc (compose smart-quotes smart-dashes))))
(provide root)


(define (page-class name-string) (string-downcase (string-replace name-string " " "-")))
(provide page-class)

(require "local-config.rkt")
(provide gtm-tag)