(** The meta-type of categories themselves.
    Functions are themselves categories, and it can be useful to look at this module by substituting [('a, 'b) t] with ['a -> 'b]. *)
module type CATEGORY = sig
  type ('a, 'b) t

  val id : ('a, 'a) t
  (** The identity category, that maps ['a] onto itself. *)

  val compose : ('b, 'c) t -> ('a, 'b) t -> ('a, 'c) t
  (** Composition of categories, combining category transformations. *)
end

module Make (C : CATEGORY) = struct
  include C

  (** [a <<< b] is an alias of [C.compose a b]. *)
  let ( <<< ) = compose

  (** [a >>> b] is [b <<< a] with its arguments flipped. *)
  let ( >>> ) a b = b <<< a
end
