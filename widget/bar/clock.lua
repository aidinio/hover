local wibox = require("wibox")

local clock = wibox.widget{
    format = string.format("<span foreground='%s'>%s</span>", colors.text, "%H:%M:%S %A %B %e"),
    font = fonts.bar,
    widget = wibox.widget.textclock,
    refresh = 1
}

return clock