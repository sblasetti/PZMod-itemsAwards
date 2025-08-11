awardsAdminWindow = nil

local function createAdminWindow()
    if awardsAdminWindow then return end

    local screenW = getCore():getScreenWidth()
    local screenH = getCore():getScreenHeight()
    local width = 500
    local height = 380
    local x = (screenW - width) / 2 + 400
    local y = (screenH - height) / 2

    awardsAdminWindow = AwardsAdminUI:new(x, y, width, height)
    awardsAdminWindow:initialise()
    awardsAdminWindow:addToUIManager()
    awardsAdminWindow:setVisible(false)
end

local function createAdminButtonInstance()
    if AwardsAdminButton.instance then return end
    local btnSize = 32
    local x = getCore():getScreenWidth() - 100
    local y = 600

    local btn = AwardsAdminButton:new(x, y, btnSize, btnSize, function()
        if awardsAdminWindow and awardsAdminWindow:isVisible() then
            awardsAdminWindow:setVisible(false)
            awardsAdminWindow:removeFromUIManager()
        else
            if not awardsAdminWindow then
                createAdminButtonInstance()
            else
                awardsAdminWindow:setVisible(true)
                awardsAdminWindow:addToUIManager()
            end
        end
    end)
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
    Events.OnTick.Add(function()
        if not awardsAdminWindow then
            createAdminWindow()
            Events.OnTick.Remove(this)
        end
    end)

    createAdminButtonInstance()
end

Events.OnGameStart.Add(onGameStart)
