gears = require("gears")
switch = require("hover.widget.wrapper.switch")

function airplane()
   local airplane_widget = switch("airplane").widget
   airplane_widget.buttons  = gears.table.join(
	  awful.button({}, 1, function ()
			airplane_widget:toggle()
	  end)
   )
	return {
		widget = airplane_widget,
	}
end

return airplane