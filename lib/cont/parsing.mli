open Minicat_core

include Monad.MONAD

include Alternative.ALTERNATIVE with type 'a t := 'a t

type stream

type offset = int

type 'a reply

val parse : 'a t -> char Lazylist.t -> ('a, string * int) result

val parse_string : 'a t -> string -> ('a, string * int) result

val parse_file : 'a t -> string -> ('a, string * int) result

val parse_raw : 'a t -> char Lazylist.t -> 'a reply

val fix : ('a t -> 'a t) -> 'a t

val eof : unit t

val any : char t

val peek : char t

val advance : int -> unit t

val span : 'a t -> ('a * string) t

val where : ('a -> bool) -> 'a t -> 'a t

val label : string -> 'a t -> 'a t

val ( <?> ) : 'a t -> string -> 'a t

module WithOrd (O : Ord.ORD) : sig
  val elem : O.t -> O.t t -> O.t t
end

val char : char -> char t

val keyword : string -> string t

val loweralpha : char t

val upperalpha : char t

val alpha : char t

val digit : char t

val alphanum : char t

val space : char t

val token : 'a t -> 'a t

val surround : 'x t -> 'x t -> 'a t -> 'a t

module Expr : sig
  type assoc = Left | Right | NoAssoc

  type 'a operator =
    | Prefix of ('a -> 'a) t
    | Postfix of ('a -> 'a) t
    | Infix of ('a -> 'a -> 'a) t * assoc

  type 'a expr_table = 'a operator list list

  val build : 'a expr_table -> 'a t -> 'a t
end