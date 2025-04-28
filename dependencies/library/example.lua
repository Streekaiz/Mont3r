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
            {"main", "Main", "user-round-cog"},
            {"legit", "Legit", "locate"},
            {"rage", "Rage", "locate-fixed"},
            {"visual", "Visual", "sun-medium"},
            {"render", "Render", "eye"},
            {"misc", "Miscallaenous", "settings-2"},
            {"settings", "Settings", "settings"}
        }

        for i, v in ipairs(tbl) do 
            tabs[v[1]] = window:AddTab(v[2], v[3])
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
            Transparency = 0
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
            library.Options[flag .. "Position"]:SetVisible(value)
        end)
        
    end 

    function builder.setUpAimAssist(section, flag)
        flag = flag or "legitAim"

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
                Default = 50,
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
            Visible = false
        })

        section:AddInput(flag .. "PredictionCustom", {
            Text = "Custom Prediction",
            Numeric = true,
            Default = "0.165",
            Finished = true,
            Placeholder = "prediction value",
            AllowEmpty = false,
            MaxLength = 5,
            Visible = false
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
            Visible = false
        })

        section:AddInput(flag .. "PredictionCustom", {
            Text = "Custom Prediction",
            Numeric = true,
            Default = "0.165",
            Finished = true,
            Placeholder = "prediction value",
            AllowEmpty = false,
            MaxLength = 5,
            Visible = false
        })
    end 

    function builder.setUpRagebot(section, flag)
        flag = flag or "rageBot"

        section:AddToggle(flag .. "Enabled", {
            Text = "Enabled",
            Risky = true
        })

        section:AddDropdown(flag .. "Target", {
            Text = "Target Priority",
            Values = {"Head", "Torso", "Arms", "Legs"},
            Default = {"Head"}
        })

        section:AddDropdown(flag .. "Scan", {
            Text = "Scanning",
            Values = {"None", "Standard", "Advanced"},
            Default = 2,
            Tooltip = "Problems may arise if set to 'none'"
        })

        section:AddToggle(flag .. "Force", {
            Text = "Force Hit",
            Risky = true
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
            Visible = false
        })

        section:AddInput(flag .. "PredictionCustom", {
            Text = "Custom Prediction",
            Numeric = true,
            Default = "0.165",
            Finished = true,
            Placeholder = "prediction value",
            AllowEmpty = false,
            MaxLength = 5,
            Visible = false
        })

        section:AddToggle(flag .. "Notification", {
            Text = "Hit Notification",
            Default = true 
        })

        section:AddDropdown(flag .. "IgnorePlayer", {
            Text = "Ignore Players",
            SpecialType = "Player",
            Searchable = true,
            ExcludeLocalPlayer = true,
            Multi = true
        })

        section:AddDropdown(flag .. "IgnoreTeam", {
            Text = "Ignore Teams",
            SpecialType = "Team",
            Multi = true
        })
    end 

    function builder.setUpBloomEffect(section, flag)
        flag = flag .. "Bloom"
    
        section:AddToggle(flag .. "Enabled", {
            Text = "Enable Bloom Effect",
            Default = false
        })
    
        section:AddSlider(flag .. "Intensity", {
            Text = "Intensity",
            Min = 0, Max = 10,
            Default = 1
        })
    
        section:AddSlider(flag .. "Size", {
            Text = "Size",
            Min = 0, Max = 100,
            Default = 24
        })
    
        section:AddSlider(flag .. "Threshold", {
            Text = "Threshold",
            Min = 0, Max = 1,
            Default = 0.3
        })
    end
    
    function builder.setUpColorCorrectionEffect(section, flag)
        flag = flag .. "ColorCorrection"
    
        section:AddToggle(flag .. "Enabled", {
            Text = "Enable Color Correction",
            Default = false
        }):AddColorPicker(flag .. "TintColor", {
            Default = Color3.fromRGB(255, 255, 255),
            Transparency = 0
        })
    
        section:AddSlider(flag .. "Brightness", {
            Text = "Brightness",
            Min = -1, Max = 1,
            Default = 0
        })
    
        section:AddSlider(flag .. "Contrast", {
            Text = "Contrast",
            Min = -1, Max = 1,
            Default = 0
        })
    
        section:AddSlider(flag .. "Saturation", {
            Text = "Saturation",
            Min = -1, Max = 1,
            Default = 0
        })
    end

    function builder.setUpCharacter(section, flag)
        flag = flag or "rageCharacter"
    
        section:AddToggle(flag .. "Enabled", {
            Text = "Enabled"
        })
    
        section:AddDropdown(flag .. "YawModifier", {
            Text = "Yaw Modifier",
            Values = {"Camera", "Spin", "Random"},
            Default = "Camera"
        })
    
        section:AddSlider(flag .. "YawDegree", {
            Text = "Yaw Degree",
            Min = -180, Max = 180,
            Default = 0
        })
    
        section:AddDropdown(flag .. "OffsetYawModifier", {
            Text = "Offset Yaw Modifier",
            Values = {"None", "Jitter", "Offset Jitter"},
            Default = "None"
        })
    
        section:AddSlider(flag .. "OffsetYawDegree", {
            Text = "Offset Yaw Degree",
            Min = -180, Max = 180,
            Default = 0
        })
    end
    
    function builder.setUpLag(section, flag)
        flag = flag or "rageLag"
    
        section:AddToggle(flag .. "Enabled", {
            Text = "Enabled"
        })
    
        section:AddDropdown(flag .. "Method", {
            Text = "Method",
            Values = {"Static", "Random"},
            Default = "Static"
        })
    
        section:AddSlider(flag .. "Limit", {
            Text = "Limit",
            Min = 0, Max = 12,
            Default = 8
        })
    
        section:AddToggle(flag .. "FreezePackets", {
            Text = "Freeze Packets"
        }):AddKeyPicker(flag .. "FreezePacketsKey", {
            Modes = {"Toggle", "Hold"},
            Mode = "Toggle"
        })
    end
end 

-- Create the main window
local window = library:CreateWindow({Title = "Obsidian UI Example"})

-- Set up tabs
local tabs = builder.setUpTabs(window)

-- Example: Use the "main" tab for groupboxes and sections
local mainTab = tabs["main"]

-- Add left and right groupboxes
local leftGroupbox = mainTab:AddLeftGroupbox("Left Groupbox")
local rightGroupbox = mainTab:AddRightGroupbox("Right Groupbox")

-- Apply builder functions on sections in the left groupbox
builder.setUpFov(leftGroupbox, "example")
builder.setUpAimAssist(leftGroupbox, "example")
builder.setUpSilentAim(leftGroupbox)
builder.setUpCharacter(leftGroupbox)
builder.setUpLag(leftGroupbox)

-- Apply builder functions on sections in the right groupbox
builder.setUpRagebot(rightGroupbox)
builder.setUpBloomEffect(rightGroupbox, "example")
builder.setUpColorCorrectionEffect(rightGroupbox, "example")

-- Save Manager and Theme Manager
saveManager:SetLibrary(library)
saveManager:BuildConfigSection(mainTab)
themeManager:SetLibrary(library)
themeManager:ApplyToTab(tabs["settings"])