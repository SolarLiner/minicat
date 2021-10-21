module type FUNCTOR = sig
  type 'a t

  val map : ('a -> 'b) -> 'a t -> 'b t
end

module Make(F: FUNCTOR) = struct
  include F

  let (<$>) = map
  let (<$) f = map (Fun.const f)
  let (let$) xs f = f <$> xs
  let void xs = map (Fun.const ()) xs
end