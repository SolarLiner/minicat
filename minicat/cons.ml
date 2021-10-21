module type CONS = sig
  type 'a t

  val empty : 'a t

  val cons : 'a -> 'a t -> 'a t
end

module Make (C : CONS) = Unfoldable.Make (struct
  include C

  let rec unfold_right f i =
    match f i with Some (v, n) -> cons v (unfold_right f n) | None -> empty
end)
