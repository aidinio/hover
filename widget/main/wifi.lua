gears = require("gears")
switch = require("hover.widget.wrapper.switch")

local custom_event = "my_event"

function event_handler()
	naughty.notify({title = "Event triggered!"})
end

awesome.connect_signal(custom_event, event_handler)

function wifi()
   local wifi_widget = switch("wifi-high-bold").widget
   wifi_widget.buttons  = gears.table.join(
	  awful.button({}, 1, function ()
			naughty.notify {title = "Hello"}
			awesome.emit_signal(custom_event)
			wifi_widget:toggle()
	  end)
   )
	return {
		widget = wifi_widget,
	}
end

return wifi