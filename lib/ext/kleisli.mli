module Make : functor (M : Minicat_core.Monad.MONAD) -> sig
  type ('a, 'b) t = K of ('a -> 'b M.t)

  include Minicat_core.Arrow.ARROW with type ('a, 'b) t := ('a, 'b) t

  val make : ('a -> 'b M.t) -> ('a, 'b) t

  val run : ('a, 'b) t -> 'a -> 'b M.t
end

module Monad : functor
  (M : Minicat_core.Monad.MONAD)
  (A : sig
     type t
   end)
  -> Minicat_core.Monad.MONAD
