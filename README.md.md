## Brief

My goal for this ricing project is to build a complete, fully-functioning Hyprland rice on Kali that matches my taste and vibe, while keeping a complete, fully-functioning KDE Plasma DE as a fallback. The two must stay fully isolated: no KDE or Kali-specific config change or daemon function change made for the rice be present or affect KDE plasma DE to prevent overwrite, break, or interfere with KDE or Kali's default apps, tools, or configs. And also Nothing should break on a system update, and switching back to KDE Desktop should always feel untouched.

> UI should control system functionality through default, stable system CLI and Backend or core functionality rather than implementing the functionality itself, so nothing breaks upon updates.

**Separation model:** Riced and Normal Desktop sessions are separated through session-scoped autostart, never global autostart. Every daemon, or config the rice depends on must start via Hyprland's own auto start config, never as a globally-enabled systemd user service, and never via an autostart entry that fires regardless of session.

**Per-app config strategy:** Every app or tool specific to the rice is disabled by default and gets to run on Hyprland session else disabled and for any app, service and daemons that overlap will have up to 3 separate config files: a `-default` Kali/KDE baseline, and a `-rice` (Hyprland-specific). At session start:

- **Hyprland session:** `exec-once` in the Hyprland config file for any shared app, that will copy our customized config file to the App/tool config file fully replacing the live config with the rice version on session start.
- **KDE/Plasma session:** same thing happens here with a script in autostart restoring the baseline.
- If a component ships as a systemd unit, it stays `disabled` at the systemd level and is started/stopped manually from hyprland config file, so it only ever runs inside the Hyprland session.

The result: two sessions that never leak into each other, even for apps that are used in both Riced and Normal DE session.