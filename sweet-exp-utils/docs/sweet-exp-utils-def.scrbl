#lang scribble/manual
@(require (for-label sweet-exp-utils/def
                     defpat
                     (rename-in racket/base [set! rkt:set!] [= rkt:=])
                     ))

@title{sweet-exp-utils/def}

@defmodule[sweet-exp-utils/def]

@defform*[[(def id = expr ...+)
           (def (head args) = body ...+)]
          #:grammar ([head id
                           (head args)]
                     [args (code:line arg ...)
                           (code:line arg ... @#,racketparenfont{.} rest-id)]
                     [arg arg-id
                          [arg-id default-expr]
                          (code:line keyword arg-id)
                          (code:line keyword [arg-id default-expr])])]{
The first form defines @racket[id] as the result of the last @racket[expr].

The second form defines a function.

Equivalent to @racket[(define id (block expr ...))] or @racket[(defpat (head args) body ...)].
}

@defform*[[(set! id = expr)
           (set! id += expr)
           (set! id -= expr)
           (set! id *= expr)
           (set! id /= expr)]]{
The first form mutates the variable @racket[id] and assigns to it the value of @racket[expr].

The second form, @racket[(set! id += expr)] is equivalent to @racket[(set! id = {id + expr})].

The third, fourth, and fifth forms are equivalent to @racket[(set! id = {id - expr})],
@racket[(set! id = {id * expr})], and @racket[(set! id = {id / expr})].

}

@defform*[[(chk a = b)]]{
Checks that @racket[a] is equal to @racket[b], and prints a check-failure message if it doesn't.
}

@defproc[(= [a any] [b any] ...) boolean?]{
Returns true if all of its arguments are equal.

For numbers, it uses @racket[rkt:=], otherwise, it uses @racket[equal?].
}

@defproc[(^ [z number?] [w number?]) number?]{
an alias for @racket[expt].
}

@deftogether[[
  @defproc[(e^ [z number?]) number?]
  @defproc[(2^ [z number?]) number?]
  @defproc[(10^ [z number?]) number?]
]]{
Functions for exponents of different bases.
}

@deftogether[[
  @defproc[(ln [z number?]) number?]
  @defproc[(log2 [x real?]) real?]
  @defproc[(log10 [x real?]) real?]
  @defproc[(logb [b real?] [x real?]) real?]
]]{
Functions for logarithms of different bases.
}

@defproc[(√ [z number?]) number?]{
an alias for @racket[sqrt].
}

