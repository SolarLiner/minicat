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

  val of_string : string -> t
  (** Constructs a [t] form its string representation. *)
end

module Make (N : NUM) = struct
  include N

  let zero = of_string "0"

  let one = of_string "1"

  (** Operator alias of addition. Shadows the default [+] operator of ints for convenience. *)
  let ( + ) = add

  (** Operator alias of subtraction. Shadows the default [+] operator of ints for convenience. *)
  let ( - ) = sub

  (** Operator alias of multiplication. Shadows the default [+] operator of ints for convenience. *)
  let ( * ) = mul

  (** Negation function, derived from subtracting [of_int 0]. *)
  let neg = ( - ) zero

  let rec ( ^ ) a b = if b == zero then one else a * (a ^ (b - one))
end
