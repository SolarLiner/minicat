(** A monoid is a [Semigroup] that has a starting "empty" value. *)
module type MONOID = sig
  include Semigroup.SEMIGROUP

  val empty : t
end

module Make (M : MONOID) = struct
  include M
  include Semigroup.Make (M)

  (** Functions used cojointly with a [Foldable] type. *)
  module Fold (F : Foldable.FOLDABLE) = struct
    type t = M.t F.t

    (** Map values onto [M.t] before folding them *)
    let fold_map f xs = F.fold_right (fun a -> M.append (f a)) xs M.empty

    (** Fold [M.t] values into a single one by starting with [M.empty] and successfully combining them with [M.append]. *)
    let fold = fold_map Fun.id
  end

  include Fold (List)
end
