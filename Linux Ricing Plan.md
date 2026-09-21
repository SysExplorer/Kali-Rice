![[Rice-Goal-Output-Video.mp4]]
# Ongoing

- [ ] Waybar and system-control basics
- [ ] Matugen
- [ ] GTK/Qt - icon - cursor - Fonts
- [ ] Fonts manager - File manager - Waypaper
- [ ] OBS
- [ ] Night light and the system info window
- [ ] Glass and desktop widgets
- [ ] Hyprland Dock (nwg-dock-hyprland)
- [ ] 


## Apps / Software to Consider

| Software / Apps                                                | Function                                                                                                                                             |
| -------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| [[Hyprland]]                                                   | Compositor and Window Manager                                                                                                                        |
| [[Waybar]]                                                     | Status Bar (indicators or either open wofi or swaync center interactive controls)                                                                    |
| [[Hypr Dock]]                                                  |                                                                                                                                                      |
| [[Wofi]]                                                       | Launcher, Menus and all list-based and prompt-based interactions                                                                                     |
| Kitty                                                          | Quick Terminal (+a quake mode with bind)                                                                                                             |
| Wave                                                           | Work Terminal                                                                                                                                        |
| [[SwayNC]]                                                     | Notification Daemon + Quick Actions / Control Center (toggles, sliders, mpris, calendar, uptime and System Stats)                                    |
| wob                                                            | Standalone OSD centered overlay for volume/brightness/mic-mute/theme changed/wallpaper changed (may ditched in favor of swaync manual Notifications) |
| [[awww]]                                                       | Wallpaper Manager                                                                                                                                    |
| Matugen & waypaper                                             | Dynamic Theme Engine + wallpaper UI                                                                                                                  |
| [[Hyprlock & Hypridle]]                                        | Lock Screen & Idle Management                                                                                                                        |
| [[Cliphist]], wl-clipboard                                     | Clipboard (Wofi-integrated)                                                                                                                          |
| Thunar, Dolphin, Nemo                                          | File Manager                                                                                                                                         |
| [[Flameshot]]                                                  | Screenshot                                                                                                                                           |
| [[OBS Studio]], wl-screenrec                                   | Screen Recording                                                                                                                                     |
| PipeWire, WirePlumber, pavucontrol                             | Audio                                                                                                                                                |
| NetworkManager, nmcli                                          | Network                                                                                                                                              |
| BlueZ, bluetoothctl                                            | Bluetooth                                                                                                                                            |
| [[hyprpolkitagent]]                                            | Authentication                                                                                                                                       |
| SDDM, greetd                                                   | Login / Greeter                                                                                                                                      |
| xdg-desktop-portal, xdg-desktop-portal-hyprland                | Wayland Portal                                                                                                                                       |
| Custom created icons (may switch to Papirus + papirus-folders) | Icon Theme                                                                                                                                           |
| Neovim                                                         | Text Editor                                                                                                                                          |
| VS Code                                                        | Code Editor (theme target)                                                                                                                           |
| Opencode                                                       | Coding Tool (theme target)                                                                                                                           |
| Brave                                                          | Coding Tool (theme target)                                                                                                                           |
| Firefox                                                        | Coding Tool (theme target)                                                                                                                           |
| Obsidian                                                       | Coding Tool (theme target)                                                                                                                           |

## Machine

- OS: Kali GNU/Linux Rolling x86_64
- DE: KDE Plasma 6.7.4
- WM: KWin (Wayland)
- CPU: AMD Ryzen 5 8645HS (12) @ 5.02 GHz
- GPU 1: NVIDIA GeForce RTX 2050 [Discrete]
- GPU 2: AMD Radeon 760M Graphics [Integrated]
- Memory: 3.90 GiB / 14.86 GiB (26%)


## Functionalties
### Window Management

