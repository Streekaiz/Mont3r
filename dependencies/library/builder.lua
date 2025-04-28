local function load(url)
    return loadstring(game:HttpGet(url, true))()
end 

local repository = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"

local library = load(repository .. "Library.lua")
local saveManager, themeManager = load(repository .. "addons/SaveManager.lua"), load(repository .. "addons/ThemeManager.lua")

local builder = {}; do 
    function builder.setUpTabs(window, tbl)
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
            tabs[1] = window:AddTab(v[2], v[3])
        end 

        return tabs 
    end 

    function builder.setUpFov(section, flag)
        flag = flag .. "Fov"
        
        section:AddToggle(flag .. "Use", {
            Text = "Use FOV",
            Default = true
        })

        section:AddToggle(flag .. "Show", {
            Text = "Show FOV Circle"
        }):AddColorPicker(flag .. "Color", {
            Default = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)),
            Transparency = 1
        })

        section:AddSlider(flag .. "Radius", {
            Text = "Circle Radius",
            Min = 30, Max = 360,
            Default = 360 / 2,
            Suffix = " pixels"
        })

        section:AddDropdown(flag .. "Position", {
            Text = "Circle Position",
            Values = {"Mouse", "Centered"},
            Default = "Mouse"
        })

        library.Toggles[flag .. "Show"]:OnChanged(function(value)
            library.Options[flag .. "Position"]:SetVisible(Value)
        end)
        
    end 

    function builder.setUpAimAssist(section)
        local flag = "legitAim"

        section:AddToggle(flag .. "Enabled", {
            Text = "Enabled"
        }):AddKeyPicker(flag .. "Key", {
            Text = "Aim Assist",
            Mode = "Hold",
            Modes = {"Toggle", "Hold"}
        })

        section:AddDropdown(flag .. "Target", {
            Text = "Target Area", 
            Values = {"Head", "Torso", "Arms", "Legs"},
            Default = {"Head", "Torso"},
            Multi = true
        })

        section:AddDropdown(flag .. "Method", {
            Text = "Mouse Method",
            Values = {"Camera", "Windows API"},
            Default = 2
        })

        section:AddToggle(flag .. "Smoothing", {
            Text = "Use Smoothing"
        }):OnChanged(function(Value)
            library.Options[flag .. "SmoothingX"]:SetVisible(Value)
            library.Options[flag .. "SmoothingY"]:SetVisible(Value)
        end)

        for i, v in ipairs({"X", "Y"}) do 
            section:AddSlider(flag .. "Smoothing" .. v, {
                Text = v .. " Smoothing",
                Default = 5,
                Suffix = "%", 
            })
        end 

        section:AddToggle(flag .. "Prediction", {
            Text = "Predict Projectile Velocity"
        }):OnChanged(function(Value)
            library.Options[flag .. "PredictionType"]:SetVisible(Value)
            library.Options[flag .. "PredictionCustom"]:SetVisible(Value)
        end)
        
        section:AddDropdown(flag .. "PredictionType", {
            Text = "Prediction Type",
            Values = {"Static", "Dynamic", "Custom"},
            Multi = true,
        })

        section:AddInput(flag .. "PredictionCustom", {
            Text = "Custom Prediction",
            Numeric = true,
            Default = "0.165",
            Finished = true,
            Placeholder = "prediction value",
            AllowEmpty = false,
            MaxLength = 5
        })
    end 

    function builder.setUpSilentAim(section)
        local flag = "legitSilent"
        section:AddToggle(flag .. "Enabled", {Text = "Enabled"}):AddKeyPicker(flag .. "Key", {SyncToggleState = true, Mode = "Always", Text = "Silent Aim"})

        section:AddDropdown(flag .. "Target", {
            Text = "Target Area", 
            Values = {"Head", "Torso", "Arms", "Legs"},
            Default = {"Head", "Torso"},
            Multi = true
        })

        section:AddDropdown(flag .. "Method", {
            Text = "Method",
            Values = {"Raycast"},
            Default = 1
        })

        section:AddSlider(flag .. "Chance", {
            Text = "Hit Chance",
            Rounding = 2,
            Suffix = "%"
        })

        section:AddToggle(flag .. "Prediction", {
            Text = "Predict Projectile Velocity"
        }):OnChanged(function(Value)
            library.Options[flag .. "PredictionType"]:SetVisible(Value)
            library.Options[flag .. "PredictionCustom"]:SetVisible(Value)
        end)
        
        section:AddDropdown(flag .. "PredictionType", {
            Text = "Prediction Type",
            Values = {"Static", "Dynamic", "Custom"},
            Multi = true,
        })

        section:AddInput(flag .. "PredictionCustom", {
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