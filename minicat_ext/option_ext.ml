open Minicat

include Monad.Make (struct
  include Option

  let pure a = Some a

  let app fs xs = match (fs, xs) with Some f, Some x -> Some (f x) | _ -> None
end)

let fail _ = None