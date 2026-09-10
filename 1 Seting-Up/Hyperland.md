---
Description:
UseCase:
Configfile:
  - ~/.config/hypr/hyprland.lua
tags:
  - Ricing
---
# Docs and Sources

| DOCs                                                                     | Porpose                                                                          |
| ------------------------------------------------------------------------ | -------------------------------------------------------------------------------- |
| wiki.hypr.land/Getting-Started/Installation/                             | `Installation` – install methods per distro (Kali = `sudo apt install hyprland`) |
| github.com/hyprwm/Hyprland/blob/main/<br>example/hyprland.lua            | `Config` – upstream default config our `hyprland.lua` is based on                |
| wiki.hypr.land/Configuring/Start/                                        | `Config` – config reference and recommended settings overview                    |
| wiki.hypr.land/Getting-Started/Master-Tutorial/                          | `Config` – launch method, default keybinds, terminal, Wayland app forcing        |
| wiki.hypr.land/Nvidia/                                                   | `Kernel modesetting` + `Suspend / hibernate support` + `Config` (env vars)       |
| hypr.land/Getting-Started/<br>Master-Tutorial/#force-apps-to-use-wayland |                                                                                  |
| start-hyprland -- -h                                                     |                                                                                  |
| wiki.hypr.land/configuring/extra/systemd/                                |                                                                                  |

# Installation

Installed with `sudo apt install hyprland`

```text
Pulls in Hyprland + its runtime libs (hyprutils, aquamarine, hyprcursor, etc.)
and the XDG desktop portal for screen-sharing / file-picker support.
```

# Config

Create a config file in  `~/.config/hypr/hyprland.lua` and copy the example  template shipped in `/usr/share/hypr/hyprland.lua` to it.

```text
The example already provides monitors, programs, autostart, look-and-feel input,
keybinds and window rules, so nothing is needed from scratch.
```

Added to its `ENVIRONMENT VARIABLES` section Befor the `Permissions` Section:

```lua
-- NVIDIA: force apps to use NVIDIA's video-decode driver and GLX/OpenGL library  
-- (avoids conflicts on systems that also have Mesa installed)  
hl.env("LIBVA_DRIVER_NAME", "nvidia")  
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")  
  
-- Fix flickering in Electron / CEF apps (see https://wiki.hypr.land/Nvidia/)  
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
```

```text
LIBVA_DRIVER_NAME and __GLX_VENDOR_LIBRARY_NAME tell apps to use NVIDIA's
video-decode and OpenGL/GLX libraries, avoiding conflicts with the Mesa on the
system.
ELECTRON_OZONE_PLATFORM_HINT=auto fixes flickering in Electron/CEF apps.
```

 Then Installed `kitty` Terminal as it is the default terminal referenced by the config keybinds and hyprland-guiutils: `sudo apt install kitty hyprland-guiutils -y`

To keep all our config files organized, create a dedicated ricing folder:

```bash
mkdir -p ~/.config/ricing/hypr/
```

Move the Hyprland config into the new folder:

```bash
mv ~/.config/hypr/hyprland.lua ~/.config/ricing/hypr/hyprland.lua
```

Now tell Hyprland to use the new config when starting the session. 
Edit `/usr/share/wayland-sessions/hyprland.desktop` and change its `Exec=` line to:

```ini
Exec=/usr/bin/start-hyprland -- --config /home/<username>/.config/ricing/hypr/hyprland.lua
```

Replace `<username>` with your Linux username.


# NVIDIA driver

Installed with `sudo apt install -y nvidia-driver nvidia-cuda-toolkit nvidia-smi`

```text
Proprietary Nvidia driver (kernel module + userland), CUDA toolchain for GPU compute and nvidia-smi to query/monitor the GPU.
```

### Kernel modesetting

Added `options nvidia-current-drm modeset=1` and `options nvidia-current NVreg_PreserveVideoMemoryAllocations=1` to `/etc/modprobe.d/nvidia.conf`

```text
"options nvidia-current-drm modeset=1" Enables NVIDIA kernel modesetting (KMS) so Hyprland can draw via KMS. and "options nvidia-current NVreg_PreserveVideoMemoryAllocations=1"  Keeps GPU VRAM contents across suspend/reboot, required by the services below.
```

Regenerated Kernel initramf with `sudo update-initramfs -u` so the options load
in early boot.

### Suspend / hibernate support

Enabled these systemd services with `sudo systemctl enable nvidia-suspend.service nvidia-hibernate.service nvidia-resume.service` :

```text
nvidia-suspend.service
nvidia-hibernate.service
nvidia-resume.service
```

```text
Handle GPU state (freeze/thaw VRAM) around suspend/hibernate/resume. They work
with the NVreg_PreserveVideoMemoryAllocations option above.
```
