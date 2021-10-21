module type MONOID = sig
include Semigroup.SEMIGROUP

val empty : t
end

module Make(M: MONOID) = struct
  include M
  include Semigroup.Make(M)

  let concat xs = List.fold_right append xs empty
end
