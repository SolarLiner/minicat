(** "Container type" category. This is implemented by types that contain values, and allow 
    manipulation of them through the container.
    
    Note that this is not the same as *module functors*, which bear the same name but are 
    different in OCaml. *)
module type FUNCTOR = sig
  type 'a t
  (** Functor type. *)

  val map : ('a -> 'b) -> 'a t -> 'b t
  (** Map values of this container onto a new container, through the provided function. *)
end

module Make (F : FUNCTOR) = struct
  include F

  (** Operator alias of [F.map]. *)
  let ( <$> ) = map

  (** Left-biased map operation, that is, replace all values of the container with the provided value. *)
  let ( <$ ) x = map (Fun.const x)

  (** Functor value binding, that is, [let$ x = xs in ...] binds [x] to all values of [xs].
      This binding is non-flattening, which means every new binding will introduce a level of
      nesting in the resulting type. *)
  let ( let$ ) xs f = f <$> xs

  (** Specialization of [(<$)] that replaces all values of [t] by [()]. *)
  let void xs = () <$ xs
end
