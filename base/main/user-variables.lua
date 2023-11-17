local home = os.getenv("HOME")

local _M = {
  -- This is used later as the default terminal and editor to run.
  terminal = "kitty",

  -- Default modkey.
  modkey = "Mod4",

  -- User defined wallpaper
  wallpaper = nil
  --wallpaper = home .. "/path/to/wallpaper",
}

return _M
