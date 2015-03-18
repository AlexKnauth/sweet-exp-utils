#lang sweet-exp racket/base

provide all-defined-out()

require racket/match
        racket/block
        rackunit
        syntax/parse/define
        defpat

define-simple-macro
  def a:expr (~datum =) b:expr ...+
  defpat a
    block b ...

define-simple-macro
  defm a:expr (~datum =) b:expr ...+
  match-define a
    block b ...

define-simple-macro
  chk a:expr (~datum =) b:expr
  check-equal? a b

def ^ = expt

module+ test
  def f(list(x)) = x
  chk f('(x)) = 'x
  def f2([x 2]) = x
  chk f2() = 2
  chk f2(3) = 3
  chk {3 ^ 2} = 9

