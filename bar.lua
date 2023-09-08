wibox = require("wibox")
gears = require("gears")
naughty = require("naughty")
--fonts = require("themes.nord_m.fonts")
function bar(args)
	fonts = require("hover.themes." .. args.theme .. ".fonts")
	colors = require("hover.themes." .. args.theme .. ".colors")
	bar = wibox.widget {
		{
			{
				{
					{
						markup = string.format("<span foreground='%s'>19:58</span>", colors.text),
						font = fonts.bar,
						widget = wibox.widget.textbox,
						valign = "center",
					},
					{
						markup = string.format("<span foreground='%s'>Friday</span>", colors.text),
						font = fonts.bar,
						widget = wibox.widget.textbox,
						valign = "center",
					},
					{
						markup = string.format("<span foreground='%s'>October 12th</span>", colors.text),
						font = fonts.bar,
						widget = wibox.widget.textbox,
						valign = "center",
						align = "right"
					},
					layout = wibox.layout.fixed.horizontal,
					spacing = 6,
				},
				widget = wibox.container.margin,
				left = 15
			},
			shape = function(cr)
				gears.shape.rounded_rect(cr, 436, 39, 33)
			end,
			bg = "#000000",
			forced_width = 436,
			widget = wibox.widget.background,
		},
		widget = wibox.container.margin,
		right = 0,
		top = 0,
	}
	return bar
end

return bar
