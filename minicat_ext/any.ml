open Minicat

include Monoid.Make (struct
  type t = bool

  let empty = false

  let append = ( || )
end)
