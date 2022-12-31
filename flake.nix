{
  description = "Dev shell sandbox";
  inputs = {
    nixpkgs.url = "github:EvanPiro/nixpkgs";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    # Add supported systems
    systems = ["x86_64-darwin" "x86_64-linux"];
  in
    nixpkgs.lib.pipe systems [
      (builtins.map (system: let
        pkgs = nixpkgs.legacyPackages.${system}.pkgs;
      in {
        devShells.${system}.default = pkgs.mkShell {
          packages = with pkgs; [
            # Add packages from nixpkgs like the following:
            # postgresql
          ];
        };
        formatter.${system} = pkgs.alejandra;
      }))

      (builtins.foldl' nixpkgs.lib.recursiveUpdate {})
    ];
}
