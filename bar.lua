wibox = require("wibox")
gears = require("gears")
naughty = require("naughty")
beautiful = require("beautiful")
awful = require("awful")
cairo = require("lgi").cairo

file_path = debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])")

function make_background(context, cr, width, height)
	local image_surface = cairo.ImageSurface.create_from_png(file_path .. "/demo_assets/song_cover.png")
	local resized_image_surface = cairo.ImageSurface(cairo.Format.RGB24, height, height)
	local resized_cr = cairo.Context(resized_image_surface)

	resized_cr:scale(height / image_surface.width, height / image_surface.height)
	resized_cr:set_source_surface(image_surface, 0, 0)
	resized_cr:paint()

	local main_surface = cairo.ImageSurface(cairo.Format.RGB24, 450, height)
	local main_cr = cairo.Context(main_surface)
	-- main_cr:set_source_rgb(0.082, 0.098, 0.11)
	main_cr:set_source_rgb(1, 0, 0)
	main_cr:paint()
	main_cr:set_source_surface(resized_image_surface, 405 - height + 2, 0)
	main_cr:paint()
	local my_gradient = cairo.Pattern.create_linear(0, 0, width, 0)
	my_gradient:add_color_stop_rgba(0, gears.color.parse_color("#15191CFF"))
	my_gradient:add_color_stop_rgba((405 - height) / width, gears.color.parse_color("#15191CFF"))
	my_gradient:add_color_stop_rgba(1, gears.color.parse_color("#15191C00"))
	main_cr:set_source(my_gradient)
	main_cr:paint()
	cr:set_source_surface(main_surface, 0, 0)
	cr:paint()
	-- return main_surface
