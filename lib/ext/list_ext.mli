open Minicat_core

include Monad.MONAD with type 'a t = 'a list

include Comonad.COMONAD with type 'a t := 'a t

include Alternative.ALTERNATIVE with type 'a t := 'a t

include Foldable.FOLDABLE with type 'a t := 'a t

include Unfoldable.UNFOLDABLE with type 'a t := 'a t