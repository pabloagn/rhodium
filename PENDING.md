**The Core Principle: Options and Conditional Configuration**

NixOS works by:
1.  Defining **options** (the "features" or "settings" you can choose for your car).
2.  Modules **setting values** for these options (making choices).
3.  Modules **reacting** to the chosen values (installing parts, configuring systems).

**Let's Simplify and Build Up - Focus on ONE Choice: The Default Shell**

**1. Defining the "Available Choices" and "Default Choice" (Factory Catalog & Standard Model):**

   *   **File:** `modules/system-profiles/options.nix` (as previously discussed, this is where we define "props" or system-level choices).

     ```nix
     # modules/system-profiles/options.nix
     { lib, config, pkgs, ... }:
     let
       availableShells = [ "zsh" "fish" "bash" ]; # What the factory offers
     in
     {
       options.mySystem.userShells = { # Renamed for clarity from just 'shells'
         enable = lib.mkOption {
           type = lib.types.listOf (lib.types.enum availableShells);
           default = [ "bash" ]; # Factory standard: bash is always installed
           description = "List of shells to make available on the system.";
         };
         defaultLoginShell = lib.mkOption { # What the car comes with by default
           type = lib.types.enum availableShells;
           default = "bash"; # Factory standard: bash is the default login shell
           description = "The default login shell for users on this system.";
         };
       };

       # --- Linter Slap Example ---
       config = lib.mkIf (!(lib.elem config.mySystem.userShells.defaultLoginShell config.mySystem.userShells.enable)) {
         # This assertion will FAIL the build if the defaultLoginShell is not in the list of enabled shells.
         assertions = [{
           assertion = false; # This means the assertion condition is "false" -> trigger error
           message = "The chosen defaultLoginShell ('${config.mySystem.userShells.defaultLoginShell}')
                      must be one of the enabled shells: ${lib.concatStringsSep ", " config.mySystem.userShells.enable}";
         }];
       };
     }
     ```
   *   **Explanation:**
        *   `options.mySystem.userShells.enable`: Defines what shells *can be installed*. Default is just `bash`.
        *   `options.mySystem.userShells.defaultLoginShell`: Defines what the *default login shell* will be. Default is `bash`.
        *   **Linter Slap:** The `assertions` block checks if the chosen `defaultLoginShell` is actually in the `enable` list. If not, `nixos-rebuild` will fail with your custom message. This is your "TypeScript prop validation."

**2. Modules Implementing the Choices (Factory Assembly Line):**

   *   **File:** `modules/core/shells/default.nix` (This module is responsible for shells).

     ```nix
     # modules/core/shells/default.nix
     { lib, config, pkgs, ... }:
     {
       # This module doesn't import individual shell.nix files if they are just for system-wide config.
       # If zsh.nix, fish.nix etc. define options, then they should be imported here.
       # For now, let's assume they are for user-specific config via Home Manager primarily.

       config = {
         # 1. Install the selected shells:
         # It iterates through the list provided by config.mySystem.userShells.enable
         environment.systemPackages = map (shellName: pkgs."${shellName}") config.mySystem.userShells.enable;

         # 2. Set the system-wide default shell for users:
         # This is what users get if their individual user definition doesn't specify a shell.
         users.defaultUserShell = pkgs."${config.mySystem.userShells.defaultLoginShell}";
       };
     }
     ```
   *   **Explanation:**
        *   It reads `config.mySystem.userShells.enable` and installs those packages.
        *   It reads `config.mySystem.userShells.defaultLoginShell` and sets the system's default.

