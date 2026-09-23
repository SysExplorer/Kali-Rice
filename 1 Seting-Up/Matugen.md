---
Description:
UseCase:
Configfile:
  - ~/.config/waybar
tags:
  - Ricing
---
# Docs and Sources

| DOCs                                                           | Porpose |
| -------------------------------------------------------------- | ------- |
| github.com/InioX/matugen                                       |         |
| github.com/InioX/matugen-themes                                |         |
| github.com/InioX/matugen/wiki/Usage                            |         |
| https://iniox.github.io/#matugen/getting-started               |         |
| https://iniox.github.io/#matugen/installation/                 |         |
| https://iniox.github.io/#matugen/configuration                 |         |
| https://github.com/InioX/matugen/blob/main/example/config.toml |         |

# Installation

sudo apt install cargo -y
cargo install matugen --root ~/.local

which matugen
matugen --version

mkdir -p ~/.config/ricing/matugen/templates
touch ~/.config/ricing/matugen/config.toml

ln -sfn ~/.config/ricing/matugen ~/.config/matugen



# Disable Systemd autostart




# Autostart with Hyprland




# Config


wallpaper image
      │
matugen image <img> -m dark
      │
      ├─ templates/colors.css   → ~/.config/ricing/waybar/colors.css   → hook: reload waybar
      ├─ templates/colors.css   → ~/.config/ricing/swaync/colors.css   → hook: swaync-client -rs
      ├─ templates/colors.css   → ~/.config/ricing/wofi/colors.css
      ├─ templates/colors.css   → ~/.config/ricing/walker/themes/...
      ├─ templates/hyprlock     → ~/.config/ricing/hypr/hyprlock colors
      └─ templates/hyprland.lua → ~/.config/ricing/hypr/colors.lua (borders, etc.)

