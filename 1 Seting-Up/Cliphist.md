---
Description:
UseCase:
Configfile:
  - ~/.config/ricing/cliphist
tags:
  - Ricing
---
# Docs and Sources

| DOCs                                                | Porpose |
| --------------------------------------------------- | ------- |
| github.com/sentriz/cliphist#packaging               |         |
| wiki.hypr.land/Useful-Utilities/Clipboard-Managers/ |         |
| github.com/Linus789/wl-clip-persist                 |         |


# Installation

Installed with `sudo apt install cliphist wl-clipboard -y`

```
wl-clipboard provides wl-copy/wl-paste, the actual Wayland clipboard tools.
cliphist is the history layer on top: it has no daemon of its own.
```

# Config

Create a dedicated ricing folder for cliphist's config, thumbnail cache, and the image-preview script:

```bash
mkdir -p ~/.config/ricing/cliphist
touch ~/.config/ricing/cliphist/config
```

```
config      - cliphist's own settings file (db path, item limits, etc.)
```

Paste this into `config`:

```
db-path /home/<username>/.config/ricing/cliphist/db
max-items 50
max-dedupe-search 100
preview-width 60
```

```
db-path            - where the history database file lives
max-items          - how many entries are kept before oldest get dropped
max-dedupe-search  - how far back to check for exact-duplicate copies
preview-width      - max characters shown per entry in `cliphist list`, kept short here so wofi entries stay one line instead of wrapping
```

Don't forget to replace `<username>` with your actual Linux username.

Cliphist only reads this file if it knows where to look. Added to Hyprland's `ENVIRONMENT VARIABLES` section in `~/.config/ricing/hypr/hyprland.lua`, alongside the NVIDIA/Electron variables:

```lua
-- Set cliphist to read its config file from this path   
hl.env("CLIPHIST_CONFIG_PATH", "/home/<username>/.config/ricing/cliphist/config")
```

Don't forget to replace `<username>` with your actual Linux username.

```
Every cliphist invocation (the watchers below, list, decode, delete, wipe)
reads this same config automatically once the env var points at it - no
need to repeat flags on every command.
```

## Autostart with Hyprland

Added to the  `Autostart` block so Cliphist reads any text or images copied toour clipboard:

```lua
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
```

```
Each wl-paste pipe any new clipboard content into cliphist store.
```

## Binding and Wofi Integration

Paste this line to show clipboard entries:

```lua
hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd("pkill -x wofi || cliphist list | wofi -S dmenu -p \"Clipboard:\" -c ~/.config/ricing/wofi/config -s ~/.config/ricing/wofi/style.css | cliphist decode | wl-copy"))

```

And this to delete a single entry from history

```lua
hl.bind(mainMod .. " + ALT + V", hl.dsp.exec_cmd("pkill -x wofi || cliphist list | wofi -S dmenu -p \"Remove from Clipboard:\" -c ~/.config/ricing/wofi/config -s ~/.config/ricing/wofi/style.css | cliphist delete"))

```

This to wipe entire history (confirmation gate before it fires)

```lua
hl.bind(mainMod .. " + ALT + X", hl.dsp.exec_cmd("pkill -x wofi || confirm=$(echo -n \"Clear\" | wofi -S dmenu -p \"Clear Clipboard:\" -c ~/.config/ricing/wofi/config -s ~/.config/ricing/wofi/style.css); [ \"$confirm\" = \"Clear\" ] && cliphist wipe"))
```

Test each bind:

`SUPER + ALT + C ` To Open the Clipboard 
`SUPER + ALT + V` To delete an entry from Clipboard 
`SUPER + ALT + X ` To clear the Clipboard 

