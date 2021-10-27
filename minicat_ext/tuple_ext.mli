module Make : functor
  (F : sig
     type t
   end)
  -> Minicat.Functor.FUNCTOR with type 'a t = F.t * 'a
