module type FOLDABLE = sig
  type 'a t

  val fold_right : ('a -> 'b -> 'b) -> 'a t -> 'b -> 'b
end

module Make(F: FOLDABLE) = struct
  include F

  let null l = fold_right (fun _ _ -> false) l true
  let first l = fold_right(fun a -> function | None -> Some a | Some v -> Some v) l None
  let length l = fold_right (fun _ -> (+) 1) l 0
  let any pred l = fold_right(fun a -> (||) (pred a)) l false
  let all pred l = fold_right(fun a -> (&&) (pred a)) l true
end

module WithMonoid(F: FOLDABLE)(M: Monoid.MONOID) = struct
  module M = Monoid.Make(M)
  type t = M.t F.t

  let fold_map f l = F.fold_right (fun x -> M.append (f x)) l M.empty
  let fold = fold_map Fun.id
end

module WithNum(F: FOLDABLE)(N: Num.NUM) = struct
  type t = N.t F.t

  let sum l = F.fold_right N.add l (N.of_int 0)
  let product l = F.fold_right N.mul l (N.of_int 1)
end

module WithEq(F: FOLDABLE)(E: Eq.EQ) = struct
  module F = Make(F)
  type t = E.t F.t

  let elem el = F.any (E.equal el)
  let not_elem el = Fun.negate (elem el)
end

module WithOrd(F: FOLDABLE)(O: Ord.ORD) = struct
  module O = Ord.Make(O)
  module F = Make(F)
  type t = O.t F.t

  let min l = match F.first l with
  | None -> None
  | Some v -> Some (F.fold_right O.min l v)

  let max l = match F.first l with
  | None -> None
  | Some v -> Some (F.fold_right O.max l v)
end
