type ordering = LT | EQ | GT

module type ORD = sig
  include Eq.EQ

  val compare : t -> t -> ordering
end

module Make (O : ORD) = struct
  include O
  include Eq.Make (O)

  let ( < ) a b = compare a b |> ( = ) LT

  let ( <= ) a b =
    let o = compare a b in
    o = LT || o = EQ

  let ( > ) a b = b < a

  let ( >= ) a b = b <= a

  let max a b = if a < b then b else a

  let min a b = if a < b then a else b
end
