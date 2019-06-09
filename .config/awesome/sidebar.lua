local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local helpers = require("helpers")
local pad = helpers.pad

-- Some commonly used variables
local playerctl_button_size = dpi(72)
local icon_size = dpi(48)
local progress_bar_width = dpi(320)
-- local progress_bar_margins = dpi(9)

-- Item configuration
local exit_icon = wibox.widget.imagebox(beautiful.poweroff_icon)
exit_icon.resize = true
exit_icon.forced_width = icon_size
exit_icon.forced_height = icon_size
local exit_text = wibox.widget.textbox("Exit")
exit_text.font = "sans 16"

local exit = wibox.widget{
    exit_icon,
    exit_text,
    layout = wibox.layout.fixed.horizontal
}
exit:buttons(gears.table.join(
        awful.button({ }, 1, function ()
            exit_screen_show()
            sidebar.visible = false
        end)
    ))

-- change icon color on hover
exit:connect_signal("mouse::enter", function()
    exit_icon.image = beautiful.poweroff_hover_icon
end)
exit:connect_signal("mouse::leave", function()
    exit_icon.image = beautiful.poweroff_icon
end)

-- local weather_widget = require("noodle.weather")
-- local weather_widget_icon = weather_widget:get_all_children()[1]
-- weather_widget_icon.forced_width = icon_size
-- weather_widget_icon.forced_height = icon_size
-- local weather_widget_text = weather_widget:get_all_children()[2]
-- weather_widget_text.font = "sans 14"

-- Dummy weather_widget for testing
-- (avoid making requests with every awesome restart)
-- local weather_widget = wibox.widget.textbox("[i] bla bla bla!")

-- local weather = wibox.widget{
--     nil,
--     weather_widget,
--     nil,
--     layout = wibox.layout.align.horizontal,
--     expand = "none"
-- }

