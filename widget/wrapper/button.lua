local wibox = require("wibox")

function button(icon_name)
    return wibox.widget.base.make_widget_declarative {
        {
            {
                image = icons(icon_name),
                resize = true,
                upscale = true,
                downscale = true,
                widget = wibox.widget.imagebox,
                forced_width = 20,
                forced_height = 20
            },
            widget = wibox.container.place,
            valign = "center",
            halign = "center"
        },
        widget = wibox.container.background,
        bg = "#C6E7FC",
        shape = function(cr)
            gears.shape.rounded_rect(cr, 30, 30, 20)
        end,
    }
end

return button