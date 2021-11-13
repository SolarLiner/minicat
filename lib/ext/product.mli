open Minicat_core

module Make : functor (N : Num.NUM) -> Monoid.MONOID with type t = N.t