**3. The "Car Order" - Customer Choices in `flake.nix` (Blueprint for a Specific Machine):**

   This is where the customer (you, for a specific host) makes their choices, overriding the factory defaults.

   ```nix
   # flake.nix
   # ... (inputs, flake-parts setup, overlays definition) ...

         flake = {
           nixosConfigurations = {
             "nixos-wsl" = nixpkgs.lib.nixosSystem {
               system = "x86_64-linux";
               specialArgs = { inherit inputs; hostname = "nixos-wsl"; };
               modules = [
                 # Base host config (chassis type)
                 ./hosts/nixos-wsl/default.nix # Sets system.stateVersion, boot.isContainer, etc.

                 # Import modules that DEFINE options and implement them
                 ./modules/core/default.nix   # This will import system-profiles/options.nix and shells/default.nix
                 # ./modules/desktop/default.nix # We'd conditionally import this based on a hostProfile option
                 ./modules/themes/default.nix # For theme options

                 # User definitions (who is driving)
                 ./users/pabloagn.nix

                 # Home Manager (driver's personal seat settings & gadgets)
                 inputs.home-manager.nixosModules.home-manager
                 {
                   home-manager.users.pabloagn = {
                     imports = [ ./home/profiles/developer.nix ];
                     # Customer pabloagn might override their own shell here,
                     # which takes precedence over users.defaultUserShell for pabloagn
                     programs.zsh.enable = true; # Example if zsh is preferred by this user
                     users.users.pabloagn.shell = pkgs.zsh; # This is user-specific override
                   };
                 }

                 # === CUSTOMER CHOICES FOR THIS "nixos-wsl" CAR ===
                 ({ lib, config, ... }: {
                   # Override the default shell choices:
                   mySystem.userShells = {
                     enable = [ "zsh" "fish" "bash" ]; # Customer wants Zsh, Fish, and Bash installed
                     defaultLoginShell = "zsh";        # Customer wants Zsh as the default login shell
                   };

                   # Theme choices for this car:
                   mySystem.theme.name = "phantom";
                   mySystem.theme.font.primary = "Inter";
                   mySystem.theme.font.monospace = "IosevkaTerm"; # Assuming "IosevkaTerm" is a key in your assets/tokens/fonts/definitions.nix
                   mySystem.theme.font.defaultSize = "10pt";

                   # Host profile choice
                   # mySystem.hostProfile = "headless-dev"; # Defined in system-profiles/options.nix
                 })
               ];
             };

             "desktop-main" = nixpkgs.lib.nixosSystem {
               # ... similar structure ...
               modules = [
                 # ... other modules ...
                 # === CUSTOMER CHOICES FOR THIS "desktop-main" CAR ===
                 ({ lib, config, ... }: {
                   mySystem.userShells = {
                     enable = [ "fish" "bash" ]; # This customer only wants Fish and Bash
                     defaultLoginShell = "fish";   # Fish is their default
                   };
                   mySystem.theme.name = "srcl";
                   # ... other theme choices ...
                   # mySystem.hostProfile = "gui-desktop";
                 })
               ];
             };
           };
         };
   # ...
   ```
   *   **Explanation:**
        *   The inline module `({ lib, config, ... }: { ... })` at the end of the `modules` list for `"nixos-wsl"` is where the **customer explicitly overrides the defaults**.
        *   `mySystem.userShells.enable = [ "zsh" "fish" "bash" ];` means for this specific "nixos-wsl" machine, these three shells will be installed (overriding the default of just `bash`).
        *   `mySystem.userShells.defaultLoginShell = "zsh";` means Zsh will be the default login shell for this machine (overriding the factory default of `bash`).
        *   The `modules/core/shells/default.nix` will see these *overridden* values from `config.mySystem.userShells.*` and act accordingly.

**How a User's Specific Module Requirements are Met (e.g., Terminals for WSL):**

Let's extend to the "Terminals" example: `Term = I want Ghostty + Kitty + Wezterm with default = Ghostty` for the WSL host.

1.  **Define Options (`modules/system-profiles/options.nix`):**
    ```nix
    # ... inside options.mySystem ...
       userTerminals = {
         enable = lib.mkOption {
           type = lib.types.listOf (lib.types.enum availableTerminals); # availableTerminals defined at top
           default = []; # Default: no specific terminals installed by this option, only if requested
           description = "List of terminal emulators to install for general use.";
         };
         default = lib.mkOption {
           type = lib.types.nullOr (lib.types.enum availableTerminals);
           default = null; # No system-wide default terminal by this option alone
           description = "Preferred default terminal application.";
         };
       };
    # ... add assertion for default terminal being in enabled list ...
    ```

2.  **Implement in a Module (`modules/desktop/terminal/default.nix`):**
    *(This module would only be imported if `mySystem.hostProfile` indicates GUI or dev capabilities, or if `userTerminals.enable` is not empty)*

    ```nix
    # modules/desktop/terminal/default.nix
    { lib, config, pkgs, ... }:
    {
      config = lib.mkIf (config.mySystem.userTerminals.enable != []) { # Only do this if some terminals are requested
        environment.systemPackages = map (termName: pkgs."${termName}") config.mySystem.userTerminals.enable;

        # Setting a true "default terminal" (for xdg-open etc.) is complex and DE-dependent.
        # For now, this option mainly ensures installation and can be used by theme/config modules.
        # The `modules/themes/apply.nix` would use `config.mySystem.userTerminals.default`
        # to know which terminal to apply specific theming to (e.g., Alacritty settings).
      };
    }
    ```
    *   This module needs to be imported in `flake.nix` for the relevant hosts, perhaps conditionally:
        `(lib.mkIf (config.mySystem.hostProfile == "headless-dev" || config.mySystem.hostProfile == "gui-desktop") ./modules/desktop/terminal/default.nix)`

