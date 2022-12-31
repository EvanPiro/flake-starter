{
  description = "Dev shell sandbox";
  inputs = {
    nixpkgs.url = "github:EvanPiro/nixpkgs";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    systems = ["x86_64-darwin" "x86_64-linux"];
  in
    nixpkgs.lib.pipe systems [
      (builtins.map (system: {
        devShells.${system}.default = with nixpkgs.legacyPackages.${system}.pkgs;
          pkgs.mkShell {
            packages = with pkgs; [
              postgresql
            ];
          };
      }))

      (builtins.foldl' nixpkgs.lib.recursiveUpdate {
       # formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
      })
    ];
}
