local library, builder, saveManager, themeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Streekaiz/Mont3r/refs/heads/main/dependencies/library/builder.lua", true))()

local window = library:CreateWindow({}); setmetatable(window, {
    __index = builder
})

local tabs = window:setupTabs()