3.  **Customer Order in `flake.nix` for `nixos-wsl`:**
    ```nix
    # ... inside the inline module for "nixos-wsl" ...
                mySystem.userTerminals = {
                  enable = [ "ghostty" "kitty" "wezterm" ];
                  default = "ghostty";
                };
    # ...
    ```

**Summary of the Flow (Car Order):**

1.  **Define Options (`modules/.../options.nix`):** These are the features in the car brochure with their standard configurations (defaults). This includes "linter slaps" (assertions).
2.  **Implement Modules (`modules/.../*.nix`):** These are the factory stations that look at the *final chosen options* for a car and install/configure parts.
3.  **Place Order (`flake.nix` -> `nixosConfigurations.<host>`):**
    *   You list all relevant "factory station blueprints" (modules) to be considered for this car.
    *   In an inline module at the end (or in the host-specific file like `hosts/nixos-wsl/default.nix`), you **set the values for the options**, overriding the defaults. This is the customer's selection.
4.  **Nix Builds:** Nix evaluates all imported modules. When `config.mySystem.userShells.defaultLoginShell` is accessed by `modules/core/shells/default.nix`, it gets the value *you set in the flake.nix order for that specific host* (e.g., "zsh" for `nixos-wsl`), not the original default ("bash") from `options.nix`.

This layered approach of defining options with defaults, then allowing specific host configurations in `flake.nix` to override these defaults, is the standard NixOS way to achieve this kind of modularity and customization. The "linter slaps" (assertions) ensure your "order" makes sense according to the rules you've defined.


----------------------------------

Understood. No more back-and-forth on the core structure. This will be the comprehensive, foundational framework based on everything we've discussed, designed for clarity, modularity, and explicit configuration, adhering to NixOS best practices.

We will set up:
*   **Two Hosts:** `nixos-wsl` (headless dev) and `nixos-desktop` (native, AMD GPU, Hyprland).
*   **One User for now (pabloagn):** To keep the initial setup focused, but extensible.
*   **Explicit Options for:** Shells, Terminals, Editors, WM, Bar, Theme, Hardware flags.
*   **Example Applications:** A file manager & notification daemon for desktop, relevant tools for WSL.
*   **Hyprland Configuration Example:** How to start structuring its settings.

**THE BLUEPRINT (FILE STRUCTURE & CONTENT)**

**Phase 0: Ensure `tools/` and `flake.lock` are Ready**
   (As per previous discussions, ensure your Rust `color-provider` can be built and `tools/Cargo.lock` exists. For now, we will proceed *as if* it works, and its package definition will be in `flake.nix`. The actual color processing logic will be integrated into the theme application later.)

---

**Phase 1: Asset Definitions (Tokens & Themes)**

*   Follow **Phase 1 (Simplified Asset Structure & Placeholder Definitions)** from two responses ago (the one starting with "You are absolutely correct. The backticks...").
    *   This creates `assets/tokens/palettes/srcl-direct.nix`, `phantom-direct.nix`, `default.nix`.
    *   `assets/tokens/fonts/definitions.nix` (ensure `ServerMono`, `Inter`, `JetBrainsMono`, `CommitMono` are defined, pointing to `pkgs.YourFont` which will come from the overlay).
    *   `assets/tokens/fonts/sizes.nix`.
    *   `assets/tokens/borders/radii.nix`.
    *   `assets/tokens/default.nix` (aggregator).
    *   `assets/tokens/semantic/color-roles.nix` and `default.nix`.
    *   `assets/themes/definitions/srcl.nix`, `phantom.nix`, `default.nix`.
*   **Create `assets/fonts/ServerMono/fontmeta.nix`:**
    ```nix
    # assets/fonts/ServerMono/fontmeta.nix
    {
      fontType = "opentype";
      license = "unfree"; # REPLACE WITH ACTUAL LICENSE
      description = "Server Mono custom font";
    }
    ```
    *(Ensure font files are in `assets/fonts/ServerMono/`)*

