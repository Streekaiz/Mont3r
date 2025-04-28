local builder = {}; do 
    function builder.tabsInit(window, tabs)
        local cache = {}

        for _, v in ipairs(tabs) do 
            cache[v] = window:Tab(v)
        end 

        return cache 
    end 

    function builder.prediction(section, baseFlag)
        local dropdown = section:Dropdown({name = "Prediction", content = {"Static", "Dynamic", "Custom"}, flag = baseFlag .. "Prediction"}) 
        local sliderX = section:Slider({name = "X Prediction Factor", min = 0, max = 5, float = 0.05, flag = baseFlag .. "PredictionX"})
        local sliderY = section:Slider({name = "Y Prediction Factor", min = 0, max = 5, float = 0.05, flag = baseFlag .. "PredictionY"})

        return dropdown, sliderX, sliderY 
    end 

    function builder.fov(section, baseFlag)
        local toggle = section:Toggle({name = "Use FOV", flag = baseFlag .. "FovUse"})
        local toggle1 = section:Toggle({name = "Show FOV Circle", flag = baseFlag .. "FovShow"})
        toggle1:Colorpicker({default = Color3.fromRGB(255, 100, 100), alpha = 1, flag = baseFlag .. "FovColor"})
        toggle1:Slider({name = "Radius", min = 0, max = 360, default = 180, suffix = " px", float = 1, flag = baseFlag .. "FovRadius"})
        local slider1 = section:Slider({name = "FOV Sides", min = 3, max = 128, default = 64, float = 1, flag = baseFlag .. "FovSides"})
        local dropdown = section:Dropdown({name = "Position", content = {"Mouse", "Centered", "Custom"}, flag = baseFlag .. "FovPosition"})
        for i, v in ipairs({"X", "Y"}) do 
            section:Slider({name = v .. " Offset", min = -100, max = 100, default = 0, float = 1, flag = baseFlag .. "FovPosition" .. v})    
        end 

        return toggle, toggle1, slider, slider1, dropdown 
    end 

    function builder.aimAssist(section)
        local baseFlag = "legitAim"
        section:Toggle({name = "Enabled", flag = baseFlag .. "Enabled"}):Keybind({flag = baseFlag .. "Key", mode = "toggle"})
        section:Toggle({name = "Require Mouse Movement", flag = baseFlag .. "Movement"})
        section:Dropdown({name = "Target Priority", content = {"Head", "Torso", "Arms", "Legs"}, default = {"Head", "Torso"}, multi = true, flag = baseFlag .. "Target"})
        section:Toggle({name = "Use Smoothing", flag = baseFlag .. "Smoothing"}):Dropdown({name = "Curving Type", content = {"Linear"}, flag = baseFlag .. "Curving"})
        section:Slider({name = "X Smoothing Factor", float = 0.25, default = 100, max = 100, suffix = "%", flag = baseFlag .. "SmoothingX"})
        section:Slider({name = "Y Smoothing Factor", float = 0.25, default = 100, max = 100, suffix = "%", flag = baseFlag .. "SmoothingY"})
        section:Dropdown({name = "Scanning Type", content = {"Standard", "Advanced"}, flag = baseFlag .. "Scan"})
        builder.prediction(section, baseFlag)
    end 

    function builder.silentAim(section)
        local baseFlag = "legitSilent"
        local toggle1 = section:Toggle({name = "Enabled", flag = baseFlag .. "Enabled"})
        toggle1:Keybind({flag = baseFlag .. "Key", mode = "toggle"})
        toggle1:Dropdown({name = "Method", content = {"Raycast", "Mouse"}, multi = true, default = "Raycast", flag = baseFlag .. "Method"})
        section:Toggle({name = "Require Mouse Movement", flag = baseFlag .. "Movement"})        
        section:Dropdown({name = "Target Priority", content = {"Head", "Torso", "Arms", "Legs"}, default = {"Head", "Torso"}, multi = true, flag = baseFlag .. "Target"})
        builder.prediction(section, baseFlag)
    end 

    function builder.localPlayer(section)
        local baseFlag = "misc"
        section:Toggle({name = "Speed Changer", flag = baseFlag .. "LocalSpeedEnabled"}):Dropdown({name = "Method", content = {"Normal", "CFrame"}, flag = baseFlag .. "LocalSpeedMethod"})
        section:Slider({name = "Speed Value", max = 200, flag = baseFlag .. "LocalSpeedValue"})
        section:Toggle({name = "Jump Power Changer", flag = baseFlag .. "LocalJumpEnabled"}):Slider({name = "Value", max = 150, flag = baseFlag .. "LocalJumpValue"})
        section:Toggle({name = "Fly", flag = baseFlag .. "LocalFlyEnabled"}):Dropdown({name = "Method", content = {"Velocity", "Platform", "CFrame"}, flag = baseFlag .. "LocalFlyMethod"}):Slider({name = "Speed", min = 1, max = 100, flag = baseFlag .. "LocalFlySpeed"})
    end
    
    function builder.bloom(section)
        local baseFlag = "visual"
        local bloom = Instance.new("BloomEffect", cloneref(game:GetService("Lighting")))
        section:Toggle({name = "Enabled", flag = baseFlag .. "BloomEnabled", callback = function(value)
            bloom.Enabled = value
        end})
        section:Slider({name = "Intensity", max = 100, flag = baseFlag .. "BloomIntensity", callback = function(value)
            bloom.Intensity = value / 10
        end})
        section:Slider({name = "Threshold", max = 1, intervals = 3, flag = baseFlag .. "BloomThreshold", callback = function(value)
            bloom.Threshold = value
        end})
        section:Slider({name = "Size", max = 100, flag = baseFlag .. "BloomSize", callback = function(value)
            bloom.Size = value
        end})
    end
    
    function builder.color(section)
        local baseFlag = "visual"
        local color = Instance.new("ColorCorrectionEffect", cloneref(game:GetService("Lighting")))
        section:Toggle({name = "Enabled", flag = baseFlag .. "ColorEnabled", callback = function(value)
            color.Enabled = value
        end})
        section:Colorpicker({flag = baseFlag .. "ColorValue", color = Color3.fromRGB(100,100,255), callback = function(value)
            color.TintColor = value
        end})
        section:Slider({name = "Brightness", flag = baseFlag .. "ColorBrightness", min = -2.5, max = 2.5, default = 0, intervals = 3, callback = function(value)
            color.Brightness = value
        end})
        section:Slider({name = "Contrast", flag = baseFlag .. "ColorContrast", min = -2.5, max = 2.5, default = 0, intervals = 3, callback = function(value)
            color.Contrast = value == 0 and 0 or value * 1.25
        end})
        section:Slider({name = "Saturation", flag = baseFlag .. "ColorSaturation", min = -2.5, max = 2.5, default = 0, intervals = 3, callback = function(value)
            color.Saturation = value
        end})
    end
    
    function builder.camera(section)
        local baseFlag = "visual"
        section:Toggle({name = "Field of View Changer", flag = baseFlag .. "FovEnabled"}):Slider({name = "Value", min = 0, max = 120, default = 70, flag = baseFlag .. "FovValue"})
        section:Toggle({name = "Zoom", flag = baseFlag .. "ZoomEnabled"}):Slider({name = "Value", min = 0, max = 120, default = 30, flag = baseFlag .. "ZoomValue"})
        section:Toggle({name = "Third Person", flag = baseFlag .. "3rdPersonEnabled"}):Dropdown({name = "Method", content = {"Camera", "Hook"}, default = "Hook", flag = baseFlag .. "3rdPersonMethod"})
        section:Slider({name = "Third Person Distance", min = 0, max = 12, default = 3, intervals = 3, flag = baseFlag .. "3rdPersonDistance"})
        section:Slider({name = "Minimum Zoom Distance", min = 0, max = 2500, default = workspace.CurrentCamera.MinimumZoomDistance, flag = baseFlag .. "ZoomDistanceMin"})
        section:Slider({name = "Maximum Zoom Distance", min = 0, max = 2500, default = workspace.CurrentCamera.MaximumZoomDistance, flag = baseFlag .. "ZoomDistanceMax"})
    end
    
    function builder.ragebot(section)
        local baseFlag = "rage"
        section:Toggle({name = "Enabled", flag = baseFlag .. "BotEnabled"})
        section:Toggle({name = "Ignore Obstacles", flag = baseFlag .. "BotIgnore"})
        section:Dropdown({name = "Raycast Scan Type", content = {"Normal", "Advanced"}, flag = baseFlag .. "BotScanType"})
        section:Dropdown({name = "Add to Scan Whitelist", content = {"CanCollide", "Transparency"}, multi = true, default = {"CanCollide"}, flag = baseFlag .. "BotScanIgnore"})
        section:Dropdown({name = "Origin", content = {"Camera", "Character"}, default = "Character", flag = baseFlag .. "BotOrigin"})
        section:Toggle({name = "Force Hit", flag = baseFlag .. "BotForce"})
        section:Toggle({name = "Aim for Body", flag = baseFlag .. "BotBaimEnabled"})
        section:Dropdown({name = "Automatic Fire", content = {"Off", "On Visible", "Always"}, default = "On Visible", flag = baseFlag .. "BotAuto"})
        section:Toggle({name = "Double Tap", flag = baseFlag .. "BotDoubleEnabled"})
        section:Toggle({name = "Notify on Hit", flag = baseFlag .. "BotNotify"})
    end
    
    function builder.character(section)
        local baseFlag = "rage"
        section:Toggle({name = "Enabled", flag = baseFlag .. "AntiaimEnabled"})
        section:Dropdown({name = "Yaw Modifier", content = {"Camera", "Spin", "Random"}, default = "Camera", flag = baseFlag .. "AntiaimYawModifier"})
        section:Slider({name = "Yaw Degree", min = -180, max = 180, default = 0, suffix = " Degrees", flag = baseFlag .. "AntiaimYawValue"})
        section:Dropdown({name = "Offset Yaw Modifier", content = {"None", "Jitter", "Offset Jitter"}, flag = baseFlag .. "AntiaimOffsetYawModifier"})
        section:Slider({name = "Offset Yaw Degree", min = -180, max = 180, default = 0, suffix = " Degrees", flag = baseFlag .. "AntiaimOffsetYawValue"})
    end
    
    function builder.lag(section)
        local baseFlag = "rage"
        section:Toggle({name = "Enabled", flag = baseFlag .. "FakelagEnabled"})
        section:Dropdown({name = "Method", content = {"Static", "Random"}, default = "Static", flag = baseFlag .. "FakelagMethod"})
        section:Slider({name = "Limit", min = 0, max = 12, default = 8, float = 0.5, flag = baseFlag .. "FakelagLimit"})
        section:Toggle({name = "Freeze Packets", flag = baseFlag .. "FakelagFreezeEnabled"})
    end

    function build.render(tab, side, path); path = path or {enemy = {}, friendly = {}} -- expects path.teamSettings
        local enemy, friendly, settings = tab:MultiSection({side = side, sections = {"Enemy", "Friendly", "Settings"}})

        local function buildTextRender(section, name, flag, callbacks); flag = "esp" .. flag
            local callbacks = callbacks or {
                onEnabled = function(value)

                end,
                onColor = function(Value, Transparency)

                end,
                onOutline = function(Value)

                end
            }
            local toggle = section:Toggle({name = name, flag = flag, callback = callbacks.onEnabled})
            local colorpicker1, colorpicker2 = toggle:Colorpicker({default = Color3.fromRGB(255, 255, 255), alpha = 1, flag = flag .. "Color", callback = callbacks.onColor}), toggle:Colorpicker({default = Color3.fromRGB(0, 0, 0), flag = flag .. "Outline", callback = callbacks.onOutline})

            return toggle, colorpicker1, colorpicker2
        end 
    end 
end 