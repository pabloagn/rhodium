function bkp --description "Create backup of file"
    cp $argv[1] $argv[1].bak.(date +%Y%m%d-%H%M%S)
end

complete -c bkp -f
