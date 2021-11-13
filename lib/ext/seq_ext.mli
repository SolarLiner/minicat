include Minicat_core.Monad.MONAD with type 'a t = 'a Seq.t

include Minicat_core.Alternative.ALTERNATIVE with type 'a t := 'a t

include Minicat_core.Foldable.FOLDABLE with type 'a t := 'a t

include Minicat_core.Unfoldable.UNFOLDABLE with type 'a t := 'a t

include Minicat_core.Cons.CONS with type 'a t := 'a t