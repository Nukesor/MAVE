MenuBoxModel = class("MenuBoxModel",  Entity)

function MenuBoxModel:__init(x, y, string, font, func, selected)
    local backgroundImage = resources.images.button
	self.width = backgroundImage:getWidth()
	self.height = backgroundImage:getHeight()
    self:addComponent(BoxComponent(self.width, self.height, {}))
    self:addComponent(FunctionComponent(func))
    self:getComponent("BoxComponent").selected = selected
    self:addComponent(PositionComponent(x, y))
    self:addComponent(DrawableComponent(backgroundImage, 0, 1, 1, 0, 0))
    self:addComponent(ZIndex(100))

    local textX = x + (self.width*relation()/2) - (font:getWidth(string)*relation()/2)
    local textY = y + (self.height*relation()/2) - (font:getHeight(string)*relation()/2)
    self:addComponent(UIStringComponent(string, font, textX, textY))

    table.insert(stack:current().menuboxes, self)
end