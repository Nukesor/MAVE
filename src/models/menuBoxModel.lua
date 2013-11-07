menuBox = class("menuBox",  Entity)

function menuBox:__init(width, height, x, y, string, font, func, selected)
    self:addComponent(BoxComponent(width, height, {}))
    self:addComponent(UIStringComponent(string, font))
    self:addComponent(FunctionComponent(func))
    self:addComponent(MenuWobblyComponent())
    self:getComponent("BoxComponent").selected = selected
    self:addComponent(PositionComponent(x, y))
    table.insert(stack:current().menuboxes, self)
end