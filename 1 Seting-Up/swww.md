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


# swww quick guide

**What it is:** an efficient, animated Wayland wallpaper daemon, controlled at runtime (change wallpaper without restarting anything). Needs `wlr-layer-shell` + `xdg-output` (Hyprland supports both) and `lz4` for gif compression.

### Setup flow

1. **Install** — `sudo apt install swww` (check it's in Kali's repos; if not, you'll need to build from source with `cargo build --release`, needing rustc ≥1.75).
2. **Start the daemon** — `swww-daemon`. Note: the old `swww init` command is **deprecated** (dropped mid-2024) — some older guides/blog posts still reference it, ignore those. Just run `swww-daemon &` (or via your compositor's autostart, like your Waybar/SwayNC pattern).
3. **Set a wallpaper** — `swww img /path/to/image.jpg`
4. **Query state** — `swww query` (shows connected outputs, their resolution, and current wallpaper — useful before targeting a specific monitor)
5. **Kill it** — `swww kill`

For your setup specifically, it'd slot into `autostart.lua` the same way SwayNC/Cliphist do:

```lua
hl.exec_cmd("swww-daemon")
```

Then a separate bind or startup line to actually set the image with `swww img ...`.

### Core subcommands

|Command|Purpose|
|---|---|
|`swww-daemon [OPTIONS]`|Starts the daemon (run once per session)|
|`swww img <path>`|Sets an image/gif as wallpaper|
|`swww clear <RRGGBB>`|Clears to a flat color instead of an image|
|`swww query`|Lists outputs, dimensions, current wallpaper|
|`swww clear-cache`|Wipes cached processed gif frames|
|`swww kill`|Stops the daemon|

### `swww-daemon` flags

- `-f, --format <argb|abgr|rgb|bgr>` — force a specific `wl_shm` pixel format (default: argb; bgr/3-channel formats use less memory)
- `-l, --layer <background|bottom>` — which layer-shell layer to draw on (default `background`)
- `-n, --namespace <name>` — appends a namespace to distinguish multiple swww-daemon sockets (rarely needed)
- `--no-cache` — skip auto-loading the last wallpaper per output on start
- `-q, --quiet` — errors only

### `swww img` flags (the ones you'll actually tweak)

- `-o, --outputs <list>` — comma-separated output names to target (from `swww query`); omit to apply to all monitors
- `-f, --filter <Nearest|Bilinear|CatmullRom|Mitchell|Lanczos3>` — resize filter; `Nearest` for pixel art, `Lanczos3` (default) for photos
- `--resize <no|crop|fit>` — `crop` (default, fills screen), `fit` (letterbox), `no` (centered, no resize)
- `--fill-color <RRGGBB>` — padding color when `--resize no` and image is smaller than screen
- `-t, --transition-type <...>` — see table below
- `--transition-step <0–255>` — how abruptly pixels shift per frame (default 90; 2 for `simple`)
- `--transition-duration <seconds>` — total transition length (default 3; ignored by `simple`)
- `--transition-fps <n>` — transition frame rate (default 30)
- `--transition-angle <deg>` — for `wipe`/`wave` (0 = right→left, 90 = top→bottom)
- `--transition-pos <x,y | alias>` — center point for `grow`/`outer`; floats = %, ints = pixels, or aliases like `center`, `top-left`
- `--transition-bezier <f1,f2,f3,f4>` — custom easing curve (get values from cubic-bezier.com)
- `--transition-wave <width,height>` — waviness for the `wave` transition (default 20,20)

### Transition types

|Type|Effect|
|---|---|
|`simple` (default) / `none`|Fade; `none` sets step to 255 = instant|
|`fade`|Bezier-smoothed fade, cleaner than `simple`|
|`left / right / top / bottom`|Sweeps from that edge|
|`wipe`|Angled sweep (`--transition-angle`)|
|`wave`|Wipe with a wavy edge|
|`grow`|Circle grows from `--transition-pos`|
|`center`|Alias for `grow` at screen center|
|`outer`|Circle shrinks (reverse of `grow`)|
|`any`|`grow`/`outer` from a random point|
|`random`|Picks any transition at random|

Example combining a few:

```bash
swww img ~/Pictures/wall.jpg -o DP-1 -t wipe --transition-angle 30 --transition-duration 1.5
```

### Notes for your rice

- Images/gifs get cached under `$XDG_CACHE_HOME/swww` (or `~/.cache/swww`) per monitor — run `swww clear-cache` if it bloats from big gifs.
- Env var equivalents exist for most transition flags (`$SWWW_TRANSITION`, `$SWWW_TRANSITION_STEP`, `$SWWW_TRANSITION_FPS`, `$SWWW_TRANSITION_ANGLE`, `$SWWW_TRANSITION_POS`, `$SWWW_TRANSITION_BEZIER`, `$SWWW_TRANSITION_WAVE`) — handy if Matugen or a wallpaper-picker script sets these before calling `swww img`.
- Full flag list any time: `swww img --help` / `swww --help`.




# Installation

Installed with `sudo apt install <app name> -y`

```text

```

# Disable Systemd autostart

Text:

```bash


```

Text:

```bash

 
```

# Autostart with Hyprland


Text:

```bash



```

```text

```

# Config

Text:

```bash

```


# Draft

Build:
	cd  /home/$USER/.local/bin
	mkdir awww-git && cd awww-git
	sudo apt install cargo pkg-config liblz4-dev wayland-protocols libwayland-dev scdoc -y
	git clone https://codeberg.org/LGFae/awww awww-git
	cargo build --release
	cp target/release/swww target/release/swww-daemon ~/.local/bin/
Man Page:
	./doc/gen.sh
	sudo mkdir -p /usr/local/share/man/man1
	sudo cp doc/generated/.1  /usr/local/share/man/man1/
	sudo mandb
test:
	man awww
	man awww-daemon
autostart:
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("sleep 2 && ~/.config/ricing/awww/awww-config.sh")
config:
	mkdir ~/.config/ricing/awww
	nano ~/.config/ricing/awww/awww-config.sh
	chmod +x ~/.config/ricing/awww/awww-config.sh
	awww img "path/to/wallpaper/image.png"
	
Bind:


# Update

# Docs and Sources

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
git clone https://codeberg.org/LGFae/awww awww-git
```


```text
Takes a few minutes on first run, cargo downloads and compiles the whole
dependency tree. The two binaries end up in target/release/.
```

Put both binaries on `PATH`:

```bash
cargo build --release
cp target/release/swww target/release/swww-daemon ~/.local/bin/
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