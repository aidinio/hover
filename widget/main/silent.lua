gears = require("gears")
switch = require("hover.widget.wrapper.switch")

function silent()
   local silent_widget = switch("bell-slash").widget
   silent_widget.buttons  = gears.table.join(
	  awful.button({}, 1, function ()
            silent_widget:toggle()
	  end)
   )
	return {
		widget = silent_widget,
	}
end

return silent