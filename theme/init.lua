-- DESCRIPTION
-- ========================================================================
-- Powerdark theme for Awesome WM.
-- Heavily inspired by powerarrow themes.

-- REQUIRED LIBRARY
-- ========================================================================
-- Awesome library
-- ------------------------------------------------------------------------
local awful        = require("awful")
local gears        = require("gears")
local wibox        = require("wibox")
local dpi          = require("beautiful.xresources").apply_dpi
local colors       = require("widgets.colors")
local theme_assets = require("beautiful.theme_assets")

-- THEME VARIABLES
-- ========================================================================
-- Init theme variable
-- ------------------------------------------------------------------------
local theme = {}
theme.dir   = os.getenv("HOME") .. "/.config/awesome/theme/"

-- Shapes
-- ------------------------------------------------------------------------
  local powerline = gears.shape.powerline
  local powerline_inv = function(cr, width, height)
    gears.shape.powerline(cr, width, height, -theme.wibar_height/2)
  end

-- COLORS
-- ========================================================================
-- Default colors
-- ------------------------------------------------------------------------
  theme.fg_normal   = colors.grey_300
  theme.bg_normal   = colors.green_700
  theme.fg_urgent   = colors.black
  theme.bg_urgent   = colors.red_500
  theme.fg_occupied = colors.black
  theme.bg_occupied = colors.orange_a400
  theme.fg_focus    = colors.black
  theme.bg_focus    = colors.light_green_a400
  theme.fg_volatile = colors.black
  theme.bg_volatile = colors.cyan_a400
  theme.bg_darkest  = colors.grey_900
  theme.bg_darker   = colors.grey_800
  theme.bg_dark     = colors.grey_700

-- Base beautiful variables
-- ------------------------------------------------------------------------
  theme.font        = "FiraCode Nerd Font 10"
  theme.useless_gap = dpi(5)

-- Border variables
-- ------------------------------------------------------------------------
  theme.border_width  = dpi(2)
  theme.border_normal = colors.grey_900
  theme.border_focus  = theme.bg_focus
  theme.border_urgent = theme.bg_urgent

-- Wallpaper configuration
-- ------------------------------------------------------------------------
-- Method to set a wallpaper based on current time
  local function time_based_wallpaper()
    local path = theme.wallpaper_path
    if not string.sub(path,-1) == "/" then
      theme.wallpaper = path
      return theme.wallpaper
    else
      local hour = os.date("%H")
      local minute = tonumber(os.date("%M"))
      if minute < 15 then
        minute = "00"
      elseif minute < 30 then
        minute = "15"
      elseif minute < 45 then
        minute = "30"
      elseif minute < 60 then
        minute = "45"
      end
      theme.wallpaper = path .. string.format("%02d_%02d.png",hour,minute)
    end

    for s = 1, screen.count() do
      gears.wallpaper.maximized(theme.wallpaper, s, true)
    end
  end
  -- Set wallpaper
  -- Dynamic, i.e. path a folder with last char being "/"
  -- Static, i.e. path to the image
  theme.wallpaper_path = theme.dir .. "/wallpapers/landscape/"
  theme.wallpaper      = time_based_wallpaper

-- Hotkeys
-- ------------------------------------------------------------------------
  theme.hotkeys_bg               = colors.grey_900
  theme.hotkeys_fg               = colors.grey_a100
  theme.hotkeys_border_width     = theme.border_width
  theme.hotkeys_border_color     = colors.green_a700
  theme.hotkeys_shape            = gears.shape.rect
  theme.hotkeys_modifiers_fg     = colors.yellow_a700
  theme.hotkeys_label_bg         = colors.black
  theme.hotkeys_label_fg         = colors.black
  theme.hotkeys_font             = "FiraCode Nerd Font 11"
  theme.hotkeys_description_font = "FiraCode Nerd Font 11"
  theme.hotkeys_group_margin     = 10

-- Naughty notification
-- ------------------------------------------------------------------------
  theme.notification_font         = theme.font
  theme.notification_bg           = theme.bg_normal
  theme.notification_fg           = theme.fg_normal
  theme.notification_border_width = 5
  theme.notification_border_color = theme.focus
  theme.notification_shape        = gears.shape.rect
  theme.notification_opacity      = 90
  theme.notification_margin       = 50

-- Wibar
-- ------------------------------------------------------------------------
  theme.wibar_height = 20
  theme.wibar_fg     = theme.fg_normal
  theme.wibar_bg     = theme.bg_normal .. "44"

