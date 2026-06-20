-- Monitors -- https://wiki.hypr.land/Configuring/Monitors/
--             output      mode         position   scale
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "0x0",    scale = 1.5 })
hl.monitor({ output = "DP-1",     mode = "preferred", position = "2560x0", scale = 1.5 })
hl.monitor({ output = "DP-2",     mode = "preferred", position = "5120x0", scale = 1.5 })

-- Workspaces -> monitors
hl.workspace_rule({ workspace = "1",  monitor = "DP-1" })
hl.workspace_rule({ workspace = "2",  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "3",  monitor = "DP-1" })
hl.workspace_rule({ workspace = "4",  monitor = "DP-1" })
hl.workspace_rule({ workspace = "5",  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "6",  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "7",  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "8",  monitor = "DP-2" })
hl.workspace_rule({ workspace = "9",  monitor = "DP-2" })
hl.workspace_rule({ workspace = "10", monitor = "DP-2" })

hl.config({
    misc = {
        vrr = 1,                      -- Enable Adaptive Sync
        force_default_wallpaper = -1,
    },
})
