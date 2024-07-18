gears = require("gears")
switch = require("hover.widget.wrapper.switch")

local custom_event = "my_event"

function event_handler()
	naughty.notify({title = "Event triggered!"})
end

awesome.connect_signal(custom_event, event_handler)

function airplane()
   local microphone_widget = switch("microphone").widget
   microphone_widget.buttons  = gears.table.join(
	  awful.button({}, 1, function ()
			naughty.notify {title = "Hello"}
			awesome.emit_signal(custom_event)
            microphone_widget:toggle()
	  end)
   )
	return {
		widget = microphone_widget,
	}
end

return airplane