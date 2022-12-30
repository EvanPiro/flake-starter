{
  description = "Dev shell sandbox";
  inputs = {
    nixpkgs.url = "github:EvanPiro/nixpkgs";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    systems = ["x86_64-linux" "x86_64-darwin"];
  in {
    devShells = nixpkgs.lib.pipe systems [
      (builtins.map (system: {
        name = system;
        value = {
          default = let
            pkgs = nixpkgs.legacyPackages.${system}.pkgs;
          in
            pkgs.mkShell {
              packages = with pkgs; [
                postgresql
              ];
            };
        };
      }))
      builtins.listToAttrs
    ];

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
