-- // setting up functions that might not be supported in a env / rstudio environment 
local setrenderproperty = setrenderproperty or function(drawing : string, key : any, value : any)
    drawing[key] = value 
end

local cloneref = cloneref or function(instance : any)
    return instance 
end 

local gethui = gethui or function()
    return cloneref(game:GetService("CoreGui"))
end 

-- // creating a service metatable to make accessing services easier
local services = {}; setmetatable(services, {__index = function(_, service) return cloneref(game:GetService(service)) end}); 

-- // defining variables; aswell as caching stuff
local players = services.Players 
local userInputService = services.UserInputService
local runService = services.RunService 
local tweenService = services.TweenService 
local coreGui = services.CoreGui

local localPlayer = players.LocalPlayer 
local camera = workspace.CurrentCamera

local newInstance = Instance.new 
local newDrawing = Drawing.new
local newVector3 = Vector3.new
local newVector2 = Vector2.new 
local wait = task.wait 
local findFirstChild = workspace.FindFirstChild 
local findFirstChildOfClass = workspace.FindFirstChildOfClass
local worldToViewportPoint = camera.WorldToViewportPoint
local worldToScreenPoint = camera.WorldToScreenPoint 
local getPlayers = players.GetPlayers
local isA = workspace.IsA
local tweenInfo = TweenInfo.new 
local findPartOnRayWithIgnoreList = workspace.FindPartOnRayWithIgnoreList
local mathHuge = math.huge 

