local awardsListData = {
    updatedBy = "",
    updatedAt = "",
    items = {}
}
function LoadAwardsList()
    print("ItemsAwards - LoadAwardsList (server) - start")
    if isClient() then return end

    local modDataAwardsList = ModData.getOrCreate(ModDataKeys.AWARDS_LIST)
    awardsListData.items = modDataAwardsList.items or {}
    print("ItemsAwards - LoadAwardsList (server) - initialize awards (", #awardsListData.items, ")")

    for i = 1, #awardsListData.items do
        print("ItemsAwards - LoadAwardsList (server) stored item: ", awardsListData.items[i].Item)
    end
end

function SaveAwardsList(args)
    -- TODO: only admins can do this

    print("ItemsAwards - SaveAwardsList (server) - items (", #args.items, ")")
    local modData = ModData.getOrCreate(ModDataKeys.AWARDS_LIST)
    for i = 1, #args.items do
        print("ItemsAwards - SaveAwardsList (server) - item to save: ", args.items[i].Item)
    end
    modData.items = args.items
    -- TODO: get admin username
    modData.updatedBy = "user"
    modData.updatedAt = os.time()

    ModData.add(ModDataKeys.AWARDS_LIST, modData)
    awardsListData.items = modData.items
    print("ItemsAwards - SaveAwardsList (server) - items saved")

    -- refresh awards list on all players
    SyncAwardsListWithAllPlayers()
end

function SyncAwardsListWithAllPlayers()
    print("ItemsAwards - SyncAwardsListToAllPlayers (server) - refresh all clients (", #awardsListData.items, ")")
    sendServerCommand(ModName, ServerCommands.SYNC_AWARDS_LIST, {
        items = awardsListData.items
    })
end

function SyncAwardsListWithPlayer(playerObj, args)
    print("ItemsAwards - SyncAwardsListWithPlayer (server) - refresh player", playerObj:getUsername(), "(",
        #awardsListData.items, ")")
    sendServerCommand(playerObj, ModName, ServerCommands.SYNC_AWARDS_LIST, {
        items = awardsListData.items
    })
end
