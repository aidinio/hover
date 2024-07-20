local wibox = require("wibox")
local button = require("hover.widget.wrapper.button")
local shutdown_widget = button("power")

shutdown_widget:buttons(gears.table.join(
    shutdown_widget:buttons(),
    awful.button({}, 1, nil, function ()
        os.execute("shutdown now")
    end)
))

return shutdown_widget