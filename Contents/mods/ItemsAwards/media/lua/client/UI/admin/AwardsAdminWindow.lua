require "ISUI/ISPanel"

AwardsAdminUI = ISPanel:derive("AwardsAdminUI")

function AwardsAdminUI:initialise()
    ISPanel.initialise(self)
    self:create()
end

function AwardsAdminUI:prerender()
    ISPanel.prerender(self)
    self:drawText(getText("UI_welcomeawards"), 10, 10, 1, 1, 1, 1, UIFont.Medium)
    self:drawText(getText("UI_version") .. ": 1.0", 10, 40, 0.8, 0.8, 0.8, 1, UIFont.Small)
    self:drawText(getText("UI_instructions"), 10, 70, 0.8, 0.8, 0.8, 1, UIFont.Small)
end

function AwardsAdminUI:create()
    local btnWidth = 100
    local btnHeight = 25

    self.awardsList = ISScrollingListBox:new(10, 100, self.width - 20, 200)
    self.awardsList:initialise()
    self.awardsList:instantiate()
    self.awardsList.itemheight = 22
    self.awardsList.selected = 0
    self.awardsList.joypadParent = self
    self.awardsList.font = UIFont.NewSmall
    self.awardsList.doDrawItem = self.drawAwardItem
    self.awardsList:setOnMouseDoubleClick(self, self.onAwardDoubleClick)
    self:addChild(self.awardsList)

    -- self.losersList = ISScrollingListBox:new(10, self.awardsList:getY() + self.awardsList:getHeight() + 10,
    --     self.width - 20, 110)
    -- self.losersList:initialise()
    -- self.losersList:instantiate()
    -- self.losersList.itemheight = 22
    -- self.awardsList.selected = 0
    -- self.losersList.font = UIFont.NewSmall
    -- self.losersList.doDrawItem = self.drawLoserItem
    -- self:addChild(self.losersList)

    self.closeButton = ISButton:new(
        self.width - 490,
        self.awardsList:getY() + self.awardsList:getHeight() + 10,
        btnWidth,
        btnHeight,
        getText("UI_Close"),
        self,
        AwardsWelcomeUI.onCloseClick
    )

    self:addChild(self.closeButton)

    -- self.cleanButton = ISButton:new(
    --     self.closeButton:getX() + btnWidth + 10,
    --     self.losersList:getY() + self.losersList:getHeight() + 10,
    --     btnWidth,
    --     btnHeight,
    --     getText("UI_clean"),
    --     self,
    --     AwardsWelcomeUI.onCleanClick
    -- )

    -- self:addChild(self.cleanButton)

    -- self.cleanLoserButton = ISButton:new(
    --     self.cleanButton:getX() + btnWidth + 10,
    --     self.losersList:getY() + self.losersList:getHeight() + 10,
    --     btnWidth,
    --     btnHeight,
    --     getText("UI_clean_loser"),
    --     self,
    --     AwardsWelcomeUI.onCleanLoserClick
    -- )

    -- self:addChild(self.cleanLoserButton)
end

function AwardsAdminUI:drawAwardItem(y, item, alt)
    local a = 0.9
    self:drawRectBorder(0, y, self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g,
        self.borderColor.b)

    if self.selected == item.index then
        self:drawRect(0, y, self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15)
    end

    local iconSize = (self.itemheight - 4)
    local x = 5

    if item.item and item.item.icon then
        self:drawTextureScaledAspect(item.item.icon, x, y + (self.itemheight - iconSize) / 2, iconSize, iconSize, a, 1, 1,
            1)
    end

    local nameX = x + iconSize + 8

    if item.item and item.item.name then
        self:drawText(item.item.name, nameX, y + 3, 1, 1, 1, a, self.font)
    end

    return y + self.itemheight
end

-- function AwardsAdminUI:drawLoserItem(y, item, alt)
--     local a = 0.9
--     self:drawRectBorder(0, y, self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g,
--         self.borderColor.b)
--     self:drawText(item.text, 10, y + 2, 1, 1, 1, a, self.font)
--     return y + self.itemheight
-- end

function AwardsAdminUI:onCloseClick()
    self:setVisible(false)
    self:removeFromUIManager()
end

function AwardsAdminUI:onAddClick()
end

-- function AwardsAdminUI:onCleanClick()
--     self.awardsList:clear()
-- end

-- function AwardsAdminUI:onCleanLoserClick()
--     self.losersList:clear()
-- end

function AwardsAdminUI:addAward(_item)
    -- local limit = Awards.Options.limitWinningNumbers * 5
    local icon, awardPosition, itemName

    if _item then
        local item = InventoryItemFactory.CreateItem(_item.Item)
        if item then
            itemName = item:getDisplayName()
            icon = item:getTex()
        end
    end

    self.awardsList:insertItem(1, itemName, { icon = icon, name = itemName })
    self.awardsList.selected = 1

    -- while self.awardsList:size() > limit do
    --     self.awardsList:removeItemByIndex(self.awardsList:size())
    -- end
end

-- function AwardsAdminUI:onAwardDoubleClick()
--     local selectedIndex = self.awardsList.selected
--     if selectedIndex and selectedIndex > 0 then
--         self.awardsList:removeItemByIndex(selectedIndex)
--     end
-- end

-- function AwardsAdminUI:addLoserMessage(message)
--     local limit = Awards.Options.limitLosingNumbers * 5

--     self.losersList:insertItem(1, message, {})
--     self.losersList.selected = 1

--     while self.losersList:size() > limit do
--         self.losersList:removeItemByIndex(self.losersList:size())
--     end
-- end

function AwardsAdminUI:new(x, y, width, height)
    local o = {}
    o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self

    o.backgroundColor = { r = 0.1, g = 0.1, b = 0.1, a = 0.9 }
    o.borderColor = { r = 0.7, g = 0.7, b = 0.7, a = 0.5 }
    o.moveWithMouse = true
    return o
end
