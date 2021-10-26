open Minicat

include Monoid.Make (struct
  type t = unit

  let empty = ()

  let append _ _ = ()
end)
