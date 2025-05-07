local cloneref = cloneref or function(object) return object end 
local script = {
    environment = MONT3R_ENV or ENV or mont3rEnv or {},
    services = {},
    remotes = {},
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

local players = services.Players 
local lighting = services.Lighting
local replicatedStorage = services.ReplicatedStorage
local workspace = services.Workspace 

local findFirstChild = workspace.FindFirstChild

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

for i, v in ipairs(replicatedStorage.Remotes) do 
    script.remotes[v.Name] = v 

    remotes["SetLookAngles"] = findFirstChild(replicatedStorage, "SetLookAngles")
end 

local oldNameCall; oldNameCall = hookmetamethod(game, "__namecall", function(self, ...) -- use newcclosure later
    local method, args = getnamecallmethod(), {...}

    if method == "FireServer" and self.Name == "SetLookAngles" then 
        if placeHolder
        args = {
            placeHolder1,
            placeHolder2
        }
    end 

    return oldNameCall 
end)