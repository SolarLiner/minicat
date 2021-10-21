module type MONAD = sig
include Applicative.APPLICATIVE

val bind : 'a t -> ('a -> 'b t) -> 'b t
end

module type MONAD_FAIL = sig
include MONAD

val fail : string -> 'a t
end

module Make(M: MONAD) = struct
  include M
  include Applicative.Make(M)

  let return = pure

  let (let>) = bind
  let (>>=) = bind
  let (=<<) k m = m >>= k
  let (>>) m k = m >>= Fun.const k
  let join ms = let> m = ms in m

  module Fold(F: sig include Foldable.FOLDABLE include Cons.CONS with type 'a t := 'a t end) = struct
    let monad_map f xs =
      let k a r = F.cons <$> (f a) <*> r in
      F.fold_right k xs (pure F.empty)
    let sequence ms = monad_map Fun.id ms
  end

  include Fold(struct
    include List
    let empty = []
  end)
end