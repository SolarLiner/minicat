module type ARROW = sig
  include Category.CATEGORY

  val arr : ('a -> 'b) -> ('a, 'b) t

  val ( *** ) : ('a, 'b) t -> ('c, 'd) t -> ('a * 'c, 'b * 'd) t
end

module Make (A : ARROW) = struct
  include A
  include Category.Make (A)

  let first a = a *** id

  let second a = id *** a

  let ( &&& ) f g = arr (fun b -> (b, b)) >>> f *** g
end
