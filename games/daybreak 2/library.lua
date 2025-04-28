local library, builder, saveManager, themeManager

local window = library:CreateWindow({
    Title = "Mont3r",
    Footer = "Daybreak 2 - v" .. (isfile("mont3rVer.cfg") and readfile("mont3rVer.cfg")) or "0.0.1",
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
            }
            legit = {
                aim = tabs.legit:AddLeftGroupbox("Aim Assist"),
                silent = tabs.legit:AddRightGroupbox("Silent Aim"),
                settings = tabs.legit:AddRightGroupbox("Settings")
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
                color = tabs.visual:AddRightGroupbox("Color")
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
                main = tabs.settings:AddRightGroupbox("UI Settings"),
                config = saveManager:BuildConfigSection(tabs.settings),
                theme = themeManager:ApplyToTab(tabs.settings)
            }
        }

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
    end
end 