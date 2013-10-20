ItemBoxModel = class("ItemBoxModel", Entity)

function ItemBoxModel:__init(w, h, x, y, type, selected, image, xscale, yscale)
    self:addComponent(BoxComponent(w, h, {}, type, image, xscale, yscale))
    self:addComponent(FunctionComponent(function ()
                                            local box = getSelectedBox()
                                            local index
                                            for i, v in pairs(stack:current().boxes) do
                                                if v == box then
                                                    index = i 
                                                end
                                            end
                                            if (gameplay.stats.blood - gameplay.items[index].price) >= 0 and gameplay.items[index].owned == false then
                                                stack:push(prompt)
                                            end
                                        end    ))
    self:getComponent("BoxComponent").selected = selected
    self:addComponent(PositionComponent(x, y))
    table.insert(stack:current().boxes, self)
end