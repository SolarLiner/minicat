open Minicat

include Integer.Make (struct
  include Int
  include Ord.StructOrd (Int)

  let of_int = Fun.id

  let to_int = Fun.id

  let quotrem a b = (a / b, a mod b)

  let signum a = Int.compare a 0
end)