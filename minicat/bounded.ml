(** Category of bounded types. *)
module type BOUNDED = sig
  type t
  (** Bounded type. *)

  val bound_min : t
  (** Lower bound of the type. *)

  val bound_max : t
  (** Higher bound of the type. *)

  val succ : t -> t
  (** [succ t] is the next value in the type. *)

  val pred : t -> t
  (** [pred t] is the previous value in the type. *)
end

module MakeUnfold (B : sig
  include BOUNDED

  include Eq.EQ with type t := t
end)
(U : Unfoldable.UNFOLDABLE) =
struct
  (** [range a b] unfolds a range of [B.t] starting from [a] and including every value up to (but not including) [b]. *)
  let range a b =
    let inner i =
      let open Eq.Make (B) in
      if i == b then None else Some (i, B.succ i)
    in
    U.unfold_right inner a

  (** [range_from a] unfolds a range of [B.t] from [a] to [B.bound_max]. *)
  let range_from a = range a B.bound_max

  (** [range_to a] unfolds a range of [B.t] from [B.bound_min] to [a]. *)
  let range_to = range B.bound_min
end

(** Make extra functions for [Bounded] using a [List]. This is a specialization of [MakeUnfold] used with [List]. *)module Make (B : sig
  include BOUNDED

  include Eq.EQ with type t := t
end) =
  MakeUnfold
    (B)
    (struct
      type 'a t = 'a list

      let rec unfold_right f i =
        match f i with None -> [] | Some (x, n) -> x :: unfold_right f n
    end)
