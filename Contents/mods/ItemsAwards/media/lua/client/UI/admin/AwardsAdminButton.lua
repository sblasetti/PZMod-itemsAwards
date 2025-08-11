require "ISUI/ISButton"

AwardsAdminButton = ISButton:derive("AwardsAdminButton")
AwardsAdminButton.instance = nil

function AwardsAdminButton:new(x, y, width, height, onClick)
    local o = ISButton:new(x, y, width, height, "", nil, onClick)

    setmetatable(o, self)
    self.__index = self

    o:setImage(getTexture("media/ui/icons/gift_admin_icon.png"))
    o.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
    o.backgroundColorMouseOver = { r = 1, g = 1, b = 1, a = 0.1 }
    o.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    return o
end
