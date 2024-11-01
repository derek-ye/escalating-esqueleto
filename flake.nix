{
  description = "Escalating Esqueleto";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = inputs:
    let
      overlay = final: prev: {
        haskell = prev.haskell // {
          packageOverrides = hfinal: hprev:
            prev.haskell.packageOverrides hfinal hprev // {
              escalating-esqueleto = hfinal.callCabal2nix "escalating-esqueleto" ./. { };
            };
        };
        escalating-esqueleto = final.haskell.lib.compose.justStaticExecutables final.haskellPackages.escalating-esqueleto;
      };
      perSystem = system:
        let
          pkgs = import inputs.nixpkgs { inherit system; overlays = [ overlay ]; };
          hspkgs = pkgs.haskellPackages;
        in
        {
          devShell = hspkgs.shellFor {
            withHoogle = true;
            packages = p: [ p.escalating-esqueleto ];
            buildInputs = [
              hspkgs.cabal-install
              hspkgs.hlint
              pkgs.bashInteractive
              pkgs.pcre
              pkgs.postgresql
            ];
          };
          defaultPackage = pkgs.escalating-esqueleto;
        };
    in
    { inherit overlay; } //
      inputs.flake-utils.lib.eachDefaultSystem perSystem;
}
