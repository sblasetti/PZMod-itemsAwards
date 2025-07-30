local dataRequested = false
local function requestAwardsListAndRemoveFromOnTick()
    if not dataRequested then
        print("ItemsAwards - requestAwardsListAndRemoveFromOnTick (client) - request awards list for player")
        dataRequested = true
        ModData.request(ModDataKeys.AWARDS_LIST)

        Events.OnTick.Remove(this)
    end
end

local function onGameStart()
    -- https://discord.com/channels/136501320340209664/232196827577974784/1391985891895152772
    Events.OnTick.Add(requestAwardsListAndRemoveFromOnTick)
end

local function onReceiveGlobalModData(key, data)
    -- only clients load client scripts, no need to check for isClient()
    if (key == ModDataKeys.AWARDS_LIST and data) then
        AwardsItemsServerSync(data)
    end
end

Events.OnGameStart.Add(onGameStart)
Events.OnReceiveGlobalModData.Add(onReceiveGlobalModData)
