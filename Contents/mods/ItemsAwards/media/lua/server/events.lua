local function onServerStarted()
    LoadAwardsList()
end

local clientCommandHandlers = {
    [ClientCommands.REQUEST_INITIAL_AWARDS_LIST] = SyncAwardsListWithPlayer
}

local function onClientCommand(mod, command, playerObj, args)
    if mod ~= ModName then
        -- another mod's command, ignoring
        return
    end

    print("ItemsAwards - onClientCommand (server) - command received: ", mod, command)
    local handler = clientCommandHandlers[command]
    if (handler) then
        print("ItemsAwards - onClientCommand (server) - running handler")
        handler(playerObj, args)
    end
    print("ItemsAwards - onClientCommand (server) - handler processing finished")
end

Events.OnServerStarted.Add(onServerStarted)
Events.OnClientCommand.Add(onClientCommand)
