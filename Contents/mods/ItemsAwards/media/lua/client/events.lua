local serverCommandHandlers = {
    [ServerCommands.SYNC_AWARDS_LIST] = AwardsItemsServerSync
}

local function onServerCommand(mod, command, args)
    print("ItemsAwards - server command received: " .. mod .. " " .. command)

    if mod ~= ModName then
        -- another mod's command, ignoring
        return
    end

    print("ItemsAwards (client) - getting command handler")
    local handler = serverCommandHandlers[command]
    if (handler) then
        print("ItemsAwards (client) - running handler")
        handler(args)
    end
    print("ItemsAwards (client) - handler processing finished")
end

local dataRequested = false
local function requestAwardsListAndRemoveFromOnTick()
    if not dataRequested then
        print("ItemsAwards - requestAwardsListAndRemoveFromOnTick (client) - request awards list for player")
        dataRequested = true
        local playerObj = getPlayer()
        sendClientCommand(playerObj, ModName, ClientCommands.REQUEST_INITIAL_AWARDS_LIST, {})

        Events.OnTick.Remove(this)
    end
end

local function onGameStart()
    -- https://discord.com/channels/136501320340209664/232196827577974784/1391985891895152772
    Events.OnTick.Add(requestAwardsListAndRemoveFromOnTick)
end


Events.OnServerCommand.Add(onServerCommand)
Events.OnGameStart.Add(onGameStart)
