local mod = "SUPER"

hl.bind(mod .. " + SHIFT + Q",     hl.dsp.exit())
hl.bind(mod .. " + RETURN",        hl.dsp.exec_cmd("alacritty"))
hl.bind(mod .. " + SHIFT + C",     hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + SHIFT + S",     hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"))
hl.bind(mod .. " + P",             hl.dsp.exec_cmd("albert toggle"))
hl.bind(mod .. " + R",             hl.dsp.window.pseudo())
hl.bind(mod .. " + T",             hl.dsp.group.toggle())
hl.bind(mod .. " + F",             hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mod .. " + code:191",      hl.dsp.exec_cmd("~/.config/hypr/scripts/hyprtabs.sh"))
hl.bind(mod .. " + grave",         hl.dsp.workspace.toggle_special())
hl.bind(mod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mod .. " + comma",         hl.dsp.exec_cmd("[workspace 3] code ~/.config/"))

-- Group / focus navigation
hl.bind(mod .. " + left",  hl.dsp.group.prev())             -- changegroupactive, b
hl.bind(mod .. " + right", hl.dsp.group.next())             -- changegroupactive, f
hl.bind(mod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mod + [0-9], move active window with mod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through workspaces
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Mouse binds
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume and Media Control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("volumectl up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("volumectl down"))
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("pamixer --default-source -m"))
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("volumectl toggle"))
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause",       hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"))
