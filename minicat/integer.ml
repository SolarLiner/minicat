module type INTEGER = sig
  include Num.NUM

  include Ord.ORD with type t := t
end
