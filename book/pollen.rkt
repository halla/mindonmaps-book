#lang racket

(require pollen/pagetree)
(require pollen/decode txexpr)
 (require pollen/template)

(define (root . elements)
   (make-txexpr 'root null (decode-elements elements
     #:txexpr-elements-proc detect-paragraphs
     #:string-proc (compose smart-quotes smart-dashes))))
(provide root)


(define (page-class name-string) (string-downcase (string-replace name-string " " "-")))
(provide page-class)


(define (get-depth ptree-item)
 1)

(define (get-depth-string ptree-item)
   (string-append "depth-" (number->string (get-depth ptree-item))))

(define (has-grandchildren? ptree-item) 
   (let ([cs (children ptree-item)])
     (if cs
         (ormap children cs) 
         #f)))

(define (get-grandchildren-string ptree-item)
   (if (has-grandchildren? ptree-item)
       "has-grandchildren"
       "no-grandchildren"))

(define (get-level ptree-item) 
   (define (iter ptree-item n) 
     (if (equal? ptree-item 'pagetree-root)
         n
         (iter (parent ptree-item) (+ n 1))))
   (iter ptree-item 0))

(define (get-level-string ptree-item)
   (string-append "level-" (number->string (get-level ptree-item))))

(define (get-toc-class ptree-item)
   (string-append (get-level-string ptree-item) " " (get-grandchildren-string ptree-item))
)


(define (toc-item x)
   (let ([sub-pages (children x)])
     `(li        
       (a [[href ,(string-append "/" (symbol->string x)) ]] 
          ,(->html (select-from-doc 'h1 x)))
       ,(if sub-pages
           `(ul  [[class ,(get-toc-class x) ]] ,@(map toc-item sub-pages)
               )
           '(span)))))



(define (toc ptree-item)
   (let ([child-pages (children ptree-item)])
     (->html `(ul [[class ,(get-toc-class ptree-item) ]]
              ,@(map toc-item child-pages)))))

(define (page-title page) (->html (select-from-doc 'h1 page)))



(require "local-config.rkt")

(provide toc)
(provide page-title)
(provide gtm-tag)