-- Taglist
-- ------------------------------------------------------------------------
  theme.taglist_font        = theme.font
  theme.taglist_fg_focus    = theme.fg_focus
  theme.taglist_bg_focus    = theme.bg_focus
  theme.taglist_fg_urgent   = theme.fg_urgent
  theme.taglist_bg_urgent   = theme.bg_urgent
  theme.taglist_fg_occupied = theme.fg_occupied
  theme.taglist_bg_occupied = theme.bg_occupied
  theme.taglist_fg_empty    = theme.fg_normal
  theme.taglist_bg_empty    = theme.bg_normal .. "44"
  theme.taglist_fg_volatile = theme.fg_volatile
  theme.taglist_bg_volatile = theme.bg_volatile
  theme.taglist_shape       = powerline
  theme.taglist_spacing     = -dpi(5)
  local taglist = require("widgets.taglist")

-- Tasklist
-- ------------------------------------------------------------------------
  theme.tasklist_fg_normal                    = colors.black
  theme.tasklist_bg_normal                    = colors.grey_300
  theme.tasklist_fg_focus                     = colors.black
  theme.tasklist_bg_focus                     = colors.green_a700
  theme.tasklist_fg_urgent                    = colors.black
  theme.tasklist_bg_urgent                    = colors.red_a700
  theme.tasklist_fg_minimize                  = colors.black
  theme.tasklist_bg_minimize                  = colors.purple_a700
  theme.tasklist_disable_icon                 = false
  theme.tasklist_disable_task_name            = false
  theme.tasklist_plain_task_name              = false
  theme.tasklist_font                         = theme.font
  theme.tasklist_align                        = center
  theme.tasklist_font_focus                   = theme.font
  theme.tasklist_font_minimized               = theme.font
  theme.tasklist_font_urgent                  = theme.font
  theme.tasklist_sticky                       = ""
  theme.tasklist_ontop                        = "ﱓ"
  theme.tasklist_floating                     = ""
  theme.tasklist_maximized                    = ""
  local tasklist = require("widgets.tasklist")

-- WIDGETS VARIABLES
-- ========================================================================
-- Keyboard Layout widget
-- ------------------------------------------------------------------------
  theme.keyboardlayout_fg = colors.yellow_500
  theme.keyboardlayout_bg = theme.bg_dark
  theme.keyboardlayout_icon = " "
  theme.keyboardlayout_shape = powerline_inv
  local keyboardlayout_widget = require("widgets.keyboardlayout")

-- IP widget
-- ------------------------------------------------------------------------
  theme.ip_bg = theme.bg_darker
  theme.ip_fg = colors.purple_300
  theme.ip_shape = powerline_inv
  theme.ip_icon = " "
  theme.ip_icon=" "
  theme.ip_icon_vpn="旅"
  local ip_widget = require("widgets.ip")

-- Uptime widget
-- ------------------------------------------------------------------------
  theme.uptime_bg = theme.bg_dark
  theme.uptime_fg = theme.fg_normal
  theme.uptime_shape = powerline_inv
  theme.uptime_icon = " "
  local uptime_widget = require("widgets.uptime")

-- Battery widget
-- ------------------------------------------------------------------------
-- Battery widget
--local bat_widget = require("widgets.bat")

-- Disk widget
-- ------------------------------------------------------------------------
  theme.disk_bg=theme.bg_darker
  theme.disk_fg=theme.fg_normal
  theme.disk_shape=powerline_inv
  theme.disk_icon=" "
  theme.disk_bar_bg = theme.bg_darkest

  theme.disk_tier1_clr=colors.green_500
  theme.disk_tier2_clr=colors.yellow_500
  theme.disk_tier3_clr=colors.orange_500
  theme.disk_tier4_clr=colors.red_500
  local disk_widget = require("widgets.disk")

-- Net widget variables
-- ------------------------------------------------------------------------
  theme.net_bg = theme.bg_dark
  theme.net_fg = theme.fg_normal
  theme.net_shape = powerline_inv
  theme.net_up_icon = " "
  theme.net_down_icon = " "
  theme.net_online_icon = " "
  theme.net_offline_icon = " "

  theme.net_tier1_clr=colors.green_500
  theme.net_tier2_clr=colors.yellow_500
  theme.net_tier3_clr=colors.orange_500
  theme.net_tier4_clr=colors.red_500
  local net_widget = require("widgets.net")

-- Ram widget variables
-- ------------------------------------------------------------------------
  theme.ram_bg=theme.bg_darker
  theme.ram_fg=theme.fg_normal
  theme.ram_shape=powerline_inv
  theme.ram_icon=" "
  theme.ram_bar_bg = theme.bg_darkest

  theme.ram_tier1_clr=colors.green_500
  theme.ram_tier2_clr=colors.yellow_500
  theme.ram_tier3_clr=colors.orange_500
  theme.ram_tier4_clr=colors.red_500
  local ram_widget = require("widgets.ram")

