(** Numerical types. This defines the set of arithmetical operations on numbers.
    Note that division is not defined as part of this trait as integral types
    can't properly defined division. *)
module type NUM = sig
  type t
  (** Numerical type. *)

  val add : t -> t -> t
  (** Add two values together. *)

  val sub : t -> t -> t
  (** Subtract two values together. *)

  val mul : t -> t -> t
  (** Multiply two values together. *)

  val abs : t -> t
  (** Return the absolute value of the number. *)

  (* Returns the value of the sign, such that it is [of_int 1] if positive, or [of_int -1] if negative. *)
  val signum : t -> t

  val of_int : int -> t
end

module Make (N : NUM) = struct
  include N

  (** Operator alias of addition. Shadows the default [+] operator of ints for convenience. *)
  let ( + ) = add

  (** Operator alias of subtraction. Shadows the default [+] operator of ints for convenience. *)
  let ( - ) = sub

  (** Operator alias of multiplication. Shadows the default [+] operator of ints for convenience. *)
  let ( * ) = mul

  (** Negation function, derived from subtracting [of_int 0]. *)
  let neg = ( - ) (of_int 0)

  let rec ( ^ ) a b =
    if b == of_int 0 then of_int 1 else a * (a ^ (b - of_int 1))
end
