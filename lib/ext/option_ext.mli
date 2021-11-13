open Minicat_core

include Monad.MONAD with type 'a t = 'a option

include Alternative.ALTERNATIVE with type 'a t := 'a t

include Foldable.FOLDABLE with type 'a t := 'a t