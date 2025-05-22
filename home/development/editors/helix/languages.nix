# home/development/editors/helix/languages.nix

{ pkgs }:
let
  # Helper to check if a package exists
  hasPackage = name: pkgs ? ${name};

  # Conditional formatter based on package availability
  mkFormatter = cmd: args:
    if hasPackage cmd
    then { command = cmd; inherit args; }
    else null;

  # Language server definitions
  languageServers = {
    rust-analyzer = {
      command = "rust-analyzer";
      enabled = hasPackage "rust-analyzer";
    };

    metals = {
      command = "metals";
      enabled = hasPackage "metals";
    };

    gopls = {
      command = "gopls";
      enabled = hasPackage "gopls";
    };

    pyright = {
      command = "pyright-langserver";
      args = [ "--stdio" ];
      enabled = hasPackage "pyright";
    };

    texlab = {
      command = "texlab";
      enabled = hasPackage "texlab";
    };

    nil = {
      command = "nil";
      enabled = hasPackage "nil";
    };

    lua-ls = {
      command = "lua-language-server";
      enabled = hasPackage "lua-language-server";
    };

    taplo = {
      command = "taplo";
      args = [ "lsp" "stdio" ];
      enabled = hasPackage "taplo";
    };

    yaml-language-server = {
      command = "yaml-language-server";
      args = [ "--stdio" ];
      enabled = hasPackage "yaml-language-server";
    };

    typescript-language-server = {
      command = "typescript-language-server";
      args = [ "--stdio" ];
      enabled = hasPackage "nodePackages.typescript-language-server";
    };

    tailwindcss-language-server = {
      command = "tailwindcss-language-server";
      args = [ "--stdio" ];
      enabled = hasPackage "nodePackages.tailwindcss-language-server";
    };

    vscode-html-language-server = {
      command = "vscode-html-language-server";
      args = [ "--stdio" ];
      enabled = hasPackage "nodePackages.vscode-html-languageserver-bin";
    };

    vscode-css-language-server = {
      command = "vscode-css-language-server";
      args = [ "--stdio" ];
      enabled = hasPackage "nodePackages.vscode-css-languageserver-bin";
    };
  };

  # Language configurations
  languages = {
    # Systems programming
    rust = {
      name = "rust";
      language-servers = [ "rust-analyzer" ];
      formatter = mkFormatter "rustfmt" [ ];
      indent = { tab-width = 4; unit = "    "; };
      category = "systems";
    };

    go = {
      name = "go";
      language-servers = [ "gopls" ];
      formatter = mkFormatter "goimports-reviser" [ ];
      indent = { tab-width = 4; unit = "\t"; };
      category = "systems";
    };

    # JVM
    scala = {
      name = "scala";
      language-servers = [ "metals" ];
      indent = { tab-width = 2; unit = "  "; };
      category = "jvm";
    };

    # Scripting
    python = {
      name = "python";
      language-servers = [ "pyright" ];
      formatter = mkFormatter "ruff" [ "format" "--stdin-filename" "-" "-" ];
      indent = { tab-width = 4; unit = "    "; };
      auto-format = true;
      category = "scripting";
    };

    lua = {
      name = "lua";
      language-servers = [ "lua-ls" ];
      formatter = mkFormatter "stylua" [ ];
      indent = { tab-width = 2; unit = "  "; };
      category = "scripting";
    };

    # Web development
    javascript = {
      name = "javascript";
      language-servers = [ "tailwindcss-language-server" "typescript-language-server" ];
      formatter = mkFormatter "prettier" [ "--parser" "javascript" ];
      indent = { tab-width = 2; unit = "  "; };
      category = "web";
    };

    typescript = {
      name = "typescript";
      language-servers = [ "tailwindcss-language-server" "typescript-language-server" ];
      formatter = mkFormatter "prettier" [ "--parser" "typescript" ];
      indent = { tab-width = 2; unit = "  "; };
      category = "web";
    };

    jsx = {
      name = "jsx";
      language-id = "javascriptreact";
      language-servers = [ "tailwindcss-language-server" "typescript-language-server" ];
      formatter = mkFormatter "prettier" [ "--parser" "babel" ];
      indent = { tab-width = 2; unit = "  "; };
      category = "web";
    };

    tsx = {
      name = "tsx";
      language-id = "typescriptreact";
      language-servers = [ "tailwindcss-language-server" "typescript-language-server" ];
      formatter = mkFormatter "prettier" [ "--parser" "typescript" ];
      indent = { tab-width = 2; unit = "  "; };
      category = "web";
    };

    html = {
      name = "html";
      language-servers = [ "tailwindcss-language-server" "vscode-html-language-server" ];
      formatter = mkFormatter "prettier" [ "--parser" "html" ];
      indent = { tab-width = 2; unit = "  "; };
      category = "web";
    };

    css = {
      name = "css";
      language-servers = [ "tailwindcss-language-server" "vscode-css-language-server" ];
      formatter = mkFormatter "prettier" [ "--parser" "css" ];
      indent = { tab-width = 2; unit = "  "; };
      category = "web";
    };

    # Configuration
    nix = {
      name = "nix";
      language-servers = [ "nil" ];
      formatter = mkFormatter "nixpkgs-fmt" [ ];
      indent = { tab-width = 2; unit = "  "; };
      category = "config";
    };

    toml = {
      name = "toml";
      language-servers = [ "taplo" ];
      formatter = mkFormatter "taplo" [ "format" "-" ];
      indent = { tab-width = 2; unit = "  "; };
      category = "config";
    };

    yaml = {
      name = "yaml";
      language-servers = [ "yaml-language-server" ];
      formatter = mkFormatter "prettier" [ "--parser" "yaml" ];
      indent = { tab-width = 2; unit = "  "; };
      category = "config";
    };

    ini = {
      name = "ini";
      indent = { tab-width = 2; unit = "  "; };
      category = "config";
    };

    # Documentation
    markdown = {
      name = "markdown";
      formatter = mkFormatter "prettier" [ "--parser" "markdown" ];
      indent = { tab-width = 2; unit = "  "; };
      soft-wrap.enable = true;
      rulers = [ ];
      category = "docs";
    };

    latex = {
      name = "latex";
      language-servers = [ "texlab" ];
      formatter = mkFormatter "latexindent" [ "-c" "-" "-o" "-" ];
      indent = { tab-width = 2; unit = "  "; };
      category = "docs";
    };

    mermaid = {
      name = "mermaid";
      category = "docs";
    };
  };

  # Filter enabled language servers
  enabledLanguageServers = builtins.listToAttrs (
    map (name: { inherit name; value = languageServers.${name}; })
      (builtins.filter (name: languageServers.${name}.enabled)
        (builtins.attrNames languageServers))
  );

  # Filter languages by availability of their dependencies
  availableLanguages = builtins.listToAttrs (
    builtins.filter
      (lang:
        let
          langServers = lang.value.language-servers or [ ];
        in
        # Include language if it has no language servers or all its servers are available
        langServers == [ ] || builtins.all (server: enabledLanguageServers ? ${server}) langServers
      )
      (builtins.map (name: { inherit name; value = languages.${name}; }) (builtins.attrNames languages))
  );

  # Language categories
  categories = {
    systems = [ "rust" "go" ];
    jvm = [ "scala" ];
    scripting = [ "python" "lua" ];
    web = [ "javascript" "typescript" "jsx" "tsx" "html" "css" ];
    config = [ "nix" "toml" "yaml" "ini" ];
    docs = [ "markdown" "latex" "mermaid" ];
  };

  # Language templates
  languageSets = {
    minimal = [ "nix" "toml" "yaml" "markdown" ];
    web = categories.web ++ categories.config;
    systems = categories.systems ++ categories.config;
    scripting = categories.scripting ++ categories.config;
    all = builtins.attrNames languages;
  };

  # Configuration builders
  mkLanguageConfig = selectedLanguages:
    let
      filtered = builtins.listToAttrs (
        map (name: { inherit name; value = availableLanguages.${name}; })
          (builtins.filter (name: availableLanguages ? ${name}) selectedLanguages)
      );

      languageList = builtins.map
        (lang:
          builtins.removeAttrs lang [ "category" ]
        )
        (builtins.attrValues filtered);

      serverConfig = builtins.listToAttrs (
        map
          (name: {
            inherit name;
            value = builtins.removeAttrs enabledLanguageServers.${name} [ "enabled" ];
          })
          (builtins.attrNames enabledLanguageServers)
      );
    in
    {
      language-server = serverConfig;
      language = languageList;
    };

in
{
  inherit languageServers languages enabledLanguageServers availableLanguages categories languageSets;
  inherit mkLanguageConfig;

  # Convenience functions
  filterByNames = names: mkLanguageConfig names;
  filterByCategory = category: mkLanguageConfig categories.${category};

  # Pre-built configurations
  all = mkLanguageConfig languageSets.all;
  minimal = mkLanguageConfig languageSets.minimal;
  web = mkLanguageConfig languageSets.web;
  systems = mkLanguageConfig languageSets.systems;
  scripting = mkLanguageConfig languageSets.scripting;
}
