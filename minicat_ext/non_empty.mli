include Minicat.Monad.MONAD

include Minicat.Comonad.COMONAD with type 'a t := 'a t

include Minicat.Foldable.FOLDABLE with type 'a t := 'a t

val of_list' : 'a list -> 'a t option

val of_list : 'a list -> 'a t

val head : 'a t -> 'a

val tail : 'a t -> 'a list