---
Description:
UseCase:
Configfile:
  - ~/.config/ricing/swaync/
tags:
  - Ricing
  - Notifications
---
# Docs and Sources

| DOCs                                                                  | Porpose                                                                                         |
| --------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| github.com/ErikReider/SwayNotificationCenter#debian                   | `Installation` – install per distro (Debian/Kali = `sudo apt install sway-notification-center`) |
| manpages.debian.org/testing/sway-notification-center/swaync.1.en.html | `CLI` – swaync / swaync-client flags (`-c`, `-s`, `-t`, `-R`, `-rs`)                            |
| manpages.debian.org/testing/sway-notification-center/swaync.5.en.html | `Config` – config.json / style.css format reference                                             |
| man.archlinux.org/man/swaync.5.en                                     | `Config` – same reference, Arch's mirror of the man page                                        |
| `man swaync` / `man swaync-client`                                    | `CLI` – local copy of the same reference after install                                          |
| wiki.archlinux.org/title/Desktop_notifications                        | `D-Bus` – how notification servers register via activation, handling multiple servers           |
| specifications.freedesktop.org/notification/latest/                   |                                                                                                 |

# Installation

Installed with `sudo apt install sway-notification-center -y`

```text
Pulls in swaync (the daemon) and swaync-client (CLI to control it), plus the
default config/style shipped under /etc/xdg/swaync/.
```

# Disable Systemd autostart

Disabled the systemd service so swaync doesn't start on its own and is only launched when explicitly told to:

```bash
sudo systemctl --global disable swaync
systemctl --user disable swaync.service
```

Verified it was disabled:

```bash
systemctl --user is-enabled swaync.service
```

# Config

Create a custom config directory under `~/.config/ricing/swaync/` and copied the default configs into it:

```bash
mkdir -p ~/.config/ricing/swaync
cp /etc/xdg/swaync/config.json ~/.config/ricing/swaync/
cp /etc/xdg/swaync/style.css ~/.config/ricing/swaync/
```

# Autostart with Hyprland

Added swaync to the `Autostart` section of `~/.config/ricing/hypr/hyprland.lua`, alongside Waybar, pointing it at our custom config folder path so it launches together with the session:

```lua
hl.on("hyprland.start", function ()
  hl.exec_cmd("waybar -c ~/.config/ricing/waybar/config -s ~/.config/ricing/waybar/style.css")
  hl.exec_cmd("swaync -c ~/.config/ricing/swaync/config.json -s ~/.config/ricing/swaync/style.css")
  hl.exec_cmd("kitty")
end)
```

```text
Runs swaync as soon as the Hyprland session starts, since the systemd service
is disabled and it needs to be launched manually from the compositor's
autostart hook.
```

# Preventing KDE's notification daemon from taking over

KDE packages are also installed on this system, and KDE's own notification daemon registers itself as the `org.freedesktop.Notifications` D-Bus service too. Only one daemon can own that name at a time, so if KDE's claims it first, swaync's notifications silently stop showing.

Created a user-level D-Bus service override so this bus name always resolves to swaync instead of KDE's daemon:

```bash
mkdir -p ~/.local/share/dbus-1/services

cat > ~/.local/share/dbus-1/services/org.freedesktop.Notifications.service << 'EOF'
[D-BUS Service]
Name=org.freedesktop.Notifications
Exec=/usr/bin/swaync
SystemdService=swaync.service
EOF
```

```text
~/.local/share/dbus-1/services/ is checked by D-Bus before the system-wide
/usr/share/dbus-1/services/, so this file takes priority over KDE's service
file without needing root or touching any system package files. Logged out
and back in once for D-Bus to pick it up.
```

# Testing

```bash
systemctl --user status swaync.service
busctl --user list | grep Notifications
notify-send "Test" "Hello from swaync"
```

```text
Confirms swaync is running, confirms it (not KDE) owns the notification bus
name, and confirms a popup actually appears.
```

# Binding

Bound to a key in `~/.config/ricing/hypr/hyprland.lua`, under the keybinds section, to toggle the notification/control center panel:

```lua
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
```

```text
-t toggles the control center panel, -sw also grabs focus so it responds to
input immediately. Runs only when the keybind is pressed.
```

Tst by pressing `mainMod + N`. Them logout with `mainMod + M` and login back and do the test again.