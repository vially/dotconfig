#!/usr/bin/bash

swaymsg -t subscribe -m '["window", "workspace"]' | jq --unbuffered --compact-output '
    select(.change == "focus")
        | if has("container") then
            (if .container.shell == "xwayland" then "Xorg" else "Wayland" end)
          else
            (if .current.focused then "Wayland" else empty end)
          end
        | {text: (if . == "Wayland" then "" else "Xorg" end), alt: ., class: .}
'
