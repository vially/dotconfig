function singlemonitor
    set -l mode $argv[1]
    if [ "$mode" = "disable" ]
        swaymsg output DP-2 enable
        swaymsg output DP-3 enable
    else
        swaymsg output DP-2 disable
        swaymsg output DP-3 disable
    end
end
