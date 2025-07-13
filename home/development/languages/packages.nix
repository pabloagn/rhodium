{pkgs, ...}: {
  home.packages = with pkgs; [
    (python3.withPackages (ps:
      with ps; [
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

        # Doom Emacs Reqs
        black
        pyflakes
        pipenv
        pytest
      ]))
  ];
}
