local JSON = require("json")
local awardsListData = {
    updatedBy = "",
    updatedOn = "",
    items = {}
}
local awardsListPath = "media/lua/server/data/awards.json"

function LoadAwardsList()
    local reader = getFileReader(awardsListPath, true)
    if not reader then
        return
    end

    local raw = ""
    local line = reader:readLine()
    while line do
        raw = raw .. line
        line = reader:readLine()
    end
    reader:close()

    local parsed = JSON.decode(raw)
    if parsed then
        awardsListData = parsed
    end
end

function SaveAwardsList()
    local writer = getFileWriter(awardsListPath, true, false)
    if writer then
        writer:write(JSON.encode(awardsListData))
        writer:close()
    end
end

function SyncAwardsListToPlayer(playerObj)
    sendServerCommand(playerObj, ModName, ServerCommands.SYNC_AWARDS_LIST, {
        items = awardsListData.items
    })
end

Events.OnPlayerConnect.Add(SyncAwardsListToPlayer)

-- Loads awards on start
LoadAwardsList()
