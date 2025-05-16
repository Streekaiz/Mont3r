local cloneref = cloneref or function(object : any) return object end 
local identifyExecutor = identifyexecutor or isexecutor or function() return "" end
local drawing = Drawing or {new = function(...) return {} end}
local setRenderProperty = setrenderproperty or function(obj, idx, val) obj[idx] = val end 

local services = {}; setmetatable(services, { __index = function(self, key) return cloneref(game:GetService(key) end })
local library = {
    connections = {},
    instances = {},
    drawings = {},

    directory = "mont3r",
    debug = false
};

function library.connect(signal, func)
    local connection = signal:Connect(func)
    --
    library.connections[#library.connections + 1] = connection 
    --
    return connection 
end 

function library.create(instance, properties)
    local object = Instance.new(instance)
    --
    for i, v in ipairs(properties) do 
        object[i] = v 
    end 
    --
    return object 
end 

function library.draw(drawing, properties)
    local object = drawing.new(drawing)
    --
    for i, v in ipairs(properties) do 
        setRenderProperty(object, i, v)
    end 
    --
    return object
end 