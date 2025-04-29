print('1')
local function load(url)
    return loadstring(game:HttpGet(url, true))()
end 
print('2')
local repository = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
print('3')
local library = load(repository .. "Library.lua")
local saveManager = load(repository .. "addons/SaveManager.lua")
local themeManager = load(repository .. "addons/ThemeManager.lua")

print("huh")
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
            Text = "Enabled",
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

    function builder.setUpCamera(section, flag)
        flag = flag .. "Camera"

        section:AddToggle(flag .. "Fov", {
            Text = "Edit FOV"
        }):AddKeyPicker(flag .. "FovKey", {
            Text = "Field Of View",
            Mode = "Always",
            SyncToggleState = true 
        })

        section:AddSlider(flag .. "FovSlider", {
            Max = 120,
            Text = "Field Of View",
            Default = 70,
            Decimals = 1,
            Visible = false 
        })

        section:AddToggle(flag .. "ZoomEnabled", {
            Text = "Edit Zoom Distance"
        })

        section:AddSlider(flag .. "ZoomMin", {
            Max = 5000,
            Text = "Minimum Zoom Distance",
            Visible = false
        })

        section:AddSlider(flag .. "ZoomMax", {
            Max = 5000,
            Text = "Maximum Zoom Distance",
            Visible = false
        })

        section:AddToggle(flag .. "ThirdPerson", {
            Text = "Third Person"
        })

        section:AddDropdown(flag .. "ThirdPersonMethod", {
            Text = "Method",
            Values = {"Camera", "Hook"},
            Default = 2,
            Visible = false 
        })

        section:AddSlider(flag .. "ThirdPersonDistance", {
            Text = "Distance",
            Min = 0, Max = 18, Default = 12, Decimals = 2
        })
        
        library.Toggles[flag .. "Fov"]:OnChanged(function(Value)
            library.Options[flag .. "FovSlider"]:SetVisible(Value)
        end)

        library.Toggles[flag .. "ThirdPerson"]:OnChanged(function(Value)
            library.Options[flag .. "ThirdPersonMethod"]:SetVisible(Value)
            library.Options[flag .. "ThirdPersonDistance"]:SetVisible(Value)
        end)

        library.Toggles[flag .. "ZoomEnabled"]:OnChanged(function(Value)
            library.Options[flag .. "ZoomMin"]:SetVisible(Value)
            library.Options[flag .. "ZoomMax"]:SetVisible(Value)
        end)
    end

    function builder.setUpWorld(section, flag)
        flag = flag .. "World"
        section:AddToggle(flag .. "Ambience", {
            Text = "Ambience"
        }):AddColorPicker(flag .. "AmbienceColor1", {
            Text = "Indoor Ambience",
            Color = Color3.fromRGB(100, 100, 255)
        }):AddColorPicker(flag .. "AmbienceColor2", {
            Text = "Outdoor Ambience",
            Color = Color3.fromRGB(0, 0, 100)
        })

        section:AddToggle(flag .. "Shadows", {
            Text = "Global Shadows",
            Default = game:GetService("Lighting").GlobalShadows 
        })

        section:AddToggle(flag .. "Fog", {
            Text = "Disable Fog"
        })

        section:AddDropdown(flag .. "Technology", {
            Text = "Lighting Technology",
            Values = {"Compatability", "Voxel", "ShadowMap", "Future"},
            Default = string.gsub(tostring(game:GetService("Lighting").Technology), "Enum.Technology.", ""),
            Disabled = sethiddenproperty == nil,
            DisabledTooltip = "Your executor doesn't support sethiddenproperty!",
            Tooltip = "May decrease/increase performance depending on the chosen value"
        })

        if sethiddenproperty then 
            library.Options[flag .. "Technology"]:OnChanged(function(Value)
            end)
        end
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

    function builder.setUpPlayer(section, flag)
        flag = flag .. "localPlayer"

        section:AddDropdown(flag .. "Modifications", {
            Text = "Modifications",
            Values = {"Speed", "Jump Power", "Flight"},
            Multi = true
        })

        section:AddDropdown(flag .. "SpeedMethod", {
            Text = "Speed Method",
            Values = {"CFrame", "Humanoid"},
            Visible = false 
        })

        section:AddInput(flag .. "SpeedValue", {
            Text = "Speed Value",
            Numeric = true,
            Placeholder = "0.165",
            Default = "0.165",
            Visible = false
        })

        section:AddInput(flag .. "JumpValue", {
            Text = "Jump Power Value",
            Numeric = true,
            Placeholder = "0.165",
            Default = "0.165",
            Visible = false
        })

        section:AddDropdown(flag .. "FlyMethod", {
            Text = "Flight Method",
            Values = {"CFrame", "Velocity"},
            Visible = false
        })

        section:AddSlider(flag .. "FlySpeed", {
            Text = "Flight Speed",
            Min = 1, Max = 35, Default = 17.5, Decimals = 2, 
            Visible = false 
        })

        library.Options[flag .. "Modifications"]:OnChanged(function()
            library.Options[flag .. "SpeedMethod"]:SetVisible(library.Options[flag .. "Modifications"].Speed)
            library.Options[flag .. "SpeedValue"]:SetVisible(library.Options[flag .. "Modifications"].Speed)
            library.Options[flag .. "JumpValue"]:SetVisible(library.Options[flag .. "Modifications"]["Jump Power"])
            library.Options[flag .. "FlyMethod"]:SetVisible(library.Options[flag .. "Modifications"].Flight)
            library.Options[flag .. "FlySpeed"]:SetVisible(library.Options[flag .. "Modifications"].Flight)
        end)
    end
    
