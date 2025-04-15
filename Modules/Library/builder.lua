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
    Section:toggle({name = "use fov", flag = Flag .. "_fov_use"})
    Section:toggle({name = "show fov", flag = Flag .. "_fov_show"})
    Section:keybind({flag = Flag .. "_fov_show_keybind"})

    
end 
