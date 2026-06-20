-- Tie Hyprland into a systemd graphical session.
--
-- Starting hyprland-session.target pulls up graphical-session.target, which
-- user services (status bars, notification daemons) attach to and which some
-- services (e.g. xdg-desktop-portal / XDPH) refuse to start without.
-- See https://wiki.hypr.land/Useful-Utilities/Systemd-start/#hyprland-sessiontarget
hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprland-session.target")
end)

hl.on("hyprland.shutdown", function()
    -- Blocking exec + brief sleep gives services time to shut down cleanly
    -- before the compositor exits.
    os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)
