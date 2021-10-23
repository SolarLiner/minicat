open Minicat

module MakeMonad (P : sig
  type t
end) =
Monad.Make (struct
  type 'a t = P.t -> 'a

  let map f g x = f (g x)

  let pure = Fun.const

  let app f g x = f x (g x)

  let bind m k r = k (m r) r
end)

include Arrow.Make (struct
  type ('a, 'b) t = 'a -> 'b

  let id = Fun.id

  let compose f g x = f (g x)

  let arr = Fun.id

  let ( *** ) f g (x, y) = (f x, g y)
end)

module MakeComonad (P : Monoid.MONOID) = Comonad.Make (struct
  type 'a t = P.t -> 'a

  let map f t x = f (t x)

  let extract t = t P.empty

  let duplicate f m x = f (P.append m x)

  let extend f x = map f (duplicate x)
end)