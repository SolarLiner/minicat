type 'a t = Elem of 'a * 'a list

let of_list' = function [] -> None | x :: xs -> Some (Elem (x, xs))

let of_list l =
  match of_list' l with
  | None -> failwith "Cannot create a NonEmpty from an empty list"
  | Some el -> el

let to_list (Elem (x, xs)) = x :: xs

let map f (Elem (x, xs)) = Elem (f x, List.map f xs)

let pure a = Elem (a, [])

let app (Elem (f, fs)) (Elem (x, xs)) = Elem (f x, List_ext.app fs xs)

let rec bind (Elem (x, xs)) f =
  let (Elem (x', xs')) = f x in
  match of_list' xs with
  | None -> Elem (x', [])
  | Some l -> Elem (x', xs' @ to_list (bind l f))

let fold_right f (Elem (x, xs)) i = f x (List.fold_right f xs i)

let head (Elem (x, _)) = x

let tail (Elem (_, xs)) = xs

let extract = head

let extend f (xs : 'a t) = pure (f xs)
