#lang racket

(provide toc)
(provide page-title)
(provide gtm-tag)
(provide page-class)
(provide root)

(require "local-config.rkt")

(require pollen/pagetree)
(require pollen/decode txexpr)
(require pollen/template)

(define (root . elements)
   (make-txexpr 'root null (decode-elements elements
     #:txexpr-elements-proc detect-paragraphs
     #:string-proc (compose smart-quotes smart-dashes))))

(define (page-class name-string) (string-downcase (string-replace name-string " " "-")))

(define (get-depth ptree-item) 1)

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
     (if (equal? ptree-item #f)
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

(module+ test
  (require rackunit)

  (define pt '(pagetree-root carticle.html (article.html (subarticle.html subsubarticle.html)) barticle.html))
  (check-equal? 1 1)
  (check-equal? #t (pagetree? pt))
  (current-pagetree pt)
  (check-equal? 'subarticle.html (first (children 'article.html)))

  (check-equal? (page-class "SoMe PagE") "some-page")
  (check-equal? (get-depth-string 'carticle.html) "depth-1")
  ;(check-equal? (has-grandchildren? 'article.html) #t)
  (check-equal? (get-grandchildren-string 'article.html) "has-grandchildren")
  (check-equal? (get-grandchildren-string 'carticle.html) "no-grandchildren")
  (check-equal? (parent 'article.html) #f) ; used to be 'pagetree-root
  (check-equal? (get-level 'article.html) 1)
  
  )




