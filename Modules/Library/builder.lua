local Library = {}

function Library:BuildTabs(Window, Tabs)
    local Stored = {}
    for i, v in ipairs(Tabs) do 
        Window:tab({name = v})
        Stored[i] = v 
    end 

    return Stored
end 

function Library:BuildTab(Window, Type)
    Type = Type and string.lower(Type) or "legit"
    local Tab = Window:tab({name = Type})
    if Type == "legit" then 
        local Aim = Tab:section({name = "aim assist"})
        local Hitpart = Tab:hitpart_picker({name = "target priority", type = "R15", flag = Type .. "_target"})
        local Silent = Tab:section({name = "projectile manipulation", side = "right"})
        self:BuildAimAssist(Aim, Type)
        self:BuildSilentAim(Silent, Type)
        self:BuildFovCircle({
            Section = Aim,
            Flag = Type
        })
        self:BuildFovCircle({
            Section = Silent,
            Flag = "Type
        })
        return Tab, Aim, Silent
    elseif Type == "rage" then 
        Tab:hitpart_picker({name = "target priority", flag = Type .. "_target"})
        local Bot, Character, Lag = Tab:section({name = "rage bot"}), Tab:section({name = "anti aim", side = "right"}), Tab:section({name = "desync", side = "right"})
        self:BuildRagebot(Bot, Type)
        self:BuildCharacter(Character, Type)
        self:BuildCharacter(Lag, Type)
    elseif Type == "esp" then 

    elseif Type == "visual" then 
        local Camera, World, Color, Bloom = Tab:section({name = "camera"}), Tab:section({name = "world", side = "right"}), Tab:section({name = "color correction"}), Tab:section({name = "bloom effect", side = "right"})
        
    elseif Type == "misc" then 

    end 
end 

function Library:BuildAimAssist(Section, Flag)
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

function Library:BuildSilentAim(Section, Flag)
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

function Library:BuildFovCircle(Properties)
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

function Library:BuildLocalPlayer(Section, Flag)
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

function Library:BuildBloom(Section, Flag, Bloom)
    Bloom = Bloom or Instance.new("BloomEffect", cloneref(game:GetService("Lighting")))
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

function Library:BuildColor(Section, Flag, Color)
    Color = Color or Instance.new("ColorCorrectionEffect", cloneref(game:GetService("Lighting")))
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

function Library:BuildCamera(Section, Flag)
    Section:toggle({name = "field of view changer", flag = Flag .. "_fov_enabled"})
    Section:slider({name = "field of view value", min = 0, max = 120, default = 70, flag = Flag .. "_fov_value"})
    Section:toggle({name = "zoom", flag = Flag .. "_zoom_enabled"})
    Section:keybind({listname = "zoom", flag = Flag .. "_zoom_key"})
    Section:slider({name = "zoom field of view", min = 0, max = 120, default = 30, flag = Flag .. "_zoom_value"})
    Section:toggle({name = "third person", flag = Flag .. "_3rdperson_enabled"})
    Section:keybind({listname = "third person", flag = Flag .. "_3rdperson_key"})
    Section:dropdown({name = "third person method", items = {"camera", "hookmetamethod"}, default = "hookmetamethod", flag = Flag .. "_3rdperson_method"})
    Section:slider({name = "third person distance", min = 0, max = 12, default = 3, intervals = 3, flag = Flag .. "_3rdperson_distance"})
    Section:slider({name = "minimum zoom distance", min = 0, max = 2500, default = workspace.CurrentCamera.MinimumZoomDistance, flag = Flag .. "_zoomdistance_min"})
    Section:slider({name = "maximum zoom distance", min = 0, max = 2500, default = workspace.CurrentCamera.MaximumZoomDistance, flag = Flag .. "_zoomdistance_max"})
end 

function Library:BuildRagebot(Section, Flag)
    Section:toggle({name = "enabled", color = Color3.fromRGB(255, 100, 100), flag = "_ragebot_enabled"})
    Section:keybind({listname = "ragebot", flag = Flag .. "_ragebot_key"})
    Section:toggle({name = "ignore obstacles", flag = Flag .. "_ignore"})
    Section:dropdown({name = "raycast scan type", items = {"normal", "advaanced"}, flag = Flag .. "_ragebot_scan_type"})
    Section:dropdown({name = "add to scan whitelist", items = {"cancollide", "transparency"}, multi = true, default = {"cancollide"}, flag = Flag .. "_ragebot_scan_ignore"})
    Section:dropdown({name = "origin", items = {"camera", "character"}, default = "character", flag = Flag .. "_ragebot_origin"})
    Section:toggle({name = "force hit", flag = Flag .. "_ragebot_force"})
    Section:toggle({name = "aim for body", flag = Flag .. "_ragebot_baim_enabled"})
    Section:keybind({listname = "body aim", flag = Flag .. "_ragebot_baim_key"})
    Section:dropdown({name = "automatic fire", items = {"off", "on visible", "always"}, default = "on visible", flag = Flag .. "_ragebot_auto"})
    Section:toggle({name = "double tap", flag = Flag .. "_ragebot_double_enabled"})
    Section:keybind({listname = "double tap", flag = Flag .. "_ragebot_double_key"})
    Section:toggle({name = "notify on hit", flag = Flag .. "_ragebot_notify"})
end 

function Library:BuildCharacter(Section, Flag)
    Section:toggle({name = "enabled", flag = Flag .. "_antiaim_enabled"})
    Section:keybind({listname = "anti aim", flag = Flag .. "_antiaim_key"})
    Section:dropdown({name = "yaw modifier", items = {"camera", "spin", "random"}, flag = Flag .. "_antiaim_yaw_modifier"})
    Section:slider({name = "yaw degree", min = -180, max = 180, default = 0, suffix = " degrees", flag = Flag .. "_antiaim_yaw_value"})
    Section:dropdown({name = "offset yaw modifier", items = {"none", "jitter", "offset jitter"}, flag = Flag .. "_antiaim_offset_yaw_modifier"})
    Section:slider({name = "offset yaw degree", min = -180, max = 180, default = 0, suffix = " degrees", flag = Flag .. "_antiaim_offset_yaw_value"})
end 

function Library:BuildLag(Section, Flag)
    Section:toggle({name = "enabled", flag = Flag .. "_fakelag_enabled"})
    Section:dropdown({name = "method", items = {"static", "random"}, flag = Flag .. "_fakelag_method"})
    Section:slider({name = "limit", min = 0, max = 12, default = 8, flag = Flag .. "_fakelag_limit"})
    Section:toggle({name = "freeze packets", flag = Flag .. "_fakelag_freeze_enabled"})
    Section:keybind({listname = "freeze packets", flag = Flag .. "_fakelag_freeze_key"})
end 

function Library:BuildRender(Tab, Path)
    local Path = Path or MONT3R_ENV.RENDER or MONT3R_ENV:GETRENDER() or {}
    local Enemy, Friendly = Tab:section({name = "enemy"}), Tab:section({name = "friendly", side = "right"})

    local function TextElement(Section, Flag, Type, TextPath)
        Section:toggle({name = Type, flag = Flag .. "_enabled"})
    end 

    for i, v in ipairs({"esp_enemy_", "_esp_friendly_"}) do 
        local Section = string.find(v, "enemy") and Enemy or Friendly 
        
    end 

    return Enemy, Friendly 
end

if getgenv().MONT3R_ENV then 
    if getgenv().MONT3R_ENV.Library then 
        getgenv().MONT3R_ENV.Library.Builder = Library 
    end 
end 

return Library
