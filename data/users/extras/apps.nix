{
  editors = {
    editor-instance = {
      binary = "ghostty";
      args = [ "-e" "hx" ];
      icon = "helix";
      description = "Editor";
    };
    helix-instance = {
      binary = "ghostty";
      args = [ "-e" "hx" ];
      icon = "helix";
      description = "Helix";
    };

    nvim-instance = {
      binary = "ghostty";
      args = [ "-e" "nvim" ];
      icon = "neovim";
      description = "Neovim";
    };
  };

  viewers = {
    image-viewer = {
      binary = "feh";
      args = [ "-Z" "--scale-down" "--auto-zoom" "--image-bg" "black" "%f" ];
      icon = "feh";
      description = "Image Viewer";
    };
  };
}
