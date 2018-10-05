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
  helpDuration = 5,
  dynamicApp = nil
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
function Launcher:dAppFOLCall ()
  return function ()
    if self.dynamicApp == nil then
      self:noDAppAlert()
    else
      hs.application.launchOrFocus(self.dynamicApp)
    end
  end
end
function Launcher:dAppSetCall ()
  return function ()
    local curAppName = hs.application.name(hs.application.frontmostApplication())
    hs.alert.show(curAppName .. " bound to " .. showKeys(self.pre) .. "+space key")
    self.dynamicApp=curAppName
  end
end
function Launcher:noDAppAlert ()
  hs.alert.show("No App bound yet, use " .. showKeys(self.pre) .. "+delete to set the currently focused window", 3)
end

-------------------
-- INITIALIZATION -
-------------------

launcher     = Launcher
launcher.pre = prefix
-- launcher.helpDuration = 5 -- default of 5 seconds for showing help text

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
hs.hotkey.bind(prefix, "delete", launcher:dAppSetCall())
hs.hotkey.bind(prefix, "space", launcher:dAppFOLCall())
