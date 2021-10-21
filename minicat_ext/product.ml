open Minicat

module Product (N : Num.NUM) = struct
  open Num.Make (N)

  let empty = of_int 1

  let append = ( * )
end
