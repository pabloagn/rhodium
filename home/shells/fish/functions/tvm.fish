function tvm --description "Open television on smart multi-edit mode"
    set -l files (tv $argv[1])
    if test -n "$files"
        $EDITOR (string split \n $files)
    end
end
