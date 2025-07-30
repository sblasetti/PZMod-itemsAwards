local function onInitGlobalModData()
    if (isClient()) then return end

    print("ItemsAwards - onInitGlobalModData (server)")
    LoadAwardsList()
end

-- https://github.com/MrBounty/PZ-Mod---Doc/blob/main/How%20to%20use%20global%20modData.md
Events.OnInitGlobalModData.Add(onInitGlobalModData)
