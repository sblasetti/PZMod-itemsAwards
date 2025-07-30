local function saveAwardsList(playerObj, args)
    print("ItemsAwards (debug) - (debug) preparing awards to save")
    local awards = {}
    for i = 1, #args.items do
        local item = args.items[i]
        print("ItemsAwards (debug) - item: ", item)
        table.insert(awards, {
            Item = item,
            Number = i,
            Count = 1,
            zkills = 1,
            onZombie = false
        })
    end

    SaveAwardsList({ items = awards })
end

local clientCommandHandlers = {
    [ClientCommands.DEBUG_CHANGE_AWARDS_LIST] = saveAwardsList
}

local function onClientCommand(mod, command, playerObj, args)
    print("ItemsAwards (debug) - onClientCommand - command received: ", mod, command)

    if mod ~= ModName then
        print("ItemsAwards (debug) - another mod's command, ignoring")
        return
    end

    print("ItemsAwards (debug) - getting command handler")
    local handler = clientCommandHandlers[command]
    if (handler) then
        handler(playerObj, args)
    end
    print("ItemsAwards (debug) - handler processing finished")
end

local function onReceiveGlobalModData(key, data)
    -- server scripts are also loaded by clients, so we check that this is running on server
    if (isClient()) then return end

    if (key == ModDataKeys.AWARDS_LIST and data) then
        print("ItemsAwards (debug) - (debug) preparing awards to save")
        local awards = {}
        for i = 1, #data.items do
            local item = data.items[i]
            print("ItemsAwards (debug) - item: ", item)
            table.insert(awards, {
                Item = item,
                Number = i,
                Count = 1,
                zkills = 1,
                onZombie = false
            })
        end

        SaveAwardsList({ items = awards })
    end
end

Events.OnClientCommand.Add(onClientCommand)
Events.OnReceiveGlobalModData.Add(onReceiveGlobalModData)
