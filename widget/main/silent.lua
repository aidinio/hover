gears = require("gears")
switch = require("hover.widget.wrapper.switch")

local custom_event = "my_event"

function event_handler()
	naughty.notify({title = "Event triggered!"})
end

awesome.connect_signal(custom_event, event_handler)

function silent()
   local silent_widget = switch("bell-slash").widget
   silent_widget.buttons  = gears.table.join(
	  awful.button({}, 1, function ()
			naughty.notify {title = "Hello"}
			awesome.emit_signal(custom_event)
            silent_widget:toggle()
	  end)
   )
	return {
		widget = silent_widget,
	}
end

return silent