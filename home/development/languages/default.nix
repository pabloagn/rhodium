# home/development/languages/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages;
in
{
  imports = [
    ./c.nix
    ./clojure.nix
    ./common-lisp.nix
    ./cpp.nix
    ./cs.nix
    ./css.nix
    ./dotnet.nix
    ./elixir.nix
    ./elm.nix
    ./erlang.nix
    ./fs.nix
    ./go.nix
    ./haskell.nix
    ./html.nix
    ./java.nix
    ./javascript.nix
    ./julia.nix
    ./kotlin.nix
    ./lua.nix
    ./nextjs.nix
    ./nix.nix
    ./nodejs.nix
    ./ocaml.nix
    ./python.nix
    ./r.nix
    ./reactjs.nix
    ./rust.nix
    ./scala.nix
    ./scheme.nix
    ./sql.nix
    ./swift.nix
    ./typescript.nix
    ./zig.nix
  ];

  options.rhodium.home.development.languages = {
    enable = mkEnableOption "Rhodium's development languages";
  };

  config = mkIf cfg.enable {
    rhodium.home.development.languages = {
      c = {
        enable = true;
        compilers = [
          pkgs.gcc
          pkgs.clang
        ];
        buildTools = [
          pkgs.gnumake
          pkgs.cmake
        ];
        languageServers = [
          pkgs.clang-tools
        ];
        linters = [
          pkgs.cppcheck
        ];
        debuggers = [
          pkgs.gdb
        ];
      };

      cpp = {
        enable = true;
        compilers = [
          pkgs.gcc
          pkgs.clang
        ];
        buildTools = [
          pkgs.gnumake
          pkgs.cmake
          pkgs.meson
          pkgs.ninja
        ];
        languageServers = [
          pkgs.clang-tools
        ];
        linters = [
          pkgs.cppcheck
        ];
        debuggers = [
          pkgs.gdb
          pkgs.lldb
        ];
      };

      go = {
        enable = true;
        compiler = [
          pkgs.go
        ];
        languageServers = [
          pkgs.gopls
        ];
        linters = [
          pkgs.golangci-lint
        ];
        formatters = [
          pkgs.gofumpt
          pkgs.goimports-reviser
        ];
        debuggers = [
          pkgs.delve
        ];
      };

      nix = {
        enable = true;
        languageServers = [
          pkgs.nil
        ];
        formatters = [
          pkgs.nixpkgs-fmt
          pkgs.alejandra
        ];
        utilityTools = [
          pkgs.cachix
          pkgs.nix-info
          pkgs.sbomnix
        ];
        analysisTools = [
          pkgs.statix
          pkgs.deadnix
          pkgs.nix-tree
          pkgs.nix-du
        ];
      };

      python = {
        enable = true;
        variants = [
          pkgs.python311
          pkgs.python312
        ];
        linters = [
          pkgs.ruff
          pkgs.mypy
          pkgs.debugpy
        ];
        packageManagers = [
          pkgs.poetry
          pkgs.pdm
        ];
        languageServers = [
          pkgs.pyright
        ];
      };

      rust = {
        enable = true;
        toolchain = pkgs.rustup;
        cargoTools = [
          pkgs.cargo-edit
          pkgs.cargo-watch
          pkgs.cargo-audit
          pkgs.cargo-outdated
          pkgs.cargo-expand
        ];
        formattersLinters = [
          pkgs.taplo-cli
        ];
      };
    };
  };
}
