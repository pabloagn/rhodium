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

    zeditor-instance = {
      binary = "zeditor";
      args = [ ];
      icon = "zeditor";
      description = "Zeditor";
    };

    code-instance = {
      binary = "code";
      args = [ ];
      icon = "code";
      description = "VS Code";
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

  productivity = {
    onepassword = {
      binary = "1password";
      args = [ "--force-device-scale-factor=1.5" ];
      icon = "onepassword";
      description = "1Password";
    };

    zen = {
      binary = "zen";
      args = [ ];
      icon = "zen";
      description = "Zen Browser";
    };

  };
}
