local gui = require("lib.gui")
local event = require("__flib__.event")
local util = require("scripts.util")

local sigsw_gui = {}

-- Forward delcaration
local create_window

--------------------------
-- define functions
--------------------------

function create_window(player_index, unit_number)
    local rootgui = game.get_player(player_index).gui.screen
    local sigsw = gui.build(rootgui, {
        { type = "frame", direction = "vertical", save_as = "main_window", name = "sigsw-main-window",
            tags = { unit_number = unit_number },
            children = {
                -- Title Bar
                -- { type = "flow", save_as = "titlebar.flow", children = {
                --     { type = "label", style = "frame_title", caption = { "sigsw.window-title" },
                --         elem_mods = { ignored_by_interaction = true } },
                --     { template = "drag_handle" },
                --     -- { template = "close_button", name = "sigsw-main-window", handlers = "sigsw_handlers.close_button" }
                -- } },
                -- Content
                { type = "frame",
                    children = {
                        { type = "label", caption = "Hello World?" }
                    } }
            } }
    })

    -- sigsw.titlebar.flow.drag_target = sigsw.main_window
    sigsw.main_window.force_auto_center()
    return sigsw
end

function sigsw_gui.Open(player_index, entity)
    local player = game.get_player(player_index)
    local rootgui = player.gui.screen

    if rootgui["sigsw-main-window"] then
        if rootgui["sigsw-main-window"].tags.unit_number == entity.unit_number then
            player.opened = rootgui["sigsw-main-window"]
            return
        end
        sigsw_gui.Close(player_index)
    end

    local sigsw = create_window(player_index, entity.unit_number)

    local pd = util.get_player_data(player_index)
    pd.sigsw = sigsw
    player.opened = pd.sigsw.main_window
end

function sigsw_gui.Close(player_index, name)
    local window = name or "sigsw-main-window"
    local player = game.get_player(player_index)
    local rootgui = player.gui.screen
    if window and rootgui[window] then
      rootgui[window].destroy()
      if window == "sigsw-main-window" then        
        local pd = global.player_data[player_index]
        pd.sigsw = nil
      end
    end
end

--------------------------
-- register handlers
--------------------------

-- function sigsw_gui.RegisterHandlers()
--     gui.add_handlers {
--     }
--     gui.register_handlers()
-- end

-- function sigsw_gui.RegisterTemplates()
--     gui.add_templates {
--     }
-- end

-- sigsw_gui.RegisterHandlers()
-- sigsw_gui.RegisterTemplates()

--------------------------
-- init flib gui
--------------------------

event.on_init(function()
    gui.init()
    gui.build_lookup_tables()
    asd = basd[23]
end)

event.on_load(function()
    gui.build_lookup_tables()
end)

event.register(defines.events.on_gui_opened, function(e)
    if gui.dispatch_handlers(e) then return end
    if not (e.entity and e.entity.valid) then return end
    if e.entity.name == "list-combinator" then
        sigsw_gui.Open(e.player_index, e.entity)
    else
        sigsw_gui.Close(e.player_index)
    end
end)

return sigsw_gui
