local cloneref = cloneref or function(object) return object end 
local script = {
    environment = MONT3R_ENV or ENV or mont3rEnv or {},
    services = {},
    remotes = {},
    connections = {},
    toggles = {},
    options = {},
    library = {},
    emotes = {},
    gameData = {
        map = "",
        gameType = "",
        gensLeft = 8,
        roundTime = 300
    },
    killerData = {
        player = nil,
        weapon = nil,
        name = "Slasher",
        detectCooldown = 0,
        lungeCooldown = 0,
        perkCooldown = 0
    }
}; setmetatable(script.services, {
    __index = function(self, key)
        return cloneref(game:GetService(key))
    end 
})

local players = script.services.Players 
local lighting = script.services.Lighting
local replicatedStorage = script.services.ReplicatedStorage
local workspace = script.services.Workspace 

local localPlayer = players.LocalPlayer 
local camera = workspace.CurrentCamera 
local playerGui = localPlayer.PlayerGui 

local findFirstChild = workspace.FindFirstChild

local hud = findFirstChild(playerGui, "HUD") 

local bloomEffect, colorCorrectionEffect = Instance.new("BloomEffect"), Instance.new("ColorCorrectionEffect")

for i, v in ipairs(replicatedStorage.Remotes) do 
    script.remotes[v.Name] = v 

    remotes["SetLookAngles"] = findFirstChild(replicatedStorage, "SetLookAngles")
end 

if require then 
    script.emotes = require(replicatedStorage.Stickers).GrabAll 
else
    script.emotes = loadstring(game:HttpGet("", true))()
end

do 
    function script:connect(index, signal, callback)
        local connection = signal:Connect(callback)
        self.connections[index] = connection
        return connection  
    end 
    
    function script:getKillerData()
        for i, v in ipairs(players:GetPlayers()) do 
            local weapon = findFirstChild(v.Character, "Weapon")
            if weapon then 
                local killer = weapon:GetAttribute("Killer")

                self.killerData.player = v 
                self.killerData.weapon = weapon 
                self.killerData.name = killer 

                return v, weapon, killer
            end 
        end 

        return nil, nil, "Slasher"
    end 

    function script:getMap()
        return findFirstChild(mworkspace.Map_Holder, "Game_Map")
    end 

    function script:applyHandler(object, extrafunc)
        local func = extrafunc or function() end 
        self:connect("skillCheckHandler", object.ChildAdded, function(child)
            if string.find(child.Name, localPlayer.Name) then 
                self.remotes.skillCheck:FireServer("Hit", child.Name)
                func("fire")
            end 
        end)
        self:connect("skillCheckAncestryHandler", object.AncestryChanged, function()
            if not object:IsDescendantOf(game) then 
                func("disconnect")
                self.connections["skillCheckHandler"]:Disconnect()
                self.connections["skillCheckAncestryHandler"]:Disconnect()
            end 
        end)
        func("created")
    end
end

script:connect("hudHandler", playerGui.ChildAdded, function(child)
    if child.Name == "HUD" then 
        hud = child
        script:applyHandler(child)
    end 
end)

if hud then 
    script:applyHandler(hud)
end 

local oldNameCall; oldNameCall = hookmetamethod(game, "__namecall", function(self, ...) -- use newcclosure later
    local method, args = getnamecallmethod(), {...}

    if method == "FireServer" then 
    --[[
        if self.Name == "SetLookAngles" and PLACEHOLDER then 
            args = {
                (-1 - 1),
                (-1 - 1)
            }
        end
        
        if self.Name == "skillCheck" and PLACEHOLDER then
            args[1] = "Hit"
        end
    ]]
        
    end 

    return oldNameCall 
end)