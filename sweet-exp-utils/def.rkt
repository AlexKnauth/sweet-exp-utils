#lang sweet-exp racket/base

provide all-defined-out()
        block

require racket/match
        racket/block
        racket/contract/base
        math/flonum
        rackunit
        syntax/parse/define
        only-in racket/base [set! rkt:set!]
        defpat
        my-cond/iffy
        for-syntax racket/base
                   syntax/parse
                   syntax/srcloc

define-simple-macro
  def a:expr (~datum =) b:expr ...+
  defpat a
    block b ...

define-simple-macro
  defm a:expr (~datum =) b:expr ...+
  match-define a
    block b ...

define-syntax set!
  syntax-parser
    (set! x:id (~datum =) v:expr)
      syntax (rkt:set! x v)
    (set! x:id (~and s (~datum +=)) v:expr)
      #:with +
      datum->syntax(#'s '+ update-source-location(#'s #:span 1) #'s)
      syntax (set! x = {x + v})
    (set! x:id (~and s (~datum -=)) v:expr)
      #:with -
      datum->syntax(#'s '- update-source-location(#'s #:span 1) #'s)
      syntax (set! x = {x - v})
    (set! x:id (~and s (~datum *=)) v:expr)
      #:with *
      datum->syntax(#'s '* update-source-location(#'s #:span 1) #'s)
      syntax (set! x = {x * v})
    (set! x:id (~and s (~datum /=)) v:expr)
      #:with /
      datum->syntax(#'s '/ update-source-location(#'s #:span 1) #'s)
      syntax (set! x = {x / v})

define-syntax chk
  lambda (stx)
    syntax-parse stx
      (chk a:expr (~datum =) b:expr)
        syntax/loc stx
          check-equal? a b

def ^ = expt

def (e^ n) = exp(n)
def (2^ n) = {2 ^ n}
def (10^ n) = {10 ^ n}

def ln(x) = log(x)
def log2(x) = fllog2(fl(x))
def logb(b x) = fllogb(fl(b) fl(x))
def log10(x) = logb(10 x)

def √ = sqrt

module+ test
  def f(list(x)) = x
  chk f('(x)) = 'x
  def f2([x 2]) = x
  chk f2() = 2
  chk f2(3) = 3
  chk {3 ^ 2} = 9
  test-case "set!"
    def x = 1
    chk x = 1
    set! x += 2
    chk x = 3
    def add = +
    block
      def (+ . args) =
        my-cond
          if andmap(number? args)
            apply(add args)
          else-if andmap((listof number?) args)
            apply(map add args)
          else
            error('+ "expected all numbers or all lists, given ~v" args)
      def y = '(1 2 3)
      set! y += '(4 5 6)
      chk y = '(5 7 9)

