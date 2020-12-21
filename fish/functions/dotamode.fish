function dotamode
    set -l mode $argv[1]
    if [ "$mode" = "disable" ]
        swaymsg output DP-1 scale 2
        swaymsg output DP-3 pos 3840 0
    else
        swaymsg output DP-1 scale 1
        swaymsg output DP-3 pos 5760 0
    end
end
