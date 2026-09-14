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

---

Description: UseCase: Configfile:

- ~/.config/waybar tags:
- Ricing

---

# Docs and Sources

|DOCs|Porpose|
|---|---|
|codeberg.org/LGFae/awww||
|<br>||
|||

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

# Disable Systemd autostart

Text:

Text:

# Autostart with Hyprland

Text:

# Config

Text:

# Draft

Build: cd /home/$USER/.local/bin mkdir awww-git && cd awww-git sudo apt install cargo pkg-config liblz4-dev wayland-protocols libwayland-dev scdoc -y git clone https://codeberg.org/LGFae/awww awww-git cargo build --release cp target/release/swww target/release/swww-daemon ~/.local/bin/ Man Page: ./doc/gen.sh sudo mkdir -p /usr/local/share/man/man1 sudo cp doc/generated/.1 /usr/local/share/man/man1/ sudo mandb test: man awww man awww-daemon autostart: hl.exec_cmd("awww-daemon") hl.exec_cmd("sleep 2 && ~/.config/ricing/awww/awww-config.sh") config: mkdir ~/.config/ricing/awww nano ~/.config/ricing/awww/awww-config.sh chmod +x ~/.config/ricing/awww/awww-config.sh awww img "path/to/wallpaper/image.png"

Bind: