gears = require("gears")
switch = require("hover.widget.wrapper.switch")

local custom_event = "my_event"

function event_handler()
	naughty.notify({title = "Event triggered!"})
end

awesome.connect_signal(custom_event, event_handler)

function bluelight()
   local bluelight_widget = switch("eyeglasses").widget
   bluelight_widget.buttons  = gears.table.join(
	  awful.button({}, 1, function ()
			naughty.notify {title = "Hello"}
			awesome.emit_signal(custom_event)
            bluelight_widget:toggle()
	  end)
   )
	return {
		widget = bluelight_widget,
	}
end

return bluelight