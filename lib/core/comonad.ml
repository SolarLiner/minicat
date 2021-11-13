module type COMONAD = sig
  include Functor.FUNCTOR

  val extract : 'a t -> 'a

  val extend : ('a t -> 'b) -> 'a t -> 'b t
end

module Make (W : COMONAD) = struct
  include W
  include Functor.Make (W)

  let duplicate w = W.extend Fun.id w

  let ( <<= ) = W.extend

  let ( =>> ) x f = f <<= x

  let ( let= ) = ( =>> )
end
