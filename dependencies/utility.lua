local library = {
    connections = {},
    instances = {},
    drawings = {},

    directory = "mont3r"
}; setmetatable(library, {
    __index = function(self, key)
        return game:GetService(key)
    end 
})

local cloneref = cloneref or function(object : any) return object end 
local identifyexecutor = identifyexecutor or isexecutor or function() return "" end

function library.log(content)
    warn("utility library - " .. content)
end 

function library.connect(signal, func)
    local connection = signal
end 