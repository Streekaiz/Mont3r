local function load(url)
    return loadstring(game:HttpGet(url, true))()
end 

local repository = "https://raw.githubusercontent.com/devidcomsono/Obsidian/main/"

local library = load(repository .. "Library.lua")
local saveManager, themeManager = load(repository .. "addons/SaveManager.lua"), load(repository .. "addons/ThemeManager.lua")

local builder = {}; do 
    function builder.setUpTabs(tbl)
        local tabs = {}; tbl = tbl or {
            {"home", "Home", "house"},
            {"main", "Main", ""},
            {"legit", "Legit", "locate"},
            {"rage", "Rage", "locate"},
            {"visual", "Visual", "eye"},
            {"render", "Render", ""},
            {"misc", "Miscallaenous", ""},
            {"settings", "Settings", "settings"}
        }

        for i, v in ipairs(tbl) do 
            tabs[1] = self:AddTab(v[2], v[3])
        end 

        return tabs 
    end 

    function builder.setUpFov(flag)
        flag = flag .. "Fov"
        
        self:AddToggle(flag .. "Use", {
            Text = "Use FOV",
            Default = true
        })

        self:AddToggle(flag .. "Show", {
            Text = "Show FOV Circle"
        }):AddColorPicker(flag .. "Color", {
            Default = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)),
            Transparency = 1
        })

        self:AddSlider(flag .. "Radius", {
            Text = "Circle Radius",
            Min = 30, Max = 360,
            Default = 360 / 2,
            Suffix = " pixels"
        })

        self:AddDropdown(flag .. "Position", {
            Text = "Circle Position",
            Values = {"Mouse", "Centered"},
            Default = "Mouse"
        })

        library.Toggles[flag .. "Show"]:OnChanged(function(value)
            library.Options[flag .. "Position"]:SetVisible(Value)
        end)
        
    end 

    function builder.setUpAimAssist()
        local flag = "legitAim"

        self:AddToggle(flag .. "Enabled", {
            Text = "Enabled"
        }):AddKeyPicker(flag .. "Key", {
            Text = "Aim Assist",
            Mode = "Hold",
            Modes = {"Toggle", "Hold"}
        })

        self:AddDropdown(flag .. "Target", {
            Text = "Target Area", 
            Values = {"Head", "Torso", "Arms", "Legs"},
            Default = {"Head", "Torso"},
            Multi = true
        })

        self:AddDropdown(flag .. "Method", {
            Text = "Mouse Method",
            Values = {"Camera", "Windows API"},
            Default = 2
        })

        self:AddToggle(flag .. "Smoothing", {
            Text = "Use Smoothing"
        }):OnChanged(function(Value)
            library.Options[flag .. "SmoothingX"]:SetVisible(Value)
            library.Options[flag .. "SmoothingY"]:SetVisible(Value)
        end)

        for i, v in ipairs({"X", "Y"}) do 
            self:AddSlider(flag .. "Smoothing" .. v, {
                Text = v .. " Smoothing",
                Default = 5,
                Suffix = "%", 
            })
        end 

        self:AddToggle(flag .. "Prediction", {
            Text = "Predict Projectile Velocity"
        }):OnChanged(function(Value)
            library.Options[flag .. "PredictionType"]:SetVisible(Value)
            library.Options[flag .. "PredictionCustom"]:SetVisible(Value)
        end)
        
        self:AddDropdown(flag .. "PredictionType", {
            Text = "Prediction Type",
            Values = {"Static", "Dynamic", "Custom"},
            Multi = true,
        })

        self:AddInput(flag .. "PredictionCustom", {
            Text = "Custom Prediction",
            Numeric = true,
            Default = "0.165",
            Finished = true,
            Placeholder = "prediction value",
            AllowEmpty = false,
            MaxLength = 5
        })
    end 

    function builder.setUpSilentAim()
        local flag = "legitSilent"
        self:AddToggle(flag .. "Enabled", {Text = "Enabled"}):AddKeyPicker(flag .. "Key", {SyncToggleState = true, Mode = "Always", Text = "Silent Aim"})

        self:AddDropdown(flag .. "Target", {
            Text = "Target Area", 
            Values = {"Head", "Torso", "Arms", "Legs"},
            Default = {"Head", "Torso"},
            Multi = true
        })

        self:AddDropdown(flag .. "Method", {
            Text = "Method",
            Values = {"Raycast"},
            Default = 1
        })

        self:AddSlider(flag .. "Chance", {
            Text = "Hit Chance",
            Rounding = 2,
            Suffix = "%"
        })

        self:AddToggle(flag .. "Prediction", {
            Text = "Predict Projectile Velocity"
        }):OnChanged(function(Value)
            library.Options[flag .. "PredictionType"]:SetVisible(Value)
            library.Options[flag .. "PredictionCustom"]:SetVisible(Value)
        end)
        
        self:AddDropdown(flag .. "PredictionType", {
            Text = "Prediction Type",
            Values = {"Static", "Dynamic", "Custom"},
            Multi = true,
        })

        self:AddInput(flag .. "PredictionCustom", {
            Text = "Custom Prediction",
            Numeric = true,
            Default = "0.165",
            Finished = true,
            Placeholder = "prediction value",
            AllowEmpty = false,
            MaxLength = 5
        })
    end 
end 

return library, builder, saveManager, themeManager