---
Description: Polkit authentication agent for Hyprland
UseCase:
Configfile:
  - ~/.config/waybar
tags:
  - Ricing
---
# Docs and Sources

| DOCs                                           | Porpose                                                     |
| ---------------------------------------------- | ----------------------------------------------------------- |
| github.com/hyprwm/hyprpolkitagent              | `Install` + `Config` – source repo, build deps, config keys |
| wiki.hypr.land/Hypr-Ecosystem/hyprpolkitagent/ | `Config` – usage reference                                  |
|                                                |                                                             |

# Installation

Installed with `sudo apt install hyprpolkitagent -y`

# Disable Systemd autostart

The package ships a `hyprpolkitagent.service` user unit. so we need to disable it globally and only enable it when loging to our Riced sessioni:

```
systemctl --user disable hyprpolkitagent.service  
systemctl --global disable hyprpolkitagent.service
```

# Autostart with Hyprland

Added to the `Autostart` section of `~/.config/ricing/hypr/hyprland.lua`:

```lua
hl.exec_cmd("systemctl --user start hyprpolkitagent")
```

```text
Now should only ever run inside the Hyprland session.
```

# Config

hyprpolkitagent works with no config file at all. If you want to override the dialog's size/fields, create:

```bash
mkdir -p ~/.config/hyprpolkitagent
nano ~/.config/hyprpolkitagent/hyprpolkitagent.conf
```

```
general {
    password_field_width = 340
    window_width         = 320
    window_height        = 440
    show_details         = true
}
```

```text
Only the "general" section exists. Anything left out of the file falls back
to these same defaults, so an empty or missing file is fine.
```

# Testing

```bash
pkexec true
```

A graphical password dialog should appear. 

# Issue

Config Not Applying:

Tried multiple edits and restarts, but `hyprpolkitagent.conf` had no effect. Turns out Kali's packaged version (`0.1.3-2`) is still the old Qt/QML build, and config file support was only added in the later hyprtoolkit rewrite. Either build from source or wait for Kali to package the update.