---

**Phase 2: Core NixOS Option Definitions**

*   **`modules/system-profiles/options.nix`:**
    ```nix
    # modules/system-profiles/options.nix
    { lib, config, pkgs, ... }:
    let
      # These lists should ideally be dynamically generated by scanning module directories
      # or from specific registration points. For now, manually defined.
      availableShells = [ "bash" "zsh" "fish" "nushell" ];
      availableTerminals = [ "alacritty" "kitty" "wezterm" "ghostty" "foot" ];
      availableEditors = [ "neovim" "helix" "emacs" "vscode" ]; # vscode is via home-manager usually
      availableWms = [ "hyprland" "sway" "i3" "none" ];
      availableBars = [ "waybar" "polybar" "eww" "none" ];
      availableFileManagers = [ "dolphin" "nautilus" "thunar" "yazi" "lf" "nnn" ];
      availableNotificationDaemons = [ "dunst" "mako" ];
      availableLaunchers = [ "rofi" "wofi" "fuzzel" "anyrun" ];

      availableThemes = lib.attrNames (import ../../assets/themes/definitions/default.nix);
      availableFontFamilies = lib.attrNames (import ../../assets/tokens/fonts/definitions.nix { inherit pkgs lib; });
    in
    {
      options.mySystem = {
        hostProfile = lib.mkOption {
          type = lib.types.enum [ "headless-dev" "gui-desktop" "server-minimal" ];
          default = "headless-dev";
          description = "Primary role of this host (influences conditional module loading).";
        };

        userShells = {
          enable = lib.mkOption { type = lib.types.listOf (lib.types.enum availableShells); default = [ "bash" ]; };
          defaultLoginShell = lib.mkOption { type = lib.types.enum availableShells; default = "bash"; };
        };

        userTerminals = {
          enable = lib.mkOption { type = lib.types.listOf (lib.types.enum availableTerminals); default = [ "alacritty" ]; };
          default = lib.mkOption { type = lib.types.enum availableTerminals; default = "alacritty"; };
        };

        userEditors = {
          enable = lib.mkOption { type = lib.types.listOf (lib.types.enum availableEditors); default = [ "neovim" ]; };
        };

        desktop = {
          windowManager = lib.mkOption { type = lib.types.enum availableWms; default = "none"; };
          statusBar = lib.mkOption { type = lib.types.enum availableBars; default = "none"; };
          fileManager = lib.mkOption { type = lib.types.enum availableFileManagers; default = "nautilus"; }; # A common GUI default
          notificationDaemon = lib.mkOption { type = lib.types.enum availableNotificationDaemons; default = "dunst"; };
          launcher = lib.mkOption { type = lib.types.enum availableLaunchers; default = "rofi"; };
        };

        theme = { # Options for this already defined in modules/themes/options.nix
                  # We just need to ensure modules/themes/options.nix populates its enums correctly
        };

        hardware = {
          amdGpu = lib.mkEnableOption "AMD GPU specific configurations";
          nvidiaGpu = lib.mkEnableOption "NVIDIA GPU specific configurations";
          # Add intelGpu etc. if needed
        };
      };

      config = { # Assertions ("Linter Slaps")
        assertions = [
          {
            assertion = lib.elem config.mySystem.userShells.defaultLoginShell config.mySystem.userShells.enable;
            message = "Default login shell '${config.mySystem.userShells.defaultLoginShell}' must be in enabled shells.";
          }
          {
            assertion = lib.elem config.mySystem.userTerminals.default config.mySystem.userTerminals.enable;
            message = "Default terminal '${config.mySystem.userTerminals.default}' must be in enabled terminals.";
          }
          (lib.mkIf (config.mySystem.hostProfile != "gui-desktop") {
            assertion = config.mySystem.desktop.windowManager == "none" &&
                        config.mySystem.desktop.statusBar == "none" &&
                        config.mySystem.desktop.launcher == "rofi"; # Rofi can be useful even without full WM for dmenu-like tasks
            message = "For non-GUI host profiles, WM and StatusBar should be 'none'. Launcher can be CLI-friendly like rofi/fuzzel.";
          })
          (lib.mkIf (config.mySystem.hardware.amdGpu && config.mySystem.hardware.nvidiaGpu) {
            assertion = false; # Or handle this case by prioritizing one, for now, it's an error
            message = "Both AMD and NVIDIA GPU options are enabled. Please choose one or implement prioritization.";
          })
        ];
      };
    }
    ```

