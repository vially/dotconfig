function vi_key_bindings
    fish_vi_key_bindings

    bind -M insert \ca beginning-of-line
    bind -M insert \ce end-of-line
    bind -M insert \cf accept-autosuggestion
end
