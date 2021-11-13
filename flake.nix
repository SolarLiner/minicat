{
  description = "System environment for Minicat";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: with flake-utils.lib; eachSystem allSystems (system:
    let
      pkgs = import nixpkgs { inherit system; };
      meta = with pkgs.lib; {
        homepage = "https://github.com/SolarLiner/minicat";
        description = "Category theory interfaces for OCaml";
        license = licenses.mit;
      };
    in
    {
      packages.minicat = pkgs.ocamlPackages.buildDunePackage {
        pname = "minicat";
        version = "1.0.0";
        src = ./.;
        useDune2 = true;
        inherit meta;
      };
      defaultPackage = self.packages.minicat;
    });
}
