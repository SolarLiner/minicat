open Minicat

module Product (N : Num.NUM) = struct
  open Num.Make (N)

  let empty = one

  let append = ( * )
end
