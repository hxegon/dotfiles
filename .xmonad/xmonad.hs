import XMonad
import XMonad.Layout.Tabbed
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myTitleMaxLength = 50
myModKey = mod4Mask

myLayout = avoidStruts $
           tiled
           ||| Mirror tiled
           ||| Full
           ||| tabbed shrinkText defaultTheme
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
     -- Percent of screen to increment by when resizing panes
     delta   = 2/100

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/clebrun/.xmobarrc"
  xmonad $ defaultConfig
    { manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = myLayout
    , logHook    = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle  = xmobarColor "orange" "" . shorten myTitleMaxLength
      }
    , modMask    = myModKey -- mod4 = Super, mod1 = left alt
    , terminal   = "gnome-terminal"
    } `additionalKeys`
      [((myModKey, xK_a), spawn "pactl set-sink-volume $(active_sink) -5%"),
      ((myModKey, xK_o), spawn "pactl set-sink-volume $(active_sink) +5%")]
      -- Bind super-a and super-o to lower and raise volume
      -- if it stops working, try checking pactl list sinks and change the 1
