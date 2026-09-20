---
Description:
UseCase:
Configfile:
  - ~/.config/ricing/snappy-switcher
tags:
  - Ricing
  - Overview
  - Window-Switcher
---
# Docs and Sources

|DOCs|Porpose|
|---|---|
|https://github.com/yayuuu/hyprland-scroll-overview|`Installation` + `Config` – scrolloverview plugin repo, hyprpm install, properties, binds|
|https://github.com/sandwichfarm/hyprexpo|`Reference` – hyprexpo, the plugin scrolloverview is based on|
|https://github.com/KZDKM/Hyprspace|`Reference` – alternative workspace overview plugin, not used|
|https://github.com/OpalAayan/snappy-switcher|`Installation` + `Usage` – active windows switcher, build deps, commands and flags|
|https://github.com/OpalAayan/snappy-switcher/blob/main/docs/CONFIGURATION.md|`Config` – every `config.ini` key (modes, theme, layout, icons, font)|

```text
Two separate tools are set up here. scrolloverview shows all workspaces at once,
snappy-switcher shows the currently open windows. They don't depend on each
```

# Workspace Overview

## Installation

Installed with Hyprland's plugin manager `hyprpm`, but its build dependencies need to be installed first:

```bash
sudo apt install cmake cpio pkg-config git g++ gcc hyprland-dev libpixman-1-dev libpango1.0-dev libcairo2-dev libdrm-dev libinput-dev libudev-dev libwayland-dev libxkbcommon-dev liblua5.4-dev -y
```

Update hyprpm, then add the plugin repo and check it was registered:

```bash
hyprpm update
hyprpm -v add https://github.com/yayuuu/hyprland-scroll-overview.git
hyprpm list
```

Enable it and load it into the running session:

```bash
hyprpm enable scrolloverview
hyprpm update
hyprpm reload -n
```

Show the currently loaded plugins:

```bash
hyprctl plugin list
```

## Autostart with Hyprland

hyprpm only remembers which plugins are enabled, it doesn't load them on its own. Added to the `Autostart` section of `~/.config/ricing/hypr/hyprland.lua`, so the plugin is loaded on every Hyprland login:

```lua
  hl.exec_cmd("hyprpm reload -n")
```

```text
"-n" makes hyprpm send a Hyprland notification if something goes wrong, such as
missing headers after an update. The command only ever runs from the Hyprland
autostart hook, so the KDE session never loads the plugin.
```

## Config

Added to `~/.config/ricing/hypr/hyprland.lua`:

```lua
hl.config({
    plugin = {
        scrolloverview = {
            gesture_distance = 300, -- how far is the "max" for the gesture
            cross_monitor_drag = true,
            scale = 0.5, -- preferred overview scale
            workspace_gap = 100,
            layout = "vertical", -- vertical, horizontal, or auto (per-monitor orientation)
            wallpaper = 2, -- 0: global only, 1: per-workspace only, 2: both
            blur = true, -- blur only the main overview wallpaper

            shadow = {
                enabled = true,
                range = 50,
            },
        },
    },
})
```

## Binding

Added under the keybinds section of `~/.config/ricing/hypr/hyprland.lua`:

```lua
-- workspace overview

local openedBySuperTab = false

local function superTabOpen()
    if hl.plugin and hl.plugin.scrolloverview then
        hl.plugin.scrolloverview.overview("on all")
        openedBySuperTab = true
    end
end

local function superTabClose()
    if openedBySuperTab and hl.plugin and hl.plugin.scrolloverview then
        hl.plugin.scrolloverview.overview("off")
        openedBySuperTab = false
    end
end

hl.bind(mainMod .. " + TAB", superTabOpen)
hl.bind(mainMod .. " + ALT_L", superTabClose, { release = true, transparent = true })
hl.bind(mainMod .. " + TAB", superTabClose, { release = true })
```

```text
The overview opens on SUPER + TAB and closes again when the keys are released.
```

# Active Windows Switcher

## Installation

Built from source and installed for the current user only. Install the build and runtime dependencies first:

```bash
sudo apt install libwayland-dev libcairo2-dev libpango1.0-dev libjson-c-dev libxkbcommon-dev libglib2.0-dev librsvg2-dev wayland-protocols -y
```

Clone into a source folder kept out of the way:

```bash
cd ~/.local/bin
mkdir -p snappy-switcher-git
git clone https://github.com/OpalAayan/snappy-switcher.git snappy-switcher-git
cd snappy-switcher-git
```

Build it and install it for our user only:

```bash
make
make install-user
```

## Config

The config folder is moved into the ricing folder so everything the rice depends on lives in one place:

```bash
mv ~/.config/snappy-switcher ~/.config/ricing/snappy-switcher
mkdir -p ~/.config/snappy-switcher
ln -s ~/.config/ricing/snappy-switcher/themes ~/.config/snappy-switcher/themes
```


Open `~/.config/ricing/snappy-switcher/config.ini` and change the default behavior to whatever suits you better:

```text
mode                  - "overview" shows every window on its own card, "context"
                        groups windows of the same app on the same workspace
                        into one card with a count badge
show_workspace_badge  - small workspace tag on each card
ignore_special        - include or skip windows from special/scratch workspaces
```

## Autostart with Hyprland

Added to the `Autostart` section of `~/.config/ricing/hypr/hyprland.lua`, pointing the daemon at the custom config path:

```lua
hl.exec_cmd("snappy-switcher --daemon -c ~/.config/ricing/snappy-switcher/config.ini")
```

## Binding

Added under the keybinds section of `~/.config/ricing/hypr/hyprland.lua`:

```lua
hl.bind("ALT + TAB", hl.dsp.exec_cmd("snappy-switcher next --workspace --mod alt"))
hl.bind("ALT + SHIFT + TAB", hl.dsp.exec_cmd("snappy-switcher prev --workspace --mod alt"))
```

```text
--workspace limits the list to windows on the current workspace. Remove it if you want the switcher to include opened windows from other workspaces too.
```

Then press `ALT + TAB` and the switcher should show up, `ALT + SHIFT + TAB` cycles backwards.