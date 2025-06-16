{...}: {
  programs.zed-editor = {
    userSettings = {
      languages = {
        Python = {
          tab_size = 4;
          formatter = "language_server";
          format_on_save = "on";
        };

        Lua = {
          tab_size = 2;
          formatter = "language_server";
          format_on_save = "on";
        };

        Nix = {
          language_servers = ["nil"];
          formatter.external = {
            command = "nixpkgs-fmt";
            arguments = [];
          };
          format_on_save = "on";
        };
      };

      lsp.nil = {
        binary.path = "nil";
        binary.arguments = [];
      };
    };
  };
}
