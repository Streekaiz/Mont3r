local function load(url)
    return loadstring(game:HttpGet(url, true))()
end 

local repository = "https://raw.githubusercontent.com/devidcomsono/Obsidian/main/"

local library = load(repository .. "Library.lua")
local saveManager, themeManager = load(repository .. "addons/SaveManager.lua"), load(repository .. "addons/ThemeManager.lua")

local builder = {}
library.__index = library; do 
    function builder.setUpTabs(tbl)
        local tabs = {}; tbl = tbl or {
            {"home", "Home", "house"},
            {"main", "Main", ""}
            {"combat", "Combat", "locate"},
            {"visual", "Visual", "eye"},
            {"render", "Render", ""},
            {"misc", "Miscallaenous", ""},
            {"settings", "Settings", "settings"}
        }

        for i, v in ipairs(tbl) do 
            tabs[1] = self:AddTab(v[2], v[3])
        end 

        return tabs 
    end 
end 