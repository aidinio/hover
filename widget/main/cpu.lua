local gears = require("gears")
local math = math

local status_bar = require("hover.widget.wrapper.status_bar")
local cpu_bar = status_bar("cpu", "#BF616A", "#402E2E", 100)

gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = function ()
        local cpu_file = io.open("/proc/stat", "r")
        local line = cpu_file:read("*l")
        cpu_file:close()
        local cpu, user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice = line:match("(%S+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)")
        local total = user + nice + system + idle + iowait + irq + softirq + steal
        local used = total - idle
        cpu_bar.update_value(math.floor(used / total * 100))
    end
}

return cpu_bar