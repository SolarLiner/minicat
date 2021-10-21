(** Alternative functors are [Applicative] functors that can combine themselves. They can be seen as the [Monoid] of container types. *)
module type ALTERNATIVE = sig
  include Applicative.APPLICATIVE

  (** Empty container value. *)
  val empty : 'a t

  (** An alternative binary operation. *)
  val alt : 'a t -> 'a t -> 'a t
end

module Make (A : ALTERNATIVE) = struct
  include A
  include Applicative.Make (A)

  (** Operator alias of [A.alt]. *)
  let ( <|> ) = alt

  (** Module functors of functions that use a [Foldable] type. A specialized version is included in the parent module generated with [List] from this module functor. *)
  module Fold (F : sig
    include Foldable.FOLDABLE

    include Cons.CONS with type 'a t := 'a t
  end) =
  struct

    (** Return zero or more results from this action. *)
    let rec many v = F.cons <$> v <*> many v

    (** Return one of more results from this action. *)
    let many1 v = many v <|> pure F.empty
  end

  include Fold (struct
    include List

    let empty = []
  end)
end
