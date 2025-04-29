local library, builder, saveManager, themeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Streekaiz/Mont3r/main/dependencies/library/builder.lua")(); do 
    saveManager:SetLibrary(library)
    themeManager:SetLibrary(library)
end 

local render = loadstring(game:HttpGet("https://raw.githubusercontent.com/Streekaiz/Mont3r/main/dependencies/render.lua"))()

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
                Visible = false
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
            do -- // Aim
                sections.legit.aim:AddToggle("legitAimEnabled", {
                    Text = "Enabled"
                }):AddKeyPicker("legitAimKey", {
                    Text = "Aim Assist",
                    Mode = "Hold",
                    Modes = {"Toggle", "Hold"}
                })
        
                sections.legit.aim:AddDropdown("legitAimTarget", {
                    Text = "Target Area", 
                    Values = {"Head", "Torso", "Arms", "Legs"},
                    Default = {"Head", "Torso"},
                    Multi = true
                })
        
                sections.legit.aim:AddDropdown("legitAimMethod", {
                    Text = "Mouse Method",
                    Values = {"Camera", "Windows API"},
                    Default = 2
                })
        
                sections.legit.aim:AddToggle("legitAimSmoothing", {
                    Text = "Use Smoothing"
                }):OnChanged(function(Value)
                    library.Options["legitAimSmoothingX"]:SetVisible(Value)
                    library.Options["legitAimSmoothingY"]:SetVisible(Value)
                end)
        
                for i, v in ipairs({"X", "Y"}) do 
                    sections.legit.aim:AddSlider("legitAimSmoothing" .. v, {
                        Text = v .. " Smoothing",
                        Default = 50,
                        Suffix = "%", 
                    })
                end 
        
                sections.legit.aim:AddToggle("legitAimPrediction", {
                    Text = "Predict Projectile Velocity"
                }):OnChanged(function(Value)
                    library.Options["legitAimPredictionType"]:SetVisible(Value)
                    library.Options["legitAimPredictionCustom"]:SetVisible(Value)
                end)
                
                sections.legit.aim:AddDropdown("legitAimPredictionType", {
                    Text = "Prediction Type",
                    Values = {"Static", "Dynamic", "Custom"},
                    Multi = true,
                    Visible = false
                })
        
                sections.legit.aim:AddInput("legitAimPredictionCustom", {
                    Text = "Custom Prediction",
                    Numeric = true,
                    Default = "0.165",
                    Finished = true,
                    Placeholder = "prediction value",
                    AllowEmpty = false,
                    MaxLength = 5,
                    Visible = false
                })

                sections.legit.aim:AddToggle("legitAimFovUse", {
                    Text = "Use FOV",
                    Default = true
                })
        
                sections.legit.aim:AddToggle("legitAimFovShow", {
                    Text = "Show FOV Circle"
                }):AddColorPicker("legitAimFovColor", {
                    Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)),
                    Transparency = 0
                })
        
                sections.legit.aim:AddSlider("legitAimFovRadius", {
                    Text = "Circle Radius",
                    Min = 30, Max = 360,
                    Default = 360 / 2,
                    Suffix = " pixels"
                })
        
                sections.legit.aim:AddDropdown("legitAimFovPosition", {
                    Text = "Circle Position",
                    Values = {"Mouse", "Centered"},
                    Default = "Mouse"
                })
        
                library.Toggles["legitAimFovShow"]:OnChanged(function(value)
                    library.Options["legitAimFovPosition"]:SetVisible(value)
                end)
            end 
        
            do -- // Silent 
                sections.legit.silent:AddToggle("legitSilentEnabled", {Text = "Enabled"}):AddKeyPicker("legitSilentKey", {SyncToggleState = true, Mode = "Always", Text = "Silent Aim"})
        
                sections.legit.silent:AddDropdown("legitSilentTarget", {
                    Text = "Target Area", 
                    Values = {"Head", "Torso", "Arms", "Legs"},
                    Default = {"Head", "Torso"},
                    Multi = true
                })
        
                sections.legit.silent:AddDropdown("legitSilentMethod", {
                    Text = "Method",
                    Values = {"Raycast"},
                    Default = 1
                })
        
                sections.legit.silent:AddSlider("legitSilentChance", {
                    Text = "Hit Chance",
                    Rounding = 2,
                    Suffix = "%"
                })
        
                sections.legit.silent:AddToggle("legitSilentPrediction", {
                    Text = "Predict Projectile Velocity"
                }):OnChanged(function(Value)
                    library.Options["legitSilentPredictionType"]:SetVisible(Value)
                    library.Options["legitSilentPredictionCustom"]:SetVisible(Value)
                end)
                
                sections.legit.silent:AddDropdown("legitSilentPredictionType", {
                    Text = "Prediction Type",
                    Values = {"Static", "Dynamic", "Custom"},
                    Multi = true,
                    Visible = false
                })
        
                sections.legit.silent:AddInput("legitSilentPredictionCustom", {
                    Text = "Custom Prediction",
                    Numeric = true,
                    Default = "0.165",
                    Finished = true,
                    Placeholder = "prediction value",
                    AllowEmpty = false,
                    MaxLength = 5,
                    Visible = false
                })

                sections.legit.silent:AddToggle("legitSilentFovUse", {
                    Text = "Use FOV",
                    Default = true
                })
        
                sections.legit.silent:AddToggle("legitSilentFovShow", {
                    Text = "Show FOV Circle"
                }):AddColorPicker("legitSilentFovColor", {
                    Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)),
                    Transparency = 0
                })
        
                sections.legit.silent:AddSlider("legitSilentFovRadius", {
                    Text = "Circle Radius",
                    Min = 30, Max = 360,
                    Default = 360 / 2,
                    Suffix = " pixels"
                })
        
                sections.legit.silent:AddDropdown("legitSilentFovPosition", {
                    Text = "Circle Position",
                    Values = {"Mouse", "Centered"},
                    Default = "Mouse"
                })
        
                library.Toggles["legitSilentFovShow"]:OnChanged(function(value)
                    library.Options["legitSilentFovPosition"]:SetVisible(value)
                end)
            end 
        end

        do -- // Rage
            do -- // Bot 
                
                sections.rage.bot:AddToggle("rageBotEnabled", {
                    Text = "Enabled",
                    Risky = true
                })
        
                sections.rage.bot:AddDropdown("rageBotTarget", {
                    Text = "Target Priority",
                    Values = {"Head", "Torso", "Arms", "Legs"},
                    Default = {"Head"}
                })
        
                sections.rage.bot:AddDropdown("rageBotScan", {
                    Text = "Scanning",
                    Values = {"None", "Standard", "Advanced"},
                    Default = 2,
                    Tooltip = "Problems may arise if set to 'none'"
                })
        
                sections.rage.bot:AddToggle("rageBotForce", {
                    Text = "Force Hit",
                    Risky = true
                })
        
                sections.rage.bot:AddToggle("rageBotPrediction", {
                    Text = "Predict Projectile Velocity"
                }):OnChanged(function(Value)
                    library.Options["rageBotPredictionType"]:SetVisible(Value)
                    library.Options["rageBotPredictionCustom"]:SetVisible(Value)
                end)
                
                sections.rage.bot:AddDropdown("rageBotPredictionType", {
                    Text = "Prediction Type",
                    Values = {"Static", "Dynamic", "Custom"},
                    Multi = true,
                    Visible = false
                })
        
                sections.rage.bot:AddInput("rageBotPredictionCustom", {
                    Text = "Custom Prediction",
                    Numeric = true,
                    Default = "0.165",
                    Finished = true,
                    Placeholder = "prediction value",
                    AllowEmpty = false,
                    MaxLength = 5,
                    Visible = false
                })
        
                sections.rage.bot:AddToggle("rageBotNotification", {
                    Text = "Hit Notification",
                    Default = true 
                })
        
                sections.rage.bot:AddDropdown("rageBotIgnorePlayer", {
                    Text = "Ignore Players",
                    SpecialType = "Player",
                    Searchable = true,
                    ExcludeLocalPlayer = true,
                    Multi = true
                })
        
                sections.rage.bot:AddDropdown("rageBotIgnoreTeam", {
                    Text = "Ignore Teams",
                    SpecialType = "Team",
                    Multi = true
                })
            end

            do -- // Character 
                sections.rage.char:AddToggle("rageCharEnabled", {
                    Text = "Enabled"
                })
            
                sections.rage.char:AddDropdown("rageCharYawModifier", {
                    Text = "Yaw Modifier",
                    Values = {"Camera", "Spin", "Random"},
                    Default = "Camera"
                })
            
                sections.rage.char:AddSlider("rageCharYawDegree", {
                    Text = "Yaw Degree",
                    Min = -180, Max = 180,
                    Default = 0
                })
            
                sections.rage.char:AddDropdown("rageCharOffsetYawModifier", {
                    Text = "Offset Yaw Modifier",
                    Values = {"None", "Jitter", "Offset Jitter"},
                    Default = "None"
                })
            
                sections.rage.char:AddSlider("rageCharOffsetYawDegree", {
                    Text = "Offset Yaw Degree",
                    Min = -180, Max = 180,
                    Default = 0
                })
            end 

            do -- // Lag 
                sections.rage.lag:AddToggle("rageLagEnabled", {
                    Text = "Enabled"
                })
            
                sections.rage.lag:AddDropdown("rageLagMethod", {
                    Text = "Method",
                    Values = {"Static", "Random"},
                    Default = "Static"
                })
            
                sections.rage.lag:AddSlider("rageLagLimit", {
                    Text = "Limit",
                    Min = 0, Max = 12,
                    Default = 8
                })
            
                sections.rage.lag:AddToggle("rageLagFreezePackets", {
                    Text = "Freeze Packets"
                }):AddKeyPicker("rageLagFreezePacketsKey", {
                    Modes = {"Toggle", "Hold"},
                    Mode = "Toggle"
                })
            end 
        end 

        do -- // Visuals
            do -- // Bloom
                sections.visual.bloomAddToggle("visualBloomEnabled", {
                    Text = "Enable Bloom Effect",
                    Default = false
                })
            
                sections.visual.bloomAddSlider("visualBloomIntensity", {
                    Text = "Intensity",
                    Min = 0, Max = 10,
                    Default = 1
                })
            
                sections.visual.bloomAddSlider("visualBloomSize", {
                    Text = "Size",
                    Min = 0, Max = 100,
                    Default = 24
                })
            
                sections.visual.bloomAddSlider("visualBloomThreshold", {
                    Text = "Threshold",
                    Min = 0, Max = 1,
                    Default = 0.3
                })
            end 

            do -- // Color 
                sections.visual.color:AddToggle("visualColorEnabled", {
                    Text = "Enabled",
                    Default = false
                }):AddColorPicker("visualColorTintColor", {
                    Color = Color3.fromRGB(255, 255, 255),
                    Transparency = 0
                })
            
                sections.visual.color:AddSlider("visualColorBrightness", {
                    Text = "Brightness",
                    Min = -1, Max = 1,
                    Default = 0
                })
            
                sections.visual.color:AddSlider("visualColorContrast", {
                    Text = "Contrast",
                    Min = -1, Max = 1,
                    Default = 0
                })
            
                sections.visual.color:AddSlider("visualColorSaturation", {
                    Text = "Saturation",
                    Min = -1, Max = 1,
                    Default = 0
                })
            end 

            do -- // Camera
                sections.visual.cameraAddToggle("visualCameraFov", {
                    Text = "Edit FOV"
                }):AddKeyPicker("visualCameraFovKey", {
                    Text = "Field Of View",
                    Mode = "Always",
                    SyncToggleState = true 
                })
        
                sections.visual.cameraAddSlider("visualCameraFovSlider", {
                    Max = 120,
                    Text = "Field Of View",
                    Default = 70,
                    Decimals = 1,
                    Visible = false 
                })
        
                sections.visual.cameraAddToggle("visualCameraZoomEnabled", {
                    Text = "Edit Zoom Distance"
                })
        
                sections.visual.cameraAddSlider("visualCameraZoomMin", {
                    Max = 5000,
                    Text = "Minimum Zoom Distance",
                    Visible = false
                })
        
                sections.visual.cameraAddSlider("visualCameraZoomMax", {
                    Max = 5000,
                    Text = "Maximum Zoom Distance",
                    Visible = false
                })
        
                sections.visual.cameraAddToggle("visualCameraThirdPerson", {
                    Text = "Third Person"
                })
        
                sections.visual.cameraAddDropdown("visualCameraThirdPersonMethod", {
                    Text = "Method",
                    Values = {"Camera", "Hook"},
                    Default = 2,
                    Visible = false 
                })
        
                sections.visual.cameraAddSlider("visualCameraThirdPersonDistance", {
                    Text = "Distance",
                    Min = 0, Max = 18, Default = 12, Decimals = 2
                })
                
                library.Toggles["visualCameraFov"]:OnChanged(function(Value)
                    library.Options["visualCameraFovSlider"]:SetVisible(Value)
                end)
        
                library.Toggles["visualCameraThirdPerson"]:OnChanged(function(Value)
                    library.Options["visualCameraThirdPersonMethod"]:SetVisible(Value)
                    library.Options["visualCameraThirdPersonDistance"]:SetVisible(Value)
                end)
        
                library.Toggles["visualCameraZoomEnabled"]:OnChanged(function(Value)
                    library.Options["visualCameraZoomMin"]:SetVisible(Value)
                    library.Options["visualCameraZoomMax"]:SetVisible(Value)
                end)
            end 

            do -- // World 

            end 

            builder.setUpColorCorrectionEffect(sections.visual.color, "visual")
            builder.setUpCamera(sections.visual.camera, "visual")
            builder.setUpWorld(sections.visual.world, "visual")
        end 

        do --- // Render
            builder.setUpRender(tabs.render, render)
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