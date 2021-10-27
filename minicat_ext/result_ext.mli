module Make : functor
  (E : sig
     type t

     val of_string : string -> t
   end)
  -> Minicat.Alternative.ALTERNATIVE
