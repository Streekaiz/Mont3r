local env = MONT3R_ENV
local utility = env.dependencies.functions
local library = env.dependencies.library
 
local services = {}; setmetatable(services, {__index = function(self, key) return cloneref and cloneref(game:GetService(key)) or game:GetService(key)})

local players = services.Players 
local replicatedStorage = services.ReplicatedStorage

local localPlayer = players.LocalPlayer 
local playerGui = localPlayer.PlayerGui

local remotes = {}; do 
    for _, v in ipairs(replicatedStorage.Remotes) do 
        remotes[v.Name] = v
    end 

    remotes["SetLookAngles"] = replicatedStorage:FindFirstChild("SetLookAngles")
end 

local function getMatchData()
    local cache = {} -- Map, GameType, GensLeft, RoundTime 

    for i, v in ipairs(workspace.Bools) do 
        if v.Name ~= "IntermissionTime" or v.Name ~= "PregameTime" then 
            table.insert(cache, v)
        end 
    end 

    return cache 
end 

local function getKillerData()
    for i, v in ipairs(players:GetPlayers()) do 
        local weapon = v.Character:FindFirstChild("Weapon")
        if weapon then 
            return v, weapon, weapon:GetAttribute("Killer")
        end 
    end 

    return nil, nil, "Slasher"
end 

local function getMap()
    local map = workspace.Map_Holder:FindFirstChild("Game_Map")

    if map then 
        return map 
    end 
end 

local function connectCheckHandler(object)
    assert(object.Name == "HUD", "Wrong object, object name should be HUD!")

    utility.connect(object.ChildAdded, function(child)
        if string.find(child.Name, localPlayer.Name) then 

        end 
    end, "checkHandler")
end 