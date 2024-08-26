local function time_info()
    return {
        {
            {
                format = string.format("<span foreground='%s'>%s</span>", colors.text, "%H:%M"),
                font = fonts.panel.clock,
                widget = wibox.widget.textclock,
                refresh = 1,
            },
            {
                {
                    {
                        {
                            format = string.format("<span foreground='%s'>%s</span>", colors.text, "%B"),
                            font = fonts.panel.month_and_day,
                            widget = wibox.widget.textclock,
                        },
                        {
                            format = string.format("<span foreground='%s'>%s</span>", colors.text, "%A"),
                            font = fonts.panel.month_and_day,
                            widget = wibox.widget.textclock,
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
            format = string.format("<span foreground='%s'>%s</span>", colors.text, "%d/%m/%Y"),
            font = fonts.panel.date,
            widget = wibox.widget.textclock,
        },
        layout = wibox.layout.align.horizontal
    }
end

return time_info