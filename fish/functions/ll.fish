function ll --description 'List contents of directory using long format'
    if test (command --search exa)
        exa -lh $argv
    else
        ls -lh $argv
    end
end
