local gears = require("gears")
local naughty = require("naughty")

local percentage_value = 100

local percentage_widget = wibox.widget.base.make_widget_declarative {
    markup = string.format("<span foreground='%s'>%s%%</span>", colors.text, percentage_value),
    font = fonts.bar,
    widget = wibox.widget.textbox,
    update_text = function(self)
        self.markup = string.format("<span foreground='%s'>%s%%</span>", colors.text, percentage_value)
    end
    }

local icon_widget = wibox.widget.base.make_widget_declarative {
    image = gears.color.recolor_image(icons("battery-charging"), "#A3BE8C"),
    resize = true,
    forced_width = 24,
    widget = wibox.widget.imagebox,
    valign = "center"
}

local battery = wibox.widget{
    {
        nil,
        icon_widget,
        layout = wibox.layout.align.horizontal,
    },
    percentage_widget,
    layout = wibox.layout.fixed.horizontal
}

gears.timer {
    timeout   = 1,
    call_now  = true,
    autostart = true,
    callback  = function()
        -- You should read it from `/sys/class/power_supply/` (on Linux)
        -- instead of spawning a shell. This is only an example.
        percentage_value = percentage_value - 1
        percentage_widget:update_text()
        naughty.notify {
            text = string.format("%s", percentage_widget.markup)
        }
        percentage_widget:emit_signal("widget::redraw_needed")
    end
}

return battery