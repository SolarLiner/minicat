(** Container types that can be "unfolded", that is, created from recursively running a generator function. *)
module type UNFOLDABLE = sig
  type 'a t
  (** unfoldable ontainer type*)

  val unfold_right : ('b -> ('a * 'b) option) -> 'b -> 'a t
  (** [unfold_right f x] constructs a new ['a t] by successively applying [f] to the last value returned (or the initial value on first iteration).
      The function can signal it is finished by returning [None]. *)
end

module Make (U : UNFOLDABLE) = struct
  include U

  (** [iterate f xs] constructs an ['a t] of infinite size by applying [f] onto itself forever. *)
  let iterate f s = unfold_right (fun n -> Some (n, f n)) s

  (** [repeat x] constructs an ['a t] of infinite size containing nothing but [x] over and over again. *)
  let repeat x = unfold_right (fun _ -> Some (x, ())) ()
end
