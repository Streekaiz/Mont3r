local env = {
    utilities = {},
    library = {},
    assets = {}
}; do 
    local function fetch(url)
        local success, content = pcall(function()
            return game:HttpGet(url)
        end)

        return success, content 
    end

    
end 

return env 