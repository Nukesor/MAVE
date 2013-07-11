BoxModel = class("BoxModel",  Entity)

function BoxModel:__init(w, h, x, y, type, string, font, func, selected)
    self:addComponent(BoxComponent(w, h, {}, type))
    self:addComponent(StringComponent(string, font))
    self:addComponent(FunctionComponent(func))
    self:addComponent(MenuWobblyComponent())
    self:getComponent("BoxComponent").selected = selected
    self:addComponent(PositionComponent(x, y))
    table.insert(stack:current().menuboxes, self)
end