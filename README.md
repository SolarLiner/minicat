# minicat

Typing conventions for Ocaml modules that takes inspiration from Category Theory.

## Conventions

Module types are designed to closely match the naming conventions of the standard library, so that you can extend its modules easily, eg. `Functor.Make(List)`. As OCaml is light on operator definitions, module types do not require any operator definitions - instead aliases are made when calling the relevant `.Make` module functor.

Some module types go beyond what the standard library provides; for those, implementations are provided within `<Module>_ext` modules.
