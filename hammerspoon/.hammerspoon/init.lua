-- Hammerspoon config by Cooper LeBrun <cooperlebrun@gmail.com>

-------------
-- GLOBALS --
-------------
prefix = {"cmd", "shift"}

------------
-- HELPERS -
------------
function showKeys(keys)
  return table.concat(keys, "+")
end

-----------
-- SETUP --
-----------
-- custom launchOrFocus binding that makes bindings more concise,
-- and collects the bindings for use with a "display launch bindings" func
launchBinds = {} -- global to prevent garbage collection
function bindLauncher(pre, key, appname)
  -- bind the key
  hs.hotkey.bind(pre, key, function()
    hs.application.launchOrFocus(appname)
  end)
  -- add to launchBinds
  launchBinds[#launchBinds+1]=(key .. " => " .. appname)
end


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
  hs.alert.show("PREFIX: " .. showKeys(prefix) .. "\n" .. table.concat(launchBinds, "\n"), 7)
end)
