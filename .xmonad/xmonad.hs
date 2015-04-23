import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/clebrun/.xmobarrc"
  xmonad $ defaultConfig
    { manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    , logHook    = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle  = xmobarColor "orange" "" . shorten 50
      }
    , modMask    = mod1Mask
    } `additionalKeys`
    [ ((mod1Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
    , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
    , ((0, xK_Print), spawn "scrot")
    ]

-- main = xmonad =<< statusBar myBar myConfig

-- myBar = "xmobar"
-- 
-- myConfig = defaultConfig
--   { terminal    = myTerminal
--   , modMask     = myModMask
--   , borderWidth = myBorderWidth
--   }
-- 
-- myTerminal    = "urxvt"
-- myModMask     = mod1Mask
-- myBorderWidth = 3
