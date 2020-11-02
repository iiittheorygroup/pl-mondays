#lang racket

; Story time!
; https://en.wikipedia.org/wiki/Entscheidungsproblem
; f n1 n2 n3
; f n
(define (sum2 a1 a2) (+ a1 a2))
(define sum1
  (lambda (a1)
    (lambda (a2)
      (+ a1 a2))))

; (.....) 2

; untyped LC syntax
; expr =  identifier
;       | lambda identifer expr
;       | expr1 expr2
; Functions ARE values! higher-order

(lambda (x) x)
((lambda (x) x) (lambda (x) x))
; ((lambda (x) x) 1) -> 1

; square : Int -> Int

; strategies
; Driving example :
; (lambda (x) x) ((lambda (x) x) (lambda (z) ((lambda (x) x) z)))
; L1 -> ((lambda (x) x) (lambda (z) (lambda (x) x z)))
; ((lambda (x) x) (lambda (z) ((lambda (x) x) z)))
; foo x y z = x * y
; Call by need : example haskell
; foo (2 * 4) (8 * 3) (2 + 5)
; Call by value : example racket
; foo (2 * 4) (8 * 3) (2 + 5)
; -> foo 8 24 7
; -> 192
; (lambda (x) (....)) ((lambda (y) (...)) (lambda (z) (...)))
; Call by value : Rule of thumb - Reduce parameters before reducing bodies
; (lambda (x) x) ((lambda (x) x) (lambda (z) ((lambda (x) x) z)))
; -> id (id (lambda (z) (id z)))
; -> id (lambda (z) (id z))
; -> (lambda (z) (id z))
; Call by name : Rule of thumb - Do not reduce inside abstractions
; (lambda (x) x) ((lambda (x) x) (lambda (z) ((lambda (x) x) z)))
; -> id (id ((lambda (z) (id z))))
; -> id (lambda (z) (id z))
; -> (lambda (z) (id z))
; Abstract Reduction Systems
; Confluence - no matter how you reduce, you end up with the same value!
; Church-Rosser :
; Confluence <=> Church-Rosser
; BODMAS
; 64 / 4 * 8
; Beta reduction - substitution
; Full beta reduction - reduce whatever you want
; (+/ )

; partial application
(define my-power
  (lambda (b p)
      (expt b p)))

; booleans, pairs, numbers, recursion
(define T (lambda (t f) t)) ; fun (t, f) -> t
(define F (lambda (t f) f)) ; fun (t, f) -> f
; OR X Y -> T/F
(define OR
  (lambda (X Y)
    (X T Y)))
(define AND
  (lambda (X Y)
    (X Y F)))
; Exercises : not, nand
; AND - X Y F

; Currying
; Haskell B. Curry
(define PAIR (lambda (fst snd) (lambda (B) (B fst snd))))
; FST P -> First pair
(define FST (lambda (P) (P T)))
(define SND (lambda (P) (P F)))
; 1. Exercise define pairwise addition for racket numbers
; 2. Exercise define pairwise addition for church numbers

; 1. 0 is a natural number
; 2. n is nat => succ n is also nat
; 3. There is nat < 0
; 4. n = m => succ n = succ m
; 5. Induction P(n) => P(succ n)

; Church encoding
(define C0
  (lambda (s z)
    z))

(define C1
  (lambda (s z)
    (s z)))

(define C2
  (lambda (s z)
    (s (s z))))

(define succ
  (lambda (n s z)
    (s (n s z))))

; x5 ^ 2 -> ______25 x*(x+1)

(define c-add
  (lambda (m n s z) ; m -> C1, n -> C2, s -> add1, z -> 0
    (m s (n s z)))) 

; Exercise : encode c-mult, WITHOUT c-add!

; /\
; succ
;  /\
; /\/\ 
