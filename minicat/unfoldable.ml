module type UNFOLDABLE = sig
  type 'a t

  val unfold_right : ('b -> ('a * 'b) option) -> 'b -> 'a t
end

module Make(U: UNFOLDABLE) = struct
include U

let iterate f s = unfold_right (fun n -> Some (n, f n)) s

let repeat x = unfold_right (fun _ -> Some (x, ())) ()
end