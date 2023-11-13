function utils_get_peripheral_wrap(name)
    local list = peripheral.getNames()
    
        for _, side in pairs(list) do
            if side == nil then
                continue()
            end
    
            local type = peripheral.getType(side)
            
            if type == name then
               return peripheral.wrap(side)
            end
        end
    
        return nil
end

function utils_is_chunky_turtle()
        local list = peripheral.getNames()
    
        for _, side in pairs(list) do
            if side == nil then
                continue()
            end
    
            local type = peripheral.getType(side)
    
            if string.find(type, "chunky") then
                return true
            end
        end
    
        return false
    end

function utils_get_time(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local remaining_seconds = seconds % 60
      
    return string.format("%02d:%02d:%02d", hours, minutes, remaining_seconds)
end

function utils_go_one_chunk()
	turtle.turnLeft()
	turtle.turnLeft()
	turtle.turnLeft()
	
	for j = 1, 16 do
		turtle.forward()
	end
end

function utils_select_item(item_name)
	for i = 1, 16 do
		local item_info = turtle.getItemDetail(i)
		
		if item_info ~= nil then
	
			if item_info.name == item_name then
				turtle.select(i)
				
				return true
			end
		end
	end

	return false
end

function utils_place_blocks(Blocks, GlobalVars)
	utils_select_item(Blocks.BLOCK_MINER)
	
	turtle.placeUp()
	turtle.turnRight()
	turtle.forward()
	turtle.forward()
	turtle.turnLeft()
	
	utils_select_item(Blocks.BLOCK_ENERGY)
	
	turtle.placeUp()
	turtle.forward()
	turtle.forward()
	turtle.turnLeft()
	turtle.forward()
	turtle.forward()
	turtle.up()
	
	utils_select_item(Blocks.BLOCK_STORAGE)
	
	turtle.placeUp()
	turtle.forward()
	
	if not GlobalVars.m_bIsChunkyTurtle and utils_select_item(Blocks.BLOCK_CHUNKLOADER) then
		GlobalVars.m_bHasChunkLoader = true
		
		utils_select_item(Blocks.BLOCK_CHUNKLOADER)
		
		turtle.placeUp()
	end
	
	turtle.forward()
	turtle.turnLeft()
	turtle.forward()
	turtle.forward()
	
	if GlobalVars.m_bIsChunkyTurtle then
	   turtle.turnLeft()
    end

	if utils_select_item(Blocks.BLOCK_CHATBOX) then
		GlobalVars.m_bHasChatBox = true
	
		utils_select_item(Blocks.BLOCK_CHATBOX)
		
		turtle.placeUp()
	end
	
    os.sleep(0.3)

	GlobalVars.m_pChatBox = utils_get_peripheral_wrap("chatBox") --chatBox
	GlobalVars.m_pMiner = utils_get_peripheral_wrap("digitalMiner") --digitalMiner

    --if GlobalVars.m_pMiner then
      --  GlobalVars.m_pMiner.start()
    --end
end

function utils_destroy_blocks(GlobalVars)
	if GlobalVars.m_bHasChatBox then
		turtle.digUp()
	end

	if not GlobalVars.m_bIsChunkyTurtle then
		turtle.turnLeft()
	end
	
	turtle.dig()
	turtle.forward()
	turtle.forward()
	turtle.forward()
	turtle.dig()
	turtle.turnLeft()
	turtle.forward()
	turtle.forward()
	turtle.up()
	turtle.turnLeft()
	turtle.dig()
	
	if not GlobalVars.m_bIsChunkyTurtle and GlobalVars.m_bHasChunkLoader then
		turtle.forward()
		turtle.dig()
	end
	
	turtle.down()
	turtle.down()
end

function utils_percentage_in_range(percentage, percentage_target, tolerance)
    local lower_bound = percentage_target - tolerance
    local upper_bound = percentage_target + tolerance

    return percentage >= lower_bound and percentage <= upper_bound
end