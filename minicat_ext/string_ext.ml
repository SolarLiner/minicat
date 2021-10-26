open Minicat

include Monoid.Make (struct
  type t = String.t

  let empty = ""

  let append = ( ^ )
end)
