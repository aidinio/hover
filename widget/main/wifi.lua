gears = require("gears")
switch = require("hover.widget.wrapper.switch")

function wifi()
   local wifi_widget = switch("wifi-high-bold").widget
   wifi_widget.buttons  = gears.table.join(
	  awful.button({}, 1, function ()
			wifi_widget:toggle()
	  end)
   )
	return {
		widget = wifi_widget,
	}
end

return wifi