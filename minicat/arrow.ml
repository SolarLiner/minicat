(** Arrows are a generalization of monads; where monads are seen as computations that output some value,
    arrows are functions of monads, allowing the representation of monads themselves. *)
module type ARROW = sig
  include Category.CATEGORY

  val arr : ('a -> 'b) -> ('a, 'b) t
  (** [arr f] "lifts" the function [f] into the arrow [t]. *)

  val ( *** ) : ('a, 'b) t -> ('c, 'd) t -> ('a * 'c, 'b * 'd) t
  (** [f *** g] "combines" the functions [f] and [g] into a single function such that [fun (x,y) -> (f x, g y)]. *)
end

module Make (A : ARROW) = struct
  include A
  include Category.Make (A)

  (** [first a] transforms the arrow [a]'s first component, leaving its second component unchanged. *)
  let first a = a *** id

  (** [first a] transforms the arrow [a]'s second component, leaving its first component unchanged. *)
  let second a = id *** a

  (** [a &&& b] fans-out input to both [a] and [b]. *)
  let ( &&& ) f g = arr (fun b -> (b, b)) >>> f *** g
end
