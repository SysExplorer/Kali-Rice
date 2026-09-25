---
Description:
UseCase:
Configfile:
  - ~/.config/ricing/matugen
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
|                                                                |         |

# Installation

```bash
sudo apt install cargo -y
cargo install matugen --root ~/.local
```

Confirm:

```bash
which matugen
matugen --version
```

# Config

Create the config file and template directory:

```bash
nano ~/.config/ricing/matugen/config.toml
```

Paste inside:

```toml
[config]
version_check = false
fallback_color = "#ffbf9b"
prefer = "closest-to-fallback"
caching = false
source_color_index = 1


[templates.hypr]
input_path = '~/.config/ricing/matugen/templates/template.lua'
output_path = '~/.config/ricing/hypr/colors.lua'
pre_hook = ''
post_hook = ''


[templates.waybar]
input_path = '~/.config/ricing/matugen/templates/template.css'
output_path = '~/.config/ricing/waybar/colors.css'
pre_hook = ''
post_hook = 'pkill -SIGUSR2 waybar'


[templates.wofi]
input_path = '~/.config/ricing/matugen/templates/template.css'
output_path = '~/.config/ricing/wofi/colors.css'
pre_hook = ''
post_hook = ''


[templates.swaync]
input_path = '~/.config/ricing/matugen/templates/template.css'
output_path = '~/.config/ricing/swaync/colors.css'
pre_hook = ''
post_hook = 'swaync-client --reload-css'


[templates.walker]
input_path = '~/.config/ricing/matugen/templates/template.toml'
output_path = '~/.config/ricing/walker/colors.toml'
pre_hook = ''
post_hook = ''


[templates.snappy_switcher]
input_path = '~/.config/ricing/matugen/templates/template.ini'
output_path = '~/.config/ricing/snappy-switcher/themes/colors.ini'
pre_hook = ''
post_hook = ''
```

## Templates

Different templates are used based on each app's config file format:

- lua for: hypr
- css for: waybar, wofi, swaync
- toml for: walker
- ini for: snappy-switcher
- json for:

### Lua (Hypr)

```bash
nano ~/.config/ricing/matugen/templates/template.lua
```

Paste inside:

```lua
return {
    -- ── Backgrounds (transparent) ──
    default_background   = "{{ base16.base00.default.hex_alpha | set_alpha: 0.80 }}",
    lighter_background   = "{{ base16.base01.default.hex_alpha | set_alpha: 0.80 }}",

    -- ── Monotone (opaque) ──
    selection_background  = "{{ base16.base02.default.hex }}",  -- hover/selected item
    comments              = "{{ base16.base03.default.hex }}",  -- muted/secondary text
    dark_foreground       = "{{ base16.base04.default.hex }}",  -- dim text/icons
    foreground            = "{{ base16.base05.default.hex }}",  -- main text
    light_foreground      = "{{ base16.base06.default.hex }}",  -- emphasized text
    light_background      = "{{ base16.base07.default.hex }}",  -- lightest surface, check hex

    -- ── Accents (opaque) ──
    variables  = "{{ base16.base08.default.hex }}",  -- red — error/destructive
    integers   = "{{ base16.base09.default.hex }}",  -- orange — warning
    classes    = "{{ base16.base0a.default.hex }}",  -- yellow — caution
    strings    = "{{ base16.base0b.default.hex }}",  -- green — success
    support    = "{{ base16.base0c.default.hex }}",  -- cyan — info/links
    functions  = "{{ base16.base0d.default.hex }}",  -- blue — primary accent
    keywords   = "{{ base16.base0e.default.hex }}",  -- purple — secondary accent
    deprecated = "{{ base16.base0f.default.hex }}",  -- brown — low-emphasis
}
```

### CSS (Waybar, Wofi, SwayNC)

```bash
nano ~/.config/ricing/matugen/templates/template.css
```

Paste inside:

```css
/* ── Backgrounds (transparent) ── */
@define-color default_background {{ base16.base00.default.hex_alpha | set_alpha: 0.80 }};
@define-color lighter_background {{ base16.base01.default.hex_alpha | set_alpha: 0.80 }};

/* ── Monotone (opaque) ── */
@define-color selection_background {{ base16.base02.default.hex }};  /* hover/selected item */
@define-color comments             {{ base16.base03.default.hex }};  /* muted/secondary text */
@define-color dark_foreground      {{ base16.base04.default.hex }};  /* dim text/icons */
@define-color foreground           {{ base16.base05.default.hex }};  /* main text */
@define-color light_foreground     {{ base16.base06.default.hex }};  /* emphasized text */
@define-color light_background     {{ base16.base07.default.hex }};  /* lightest surface, check hex */

/* ── Accents (opaque) ── */
@define-color variables   {{ base16.base08.default.hex }};  /* red — error/destructive */
@define-color integers    {{ base16.base09.default.hex }};  /* orange — warning */
@define-color classes     {{ base16.base0a.default.hex }};  /* yellow — caution */
@define-color strings     {{ base16.base0b.default.hex }};  /* green — success */
@define-color support     {{ base16.base0c.default.hex }};  /* cyan — info/links */
@define-color functions   {{ base16.base0d.default.hex }};  /* blue — primary accent */
@define-color keywords    {{ base16.base0e.default.hex }};  /* purple — secondary accent */
@define-color deprecated  {{ base16.base0f.default.hex }};  /* brown — low-emphasis */
```