---

**Phase 3: NixOS Modules Implementing These Options**

*   **`modules/core/default.nix`:**
    ```nix
    # modules/core/default.nix
    {
      imports = [
        ./boot.nix
        ./security.nix # Basic security
        ./shells/default.nix
        # ./filesystem/default.nix # If you have one
        # ./networking/default.nix # If you have one, else covered by host config

        ../system-profiles/options.nix # Define the global "props"
      ];
    }
    ```

*   **`modules/core/shells/default.nix`:** (Installs selected shells, sets default)
    ```nix
    # modules/core/shells/default.nix
    { lib, config, pkgs, ... }:
    let
      shellPkgs = { # Map option name to package name if different
        bash = pkgs.bashInteractive;
        zsh = pkgs.zsh;
        fish = pkgs.fish;
        nushell = pkgs.nushell;
      };
    in
    {
      config = {
        environment.systemPackages = map (shellName: shellPkgs."${shellName}") config.mySystem.userShells.enable;
        users.defaultUserShell = shellPkgs."${config.mySystem.userShells.defaultLoginShell}";

        # System-wide direnv and starship if desired (often better in Home Manager for user config)
        # programs.direnv.enable = true;
        # programs.starship.enable = true;
      };
    }
    ```

*   **`modules/desktop/default.nix`:** (Aggregates all desktop-related modules)
    ```nix
    # modules/desktop/default.nix
    { lib, config, ... }:
    {
      imports = [
        ./applications/default.nix
        ./components/default.nix     # For fonts, cursors etc.
        ./environments/default.nix   # For full DEs like GNOME/KDE (if you add them)
        ./window-managers/default.nix # For WMs like Hyprland
        ./services/default.nix       # For desktop-related services like notification daemons, launchers
      ];
      # This module itself might not have much config, it mostly groups imports.
      # It's imported conditionally based on config.mySystem.hostProfile.
    }
    ```

*   **`modules/desktop/applications/default.nix`:** (Example for installing selected editors)
    ```nix
    # modules/desktop/applications/default.nix
    { lib, config, pkgs, ... }:
    let
      editorPkgs = {
        neovim = pkgs.neovim;
        helix = pkgs.helix;
        emacs = pkgs.emacs;
        # vscode would be via home-manager.users.<name>.programs.vscode.enable
      };
      fileManagerPkgs = {
        dolphin = pkgs.dolphin;
        nautilus = pkgs.nautilus;
        thunar = pkgs.thunar;
        yazi = pkgs.yazi;
        lf = pkgs.lf;
        nnn = pkgs.nnn;
      };
    in
    {
      config = {
        environment.systemPackages =
          (map (editorName: editorPkgs."${editorName}") config.mySystem.userEditors.enable)
          ++ (lib.optional (config.mySystem.hostProfile == "gui-desktop") fileManagerPkgs."${config.mySystem.desktop.fileManager}");
      };
    }
    ```

*   **`modules/desktop/components/fonts/fonts.nix`:** (Already defined, ensures all `definitions.nix` fonts are available)

*   **`modules/desktop/window-managers/default.nix`:**
    ```nix
    # modules/desktop/window-managers/default.nix
    {
      imports = [ ./hyprland.nix ]; # Add sway.nix, i3.nix etc. here
    }
    ```

