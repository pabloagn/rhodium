function jtp --description "Jump To Proj: Quick project switcher"
    set -l project_dirs $HOME_PROJECTS $HOME_PROFESSIONAL $HOME_SOLENOIDLABS $RHODIUM
    set -l project (fd . $project_dirs -d 1 --type d 2>/dev/null | fzf --preview 'eza --tree --level=2 --color=always {}')
    if test -n "$project"
        cd "$project"
    end
end

complete -c jtp -f
