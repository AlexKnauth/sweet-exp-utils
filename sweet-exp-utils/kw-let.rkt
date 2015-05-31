#lang sweet-exp racket/base

provide kw-let
        kw-let*
        kw-letrec
        kw-recur

require syntax/parse/define
        for-syntax racket/base
                   racket/syntax
module+ test
  require rackunit

begin-for-syntax
  define-syntax-class kw
    [pattern kw:keyword
      #:with id:id (format-id #'kw "~a" (syntax-e #'kw) #:source #'kw #:props #'kw)]

define-simple-macro
  kw-let
    ~seq kw:kw val:expr
    ...
    body:expr
    ...+
  let ([kw.id val] ...) body ...

define-simple-macro
  kw-let*
    ~seq kw:kw val:expr
    ...
    body:expr
    ...+
  let* ([kw.id val] ...) body ...

define-simple-macro
  kw-letrec
    ~seq kw:kw val:expr
    ...
    body:expr
    ...+
  letrec ([kw.id val] ...) body ...

define-simple-macro
  kw-recur loop-id:id
    ~and
      ~seq init-stuff ...
      ~seq kw:kw init-val:expr
    ...
    body:expr
    ...+
  #:with [[arg-stuff ...] ...]
  #'[[kw kw.id] ...]
  let ()
    define (loop-id arg-stuff ... ...)
      body
      ...
    loop-id init-stuff ... ...

module+ test
  check-equal?
    kw-let #:a 1 #:b 2
      {a + b}
    3
  check-equal?
    kw-let
      #:a 1
      #:b 2
      {a + b}
    3
  check-equal?
    kw-recur fac #:n 10
      if zero?(n)
         1
         {n * fac(#:n {n - 1})}
    3628800

