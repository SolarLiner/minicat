open Minicat

module ResultInner =
functor
  (E : sig
     type t
   end)
  ->
  struct
    type 'a t = ('a, E.t) result

    let pure a = Ok a

    let map = Result.map

    let app fr xr =
      match (fr, xr) with
      | Ok f, Ok r -> Ok (f r)
      | Error e, _ | _, Error e -> Error e

    let bind = Result.bind
  end

module Make (E : sig
  type t

  val of_string : string -> t
end) =
struct
  include Monad.Make (ResultInner (E))

  let fail s = Error (E.of_string s)
end
