(** Applicative functors allow working with contained functions, such that they can be applied to values within other container of the same type. *)
module type APPLICATIVE = sig
  include Functor.FUNCTOR

  val pure : 'a -> 'a t
  (** [pure x] places a single value [x] into the container type. *)

  val app : ('a -> 'b) t -> 'a t -> 'b t
  (** [app fs xs] applies the function values contained in [fs] to values contained in [xs]. *)
end

module Make (A : APPLICATIVE) = struct
  include A
  include Functor.Make (A)

  (** Operator alias*)
  let ( <*> ) = app

  let ( *> ) a b = Fun.id <$ a <*> b

  let ( <* ) a b = Fun.const <$> a <*> b

  let ( --> ) p a = if p then a else pure ()

  let rec forever ap = ap *> forever ap
end
