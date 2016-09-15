import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myTitleMaxLength = 50

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/clebrun/.xmobarrc"
  xmonad $ defaultConfig
    { manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    , logHook    = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle  = xmobarColor "orange" "" . shorten myTitleMaxLength
      }
    , modMask    = mod4Mask -- mod4 = Super, mod1 = left alt
    , terminal   = "gnome-terminal"
    } `additionalKeys`
    [ ((mod1Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
    , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
    , ((0, xK_Print), spawn "scrot")
    ]
