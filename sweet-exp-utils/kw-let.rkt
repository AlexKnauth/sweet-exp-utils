#lang sweet-exp racket

provide kw-let
        kw-let*
        kw-letrec

require syntax/parse/define
        for-syntax racket/syntax
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