### TOML (Walker)

```bash
nano ~/.config/ricing/matugen/templates/template.toml
```

Paste inside:

```toml
# ── Backgrounds (transparent) ──
default_background   = "{{ base16.base00.default.hex_alpha | set_alpha: 0.80 }}"
lighter_background   = "{{ base16.base01.default.hex_alpha | set_alpha: 0.80 }}"

# ── Monotone (opaque) ──
selection_background  = "{{ base16.base02.default.hex }}"  # hover/selected item
comments              = "{{ base16.base03.default.hex }}"  # muted/secondary text
dark_foreground       = "{{ base16.base04.default.hex }}"  # dim text/icons
foreground            = "{{ base16.base05.default.hex }}"  # main text
light_foreground      = "{{ base16.base06.default.hex }}"  # emphasized text
light_background      = "{{ base16.base07.default.hex }}"  # lightest surface, check hex

# ── Accents (opaque) ──
variables  = "{{ base16.base08.default.hex }}"  # red — error/destructive
integers   = "{{ base16.base09.default.hex }}"  # orange — warning
classes    = "{{ base16.base0a.default.hex }}"  # yellow — caution
strings    = "{{ base16.base0b.default.hex }}"  # green — success
support    = "{{ base16.base0c.default.hex }}"  # cyan — info/links
functions  = "{{ base16.base0d.default.hex }}"  # blue — primary accent
keywords   = "{{ base16.base0e.default.hex }}"  # purple — secondary accent
deprecated = "{{ base16.base0f.default.hex }}"  # brown — low-emphasis
```

### INI (Snappy-switcher)

```bash
nano ~/.config/ricing/matugen/templates/template.ini
```

Paste inside:

```ini
; ── Backgrounds (transparent) ──
default_background   = {{ base16.base00.default.hex_alpha | set_alpha: 0.80 }}
lighter_background   = {{ base16.base01.default.hex_alpha | set_alpha: 0.80 }}

; ── Monotone (opaque) ──
selection_background  = {{ base16.base02.default.hex }}  ; hover/selected item
comments              = {{ base16.base03.default.hex }}  ; muted/secondary text
dark_foreground       = {{ base16.base04.default.hex }}  ; dim text/icons
foreground            = {{ base16.base05.default.hex }}  ; main text
light_foreground      = {{ base16.base06.default.hex }}  ; emphasized text
light_background      = {{ base16.base07.default.hex }}  ; lightest surface, check hex

; ── Accents (opaque) ──
variables  = {{ base16.base08.default.hex }}  ; red — error/destructive
integers   = {{ base16.base09.default.hex }}  ; orange — warning
classes    = {{ base16.base0a.default.hex }}  ; yellow — caution
strings    = {{ base16.base0b.default.hex }}  ; green — success
support    = {{ base16.base0c.default.hex }}  ; cyan — info/links
functions  = {{ base16.base0d.default.hex }}  ; blue — primary accent
keywords   = {{ base16.base0e.default.hex }}  ; purple — secondary accent
deprecated = {{ base16.base0f.default.hex }}  ; brown — low-emphasis
```

### JSON

```bash
nano ~/.config/ricing/matugen/templates/template.json
```

Paste inside:

```json
{
  "default_background": "{{ base16.base00.default.hex_alpha | set_alpha: 0.80 }}",
  "lighter_background": "{{ base16.base01.default.hex_alpha | set_alpha: 0.80 }}",

  "selection_background": "{{ base16.base02.default.hex }}",
  "comments": "{{ base16.base03.default.hex }}",
  "dark_foreground": "{{ base16.base04.default.hex }}",
  "foreground": "{{ base16.base05.default.hex }}",
  "light_foreground": "{{ base16.base06.default.hex }}",
  "light_background": "{{ base16.base07.default.hex }}",

  "variables": "{{ base16.base08.default.hex }}",
  "integers": "{{ base16.base09.default.hex }}",
  "classes": "{{ base16.base0a.default.hex }}",
  "strings": "{{ base16.base0b.default.hex }}",
  "support": "{{ base16.base0c.default.hex }}",
  "functions": "{{ base16.base0d.default.hex }}",
  "keywords": "{{ base16.base0e.default.hex }}",
  "deprecated": "{{ base16.base0f.default.hex }}"
}
```

## Output Files

Create the output file for each app based on its config file type:

```bash
cd ~/.config/ricing/
touch hypr/colors.lua
touch {waybar,wofi,swaync}/colors.css
touch walker/colors.toml
touch snappy-switcher/themes/colors.ini
```

## App Integration

Add these on top of each app's config file based on the config format, then change each element's color to fit/match:

```text
for lua: require(path/to/file)
for css: @import
for toml: require(path/to/file)
for ini: require(path/to/file)
for kson: require(path/to/file)
```

# Work Flow

1. **Wallpaper picker (Walker)** selects an image and stores its path in a variable.
2. **awww** sets the wallpaper using that variable.
3. **Matugen** regenerates the colors from the same image variable.
4. **Hyprlock (lock screen) and SDDM (greeter)** wallpapers are also driven by the same variable, so everything, desktop, lock screen, and login screen stays in sync with one source of truth.


# Test

```bash
matugen -c  ~/.config/ricing/matugen/config.toml image ~/Pictures/Wallpapers/wallhaven-d8gygl.png --source-color-index 0 -m smart -b wal
```
