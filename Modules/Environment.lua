local env = getgenv or _G; env.MONT3R_ENV = {};
local Directory = "Mont3r";
local Logs = {};

function WriteToLog(success, message) 
    local footer = success and "mont3r | success " or "mont3r | error "
    table.insert(Logs, footer .. "| " .. message)
end;

function Call(logname, func, ...)
    local Success, Content = pcall(func, ...)

    if Success then 
        table.insert(Logs, "mont3r.lua | successfully fetched " .. logname)
        return true, Content 
    else 
        table.insert(Logs, "mont3r.lua | failed to fetch " .. logname)
        return false, {}
    end 
end;

function Get(url)
    return game:HttpGet(url, true)
end;

-- Files 

local function CreateFolder(Name)
    if Name == nil then 
        if not isfolder(Directory) then 
            makefolder(Directory)
            WriteToLog(true, "initalizing file setup")
        end 
    else 
        if not isfolder(Directory .. "/" .. Name) then 
            makefolder(Directory .. "/" .. Name)
            WriteToLog(true, "created " .. Directory .. "/" .. Name)
        end
    end
end;

local function WriteFile(To, Name, Content)
    local Folder = Directory .. "/" .. To 
    local Success, Content = Call(Folder .. "/" .. Name, Get(Content)) 

    if Success then 
        writefile(Folder .. "/" .. Name)
    else
        warn("Failed to write to " .. Folder .. "/" .. Name .. " | " .. Content)
    end
end 

for i, v in ipairs({
    "configs",
    "fonts",
    "assets",
    "modules",
    "games"
}) do CreateFolder(v) end;

