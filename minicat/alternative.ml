module type ALTERNATIVE = sig
  include Applicative.APPLICATIVE

  val empty : 'a t

  val alt : 'a t -> 'a t -> 'a t
end

module Make (A : ALTERNATIVE) = struct
  include A
  include Applicative.Make (A)

  module Fold (F : sig
    include Foldable.FOLDABLE

    include Cons.CONS with type 'a t := 'a t
  end) =
  struct
    let ( <|> ) = alt

    let rec many v = List.cons <$> v <*> many v

    let many1 v = many v <|> pure []
  end

  include Fold (struct
    include List

    let empty = []
  end)
end
