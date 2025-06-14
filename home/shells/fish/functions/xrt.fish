function xrt --description "Extract archives"
    for file in $argv
        if test -f $file
            switch $file
                case '*.tar.bz2'
                    tar xjf $file
                case '*.tar.gz'
                    tar xzf $file
                case '*.bz2'
                    bunzip2 $file
                case '*.gz'
                    gunzip $file
                case '*.tar'
                    tar xf $file
                case '*.tbz2'
                    tar xjf $file
                case '*.tgz'
                    tar xzf $file
                case '*.zip'
                    unzip $file
                case '*.7z'
                    7z x $file
                case '*'
                    echo "Unknown archive format: $file"
            end
        else
            echo "$file is not a valid file"
        end
    end
end

complete -c xrt -f
