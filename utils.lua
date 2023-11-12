local utils = {}

function utils.is_chunky_turtle_fn()
        local list = peripheral.getNames()
    
        for _, side in pairs(list) do
            if side == nil then
                continue()
            end
    
            local type = peripheral.getType(side)
    
            if not string.find(type, "chunky") then
                return false
            end
    
            return true
        end
    
        return false
    end
