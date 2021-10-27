include Minicat.Monad.MONAD with type 'a t = 'a Seq.t

include Minicat.Alternative.ALTERNATIVE with type 'a t := 'a t

include Minicat.Foldable.FOLDABLE with type 'a t := 'a t

include Minicat.Unfoldable.UNFOLDABLE with type 'a t := 'a t