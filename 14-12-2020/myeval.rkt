#lang racket

; Exercise 1 - add new syntax
; Exercise 2 - implement in another language

; ((lambda (x) (* x x)) 5)
; (* x x) (x -> 5)
; ((lambda (x) (lambda (y) (+ x y))) 5)
; (lambda (y) (+ x y)) (x -> 5)

; e = (x -> 5)
; (e x) -> 5

; Abstraction and application
; 'x
; (lambda (x) x)
; ((lambda (x) x) (lambda (z) z))
; ` -> quasiquote
; , -> unquote
(define (myeval expr env)
  (match expr
    [(? symbol? x) (env x)]
    [`(lambda (,arg) ,body)
      (lambda (x)
        (myeval body (lambda (v)
                       (if (eq? v arg)
                         x
                         (env v)))))]
    [`(,rator ,rand)
      ((myeval rator env) (myeval rand env))]))

; Encode env as procedures
; ((x -> v) env)
; (env 'u)
(define (extend-env newvar v env)
  (lambda (z) ; z = 'x
    (if (eq? z newvar)
      v
      (env z))))

(define empty-env (lambda (x) (error "empty environment")))
(define e1 (extend-env 'x 5 empty-env))
(define e2 (extend-env 'y 6 e1))

; e1 = ('x -> 5)
; (lambda (z)
;   (if (eq? z 'x)
;     5
;     (empty-env z)))
; e1 (list (cons 'x 5))
; e2 (list (cons 'x 5) (cons 'y 6))
; (:) :: t -> [t] -> [t]
; cons :: a -> b -> (cons a b)
; (list 1 2 3)
; (cons 1 (cons 2 (cons 3 '())))
; (cons a b)
; Typed Racket
; (car (cons a b)) -> a
; (cdr (cons a b)) -> b

; e2 = ('y -> 6, 'x -> 5)
; Text
; (+ 1 2)
; Abstract Syntax Tree
; '((lambda (x) (* x x)) 6) 
; (car '((lambda (x) (* x x)) 6)) -> '(lambda (x) (* x x))
; (cddr'(lambda (x) (* x x)))
; expr -> (eval expr)
; (lambda (x) (..)) 5 -> (apply (lambda (x) (..)) 5)
; eval 
(apply (lambda (x) `()) 5)
((eval (lambda (x) `())) 5)
; Whatever expression you pass to myeval, you can also pass to eval
; (x -> '(lambda (x) (inc1 x)))
; 
'(lambda (x) x)
