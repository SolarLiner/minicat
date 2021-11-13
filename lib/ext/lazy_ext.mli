open Minicat_core

include Monad.MONAD with type 'a t = 'a Lazy.t

include Alternative.ALTERNATIVE with type 'a t := 'a t

include Foldable.FOLDABLE with type 'a t := 'a t

include Comonad.COMONAD with type 'a t := 'a t