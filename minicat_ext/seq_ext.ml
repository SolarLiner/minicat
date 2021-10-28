include Seq

let pure a = Seq.cons a Seq.empty

let fail _ = Seq.empty

let app f xs = Seq.flat_map (fun f -> Seq.flat_map (fun x -> pure (f x)) xs) f

let bind m f = Seq.flat_map f m

let alt a b = Seq.concat (Seq.cons a (Seq.cons b empty))

let rec fold_right f l i =
  match l () with Seq.Nil -> i | Seq.Cons (x, xs) -> f x (fold_right f xs i)

let unfold_right = Seq.unfold