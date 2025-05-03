local library, saveManager, themeManager; do 
    local repository = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"

    local function fetch(file)
        return loadstring(game:HttpGet(repository .. file))()
    end 

    library = fetch("Library.lua")
    saveManager = fetch("addons/SaveManager.lua")
    themeManager = fetch("addons/ThemeManager.lua")

    saveManager:SetLibrary(library)
    themeManager:SetLibrary(library)
end 

local toggles, options, window = library.Toggles, library.Options, library:CreateWindow({
    Title = "Mont3r",
    CornerRadius = 0
})

local tabs = {}; do 
    for i, v in ipairs({
        {"home", "Home", "house"},
        {"main", "Main", "user-round-cog"},
        {"killer", "Killer", "knife"},
        {"survivor", "Survivor", "user"},
        {"visual", "Visual", "lightbulb"},
        {"render", "Render", "eye"},
        {"misc", "Misc", "settings-2"},
        {"settings", "Settings", "settings"}
    }) do 
        tabs[v[1]] = window:AddTab(v[2], v[3])
    end 

    saveManager:BuildConfigSection(tabs.settings)
    themeManager:ApplyToTab(tabs.settings)
end 

local sections = {}; do 
    local tabBoxes = {
        esp = tabs.render:AddLeftTabbox(),
        espSet = tabs.render:AddRightTabbox(),
        vis = tabs.visual:AddRightTabbox()
    }

    sections = {
        home = {
            logs = tabs.home:AddLeftGroupbox("Changelogs"),
            discord = tabs.home:AddRightGroupbox("Discord"),
            server = tabs.home:AddRightGroupbox("Servers"),
        },
        main = {
            aim = tabs.main:AddLeftGroupbox("Aim Assist"),
            silent = tabs.main:AddLeftGroupbox("Silent Aim"),
            localPlayer = tabs.main:AddRightGroupbox("Local Player"),
            autoFarm = tabs.main:AddRightGroupbox("EXP Farm")
        },
        killer = {
            main = tabs.killer:AddLeftGroupbox("Main"),
            exploits = tabs.killer:AddRightGroupbox("Exploits")
        },
        survivor = {
            main = tabs.survivor:AddLeftGroupbox("Main"),
            exploits = tabs.survivor:AddRightGroupbox("Exploits")
        },
        visual = {
            camera = tabs.visual:AddLeftGroupbox("Camera"),
            world = tabs.visual:AddLeftGroupbox("World"),
            bloom = tabBoxes.vis:AddTab("Bloom"),
            color = tabBoxes.vis:AddTab("Color")
        },
        render = {
            enemy = tabBoxes.esp:AddTab("Enemy"),
            friendly = tabBoxes.esp:AddTab("Friendly"),
            text = tabBoxes.espSet:AddTab("Text"),
            element = tabBoxes.espSet:AddTab("Element"),
            object = tabs.render:AddLeftGroupbox("World"),       
        },
        misc = {
            emote = tabs.misc:AddLeftGroupbox("Stickers"),
            lines = tabs.misc:AddRightGroupbox("Voice Lines")
        },
        settings = {
            main = tabs.settings:AddRightGroupbox("Settings")
        }
    }
    
    tabs.home:UpdateWarningBox({Title = "Discord Server", Text = "Join our discord server to be notified on updates & game support!", IsNormal = true, Visible = true})

end 

sections.survivor.main:AddToggle("skillCheck", {
    Text = "Complete Skill Checks"
})

sections.survivor.main:AddToggle("skillCheckNotify", {
    Text = "Notify on Completion",
    Visible = false 
})

sections.survivor.main:AddDropdown("skillCheckMethod", {
    Text = "Completion Method",
    Values = {"ChildAdded", "Hookmetamethod"},
    Default = "ChildAdded",
    Visible = false
})

sections.survivor.main:AddSlider("skillCheckDelay", {
    Text = "Completion Delay", Min = 0, Max = 5, Decimals = 2, Default = 0, HideMax = true, Suffix = "s"
})

toggles["skillCheck"]:OnChanged(function(Value)
    toggles["skillCheckNotify"]:SetVisible(Value)
    toggles["skillCheckMethod"]:SetVisible(Value)
end)

options["skillCheckMethod"]:OnChanged(function(Value)
    options["skillCheckDelay"]:SetVisible(Value == "ChildAdded")
end)

sections.main.localPlayer:AddToggle("localPlayerSpeed", {
    Text = "Edit Speed"
})

sections.main.localPlayer:AddDropdown("localPlayerSpeedMethod", {
    Text = "Method",
    Values = {"CFrame", "Humanoid"},
    Default = "CFrame",
    Visible = false
})

