#lang racket/gui
(require drracket/tool framework "color-lexer.rkt")
 
(provide tool@)

(define pyret-text
  (class* mode:surrogate-text% (mode:surrogate-text<%>)
    (super-new)))
(define colored-pyret-text
  (color:text-mode-mixin pyret-text))
(define pyret-repl-submit (lambda (text num) #t))
(define is-pyret-lang? (lambda (name) (equal? name "pyret")))
 
(define tool@
  (unit
    (import drracket:tool^)
    (export drracket:tool-exports^)
    (define (phase1) '())
    (define (phase2)
      (define pt (new colored-pyret-text
        [get-token get-token]
        [matches (list)]
        [token-sym->style (lambda (s) "Constant")]))
      (drracket:modes:add-mode "pyret" pt pyret-repl-submit is-pyret-lang?))
    '()))

