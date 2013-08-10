BoxModel = class("BoxModel",  Entity)

function BoxModel:__init(width, height, x, y, type, string, font, func, selected)
    self:addComponent(BoxComponent(width, height, {}, type))
    self:addComponent(UIStringComponent(string, font))
    self:addComponent(FunctionComponent(func))
    self:addComponent(MenuWobblyComponent())
    self:getComponent("BoxComponent").selected = selected
    self:addComponent(PositionComponent(x, y))
    table.insert(stack:current().menuboxes, self)
end