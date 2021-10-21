open Minicat

include Monoid.Make(struct
  type t = bool

  let empty = true
  let append = (&&)
end)