open Minicat_core

module Monad (P : sig
  type t
end) : Monad.MONAD = struct
  type 'a t = P.t -> 'a

  let map f g x = f (g x)

  let pure = Fun.const

  let app f g x = f x (g x)

  let bind m k r = k (m r) r
end

type ('a, 'b) t = 'a -> 'b

let id = Fun.id

let compose f g x = f (g x)

let arr = Fun.id

let ( *** ) f g (x, y) = (f x, g y)

module Comonad (P : Monoid.MONOID) : Comonad.COMONAD = struct
  type 'a t = P.t -> 'a

  let map f t x = f (t x)

  let extract t = t P.empty

  let duplicate f m x = f (P.append m x)

  let extend f x = map f (duplicate x)
end
