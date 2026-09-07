---
Description:
UseCase:
Configfile:
  - ~/.config/hypr/hyprland.lua
tags:
  - Ricing
---
# Docs and Sources

| DOCs                                                                              | Porpose                                                                         |
| --------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| https://wiki.hypr.land/Getting-Started/Master-Tutorial/                           | First-run guide: launch method, default keybinds, terminal, Wayland app forcing |
| https://wiki.hypr.land/Nvidia/                                                    | NVIDIA setup: modeset kernel module, env vars, multi-GPU workarounds            |
| https://wiki.hypr.land/Getting-Started/Master-Tutorial/#force-apps-to-use-wayland | Optional per-app: make Chromium/Electron use native Wayland not XWayland        |
| https://wiki.hypr.land/Getting-Started/Installation/                              | Install methods per distro (Kali = `sudo apt install hyprland`)                 |
| https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.lua                 | Upstream default config we base our `hyprland.lua` on                           |
| https://wiki.hypr.land/Configuring/Start/                                         | Config reference and recommended settings overview                              |

# Installation

Installed with `sudo apt install hyprland`

```text
Pulls in Hyprland + its runtime libs (hyprutils, aquamarine, hyprcursor, etc.)
and the XDG desktop portal for screen-sharing / file-picker support.
```

### Config

Create a config file in  `~/.config/hypr/hyprland.lua`  using the example template shipped in `/usr/share/hypr/hyprland.lua` 

```text
The example already provides monitors, programs, autostart, look-and-feel input,
keybinds and window rules, so nothing is needed from scratch.
```

Added to its `ENVIRONMENT VARIABLES` section:

```lua
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
```

```text
LIBVA_DRIVER_NAME and __GLX_VENDOR_LIBRARY_NAME tell apps to use NVIDIA's
video-decode and OpenGL/GLX libraries, avoiding conflicts with the Mesa on the
system.
ELECTRON_OZONE_PLATFORM_HINT=auto fixes flickering in Electron/CEF apps.
```

 Then Installed `kitty` Terminal is the default terminal referenced by the config keybinds.
 `sudo apt install kitty`

# NVIDIA driver

Installed with `sudo apt install -y nvidia-driver nvidia-cuda-toolkit nvidia-smi`

```text
Proprietary Nvidia driver (kernel module + userland), CUDA toolchain for GPU compute and nvidia-smi to query/monitor the GPU.
```

### Kernel modesetting

Added `options nvidia-current-drm modeset=1` and `options nvidia-current-drm modeset=1` to `/etc/modprobe.d/nvidia.conf`

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



# Next Steps

- Test Hyprland from a TTY: `Ctrl+Alt+F3`, log in, type `Hyprland`. Errors show
  here immediately; return to KDE with `Ctrl+Alt+F1/F2`.
- If black screen or GBM errors: add `env = GBM_BACKEND,nvidia-drm` to
  `~/.config/hypr/hyprland.lua`.
- After reboot verify modeset persisted:
  - `ls /dev/dri/` -> should list `renderD128` (AMD) and `renderD129` (NVIDIA)
  - `cat /sys/module/nvidia_drm/parameters/modeset` -> should print `Y`