local brightness_icon = wibox.widget.imagebox(beautiful.redshift_icon)
brightness_icon.resize = true
brightness_icon.forced_width = icon_size
brightness_icon.forced_height = icon_size
local brightness_bar = require("noodle.brightness_bar")
brightness_bar.forced_width = progress_bar_width
-- brightness_bar.margins.top = progress_bar_margins
-- brightness_bar.margins.bottom = progress_bar_margins
local brightness = wibox.widget{
    nil,
    {
        brightness_icon,
        pad(1),
        brightness_bar,
        pad(1),
        layout = wibox.layout.fixed.horizontal
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.horizontal
}
brightness:buttons(
    gears.table.join(
        awful.button({ }, 1, function ()
        end)
    ))

-- lighten brightness color when hovering
brightness:connect_signal("mouse::enter", function ()
    brightness_bar.color = "#6de5e5"
end)
brightness:connect_signal("mouse::leave", function ()
    brightness_bar.color =  "#62CDCD"
end)

local battery_icon = wibox.widget.imagebox(beautiful.battery_icon)
battery_icon.resize = true
battery_icon.forced_width = icon_size
battery_icon.forced_height = icon_size
awesome.connect_signal(
    "charger_plugged", function(c)
        battery_icon.image = beautiful.battery_charging_icon
    end
    )
awesome.connect_signal(
    "charger_unplugged", function(c)
        battery_icon.image = beautiful.battery_icon
    end
    )
local battery_bar = require("noodle.battery_bar")
battery_bar.forced_width = progress_bar_width
-- battery_bar.margins.top = progress_bar_margins
-- battery_bar.margins.bottom = progress_bar_margins
local battery = wibox.widget{
    nil,
    {
        battery_icon,
        pad(1),
        battery_bar,
        pad(1),
        layout = wibox.layout.fixed.horizontal
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.horizontal
}

-- lighten battery color when hovering
battery:connect_signal("mouse::enter", function ()
    battery_bar.color = "#c6b0f1"
end)
battery:connect_signal("mouse::leave", function ()
    battery_bar.color = "#B4A1DB"
end)

local cpu_icon = wibox.widget.imagebox(beautiful.cpu_icon)
cpu_icon.resize = true
cpu_icon.forced_width = icon_size
cpu_icon.forced_height = icon_size
local cpu_bar = require("noodle.cpu_bar")
cpu_bar.forced_width = progress_bar_width
-- cpu_bar.margins.top = progress_bar_margins
-- cpu_bar.margins.bottom = progress_bar_margins
local cpu = wibox.widget{
    nil,
    {
        cpu_icon,
        pad(1),
        cpu_bar,
        pad(1),
        layout = wibox.layout.fixed.horizontal
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.horizontal
}

cpu:buttons(
    gears.table.join(
        awful.button({ }, 1, function ()
            local matcher = function (c)
                return awful.rules.match(c, {name = 'htop'})
            end
            awful.client.run_or_raise(terminal .." -e htop", matcher)
            sidebar.visible = false
        end)
    ))

-- lighten cpu color when hovering
cpu:connect_signal("mouse::enter", function ()
    cpu_bar.color = "#82f2a0"
end)
cpu:connect_signal("mouse::leave", function ()
    cpu_bar.color =  "#74DD91"
end)

local ram_icon = wibox.widget.imagebox(beautiful.ram_icon)
ram_icon.resize = true
ram_icon.forced_width = icon_size
ram_icon.forced_height = icon_size
local ram_bar = require("noodle.ram_bar")
ram_bar.forced_width = progress_bar_width
-- ram_bar.margins.top = progress_bar_margins
-- ram_bar.margins.bottom = progress_bar_margins
local ram = wibox.widget{
    nil,
    {
        ram_icon,
        pad(1),
        ram_bar,
        pad(1),
        layout = wibox.layout.fixed.horizontal
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.horizontal
}

ram:buttons(
    gears.table.join(
        awful.button({ }, 1, function ()
            local matcher = function (c)
                return awful.rules.match(c, {name = 'htop'})
            end
            awful.client.run_or_raise(terminal .." -e htop", matcher)
            sidebar.visible = false
        end)
    ))

-- lighten ram color when hovering
ram:connect_signal("mouse::enter", function ()
    ram_bar.color = "#47d3dc"
end)
ram:connect_signal("mouse::leave", function ()
    ram_bar.color = "#3DBAC2"
end)

-- mpd and spotify song retrieval
local song = require("noodle.song")
local song_children = song:get_all_children()
local song_title = song_children[1]
local song_artist = song_children[2]
song_title.font = "sans medium 14"
song_artist.font = "sans italic 12"

-- local playerctl_toggle_icon = wibox.widget.imagebox(beautiful.playerctl_toggle_icon)
local playerctl_toggle_icon = wibox.widget.imagebox(beautiful.spotify_icon)
playerctl_toggle_icon.resize = true
playerctl_toggle_icon.forced_width = playerctl_button_size
playerctl_toggle_icon.forced_height = playerctl_button_size
playerctl_toggle_icon:buttons(gears.table.join(
        awful.button({ }, 1, function ()
            if spotify_bool then
                awful.spawn.with_shell("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause")
            else
                awful.spawn.with_shell("mpc toggle")
            end
        end)
    ))
-- change button color on hover
playerctl_toggle_icon:connect_signal("mouse::enter", function()
    if spotify_bool then
        playerctl_toggle_icon.image = beautiful.spotify_hover_icon
    else
        playerctl_toggle_icon.image = beautiful.playerctl_toggle_icon_hover
    end
end)
playerctl_toggle_icon:connect_signal("mouse::leave", function()
    if spotify_bool then
        playerctl_toggle_icon.image = beautiful.spotify_icon
    else
        playerctl_toggle_icon.image = beautiful.playerctl_toggle_icon
    end
end)

local playerctl_prev_icon = wibox.widget.imagebox(beautiful.playerctl_prev_icon)
playerctl_prev_icon.resize = true
playerctl_prev_icon.forced_width = playerctl_button_size
playerctl_prev_icon.forced_height = playerctl_button_size
playerctl_prev_icon:buttons(gears.table.join(
        awful.button({ }, 1, function ()
            if spotify_bool then
                awful.spawn.with_shell("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous")
            else
                awful.spawn.with_shell("mpc prev")
            end
        end)
    ))
-- change button color on hover
playerctl_prev_icon:connect_signal("mouse::enter", function()
    playerctl_prev_icon.image = beautiful.playerctl_prev_icon_hover
end)
playerctl_prev_icon:connect_signal("mouse::leave", function()
    playerctl_prev_icon.image = beautiful.playerctl_prev_icon
end)

local playerctl_next_icon = wibox.widget.imagebox(beautiful.playerctl_next_icon)
playerctl_next_icon.resize = true
playerctl_next_icon.forced_width = playerctl_button_size
playerctl_next_icon.forced_height = playerctl_button_size
playerctl_next_icon:buttons(gears.table.join(
        awful.button({ }, 1, function ()
            if spotify_bool then
                awful.spawn.with_shell("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next")
            else
                awful.spawn.with_shell("mpc next")
            end
        end)
    ))
-- change button color on hover
playerctl_next_icon:connect_signal("mouse::enter", function()
    playerctl_next_icon.image = beautiful.playerctl_next_icon_hover
end)
playerctl_next_icon:connect_signal("mouse::leave", function()
    playerctl_next_icon.image = beautiful.playerctl_next_icon
end)

local playerctl_buttons = wibox.widget {
    nil,
    {
        playerctl_prev_icon,
        pad(1),
        playerctl_toggle_icon,
        pad(1),
        playerctl_next_icon,
        layout  = wibox.layout.fixed.horizontal
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.horizontal,
}

song:buttons(gears.table.join(
        awful.button({ }, 1, function ()
            -- awful.spawn.with_shell("mpc toggle")
            if spotify_bool then
                playerctl_toggle_icon.image = beautiful.playerctl_toggle_icon
            else
                playerctl_toggle_icon.image = beautiful.spotify_icon
            end
            spotify_bool = not spotify_bool
            song.songupdate()
        end)
    ))

local time = wibox.widget.textclock("%I:%M %P")
time.align = "center"
time.valign = "center"
time.font = "sans 55"

local date = wibox.widget.textclock("%B %d")
date.align = "center"
date.valign = "center"
date.font = "sans medium 18"

-- local fancy_date = wibox.widget.textclock("%-j days around the sun")
local fancy_date = wibox.widget.textclock("Knowing that today is %A fills you with determination.")
fancy_date.align = "center"
fancy_date.valign = "center"
fancy_date.font = "sans italic 14"

local disk_space = require("noodle.disk")
disk_space.font = "sans 14"
local disk_icon = wibox.widget.imagebox(beautiful.files_icon)
disk_icon.resize = true
disk_icon.forced_width = icon_size
disk_icon.forced_height = icon_size
local disk = wibox.widget{
    nil,
    {
        disk_icon,
        disk_space,
        layout = wibox.layout.fixed.horizontal
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.horizontal
}

disk:buttons(gears.table.join(
        awful.button({ }, 1, function ()
            awful.spawn(filemanager, {floating = false})
            sidebar.visible = false
        end)
    ))

-- change icon color on hover
disk:connect_signal("mouse::enter", function()
    disk_icon.image = beautiful.files_hover_icon
end)
disk:connect_signal("mouse::leave", function()
    disk_icon.image = beautiful.files_icon
end)

local search_icon = wibox.widget.imagebox(beautiful.search_icon)
search_icon.resize = true
search_icon.forced_width = icon_size
search_icon.forced_height = icon_size
local search_text = wibox.widget.textbox("Search")
search_text.font = "sans 16"

local search = wibox.widget{
    search_icon,
    search_text,
    layout = wibox.layout.fixed.horizontal
}
search:buttons(gears.table.join(
        awful.button({ }, 1, function ()
            -- sleep to prevent rofi from closing on the leftclick
            os.execute("sleep 0.1")
            awful.spawn.with_shell("rofi -show drun")
            sidebar.visible = false
        end)
    ))

-- change icon color on hover
search:connect_signal("mouse::enter", function()
    search_icon.image = beautiful.search_hover_icon
end)
search:connect_signal("mouse::leave", function()
    search_icon.image = beautiful.search_icon
end)

local volume_icon = wibox.widget.imagebox(beautiful.volume_icon)
volume_icon.resize = true
volume_icon.forced_width = icon_size
volume_icon.forced_height = icon_size
local volume_bar = require("noodle.volume_bar")
volume_bar.forced_width = progress_bar_width

local volume = wibox.widget{
    nil,
    {
        volume_icon,
        pad(1),
        volume_bar,
        pad(1),
        layout = wibox.layout.fixed.horizontal
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.horizontal
}
-- lighten volume color when hovering
volume:connect_signal("mouse::enter", function ()
    if (not volume_bar.muted()) then
        volume_bar.color = "#abfeff"
        volume_bar.hover(true)
    else
        volume_bar.color = "#546577"
        volume_bar.hover(true)
    end
end)
volume:connect_signal("mouse::leave", function ()
    if (not volume_bar.muted()) then
        volume_bar.color = beautiful.xcolor6
        volume_bar.hover(false)
    else
        volume_bar.color = "#465463"
        volume_bar.hover(false)
    end
end)

volume:buttons(gears.table.join(
        -- Left click - Mute / Unmute
        awful.button({ }, 1, function ()
            awful.spawn.with_shell("amixer -q sset Master,0 toggle")
        end)
        -- Scroll - Increase / Decrease volume
        -- awful.button({ }, 4, function () 
        --     awful.spawn.with_shell("volume-control.sh up")
        -- end),
        -- awful.button({ }, 5, function () 
        --     awful.spawn.with_shell("volume-control.sh down")
        -- end)
    ))

-- Create the sidebar
sidebar = wibox({x = 0, y = 0, visible = false, ontop = true, type = "dock"})
sidebar.bg = beautiful.sidebar_bg or beautiful.wibar_bg or "#111111"
sidebar.fg = beautiful.sidebar_fg or beautiful.wibar_fg or "#FFFFFF"
sidebar.opacity = beautiful.sidebar_opacity or 1
sidebar.height = beautiful.sidebar_height or awful.screen.focused().geometry.height
sidebar.width = beautiful.sidebar_width or dpi(300)
sidebar.y = beautiful.sidebar_y or 0
local radius = beautiful.sidebar_border_radius or 0
if beautiful.sidebar_position == "right" then
    sidebar.x = awful.screen.focused().geometry.width - sidebar.width
    sidebar.shape = helpers.prrect(radius, true, false, false, true)
else
    sidebar.x = beautiful.sidebar_x or 0
    sidebar.shape = helpers.prrect(radius, false, true, true, false)
end
-- sidebar.shape = helpers.rrect(radius)

sidebar:buttons(gears.table.join(
        -- Middle click - Hide sidebar
        -- awful.button({ }, 2, function ()
        --     sidebar.visible = not sidebar.visible
        -- end)
        -- Right click - Hide sidebar
        -- awful.button({ }, 3, function ()
        --     sidebar.visible = false
        --     -- mymainmenu:show()
        -- end)
    ))

-- Hide sidebar when mouse leaves
if beautiful.sidebar_hide_on_mouse_leave then
    sidebar:connect_signal("mouse::leave", function ()
        sidebar.visible = false
    end)
end
-- Activate sidebar by moving the mouse at the edge of the screen
if beautiful.sidebar_show_on_mouse_edge then
    local sidebar_activator = wibox({y = sidebar.y, width = 1, visible = true, ontop = false, opacity = 0, below = true})
    sidebar_activator.height = sidebar.height
    -- sidebar_activator.height = sidebar.height - beautiful.wibar_height
    sidebar_activator:connect_signal("mouse::enter", function ()
        sidebar.visible = true
    end)

    if beautiful.sidebar_position == "right" then
        sidebar_activator.x = awful.screen.focused().geometry.width - sidebar_activator.width
    else
        sidebar_activator.x = 0
    end

    sidebar_activator:buttons(
        gears.table.join(
            -- awful.button({ }, 2, function ()
            --     start_screen_show()
            --     -- sidebar.visible = not sidebar.visible
            -- end),
            awful.button({ }, 4, function ()
                awful.tag.viewprev()
            end),
            awful.button({ }, 5, function ()
                awful.tag.viewnext()
            end)
        ))
end

-- Item placement
sidebar:setup {
    { ----------- TOP GROUP -----------
        pad(1),
        pad(1),
        pad(1),
        pad(1),
        time,
        date,
        pad(1),
        fancy_date,
        -- pad(1),
        -- weather,
        pad(1),
        pad(1),
        layout = wibox.layout.fixed.vertical
    },
    { ----------- MIDDLE GROUP -----------
        playerctl_buttons,
        {
            -- Put some padding at the left and right edge so that
            -- it looks better with extremely long titles/artists
            pad(2),
            song,
            pad(2),
            layout = wibox.layout.align.horizontal,
        },
        pad(1),
        pad(1),
        volume,
        cpu,
        brightness,
        ram,
        battery,
        pad(1),
        pad(1),
        disk,
        pad(1),
        pad(1),
        layout = wibox.layout.fixed.vertical
    },
    { ----------- BOTTOM GROUP -----------
        { -- Search and exit screen
            nil,
            {
                search,
                pad(15),
                exit,
                pad(2),
                layout = wibox.layout.fixed.horizontal
            },
            nil,
            layout = wibox.layout.align.horizontal,
            expand = "none"
        },
        pad(1),
        layout = wibox.layout.fixed.vertical
    },
    layout = wibox.layout.align.vertical,
    -- expand = "none"
}
