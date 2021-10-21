module type NUM = sig
  type t

  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val abs : t -> t
  val signum : t -> t
  val of_int : int -> t
end

module Make(N: NUM) = struct
include N

let (+) = add
let (-) = sub
let ( * ) = mul
let neg = (-) (of_int 0)
end