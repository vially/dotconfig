function whoowns
    set -l file_name $argv[1]
    if not test -e $file_name
        set file_name (command --search $file_name)
    end
    pacaur -Qo $file_name
end