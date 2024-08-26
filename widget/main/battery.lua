local status_bar = require("hover.widget.wrapper.status_bar")
local gears = require("gears")
local battery_bar = status_bar("battery-charging", "#A3BE8C", "#36402E", 75)

gears.timer {
    
    callback = function ()
        awesome.connect_signal("battery::changed", function (a)
            battery_bar.update_value(math.floor(a.percentage))
            battery_bar.update_icon(a.icon_path)
        end)
    end,
    autostart = true,
    call_now = true,
    timeout = 0,
    single_shot = true
}

return battery_bar