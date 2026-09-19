---
Description:
UseCase:
Configfile:
  - ~/.config/ricing/hypr/hyprlock.conf
  - ~/.config/ricing/hypr/hypridle.conf 
tags:
  - Ricing
  - Lock-Screen
  - Idle
---
# Docs and Sources

|DOCs|Porpose|
|---|---|
|wiki.hypr.land/Hypr-Ecosystem/hyprlock/|`Config` – hyprlock widgets, variables and options reference|
|wiki.archlinux.org/title/Hyprlock<br>|`Config` – usage notes and tips|
|github.com/hyprwm/hyprlock|`Installation` – source repo|
|github.com/hyprwm/hyprlock/blob/main/assets/example.conf|`Config` – upstream example our `hyprlock.conf` is based on|
|wiki.hypr.land/Hypr-Ecosystem/hypridle/|`Config` – hypridle `general` and `listener` options reference|
|github.com/hyprwm/hypridle|`Installation` – source repo|

# Installation

Installed with `sudo apt install hyprlock hypridle -y`

```
hyprlock is the lock screen and hypridle is the idle daemon. hypridle watches for inactivity and runs the actions we give it (dim, lock, screen off, suspend), and it calls hyprlock when it is time to lock.
```

# Autostart with Hyprland

Only hypridle needs to be started, pointing at our custom config file. Added to the `Autostart` section of `~/.config/ricing/hypr/hyprland.lua`:

```lua
  hl.exec_cmd("hypridle -c ~/.config/ricing/hypr/hypridle.conf")
```

```text
hyprlock is not autostarted. It only runs when the keybind is pressed or when hypridle tells it to lock, so it never runs outside the Hyprland session.
```

# Config

Create both config files inside the ricing folder:

```bash
touch ~/.config/ricing/hypr/hyprlock.conf
touch ~/.config/ricing/hypr/hypridle.conf
```

## Hyprlock

Paste this into `~/.config/ricing/hypr/hyprlock.conf`:

```ini
# sample hyprlock.conf
# for more configuration options, refer https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock
#
# rendered text in all widgets supports pango markup (e.g. <b> or <i> tags)
# ref. https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/#general-remarks
#
# shortcuts to clear password buffer: ESC, Ctrl+U, Ctrl+Backspace
#
# you can get started by copying this config to ~/.config/hypr/hyprlock.conf
#

$font = Monospace

general {
    hide_cursor = false
}

# uncomment to enable fingerprint authentication
# auth {
#     fingerprint {
#         enabled = true
#         ready_message = Scan fingerprint to unlock
#         present_message = Scanning...
#         retry_delay = 250 # in milliseconds
#     }
# }

animations {
    enabled = true
    bezier = linear, 1, 1, 0, 0
    animation = fadeIn, 1, 5, linear
    animation = fadeOut, 1, 5, linear
    animation = inputFieldDots, 1, 2, linear
}

background {
    monitor =
    path = screenshot
    blur_passes = 3
}

input-field {
    monitor =
    size = 20%, 5%
    outline_thickness = 3
    inner_color = rgba(0, 0, 0, 0.0) # no fill

    outer_color = rgba(33ccffee) rgba(00ff99ee) 45deg
    check_color = rgba(00ff99ee) rgba(ff6633ee) 120deg
    fail_color = rgba(ff6633ee) rgba(ff0066ee) 40deg

    font_color = rgb(143, 143, 143)
    fade_on_empty = false
    rounding = 15

    font_family = $font
    placeholder_text = Input password...
    fail_text = $PAMFAIL$FPRINTFAIL

    # uncomment if you wish to display a message during authentication
    # check_text = Authenticating...

    # uncomment to use a letter instead of a dot to indicate the typed password
    # dots_text_format = *
    # dots_size = 0.4
    dots_spacing = 0.3

    # uncomment to use an input indicator that does not show the password length (similar to swaylock's input indicator)
    # hide_input = true

    position = 0, -20
    halign = center
    valign = center
}

# TIME
label {
    monitor =
    text = $TIME # ref. https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/#variable-substitution
    font_size = 90
    font_family = $font

    position = -30, 0
    halign = right
    valign = top
}

# DATE
label {
    monitor =
    text = cmd[update:60000] date +"%A, %d %B %Y" # update every 60 seconds
    font_size = 25
    font_family = $font

    position = -30, -150
    halign = right
    valign = top
}

label {
    monitor =
    text = $LAYOUT[en,ru]
    font_size = 24
    onclick = hyprctl switchxkblayout all next

    position = 250, -20
    halign = center
    valign = center
}
```

## Hypridle

Paste this into `~/.config/ricing/hypr/hypridle.conf`:

```ini
general {
    lock_cmd = pidof hyprlock || hyprlock -c ~/.config/ricing/hypr/hyprlock.conf                         # avoid starting multiple hyprlock instances.
    before_sleep_cmd = loginctl lock-session                                  # lock before suspend.
    after_sleep_cmd = hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })'  # to avoid having to press a key twice to turn on the display.
}

listener {
    timeout = 150                                # 2.5min.
    on-timeout = brightnessctl -s set 10         # set monitor backlight to minimum, avoid 0 on OLED monitor.
    on-resume = brightnessctl -r                 # monitor backlight restore.
}

# turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
listener {
    timeout = 150                                          # 2.5min.
    on-timeout = brightnessctl -sd rgb:kbd_backlight set 0 # turn off keyboard backlight.
    on-resume = brightnessctl -rd rgb:kbd_backlight        # turn on keyboard backlight.
}

listener {
    timeout = 300                                 # 5min
    on-timeout = loginctl lock-session            # lock screen when timeout has passed
}

listener {
    timeout = 330                                                                                  # 5.5min
    on-timeout = hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })'                            # screen off when timeout has passed
    on-resume = hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })' && brightnessctl -r          # screen on when activity is detected after timeout has fired.
}

listener {
    timeout = 1800                                # 30min
    on-timeout = systemctl suspend                # suspend pc
}
```

# Binding

Bound to a key in `~/.config/ricing/hypr/hyprland.lua`, under the keybinds section, to lock the screen manually:

```lua
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock -c ~/.config/ricing/hypr/hyprlock.conf"))
```

```text
Runs hyprlock with our custom config only when the keybind is pressed.
```

# Testing

Press `SUPER + L` and the screen should lock. or:

```bash
loginctl lock-session
```