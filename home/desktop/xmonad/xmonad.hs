import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Grid
import XMonad.Layout.ResizableTile
import XMonad.Layout.ToggleLayouts
import XMonad.Util.Run (spawnPipe, safeSpawn)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.IO
import System.Exit

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ ewmhFullscreen $ ewmh $ docks $ def
        { terminal    = "alacritty"
        --, modMask     = controlMask  -- Super key
        , modMask     = mod1Mask  -- Super key
        , borderWidth = 2
        , normalBorderColor  = "#3b4252"
        , focusedBorderColor = "#88c0d0"
        , layoutHook  = myLayout
        , manageHook  = myManageHook
        , handleEventHook = handleEventHook def
        , logHook     = dynamicLogWithPP xmobarPP
                          { ppOutput = hPutStrLn xmproc
                          , ppTitle = xmobarColor "#8fbcbb" "" . shorten 50
                          , ppCurrent = xmobarColor "#88c0d0" "" . wrap "[" "]"
                          , ppVisible = xmobarColor "#81a1c1" ""
                          , ppHidden = xmobarColor "#4c566a" ""
                          , ppHiddenNoWindows = xmobarColor "#3b4252" ""
                          , ppSep = " | "
                          }
        , workspaces = ["1:term", "2:web", "3:emacs", "4:chat", "5:media", "6:virt", "7", "8:games", "9:discord"]
        , startupHook = myStartupHook
        } `additionalKeysP` myKeys

-- Layouts
myLayout = avoidStruts 
         $ smartBorders 
         $ toggleLayouts Full
         $ spacing 5 
         $ (tiled ||| Mirror tiled ||| Grid)
  where
    tiled = renamed [Replace "Tall"] $ ResizableTall 1 (3/100) (1/2) []

-- Window management rules
myManageHook = composeAll
    [ className =? "Firefox"        --> doShift "2:web"
    , className =? "Google-chrome"  --> doShift "2:web"
    , className =? "Emacs"          --> doShift "3:code"
    , className =? "Virt-manager"   --> doShift "6:virt"
    , className =? "Gimp"           --> doFloat
    , isFullscreen                  --> doFullFloat
    , manageDocks
    ]

-- Startup hook
myStartupHook = do
    spawn "nitrogen --restore"  -- Restore wallpaper
    spawn "picom"               -- Start compositor
    spawn "dunst"               -- Start notification daemon

-- Keybindings (i3-like where possible)
myKeys =
    [ -- Launching programs
      ("M-<Return>", spawn "alacritty")
    , ("M-p", spawn "dmenu_run -fn 'JetBrainsMono Nerd Font-10' -nb '#2e3440' -nf '#d8dee9' -sb '#88c0d0' -sf '#2e3440'")
    , ("M-S-<Return>", spawn "firefox")
    
    -- Window management
    , ("M-S-q", kill)
    , ("M-<Space>", sendMessage NextLayout)
    , ("M-f", sendMessage ToggleLayout)  -- Toggle fullscreen
    
    -- Focus
    , ("M-j", windows W.focusDown)
    , ("M-k", windows W.focusUp)
    , ("M-m", windows W.focusMaster)
    
    -- Move windows
    , ("M-S-j", windows W.swapDown)
    , ("M-S-k", windows W.swapUp)
    , ("M-S-m", windows W.swapMaster)
    
    -- Resize
    , ("M-l", sendMessage Expand)
    , ("M-h", sendMessage Shrink)
    , ("M-S-l", sendMessage MirrorExpand)
    , ("M-S-h", sendMessage MirrorShrink)
    
    -- System
    , ("M-S-r", spawn "xmonad --recompile && xmonad --restart")
    , ("M-S-e", io exitSuccess)  -- Exit XMonad
    
    -- Screenshots (like i3)
    , ("<Print>", spawn "maim ~/Pictures/$(date +%s).png")
    , ("S-<Print>", spawn "maim -s ~/Pictures/$(date +%s).png")
    ]
