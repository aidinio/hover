wibox = require("wibox")
gears = require("gears")
naughty = require("naughty")
beautiful = require("beautiful")
awful = require("awful")

function bar(args)
	theme_module = "hover.themes." .. args.theme
	theme_root = tostring(debug.getinfo(1).source):match("(/.*/)") .. "themes/" .. args.theme .. "/"
	fonts = require(theme_module .. ".fonts")
	colors = require(theme_module .. ".colors")
	icons = require(theme_module .. ".icons")
	bar_buttons = gears.table.join(
		awful.button({}, 1, function(c)
			panel.visible = not panel.visible
		end)
	)
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
										markup = string.format("<span foreground='%s'>19:58</span>", colors.text),
										font = fonts.panel.clock,
										widget = wibox.widget.textbox,
									},
									{
										{
											{
												{
													markup = string.format("<span foreground='%s'>October</span>", colors.text),
													font = fonts.panel.month_and_day,
													widget = wibox.widget.textbox,
												},
												{
													markup = string.format("<span foreground='%s'>Friday</span>", colors.text),
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
									markup = string.format("<span foreground='%s'>12/10/2023</span>", colors.text),
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
													{
														{
															image = gears.color.recolor_image(icons("bluetooth-connected"), "#2E3440"),
															resize = true,
															forced_width = 19,
															widget = wibox.widget.imagebox,
															valign = "center"
														},
														widget = wibox.container.background,
														bg = "#C6E7FC",
														shape = function(cr)
															gears.shape.rounded_rect(cr, 45, 45, 30)
														end,
														forced_width = 45,
													},
													widget = wibox.container.margin,
													right = 15
												},
												{
													{
														{
															markup = string.format("<span foreground='%s'>Friday</span>", colors.text),
															widget = wibox.widget.textbox,
															halign = "right"
														},
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
											{
												{
													{
														{
															markup = string.format("<span foreground='%s'>Friday</span>", colors.text),
															widget = wibox.widget.textbox,
														},
														widget = wibox.container.background,
														bg = "#C6E7FC",
														shape = function(cr)
															gears.shape.rounded_rect(cr, 45, 45, 30)
														end,
														forced_width = 45,
													},
													widget = wibox.container.margin,
													right = 15
												},
												{
													{
														{
															markup = string.format("<span foreground='%s'>Friday</span>", colors.text),
															widget = wibox.widget.textbox,
															halign = "right"
														},
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
											{
												{
													{
														{
															markup = string.format("<span foreground='%s'>Friday</span>", colors.text),
															widget = wibox.widget.textbox,
														},
														widget = wibox.container.background,
														bg = "#C6E7FC",
														shape = function(cr)
															gears.shape.rounded_rect(cr, 45, 45, 30)
														end,
														forced_width = 45,
													},
													widget = wibox.container.margin,
													right = 15
												},
												{
													{
														{
															markup = string.format("<span foreground='%s'>Friday</span>", colors.text),
															widget = wibox.widget.textbox,
															halign = "right"
														},
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
															gears.shape.partially_rounded_rect(cr, 100, height, true, false, false, true)
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
															gears.shape.partially_rounded_rect(cr, width, height, false, true, true,
																false)
														end,
														bar_shape = function(cr, width, height)
															gears.shape.partially_rounded_rect(cr, width, height, false, true, true,
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
															gears.shape.partially_rounded_rect(cr, 100, height, true, false, false, true)
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
															gears.shape.partially_rounded_rect(cr, width, height, false, true, true,
																false)
														end,
														bar_shape = function(cr, width, height)
															gears.shape.partially_rounded_rect(cr, width, height, false, true, true,
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
															gears.shape.partially_rounded_rect(cr, 100, height, true, false, false, true)
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
															gears.shape.partially_rounded_rect(cr, width, height, false, true, true,
																false)
														end,
														bar_shape = function(cr, width, height)
															gears.shape.partially_rounded_rect(cr, width, height, false, true, true,
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
										nil,
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
													valign = "center",
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
													valign = "center",
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
													valign = "center",
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
													valign = "center",
												},
												layout = wibox.layout.fixed.horizontal,
												--max_widget_size = 30,
												spacing = 33,
												forced_height = 20,
											},
											widget = wibox.container.margin,
											left = 15,
											right = 15,
											top = 7
										},
										layout = wibox.layout.align.vertical,
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
								{
									{
										{
											{
												{
													image = gears.color.recolor_image(icons("battery-charging"), "#A3BE8C"),
													resize = false,
													forced_width = 24,
													widget = wibox.widget.imagebox,
													valign = "center",
												},
												{
													markup = string.format("<span foreground='%s'>75%%</span>", "#A3BE8C"),
													font = fonts.bar,
													widget = wibox.widget.textbox,
													forced_width = 35,
												},
												spacing = 5,
												layout = wibox.layout.fixed.horizontal,
											},
											{
												max_value = 100,
												value = 75,
												forced_height = 19,
												forced_width = 0,
												--paddings = 3,
												background_color = "#0000",
												color = "#A3BE8C",
												widget = wibox.widget.progressbar,
												shape = function(cr, width, height)
													gears.shape.partially_rounded_rect(cr, width, height, false, true, true,
														false)
												end,
												bar_shape = function(cr, width, height)
													gears.shape.partially_rounded_rect(cr, width, height, false, true, true,
														false)
												end,
											},
											layout = wibox.layout.align.horizontal,
											forced_height = 16
										},
										widget = wibox.container.margin,
										top = 6,
										bottom = 6,
										left = 15,
										right = 6,
									},
									widget = wibox.container.background,
									bg = "#36402E",
									shape = function(cr, width, height)
										gears.shape.rounded_rect(cr, width, height, 25)
									end
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
													image = gears.color.recolor_image(icons("ram"), "#C6E7FC"),
													resize = false,
													forced_width = 24,
													widget = wibox.widget.imagebox,
													valign = "center",
												},
												{
													markup = string.format("<span foreground='%s'>75%%</span>", "#C6E7FC"),
													font = fonts.bar,
													widget = wibox.widget.textbox,
													forced_width = 35,
												},
												spacing = 5,
												layout = wibox.layout.fixed.horizontal,
											},
											{
												max_value = 100,
												value = 50,
												forced_height = 19,
												forced_width = 0,
												--paddings = 3,
												background_color = "#0000",
												color = "#C6E7FC",
												widget = wibox.widget.progressbar,
												shape = function(cr, width, height)
													gears.shape.partially_rounded_rect(cr, width, height, false, true, true,
														false)
												end,
												bar_shape = function(cr, width, height)
													gears.shape.partially_rounded_rect(cr, width, height, false, true, true,
														false)
												end,
											},
											layout = wibox.layout.align.horizontal,
											forced_height = 16
										},
										widget = wibox.container.margin,
										top = 6,
										bottom = 6,
										left = 15,
										right = 6,
									},
									widget = wibox.container.background,
									bg = "#2E3440",
									shape = function(cr, width, height)
										gears.shape.rounded_rect(cr, width, height, 25)
									end
								},
								widget = wibox.container.margin,
								left = 15,
								right = 15,
							},
							{
								{
									{
										{
											{
												{
													image = gears.color.recolor_image(icons("cpu"), "#BF616A"),
													resize = false,
													forced_width = 24,
													widget = wibox.widget.imagebox,
													valign = "center",
												},
												{
													markup = string.format("<span foreground='%s'>75%%</span>", "#BF616A"),
													font = fonts.bar,
													widget = wibox.widget.textbox,
													forced_width = 35,
												},
												spacing = 5,
												forced_height = 30,
												layout = wibox.layout.fixed.horizontal,
											},
											{
												max_value = 100,
												value = 100,
												forced_height = 19,
												forced_width = 0,
												--paddings = 3,
												background_color = "#0000",
												color = "#BF616A",
												widget = wibox.widget.progressbar,
												shape = function(cr, width, height)
													gears.shape.partially_rounded_rect(cr, width, height, false, true, true,
														false)
												end,
												bar_shape = function(cr, width, height)
													gears.shape.partially_rounded_rect(cr, width, height, false, true, true,
														false)
												end,
											},
											layout = wibox.layout.align.horizontal,
											forced_height = 16
										},
										widget = wibox.container.margin,
										top = 6,
										bottom = 6,
										left = 15,
										right = 6,
									},
									widget = wibox.container.background,
									bg = "#402E2E",
									shape = function(cr, width, height)
										gears.shape.rounded_rect(cr, width, height, 25)
									end
								},
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
								widget = wibox.widget.textbox,
								markup = "PLACEHOLDER",
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
