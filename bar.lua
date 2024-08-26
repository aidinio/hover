wibox = require("wibox")
gears = require("gears")
naughty = require("naughty")
beautiful = require("beautiful")
awful = require("awful")
cairo = require("lgi").cairo

file_path = debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])")

custom_widget = wibox.widget {
	widget = wibox.widget.base.make_widget,
	fit = function(context, width, height)
		return 100, 100
	end,
	draw = function(context, cr, width, height)
		-- surf = gears.surface.load_uncached("./demo_assets/song_cover.jpg")
		-- cr = cairo.Context(surf)
		-- w, h = gears.surface.get_size(surf)
		-- cr:rectangle(0, 0, w, h)
		-- -- pat_h = cairo.Pattern.create_linear(0, 0, w, 0)
		-- -- pat_h:add_color_stop_rgba(0 ,gears.color.parse_color("#282828"))
		-- -- pat_h:add_color_stop_rgba(0.2 ,gears.color.parse_color("#282828"))
		-- -- pat_h:add_color_stop_rgba(0.6 ,gears.color.parse_color("#282828" .. "BB"))
		-- -- pat_h:add_color_stop_rgba(0.8 ,gears.color.parse_color("#282828" .. "99"))
		-- -- pat_h:add_color_stop_rgba(1 ,gears.color.parse_color("#282828" .. "88"))
		-- cr:set_source(pat_h)
		-- cr:fill()
		cairo_line_to(cr, 50, 50);
	end
}

