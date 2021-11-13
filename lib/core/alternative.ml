(** Alternative monads are monads that can select between two choices or else recover from a fail state. They can be seen as the [Monoid] of container types. *)
module type ALTERNATIVE = sig
  include Monad.MONAD

  val empty : 'a t
  (** Empty container value. *)

  val fail : string -> 'a t
  (** Fail within the monad. This can be set to [Fun.const empty] raising exceptions is not explicitely supported (and instead relies on a sentinel value to detect errors) *)

  val alt : 'a t -> 'a t -> 'a t
  (** An alternative binary operation. *)
end

module Make (A : ALTERNATIVE) = struct
  include A
  include Monad.Make (A)

  (** Operator alias of [A.alt]. *)
  let ( <|> ) = alt

  let guard ?message:m pred =
    let* c = pred in
    if c then return ()
    else
      fail
        (match m with
        | Some m -> "Guard triggered: " ^ m
        | None -> "Guard triggered")

  let opt x = x <|> A.empty

  let choice xs = List.fold_right alt xs empty

  (** Module functors of functions that use a [Foldable] type. A specialized version is included in the parent module generated with [List] from this module functor. *)
  module Fold (F : sig
    include Foldable.FOLDABLE

    include Cons.CONS with type 'a t := 'a t
  end) =
  struct
    (** Return zero of more results from this action. *)
    let rec many v = many1 v <|> pure F.empty

    (** Return one or more results from this action. *)
    and many1 v =
      let* r = v in
      let* rs = many v in
      return (F.cons r rs)

    let anyof vs = F.fold_right ( <|> ) vs empty
  end

  include Fold (struct
    include List

    let empty = []
  end)
end
