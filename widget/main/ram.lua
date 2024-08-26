local gears = require("gears")

local status_bar = require("hover.widget.wrapper.status_bar")
local ram_bar = status_bar("ram", "#C6E7FC", "#2E3440", 50)
local math = math

gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = function ()
        local command = io.popen("free")
        local result = command:read("*a")
        command:close()
        for line in result:gmatch("[^\n]+") do
            if line:find("Mem:") then
                local total, used = line:match("%s+(%d+)%s+(%d+)")
                total = tonumber(total)
                used = tonumber(used)
                free = tonumber(free)
                ram_bar.update_value(math.floor(used / total * 100))
            end
        end
    end
}

return ram_bar