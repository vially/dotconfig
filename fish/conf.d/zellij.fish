# Workaround for: https://github.com/zellij-org/zellij/issues/1933
function zr
  command zellij run --name "$argv" -- fish -c "$argv"
end
function zrf
  command zellij run --name "$argv" --floating -- fish -c "$argv"
end
function zri
  command zellij run --name "$argv" --in-place -- fish -c "$argv"
end
function ze
  command zellij edit $argv
end
function zef
  command zellij edit --floating $argv
end
function zei
  command zellij edit --in-place $argv
end
