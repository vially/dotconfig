function pkgmain
    set -l pkgname $argv[1]
    set -l pkgdir "./node_modules/$pkgname"
    set -l pkgjson "$pkgdir/package.json"
    if not test -e $pkgjson
        echo "$pkgjson does not exist"
        return 1
    end

    if jq --exit-status .main "$pkgjson" > /dev/null
        echo $pkgdir/(jq --raw-output .main "$pkgjson")
    else
        echo $pkgdir/index.js
    end
end