function bar(args)
	theme_module = "hover.theme." .. args.theme
	theme_root = tostring(debug.getinfo(1).source):match("(/.*/)") .. "theme/" .. args.theme .. "/"
	demo_assets = require("hover.demo_assets")
	fonts = require(theme_module .. ".font")
	colors = require(theme_module .. ".color")
	icons = require(theme_module .. ".icon")
	bar_buttons = gears.table.join(
		awful.button({}, 1, function(c)
			panel.visible = not panel.visible
		end)
	)
	local wifi_widget = require("hover.widget.main.wifi")().widget
	wifi_widget:toggle("off")
	local bluetooth_widget = require("hover.widget.main.bluetooth")().widget
	-- wifi_widget = require("hover.widget.wrapper.switch")("wifi").widget
	local battery_status_bar = require("hover.widget.main.battery")
	local ram_status_bar = require("hover.widget.main.ram")
	local cpu_status_bar = require("hover.widget.main.cpu")
	local clock = require("hover.widget.bar.clock")
	local battery_widget = require("hover.widget.bar.battery")
	local time_widget = require("hover.widget.main.time")
	local microphone_widget = require("hover.widget.main.microphone")().widget
	local bluelight_widget = require("hover.widget.main.bluelight")().widget
	local silent_widget = require("hover.widget.main.silent")().widget
	local airplane_widget = require("hover.widget.main.airplane")().widget
	local shutdown_button = require("hover.widget.main.shutdown")
	local restart_button = require("hover.widget.main.restart")
	local sleep_button = require("hover.widget.main.sleep")
	local lock_button = require("hover.widget.main.lock")
	local volume_slider = require("hover.widget.main.volume")
	local brightness_slider = require("hover.widget.main.brightness")
	local microphone_slider = require("hover.widget.main.microphone_slider")
	local music_player = require("hover.widget.main.music_player")()
	local time_info = require("hover.widget.main.time_info")()

	bar = wibox.widget {
		{
			{
				nil,
				{
					{
						clock,
						layout = wibox.layout.fixed.horizontal,
					},
					nil,
					{
						{
							{
								image = gears.color.recolor_image(icons("eyeglasses"), "#C6E7FC"),
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
							battery_widget,
							layout = wibox.layout.fixed.horizontal,
							spacing = 3,
						},
						layout = wibox.layout.align.horizontal,
					},
					layout = wibox.layout.align.horizontal,
				},
				layout = wibox.layout.align.vertical,
			},
			widget = wibox.container.margin,
			left = 15,
			right = 15
		},
		shape = function(cr)
			gears.shape.rounded_rect(cr, 436, 39, 33)
		end,
		bg = "#000000",
		forced_width = 436,
		widget = wibox.container.background,
	}
	bar:buttons(bar_buttons)
	panel = awful.popup {
		widget = {
			{
				{
					{
						{
							time_info,
							widget = wibox.container.margin,
							left = 15,
							right = 15,
						},
						widget = wibox.container.background,
						bg = "#15191C",
						shape = function(cr, width)
							gears.shape.rounded_rect(cr, width, 68, 12)
						end,
						forced_height = 68,
					},
					widget = wibox.container.margin,
					left = 15,
					right = 15,
					top = 15,
				},
				{
					{
						{
							{
								{
									{
										{
											{
												{
													wifi_widget,
													widget = wibox.container.margin,
													right = 15
												},
												{
													bluetooth_widget,
													widget = wibox.container.margin,
													right = 18
												},
												layout = wibox.layout.align.horizontal,
												forced_height = 45,
											},
											{
												{
													microphone_widget,
													widget = wibox.container.margin,
													right = 15
												},
												{
													bluelight_widget,
													widget = wibox.container.margin,
													right = 18
												},
												layout = wibox.layout.align.horizontal,
												forced_height = 45,
											},
											{
												{
													silent_widget,
													widget = wibox.container.margin,
													right = 15
												},
												{
													airplane_widget,
													widget = wibox.container.margin,
													right = 18
												},
												layout = wibox.layout.align.horizontal,
												forced_height = 45,
											},
											layout = wibox.layout.fixed.vertical,
											spacing = 18
										},
										widget = wibox.container.margin,
										top = 15,
										left = 18,
										right = 0,
										bottom = 15,
									},
									widget = wibox.container.background,
									bg = "#15191C",
									shape = function(cr, width, height)
										gears.shape.rounded_rect(cr, width, height, 14)
									end,
									-- forced_height = 203,
								},
								widget = wibox.container.margin,
								right = 15,
							},
							{
								{
									{
										{
											{
												volume_slider,
												brightness_slider,
												microphone_slider,
												layout = wibox.layout.fixed.vertical,
												spacing = 27,
											},
											widget = wibox.container.margin,
											top = 15,
											left = 15,
											right = 15,
											bottom = 15,
										},
										widget = wibox.container.background,
										bg = "#15191C",
										shape = function(cr, width, height)
											gears.shape.rounded_rect(cr, width, height, 14)
										end,
										--forced_height = 141,
									},
									widget = wibox.container.margin,
									bottom = 15,
								},
								{
									{
										{
											shutdown_button,
											restart_button,
											sleep_button,
											lock_button,
											layout = wibox.layout.flex.horizontal,
											spacing = 33,
											forced_height = 20,
										},
										widget = wibox.container.margin,
										left = 15,
										right = 15,
										top = 7,
										bottom = 7
									},
									widget = wibox.container.background,
									bg = "#15191C",
									shape = function(cr, width, height)
										gears.shape.rounded_rect(cr, width, height, 14)
									end,
								},
								nil,
								layout = wibox.layout.align.vertical
							},
							nil,
							layout = wibox.layout.align.horizontal
						},
						layout = wibox.layout.fixed.vertical,
					},
					widget = wibox.container.margin,
					left = 15,
					right = 15,
					top = 15,
				},
				{
					{
						{
							{
								battery_status_bar,
								widget = wibox.container.margin,
								left = 15,
								right = 15,
								top = 15,
							},
							{
								ram_status_bar,
								widget = wibox.container.margin,
								left = 15,
								right = 15,
							},
							{
								cpu_status_bar,
								widget = wibox.container.margin,
								left = 15,
								right = 15,
								bottom = 15,
							},
							layout = wibox.layout.fixed.vertical,
							spacing = 20,
						},
						widget = wibox.container.background,
						bg = "#15191C",
						shape = function(cr, width, height)
							gears.shape.rounded_rect(cr, width, height)
						end,
					},
					widget = wibox.container.margin,
					left = 15,
					right = 15,
					top = 15,
				},
				{
					music_player,
					widget = wibox.container.margin,
					left = 15,
					right = 15,
					top = 15,
				},
				{
					{
						{
							{
								{
									{
										{
											{
												{
													image = gears.color.recolor_image(icons("screenshot"), "#C6E7FC"),
													resize = true,
													widget = wibox.widget.imagebox,
													forced_width = 24,
													forced_height = 24,
													valign = "center"
												},
												{
													markup = string.format("<span foreground='%s'>Screenshot taken!</span>",
														colors.text),
													font = fonts.bar,
													widget = wibox.widget.textbox,
												},
												{
													markup = string.format(
														"<span foreground='%s'>Path: /home/user/Pictures/screenshot.png</span>",
														colors.text),
													font = fonts.bar,
													widget = wibox.widget.textbox,
												},
												layout = wibox.layout.fixed.horizontal,
												spacing = 5,
												forced_width = 310,
												forced_height = 30,
											},
											nil,
											{
												image = gears.color.recolor_image(icons("x"), "#9A9EA6"),
												resize = true,
												forced_width = 24,
												forced_height = 24,
												widget = wibox.widget.imagebox,
												valign = "center"
											},
											layout = wibox.layout.align.horizontal
										},
										widget = wibox.container.margin,
										top = 7,
										bottom = 7,
										left = 14,
										right = 14,
									},
									widget = wibox.container.background,
									bg = "#2E3440",
									shape = function(cr, width, height)
										gears.shape.rounded_rect(cr, width, height)
									end
								},
								{
									{
										{
											{
												{
													image = gears.color.recolor_image(icons("battery-warning"), "#C6E7FC"),
													resize = true,
													widget = wibox.widget.imagebox,
													forced_width = 24,
													forced_height = 24,
													valign = "center"
												},
												{
													markup = string.format("<span foreground='%s'>Low battery alert</span>", colors.text),
													font = fonts.bar,
													widget = wibox.widget.textbox,
												},
												{
													markup = string.format(
														"<span foreground='%s'>You have only 15%% battery left</span>", colors.text),
													font = fonts.bar,
													widget = wibox.widget.textbox,
												},
												layout = wibox.layout.fixed.horizontal,
												spacing = 5,
												forced_width = 310,
												forced_height = 30,
											},
											nil,
											{
												image = gears.color.recolor_image(icons("x"), "#9A9EA6"),
												resize = true,
												forced_width = 24,
												forced_height = 24,
												widget = wibox.widget.imagebox,
												valign = "center"
											},
											layout = wibox.layout.align.horizontal
										},
										widget = wibox.container.margin,
										top = 7,
										bottom = 7,
										left = 14,
										right = 14,
									},
									widget = wibox.container.background,
									bg = "#2E3440",
									shape = function(cr, width, height)
										gears.shape.rounded_rect(cr, width, height)
									end
								},
								layout = wibox.layout.fixed.vertical,
								spacing = 15
							},
							widget = wibox.container.margin,
							top = 15,
							left = 15,
							right = 15,
							bottom = 15,
						},
						widget = wibox.container.background,
						bg = "#15191C",
						shape = function(cr, width, height)
							gears.shape.rounded_rect(cr, width, height)
						end,
					},
					widget = wibox.container.margin,
					left = 15,
					right = 15,
					top = 15,
				},
				layout = wibox.layout.fixed.vertical
			},
			widget = wibox.container.background,
			bg = "#000000"
		},
		shape = function(cr)
			gears.shape.rounded_rect(cr, 436, 795, 21)
		end,
		placement = function(cr)
			awful.placement.top_right(cr, { margins = { top = 10 + 39 + 10, right = 10 } })
		end,
		visible = true,
		screen = args.screen,
		minimum_width = 436,
		minimum_height = 795,
		ontop = true
	}
	return bar
end

return bar
