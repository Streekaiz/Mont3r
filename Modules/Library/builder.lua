function MONT3R_ENV:BuildAimAssist(Section, Flag)
    Section:toggle({name = "enabled", flag = Flag .. "_aim_enabled"})
    Section:keybind({listname = "aim assist", flag = Flag .. "_aim_key"})
    Section:toggle({name = "require mouse movement", flag = Flag .. "_aim_require"})
    Section:dropdown({name = "raycast scanning", items = {"none", "standard", "advanced"}, default = "standard", flag = Flag .. "_aim_scan"})
    Section:toggle({name = "use smoothing", flag = Flag .. "_aim_smoothing_enabled"})
    Section:slider({name = "x smoothing factor", min = 0, max = 100, suffix = "%", intervals = 2, flag = Flag .. "_aim_smoothing_x"})
    Section:slider({name = "y smoothing factor", min = 0, max = 100, suffix = "%", intervals = 2, flag = Flag .. "_aim_smoothing_y"})
    Section:dropdown({name = "curving type", items = {"linear"}, flag = Flag .. "_curve"})
    Section:toggle({name = "predict projectile velocity", flag = Flag .. "_aim_prediction_enabled"})
    Section:dropdown({name = "prediction type", items = {"static", "dynamic", "custom"}, flag = Flag .. "_aim_prediction_type"})
    Section:slider({name = "x prediction factor", max = 5, flag = Flag .. "_aim_prediction_x"})
    Section:slider({name = "y prediction factor", max = 5, flag = Flag .. "_aim_prediction_y"})
end 

function MONT3R_ENV:BuildSilentAim(Section, Flag)
    Section:toggle({name = "enabled", flag = Flag .. "_silent_enabled"})
    Section:keybind({listname = "projectile manipulation", flag = Flag .. "_silent_key"})
    Section:toggle({name = "require mouse movement", flag = Flag .. "_silent_require"})
    Section:dropdown({name = "override method", items = {"raycast", "mouse.hit"}, flag = Flag .. "_silent_method"})
    Section:dropdown({name = "raycast scanning", items = {"none", "standard", "advanced"}, default = "standard", flag = Flag .. "_silent_scan"})
    Section:toggle({name = "predict projectile velocity", flag = Flag .. "_silent_prediction_enabled"})
    Section:dropdown({name = "prediction type", items = {"static", "dynamic", "custom"}, flag = Flag .. "_silent_prediction_type"})
    Section:slider({name = "x prediction factor", max = 5, flag = Flag .. "_silent_prediction_x"})
    Section:slider({name = "y prediction factor", max = 5, flag = Flag .. "_silent_prediction_y"})
    Section:slider({name = "hit chance", max = 100, default = 100, suffix = "%", flag = Flag .. "_silent_chance"})
end 

function MONT3R_ENV:BuildFovCircle(Properties)
    local Config = {
        Section = Properties.Section or Properties.section or nil,
        Flag = Properties.Flag or Properties.flag or "stuff",
        Color = Properties.Color or Properties.color or Color3.fromRGB(255, 100, 100),
        OutlineColor = Properties.OutlineColor or Properties.outlinecolor or Color3.fromRGB(0, 0, 0),
        Circle = Properties.Circle or Properties.circle or Drawing.new("Circle"),
        OutlineCircle = Properties.OutlineCircle or Properties.outlinecircle or Drawing.new("Circle")
    }

    local Section = Config.Section 
    local Flag = Config.Flag
    Section:toggle({name = "use fov", flag = Flag .. "_fov_use"})
    Section:keybind({flag = Flag .. "_fov_use_keybind"})
    Section:toggle({name = "show fov", flag = Flag .. "_fov_show", callback = function(Value)
        setrenderproperty(Config.Circle, "Visible", Value)
    end})
    Section:colorpicker({flag = Flag .. "_fov_color", color = Config.Color, alpha = 0, callback = function(Value)
        setrenderproperty(Config.Circle, "Color", Value)
    end})
    Section:toggle({name = "show fov outline", flag = Flag .. "_fov_outline_show", callback = function(Value)
        setrenderproperty(Config.OutlineCircle, "Visible", Value)
    end})
    Section:colorpicker({flag = Flag .. "_fov_outline_color", color = Config.OutlineColor, callback = function(Value)
        setrenderproperty(Config.OutlineCircle, "Color", Value)
    end})
    Section:slider({name = "fov radius", max = 360, default = 180, suffix = " pixels", flag = Flag .. "_fov_radius", callback = function(Value)
        setrenderproperty(Config.Circle, "Radius", Value)
		setrenderproperty(Config.OutlineCircle, "Radius", Value)
    end})
    Section:dropdown({name = "fov position", items = {"center", "mouse"}, flag = Flag .. "_fov_position", callback = function(Value)
        if Value == "center" then 
        	local size = workspace.CurrentCamera.ViewportSize
        	setrenderproperty(Config.Circle, "Position", Vector2.new(size.X / 2, size.Y / 2))
        	setrenderproperty(Config.OutlineCircle, "Position", Vector2.new(size.X / 2, size.Y / 2))
        end
    end})
