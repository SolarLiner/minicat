module Make : functor (M : Minicat.Monad.MONAD) -> sig
  type ('a, 'b) t = K of ('a -> 'b M.t)

  include Minicat.Arrow.ARROW with type ('a, 'b) t := ('a, 'b) t

  val make : ('a -> 'b M.t) -> ('a, 'b) t

  val run : ('a, 'b) t -> 'a -> 'b M.t
end

module Monad : functor
  (M : Minicat.Monad.MONAD)
  (A : sig
     type t
   end)
  -> Minicat.Monad.MONAD
