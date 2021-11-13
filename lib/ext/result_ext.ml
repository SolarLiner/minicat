open Minicat_core

module Make (E : sig
  type t

  val of_string : string -> t
end) : Alternative.ALTERNATIVE = struct
  type 'a t = ('a, E.t) result

  let fail s = Error (E.of_string s)

  let empty = fail "empty"

  let pure a = Ok a

  let map = Result.map

  let app fr xr =
    match (fr, xr) with
    | Ok f, Ok r -> Ok (f r)
    | Error e, _ | _, Error e -> Error e

  let bind = Result.bind

  let alt a b = match (a, b) with Ok a, _ -> Ok a | Error _, a -> a
end
