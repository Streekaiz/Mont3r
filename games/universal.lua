local library, saveManager, themeManager; do 
    local repository = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
    local function fetch(file)
        return loadstring(game:HttpGet(repository .. file))()
    end 

    library = fetch("Library.lua")
    saveManager = fetch("addons/SaveManager.lua")
    themeManager  = fetch("addons/ThemeManager.lua")

    saveManager:SetLibrary(library)
    themeManager:SetLibrary(library)
end; do 
    local window = library:CreateWindow({
        CornerRadius = 2
    }); do 
        local tabs = {}; do 
            for i, v in ipairs({
                {"home", "Home", "house"},
                {"legit", "Legit", "locate"},
                {"rage", "Rage", "locate-fixed"},
                {"visual", "Visual", "sun-medium"},
                {"render", "Render", "eye"},
                {"misc", "Miscallaenous", "settings-2"},
                {"settings", "Settings", "settings"}
            }) do 
                tabs[v[1]] = window:AddTab(v[2], v[3])
            end 
        end 

        local groupBoxes = {}; do 
            local tabBoxes = {
                esp = tabs.render:AddLeftTabbox(),
                vis = tabs.visual:AddRightTabbox()
            }

            groupBoxes = {
                legit = {
                    aim = tabs.legit:AddLeftGroupbox("Aim Assist"),
                    silent = tabs.legit:AddRightGroupbox("Bullet Manipulation"),
                    settings = tabs.legit:AddRightGroupbox("Settings")
                },
                rage = {
                    bot  = tabs.rage:AddLeftGroupbox("Rage Bot"),
                    antiaim = tabs.rage:AddRightGroupbox("Anti Aim")
                },
                visual = {
                    bloom = tabBoxes.vis:AddTab("Bloom"),
                    color = tabBoxes.vis:AddTab("Color"),
                    camera = tabs.visual:AddLeftGroupbox("Camera"),
                    world = tabs.visual:AddLeftGroupbox("World")
                },
                render = {
                    enemy = tabBoxes.esp:AddTab("Enemy"),
                    friendly = tabBoxes.esp:AddTab("Friendly"),
                    settings = tabs.render:AddRightGroupbox("Settings")
                },
                misc = {
                    localPlayer = tabs.misc:AddLeftGroupbox("Local Player"),
                    players = tabs.misc:AddLeftGroupbox("Players"),
                    servers = tabs.misc:AddRightGroupbox("Servers")
                },
                settings = {
                    main = tabs.settings:AddRightGroupbox("Settings")
                }
            }
        end 

        do -- // Aim Assist 
            local flag = "legitAim"
            local section = groupBoxes.legit.aim 
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
            })
            for i, v in ipairs({"X", "Y"}) do 
                section:AddSlider(flag .. "Smoothing" .. v, {
                    Text = v .. " Smoothing",
                    Default = 50,
                    Suffix = "%", 
                })
            end 

            section:AddToggle(flag .. "Prediction", {
                Text = "Predict Projectile Velocity"
            })
            
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
                MaxLength = 5,
                
            })
        end 

        do -- // Silent Aim 
            local flag = "legitSilent"
            local section = groupBoxes.legit.silent
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
            })
            
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
                MaxLength = 5,
                
            })
        end 

        do -- // Legit Settings
            local section = groupBoxes.legit.settings 
            local flag = "legit"

            section:AddDropdown(flag .. "ExcludePlayer", {
                Text = "Exclude Players",
                SpecialType = "Player",
                ExcludeLocalPlayer = true 
            })

            section:AddDropdown(flag .. 'ExcludeTeam', {
                Text = 'Exclude Team',
                SpecialType = "Team"
            })

            section:AddToggle(flag .. 'ExcludeDistance', {
                Text = 'Limit by Distance'
            })

            section:AddSlider(flag .. 'ExcludeDistanceMin', {
                Text = "Minimum Distance",
                Max = 5000, Default = 0, HideMax = true, Suffix = " studs"
            })

            section:AddSlider(flag .. 'ExcludeDistanceMax', {
                Text = "Maximum Distance",
                Max = 5000, Default = 2500, HideMax = true, Suffix = " studs"
            })

            section:AddToggle(flag .. 'ExcludeHealth', {
                Text = 'Limit by Health'
            })

            section:AddSlider(flag .. 'ExcludeHealthMin', {
                Text = "Minimum Health",
                Max = 5000, Default = 0, HideMax = true, Suffix = " studs"
            })

            section:AddSlider(flag .. 'ExcludeHealthMax', {
                Text = "Maximum Health",
                Max = 5000, Default = 2500, HideMax = true, Suffix = " studs"
            })
        end

        --[[do -- // Rage Bot
            local section = groupBoxes.rage.bot 
            local flag = 'rageBot'

            section:AddToggle(flag .. 'Enabled', {
                Text = 'Enabled',
                Risky = true 
            })

            section:AddDropdown(flag .. "Hook", {
                Text = "Hooking Method",
                Risky = true,
                Values = {"Raycast", "Mouse", "Remote"},
                Tooltip = "Might cause some issues ingame"
            })

            section:AddDropdown(flag .. "Target", {
                Text = 'Target Priority',
                Values = {"Head", "Torso", "Arms", "Legs"},
                Multi = true,
                Default = {"Head", "Torso"}
            })

            section:AddDropdown(flag .. "Origin", {
                Text = "Projectile Origin",
                Values = {"Character", "Camera"},
                Default = 1
            })

            section:AddDropdown(flag .. "Checks", {
                Text = "Validation Checks",
                Values = {"Status", "Team", "Visible", "Health", "Distance", "ForceField"},
                Default = {"Status", "Team", "Visible", "ForceField"},
                Multi = true 
            })

            section:AddDropdown(flag .. "Scan", {
                Text = "Scanning Type",
                Values = {"Performance", "Standard", "Advanced"},
                Default = 2
            })

            section:AddToggle(flag .. 'Path', {
                Text = 'Redirect Movement',
                Risky = true
            })

            section:AddToggle(flag .. "PathIgnoreT", {
                Text = "Ignore Transparent Objects"
            })

            section:AddToggle(flag .. "PathIgnoreC", {
                Text = "Ignore CanCollide Objects"
            })

            section:AddDropdown(flag .. "PathPerformance", {
                Text = "Connection Type",
                Values = {"Loop", "Heartbeat", "RenderStepped", "Stepped"},
                Default = 2 
            })
        end]]

        do 
            local section1, section2, section3, section4 = groupBoxes.visual.bloom, groupBoxes.visual.color, groupBoxes.visual.camera, groupBoxes.visual.world 
            local flag = "visual"

            do -- // Bloom
                section1:AddToggle(flag .. "BloomEnabled", {
                    Text = "Enabled"
                })

                for i, v in ipairs({
                    "Intensity", "Threshold", "Size"
                }) do 
                    section1:AddSlider(flag .. "Bloom" .. v, {
                        Text = v,
                        Min = -10, Max = 10, Default = 0, HideMax = true
                    })
                end 
            end

            do -- // Color
                section2:AddToggle(flag .. "ColorEnabled", {
                    Text = "Enabled"
                }):AddColorPicker(flag .. "TintColor", {
                    Color = Color3.fromRGB(255, 255, 255),
                    Transparency = 0
                })

                for i, v in ipairs({
                    "Brightness", "Contrast", "Saturation"
                }) do 
                    section2:AddSlider(flag .. "Color" .. v, {
                        Text = v,
                        Min = -10, Max = 10, Default = 0, HideMax = true
                    })
                end 
            end

            do -- // Camera
                section3:AddToggle(flag .. "FovEnabled", {
                    Text = "Edit FOV"
                }):AddKeyPicker(flag .. "FovKey", {
                    Text = "Field Of View",
                    SyncToggleState = true 
                })

                section3:AddSlider(flag .. "Fov", {
                    Text = "Field Of View",
                    Min = 0, Max = 120, Decimals = 1, Default = 70, Suffix = "%", HideMax = true 
                })

                section3:AddToggle(flag .. "ZoomEnabled", {
                    Text = "Edit Zoom Distance"
                })

                for i, v in ipairs({
                    {"Min", "Minimum"},
                    {"Max", "Maximum"}
                }) do 
                    section3:AddSlider(flag .. "Zoom" .. v[1], {
                        Text = v[2] .. " Zoom Distance",
                        Min = 0,
                        Max = 5000,
                        Default = i == 1 and 0 or 2500,
                        HideMax = true 
                    })
                end 

                section3:AddToggle(flag .. "ThirdPersonEnabled", {
                    Text = "Third Person"
                })

                section3:AddSlider(flag .. "ThirdPersonDistance", {
                    Text = "Third Person Distance",
                    Min = 0,
                    Max = 18,
                    Default = 13,
                    HideMax = true 
                })

            end 

            do -- // World
                section4:AddToggle(flag .. "Ambient", {
                    Text = "Ambience"
                }):AddColorPicker(flag .. "AmbientC1", {
                    Color = Color3.fromRGB(100, 100, 255)
                }):AddColorPicker(flag .. "AmbientC2", {
                    Color = Color3.fromRGB(255, 100, 100)
                })

                section4:AddToggle(flag .. "Shadow", {
                    Text = "Global Shadows",
                    Default = game:GetService("Lighting").GlobalShadows
                })

                section4:AddDropdown(flag .. "Technology", {
                    Text = "Lighting Technology",
                    Values = {"Compatability", "Voxel", "ShadowMap", "Future"},
                    Default = string.gsub(tostring(game:GetService("Lighting").Technology), "Enum.Technology.", ""),
                    Disabled = (sethiddenproperty == nil),
                    DisabledTooltip = "Your executor doesn't support sethiddenproperty!",
                    Tooltip = "May decrease/increase performance depending on the chosen value"
                })        
            end 
        end 

        do -- // LocalPlayer
            local section = groupBoxes.misc.localPlayer 
            local flag = "miscLocalPlayer"

            section:AddDropdown(flag .. "Edits", {
                Text = "Player Modifications",
                Values = {"Speed", "Jump", "Flight", "Hip Height"},
                Multi = true
            })

            section:AddDropdown(flag .. "SpeedMethod", {
                Text = "Speed Method",
                Values = {"CFrame", "Humanoid"},
                Default = 1
            })

            section:AddSlider(flag .. "Speed", {
                Text = "Speed",
                Min = 0, Max = 100, Default = 18, HideMax = true, Suffix = "%"
            })

            section:AddSlider(flag .. "Jump", {
                Text = "Jump Power",
                Min = 0, Max = 100, Default = 50, HideMax = true, Suffix = "%"
            })

            section:AddDropdown(flag .. "FlightMethod", {
                Text = "Flight Method",
                Values = {"CFrame", "Velocity"},
                Default = 2
            })

            section:AddSlider(flag .. "FlightSpeed", {
                Text = "Flight Speed",
                Min = 0, Max = 100, Default = 25, HideMax = true, Suffix = "%"
            })
        end 

        do -- // Players
            local section = groupBoxes.misc.players 
            local flag = "miscPlayers"

            section:AddDropdown(flag .. "Selected", {
                Text = "Target",
                SpecialType = "Player",
                ExcludeLocalPlayer = true 
            })

            section:AddButton({Text = "Teleport", Risky = true})
            section:AddButton({Text = "Spectate"})
        end 
    end 
end 