local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()
local Window = Library:CreateWindow({
    Title = "My Script",
    Footer = "v1.0.0",
    ToggleKeybind = Enum.KeyCode.RightControl,
    Center = true,
    AutoShow = true
}); do 
    local Home = Window:AddTab("Home", "house") do 

    end 

    local Main = Window:AddTab("Main", "settings") do 
        local Bubble = Window:AddLeftGroupbox("Bubbles") do 
            Bubble:AddToggle("auto_blow", {
                Text = "Autoblow bubbles",
                Tooltip = "Blows bubbles for you"
            })

            Bubble:AddToggle("auto_sell", {
                Text = "Sell bubbles",
                Tooltip = "Sells your bubble for you"
            })

            Bubble:AddSlider("auto_sell_percent", {
                Text = "Sell Minimum",
                Min = 0,
                Max = 100,
                Suffix = "%",
                Decimals = 2
            })
        end 
    end 

    local Settings = Window:AddTab("Settings", "settings") do 

    end 
end

  n