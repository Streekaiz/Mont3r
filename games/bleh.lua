local mont3rEnv = isfile("Mont3r/environment.lua") and readfile("Mont3r/environment.lua") or loadstring(game:HttpGet("https://placeholder"))()
local funcs = mont3rEnv.utilites.functions
local connections = mont3rEnv.connections 

--[[
    local services = {}; setmetatable(services, {
        __index = function(self, key) 
            return cloneref and cloneref(game:GetService(key)) or game:GetService(key)
        end
    })
]]

-- // Setting up variables; and caching methods
local players = mont3rEnv.services.Players 
local runService = mont3rEnv.services.RunService 
local tweenService = mont3rEnv.services.TweenService 
local userInputService = mont3rEnv.services.UserInputService
local replicatedStorage = mont3rEnv.services.ReplicatedStorage
local stats = mont3rEnv.services.Stats 

local localPlayer = players.LocalPlayer 

local findFirstChild = workspace.FindFirstChild 
local findFirstChildOfClass = workspace.FindFirstChildOfClass
local getChildren = workspace.getChildren

local remotes = findFirstChild(replicatedStorage, "Remotes")

local function getKiller()
    for i, v in ipairs(players:GetPlayers()) do 
        if funcs.isAlive(v) then 
            local weapon = findFirstChild(v.Character, "Weapon") 
            if weapon then
                return v, weapon 
            end  
        end 
    end 

    return nil, nil 
end 

local function getRemotes(object)
    local cache = {}

    if object:IsA("Tool") then 
        for i, v in ipairs(getChildren(object)) do 
            if string.find(string.lower(v.Class), "remote") then 
                cache[v.Name] = v 
            end 
        end 
    end 

    return cache 
end 

local function connectCheckHandler(object)
    
    local success, message 
    success, message = pcall(function()
        funcs.connect(object.ChildAdded, function(child)
            if string.find(child.Name, localPlayer.Name) then 
                remotes.skillCheck("Hit", child)
            end 
        end, "checkHandler")
    end

    if not success then 
        warn("connectCheckHandler : failed to write to childAdded, " .. message)
        return 
    end 

    success, message = pcall(function()
        funcs.connect(object.descendant, function()
            if object.Parent == nil then
                if connections["checkHandler"] then 
                    connections["checkHandler"]:Disconnect()
                    connections["checkDescendantHandler"]:Disconnect()
                end 
            end 
        end, "checkDescendantHandler") -- signal placeholder; change later
    end 

    if not success then 
        warn("connectCheckHandler : failed to write to descendant event, " .. message)
        return 
    end 
    
    return 
end 

local survivorAnimations, killerAnimations = { names = {}, assets = {} }, { names = {}, assets = {} }; do 

end 
