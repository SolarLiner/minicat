module type CATEGORY = sig
  type ('a, 'b) t

  val id : ('a, 'a) t
  val compose : ('b, 'c) t -> ('a, 'b) t -> ('a, 'c) t
end

module Make(C: CATEGORY) = struct
  include C

  let (<<<) = compose
  let (>>>) a b = b <<< a
end