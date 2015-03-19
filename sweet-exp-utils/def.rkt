#lang sweet-exp racket/base

provide all-defined-out()
        block

require racket/match
        racket/block
        math/flonum
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

