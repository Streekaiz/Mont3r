local library, builder, saveManager, themeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Streekaiz/Mont3r/refs/heads/main/dependencies/library/builder.lua", true))(); do 
    saveManager:SetLibrary(library)
    themeManager:SetLibrary(library)
end 

local window = library:CreateWindow({
    Title = "Mont3r",
    Footer = "Daybreak 2 - v0.0.1",
    CornerRadius = 0,
    MobileButtonsSide = "Right"
}); do 
    local tabs = builder.setUpTabs({
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
                Visible = false, Disabled = true,
                DisabledTooltip = "Only enabled for ChildAdded!"
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
            builder.setUpAimAssist(sections.legit.aim)
            builder.setUpFov(sections.legit.aim, "legitAim")
            builder.setUpSilentAim(sections.legit.silent)
            builder.setUpFov(sections.legit.silent, "legitSilent")
        end

        do -- // Rage
            builder.setUpRagebot(sections.rage.bot, "rageBot")
            builder.setUpCharacter(sections.rage.char, "rageAnti")
            builder.setUpLag(sections.rage.lag, "rageLag")
        end 

        do -- // Visuals
            builder.setUpBloomEffect(sections.visual.bloom, "visual")
            builder.setUpColorCorrectionEffect(sections.visual.color, "visual")
            builder.setUpCamera(sections.visual.camera, "visual")
            builder.setUpWorld(sections.visual.world, "visual")
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