*   **`modules/desktop/window-managers/hyprland.nix`:**
    ```nix
    # modules/desktop/window-managers/hyprland.nix
    { lib, config, pkgs, ... }:
    {
      config = lib.mkIf (config.mySystem.desktop.windowManager == "hyprland" && config.mySystem.hostProfile == "gui-desktop") {
        programs.hyprland = {
          enable = true;
          package = if config.mySystem.hardware.amdGpu then pkgs.hyprland-amd else pkgs.hyprland; # Example
          # nvidiaPatches = lib.mkIf config.mySystem.hardware.nvidiaGpu true; # If using NVIDIA

          # Default Hyprland portal (good for screen sharing, etc.)
          xdg.portal.enable = true;
          xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
        };

        # Enable Wayland session management
        programs.wayland.enable = true; # May not be needed if Hyprland package handles it

        # Basic environment for Hyprland
        environment.systemPackages = with pkgs; [
          wayland # Core Wayland protocols
          libva # VA-API for hardware video acceleration
          # Add mesa if not pulled in by GPU drivers for amdGpu
        ];

        # AMD GPU specific settings
        services.xserver.videoDrivers = lib.mkIf config.mySystem.hardware.amdGpu [ "amdgpu" ];
        boot.kernelModules = lib.mkIf config.mySystem.hardware.amdGpu [ "amdgpu" ];
        # Add other AMD specific settings here if needed (firmware, etc.)

        # Theming for Hyprland (borders, gaps, some colors) will be applied by modules/themes/apply.nix
        # Specific keybinds, window rules etc., would go into user's Home Manager config for Hyprland.
        # Or, you can provide system-wide defaults here that users can override.
        # Example for system-wide default (HM can override):
        # environment.etc."hypr/hyprland.conf".text = ''
        #   # Basic Hyprland settings from NixOS module
        #   # Colors and fonts will be set by the theme system.
        #   monitor=,preferred,auto,1
        #   exec-once = waybar # If waybar is the chosen bar
        # '';
      };
    }
    ```

*   **`modules/desktop/services/default.nix`:** (For notification daemons, launchers, bars)
    ```nix
    # modules/desktop/services/default.nix
    { lib, config, pkgs, ... }:
    {
      config = lib.mkIf (config.mySystem.hostProfile == "gui-desktop") {
        # Notification Daemon
        services.dunst.enable = lib.mkIf (config.mySystem.desktop.notificationDaemon == "dunst") true;
        services.mako.enable = lib.mkIf (config.mySystem.desktop.notificationDaemon == "mako") true;
        # Theming for these is done in modules/themes/apply.nix

        # Launcher (Rofi example, theming by apply.nix)
        programs.rofi.enable = lib.mkIf (config.mySystem.desktop.launcher == "rofi") true;

        # Status Bar (Waybar example, theming by apply.nix)
        programs.waybar.enable = lib.mkIf (config.mySystem.desktop.statusBar == "waybar") true;
      };
    }
    ```

*   **`modules/themes/options.nix`:** (Already defined, good)
*   **`modules/themes/apply.nix`:** (Already defined, needs to be expanded to theme more components based on `finalTokens`)
*   **`modules/themes/default.nix`:** (Already defined, good)

---

**Phase 4: Host and User Specific Configurations**

*   **`hosts/nixos-wsl/default.nix`:**
    ```nix
    # hosts/nixos-wsl/default.nix
    { config, pkgs, lib, hostname, ... }: # hostname is from specialArgs in flake.nix
    {
      imports = [ ../common/default.nix ];

      networking.hostName = hostname;
      boot.isContainer = true;
      system.stateVersion = "23.11";

      # WSL specific packages or settings
      environment.systemPackages = [ pkgs.wslu ];

      # Set default values for options if this host type always has certain features
      # These can be overridden by the `extraSystemOptions` in flake.nix for a specific instance.
      mySystem.hostProfile = lib.mkDefault "headless-dev";
    }
    ```

*   **`hosts/nixos-desktop/default.nix`:**
    ```nix
    # hosts/nixos-desktop/default.nix
    { config, pkgs, lib, hostname, ... }:
    {
      imports = [
        ../common/default.nix
        ./hardware-configuration.nix # If you generate one for this native host
      ];

      networking.hostName = hostname;
      system.stateVersion = "23.11";

      # For a native desktop, enable Xserver or Wayland session management basics
      services.xserver.enable = true; # Or programs.wayland.enable = true;
      services.xserver.displayManager.startx.enable = true; # Basic startx, or choose gdm, sddm etc.

      mySystem.hostProfile = lib.mkDefault "gui-desktop";
      mySystem.hardware.amdGpu = lib.mkDefault true; # Example if this desktop usually has AMD
    }
    ```
*   **`hosts/common/default.nix`:**
    ```nix
    # hosts/common/default.nix
    { config, pkgs, lib, ... }:
    {
      # Timezone, locale, basic networking that's truly common
      time.timeZone = "Etc/UTC";
      i18n.defaultLocale = "en_US.UTF-8";
      console.keyMap = "us";

      # Nix settings
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    }
    ```

