{
  description = "Dev shell sandbox";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:EvanPiro/nixpkgs";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        # Enter dependencies here. Example:
        # postgresql
      ];
    };
    formatter.${system} = pkgs.alejandra;
  };
}