-- CPU widget variables
-- ------------------------------------------------------------------------
  theme.cpu_fg = theme.fg_normal
  theme.cpu_bg = theme.bg_dark
  theme.cpu_shape = powerline_inv
  theme.cpu_icon = "  "
  theme.cpu_bar_bg = theme.bg_darkest

  theme.cpu_tier1_clr=colors.green_500
  theme.cpu_tier2_clr=colors.yellow_500
  theme.cpu_tier3_clr=colors.orange_500
  theme.cpu_tier4_clr=colors.red_500
  local cpu_widget = require("widgets.cpu")

-- Date widget variables
-- ------------------------------------------------------------------------
  theme.date_format = " %a %d %b | %H:%M"
  theme.date_fg = theme.fg_normal
  theme.date_bg = theme.bg_darker
  theme.date_shape = powerline_inv
  local date_widget = require("widgets.date")

-- Systray widget variables
-- ------------------------------------------------------------------------
  theme.systray_bg           = colors.brown_500
  theme.bg_systray           = theme.systray_bg
  theme.systray_icon_spacing = dpi(0)
  theme.systray_shape        = powerline_inv
  local systray_widget = require("widgets.systray")

-- Layoutbox widget variables
-- ------------------------------------------------------------------------
  local layoutbox_widget = require("widgets.layouts")
  -- Image location
  layout_img_dir          = theme.dir .. "/icons/layouts/"
  theme.layout_cornernw   = layout_img_dir .. "cornernw.png"
  theme.layout_cornerne   = layout_img_dir .. "cornerne.png"
  theme.layout_cornersw   = layout_img_dir .. "cornersw.png"
  theme.layout_cornerse   = layout_img_dir .. "cornerse.png"
  theme.layout_fairh      = layout_img_dir .. "fairhorizontal.png"
  theme.layout_fairv      = layout_img_dir .. "fair.png"
  theme.layout_floating   = layout_img_dir .. "floating.png"
  theme.layout_magnifier  = layout_img_dir .. "magnifier.png"
  theme.layout_max        = layout_img_dir .. "max.png"
  theme.layout_fullscreen = layout_img_dir .. "maxfullscreen.png"
  theme.layout_tile       = layout_img_dir .. "tile.png"
  theme.layout_tiletop    = layout_img_dir .. "tiletop.png"
  theme.layout_tilebottom = layout_img_dir .. "tilebottom.png"
  theme.layout_tileleft   = layout_img_dir .. "tileleft.png"
  -- Layout widget
  theme.layout_fg        = theme.fg_normal
  theme.layout_bg        = theme.bg_normal .. "00"
  theme.layout_shape     = powerline_inv
  theme_assets.recolor_layout(theme, theme.fg_normal)

local top_left_wibar = function(screen)
  return { -- Left widgets
    taglist(screen),
    spacing = -dpi(theme.wibar_height/4),
    layout  = wibox.layout.fixed.horizontal,
  }
end

local top_center_wibar = function(screen)
  return { -- Middle widgets
    tasklist(screen),
    layout  = wibox.layout.flex.horizontal,
  }
end

local top_right_wibar = function(screen,tag)
  return { -- Right widgets
    spacing = -dpi(theme.wibar_height/4),
    layout  = wibox.layout.fixed.horizontal,
    keyboardlayout_widget(),
    ip_widget(),
    uptime_widget(),
    disk_widget(),
    --bat_widget(),
    net_widget(),
    ram_widget(),
    cpu_widget(),
    date_widget(),
    systray,
    layoutbox_widget(screen,tag),
  }
end

function theme.at_screen_connect(s)
  -- Time based wallpaper configuration
  gears.timer {
    timeout = 300,
    call_now = true,
    autostart = true,
    callback = time_based_wallpaper,
  }
  screen.connect_signal("request::wallpaper", time_based_wallpaper)
  -- Init tags
  awful.tag(awful.util.tagnames, s, awful.layout.layouts)

  -- THE TOP WIBAR
  -- ========================================================================
  -- Empty top wibar to create a "margin"
  s.empty_top_bar = awful.wibar({
    position = "top",
    screen   = s,
    height   = dpi(2 * theme.useless_gap),
    bg       = "#00000000",
  })
  -- The real top wibar
  s.top_bar = awful.wibar({
    position = "top",
    screen   = s,
    height   = dpi(theme.wibar_height),
    width    = dpi(s.geometry.width - 4 * theme.useless_gap),
    fg       = theme.wibar_fg,
    bg       = theme.wibar_bg,
  })

  -- Add widgets to the wibar
  -- ------------------------------------------------------------------------
  systray = nil
  if s == screen[1] then systray = systray_widget() end
  s.top_bar:setup {
    layout   = wibox.layout.align.horizontal,
    top_left_wibar(s),
    top_center_wibar(s),
    top_right_wibar(s,tag),
  }
end

return theme

-- vim: ft=lua: fdm=indent