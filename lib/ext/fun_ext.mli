include Minicat_core.Arrow.ARROW with type ('a, 'b) t = 'a -> 'b

module Monad : functor
  (P : sig
     type t
   end)
  -> Minicat_core.Monad.MONAD

module Comonad : functor (P : Minicat_core.Monoid.MONOID) ->
  Minicat_core.Comonad.COMONAD
