function ll --description 'List contents of directory using long format'
    if type --query exa
        exa -lh $argv
    else
        ls -lh $argv
    end
end
