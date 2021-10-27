open Minicat
include Int
include Ord.StructOrd (Int)

let of_string = int_of_string

let to_string = string_of_int

let quotrem a b = (a / b, a mod b)

let signum a = Int.compare a 0
