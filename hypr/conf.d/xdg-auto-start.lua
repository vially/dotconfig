-- Run programs on session startup
hl.on("hyprland.start", function()
    hl.exec_cmd("albert")
    hl.exec_cmd("ashell")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hyprsunset")
end)
