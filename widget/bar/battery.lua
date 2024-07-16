local gears = require("gears")
local naughty = require("naughty")
local lgi = require("lgi")
local Gio = lgi.Gio
local UPowerGlib = lgi.UPowerGlib
icons = require(theme_module .. ".icon")

icons_table = {
    ["ac-adapter-symbolic"] = "battery-charging",
    ["battery-missing-symbolic"] = "battery-warning",
    ["battery-empty-symbolic"] = "battery-empty",
    ["battery-full-charged-symbolic"] = "",
    ["battery-caution-charging-symbolic"] = "",
    ["battery-caution-symbolic"] = "",
    ["battery-low-charging-symbolic"] = "",
    ["battery-low-symbolic"] = "",
    ["battery-good-charging-symbolic"] = "",
    ["battery-good-symbolic"] = "",
    ["battery-full-charging-symbolic"] = "",
    ["battery-full-symbolic"] = "",
}

function notif(msg)
    naughty.notify{
        title = "Hi!",
        text = msg
    }
end


local percentage_value = -1
local icon_path = ""

local percentage_widget = wibox.widget.base.make_widget_declarative {
    markup = string.format("<span foreground='%s'>%s%%</span>", colors.text, percentage_value),
    font = fonts.bar,
    widget = wibox.widget.textbox,
    update_text = function(self)
        self.markup = string.format("<span foreground='%s'>%s%%</span>", colors.text, percentage_value)
    end
    }

local icon_widget = wibox.widget.base.make_widget_declarative {
    image = gears.color.recolor_image(icon_path, "#A3BE8C"),
    resize = true,
    forced_width = 24,
    widget = wibox.widget.imagebox,
    valign = "center",
    update_icon = function(self)
        self.image = gears.color.recolor_image(icon_path, "#A3BE8C")
    end
}

local battery = wibox.widget{
        {
            icon_widget,
            widget = wibox.container.margin,
            right = 5,
            top = 1
        },
        percentage_widget,
    layout = wibox.layout.fixed.horizontal
}

local bus = Gio.bus_get_sync(Gio.BusType.SYSTEM)

local proxy = Gio.DBusProxy.new_sync(
    bus,
    Gio.DBusProxyFlags.NONE,
    nil,
    "org.freedesktop.UPower",
    "/org/freedesktop/UPower/devices/DisplayDevice",
    "org.freedesktop.DBus.Properties",
    nil
)

local client = UPowerGlib.Client.new()

local device = client:get_devices()[1]
percentage_value = string.match(tostring(device.percentage), "(.*)%.")
-- percentage_value = "100"
percentage_widget:update_text()
if device.state == 1 then
    icon_path = icons("battery-charging")
elseif device.percentage > 80 then
    icon_path = icons("battery-full")
elseif device.percentage > 60 then
    icon_path = icons("battery-high")
elseif device.percentage > 40 then
    icon_path = icons("battery-medium")
elseif device.percentage > 20 then
    icon_path = icons("battery-low")
elseif device.percentage > 0 then
    icon_path = icons("battery-empty")
end
icon_widget:update_icon()
gears.timer.start_new(0, function ()

    proxy.on_g_signal = function(a, b, c, d, e)
        local objv2 = d:get_child_value(1):print(true)
        print(objv2)
        print("[ UPowerGlib] ", device.percentage)
        notif(tostring(device.percentage))
        notif(tostring(objv2))
        percentage_value = string.match(tostring(device.percentage), "(.*)%.")
        -- percentage_value = "100"
        percentage_widget:update_text()
        print("[ UPowerGlib] ", tostring(device.percentage))
        icon_name = tostring(device.icon_name)
        icon_path = icons(icons_table[icon_name])
        if device.state == 1 then
            icon_path = icons("battery-charging")
        elseif device.percentage > 80 then
            icon_path = icons("battery-full")
        elseif device.percentage > 60 then
            icon_path = icons("battery-high")
        elseif device.percentage > 40 then
            icon_path = icons("battery-medium")
        elseif device.percentage > 20 then
            icon_path = icons("battery-low")
        elseif device.percentage > 0 then
            icon_path = icons("battery-empty")
        end
        icon_widget:update_icon()
    end
    
    lgi.GLib.MainLoop():run()
end)

-- gears.timer {
--     timeout   = 1,
--     call_now  = true,
--     autostart = true,
--     callback  = function()
--         -- You should read it from `/sys/class/power_supply/` (on Linux)
--         -- instead of spawning a shell. This is only an example.
--         percentage_value = percentage_value - 1
--         percentage_widget:update_text()
--         naughty.notify {
--             text = string.format("%s", percentage_widget.markup)
--         }
--         percentage_widget:emit_signal("widget::redraw_needed")
--     end
-- }

return battery