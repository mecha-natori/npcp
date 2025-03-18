{
  inputs = {
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts";
    };
    git-hooks = {
      inputs = {
        flake-compat.follows = "";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems = {
      flake = false;
      url = "github:nix-systems/default";
    };
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix";
    };
  };
  outputs =
    inputs@{
      flake-parts,
      git-hooks,
      systems,
      treefmt-nix,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        git-hooks.flakeModule
        treefmt-nix.flakeModule
      ];
      perSystem =
        { config, pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            shellHook = ''
              ${config.pre-commit.installationScript}
            '';
          };
          pre-commit = {
            check.enable = true;
            settings = {
              hooks = {
                editorconfig-checker = {
                  enable = true;
                  excludes = [
                    "flake.lock"
                  ];
                };
                markdownlint = {
                  enable = true;
                  settings.configuration.MD013 = false;
                };
                treefmt = {
                  enable = true;
                  package = config.treefmt.build.wrapper;
                };
              };
              src = ./.;
            };
          };
          treefmt.programs = {
            mdformat = {
              enable = true;
              package = pkgs.mdformat.withPlugins (
                ps: with ps; [
                  mdformat-gfm
                ]
              );
              settings = {
                end-of-line = "lf";
                number = true;
                wrap = 80;
              };
            };
            nixfmt.enable = true;
          };
        };
      systems = import systems;
    };
}
