open Minicat

module MakeInner(M: Monad.MONAD) = struct
  open Monad.Make(M)
  type ('a, 'b) kleisli = K of ('a -> 'b M.t)
  type ('a, 'b) t = ('a, 'b) kleisli

  let id = K return
  let compose (K f) (K g) = K (fun x -> (g x) >>= f)
  let arr f = K (fun x -> f x |> M.pure)
  let ( *** ) (K f) (K g) = K (fun (x,y) ->
    let> x' = f x in
    let> y' = g y in
    pure (x', y'))
end

module Make(M: Monad.MONAD) = struct 
  open MakeInner(M)
  include Arrow.Make(MakeInner(M))

  let make f = K f
  let run (K f) x = f x
end

module MakeMonad(M: Monad.MONAD)(A: sig type t end) = Monad.Make(struct
  module K = MakeInner(M)

  type 'a t = (A.t, 'a) K.t

  let pure (a:'a) : 'a t = K.K (fun (_:A.t) -> (M.pure a))
  let map f (K.K k) : 'b t = K.K (fun x -> k x |> M.map f)
  let app (K.K f) (K.K k): 'b t = K.K (fun x -> k x |> M.app (f x))
  let bind (K.K f) k : 'b t =
    let open Monad.Make(M) in
    let kinner x =
      let> a = f x in
      let (K.K k') = k a in
      k' x
    in K kinner
end)