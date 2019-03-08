-- Hammerspoon config by Cooper LeBrun <cooperlebrun@gmail.com>

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
  prefix       = nil,
  binds        = {},
  helpDuration = 5,
  dynamicApp   = nil
}
function Launcher:bind(key, appname)
  -- WARNING: This will error if you don't set pre first!
  -- bind the key
  hs.hotkey.bind(self.prefix, key, function()
    success = hs.application.launchOrFocus(appname)
    if not success then
      hs.alert.show(appname .. " launch binding not successful. :(")
    end
  end)
  -- add to launchBinds
  self.binds[#self.binds+1]=(key .. " => " .. appname)
end
function Launcher:helpCall()
  return function ()
    hs.alert.show("PREFIX: " .. showKeys(self.prefix) .. "\n" .. table.concat(self.binds, "\n"), self.helpDuration)
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
    hs.alert.show(curAppName .. " bound to " .. showKeys(self.prefix) .. "+space key")
    self.dynamicApp=curAppName
  end
end
function Launcher:noDAppAlert ()
  hs.alert.show("No App bound yet, use " .. showKeys(self.prefix) .. "+delete to set the currently focused window", 3)
end

-------------------
-- INITIALIZATION -
-------------------
local mash = {"cmd", "alt", "ctrl"}

launcher        = Launcher
launcher.prefix = mash
-- launcher.helpDuration = 5 -- default of 5 seconds for showing help text

hs.loadSpoon("MiroWindowsManager")
hs.window.animationDuration = 0.0

--------------
-- BINDINGS --
--------------

-- Static app shortcuts
launcher:bind("m", "Messages")
launcher:bind("t", "iTerm")
launcher:bind("s", "Spotify")
launcher:bind("b", "Firefox")
-- launcher:bind("d", "Discord")
launcher:bind("d", "Dash")
launcher:bind("r", "Things3")
launcher:bind("i", "Mail")
launcher:bind("e", "Emacs")

-- Show app shortcut bindings
hs.hotkey.bind(launcher.prefix, "/", launcher:helpCall())

-- Dynamic app key binding. Use with prefix+space, set with prefix+delete
hs.hotkey.bind(launcher.prefix, "delete", launcher:dAppSetCall())
hs.hotkey.bind(launcher.prefix, "space", launcher:dAppFOLCall())

-- Miro Window Manager bindings
spoon.MiroWindowsManager:bindHotkeys({
  up         = {mash, "up"},
  down       = {mash, "down"},
  left       = {mash, "left"},
  right      = {mash, "right"},
  fullscreen = {mash, "f"}
})

------------------
-- OTHER CONFIG --
------------------
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("HammerSpoon loaded") -- KEEP AT END OF FILE
