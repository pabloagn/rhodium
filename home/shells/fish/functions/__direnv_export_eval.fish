function __direnv_export_eval --on-event fish_prompt
    begin
        begin
            direnv export fish
        end 1>| source
    end 2>| egrep -v -e "^direnv: (export|loading|using|nix-direnv:)" -e "Welcome to"
end