sections.main.localPlayer:AddSlider("localPlayerSpeedVal", {
    Text = "Speed",
    Min = 0, Max = 100, Decimals = 3, HideMax = true,
    Visible = false
})

sections.main.localPlayer:AddToggle("localPlayerJump", {
    Text = "Enable Jumping"
})

sections.main.localPlayer:AddSlider("localPlayerJumpPower", {
    Text = "Jump Power",
    Min = 0, Max = 100, Default = 50, HideMax = true, 
    Visible = false
})

sections.main.localPlayer:AddToggle("localPlayerFlight", {
    Text = "Flight",
    Risky = true
}):AddKeyPicker("localPlayerFlightKey", {
    Text = "Flight", SyncToggleState = true, Mode = "Toggle"
})

sections.main.localPlayer:AddDropdown("localPlayerFlightMethod", {
    Text = "Flight Method",
    Values = {"CFrame", "Velocity"},
    Default = "Velocity", Tooltip = "CFrame is client-sided", 
    Visible = false
})

sections.main.localPlayer:AddSlider("localPlayerFlightSpeed", {
    Text = "Flight Speed",
    Min = 0, Max = 100, Default = 30, HideMax = true,
    Visible = false
})

sections.main.aim:AddToggle("legitAimEnabled", {
    Text = "Enabled"
}):AddKeyPicker("legitAimKey", {
    Text = "Aim Assist",
    Mode = "Hold",
    Modes = {"Toggle", "Hold"}
})

sections.main.aim:AddDropdown("legitAimTarget", {
    Text = "Target Area", 
    Values = {"Head", "Torso", "Arms", "Legs"},
    Default = {"Head", "Torso"},
    Multi = true
})

sections.main.aim:AddDropdown("legitAimMethod", {
    Text = "Mouse Method",
    Values = {"Camera", "Windows API"},
    Default = 2
})

sections.main.aim:AddToggle("legitAimSmoothing", {
    Text = "Use Smoothing"
})

for i, v in ipairs({"X", "Y"}) do 
    sections.main.aim:AddSlider("legitAimSmoothing" .. v, {
        Text = v .. " Smoothing",
        Default = 50, HideMax = true,
        Suffix = "%", 
    })
end

sections.main.aim:AddToggle("legitAimPrediction", {
    Text = "Predict Projectile Velocity"
})

sections.main.aim:AddDropdown("legitAimPredictionType", {
    Text = "Prediction Type",
    Values = {"Static", "Dynamic", "Custom"},
    Multi = false, Default = "Static",
    Visible = false
})

sections.main.aim:AddInput("legitAimPredictionCustom", {
    Text = "Custom Prediction",
    Numeric = true,
    Default = "0.165",
    Finished = true,
    Placeholder = "prediction value",
    AllowEmpty = false,
    MaxLength = 5,
    Visible = false
})

sections.main.aim:AddToggle("legitAimFovUse", {
    Text = "Use FOV",
    Default = true
})

sections.main.aim:AddToggle("legitAimFovShow", {
    Text = "Show FOV Circle"
}):AddColorPicker("legitAimFovColor", {
    Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)),
    Transparency = 0
})

sections.main.aim:AddSlider("legitAimFovRadius", {
    Text = "Circle Radius",
    Min = 30, Max = 360,
    Default = 360 / 2, HideMax = true
    Suffix = " pixels"
})

sections.main.aim:AddDropdown("legitAimFovPosition", {
    Text = "Circle Position",
    Values = {"Mouse", "Centered"},
    Default = "Mouse"
})

sections.main.silent:AddToggle("legitSilentEnabled", {Text = "Enabled"}):AddKeyPicker("legitSilentKey", {SyncToggleState = true, Mode = "Always", Text = "Silent Aim"})

sections.main.silent:AddDropdown("legitSilentTarget", {
    Text = "Target Area", 
    Values = {"Head", "Torso", "Arms", "Legs"},
    Default = {"Head", "Torso"},
    Multi = true
})

sections.main.silent:AddDropdown("legitSilentMethod", {
    Text = "Method",
    Values = {"Remote"},
    Default = 1
})

sections.main.silent:AddSlider("legitSilentChance", {
    Text = "Hit Chance",
    Rounding = 2, HideMax = true, Default = 50,
    Suffix = "%"
})

sections.main.silent:AddToggle("legitSilentPrediction", {
    Text = "Predict Projectile Velocity"
})

sections.main.silent:AddDropdown("legitSilentPredictionType", {
    Text = "Prediction Type",
    Values = {"Static", "Dynamic", "Custom"},
    Multi = false, Default = "Static",
    Visible = false
})

sections.main.silent:AddInput("legitSilentPredictionCustom", {
    Text = "Custom Prediction",
    Numeric = true,
    Default = "0.165",
    Finished = true,
    Placeholder = "prediction value",
    AllowEmpty = false,
    MaxLength = 5,
    Visible = false
})

