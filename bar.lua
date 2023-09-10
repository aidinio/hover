wibox = require("wibox")
gears = require("gears")
naughty = require("naughty")
beautiful = require("beautiful")

function bar(args)
	theme_module = "hover.themes." .. args.theme
	theme_root = tostring(debug.getinfo(1).source):match("(/.*/)") .. "themes/" .. args.theme .. "/"
	fonts = require(theme_module .. ".fonts")
	colors = require(theme_module .. ".colors")
	icons = require(theme_module .. ".icons")
	bar = wibox.widget {
		{
			{
				nil,
				{
					{
						{
							markup = string.format("<span foreground='%s'>19:58</span>", colors.text),
							font = fonts.bar,
							widget = wibox.widget.textbox,
						},
						{
							markup = string.format("<span foreground='%s'>Friday</span>", colors.text),
							font = fonts.bar,
							widget = wibox.widget.textbox,
						},
						{
							markup = string.format("<span foreground='%s'>October 12th</span>", colors.text),
							font = fonts.bar,
							widget = wibox.widget.textbox,
						},
						layout = wibox.layout.fixed.horizontal,
						spacing = 6,
					},
					nil,
					{
						{
							{
								image = gears.color.recolor_image(icons("eyeglass"), "#C6E7FC"),
								resize = true,
								forced_width = 19,
								widget = wibox.widget.imagebox,
								valign = "center"
								--top = 39 / 2 - 19 / 2 + 3
							},
							{
								image = gears.color.recolor_image(icons("bluetooth-connected"), "#C6E7FC"),
								resize = true,
								forced_width = 19,
								widget = wibox.widget.imagebox,
								valign = "center"
							},
							{
								image = gears.color.recolor_image(icons("wifi"), "#C6E7FC"),
								resize = true,
								forced_width = 24,
								widget = wibox.widget.imagebox,
								valign = "center"
							},
							{
								{
									nil,
									{
										image = gears.color.recolor_image(icons("battery-charging"), "#A3BE8C"),
										resize = true,
										forced_width = 24,
										widget = wibox.widget.imagebox,
										valign = "center"
									},
									layout = wibox.layout.align.horizontal,
								},
								{
									markup = string.format("<span foreground='%s'>100%%</span>", colors.text),
									font = fonts.bar,
									widget = wibox.widget.textbox,
								},
								layout = wibox.layout.fixed.horizontal
							},
							layout = wibox.layout.fixed.horizontal,
							spacing = 3,
						},
						layout = wibox.layout.align.horizontal,
					},
					layout = wibox.layout.align.horizontal,
					forced_width = 436 - 15 * 2,
				},
				layout = wibox.layout.align.vertical,
			},
			widget = wibox.container.margin,
			left = 15,
			right = 15
		},
		--valign = "center",
		shape = function(cr)
			gears.shape.rounded_rect(cr, 436, 39, 33)
		end,
		bg = "#000000",
		forced_width = 436,
		widget = wibox.widget.background,
	}
	return bar
end
return bar
