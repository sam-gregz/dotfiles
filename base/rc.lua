-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standadrd awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Miscellaneous handling library
local menubar = require("menubar")

-- User vars
RC = {} -- global namespace, on top before require any modules
RC.vars = require("main.user-variables")
modkey = RC.vars.modkey

-- Error handling
require("main.error-handling")

-- Variable definitions
-- Themes define colours, icons, font and wallpapers
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.wallpaper = RC.vars.wallpaper

-- Custom Local Library
local main = {
  layouts = require("main.layouts"),
  tags    = require("main.tags"),
  menu    = require("main.menu"),
  rules   = require("main.rules"),
}

-- Custom Local Library: Keys and Mouse Binding
local binding = {
  globalbuttons = require("bind.globalbuttons"),
  clientbuttons = require("bind.clientbuttons"),
  globalkeys = require("bind.globalkeys"),
  clientkeys = require("bind.clientkeys"),
  bindtotags = require("bind.bindtotags")
}

-- Layouts
RC.layouts = main.layouts()

-- Tags
RC.tags = main.tags()

-- Menu
RC.mainmenu = awful.menu({ items = main.menu() })
RC.launcher = awful.widget.launcher(
  { image = beautiful.awesome_icon, menu = RC.mainmenu }
)
menubar.utils.terminal = RC.vars.terminal

-- Mouse and Key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

-- Set root
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)

-- Statusbar: Wibar
require("deco.statusbar")

-- Rules
awful.rules.rules = main.rules(
    binding.clientkeys(),
    binding.clientbuttons()
)

-- Signals
require("main.signals")
