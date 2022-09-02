if string match -q "$TERM_PROGRAM" "vscode"
    source (code --locate-shell-integration-path fish)
end
