MenuBoxModel = class("MenuBoxModel",  Entity)

function MenuBoxModel:__init(x, y, string, font, func, selected)
    local backgroundImage = resources.images.button
	self.width = backgroundImage:getWidth()
	self.height = backgroundImage:getHeight()
    self:addComponent(BoxComponent(self.width, self.height, {}))
    self:addComponent(UIStringComponent(string, font))
    self:addComponent(FunctionComponent(func))
    self:getComponent("BoxComponent").selected = selected
    self:addComponent(PositionComponent(x, y))
    self:addComponent(DrawableComponent(backgroundImage, 0, 1, 1, 0, 0))
    self:addComponent(ZIndex(100))
    table.insert(stack:current().menuboxes, self)
end