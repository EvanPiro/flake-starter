{
  description = "Dev shell sandbox";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    # Add supported systems
    systems = ["x86_64-darwin" "x86_64-linux"];
    mkDevShell = import ./shell.nix;
  in
    nixpkgs.lib.pipe systems [
      (builtins.map (system: let
        pkgs = nixpkgs.legacyPackages.${system}.pkgs;
      in {
        # Add set conforming to flake schema here:
        devShells.${system}.default = mkDevShell pkgs;
        formatter.${system} = pkgs.alejandra;
        checks.${system}.default = pkgs.nixosTest {
          name = "flake test";
          nodes = {
            node1 = {...}: {
              # enable server here
            };
          };
          testScript = ''
            machin.succeed('please add test') || fail
          '';
        };
      }))

      (builtins.foldl' nixpkgs.lib.recursiveUpdate {})
    ];
}
