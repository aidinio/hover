function status_bar(icon_name, foreground, background, percentage)
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
    return {
        widget =
        {
            {
                {
                    {
                        {
                            image = gears.color.recolor_image(icons(icon_name), foreground),
                            resize = false,
                            forced_width = 24,
                            widget = wibox.widget.imagebox,
                            valign = "center",
                        },
                        {
                            markup = string.format("<span foreground='%s'>%s%%</span>", foreground, percentage),
                            font = fonts.bar,
                            widget = wibox.widget.textbox,
                            forced_width = 35,
                        },
                        spacing = 5,
                        layout = wibox.layout.fixed.horizontal,
                    },
                    {
                        max_value = 100,
                        value = percentage,
                        forced_height = 19,
                        forced_width = 0,
                        --paddings = 3,
                        background_color = "#0000",
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
            bg = background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 25)
            end
        }
    }
end

return status_bar