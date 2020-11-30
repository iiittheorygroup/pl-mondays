#lang racket

(define (f n)
  (f (- n 1)))

(define (factorial n)
  (if (equal? n 0)
    1
    (* n (factorial (- n 1)))))

; f(x) = x
; Will iteration always converge to fixpoint?
; No! Take f(1) = 2 and f(2) = 1, will oscillate
(define (fixpoint-cos n r)
  (if
    (equal? n 0)
    r
    (let ([x (fixpoint-cos (- n 1) (cos r))])
      (printf "Current value ~s\n" r)
      x)))

; (define (f x y z)
;   (...)) -- no f in body!

; Y-combinator (f) = fixpoint(f)
; what to pass to Y, to get factorial?
; Y(G), such that G's fixpoint is factorial
;
; f : Int -> Int, f(x) = x * x, f(0) = 0, f(1) = 1

(define (G f)
    (lambda (n)
      (if (equal? n 0)
        1
        (* n (f (- n 1))))))

; s x = G (x x)
; s s = G (s s)
(define (Y g)
  (let ([s (lambda (x) (g (x x)))]) ; s(x) = g(x(x))
    (s s))) ; s(s) = g(s(s)) = g(g(s(s)))

(define (Ya g)
  (let ([s (lambda (x)
             (lambda (n)
               ((g (x x)) n)))]) ; g(s(s))(n)
    (s s)))

; (let (bindings...) (expr...))
; (let ([square (lambda (x) (* x x))]) (square 5))

(define plain-Y
  (lambda (f)
    ((lambda (x) (lambda (f (x x))))
     (lambda (x) (lambda (f (x x)))))))

(define (square x) (* x x))