sections.main.silent:AddToggle("legitSilentFovUse", {
    Text = "Use FOV",
    Default = true
})

sections.main.silent:AddToggle("legitSilentFovShow", {
    Text = "Show FOV Circle"
}):AddColorPicker("legitSilentFovColor", {
    Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)),
    Transparency = 0
})

sections.main.silent:AddSlider("legitSilentFovRadius", {
    Text = "Circle Radius",
    Min = 30, Max = 360,
    Default = 360 / 2, HideMax = true,
    Suffix = " pixels"
})

sections.main.silent:AddDropdown("legitSilentFovPosition", {
    Text = "Circle Position",
    Values = {"Mouse", "Centered"},
    Default = "Mouse"
})

sections.killer.main:AddToggle("killerBot", {
    Text = "Rage Bot",
})

sections.killer.main:AddDropdown("killerBotTarget", {
    Text = "Target Priority",
    Multi = true,
    Values = {"Head", "Torso", "Arms", "Legs"},
    Default = {"Head", "Torso"},
    Visible = false
})

sections.killer.main:AddToggle("killerBotInstant", {
    Text = "Instant Hit",
    Risky = true,
    Visible = false
})

sections.killer.main:AddSlider("killerBotDelay", {
    Text = "Projectile Delay",
    Min = 0, Max = 1000, Default = 1000, Suffix = "s", HideMax = true, 
    Tooltip = "Delays creating a projectile",
    Visible = false
})

sections.killer.main:AddDropdown("killerBotOrigin", {
    Text = "Origin",
    Values = {"Camera", "Character"},
    Default = "Character",
    Visible = false
})

sections.killer.main:AddDropdown("killerBotIgnore", {
    Text = "Ignore Players", SpecialType = "Player", ExcludeLocalPlayer = true, Visible = false
})

sections.killer.exploits:AddToggle("killerKillAll", {
    Text = "Kill All",
    Risky = true
})

sections.killer.exploits:AddDropdown("killerKillAllType", {
    Text = "Method",
    Values = {"Projectile", "Lunge", "Remote"},
    Default = "Remote",
    Visible = false 
})

sections.killer.exploits:AddDropdown("killerKillAllIgnore", {
    Text = "Ignore Players", SpecialType = "Player", ExcludeLocalPlayer = true, Visible = false
})

sections.killer.main:AddDropdown("killerCooldown", {
    Text = "Disable Cooldowns",
    Values = {"Detect", "Lunge", "Ability"}
})

sections.killer.exploits:AddToggle("killerAnimation", {
    Text = "Disable Animations",
    Risky = true
})


toggles["localPlayerSpeed"]:OnChanged(function(Value)
    options["localPlayerSpeedMethod"]:SetVisible(Value)
    options["localPlayerSpeedVal"]:SetVisible(Value)
end)

toggles["localPlayerJump"]:OnChanged(function(Value)
    options["localPlayerJumpPower"]:SetVisible(Value)
end)

toggles["localPlayerFlight"]:OnChanged(function(Value)
    options["localPlayerFlightMethod"]:SetVisible(Value)
    options["localPlayerFlightSpeed"]:SetVisible(Value)
end)

toggles["killerBot"]:OnChanged(function(Value)
    options["killerBotTarget"]:SetVisible(Value)
    toggles["killerBotInstant"]:SetVisible(Value)
    options["killerBotDelay"]:SetVisible(Value)
    options["killerBotOrigin"]:SetVisible(Value)
    options["killerBotIgnore"]:SetVisible(Value)
end)

toggles["killerKillAll"]:OnChanged(function(Value)
    options["killerKillAllType"]:SetVisible(Value)
    options["killerKillAllIgnore"]:SetVisible(Value)
end)

toggles["legitAimSmoothing"]:OnChanged(function(Value)
    options["legitAimSmoothingX"]:SetVisible(Value)
    options["legitAimSmoothingY"]:SetVisible(Value)
end)

toggles["legitAimPrediction"]:OnChanged(function(Value)
    options["legitAimPredictionType"]:SetVisible(Value)
    options["legitAimPredictionCustom"]:SetVisible(Value)
end)

toggles["legitSilentPrediction"]:OnChanged(function(Value)
    options["legitSilentPredictionType"]:SetVisible(Value)
    options["legitSilentPredictionCustom"]:SetVisible(Value)
end)

toggles["legitSilentFovShow"]:OnChanged(function(value)
    options["legitSilentFovPosition"]:SetVisible(value)
end)

toggles["legitAimFovShow"]:OnChanged(function(value)
    options["legitAimFovPosition"]:SetVisible(value)
end)