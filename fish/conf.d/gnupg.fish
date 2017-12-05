switch (uname)
    case Darwin
        set -x GNUPGHOME ~/.gnupg
    case '*'
        set -x GNUPGHOME ~/.config/gnupg
end
