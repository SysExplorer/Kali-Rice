---
Description:
UseCase:
Configfile:
  - ~/.config/waybar
tags:
  - Ricing
---
# Docs and Sources

| DOCs                    | Porpose |
| ----------------------- | ------- |
| codeberg.org/LGFae/awww |         |
| <br>                    |         |
|                         |         |


|DOCs|Porpose|
|---|---|
|codeberg.org/LGFae/awww|`Installation` + `Usage` – upstream repo, build deps, subcommands, transitions|
|github.com/LGFae/swww|`Archive` – the old repo, read-only since the rename|
|codeberg.org/LGFae/awww/src/branch/main/<br>example_scripts|`Scripts` – upstream examples for cycling and randomising wallpapers|
|`man awww` / `man awww-daemon`|`CLI` – local copy of the flag reference after the man pages are installed|
|wiki.hypr.land/Configuring/Basics/Autostart/|`Autostart` – launching the daemon from the compositor instead of systemd|

```text
swww was renamed to awww ("An Answer to your Wayland Wallpaper Woes") and moved
from GitHub to Codeberg in October 2025. The GitHub repo is archived. Any guide
still saying `swww init` or `sudo apt install swww` predates that move.
```

# Installation

Not packaged in Kali's repos, so it gets built from source. Install the build and runtime dependencies first:

```bash
sudo apt install cargo rustc pkg-config libwayland-dev wayland-protocols liblz4-dev libxkbcommon-dev scdoc git -y
```

```text
cargo/rustc build it, pkg-config + libwayland-dev + wayland-protocols supply the
Wayland client headers and protocol .xml files the build looks for, liblz4-dev
is used to compress animation frames, libxkbcommon-dev is a runtime link
dependency, scdoc generates the man pages, git pulls the source.
```

Clone into a source folder kept out of the way, then build:

```bash
cd  /home/$USER/.local/bin
mkdir awww-git && cd awww-git
git clone https://codeberg.org/LGFae/awww
```

```text
Takes a few minutes on first run, cargo downloads and compiles the whole
dependency tree. The two binaries end up in target/release/.
```

Put both binaries on `PATH`:

```bash
cargo build --release
cp target/release/awww target/release/awww-daemon ~/.local/bin/
```

Confirm the shell actually finds them:

```bash
which awww awww-daemon
```

## Man pages

Generate them from the source tree and install them system-wide:

```bash
./doc/gen.sh
sudo mkdir -p /usr/local/share/man/man1
sudo cp doc/generated/*.1 /usr/local/share/man/man1/
sudo mandb
```

```text
/usr/local/share/man is the path reserved for locally installed software, so
apt never touches it. mandb rebuilds the man index so the pages are searchable.
```

Verify:

```bash
man awww
man awww-daemon
```



# Autostart

Add this to the hyperland autpostart section of the config:

```lua
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("sleep 2 && ~/.config/ricing/awww/awww-config.sh")
```

```text
awww-daemon starts the wallpaper layer,awww-config.sh waits for it and sets the image.
```

# Config

awww has no config file of its own, every setting is a flag on the command line. The rice keeps those flags in a small startup script instead:

```bash
mkdir -p ~/.config/ricing/awww
touch ~/.config/ricing/awww/awww-config.sh
chmod +x ~/.config/ricing/awww/awww-config.sh
```

Paste this into `awww-config.sh`:

```bash

#!/usr/bin/env bash

# This script is an awww wrapper, acts as your "config file" for wallpaper behavior.
# Edit the IMAGE path and the OPTS array below, then call this script from
# Hyprland's exec-once (after awww-daemon has started).

IMAGE="$HOME/Pictures/Wallpapers/Wallpaper -  (19).jpg"   # path to the image/gif to display, or a 0x hexcode >

OPTS=(

  # -a, --all
  # Sends this command to every awww-daemon namespace instead of just the default one.
  # Leave this commented out unless you're deliberately running multiple daemons.
  # -a

  -o ""                         # --outputs:  (e.g. "DP-1,eDP-1"); Screen/Monitor

  -n ""                         # --namespace: target one specific daemon namespace

  # --no-cache                  # skip writing this image to the wallpaper cache entirely
  # --no-resize                 # don't resize at all — centers the image, pads empty space with --fill-color

  --resize crop                 # no | crop | fit | stretch — how to fit the image to the screen
  --crop-gravity center         # which part to keep when cropping: center, top, bottom, left, right, or a cor>
  --fill-color 000000ff         # RRGGBBAA padding color shown when --resize no/fit leaves empty space

  -f Lanczos3                   # --filter: Nearest | Bilinear | CatmullRom | Mitchell | Lanczos3 (resize qual>

  -t wipe                       # --transition-type: none|simple|fade|left|right|top|bottom|wipe|wave|grow|cen>
  --transition-step 90          # how abruptly pixels shift per frame — lower = smoother, 255 = instant
  --transition-duration 1.5     # total transition length in seconds (ignored by the 'simple' transition)
  --transition-fps 144           # frame rate of the transition animation
  --transition-angle 30         # angle in degrees, used by 'wipe'/'wave' (0 = right→left, 90 = top→bottom)
  --transition-pos center       # center point for 'grow'/'outer': "x,y" (% as floats, px as ints) or an alias>

  # --transition-bezier .54,0,.34,.99   # custom easing curve for 'fade' — get values from cubic-bezier.com
  # --transition-wave 20,20             # width,height of the wavy edge, only used by the 'wave' transition
  # --invert-y                          # flips how the y-axis is read in --transition-pos

)

awww img "$IMAGE" "${OPTS[@]}"
```

run this to set the wallpaper for now:
`awww img path/to/image`