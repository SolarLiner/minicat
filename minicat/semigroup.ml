module type SEMIGROUP = sig
  type t

  val append : t -> t -> t
end

module Make (S : SEMIGROUP) = struct
  include S

  let ( ++ ) = append
end