-- // library init
local library = {
    debug = false, 

    author = "Streekaiz",
    repo = "yurr",

    folder = "Mont3r",
    folders = {
        "functionData", 
        "logs",
            "logs/info",
            "logs/warning",
            "logs/errors",
            "logs/executions",
        
    },
    
    connections = {},
    drawings = {},
    instances = {},
    signals = {},

    players = {},
    preloadedImages = {},

    unloadFunctions = {
        removeDrawings = function()
            if cleardrawingcache then 
                cleardrawingcache()
            else
                for i, v in ipairs(drawings) do
                    v:Destroy()
                end 
            end 
        end,
        removeInstances = function()
            for i, v in ipairs(instances) do 
                v:Destroy() 
            end 
        end
    },
}; do -- // creating library functions
    function library.log(file, content, to)
        writefile(library.directory .. "/" .. to .. "/" .. file, content)
    end 
    
    function library.downloadFile(path, data)
        local success, content = pcall(function()
            return game:HttpGet(data)
        end)

        if success then 
            writefile(path, content)
        else
            warn("error writing to " .. path .. "; " .. content)
            return 
        end 

        return content 
    end 

    function library.ensureFolder(path)
        if not isfolder(path) then 
            makefolder(path)
            return path 
        end 
    end 

    function library.ensureFile(path, content)
        if not isfile(path) then 
            local success, content = pcall(writefile(path, content))
            if success then 
                return path 
            else
                warn("error writing to " .. path .. "; " .. content)
                return path 
            end 
        end 
    end 

    function library.connect(signal, callback, index)
        if not signal or callback then return end 
        
        index = index or #library.connections+1
        
        local connection = signal:Connect(callback)
        
        library.connections[index] = connection
        
        return connection  
    end 

    function library.draw(class, properties, index)
        local drawing = newDrawing(class)
        index = index or #library.drawings + 1

        for i, v in ipairs(properties) do 
            setrenderproperty(drawing, i, v)
        end; library.drawings[index] = drawing 

        return drawing 
    end 

    function library.instance(class, parent, properties, index)
        local instance = newInstance(class)
        index = index or #library.instances + 1 

        for i, v in ipairs(properties) do 
            setrenderproperty(instance, i, v)
        end; library.instances[index] = instance; 

        instance.Parent = parent 
        
        return instance 
    end 

    function library.saveData(name, data)
        data = httpService:JSONEncode(data)

        if data then 
            writefile(library.folder .. "/functionData/" .. name, data) 
        end
        
        return data 
    end 

    function library.getData(name)
        return httpService:JSONDecode(readfile(library.folder .. "/functionData/" .. name))
    end 

    function library.getCharacter(player)
        return player.Character 
    end 

    function library.getHumanoid(character)
        return character.Humanoid or findFirstChildOfClass(character, "Humanoid")
    end 

    function library.getRoot(character)
        return character.HumanoidRootPart or findFirstChild(character, "HumanoidRootPart")
    end 

    function library.getTeam(player)
        return player.Team 
    end 

    function library.getViewportSize()
        return camera.ViewportSize
    end 

    function library.worldToViewportPoint(position)
        return worldToViewportPoint(position)
    end 

    function library.isAlive(player)
        local character = library.getCharacter(player)
        if character then 
            local humanoidRootPart = library.getRoot(character)
            if humanoidRootPart then 
                local humanoid = library.getHumanoid(character)
                if humanoid then 
                    return humanoid.Health > 0, character, humanoidRootPart, humanoid 
                end 
            end 
        end 

        return false, nil, nil 
    end 

    function library.isFriendly(first, second)
        return library.getTeam(first) == (second and library.getTeam(second)) or library.getTeam(localPlayer)
    end 

    function library.isVisible(origin, position, accuracy, ignore)
        local hit, pos = findPartOnRayWithIgnoreList(Ray.new(origin, (position - origin).Unit * (position - origin).Magnitude), ignore, false, true)

        return (pos - position).Magnitude <= accuracy, hit, pos
    end 

    function library.getMouseLocation()
        return userInputService:GetMouseLocation()
    end 

    function library.getClosestRenderedPlayer(Function)
        Function = Function or function() return true end

        local closestPlayer, closestPosition 
        local shortestDistance = mathHuge 

        for _, v in ipairs(getPlayers()) do 
            if not Function(v) then continue end 

            local screenPos, onScreen = worldToViewportPoint(library.getRoot(library.getCharacter(v)).Position)
            local mousePos = library.getMouseLocation()
            local magnitude = (newVector2(screenPos.X, screenPos.Y) - newVector2(mousePos.X, mousePos.Y)).Magnitude

            if onScreen and magnitude < shortestDistance then 
                closestPlayer = v 
                closestPos = screenPos 
                shortestDistance = magnitude
            end 
        end 

        return closestPlayer, closestPosition, shortestDistance  
    end 

    function library.getClosestPartByMouse(list)
        local closestPart, closestPos
        local shortestDistance = mathHuge 

        for _, part in ipairs(list) do 
            if isA(part, "BasePart") then 
                local screenPos, onScreen = worldToViewportPoint(part.Position)
                local mousePos = library.getMouseLocation()
                local magnitude = (newVector2(screenPos.X, screenPos.Y) - newVector2(mousePos.X, mousePos.Y)).Magnitude

                if onScreen and magnitude < shortestDistance then 
                    closestPart = part 
                    closestPos = screenPos 
                    shortestDistance = magnitude 
                end 
            end 
        end 

        return closestPart, closestPosition, shortestDistance
    end 

    function library.listBodyParts(character, root, index, hitboxes)
        local parts = {}
        local hitboxes = hitboxes or {"Head", "Torso", "Arms", "Legs"}
    
        for _, part in ipairs(character:GetChildren()) do 
            if part:IsA("BasePart") and part ~= root then 
                local name = string.lower(part.Name)
                local idx = index and part.Name or #parts + 1
                if table.find(hitboxes, "Head") and name:find("head") then
                    parts[idx] = part
                elseif table.find(hitboxes, "Torso") and name:find("torso") then 
                    parts[idx] = part
                elseif table.find(hitboxes, "Arms") and name:find("arm") then 
                    parts[idx] = part
                elseif table.find(hitboxes, "Legs") and name:find("leg") then 
                    parts[idx] = part
                end
            end 
        end 
    
        return parts
    end

    function library.scan(insert)
        return {
            insert.Position + (newVector3(insert.Size.X, 0, 0) / 2),
            insert.Position - (newVector3(insert.Size.X, 0, 0) / 2),
            insert.Position + (newVector3(0, insert.Size.Y, 0) / 2),
            insert.Position - (newVector3(0, insert.Size.Y, 0) / 2),
            insert.Position + (newVector3(0, 0, insert.Size.Z) / 2),
            insert.Position - (newVector3(0, 0, insert.Size.Z) / 2),
            insert.Position,
        }
    end 

    function library.scanAdvanced(insert)
        return {
            insert.Position + (newVector3(insert.Size.X, 0, 0) / 2),
            insert.Position - (newVector3(insert.Size.X, 0, 0) / 2),
            insert.Position + (newVector3(0, insert.Size.Y, 0) / 2),
            insert.Position - (newVector3(0, insert.Size.Y, 0) / 2),
            insert.Position + (newVector3(0, 0, insert.Size.Z) / 2),
            insert.Position - (newVector3(0, 0, insert.Size.Z) / 2),
            insert.Position + (newVector3(insert.Size.X, insert.Size.Y, 0) / 2),
            insert.Position - (newVector3(insert.Size.X, insert.Size.Y, 0) / 2),
            insert.Position + (newVector3(0, insert.Size.Y, insert.Size.Z) / 2),
            insert.Position - (newVector3(0, insert.Size.Y, insert.Size.Z) / 2),
            insert.Position + (newVector3(insert.Size.X, 0, insert.Size.Z) / 2),
            insert.Position - (newVector3(insert.Size.X, 0, insert.Size.Z) / 2),
            insert.Position + (newVector3(-insert.Size.X, insert.Size.Y, 0) / 2),
            insert.Position + (newVector3(insert.Size.X, -insert.Size.Y, 0) / 2),
            insert.Position + (newVector3(0, -insert.Size.Y, insert.Size.Z) / 2),
            insert.Position + (newVector3(0, insert.Size.Y, -insert.Size.Z) / 2),
            insert.Position + (newVector3(-insert.Size.X, 0, insert.Size.Z) / 2),
            insert.Position + (newVector3(insert.Size.X, 0, -insert.Size.Z) / 2),
            insert.Position + (newVector3(-insert.Size.X, insert.Size.Y, insert.Size.Z) / 2),
            insert.Position + (newVector3(insert.Size.X, -insert.Size.Y, insert.Size.Z) / 2),
            insert.Position + (newVector3(insert.Size.X, insert.Size.Y, -insert.Size.Z) / 2),
            insert.Position + (newVector3(-insert.Size.X, -insert.Size.Y, insert.Size.Z) / 2),
            insert.Position + (newVector3(insert.Size.X, -insert.Size.Y, -insert.Size.Z) / 2),
            insert.Position + (newVector3(-insert.Size.X, insert.Size.Y, -insert.Size.Z) / 2),
            insert.Position + (insert.Size / 2),
            insert.Position - (insert.Size / 2),
            insert.Position,
        }
    end

    function library.preloadImage(link)
        local data = library.preloadedImages[link] or game:HttpGet(link)
        if library.preloadedImages[link] == nil then
            library.preloadedImages[link] = data
        end
        return data
    end

    function library.scheduleTask(func, delay)
        coroutine.wrap(function()
            wait(delay)
            
            pcall(func)
        end)
    end 

    function library.addSignal(signal, func)
        library.signals[signal] = func 
    end 

    function library.deleteSignal(signal)
        library.signals[signal] = nil 
    end 

    function library.fireSignal(signal)
        for _, v in ipairs(library.signals) do 
            if _ == signal then 
                task.spawn(v)
            end 
        end 
    end 

    function library.unload()
        for _, v in ipairs(library.unloadFunctions) do 
            task.spawn(v)
        end
        library = nil 
    end 
end 

-- // connecting player events & adding them to a table
-- // might have some use later?
for _, v in ipairs(getPlayers()) do 
    if v ~= localPlayer then
        table.insert(library.players, v)
    end 
end 

library.connect(players.PlayerAdded, function(player)
    table.insert(library.players, player)
end)

library.connect(players.PlayerRemoving, function(player)
    for _, v in ipairs(library.players) do 
        if v == player then 
            table.remove(library.players, player)
        end 
    end 
end)

-- // check if theres already a created env; and defines itself
local env; do 
    env = MONT3R or MONT3R_ENV or mont3r or mont3rEnv or nil 

    if env then 
        if env.dependencies then 
            if not env.dependencies.functions then 
                env.dependencies.functions = library 
            end 
        end 

        if not env.services then 
            env.services = services 
        end 
    end 
end 

-- // returns the library!
return library