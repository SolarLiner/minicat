module type INTEGER = sig
  include Num.NUM

  include Ord.ORD with type t := t

  val quotrem : t -> t -> t * t
  (** Simulatenous calculation of the quotient and remainder operations. *)

  val to_string : t -> string
  (** String representation of number, such that [to_string x |> of_string === x]. *)
end

module Make (I : INTEGER) = struct
  include I
  include Num.Make (I)
  include Ord.Make (I)

  (** [divmod n d] is the simulatenous truncating divition and modulo operation. *)
  let divmod n d =
    let ((q, r) as qr) = quotrem n d in
    if signum r == neg (signum d) then (q - one, r + d) else qr

  (** [quot n d] returns the quotient of the Euclidean division. *)
  let quot a b =
    let x, _ = I.quotrem a b in
    x

  (** [rem n d] returns the remainder of the Euclidean division. *)
  let rem a b =
    let _, x = I.quotrem a b in
    x

  (** [div n d] performs a division truncating towards -infinity. *)
  let div a b =
    let q, _ = divmod a b in
    q

  (** [n % d] performs the integer modulo operation, such that [(div n d) * d + (n % d) == n]*)
  let ( % ) a b =
    let _, r = divmod a b in
    r

  (** Returns the greatest common denominator between two [Integer] values. *)
  let rec gcd a b = if b == zero then a else gcd b (a % b)

  let lcm a b =
    if b == zero || a == zero then zero else abs (quot a (gcd a b) * b)
end