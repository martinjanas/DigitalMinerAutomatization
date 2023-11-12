function get_peripheral_fn(name)
    local list = peripheral.getNames()
    
        for _, side in pairs(list) do
            if side == nil then
                continue()
            end
    
            local type = peripheral.getType(side)
            print("type: "..type)
            if type == name then
               return peripheral.wrap(side)
            end
    
            return nil
        end
    
        return nil
end

function is_chunky_turtle_fn()
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

function get_time_fn(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local remaining_seconds = seconds % 60
      
    return string.format("%02d:%02d:%02d", hours, minutes, remaining_seconds)
end

function go_one_chunk_fn()
	turtle.turnLeft()
	turtle.turnLeft()
	turtle.turnLeft()
	
	for j = 1, 16 do
		turtle.forward()
	end
end

function select_item_fn(item_name)
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

function place_blocks_fn(Blocks, GlobalManager)
	select_item_fn(Blocks.BLOCK_MINER)
	
	turtle.placeUp()
	turtle.turnRight()
	turtle.forward()
	turtle.forward()
	turtle.turnLeft()
	
	select_item_fn(Blocks.BLOCK_ENERGY)
	
	turtle.placeUp()
	turtle.forward()
	turtle.forward()
	turtle.turnLeft()
	turtle.forward()
	turtle.forward()
	turtle.up()
	
	select_item_fn(Blocks.BLOCK_STORAGE)
	
	turtle.placeUp()
	turtle.forward()
	
	if not GlobalManager.m_bIsChunkyTurtle and select_item_fn(Blocks.BLOCK_CHUNKLOADER) then
		GlobalManager.m_bHasChunkLoader = true
		
		select_item_fn(Blocks.BLOCK_CHUNKLOADER)
		
		turtle.placeUp()
	end
	
	turtle.forward()
	turtle.turnLeft()
	turtle.forward()
	turtle.forward()
	
	if GlobalManager.m_bIsChunkyTurtle then
	   turtle.turnLeft()
    end

	if select_item_fn(Blocks.BLOCK_CHATBOX) then
		GlobalManager.m_bHasChatBox = true
	
		select_item_fn(Blocks.BLOCK_CHATBOX)
		
		turtle.placeUp()
	end
	
	GlobalManager.m_pChatBox = get_peripheral_fn("chatBox") --chatBox
	
    os.sleep(0.15)

	GlobalManager.m_pMiner = get_peripheral_fn("digitalMiner") --digitalMiner

    if GlobalManager.m_pMiner then
       GlobalManager.m_pMiner.start()
    end
end

function destroy_blocks(GlobalManager)
	if GlobalManager.m_bHasChatBox then
		turtle.digUp()
	end

	if not GlobalManager.m_bIsChunkyTurtle then
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
	
	if not GlobalManager.m_bIsChunkyTurtle and GlobalManager.m_bHasChunkLoader then
		turtle.forward()
		turtle.dig()
	end
	
	turtle.down()
	turtle.down()
end