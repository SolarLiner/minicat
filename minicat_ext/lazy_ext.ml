open Minicat

module LazyInput = struct
  type 'a t = 'a Lazy.t

  let map f x = lazy (f (Lazy.force x))

  let pure a = lazy a

  let app lf lx = lazy (Lazy.force lx |> Lazy.force lf)

  let bind m f : 'b t = Lazy.force m |> f

  let fail s = lazy (failwith s)

  let fold_right f (l : 'a t) (i : 'b) : 'b = f (Lazy.force l) i

  let extract = Lazy.force

  let extend f l = lazy (f l)
end

include Monad.Make (LazyInput)
include Foldable.Make (LazyInput)
include Comonad.Make (LazyInput)
