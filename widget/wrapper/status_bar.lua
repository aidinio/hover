function status_bar(icon, foreground, background, percentage)
    -- result = ""
    -- local function networkMonitor()
    --     awful.spawn.easy_async_with_shell("ping -c 1 google.com", function(stdout, stderr, exitreason, exitcode)
    --         -- Handle the output or errors here
    --         if exitcode == 0 then
    --             result = "Network is reachable"
    --         else
    --             result = "Network is unreachable"
    --         end
    --         naughty.notify({
    --             title = result
    --         })
    --     end)
    -- end
    -- local my_timer = gears.timer {
    --     timeout = 3,
    --     autostart = true,
    --     call_now = true,
    --     callback = networkMonitor
    -- }
    icon = icons(icon)
    local image_widget = wibox.widget.base.make_widget_declarative {
        image = gears.color.recolor_image(icon, foreground),
        resize = false,
        forced_width = 25,
        widget = wibox.widget.imagebox,
        valign = "center",
        update = function(self)
            self.image = gears.color.recolor_image(icon, foreground)
        end
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
        forced_height = 19,
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
    
    return wibox.widget.base.make_widget_declarative {
        update_icon = function (new_icon)
            icon = new_icon
            image_widget:update()
        end,
        update_value = function (value)
            percentage = value
            text_widget:update()
            bar_widget:update()
        end,
        update_foreground = function (new_foreground)
            foreground = new_foreground
            text_widget:update()
            bar_widget:update()
            image_widget:update()
        end,
        update_background = function (self, new_background)
            background = new_background
            self.bg = background
        end,
        {
            {
                {
                    image_widget,
                    text_widget,
                    spacing = 5,
                    layout = wibox.layout.fixed.horizontal,
                },
                bar_widget,
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
        bg = background,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 25)
        end
    }
end

return status_bar
