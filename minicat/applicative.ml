module type APPLICATIVE = sig
  include Functor.FUNCTOR

  val pure : 'a -> 'a t
  val app : ('a -> 'b) t -> 'a t -> 'b t
end

module Make(A: APPLICATIVE) = struct
  include A
  include Functor.Make(A)

  let (<*>) = app
  let ( *> ) a b = (Fun.id <$ a) <*> b
  let ( <* ) a b = Fun.const <$> a <*> b
  let (-->) p a = if p then a else pure ()
  let rec forever ap = ap *> forever ap
end