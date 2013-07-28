ItemBoxModel = class("ItemBoxModel", Entity)

function ItemBoxModel:__init(w, h, x, y, type, selected)
    self:addComponent(BoxComponent(w, h, {}, type))
    self:addComponent(FunctionComponent(function ()
    										local box = getSelectedBox()
											local index
											for i, v in pairs(stack:current().boxes) do
												if v == box then
													index = i 
												end
											end
    										if (gameplay.gold - gameplay.items[index].price) >= 0 then
    											stack:push(prompt)
    										end
    									end	))
    self:getComponent("BoxComponent").selected = selected
    self:addComponent(PositionComponent(x, y))
    table.insert(stack:current().boxes, self)
end