-- Hyprland configuration (Lua) -- https://wiki.hypr.land/Configuring/Start/
--
-- Since Hyprland 0.55 the config language is Lua. If this file (hyprland.lua)
-- exists it is loaded instead of hyprland.conf.
--
-- Modular config: each file under conf.d/ is loaded explicitly below.
-- NOTE: require() is not used because the directory name "conf.d" contains a
-- dot, and Lua maps dots in module names to path separators. dofile() with an
-- absolute path sidesteps that and keeps the load order explicit.

local hypr = os.getenv("HOME") .. "/.config/hypr"
local function load(rel)
    dofile(hypr .. "/conf.d/" .. rel)
end

load("session.lua")
load("monitors.lua")
load("input.lua")
load("ui.lua")
load("xwayland.lua")
load("keybindings.lua")
load("swayidle.lua")
load("xdg-auto-start.lua")

-- Ephemeral / scratch tweaks
load("ephemeral/apps.lua")
load("ephemeral/keybindings.lua")
