
getgenv().MONT3R_ENV = {
    Library = {
        Builder = loadstring(game:HttpGet("https://raw.githubusercontent.com/Streekaiz/Mont3r/refs/heads/main/Modules/Library/builder.lua")),        ,
        Source = loadstring(game:HttpGet("https://raw.githubusercontent.com/Streekaiz/assets/refs/heads/main/Libraries/UI/Vaderpaste.lua", true))()
    }
    
}
local Library, Flags = loadstring(game:HttpGet("https://raw.githubusercontent.com/Streekaiz/assets/refs/heads/main/Libraries/UI/Vaderpaste.lua", true))()

local Window = Library:window({})

local Tab; for i, v in ipairs({"legit", "rage", "esp", "visual", "misc"}) do 
    Tab = Window:tab({name = v})
end

local a = Tab:section({name = "bleh"})
MONT3R_ENV.Library.Builder:BuildAimAssist(a, "bleh")

Tab.open_tab()