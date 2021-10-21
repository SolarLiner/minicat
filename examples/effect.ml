open Minicat_ext
open Minicat_ext.Effect

let prompt s : string Effect.t =
 fun () ->
  print_string s;
  read_line ()

let main =
  let> name = String.trim <$> prompt "Who are you ? " in
  let> location = String.trim <$> prompt "Where do you come from ? " in
  Effect.print
    (Printf.sprintf "Hello, %s! %s sure is lovely around this time!" name
       location)

let () = run main
