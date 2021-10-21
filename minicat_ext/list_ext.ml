open Minicat

include Monad.Make(struct
include List

let pure a = [a]
let rec app fs xs = match fs, xs with
| f::fs, x::xs -> (f x)::app fs xs
| [], _ | _, [] -> []
let rec bind xs f = match xs with
| x::xs -> f x @ bind xs f
| [] -> []
end)

include Foldable.Make(List)