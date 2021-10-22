open Minicat

module Make (N : Num.NUM) = Monoid.Make (struct
  open Num.Make (N)

  type t = N.t

  let empty = zero

  let append = ( + )
end)
