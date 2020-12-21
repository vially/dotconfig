function pkgexports
    cat (pkgmain $argv[1]) | grep exports
end
