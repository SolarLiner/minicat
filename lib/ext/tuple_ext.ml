open Minicat_core

module Make (F : sig
  type t
end) : Functor.FUNCTOR with type 'a t = F.t * 'a = struct
  type 'a t = F.t * 'a

  let map f (a, s) = (a, f s)
end
