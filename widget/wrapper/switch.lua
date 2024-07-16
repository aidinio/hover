-- gears = require("gears")
cairo = require("lgi").cairo

function svgsurf(context, cr, width, height)
	width = 30
	height = 30
	-- naughty.notify({
	-- 	title = "WOWW",
	-- 	text = "HELLO"
	-- })
	local svg_surface = gears.surface("/home/aidin/.config/awesome/hover/theme/nord_m/icon/bluetooth-connected.svg")

	local image_surface = gears.surface("/home/aidin/.config/awesome/hover/theme/nord_m/icon/bluetooth-connected.svg")
	local resized_image_surface = cairo.ImageSurface(cairo.Format.RGB24, height, height)
	local resized_cr = cairo.Context(resized_image_surface)
	
	resized_cr:scale(height / image_surface.width, height / image_surface.height)
	resized_cr:set_source_surface(image_surface, 0, 0)
	resized_cr:paint()
	-- naughty.notify({
	-- 	title = "svg_surface",
	-- 	text = "svg_surface " .. svg_surface.width
	-- })
	-- local resized_surface = svg_surface:take_surface()
	-- local cr = cairo.Context(resized_surface)
	-- cr:set_source_surface(svg_surface, 0, 0)
	-- cr:rectangle(0, 0, width, height)
	-- cr:fill()
	cr:set_source_surface(resized_image_surface, 0, 0)
	cr:paint()
	-- return svg_surface
end

function switch()
	return {
		widget = {
			-- {
			-- 	{
			-- 		image = gears.color.recolor_image(icons("bluetooth-connected"), "#2E3440"),
			-- 		resize = true,
			-- 		forced_width = 25,
			-- 		widget = wibox.widget.imagebox,
			-- 		valign = "center",
			-- 		halign = "center"
			-- 	},
			-- 	layout = wibox.layout.fixed.horizontal,
			-- 	forced_width = 25
			-- },
			widget = wibox.container.background,
			bg = "#C6E7FC",
			shape = function(cr)
				gears.shape.rounded_rect(cr, 45, 45, 30)
			end,
			bgimage = function(context, cr, width, height)
				return svgsurf(context, cr, width, height)
			end,
			forced_width = 45,
		}
	}
end

return switch
