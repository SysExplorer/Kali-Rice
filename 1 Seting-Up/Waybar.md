---
Description:
UseCase:
Configfile:
  - ~/.config/waybar
tags:
  - Ricing
---
# Docs and Sources

| DOCs                                                         | Porpose |
| ------------------------------------------------------------ | ------- |
| wiki.hypr.land/Configuring/Basics/Autostart/                 |         |
| wiki.hypr.land/Useful-Utilities/Systemd-start<br>/#autostart |         |
| github.com/Alexays/Waybar                                    |         |

# Installation

Installed with `sudo apt install waybar -y`

```text
Pulls in Waybar and its runtime dependencies for the status bar.
```

# Disable Systemd autostart

Disabled the systemd service so Waybar doesn't start on its own and is only launched when explicitly told to:

```bash
sudo systemctl --global disable waybar
systemctl --user disable waybar.service
```

Verified it was disabled:

```bash
systemctl --user is-enabled waybar.service
systemctl --global is-enabled waybar.service
```

# Autostart with Hyprland


Added Waybar to the `Autostart` section of `~/.config/ricing/hypr/hyprland.lua`, pointing it at our custom config folder path so it launches together with the session instead of via its own systemd service:

```lua
hl.on("hyprland.start", function ()
  hl.exec_cmd("waybar -c ~/.config/ricing/waybar/config -s ~/.config/ricing/waybar/style.css")
  hl.exec_cmd("kitty")
end)
```

```text
Runs waybar and kitty as soon as the Hyprland session starts, since both
services are disabled at the systemd level and need to be launched manually
from the compositor's autostart hook.
```

# Config

Create a custom config directory under `~/.config/ricing/waybar/` and copied the default configs into it:

```bash
mkdir ~/.config/ricing/waybar
cp /etc/xdg/waybar/config.jsonc ~/.config/ricing/waybar/
cp /etc/xdg/waybar/style.css ~/.config/ricing/waybar/
```