local function createAdminButtonInstance()
    if AwardsAdminButton.instance then return end
    local btnSize = 32
    local x = getCore():getScreenWidth() - 100
    local y = 600

    local btn = AwardsAdminButton:new(x, y, btnSize, btnSize)
    btn:setAnchorLeft(false)
    btn:setAnchorRight(true)
    btn:setAnchorTop(true)
    btn:setAnchorBottom(false)
    btn.tooltip = getText("IGUI_awards_admin_button_tooltip")
    btn:initialise()
    btn:addToUIManager()
    AwardsAdminButton.instance = btn
end


local function onGameStart()
    createAdminButtonInstance()
end

Events.OnGameStart.Add(onGameStart)