- [x]  Tiling
- [x]  Scroll layout
- [ ]  Floating windows
- [ ]  Normal / windowed mode (floating with borders)
- [x]  Window borders
- [x]  Window background effects
- [ ]  Workspace management
- [ ]  Workspace indicators
- [ ]  Special workspaces

### Launching

- [x]  Application menu / launcher: Wofi
- [x]  Application search
- [ ]  Active applications / window switcher
- [ ]  Tab / window switching
- [ ]  Quick file opener
- [ ]  Layout change per app
- [ ]  Bookmark search
- [ ]  Shortcut cheat sheet panel
- [ ]  Theme changer (via Wofi)


> Wofi is the single interface surfacing several features that also appear under their own categories below: clipboard (via cliphist), calculator, theme changer, wallpaper picker, Wi-Fi picker, Bluetooth picker, power profiles, and power controls (poweroff, sleep, etc.).

### Waybar / SwayNC / OSD Implications

_(New section — captures the full click-routing and display/interaction split worked out for status, notifications, quick settings, and on-screen displays.)_

| Function                                                       | Display                                                                                                     | Interaction                                                                                                    |
| -------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| Wi-Fi                                                          | Waybar + SwayNC                                                                                             | Wofi list (scan / connect / password-prompt mode)                                                              |
| Bluetooth                                                      | Waybar + SwayNC                                                                                             | Wofi list (bluetoothctl-backed device list + pairing)                                                          |
| Sound (volume)                                                 | Waybar (%)                                                                                                  | SwayNC slider widget (click path)                                                                              |
| Brightness                                                     | Waybar (%)                                                                                                  | SwayNC slider widget (click path)                                                                              |
| OSD (volume / brightness / mic-mute)                           | wob — standalone, centered, independently positioned                                                        | None — auto-appears on keybind-triggered change only, no click needed                                          |
| Airplane mode                                                  | SwayNC                                                                                                      | SwayNC toggle button                                                                                           |
| Media (mpris)                                                  | SwayNC + lock screen                                                                                        | SwayNC mpris widget                                                                                            |
| Per-app volume mixer                                           | Quickshell (dynamic, auto-detecting) or static SwayNC sliders per hardcoded app                             | SwayNC slider (static) or Quickshell widget (dynamic)                                                          |
| Power (sleep / suspend / hibernate / shutdown / reboot / lock) | —                                                                                                           | Wofi power menu                                                                                                |
| Power profiles                                                 | —                                                                                                           | Wofi                                                                                                           |
| Battery / charging                                             | SwayNC (`label` widget) + Waybar                                                                            | Static, tooltip only                                                                                           |
| System stats (CPU / RAM / GPU / disk / temp / network speed)   | SwayNC `label` widgets (text-block approximation) for v1, or Quickshell (real graphs/sparklines) if adopted | Static / interval refresh (SwayNC), none (Quickshell, display-only)                                            |
| Workspaces                                                     | Waybar                                                                                                      | Waybar click to switch                                                                                         |
| Time                                                           | Waybar                                                                                                      | Static                                                                                                         |
| Date                                                           | Waybar + SwayNC                                                                                             | Static; click date opens calendar                                                                              |
| Calendar                                                       | SwayNC                                                                                                      | Built-in calendar widget                                                                                       |
| Notifications + DND                                            | SwayNC (+ Waybar icon/count)                                                                                | SwayNC                                                                                                         |
| Tray                                                           | Waybar                                                                                                      | Native tray click (app-defined)                                                                                |
| Clipboard                                                      | Waybar (optional icon)                                                                                      | Wofi (cliphist backend)                                                                                        |
| Screenshot                                                     | —                                                                                                           | Flameshot's own GUI (current default); grim/slurp + Wofi save/copy/annotate only if Flameshot is dropped later |
| App launcher                                                   | —                                                                                                           | Wofi                                                                                                           |
| Calculator                                                     | —                                                                                                           | Wofi (qalc / libqalculate backend)                                                                             |
| Color picker                                                   | —                                                                                                           | Wofi + hyprpicker, or grim+slurp+pixel-read script                                                             |
| Theme changer                                                  | —                                                                                                           | Wofi                                                                                                           |
| Quick Actions panel                                            | SwayNC control center                                                                                       | SwayNC (this section directly implements the plan's own "Quick Actions" feature category)                      |
| [[Workspace Overview]]                                         |                                                                                                             |                                                                                                                |


**Key architectural rules established:**

- [ ]  **Waybar is read-only.** No sliders, no lists, no multi-step UI — just icon/text + a click that launches something else.
- [ ]  **SwayNC handles:** notifications, DND, calendar, mpris, and anything expressible as a toggle button, a drag-slider, or a static text label (including battery and basic system stats via the `label` widget trick). It has no native wifi/bluetooth scanner, device list, or text-input dialog.
- [ ]  **Wofi handles:** anything that's fundamentally a list-to-pick-from or a simple prompt/confirm — wifi networks, bluetooth devices, power menu, calculator, color picker, theme picker, clipboard history. Password entry uses Wofi's `-password` mode; confirmations are just 2-item lists.
- [ ]  **wob handles:** OSD only. It's a separate layer-shell surface, positioned independently of SwayNC's anchor — this is what allows OSDs to sit centered on screen while normal notifications and the control center sit wherever they're anchored.
- [ ]  **Quickshell is the fallback** for anything requiring real interactivity or graphics beyond the above three tools' native capabilities: live-drag sliders with animation, sparkline/graph system-stat widgets, a dynamic per-app volume mixer, and now the Rainmeter-style desktop widget layer (see below).

### Desktop Widgets (Rainmeter-style)

_(New section — captures the requirement for a highly customizable, always-visible widget layer for clock and system stats, similar to Rainmeter on Windows.)_

- [ ]  Requirement: persistent, freely-positioned desktop widgets (not a popup, not a bar module) for at least a clock and system stats (CPU / RAM / GPU / network), with full visual customization — fonts, colors, layout, real graphs/gauges rather than plain text.
- [ ]  Neither Waybar (a bar, not freeform desktop widgets) nor SwayNC (popup panel, not persistent desktop-anchored) fit this — this is a distinct third surface, closer to conky or Rainmeter itself than to a status bar or notification center.
- [ ]  **Leading candidate: Quickshell**, already flagged in this plan as an "alternative shell to evaluate later." It supports arbitrary layer-shell surfaces (so widgets can sit directly on the desktop, below or above windows as configured), real canvas/graph drawing (unlike SwayNC's text-only `label` widgets), and full QML-based styling control — closest match to Rainmeter's model of freely placed, skinnable widgets.
- [ ]  **Alternative candidates:** eww (also layer-shell based, slightly more limited widget/graphing primitives than Quickshell but lighter weight), or conky (the traditional Linux equivalent of this exact use case — far less visual customization than Quickshell/eww, but extremely lightweight and battle-tested for "just show me stats on the desktop").
- [ ]  Decision on Quickshell vs eww vs conky for this specific role is still open — worth resolving alongside the existing "Quick Shell" TBD line below, since they're now effectively the same decision.


### System Controls

#### Wi-Fi

- [ ]  Enable / disable Wi-Fi
- [ ]  List available networks
- [ ]  Connect / disconnect
- [ ]  Show current connection
- [ ]  Network status
- [ ]  Wi-Fi selection
- [ ]  Wi-Fi picker via Wofi

#### Network

- [ ]  Ethernet
- [ ]  VPN
- [ ]  Connection management
- [ ]  Connection status

#### Bluetooth

- [ ]  Enable / disable Bluetooth
- [ ]  Device discovery
- [ ]  Pairing
- [ ]  Connect / disconnect
- [ ]  Device battery status
- [ ]  Bluetooth picker via Wofi

#### Audio

- [ ]  Volume control
- [ ]  Mute / unmute
- [ ]  Output device switching
- [ ]  Input device switching
- [ ]  Per-application volume
- [ ]  Microphone mute

#### Brightness

- [ ]  Brightness control
- [ ]  Increase / decrease brightness
- [ ]  Set brightness level
- [ ]  Per-monitor brightness where supported

#### Power

- [ ]  Battery status
- [ ]  Charging status
- [ ]  Power profiles (selectable via Wofi)
- [ ]  Sleep
- [ ]  Suspend
- [ ]  Hibernate
- [ ]  Shutdown
- [ ]  Reboot
- [ ]  Lid behavior
- [ ]  Lock screen
- [ ]  Poweroff / sleep menu via Wofi

### Notifications & Media

#### Notifications

- [x]  Display notifications
- [x]  Notification history
- [ ]  Notification grouping
- [x]  Do-not-disturb mode
- [x]  Clear notifications
- [ ]  Notification actions
- [x]  Notification center / control center
- [ ]  Waybar integration
- [ ]  Dynamic wallpaper-based theming OSD
- [ ] OSDs

#### Media

- [ ]  Play / pause
- [ ]  Previous / next
- [ ]  Current track
- [ ]  Artist
- [ ]  Album artwork
- [ ]  Playback status
- [ ]  Listening status
- [ ]  Waybar integration
- [ ]  Media controls on the lock screen

### System Information

- [ ]  CPU usage
- [ ]  RAM usage
- [ ]  GPU usage
- [ ]  Storage usage
- [ ]  Network usage
- [ ]  Temperature
- [ ]  Battery
- [ ]  Time
- [ ]  Date
- [ ]  Clock

### Wallpaper & Appearance

#### Wallpaper

- [ ]  Browse wallpapers
- [ ]  Wallpaper selection
- [ ]  Instant wallpaper switching
- [x]  Wallpaper transitions
- [ ]  Multi-monitor support
- [ ]  Wofi integration (wallpaper picker)
- [ ]  Wallpaper-based color generation
- [ ]  Wallpaper daemon handles display and transitions behind Wofi's picker

#### Dynamic Theming

- [ ]  Extract colors from the current wallpaper
- [ ]  Generate a consistent color palette
- [ ]  Apply colors to the desktop
- [ ]  Apply colors to the status bar (Waybar)
- [ ]  Apply colors to the launcher (Wofi)
- [ ]  Apply colors to notifications
- [ ]  Apply colors to the terminal
- [ ]  Apply colors to GTK
- [ ]  Apply colors to Qt
- [ ]  Apply colors to the lock screen
- [ ]  Apply colors to the greeter
- [ ]  Reload affected applications automatically
- [ ]  Keep a shared color source while allowing separate configurations

#### Color Themes

- [ ]  Terminal
- [ ]  Opencode
- [ ]  VS Code

#### GTK / Qt Appearance

- [ ]  I will probably custom create mine including the floating window controls
- [ ]  GTK application styling
- [ ]  Qt application styling
- [ ]  Dark / light mode
- [ ]  Dynamic wallpaper-based colors
- [ ]  Consistent appearance across applications

#### Icons

- [ ]  Application icons
- [ ]  File icons
- [ ]  System icons
- [ ]  Consistent icon set
- [ ]  Theme integration
- [ ]  Decide whether icons themselves should dynamically change
- [ ]  Selected icon theme: Papirus + papirus-folders (custom icon set planned for later)

#### Cursor

- [ ]  Cursor style
- [ ]  Cursor size
- [ ]  Theme integration

#### Fonts

- [ ]  UI font
- [ ]  Terminal font
- [ ]  Waybar font
- [ ]  Nerd Font
- [ ]  Icon font

### Authentication & Session

#### Lock Screen

- [x]  Lock / unlock
- [x]  Password authentication
- [ ]  Dynamic wallpaper
- [ ]  Dynamic colors
- [x]  Clock
- [ ]  Media controls
- [ ]  Power controls
- [ ]  Separate configuration from the greeter
- [ ]  Option to use a different theme from the desktop

#### Login / Greeter

- [ ]  Login screen
- [ ]  User selection
- [ ]  Session selection
- [ ]  Shutdown / reboot
- [ ]  Dynamic wallpaper
- [ ]  Dynamic colors
- [ ]  Separate configuration from the lock screen
- [ ]  Option to use a different theme from the desktop

#### Privileged Actions

- [x]  Graphical authentication dialogs
- [x]  Authentication for privileged actions from graphical applications

### Clipboard & File Management

#### Clipboard

- [x]  Clipboard history
- [x]  Text history
- [x]  Image history
- [x]  Search
- [x]  Wofi integration (via cliphist)

#### File Management

- [ ]  File browsing
- [ ]  Open files
- [ ]  Copy / move
- [ ]  Delete
- [ ]  Trash
- [ ]  Mount / unmount drives
- [ ]  Thumbnails
- [ ]  Archive handling
- [ ]  Theme and icon integration
- [ ]  Other pro features related to connecting to remote drives and more

### Screenshots & Recording

#### Screenshots

- [ ]  Full screen
- [ ]  Window
- [ ]  Region
- [ ]  Copy to clipboard
- [ ]  Save to file
- [ ]  Optional annotation

#### Screen Recording

- [ ]  Full screen
- [ ]  Window
- [ ]  Region
- [ ]  System audio
- [ ]  Microphone
- [ ]  Recording indicator

### Display & Session Management

#### Idle Management

- [x]  Detect inactivity
- [x]  Automatic screen locking
- [ ]  Display sleep
- [ ]  Suspend
- [ ]  Idle inhibition while watching media

#### Display Management

- [ ]  Resolution
- [ ]  Refresh rate
- [ ]  Scaling
- [ ]  Monitor positioning
- [ ]  Multi-monitor configuration
- [ ]  Display profiles

#### Night Light

- [ ]  Blue-light reduction
- [ ]  Automatic schedule
- [ ]  Manual color temperature

#### System Tray

- [ ]  Tray applications
- [ ]  Network / VPN applications
- [ ]  Background applications

### Desktop Utilities

#### Notes and Code

- [ ]  Neovim for terminals and light edits (will use fzf with it)
- [ ]  VS Code for real job
- [ ]  Obsidian as main notes app

#### OSD

- [ ]  Volume
- [ ]  Brightness
- [ ]  Microphone mute
- [ ]  Media controls
- [ ]  Other system feedback
- [ ]  Wallpaper-based theme
- [ ]  **Resolved:** wob, standalone centered overlay, keybind-triggered only (see implications table above)

#### Desktop Widgets

- [ ]  CPU usage
- [ ]  RAM usage
- [ ]  GPU usage
- [ ]  Network
- [ ]  Weather
- [ ]  Clock
- [ ]  Other system information
- [ ]  **Resolved direction:** Rainmeter-style persistent, freely-positioned, highly customizable widgets — leading candidate Quickshell, alternatives eww / conky (see Desktop Widgets section above)

#### Calculator

- [ ]  Quick calculations
- [ ]  Unit conversion
- [ ]  Wofi integration

#### Color Picker

- [ ]  Pick a color from the screen (grab HEX from screen)
- [ ]  HEX / RGB output
- [ ]  Copy to clipboard
- [ ]  Wofi integration

#### Quick Actions

- [ ]  Wi-Fi
- [ ]  Bluetooth
- [ ]  Brightness
- [ ]  Volume
- [ ]  Do-not-disturb
- [ ]  Power profile
- [ ]  Dark / light mode
- [ ]  Other frequently used system controls
- [ ]  **Resolved:** this is SwayNC's control center (see implications table above)

#### Search

- [x]  Applications
- [ ]  Files
- [ ]  Windows / Tabs
- [ ]  Bookmarks
- [ ]  Commands

### Terminal & Shell

#### Terminal

- [ ]  Kitty (if I can't find a better one)
- [ ]  Terminal customization
- [ ]  Transparency
- [ ]  Visual effects
- [ ]  Dynamic wallpaper-based theme
- [ ]  Fastfetch on shell start, with custom ASCII art
- [ ]  btop for in-terminal system stats
- [ ]  Neovim, used instead of Kate as the text editor

#### Work Terminal

- [ ]  Wave
- [ ]  Development / work environment
- [ ]  May be dropped later

#### Shell

- [ ]  Zsh
- [ ]  Command completion
- [ ]  Syntax highlighting
- [ ]  Prompt customization

### Wayland & Desktop Integration

#### Wayland / Desktop Integration

- [ ]  Screen sharing
- [ ]  Screenshot integration
- [ ]  File chooser
- [ ]  Browser integration
- [ ]  Flatpak integration
- [ ]  Graphical authentication
- [ ]  Desktop application integration

### Features Yet to Be Decided

_(Resolved items from this and prior discussion have been removed or annotated above; only genuinely open items remain.)_

- [ ]  Exact wallpaper manager
- [ ]  Exact dynamic theme engine
- [ ]  Exact GTK theme
- [ ]  Exact Qt theme
- [ ]  Exact cursor theme
- [ ]  Exact font(s)
- [ ]  Exact lock screen
- [ ]  Exact greeter
- [ ]  Exact idle manager
- [ ]  Exact file manager
- [ ]  Exact screen recorder
- [ ]  Exact display-management tool
- [ ]  Exact XDG portal implementation
- [ ]  Exact Polkit agent
- [ ]  Night-light implementation
- [ ]  Workspace configuration
- [ ]  Search extensions / providers
- [ ]  System fonts and per-app fonts
- [ ]  **Quickshell vs eww vs conky** for the Rainmeter-style desktop widget layer (clock + system stats) — replaces the old, vaguer "whether 'Quick Shell' replaces or supplements Hyprland's current shell setup" line, now scoped specifically to desktop widgets rather than a general shell replacement
- [ ]  Whether Quickshell (if adopted for widgets) should also absorb the per-app volume mixer and system-stat graphing edge cases noted in the implications table, or whether those stay minimal (SwayNC labels / static sliders) for v1
## Function → App Mapping

| Functionality                                        | App Used                         |
| ---------------------------------------------------- | -------------------------------- |
| Workspaces                                           | Waybar                           |
| Time                                                 | Waybar                           |
| Tray                                                 | Waybar                           |
| Airplane mode                                        | SwayNC                           |
| Media (mpris)                                        | SwayNC                           |
| Calendar                                             | SwayNC                           |
| Quick Actions panel                                  | SwayNC                           |
| OSD (volume/brightness/mic-mute)                     | wob                              |
| Power (sleep/suspend/hibernate/shutdown/reboot/lock) | Wofi                             |
| Power profiles                                       | Wofi                             |
| App launcher                                         | Wofi                             |
| Calculator                                           | Wofi                             |
| Theme changer                                        | Wofi                             |
| Wi-Fi                                                | Waybar + SwayNC + Wofi           |
| Bluetooth                                            | Waybar + SwayNC + Wofi           |
| Sound (volume)                                       | Waybar + SwayNC                  |
| Brightness                                           | Waybar + SwayNC                  |
| Per-app volume mixer                                 | SwayNC or Quickshell             |
| Battery / charging                                   | SwayNC + Waybar                  |
| System stats (CPU/RAM/GPU/disk/temp/network)         | SwayNC or Quickshell             |
| Date                                                 | Waybar + SwayNC                  |
| Notifications + DND                                  | SwayNC + Waybar                  |
| Clipboard                                            | Waybar + Wofi                    |
| Screenshot                                           | Flameshot (or grim/slurp + Wofi) |
| Color picker                                         | Wofi + hyprpicker                |
