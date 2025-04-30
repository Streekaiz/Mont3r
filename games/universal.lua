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
    end 

end 