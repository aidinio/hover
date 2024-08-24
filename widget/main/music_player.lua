local lgi = require("lgi")
local Gio = lgi.Gio

local bus = Gio.bus_get_sync(Gio.BusType.SESSION, nil)

local function make_background(context, cr, width, height)
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

local function spotify_pause()
    bus:call_sync("org.mpris.MediaPlayer2.spotify",
        "/org/mpris/MediaPlayer2",
        "org.mpris.MediaPlayer2.Player",
        "PlayPause",
        nil,
        nil,
        Gio.DBusCallFlags.NONE,
        -1)
end

local function music_player()
    local play_button = wibox.widget.base.make_widget_declarative {
        image = gears.color.recolor_image(icons("play-bold"), "#C6E7FC"),
        resize = true,
        forced_width = 24,
        widget = wibox.widget.imagebox,
        valign = "center",
    }
    play_button:connect_signal("button::press", spotify_pause)
    return {
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
                            play_button,
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
    }
end

return music_player
