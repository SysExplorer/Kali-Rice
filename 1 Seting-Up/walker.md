---
Description:
UseCase:
Configfile:
  - ~/.config/ricing/walker
  - ~/.config/ricing/elephant
tags:
  - Ricing
  - Launcher
---
# Docs and Sources

| DOCs                                                  | Porpose |
| ----------------------------------------------------- | ------- |
| github.com/abenz1267/elephant                         |         |
| github.com/abenz1267/walker                           |         |
| benz.gitbook.io/walker/installation-and-launching<br> |         |
| benz.gitbook.io/walker/walker-and-elephant            |         |
| benz.gitbook.io/walker/customization/custom-menus     |         |

# Installation

Shared build/runtime dependencies for both Elephant and Walker:

```bash
sudo apt install golang-go playerctl libgtk-4-dev libgtk4-layer-shell-dev libpoppler-glib-dev protobuf-compiler wl-clipboard imagemagick libqalculate-dev qalc wtype jq sqlite3 libnotify-bin fd-find -y

ln -s $(which fdfind) ~/.local/bin/fd
```

# Elephant

## Installation

Built from source and installed for the current user only:

```bash
cd ~/.local/bin
mkdir elephant-git
git clone https://github.com/abenz1267/elephant elephant-git
cd elephant-git/cmd/elephant
go mod download
go build -o elephant .

```

Move the binary to `PATH`:

```bash
cp elephant ~/.local/bin/
```

Build and install the plugins:

```bash
mkdir -p ~/.config/ricing/elephant/providers
cd ~/.local/bin/elephant-git

for p in desktopapplications files bluetooth clipboard runner symbols calc menus providerlist websearch todo wireplumber playerctl aptpackages unicode bookmarks snippets; do
  cd internal/providers/$p
  go build -buildmode=plugin -o $p.so
  cp $p.so ~/.config/ricing/elephant/providers/
  cd ~/.local/bin/elephant-git
done

ls ~/.config/ricing/elephant/providers/ # You should see the plugins.

```

## Config

```bash
ln -sfn ~/.config/ricing/elephant ~/.config/elephant
```

```text
~/.config/ricing/elephant/
├── elephant.toml              # OPTIONAL main config (global settings)
├── .env                       # OPTIONAL environment variables elephant loads on start
├── desktopapplications.toml   # OPTIONAL per-provider config override
├── providerlist.toml          # OPTIONAL per-provider config override
├── clipboard.toml             # OPTIONAL per-provider config override
└── providers/                 # compiled plugin BINARIES only — nothing else goes here
    ├── desktopapplications.so
    ├── providerlist.so
    └── clipboard.so
```

## Autostart with Hyprland

Added to the `Autostart` section of `~/.config/ricing/hypr/hyprland.lua`:

```lua
hl.exec_cmd("elephant --config ~/.config/ricing/elephant/")
```

## Testing

```bash
which elephant
ls -la ~/.local/bin/elephant
elephant --config ~/.config/ricing/elephant/
elephant --config ~/.config/ricing/elephant/ listproviders
```

# Walker

## Installation

Built from source and installed for the current user only:

```bash
cd ~/.local/bin
mkdir walker-git
git clone https://github.com/abenz1267/walker.git walker-git
cd walker-git
cargo build --release
```

Move the binary to `PATH`:

```bash
cp target/release/walker ~/.local/bin/
```

## Config

```bash
mkdir -p ~/.config/ricing/walker/themes
cp ~/.local/bin/walker-git/resources/config.toml ~/.config/ricing/walker/config.toml
cp -r ~/.local/bin/walker-git/resources/themes/default ~/.config/ricing/walker/themes/default
ln -sfn ~/.config/ricing/walker ~/.config/walker
```


## Autostart with Hyprland

Added to the `Autostart` section of `~/.config/ricing/hypr/hyprland.lua`:

```lua
hl.exec_cmd("walker --gapplication-service")
```

## Binding

Bound to keys in `~/.config/ricing/hypr/hyprland.lua`, under the keybinds section:

```lua
-- App Launcher
hl.bind("ALT + SPACE", hl.dsp.exec_cmd("walker"))
-- Clipboard
hl.bind("ALT + C", hl.dsp.exec_cmd("walker -m clipboard"))
-- File Picker
hl.bind("ALT + F", hl.dsp.exec_cmd("walker -m files"))
-- Qiuck Command
hl.bind("ALT + R", hl.dsp.exec_cmd("walker -m runner"))
-- Emoji Picker
hl.bind("ALT + E", hl.dsp.exec_cmd("walker -m symbols"))
-- Calculator
hl.bind("ALT + SHIFT + C", hl.dsp.exec_cmd("walker -m calc"))
-- Tasks / Todo
hl.bind("ALT + T", hl.dsp.exec_cmd("walker -m todo"))
-- Unicode Picker
hl.bind("ALT + U", hl.dsp.exec_cmd("walker -m unicode"))
-- Snippets
hl.bind("ALT + N", hl.dsp.exec_cmd("walker -m snippets"))
-- All
hl.bind("ALT + A", hl.dsp.exec_cmd("walker -m providerlist"))
```

```text
Ones that will be integrated with waybar or swayNC:

hl.bind("ALT + ", hl.dsp.exec_cmd("walker -m wireplumber"))
hl.bind("ALT + ", hl.dsp.exec_cmd("walker -m playerctl"))
hl.bind("ALT + ", hl.dsp.exec_cmd("walker -m aptpackages"))
hl.bind("ALT + ", hl.dsp.exec_cmd("walker -m bluetooth"))
hl.bind("ALT + ", hl.dsp.exec_cmd("walker -m providerlist"))
hl.bind("ALT + ", hl.dsp.exec_cmd("walker -m bookmarks"))
hl.bind("ALT + ", hl.dsp.exec_cmd("walker -m menus"))
```

## Testing

```bash
which walker
ls -la ~/.local/bin/walker
```

```bash
elephant --config ~/.config/ricing/elephant/ &
walker --gapplication-service &  (in a separate terminal)
walker
```
