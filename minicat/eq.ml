module type EQ = sig
  type t

  val equal : t -> t -> bool
end

module Make (E : EQ) = struct
  include E

  let ( == ) = equal

  let ( != ) a b = equal a b |> Bool.not
end
