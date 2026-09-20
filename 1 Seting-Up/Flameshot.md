---
Description:
UseCase:
Configfile:
tags:
  - Ricing
  - Screenshot
---
# Docs and Sources

| DOCs                                            | Porpose                                                                                      |
| ----------------------------------------------- | -------------------------------------------------------------------------------------------- |
| flameshot.org/docs/guide/wayland-help/          | `Config` – Flameshot's Wayland notes, portal packages and the Hyprland rule ours is based on |
| wiki.hypr.land/Configuring/Basics/Window-Rules/ | `Config` – Lua window rule syntax, match props and effects                                   |
| wiki.hypr.land/FAQ/                             | `Config` – Hyprland's note on Flameshot's limited Wayland support                            |
| github.com/hyprwm/Hyprland/discussions/12811    | `Issue` – old Flameshot rules broke after the window rule rewrite (small floating window)    |
| github.com/flameshot-org/flameshot/issues/4948  | `Reference` – why the overlay is a fullscreen window and reflows tiling layouts              |

# Installation

Installed with `sudo apt install flameshot -y`

# Autostart with Hyprland

Added to the `Autostart` section of `~/.config/ricing/hypr/hyprland.lua`:

```lua
hl.exec_cmd("flameshot")
```

# Config

Hyprland needs a window rule to make flameshot window behave like an overlay. Added to the window rules section of `~/.config/ricing/hypr/hyprland.lua`:

```lua

-- Flameshot capture overlay Behavior
hl.window_rule({
    name = "flameshot-overlay",  -- label to find/disable the rule
    match = { class = "flameshot", initial_title = "^flameshot$" },
    -- Targets the overlay only not the config window
    no_anim = true,              -- no zoom-in, so it feels like an overlay
    float = true,                -- out of tiling, no layout reflow, allows move/size
    pin = true,                  -- on all workspaces, above other floating windows
    rounding = 0,                -- no rounded corners
    border_size = 0,             -- no border
    move = {0, 0},               -- top-left of the screen
    size = {"monitor_w", "monitor_h"},  -- cover the whole monitor
    suppress_event = "fullscreen",      -- ignore Flameshot's fullscreen request
})

```


Note: Multi-monitor not tested yet, `size` may need adjusting.

# Binding

Bound to a key in `~/.config/ricing/hypr/hyprland.lua`, under the keybinds section:

```lua
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("flameshot gui"))
```

# Testing

Press `SUPER + SHIFT + P` and flameshot should show as an overlay. The overlay should cover the screen with no border and no zoom-in animation.

Then open the settings window, it should be a normal window you can move and close:

```bash
flameshot config
```
