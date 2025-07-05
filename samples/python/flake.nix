{
  description = "Python data science environment with numpy, pandas, etc.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        # Python with all the data science packages
        pythonEnv = pkgs.python311.withPackages (ps: with ps; [
          # Core scientific computing
          numpy
          scipy
          pandas
          polars
          
          # Visualization
          matplotlib
          seaborn
          plotly
          bokeh
          altair
          
          # Machine Learning
          scikit-learn
          xgboost
          lightgbm
          
          # Statistics
          statsmodels
          
          # Jupyter ecosystem
          jupyter
          jupyterlab
          ipython
          ipykernel
          ipywidgets
          
          # Data processing
          openpyxl
          xlrd
          pyarrow
          fastparquet
          
          # Development tools
          black
          flake8
          mypy
          pytest
          pytest-cov
          
          # Additional useful packages
          requests
          beautifulsoup4
          lxml
          tqdm
          click
          rich
          
          # Optional: Deep learning (uncomment if needed)
          # torch
          # torchvision
          # tensorflow
        ]);
        
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Python environment
            pythonEnv
            
            # System dependencies that some packages might need
            pkg-config
            libffi
            openssl
            
            # For numpy/scipy compilation if needed
            blas
            lapack
            gfortran
            
            # Other useful tools
            git
            curl
            which
            
            # Optional: R for mixed workflows
            # R
            # rPackages.ggplot2
            # rPackages.dplyr
          ];
          
          shellHook = ''
            echo "🐍 Python Data Science Environment Loaded!"
            echo "Python version: $(python --version)"
            echo "NumPy version: $(python -c 'import numpy; print(numpy.__version__)')"
            echo "Pandas version: $(python -c 'import pandas; print(pandas.__version__)')"
            echo ""
            echo "Available tools:"
            echo "  - jupyter lab (start with: jupyter lab)"
            echo "  - python (interactive Python)"
            echo "  - ipython (enhanced Python shell)"
            echo ""
            echo "Key packages installed:"
            echo "  NumPy, Pandas, Polars, Matplotlib, Seaborn, Scikit-learn"
            echo "  Plotly, Bokeh, SciPy, Statsmodels, XGBoost, LightGBM"
            
            # Set up matplotlib backend for headless environments
            export MPLBACKEND=Agg
            
            # Ensure Python can find packages
            export PYTHONPATH="${pythonEnv}/${pythonEnv.sitePackages}:$PYTHONPATH"
          '';
        };
        
        # Optional: Create a package for your project
        packages.default = pkgs.python311Packages.buildPythonApplication {
          pname = "data-science-project";
          version = "0.1.0";
          
          src = ./.;
          
          propagatedBuildInputs = with pkgs.python311Packages; [
            numpy
            pandas
            matplotlib
            # Add your specific dependencies here
          ];
          
          # If you have a setup.py or pyproject.toml
          # format = "pyproject";
        };
      });
}
