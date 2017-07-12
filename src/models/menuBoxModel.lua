MenuBoxModel = class("MenuBoxModel",  Entity)

function MenuBoxModel:initialize(x, y, string, font, func, selected)
    local backgroundImage = resources.images.button
	self.width = backgroundImage:getWidth()
	self.height = backgroundImage:getHeight()
    self:add(BoxComponent(self.width, self.height, {}))
    self:add(FunctionComponent(func))
    self:get("BoxComponent").selected = selected
    self:add(PositionComponent(x, y))
    self:add(DrawableComponent(backgroundImage, 0, 1, 1, 0, 0))
    self:add(ZIndex(100))

    local textX = x + (self.width*relation()/2) - (font:getWidth(string)*relation()/2)
    local textY = y + (self.height*relation()/2) - (font:getHeight(string)*relation()/2)
    self:add(UIStringComponent(string, font, textX, textY))

    table.insert(stack:current().menuboxes, self)
end