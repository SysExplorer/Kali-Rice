---
Description:
UseCase:
Configfile:
  - ~/.config/ricing/wofi/
tags:
  - Ricing
  - Dropdown-List
  - Launcher
---
# Docs and Sources

| DOCs                                 | Porpose |
| ------------------------------------ | ------- |
| https://github.com/SimplyCEO/wofi    |         |
| https://cloudninja.pw/docs/wofi.html |         |
| https://sr.ht/~scoopta/wofi/         |         |
| https://hg.sr.ht/~scoopta/wofi       |         |

# Installation

Installed with `sudo apt install wofi`

# Config

Create the ricing config folder and a matched config/style pair:

```bash
mkdir -p ~/.config/ricing/wofi
touch ~/.config/ricing/wofi/config
touch ~/.config/ricing/wofi/stylew.css
```

Paste this into `config` so it points at its matching stylesheet:

```
style=/home/<username>/.config/ricing/wofi/style.css
```

Don't forget to replace `<username>` with your actual Linux username.

```text
"style=" tells wofi which CSS file to load for this config profile. 
```

Paste this to the style config file:
##### Test Style
```
```css

@define-color bg          #0b111a;
@define-color bg_alt      #101a27;
@define-color bg_hover    #172638;
@define-color bg_selected #203448;

@define-color copper      #c9824a;
@define-color copper_soft #d99a68;

@define-color text        #e6edf5;
@define-color text_muted  #8b9aaa;
@define-color border      #26384b;


window {
    margin: 0px;
    padding: 0px;

    border: 1px solid @border;
    border-radius: 10px;

    background-color: alpha(@bg, 0.96);

    font-family: "JetBrainsMono Nerd Font";
    font-size: 14px;
}


#outer-box {
    margin: 0px;
    padding: 14px;

    background-color: transparent;
}

#input {
    margin: 0px 0px 12px 0px;
    padding: 10px 13px;

    border: 1px solid @border;
    border-radius: 7px;

    background-color: @bg_alt;
    color: @text;

    caret-color: @copper;

    box-shadow: none;
}


#input:focus {
    border: 1px solid @copper;
    box-shadow: none;
}

#scroll {
    margin: 0px;
    padding: 0px;
}


#inner-box {
    margin: 0px;
    padding: 0px;

    background-color: transparent;
}


#entry {
    margin: 2px 0px;
    padding: 8px 10px;

    border-radius: 7px;

    background-color: transparent;
    color: @text;
}


#entry:hover {
    background-color: @bg_hover;
}


#entry:selected {
    background-color: @bg_selected;

    border-left: 3px solid @copper;

    color: @text;
}


#img {
    margin-right: 10px;
}

#text {
    margin: 0px;

    color: @text;
}

#entry:selected #text {
    color: @copper_soft;
}

scrollbar {
    background-color: transparent;
}


scrollbar slider {
    min-width: 4px;
    border-radius: 4px;

    background-color: @border;
}


scrollbar slider:hover {
    background-color: @copper;
}
* ------------------------------------------------------------ */

#unselected {
    color: @text;
}


#selected {
    color: @copper_soft;
}

tooltip {
    padding: 6px 9px;

    border: 1px solid @border;
    border-radius: 6px;

    background-color: @bg_alt;
    color: @text;
}

```


Test it directly from the terminal first:

```bash
wofi --show drun --conf ~/.config/ricing/wofi/config --style ~/.config/ricing/wofi/style.css
```

An app launcher should pop up listing installed applications.

# Binding

Bound to a key in `~/.config/ricing/hypr/hyprland.lua`, under the keybinds section:

```lua
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("wofi --show drun --conf ~/.config/ricing/wofi/config --style ~/.config/ricing/wofi/style.css"))
```

```text
Runs wofi only when the keybind is pressed, pointing it at our ricing config
```

Reload Hyprland's config, then test by pressing `mainMod + L`.