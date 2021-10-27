include Minicat.Arrow.ARROW with type ('a, 'b) t = 'a -> 'b

module Monad : functor
  (P : sig
     type t
   end)
  -> Minicat.Monad.MONAD

module Comonad : functor (P : Minicat.Monoid.MONOID) -> Minicat.Comonad.COMONAD