*   **`users/pabloagn.nix`:**
    ```nix
    # users/pabloagn.nix
    { config, pkgs, lib, ... }:
    {
      users.users.pabloagn = {
        isNormalUser = true;
        description = "Pablo Aguirre";
        extraGroups = [ "wheel" "networkmanager" "docker" "adbusers" ]; # Common groups
        shell = pkgs.zsh; # This is pabloagn's preferred login shell, overriding system default
                          # Ensure zsh is in mySystem.userShells.enable for this host
        # Use sops-nix for hashedPasswords in production for security
        # initialPassword = "replace_this_insecure_password"; # For testing only
      };
    }
    ```

*   **`home/profiles/developer.nix`:** (Example Home Manager profile)
    ```nix
    # home/profiles/developer.nix
    { pkgs, config, lib, ... }:
    {
      programs.home-manager.enable = true;
      home.stateVersion = "23.11";

      home.username = "pabloagn"; # This needs to match the user it's applied to
                                # Or set dynamically by Home Manager's NixOS module

      home.packages = with pkgs; [ git neovim ripgrep fd ];

      programs.git = {
        enable = true;
        userName = "Pablo Aguirre";
        userEmail = "pablo@example.com"; # Replace with your email
      };

      # Alacritty is themed by modules/themes/apply.nix, but enabled here
      programs.alacritty.enable = true;

      # Example: Zsh config (if user pabloagn uses zsh)
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        ohMyZsh.enable = false; # Example: using pure zsh or other plugin managers
        # .zshrc content or plugins
      };
    }
    ```
    Create other profiles like `minimal.nix`, `creative.nix`, `gamer.nix` similarly.

---

**Phase 5: `flake.nix` (The Master Order Form)**

Use the `flake.nix` from my *previous* response (the one starting "You are absolutely right to demand clarity..."). It contains the `mkHost` helper and demonstrates how to define `nixos-wsl` and `desktop-main` by:
1.  Importing the respective `hosts/<hostname>/default.nix`.
2.  Importing all shared `modules/*` categories.
3.  Conditionally importing `modules/desktop/default.nix` based on a `hasDesktop` flag passed to `mkHost` (or a `mySystem.hostProfile` check).
4.  Importing specific `users/<username>.nix` files.
5.  Setting up Home Manager to import profiles from `home/profiles/` for those users.
6.  Using an `extraModules` (or `extraSystemOptions` as I named it) inline module to set the **customer choices** for `mySystem.theme.*`, `mySystem.userShells.*`, `mySystem.userTerminals.*`, `mySystem.desktop.*`, `mySystem.hardware.*` for *that specific host build*.

**Key to Understanding "What Module They Get":**

*   **Availability vs. Activation:**
    *   Importing `./modules/core/default.nix` (which imports `./modules/core/shells/default.nix`) makes the *logic* for installing and setting default shells available.
    *   The *actual* shells installed and the default set depend on the values of `config.mySystem.userShells.enable` and `config.mySystem.userShells.defaultLoginShell`.
    *   These values are **set by you in the `flake.nix` `nixosConfiguration` entry for that specific host** (the "customer order").
*   **Conditional Logic (`lib.mkIf`):**
    *   Your modules (e.g., `hyprland.nix`) use `lib.mkIf (config.mySystem.desktop.windowManager == "hyprland" && config.mySystem.hostProfile == "gui-desktop") { programs.hyprland.enable = true; ... }`.
    *   This means Hyprland is only enabled if the customer's order for that host specified `mySystem.desktop.windowManager = "hyprland";` AND that host is a `gui-desktop`.
*   **Home Manager for User Apps/Dotfiles:**
    *   Things like `programs.git` are Home Manager options. They are "activated" for a user if their Home Manager profile (e.g., `home/profiles/developer.nix`) includes `programs.git.enable = true;` AND that profile is imported for that user on that host.

This structure provides multiple layers for defining the "car":
1.  **Flake (`nixosConfigurations.<host>`):** The final customer order, selecting options.
2.  **Host Type (`hosts/<host>/default.nix`):** Defines the base model/chassis and its inherent features/limitations. Sets defaults for some `mySystem.*` options.
3.  **System Profiles (`modules/system-profiles/options.nix`):** The catalog of all configurable "props" with their factory defaults and validation rules.
4.  **Feature Modules (`modules/*/*.nix`):** The engineering blueprints that implement features based on the *final, resolved* option values.
5.  **User Profiles (`home/profiles/*.nix`):** The driver's personal settings and preferred gadgets.

This is exhaustive but necessary for the level of control and clarity you're aiming for.
