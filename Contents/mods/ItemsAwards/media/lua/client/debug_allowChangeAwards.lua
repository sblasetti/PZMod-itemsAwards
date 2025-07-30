local function getPlayerToolboxItems(playerObj)
    local items = playerObj:getInventory():getItems()
    for i = 1, items:size() do
        local item = items:get(i - 1)
        if (item:getType() == "Toolbox") then
            print("ItemsAwards (debug)  (client) - found toolbox")
            return item:getInventory():getItems()
        end
    end

    print("ItemsAwards (debug)  (client) - no toolbox available")
    return nil
end

local function onEnterVehicle(playerObj)
    -- prepare list of current items on inventory
    local toolboxItems = getPlayerToolboxItems(playerObj)
    if (not toolboxItems) then
        print("ItemsAwards (debug)  (client) - no items to send to server")
        return
    end

    print("ItemsAwards (debug)  (client) - prepare list of awards")
    local inventoryItems = {}
    local toolboxItemsSize = toolboxItems and toolboxItems:size() or 0
    print("ItemsAwards (debug) - toolbox items count: ", toolboxItemsSize)
    for i = 1, toolboxItemsSize do
        local item = toolboxItems:get(i - 1)
        print("ItemsAwards (debug) - toolbox item: ", item:getType())
        table.insert(inventoryItems, item:getType())
    end

    -- send that as new list of awards
    print("ItemsAwards (debug)  (client) - request to store awards")
    sendClientCommand(playerObj, ModName, ClientCommands.DEBUG_CHANGE_AWARDS_LIST, { items = inventoryItems })
end

Events.OnEnterVehicle.Add(onEnterVehicle)
