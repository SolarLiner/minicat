open Minicat
include Cons.Make (Seq)

include Monad.Make (struct
  include Seq

  let pure a = Seq.cons a Seq.empty

  let app f xs = Seq.flat_map (fun f -> Seq.flat_map (fun x -> pure (f x)) xs) f

  let bind m f = Seq.flat_map f m
end)

include Foldable.Make (struct
  include Seq

  let rec fold_right f l i =
    match l () with Seq.Nil -> i | Seq.Cons (x, xs) -> f x (fold_right f xs i)
end)

include Unfoldable.Make (struct
  include Seq

  let unfold_right = Seq.unfold
end)
