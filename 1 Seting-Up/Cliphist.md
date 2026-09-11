---
Description:
UseCase:
Configfile:
  - ~/.config/waybar
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

Installed with `sudo apt install cliphist -y`

```text

```


# Quick Command guide
| command         | usage |
| --------------- | ----- |
| cliphist list   | to    |
| cliphist store  | to    |
| cliphist decode | to    |
| cliphist delete | to    |
| cliphist wipe   | to    |



# Config

### Whatch Clipboard

Text:

```bash


```



### Wofi Integration

Text:

```bash

 
```

### Key Binds


Text:

```bash



```

```text

```


Text:

```bash

```


# Draft

sudo apt install cliphist

Just to be clear, the thing actually saving what u copy and pasting it as wl-clipboard and wl-paste, ut the issue is that they only save the last copired item so they can even show a list of previuslly copied item. this where cliphist comes in, it saves what ever wl-clipboard copied as a list and can send it back to wl-paste to paste it so its just a store and we need to make it listen to whatever wl-paste have and sacve it to its stor. and since  it stors them as lists, we will just pipe it to wofi to show our copied items history as list and thats how we will be using it. to pin/clear and make items persists even when we close the original copied item source ..... 

%%
Plan:
Set copy bind 
Set paste bind (last item)
Set paste from history list bind 
Set delete from history list bind 
Set wipe history bind 
Setup config file with variables and a custom database file location

Command Samples:

hl.exec_cmd("cliphist list | wofi -S dmenu | cliphist decode | wl-copy")

hl.bind("Ctrl + C, hl.dsp.exec_cmd(""))

Planned Binds:
Ctrl + C   | copy
Ctrl + V   | paste
Ctrl + Shift + V   | paste from history
Ctrl + Shift + C    | delete selected from history
Ctrl + Shift + C      | wipe history

%%

