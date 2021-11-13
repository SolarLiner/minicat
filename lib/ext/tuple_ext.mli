module Make : functor
  (F : sig
     type t
   end)
  -> Minicat_core.Functor.FUNCTOR with type 'a t = F.t * 'a