end 

function MONT3R_ENV:BuildLocalPlayer(Section, Flag)
    Section:toggle({name = "speed changer", flag = Flag .. "_local_speed_enabled"})
    Section:keybind({listname = "speed", flag = Flag .. "_local_speed_key"})
    Section:dropdown({name = "speed method", items = {"normal", "cframe"}, flag = Flag .. "_local_speed_method"})
    Section:slider({name = "speed value", max = 200, flag = Flag .. "_local_speed_value"})
    Section:toggle({name = "jump power changer", flag = Flag .. "_local_jump_enabled"})
    Section:keybind({flag = "_local_jump_key"})
    Section:slider({name = "power value", max = 150, flag = Flag .. "_local_jump_value"})
    Section:toggle({name = "fly", flag = Flag .. "_local_fly_enabled"})
    Section:dropdown({name = "fly method", items = {"velocity", "platform", "cframe"}, flag = Flag .. "_local_fly_method"})
    Section:slider({name = "fly speed", min = 1, max = 100, flag = Flag .. "_local_fly_speed"})
end

function MONT3R_ENV:BuildBloom(Section, Flag, Bloom)
    local Bloom = Bloom or Instance.new("BloomEffect", cloneref(game:GetService("Lighting")))
    Section:toggle({name = "enabled", flag = Flag .. "_bloom_enabled", callback = function(Value)
        Bloom.Enabled = Value
    end})
    Section:slider({name = "intensity", max = 100, flag = "_bloom_intensity", callback = function(Value)
        Bloom.Intensity = Value / 10
    end})
    Section:slider({name = "threshold", max = 1, intervals = 3, flag = Flag .. "_bloom_threshold", callback = function(Value)
        Bloom.Threshold = Value
    end})
    Section:slider({name = "size", max = 100, flag = Flag .. "_bloom_size", callback = function(Value)
        Bloom.Size = Value
    end})
end

function MONT3R_ENV:BuildColor(Section, Flag, Color)
    local Color = Color or Instance.new("ColorCorrectionEffect", cloneref(game:GetService("Lighting")))
    Section:toggle({name = "enabled", flag = Flag .. "_color_enabled", callback = function(Value)
        Color.Enabled = Value
    end})
    Section:colorpicker({flag = Flag .. "_color_value", color = Color3.fromRGB(100,100,255), callback = function(Value)
        Color.TintColor = Value
    end})
    Section:slider({name = "brightness", flag = Flag .. "_color_brightness", min = -2.5, max = 2.5, default = 0, intervals = 3, callback = function(Value)
        Color.Brightness = Value
    end})
    Section:slider({name = "contrast", flag = Flag .. "_color_contrast", min = -2.5, max = 2.5, default = 0, intervals = 3, callback = function(Value)
        Color.Contrast = Value == 0 and 0 or Value * 1.25
    end})
    Section:slider({name = "saturation", flag = Flag .. "_color_saturation", min = -2.5, max = 2.5, default = 0, intervals = 3, callback = function(Value)
        Color.Saturation = Value
    end})
end 

function MONT3R_ENV:BuildRender(Tab, Path)
    local Path = Path or MONT3R_ENV.RENDER or MONT3R_ENV:GETRENDER() or {}
    local Enemy, Friendly = Tab:section({name = "enemy"}), Tab:Section({name = "friendly", side = "right"})

    local function TextElement(Section, Flag, Type, TextPath)
        Section:toggle({name = Type, flag = Flag .. "_enabled"})
    end 

    for i, v in ipairs({"esp_enemy_", "_esp_friendly_"}) do 
        local Section = string.find(v, "enemy") and Enemy or Friendly 
        
    end 
end