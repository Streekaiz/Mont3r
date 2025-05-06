repeat task.wait() until game:IsLoaded()

local DEBUG = true 
if game.PlaceId ~= 0 then
    return
end 

local function debug(title, content)
    if DEBUG then 
        warn(title .. " - " .. content)
    end
end 

local cache = {
    [1] = nil,
    [2] = nil,
    [3] = nil    
}

local findFirstChild = workspace.FindFirstChild
local find = string.find 

local players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local replicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")

local localPlayer = players.LocalPlayer 
local localPlayerName = localPlayer.Name
local playerGui = localPlayer.PlayerGui 

local remotes = findFirstChild(replicatedStorage, "Remotes")
local hud = findFirstChild(playerGui, "HUD")

local skillCheckRemote

local function connect(signal, callback)
    local connection = signal:Connect(callback)
    --
    debug("connect", tostring(signal))
    --
    return connection
end   

local function createHandler(object)
    cache[1] = connect(object.ChildAdded, function(child)
        local childName = child.Name 
        debug("childAdded", childName)
        if find(childName, localPlayerName) then 
            skillCheckRemote:FireServer("Hit", childName)
            debug("childAdded", "fired remote")
        end 
    end)

    cache[2] = connect(object.DescendantChanged, function(descendant)
        if object.Parent == nil then 
            debug("descendantChanged", "disconnecting")
            cache[1]:Disconnect()
            cache[2]:Disconnect()
        end 
    end)
end 

if hud then 
    createHandler(hud)
else
    repeat hud = findFirstChild(playerGui, "HUD") until hud 

    createHandler(hud)
end 

connect(playerGui.ChildAdded, function(child)
    if child.Name == "HUD" then 
        createHandler(child)
    end 
end)