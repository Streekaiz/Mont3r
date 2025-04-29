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
            Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)),
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
            Color = Color3.fromRGB(255, 255, 255),
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
            Disabled = (sethiddenproperty == nil),
            DisabledTooltip = "Your executor doesn't support sethiddenproperty!",
            Tooltip = "May decrease/increase performance depending on the chosen value"
        })

        if sethiddenproperty then 
            library.Options[flag .. "Technology"]:OnChanged(function(Value)
            end)
        end
    end

    function builder.setUpRender(tab, path)
        local enemy, friendly = path.teamSettings.enemy, path.teamSettings.friendly 
        local tabbox = tab:AddLeftTabbox(); do 
            local enemySection, friendlySection = tabbox:AddTab("Enemy"), tabbox:AddTab("Friendly")

            for i = 1, 2 do 
                local section = i == 1 and enemySection or friendlySection
                local path = i == 1 and enemy or friendly 
                local flag = i == 1 and "espEnemy" or "espFriendly"
                local white, black = Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0)
                local maincolor = i == 1 and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(100, 100, 255)
                section:AddToggle(flag .. "Enabled", { Text = "Enabled" }):AddKeyPicker(flag .. "Key", {NoUI = true, Mode = "Always"})
                section:AddToggle(flag .. "Box", { Text = "Bounded Box" }):AddColorPicker(flag .. "BoxColor", {Color = white, Transparency = 0})
                section:AddToggle(flag .. "BoxOutline", { Text = "Bounded Box Outline", Visible = false }):AddColorPicker(flag .. "BoxOutlineColor", {Color = black, Transparency = 0})
                section:AddToggle(flag .. "BoxFill", { Text = "Fill Bounded Box" }):AddColorPicker(flag .. "BoxFillColor", {Color = white, Transparency = 0.5})
                section:AddToggle(flag .. "BoxDimensional", { Text = "3D Box" }):AddColorPicker(flag .. "BoxDimensionalColor", {Color = white, Transparency = 0})
                section:AddToggle(flag .. "Bar", { Text = "Health Bar" }):AddColorPicker(flag .. "BarHealthy", {Color = Color3.fromRGB(100, 255, 100)}):AddColorPicker(flag .. "BarDying", {Color = Color3.fromRGB(255, 100, 100)})
                section:AddToggle(flag .. "BarOutline", { Text = "Health Bar Outline", Visible = false }):AddColorPicker(flag .. "BarOutlineColor", {Color = black, Transparency = 0})
                section:AddToggle(flag .. "Health", { Text = "Health Text" }):AddColorPicker(flag .. "HealthColor", {Color = Color3.fromRGB(100, 255, 100), Transparency = 0})
                section:AddToggle(flag .. "HealthOutline", { Text = "Health Text Outline", Visible = false }):AddColorPicker(flag .. "HealthOutlineColor", {Color = black})
                section:AddToggle(flag .. "Name", { Text = "Name" }):AddColorPicker(flag .. "NameColor", {Color = white, Transparency = 0})
                section:AddToggle(flag .. "NameOutline", { Text = "Name Outline", Visible = false }):AddColorPicker(flag .. "NameOutlineColor", {Color = black})
                section:AddToggle(flag .. "Distance", { Text = "Distance" }):AddColorPicker(flag .. "DistanceColor", {Color = white, Transparency = 0})
                section:AddToggle(flag .. "DistanceOutline", { Text = "Distance Outline", Visible = false }):AddColorPicker(flag .. "DistanceOutlineColor", {Color = black})
                section:AddToggle(flag .. "Weapon", { Text = "Weapon" }):AddColorPicker(flag .. "WeaponColor", {Color = white, Transparency = 0})
                section:AddToggle(flag .. "WeaponOutline", { Text = "Weapon Outline", Visible = false }):AddColorPicker(flag .. "WeaponOutlineColor", {Color = black})
                section:AddToggle(flag .. "Tracer", { Text = "Tracer" }):AddColorPicker(flag .. "TracerColor", {Color = white, Transparency = 0})
                section:AddToggle(flag .. "TracerOutline", { Text = "Tracer Outline", Visible = false }):AddColorPicker(flag .. "TracerOutlineColor", {Color = black, Transparency = 0})
                section:AddDropdown(flag .. "TracerOrigin", { Text = "Tracer Origin", Visible = false, Values = {"Top", "Bottom", "Middle"}, Default = "Bottom"})
                section:AddToggle(flag .. "Arrow", { Text = "Offscreen Arrow" }):AddColorPicker(flag .. "ArrowColor", {Color = white, Transparency = 0})
                section:AddToggle(flag .. "ArrowOutline", { Text = "Offscreen Arrow Outline", Visible = false }):AddColorPicker(flag .. "ArrowOutlineColor", {Color = black, Transparency = 0})
                section:AddSlider(flag .. "ArrowRadius", { Text = "Offscreen Arrow Radius", Visible = false, Min = 0, Max = 300, Default = 150, Decimals = 1})
                section:AddSlider(flag .. "ArrowSize", { Text = "Offscreen Arrow Size", Visible = false, Min = 0, Max = 30, Default = 15, Decimals = 1})
                section:AddToggle(flag .. "Cham", { Text = "Cham" }):AddColorPicker(flag .. "ChamColor", {Color = maincolor, Transparency = 0.5})
                section:AddToggle(flag .. "ChamOutline", { Text = "Cham Outline", Visible = false }):AddColorPicker(flag .. "ChamOutlineColor", {Color = black, Transparency = 0})
                section:AddToggle(flag .. "ChamVisible", { Text = "Visible Only", Visible = false })
                
                library.Toggles[flag .. "Enabled"]:OnChanged(function(Value) path.enabled = Value end)
                library.Toggles[flag .. "Box"]:OnChanged(function(Value)
                    path.box = Value
                    path.boxColor = {library.Options[flag .. "BoxColor"].Value, library.Options[flag .. "BoxColor"].Transparency}
                    path.boxOutline = library.Toggles[flag .. "BoxOutline"].Value 
                    path.boxOutlineColor = {library.Options[flag .. "BoxOutlineColor"].Value, library.Options[flag .. "BoxOutlineColor"].Transparency}
                    library.Toggles[flag .. "BoxOutline"]:SetVisible(Value) 
                end)

                library.Options[flag .. "BoxColor"]:OnChanged(function(Value)
                    path.boxColor = {library.Options[flag .. "BoxColor"].Value, library.Options[flag .. "BoxColor"].Transparency}
                end)

                library.Toggles[flag .. "BoxOutline"]:OnChanged(function(Value)
                    path.boxOutline = Value
                    path.boxOutlineColor = {library.Options[flag .. "BoxOutlineColor"].Value, library.Options[flag .. "BoxOutlineColor"].Transparency} 
                end)

                library.Options[flag .. "BoxOutlineColor"]:OnChanged(function(Value)
                    path.boxOutlineColor = {library.Options[flag .. "BoxOutlineColor"].Value, library.Options[flag .. "BoxOutlineColor"].Transparency}
                end)

                library.Toggles[flag .. "BoxFill"]:OnChanged(function(Value)
                    path.boxFill = Value
                    path.boxFillColor = {library.Options[flag .. "BoxFillColor"].Value, library.Options[flag .. "BoxFillColor"].Transparency}
                end)
    
                library.Options[flag .. "BoxFillColor"]:OnChanged(function(Value)
                    path.boxFillColor = {library.Options[flag .. "BoxFillColor"].Value, library.Options[flag .. "BoxFillColor"].Transparency}
                end)

                library.Toggles[flag .. "Bar"]:OnChanged(function(Value)
                    path.healthBar = Value
                    path.healthyColor = library.Options[flag .. "BarHealthy"].Value
                    path.dyingColor = library.Options[flag .. "BarDying"].Value
                end)
    
                library.Options[flag .. "BarHealthy"]:OnChanged(function(Value)
                    path.healthyColor = Value
                end)
    
                library.Options[flag .. "BarDying"]:OnChanged(function(Value)
                    path.dyingColor = Value
                end)
                --[[
                    enabled = false,
                    box = false,
                    boxColor = { Color3.new(1,0,0), 1 },
                    boxOutline = true,
                    boxOutlineColor = { Color3.new(), 1 },
                    boxFill = false,
                    boxFillColor = { Color3.new(1,0,0), 0.5 },
                    healthBar = false,
                    healthyColor = Color3.new(0,1,0),
                    dyingColor = Color3.new(1,0,0),
                    healthBarOutline = true,
                    healthBarOutlineColor = { Color3.new(), 0.5 },
                    healthText = false,
                    healthTextColor = { Color3.new(1,1,1), 1 },
                    healthTextOutline = true,
                    healthTextOutlineColor = Color3.new(),
                    box3d = false,
                    box3dColor = { Color3.new(1,0,0), 1 },
                    name = false,
                    nameColor = { Color3.new(1,1,1), 1 },
                    nameOutline = true,
                    nameOutlineColor = Color3.new(),
                    weapon = false,
                    weaponColor = { Color3.new(1,1,1), 1 },
                    weaponOutline = true,
                    weaponOutlineColor = Color3.new(),
                    distance = false,
                    distanceColor = { Color3.new(1,1,1), 1 },
                    distanceOutline = true,
                    distanceOutlineColor = Color3.new(),
                    tracer = false,
                    tracerOrigin = "Bottom",
                    tracerColor = { Color3.new(1,0,0), 1 },
                    tracerOutline = true,
                    tracerOutlineColor = { Color3.new(), 1 },
                    offScreenArrow = false,
                    offScreenArrowColor = { Color3.new(1,1,1), 1 },
                    offScreenArrowSize = 15,
                    offScreenArrowRadius = 150,
                    offScreenArrowOutline = true,
                    offScreenArrowOutlineColor = { Color3.new(), 1 },
                    chams = false,
                    chamsVisibleOnly = false,
                    chamsFillColor = { Color3.new(0.2, 0.2, 0.2), 0.5 },
                    chamsOutlineColor = { Color3.new(1,0,0), 0 },
                ]]
            end 
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
return library, builder, saveManager, themeManager 