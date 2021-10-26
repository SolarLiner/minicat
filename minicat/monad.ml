(** A monad is an abstraction over Continuation Passing style of computation.
    It is also very useful in representing "impure" function by highlighting the
    type of effects the function requires to be executed. *)
module type MONAD = sig
  include Applicative.APPLICATIVE

  val bind : 'a t -> ('a -> 'b t) -> 'b t
  (** [bind m f] computes m, takes its result and applies it to [m]. *)
end

module Make (M : MONAD) = struct
  include M
  include Applicative.Make (M)

  (** Alias of [Applicative.APPLICATIVE.pure] for those who are too familiar with Haskell ;) *)
  let return = pure

  (** [let> x = m in ...] binds the result of [m] to [x]. It is strictly equivalent of [m >>= (fun x -> ...)] but offers nicer
      syntax within OCaml. *)
  let ( let> ) = bind

  (** Maybe the most infamous functional programming operator, defined as an alias to [M.bind]. *)
  let ( >>= ) = bind

  (** [x =<< m] is [m >>= x] with arguments flipped. *)
  let ( =<< ) k m = m >>= k

  (** [a >> b] disregards the result of computing [a], then runs computation [b]. *)
  let ( >> ) m k = m >>= Fun.const k

  (** [join ms] flattens a level of monads. It can be seen as a "concatenation" of the monad. *)
  let join ms =
    let> m = ms in
    m

  (** Functions using a [Foldable] type as part of their computation. A specialization using [List] is included in the module, generated from this module functor. *)
  module Fold (F : sig
    include Foldable.FOLDABLE

    include Cons.CONS with type 'a t := 'a t
  end) =
  struct
    (** Map monads, much like [Functor.FUNCTOR.map], but ensures order of computation. *)
    let monad_map f xs =
      let k a r = F.cons <$> f a <*> r in
      F.fold_right k xs (pure F.empty)

    (** [sequence ms] runs all computations in [ms] in sequence, returning all results. *)
    let sequence ms = monad_map Fun.id ms
  end

  include Fold (struct
    include List

    let empty = []
  end)
end
