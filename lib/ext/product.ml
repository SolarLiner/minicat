open Minicat_core

module Make (N : Num.NUM) : Monoid.MONOID with type t = N.t = struct
  include Num.Make (N)

  let empty = one

  let append = ( * )
end