end

saveManager:SetLibrary(library)
themeManager:SetLibrary(library)


local window = library:CreateWindow({
    Title = "Mont3r",
    Footer = "Daybreak 2 - v0.0.1",
    CornerRadius = 0,
    MobileButtonsSide = "Right"
}); do 
    local tabs = builder.setUpTabs(window, {
        {"home", "Home", "house"},
        {"main", "Main", "user-round-cog"},
        {"legit", "Legit", "locate"},
        {"rage", "Rage", "locate-fixed"},
        {"visual", "Visual", "sun-medium"},
        {"render", "Render", "eye"},
        {"misc", "Miscallaenous", "settings-2"},
        {"settings", "Settings", "settings"}
    }); do 

        local sections = {
            home = {
                home = tabs.home:AddLeftGroupbox("Changelogs"),
                discord = tabs.home:AddRightGroupbox("Discord"),
                client = tabs.home:AddRightGroupbox("Client")
            },
            main = {
                auto = tabs.main:AddLeftGroupbox("Automation"),
                killerControl = tabs.main:AddRightGroupbox("Control Killer"),
                autoFarm = tabs.main:AddLeftGroupbox("Auto Farm"),
                exploits = tabs.main:AddRightGroupbox("Exploits")
            },
            legit = {
                aim = tabs.legit:AddLeftGroupbox("Aim Assist"),
                silent = tabs.legit:AddRightGroupbox("Silent Aim"),
                settings = tabs.legit:AddRightGroupbox("Settings"),
                indicator = tabs.legit:AddLeftGroupbox("Indicator")
            },
            rage = {
                bot = tabs.rage:AddLeftGroupbox("Rage Bot"),
                char = tabs.rage:AddRightGroupbox("Character"),
                lag = tabs.rage:AddRightGroupbox("Fake Lag"),
                misc = tabs.rage:AddLeftGroupbox("Exploits")
            },
            visual = {
                camera = tabs.visual:AddLeftGroupbox("Camera"),
                world = tabs.visual:AddRightGroupbox("World"),
                bloom = tabs.visual:AddRightGroupbox("Bloom"),
                color = tabs.visual:AddRightGroupbox("Color"),
                misc = tabs.visual:AddLeftGroupbox("Miscallaenous")
            },
            render = {
                esp = tabs.render:AddLeftTabbox(),
                mainSettings = tabs.render:AddRightGroupbox("Main Settings"),
                textSettings = tabs.render:AddRightGroupbox("Text Settings"),
            },
            misc = {
                localPlayer = tabs.misc:AddLeftGroupbox("Local Player"),
                servers = tabs.misc:AddRightGroupbox("Servers")
            },
            settings = {
                main = tabs.settings:AddRightGroupbox("UI Settings")
            }
        }

        do -- // Main
            sections.main.auto:AddToggle("skillChecksAuto", {
                Text = "Complete Skillchecks",
                Tooltip = "Manages skill checks for you."
            })

            sections.main.auto:AddDropdown("skillChecksMethod", {
                Text = "Completion Method",
                Values = {"ChildAdded", "Hookmetamethod"},
                Visible = false,
                Tooltip = "ChildAdded is reccomended."
            })

            sections.main.auto:AddSlider("skillChecksDelay", {
                Text = "Delay",
                Min = 0, Max = 10, Decimals = 2, Suffix = "s",
                Visible = false, Disabled = true,
                DisabledTooltip = "Only enabled for ChildAdded!"
            })
            

            library.Toggles.skillChecksAuto:OnChanged(function(Value)
                library.Options.skillChecksMethod:SetVisible(Value)
                library.Options.skillChecksDelay:SetVisible(Value)
            end)

            library.Options.skillChecksMethod:OnChanged(function(Value)
                library.Options.skillChecksDelay:SetVisible(Value == "ChildAdded")
            end)

        end 

        do -- // Legit
            builder.setUpAimAssist(sections.legit.aim)
            builder.setUpFov(sections.legit.aim, "legitAim")
            builder.setUpSilentAim(sections.legit.silent)
            builder.setUpFov(sections.legit.silent, "legitSilent")
        end

        do -- // Rage
            builder.setUpRagebot(sections.rage.bot, "rageBot")
            
            builder.setUpLag(sections.rage.lag, "rageLag")
        end 

        do -- // Visuals
            builder.setUpBloomEffect(sections.visual.bloom, "visual")
            builder.setUpColorCorrectionEffect(sections.visual.color, "visual")
            builder.setUpCamera(sections.visual.camera, "visual")
            builder.setUpWorld(sections.visual.world, "visual")
        end 

        do -- // Misc 
            builder.setUpPlayer(sections.misc.localPlayer, "misc")
        end 

        do -- // Settings 
            saveManager:BuildConfigSection(tabs.settings)
            themeManager:ApplyToTab(tabs.settings)
        end 
    end
end 