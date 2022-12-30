{
  system,
  nixpkgs,
}: let
  pkgs = nixpkgs.legacyPackages.${system}.pkgs;
in
  pkgs.mkShell {
    packages = with pkgs; [postgresql];
  }
