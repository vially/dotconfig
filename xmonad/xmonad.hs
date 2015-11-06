import Control.Monad (liftM2)
import XMonad
import qualified XMonad.StackSet as W
import XMonad.Actions.WindowGo
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Tabbed
import XMonad.ManageHook
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Shell
import XMonad.Prompt.Window
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

-- Define the names of all workspaces
myWorkspaces = ["1:main","2:terminal","3:dev","4:media","5","6","7","8","9"]

-- Define window rules
myManageHook :: [ManageHook]
myManageHook =
    [ isFullscreen --> (doF W.focusDown <+> doFullFloat)
    --, className =? "zeal"                       --> doFullFloat
    , className =? "Termite"                    --> viewShift "2:terminal"
    , className =? "Atom"                       --> viewShift "3:dev"
    , className =? "Gvim"                       --> viewShift "3:dev"
    , className =? "dota_linux"                 --> viewShift "4:media"
    , className =? "dota_linux"                 --> doFloat
    , resource  =? "Gnoplot"                    --> doFloat
    , resource  =? "Do"                         --> doFloat
    ]
  where viewShift = doF . liftM2 (.) W.greedyView W.shift

-- Keybinding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myKeys = [ ((mod4Mask, xK_o), spawn "gruncher")
         , ((mod4Mask .|. shiftMask, xK_s), runOrRaise "termite" (className =? "Termite"))
         , ((mod4Mask .|. shiftMask, xK_i), runOrRaiseNext "chromium" (className =? "Chromium"))
         , ((mod4Mask .|. shiftMask, xK_z), runOrRaise "zeal" (className =? "zeal"))
         , ((mod4Mask .|. controlMask, xK_x), shellPrompt defaultXPConfig)
         , ((mod4Mask .|. shiftMask, xK_x), runOrRaisePrompt defaultXPConfig)
         , ((mod4Mask .|. shiftMask, xK_g), windowPromptGoto defaultXPConfig)
         -- XF86AudioLowerVolume
         , ((0, 0x1008ff11), spawn "volumectl down")
         -- XF86AudioRaiseVolume
         , ((0, 0x1008ff13), spawn "volumectl up")
         -- XF86AudioMute
         , ((0, 0x1008ff12), spawn "volumectl toggle")
         ]

-- Layouts:
myLayout = smartBorders $ onWorkspace "1:main" Full $ onWorkspace "2:terminal" simpleTabbedBottom $ onWorkspace "3:dev" Full $ layoutHook defaultConfig

-- Custom PP, configure it as you like. It determines what's being written to the bar.
myStatusBarPP = xmobarPP { ppCurrent = xmobarColor "#f0c674" "" . wrap "[" "]"
                         , ppTitle   = xmobarColor "#f0c674" "" . shorten 50
                         , ppVisible = xmobarColor "#306EFF" ""
                         , ppHidden  = xmobarColor "#a3685a" ""
                         , ppUrgent  = xmobarColor "red" ""
                         }

myConfig = ewmh defaultConfig
        { modMask           = mod4Mask
        , layoutHook        = myLayout
        , handleEventHook   = fullscreenEventHook
        , terminal          = "termite"
        , borderWidth       = 0
        , manageHook        = manageHook defaultConfig <+> composeAll myManageHook
        , workspaces        = myWorkspaces
        } `additionalKeys` myKeys

main = do
   xmonad =<< statusBar "xmobar" myStatusBarPP toggleStrutsKey myConfig
