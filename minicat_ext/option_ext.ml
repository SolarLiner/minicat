include Option

let empty = None

let pure a = Some a

let app fs xs = match (fs, xs) with Some f, Some x -> Some (f x) | _ -> None

let alt a b =
  match (a, b) with Some x, _ -> Some x | None, Some x -> Some x | _ -> None

let fail _ = None

let fold_right f opt i = match opt with Some x -> f x i | None -> i
