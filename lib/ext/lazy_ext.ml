type 'a t = 'a Lazy.t

let empty = lazy (failwith "empty")

let fail s = lazy (failwith s)

let map f x = lazy (f (Lazy.force x))

let pure a = lazy a

let app lf lx = lazy (Lazy.force lx |> Lazy.force lf)

let bind m f : 'b t = Lazy.force m |> f

let alt a b = lazy (try Lazy.force a with _ -> Lazy.force b)

let fold_right f (l : 'a t) (i : 'b) : 'b = f (Lazy.force l) i

let extract = Lazy.force

let extend f l = lazy (f l)
