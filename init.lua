local globals = require("plug.globals")
local waywall = require("waywall")

local M = {}

M.setup = function(config)
    config = config or {}
    config.actions = config.actions or {}

    local plugin_name = "ww_oneshot_crosshair"
    local image_path = globals.PLUG_CONFIG_DIR .. plugin_name .. "/crosshair.png"

    local pluginconfig = {
        resx = config.resolution[1],
        resy = config.resolution[2],
        size = 80,
        key = "K",
        path = image_path,
    }

    config.actions[pluginconfig.key] = function()
        if crosshair_image then
            crosshair_image:close()
            crosshair_image = nil
        end

        if crosshair_active then
            crosshair_active = false
        else
            crosshair_active = true
            crosshair_image = waywall.image(pluginconfig.path, {
                dst = {
                    x = (pluginconfig.resx - pluginconfig.size) / 2,
                    y = (pluginconfig.resy - pluginconfig.size) / 2,
                    w = pluginconfig.size,
                    h = pluginconfig.size,
                },
            })
        end
    end
end

return M