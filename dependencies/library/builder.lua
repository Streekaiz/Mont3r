local builder = {}; do 
    function builder.tabsInit(window, tabs)
        local cache = {}

        for _, v in ipairs(tabs) do 
            cache[v] = window:Tab(v)
        end 

        return cache 
    end 

    function builder.aimAssist(section)
        section:Toggle({name = "Enabled", flag = "legitAimEnabled"}):Keybind({flag = "legitAimKey", mode = "toggle"}})
        section:Toggle({name = "Require Mouse Movement", flag = "legitAimMovement"})
        section:Dropdown({name = "Target Priority", content = {"Head", "Torso", "Arms", "Legs"}, multi = true, flag = "legitAimTarget"})
        section:Toggle({name = "Use Smoothing", flag = "legitAimSmoothing"})
        section:Dropdown({name = "Curving Type", content = {"linear"}, flag = "legitAimCurving"})
        section:Slider({name = "X Smoothing Factor", float = 0.25, default = 100, max = 100, suffix = "%", flag = "legitAimSmoothingX"})
        section:Slider({name = "Y Smoothing Factor", float = 0.25, default = 100, max = 100, suffix = "%", flag = "legitAimSmoothingY"})
        

    end 
end 