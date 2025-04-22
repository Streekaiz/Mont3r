local builder = {}; do 
    function builder.tabsInit(window, tabs)
        local cache = {}

        for _, v in ipairs(tabs) do 
            cache[v] = window:Tab(v)
        end 

        return cache 
    end 

    function builder.rageSection
end 