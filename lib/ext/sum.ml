open Minicat_core

module Make (N : Num.NUM) : Monoid.MONOID with type t = N.t = struct
  open Num.Make (N)

  type t = N.t

  let empty = zero

  let append = ( + )
end
