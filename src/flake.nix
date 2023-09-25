{
  nixConfig = {
    extra-substituters = "https://anmonteiro.nix-cache.workers.dev";
    extra-trusted-public-keys = "ocaml.nix-cache.com-1:/xI2h2+56rwFfKyyFVbkJSeGqSIYMC/Je+7XXqGKDIY=";
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    ocaml-overlay.url = "path:/Users/bbennett37/code/personal/ocaml-nix-overlays";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ocaml-overlay }: flake-utils.lib.eachDefaultSystem (system:
    let pkgs = import nixpkgs {
      inherit system;
      overlays = [
        ocaml-overlay.overlays.default
      ];
    }; in
    {
      devShell = pkgs.mkShell {
        packages = with pkgs.ocaml-ng.ocamlPackages_5_1; [
          ocaml
          dune_3
          ocaml-lsp
          findlib
          melange
          reason
          opium
          atdgen
          atdgen-runtime
          atdgen-codec-runtime
          melange-atdgen-codec-runtime
          # restorative
        ];
      };
    });
}
