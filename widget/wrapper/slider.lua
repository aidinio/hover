local function slider(icon_name)
    return wibox.widget.base.make_widget_declarative
    {
    {
        {
            {
                image = gears.color.recolor_image(icons(icon_name), "#C6E7FC"),
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
}
end

return slider