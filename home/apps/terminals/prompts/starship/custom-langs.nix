{
  config,
  rhodiumLib,
  ...
}:
let
  viaIcon = "◆";
in
{
  programs.starship.settings = {
    custom = {
      clojure = {
        description = "Shows Clojure project";
        when = ''
          test -f project.clj || \
          test -f deps.edn || \
          test -f build.boot || \
          test -f shadow-cljs.edn || \
          test -f bb.edn
        '';
        command = ''
          if command -v clojure >/dev/null 2>&1; then
            clojure -version 2>&1 | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1
          else
            echo "project"
          fi
        '';
        format = "${viaIcon} [ $output]($style) ";
        style = "bold green";
      };

      astro = {
        description = "Shows Astro project";
        when = ''
          test -f astro.config.mjs || \
          test -f astro.config.js || \
          test -f astro.config.ts || \
          find . -maxdepth 1 -name "*.astro" 2>/dev/null | grep -q .
        '';
        command = ''
          if [ -f package.json ] && grep -q '"astro"' package.json 2>/dev/null; then
            grep '"astro":' package.json | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1
          else
            echo "project"
          fi
        '';
        format = "${viaIcon} [ $output]($style) ";
        style = "bold purple";
      };

      typescript = {
        description = "Shows TypeScript project";
        when = ''
          test -f tsconfig.json || \
          test -f tsconfig.base.json || \
          find . -maxdepth 1 -name "*.ts" -o -name "*.tsx" 2>/dev/null | grep -q .
        '';
        command = ''
          if command -v tsc >/dev/null 2>&1; then
            tsc --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+'
          else
            echo "project"
          fi
        '';
        format = "${viaIcon} [ $output]($style) ";
        style = "bold blue";
      };

      assembly = {
        description = "Shows Assembly project";
        when = ''
          find . -maxdepth 1 \( -name "*.asm" -o -name "*.s" -o -name "*.S" \) 2>/dev/null | grep -q .
        '';
        command = ''
          if command -v nasm >/dev/null 2>&1; then
            echo "nasm"
          elif command -v gas >/dev/null 2>&1; then
            echo "gas"
          else
            echo "asm"
          fi
        '';
        format = "${viaIcon} [ $output]($style) ";
        style = "bold red";
      };

      ada = {
        description = "Shows Ada project";
        when = ''
          test -f alire.toml || \
          test -f project.gpr || \
          find . -maxdepth 1 \( -name "*.ads" -o -name "*.adb" \) 2>/dev/null | grep -q .
        '';
        command = ''
          if command -v gnatmake >/dev/null 2>&1; then
            gnatmake --version | head -1 | grep -o '[0-9]\+\.[0-9]\+'
          else
            echo "project"
          fi
        '';
        format = "${viaIcon} [ $output]($style) ";
        style = "bold cyan";
      };

      agda = {
        description = "Shows Agda project";
        when = ''
          test -f .agda-lib || \
          find . -maxdepth 1 -name "*.agda" 2>/dev/null | grep -q .
        '';
        command = ''
          if command -v agda >/dev/null 2>&1; then
            agda --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1
          else
            echo "project"
          fi
        '';
        format = "${viaIcon} [ $output]($style) ";
        style = "bold yellow";
      };

      angular = {
        description = "Shows Angular project";
        when = ''
          test -f angular.json || \
          test -f .angular-cli.json || \
          test -f angular-cli.json
        '';
        command = ''
          if [ -f package.json ] && grep -q '"@angular/core"' package.json 2>/dev/null; then
            grep '"@angular/core":' package.json | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1
          else
            echo "project"
          fi
        '';
        format = "${viaIcon} [ $output]($style) ";
        style = "bold red";
      };
    };
  };
}
