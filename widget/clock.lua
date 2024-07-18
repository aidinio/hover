function airplane()
   wifi_widget = switch().widget
   wifi_widget.buttons  = gears.table.join(
	  awful.button({}, 1, function ()
			naughty.notify {title = "Hello"}
			awesome.emit_signal(custom_event)
	  end)
   )
	return {
		widget = wifi_widget,
	}
end

return airplane