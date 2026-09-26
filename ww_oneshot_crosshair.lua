local globals = require("plug.globals")
local waywall = require("waywall")

local M = {}

M.setup = function(config)
    config = config or {}
    config.actions = config.actions or {}

    local plugin_name = "ww_oneshot_crosshair"
    local image_path = globals.PLUG_CONFIG_DIR .. plugin_name .. "/crosshair.png"

    local cfg = {
        resx = 1920,
        resy = 1080,
        size = 80,
        key = "K",
        path = image_path,
    }

    config.actions[cfg.key] = function()
        if crosshair_image then
            crosshair_image:close()
            crosshair_image = nil
        end

        if crosshair_active then
            crosshair_active = false
        else
            crosshair_active = true
            crosshair_image = waywall.image(cfg.path, {
                dst = {
                    x = (cfg.resx - cfg.size) / 2,
                    y = (cfg.resy - cfg.size) / 2,
                    w = cfg.size,
                    h = cfg.size,
                },
            })
        end
    end
end

return M