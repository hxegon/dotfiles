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
-- Launcher object that tidys up handling static app shortcuts
Launcher = {
  pre          = nil,
  binds        = {},
  helpDuration = 5
}
function Launcher:bind(key, appname)
  -- WARNING: This will error if you don't set pre first!
  -- bind the key
  hs.hotkey.bind(self.pre, key, function()
    hs.application.launchOrFocus(appname)
  end)
  -- add to launchBinds
  self.binds[#self.binds+1]=(key .. " => " .. appname)
end
function Launcher:helpCallback()
  return function ()
    hs.alert.show("PREFIX: " .. showKeys(self.pre) .. "\n" .. table.concat(self.binds, "\n"), self.helpDuration)
  end
end

-------------------
-- INITIALIZATION -
-------------------

launcher     = Launcher
launcher.pre = prefix
-- launcher.helpDuration = 5 -- default of 5 seconds for showing help text

-- [1] is initially nil for a hotkey check branch, gets reset to application names
-- [2] is what gets printed if there's no app set yet
varApp = { nil, "No App bound yet, use " .. showKeys(prefix) .. "+delete to set the currently focused window" }

--------------
-- BINDINGS --
--------------
-- Static app shortcuts
launcher:bind("m", "Messages")
launcher:bind("t", "iTerm")
launcher:bind("s", "Spotify")
launcher:bind("b", "Firefox")
launcher:bind("d", "Discord")
launcher:bind("r", "Reminders")
launcher:bind("f", "Finder")
launcher:bind("c", "Calendar")
launcher:bind("i", "Mail")
launcher:bind("n", "Notes")

-- Show app shortcut bindings
hs.hotkey.bind(prefix, "/", launcher:helpCallback())

-- Dynamic app key binding. Use with prefix+space, set with prefix+delete
hs.hotkey.bind(prefix, "delete", function()
  local curAppName = hs.application.name(hs.application.frontmostApplication())
  hs.alert.show(curAppName .. " bound to " .. showKeys(prefix) .. "+space key")
  varApp[1]=curAppName
end)
hs.hotkey.bind(prefix, "space", function()
  if varApp[1] == nil then
    hs.alert.show(varApp[2])
  else
    hs.application.launchOrFocus(varApp[1])
  end
end)
