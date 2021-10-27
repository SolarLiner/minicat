include List

let empty = []

let pure a = [ a ]

let rec app fs xs =
  match (fs, xs) with
  | f :: fs, x :: xs -> f x :: app fs xs
  | [], _ | _, [] -> []

let rec bind xs f = match xs with x :: xs -> f x @ bind xs f | [] -> []

let rec unfold_right f i =
  match f i with Some (r, n) -> r :: unfold_right f n | None -> []

let fail _ = []

let alt a b = List.concat [ a; b ]

let extract = List.hd

let extend f (xs : 'a t) = pure (f xs)
