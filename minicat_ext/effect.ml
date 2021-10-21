include Fun_ext.MakeMonad (Unit)

let run eff = eff ()

let print s () = print_endline s

let put s () = print_string s

let read = read_line

let fail s () = failwith s
