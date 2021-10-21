module type BOUNDED = sig
  type t

  val bound_min : t
  val bound_max : t
end