{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Python ---
    # python3 # Python 3 interpreter (commented out in original)
    isort # Python import sorter
    pyright # Type checker
    ruff # Fast Python formatter/linter
    poetry

    # --- Python with Packages ---
    (python3.withPackages (
      ps: with ps; [
        # --- Jupyter Core ---
        ipykernel # Python kernel for Jupyter
        jupyter # Jupyter notebook server
        jupyter-client # Required by molten.nvim for Jupyter communication

        # --- Molten.nvim Requirements ---
        cairosvg # Required for displaying plots/images as SVG
        kaleido # Optional - For static Plotly image export
        nbformat # Optional - For notebook format operations
        pillow # Required for displaying images (PNG, JPG, etc)
        plotly # Optional - For interactive Plotly charts
        pynvim # Required by molten.nvim - Neovim Python client
        pyperclip # Optional - For copying images to clipboard

        # --- Data Science Essentials ---
        matplotlib # Plotting library
        numpy # Numerical computing
        pandas # Data manipulation
        wcwidth # Terminal width calculations

        # --- Doom Emacs Requirements ---
        black # Python code formatter
        pyflakes # Python syntax checker and linter
        pipenv # Python dependency management tool
        pytest # Python testing framework
        grip # Preview READMEs from GitHub repos before committing

        # --- Formatters ---
        # mdformat # Markdown formatter
        # mdformat-frontmatter # Ensure frontmatter is respected
      ]
    ))
  ];
}