end

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
	local time_widdget = require("hover.widget.main.time")
	local microphone_widget = require("hover.widget.main.microphone")().widget
	local bluelight_widget = require("hover.widget.main.bluelight")().widget
	local silent_widget = require("hover.widget.main.silent")().widget
	local airplane_widget = require("hover.widget.main.airplane")().widget

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
							{
								{
									{
										markup = string.format("<span foreground='%s'>12:32</span>", colors.text),
										font = fonts.panel.clock,
										widget = wibox.widget.textbox,
									},
									{
										{
											{
												{
													markup = string.format("<span foreground='%s'>July</span>", colors.text),
													font = fonts.panel.month_and_day,
													widget = wibox.widget.textbox,
												},
												{
													markup = string.format("<span foreground='%s'>Monday</span>", colors.text),
													font = fonts.panel.month_and_day,
													widget = wibox.widget.textbox,
												},
												layout = wibox.layout.fixed.vertical,
												spacing = -5
											},
											widget = wibox.container.margin,
											top = 8,
										},
										widget = wibox.container.margin,
										left = 7
									},
									layout = wibox.layout.fixed.horizontal,
								},
								nil,
								{
									markup = string.format("<span foreground='%s'>15/07/2024</span>", colors.text),
									font = fonts.panel.date,
									widget = wibox.widget.textbox,
								},
								layout = wibox.layout.align.horizontal
							},
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
													{
														airplane_widget,
														widget = wibox.container.background,
														bg = "#C6E7FC",
														shape = function(cr)
															gears.shape.rounded_rect(cr, 45, 45, 30)
														end,
														forced_width = 45
													},
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
												{
													{
														{
															{
																image = gears.color.recolor_image(icons("volume"), "#C6E7FC"),
																resize = true,
																forced_width = 18,
																widget = wibox.widget.imagebox,
																valign = "center"
															},
															widget = wibox.container.margin,
															left = 5,
															right = 5
														},
														widget = wibox.container.background,
														forced_height = 19,
														shape = function(cr, width, height)
															gears.shape.partially_rounded_rect(cr, 100, height, true,
																false, false, true)
														end,
														bg = "#2E3440",
													},
													{
														max_value = 100,
														value = 50,
														forced_height = 19,
														forced_width = 0,
														--paddings = 3,
														background_color = "#2E3440",
														color = "#C6E7FC",
														widget = wibox.widget.progressbar,
														shape = function(cr, width, height)
															gears.shape.partially_rounded_rect(cr, width, height, false,
																true, true,
																false)
														end,
														bar_shape = function(cr, width, height)
															gears.shape.partially_rounded_rect(cr, width, height, false,
																true, true,
																false)
														end,
													},
													layout = wibox.layout.align.horizontal
												},
												{
													{
														{
															{
																image = gears.color.recolor_image(icons("brightness-half"), "#C6E7FC"),
																resize = true,
																forced_width = 18,
																widget = wibox.widget.imagebox,
																valign = "center"
															},
															widget = wibox.container.margin,
															left = 5,
															right = 5
														},
														widget = wibox.container.background,
														forced_height = 19,
														shape = function(cr, width, height)
															gears.shape.partially_rounded_rect(cr, 100, height, true,
																false, false, true)
														end,
														bg = "#2E3440",
													},
													{
														max_value = 100,
														value = 50,
														forced_height = 19,
														forced_width = 0,
														-- paddings = 3,
														background_color = "#2E3440",
														color = "#C6E7FC",
														widget = wibox.widget.progressbar,
														shape = function(cr, width, height)
															gears.shape.partially_rounded_rect(cr, width, height, false,
																true, true,
																false)
														end,
														bar_shape = function(cr, width, height)
															gears.shape.partially_rounded_rect(cr, width, height, false,
																true, true,
																false)
														end,
													},
													layout = wibox.layout.align.horizontal
												},
												{
													{
														{
															{
																image = gears.color.recolor_image(icons("microphone"), "#C6E7FC"),
																resize = true,
																forced_width = 18,
																widget = wibox.widget.imagebox,
																valign = "center"
															},
															widget = wibox.container.margin,
															left = 5,
															right = 5
														},
														widget = wibox.container.background,
														forced_height = 19,
														shape = function(cr, width, height)
															gears.shape.partially_rounded_rect(cr, 100, height, true,
																false, false, true)
														end,
														bg = "#2E3440",
													},
													{
														max_value = 100,
														value = 50,
														forced_height = 19,
														forced_width = 0,
														--paddings = 3,
														background_color = "#2E3440",
														color = "#C6E7FC",
														widget = wibox.widget.progressbar,
														shape = function(cr, width, height)
															gears.shape.partially_rounded_rect(cr, width, height, false,
																true, true,
																false)
														end,
														bar_shape = function(cr, width, height)
															gears.shape.partially_rounded_rect(cr, width, height, false,
																true, true,
																false)
														end,
													},
													layout = wibox.layout.align.horizontal
												},
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
											{
												{
													markup = string.format("<span foreground='%s'>Friday</span>", "#000000"),
													widget = wibox.widget.textbox,
													halign = "center",
												},
												widget = wibox.container.background,
												bg = "#C6E7FC",
												shape = function(cr)
													gears.shape.rounded_rect(cr, 30, 30, 20)
												end,
												forced_width = 30,
											},
											{
												{
													markup = string.format("<span foreground='%s'>Friday</span>", "#000000"),
													widget = wibox.widget.textbox,
													halign = "center",
												},
												widget = wibox.container.background,
												bg = "#C6E7FC",
												shape = function(cr)
													gears.shape.rounded_rect(cr, 30, 30, 20)
												end,
												forced_width = 30,
											},
											{
												{
													markup = string.format("<span foreground='%s'>Friday</span>", "#000000"),
													widget = wibox.widget.textbox,
												},
												widget = wibox.container.background,
												bg = "#C6E7FC",
												shape = function(cr)
													gears.shape.rounded_rect(cr, 30, 30, 20)
												end,
												forced_width = 30,
											},
											{
												{
													markup = string.format("<span foreground='%s'>Friday</span>", "#000000"),
													widget = wibox.widget.textbox,
													valign = "center",
												},
												widget = wibox.container.background,
												bg = "#C6E7FC",
												shape = function(cr, width, height)
													gears.shape.rounded_rect(cr, 30, 30, 20)
												end,
												forced_width = 30,
											},
											layout = wibox.layout.flex.horizontal,
											--spacing = 33,
											forced_height = 20,
										},
										widget = wibox.container.margin,
										left = 15,
										right = 15,
										top = 7
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
					{
						{
							{
								{
									markup = string.format("<span foreground='%s'>Chet Baker - Alone Together</span>", colors.text),
									font = fonts.panel.music_player.song_title,
									align = "left",
									widget = wibox.widget.textbox
								},
								{
									{
										max_value = 100,
										value = 60,
										forced_height = 18,
										forced_width = 100,
										--paddings = 3,
										background_color = "#2E3440",
										color = "#C6E7FC",
										widget = wibox.widget.progressbar,
										shape = function(cr, width, height)
											gears.shape.rounded_rect(cr, width, height, 20)
										end,
										bar_shape = function(cr, width, height)
											gears.shape.rounded_rect(cr, width, height, 20)
										end,
									},
									layout = wibox.layout.fixed.vertical,
									forced_height = 18
								},
								{
									{
										markup = string.format("<span foreground='%s'>31:38/53:80</span>", colors.text),
										font = fonts.panel.music_player.duration,
										align = "center",
										widget = wibox.widget.textbox,
									},
									{

										{
											{
												image = gears.color.recolor_image(icons("skip-back-bold"), "#C6E7FC"),
												resize = true,
												forced_width = 24,
												widget = wibox.widget.imagebox,
												valign = "center",
											},
											{
												image = gears.color.recolor_image(icons("play-bold"), "#C6E7FC"),
												resize = true,
												forced_width = 24,
												widget = wibox.widget.imagebox,
												valign = "center",
											},
											{
												image = gears.color.recolor_image(icons("skip-forward-bold"), "#C6E7FC"),
												resize = true,
												forced_width = 24,
												widget = wibox.widget.imagebox,
												valign = "center",
											},
											layout = wibox.layout.fixed.horizontal,
											spacing = 20
										},
										widget = wibox.container.margin,
										left = 65
									},
									layout = wibox.layout.align.horizontal
								},
								layout = wibox.layout.fixed.vertical,
								spacing = 20
							},
							widget = wibox.container.margin,
							left = 15,
							top = 20,
							right = 15,
							bottom = 20,
						},
						widget = wibox.container.background,
						bg = "#15191C",
						-- bg = "linear:0,0:400,0:0,#ff0000:1,#0000ff00",
						shape = function(cr, width, height)
							gears.shape.rounded_rect(cr, width, 150)
						end,
						bgimage = function(context, cr, width, height)
							make_background(context, cr, width, height)
						end,
						forced_height = 150,
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
													image = gears.color.recolor_image(icons("bell"), "#C6E7FC"),
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
	}
	return bar
end

return bar