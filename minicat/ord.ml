(** Type of ordering results. *)
type ordering = LT | EQ | GT

(** Total ordering of values, meaning that forall a b c. [a <= b <= c iff a <= b and b <= c].*)
module type ORD = sig
  include Eq.EQ

  val compare : t -> t -> ordering
  (** Compare two values and return their relative order. *)
end

module Make (O : ORD) = struct
  include O
  include Eq.Make (O)

  (** Strict less-than operator. Shadows OCaml's structural operator when imported, for convenience, but keep in mind that this might induce type error elsewhere if the scope of the import is too large. *)
  let ( < ) a b = compare a b |> ( = ) LT

  (** Less-than or equal operator. Shadows OCaml's structural operator when imported, for convenience, but keep in mind that this might induce type error elsewhere if the scope of the import is too large. *)
  let ( <= ) a b =
    let o = compare a b in
    o = LT || o = EQ

  (** Strict greater-than operator. Shadows OCaml's structural operator when imported, for convenience, but keep in mind that this might induce type error elsewhere if the scope of the import is too large. *)
  let ( > ) a b = b < a

  (** Greater-than or equal operator. Shadows OCaml's structural operator when imported, for convenience, but keep in mind that this might induce type error elsewhere if the scope of the import is too large. *)
  let ( >= ) a b = b <= a

  (** Computes the maximum of two numbers. *)
  let max a b = if a < b then b else a

  (** Computes the minimum of two numbers. *)
  let min a b = if a < b then a else b
end

module StructOrd (O : sig
  type t
end) =
Make (struct
  type t = O.t

  let equal = ( = )

  let compare a b =
    match compare a b with
    | -1 -> LT
    | 0 -> EQ
    | 1 -> GT
    | _ -> failwith "Comparison result outside range"
end)