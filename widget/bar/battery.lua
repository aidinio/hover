local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local UPowerGlib = require("lgi").UPowerGlib
local icons = require(theme_module .. ".icon")

local function get_battery_icon(state, percentage)
    if state == 1 then
        return icons("battery-charging")
    elseif percentage > 80 then
        return icons("battery-full")
    elseif percentage > 60 then
        return icons("battery-high")
    elseif percentage > 40 then
        return icons("battery-medium")
    elseif percentage > 20 then
        return icons("battery-low")
    else
        return icons("battery-empty")
    end
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

local client = UPowerGlib.Client.new()
local device = client:get_devices()[1]

percentage_value = string.match(tostring(device.percentage), "(.*)%.")
percentage_widget:update_text()
icon_path = get_battery_icon(device.state, device.percentage)
icon_widget:update_icon()
awesome.emit_signal("battery::changed", {
    state = device.state,
    icon_path = icon_path,
    percentage = device.percentage,
    percentage_text = percentage_value
})

device.on_notify = function (_)
    percentage_value = string.match(tostring(device.percentage), "(.*)%.")
    percentage_widget:update_text()
    icon_path = get_battery_icon(device.state, device.percentage)
    icon_widget:update_icon()
    awesome.emit_signal("battery::changed", {state = device.state, icon_path = icon_path, percentage = device.percentage, percentage_text = percentage_value})
end

return battery
