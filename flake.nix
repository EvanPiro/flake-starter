{
  description = "Dev shell sandbox";
  inputs = {
    nixpkgs.url = "github:EvanPiro/nixpkgs";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    mkDevShell = import ./dev-shell.nix;
    systems = ["x86_64-linux" "x86_64-darwin"];
  in {
    devShells = {
      x86_64-linux.default = mkDevShell {
        inherit nixpkgs;
        system = "x86_64-linux";
      };
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
