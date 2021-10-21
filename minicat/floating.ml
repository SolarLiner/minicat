(** Category of floating point types *)
module type FLOATING = sig
  include Num.NUM

  val recip : t -> t
  (** Returns the reciprocal of the value. *)

  val pi : t

  val exp : t -> t

  val log : t -> t

  val sin : t -> t

  val cos : t -> t

  val asin : t -> t

  val acos : t -> t

  val atan : t -> t

  val sinh : t -> t

  val cosh : t -> t

  val asinh : t -> t

  val acosh : t -> t

  val atanh : t -> t
end

module Make (F : FLOATING) = struct
  include F
  include Num.Make (F)

  (** [n / d] is [n * F.recip d]. *)
  let ( / ) n d = n * F.recip d
end