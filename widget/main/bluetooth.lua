local gears = require("gears")
local awful = require("awful")
local switch = require("hover.widget.wrapper.switch")

local custom_event = "my_event"

function airplane()
   local bluetooth_widget = switch("bluetooth").widget
   bluetooth_widget.buttons  = gears.table.join(
	  awful.button({}, 1, function ()
            bluetooth_widget:toggle()
	  end)
   )
	return {
		widget = bluetooth_widget,
	}
end

return airplane