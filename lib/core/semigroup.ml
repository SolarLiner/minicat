(** Semigroups are types which allow a binary operation on them. Useful examples of semigroups are [Sum] and [Product] which are self-described, as well as [All] or [Any].
    When combined with [Foldable] types, they allow concise writing of value reductions. *)
module type SEMIGROUP = sig
  type t
  (** Type of the semigroup *)

  val append : t -> t -> t
  (** Binary operator, applicable onto two values of [t]. *)
end

module Make (S : SEMIGROUP) = struct
  include S

  (** Operator alias of [S.append]. *)
  let ( ++ ) = append
end
