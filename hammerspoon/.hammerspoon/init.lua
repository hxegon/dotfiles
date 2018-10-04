-- Hammerspoon config by Cooper LeBrun <cooperlebrun@gmail.com>

-----------
-- SETUP --
-----------
launchBinds = {}
function bindLauncher(pre, key, appname)
  -- bind the key
  hs.hotkey.bind(pre, key, function()
    hs.application.launchOrFocus(appname)
  end)
  -- add to launchBinds
  launchBinds[#launchBinds+1]=(key .. " => " .. appname)
end

-------------
-- GLOBALS --
-------------
local prefix = {"cmd", "shift"}

--------------
-- BINDINGS --
--------------
bindLauncher(prefix, "m", "Messages")
bindLauncher(prefix, "t", "iTerm")
bindLauncher(prefix, "s", "Spotify")
bindLauncher(prefix, "b", "Firefox")
bindLauncher(prefix, "d", "Discord")
bindLauncher(prefix, "r", "Reminders")
bindLauncher(prefix, "f", "Finder")
bindLauncher(prefix, "c", "Calendar")
bindLauncher(prefix, "i", "Mail")
bindLauncher(prefix, "n", "Notes")

hs.hotkey.bind(prefix, "/", function() -- Show app launcher bindings
  hs.alert.show("PREFIX: " .. table.concat(prefix, "+") .. "\n" .. table.concat(launchBinds, "\n"), 7)
end)
