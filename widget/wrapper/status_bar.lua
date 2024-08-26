local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

function status_bar(icon, foreground, background, percentage)
    icon = icons(icon)
    local image_widget = wibox.widget.base.make_widget_declarative {
        image = gears.color.recolor_image(icon, foreground),
        -- resize = true,
        -- upscale = true,
        forced_width = 25,
        forced_height = 25,
        widget = wibox.widget.imagebox,
        valign = "center",
        update = function(self)
            self.image = gears.color.recolor_image(icon, foreground)
        end,
        point = { x = 13, y = 1 }
    }

    local text_widget = wibox.widget.base.make_widget_declarative {
        markup = string.format("<span foreground='%s'>%s%%</span>", foreground, percentage),
        font = fonts.bar,
        widget = wibox.widget.textbox,
        forced_width = 40,
        update = function(self)
            self.markup = string.format("<span foreground='%s'>%s%%</span>", foreground, percentage)
        end,
    }

    local bar_widget = wibox.widget.base.make_widget_declarative {
        max_value = 100,
        value = percentage,
        forced_height = 10,
        height = 10,
        forced_width = 0,
        paddings = 0,
        background_color = "#fff0",
        color = foreground,
        widget = wibox.widget.progressbar,
        shape = function(cr, width, height)
            gears.shape.partially_rounded_rect(cr, width, height, false, true,
                true,
                false)
        end,
        bar_shape = function(cr, width, height)
            gears.shape.partially_rounded_rect(cr, width, height, false, true,
                true,
                false)
        end,
        update = function(self)
            self.color = foreground
            self.value = percentage
        end
    }

    local background_widget = wibox.widget.base.make_widget_declarative {
        {
            {
                wibox.widget.seperator,
                {
                    text_widget,
                    bar_widget,
                    layout = wibox.layout.align.horizontal,
                },
                layout = wibox.layout.align.horizontal,
            },
            widget = wibox.container.margin,
            top = 6,
            bottom = 6,
            left = 45,
            right = 6,
        },
        widget = wibox.container.background,
        bg = background,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 25)
        end,
        forced_width = 1000,
        point = { x = 0, y = 0 }
    }

    return wibox.widget.base.make_widget_declarative {
        update_icon = function(new_icon)
            icon = new_icon
            image_widget:update()
        end,
        update_value = function(value)
            percentage = value
            text_widget:update()
            bar_widget:update()
        end,
        update_foreground = function(new_foreground)
            foreground = new_foreground
            text_widget:update()
            bar_widget:update()
            image_widget:update()
        end,
        update_background = function(new_background)
            background = new_background
            -- self.bg = new_background
            background_widget.bg = new_background
        end,
        -- wibox.widget.seperator,wibox.widget.seperator,
        {
            background_widget,
            image_widget,
            layout = wibox.layout.manual,
        },
        layout = wibox.layout.align.horizontal,
        forced_height = 27,
        forced_width = 340
    }
end

return status_bar
