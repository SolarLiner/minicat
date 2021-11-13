(** Type of container values that can be constructed "right to left" one value at a time, like [List]. *)
module type CONS = sig
  type 'a t
  (** Container type that can be constructed value by value. *)

  val empty : 'a t
  (** Empty container value *)

  val cons : 'a -> 'a t -> 'a t
  (** [cons x xs] constructs a new ['a t] by prepending [x] to [xs]. *)
end

module Make (C : CONS) = Unfoldable.Make (struct
  include C

  let rec unfold_right f i =
    match f i with Some (v, n) -> cons v (unfold_right f n) | None -> empty
end)
