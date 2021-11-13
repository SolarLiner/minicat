(** Equality comparison. This allows any computation to be performed as part of checking, instead of simple structure checking as done by the [=] and [<>] operators. *)
module type EQ = sig
  type t
  (** Type to match against for equality. *)

  val equal : t -> t -> bool
  (** Check for equality. *)
end

module Make (E : EQ) = struct
  include E

  (** Operator alias for equality. Note the double equals sign in [==] to distinguish it from the default structural equality check in OCaml. *)
  let ( == ) = equal

  (** Operator alias for inequality. Derived from [equals], and distinct from OCaml's default structural inequality check. *)
  let ( != ) a b = equal a b |> Bool.not
end

(** Wraps OCaml's default structural equality check into the EQ category for easily plugging into modules that require equality. *)
module StructEq (T : sig
  type t
end) =
Make (struct
  type t = T.t

  let equal = ( = )
end)
