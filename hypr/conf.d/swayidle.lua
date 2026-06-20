-- idle and lock config
hl.on("hyprland.start", function()
    hl.exec_cmd("swayidle -w timeout 900 'swaylock -f --image ~/.local/share/wallpapers/default.jpg' timeout 1200 'hyprctl dispatcher dpms off' resume 'hyprctl dispatcher dpms on' before-sleep 'swaylock -f --image ~/.local/share/wallpapers/default.jpg'")
end)
