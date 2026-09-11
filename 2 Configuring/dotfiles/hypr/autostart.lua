-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
   hl.on("hyprland.start", function ()
--   hl.exec_cmd("waybar")
     hl.exec_cmd("waybar -c ~/.config/ricing/waybar/config -s ~/.config/ricing/waybar/style.css")
--   hl.exec_cmd("kitty nvim")
     hl.exec_cmd("kitty")
   end)

