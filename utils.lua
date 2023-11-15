function utils_get_peripheral_wrap(name)
    local list = peripheral.getNames()
    
        for _, side in pairs(list) do
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
		local item_details = turtle.getItemDetail(i)

		if item_details and item_details.name == item_name then
		   return true, i
		end
	end

	return false, -1
end

function utils_place_blocks(Blocks, GlobalVars)
	local has_miner, miner_block_index = utils_select_item(Blocks.BLOCK_MINER)

	if has_miner then
	   turtle.select(miner_block_index)
	   turtle.placeUp()
	   turtle.turnRight()
	   turtle.forward()
	   turtle.forward()
	   turtle.turnLeft()

	   local has_energy_block, energy_block_index = utils_select_item(Blocks.BLOCK_ENERGY)

	    if has_energy_block then
		   turtle.select(energy_block_index)
		   turtle.placeUp()
		   turtle.forward()
		   turtle.forward()
		   turtle.turnLeft()
		   turtle.forward()
		   turtle.forward()
		   turtle.up()

		   local has_storage_block, storage_block_index = utils_select_item(Blocks.BLOCK_STORAGE)

		    if has_storage_block then
			    turtle.select(storage_block_index)
			    turtle.placeUp()
			    turtle.forward()

			    local has_chunkloader_block, chunkloader_block_index = utils_select_item(Blocks.BLOCK_CHUNKLOADER)
			  
			    if not GlobalVars.m_bIsChunkyTurtle and has_chunkloader_block then
				   GlobalVars.m_bHasChunkLoader = true
				   turtle.select(chunkloader_block_index)
				   turtle.placeUp()
			    end

				turtle.forward()
				turtle.turnLeft()
				turtle.forward()
				turtle.forward()

				if GlobalVars.m_bIsChunkyTurtle then
				   turtle.turnLeft()
				end

				local has_chatbox_block, chatbox_block_index = utils_select_item(Blocks.BLOCK_CHATBOX)

				if has_chatbox_block then
				   GlobalVars.m_bHasChatBox = true
				   turtle.select(chatbox_block_index)
				   turtle.placeUp()
				end
		    end

			os.sleep(0.3)

			GlobalVars.m_pChatBox = utils_get_peripheral_wrap("chatBox") --chatBox
			GlobalVars.m_pMiner = utils_get_peripheral_wrap("digitalMiner") --digitalMiner
	    end
	end
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