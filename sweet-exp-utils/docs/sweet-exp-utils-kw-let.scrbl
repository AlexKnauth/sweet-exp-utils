#lang scribble/manual
@(require scribble/eval
          scribble-code-examples
          (for-label sweet-exp-utils/kw-let
                     racket
                     (only-in lang/htdp-advanced recur)
                     ))

@title{sweet-exp-utils/kw-let}

@defmodule[sweet-exp-utils/kw-let]

@defform[(kw-let kw expr ... ... body ...+)]{
Similar to @racket[let], except that instead of a parenthesized list of binding
pairs, it takes the identifiers as keywords.  This is especially useful within
a module with the @racketmodname[sweet-exp] meta-language.

@examples[
  (require sweet-exp-utils/kw-let)
  (kw-let #:a 1 #:b 2
    (+ a b))
]
@code-examples[#:lang "sweet-exp racket" #:context #'here #:show-lang-line #t]{
require sweet-exp-utils/kw-let
kw-let #:a 1 #:b 2
  {a + b}
kw-let
  #:a lambda (x)
        {x + 1}
  #:b 2
  a(b)
}
}

@deftogether[[
  @defform[(kw-let* kw expr ... ... body ...+)]
  @defform[(kw-letrec kw expr ... ... body ...+)]
]]{
Like @racket[kw-let], but behaving like @racket[let*] and @racket[letrec].
}

@defform[(kw-recur loop-id kw expr ... ... body ...+)]{
Similar in spirit to the named variant of @racket[let], or to @racket[recur]
from ASL, but replacing the list of binding pairs with a sequence of keywords,
and also defining @racket[loop-id] as a function that takes keyword arguments,
instead of positional arguments.

@examples[
  (require sweet-exp-utils/kw-let)
  (kw-recur fac #:n 10
    (if (zero? n)
        1
        (* n (fac #:n (sub1 n)))))
]
@code-examples[#:lang "sweet-exp racket" #:context #'here #:show-lang-line #t]{
require sweet-exp-utils/kw-let
kw-recur fac #:n 10
  if zero?(n)
     1
     {n * fac(#:n {n - 1})}
}
}

