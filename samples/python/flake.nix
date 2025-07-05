{
  description = "Rhodium's Python Data Science Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    uv2nix = {
      url = "github:pyproject-nix/uv2nix";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pyproject-build-systems = {
      url = "github:pyproject-nix/build-system-pkgs";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.uv2nix.follows = "uv2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    uv2nix,
    pyproject-nix,
    pyproject-build-systems,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (nixpkgs) lib;

      pythonEnv = pkgs.python311.withPackages (ps:
        with ps; [
          numpy
          scipy
          pandas
          matplotlib
          seaborn
          jupyter
          jupyterlab
          ipython
          ipykernel
          ipywidgets
          openpyxl
          # xlrd
          # pyarrow
          # fastparquet
          # ruff
          # flake8
          # mypy
          # pytest
          # pytest-cov
          # requests
          # beautifulsoup4
          # lxml
          # tqdm
          # click
          # rich
        ]);

      uvWorkspace =
        if builtins.pathExists ./uv.lock
        then uv2nix.lib.workspace.loadWorkspace {workspaceRoot = ./.;}
        else null;

      uvOverlay =
        if uvWorkspace != null
        then uvWorkspace.mkPyprojectOverlay {sourcePreference = "wheel";}
        else (_final: _prev: {});

      pyprojectOverrides = _final: _prev: {};

      uvPythonSet =
        if uvWorkspace != null
        then
          (pkgs.callPackage pyproject-nix.build.packages {
            python = pkgs.python311;
          }).overrideScope
          (lib.composeManyExtensions [
            pyproject-build-systems.overlays.default
            uvOverlay
            pyprojectOverrides
          ])
        else null;

      uvEnvironment =
        if uvPythonSet != null
        then uvPythonSet.mkVirtualEnv "ds-uv-env" uvWorkspace.deps.default
        else null;
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs;
          [
            pythonEnv
            pkg-config
            libffi
            openssl
            blas
            lapack
            gfortran
            git
            curl
            which
            uv
          ]
          ++ lib.optionals (uvEnvironment != null) [uvEnvironment];

        env =
          {
            UV_PYTHON_DOWNLOADS = "never";
            UV_PYTHON = "${pkgs.python311}/bin/python";
            MPLBACKEND = "Agg";
          }
          // lib.optionalAttrs pkgs.stdenv.isLinux {
            LD_LIBRARY_PATH = lib.makeLibraryPath pkgs.pythonManylinuxPackages.manylinux1;
          };

        shellHook = ''unset PYTHONPATH'';
      };
    });
}
