-- > Refactored Script

local author, repo = "Streekaiz", "Mont3r"
local rawRepo = "https://raw.githubusercontent.com/" .. author .. "/" .. repo
local dependencies = rawRepo .. "/refs/heads/main/dependencies"
local ui = rawRepo .. "/refs/heads/main/dependencies/library"

local env = {
    utilities = {},
    library = {},
    assets = {},
    services = 
}

do
    local function fetch(url)
        local success, content = pcall(function()
            return game:HttpGet(url)
        end)
        
        if success then
            return content
        else
            warn("Failed to fetch URL: " .. url)
            return nil
        end
    end

    -- Library
    do
        local uiLibrary = fetch(ui .. "/source.lua")
        local builderLibrary = fetch(ui .. "/builder.lua")

        if uiLibrary ~= nil then
            env.library.source = uiLibrary
        end

        if builderLibrary ~= nil then
            env.library.builder = builderLibrary
        end
    end

    -- Utilities
    do
        for _, library in ipairs({"functions", "math", "tween", "render", "color"}) do
            local content = fetch(dependencies .. "/" .. library .. ".lua")
            if content then
                env.utilities[library] = content
            end
        end
    end
end

return env