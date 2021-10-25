open Minicat

module MonadList = Monad.Make (struct
  include List

  let pure a = [ a ]

  let rec app fs xs =
    match (fs, xs) with
    | f :: fs, x :: xs -> f x :: app fs xs
    | [], _ | _, [] -> []

  let rec bind xs f = match xs with x :: xs -> f x @ bind xs f | [] -> []
end)

include MonadList

include Alternative.Make (struct
  include MonadList

  let empty = []

  let alt a b = List.concat [ a; b ]
end)

include Foldable.Make (List)
