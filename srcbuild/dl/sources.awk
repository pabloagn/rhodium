/"name":/ {
    name = $2
    sub(/^[ \t]*"name": "[^"]*/, "", name)
    gsub(/[" ,]/, "", name)
}
/"browser_download_url":/ {
    url = $2
    gsub(/[" ,]/, "", url)
    if (name ~ /_[0-9]+\.[sS]ource\.tar\.xz$/) {
        print name "\t" url
    }
}
