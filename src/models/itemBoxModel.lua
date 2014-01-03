ItemBoxModel = class("ItemBoxModel", Entity)

function ItemBoxModel:__init(id, w, h, x, y, selected, image, xscale, yscale)
    self:addComponent(BoxComponent(w, h, {}, image, xscale, yscale))
    self:addComponent(FunctionComponent(function ()
                                            if (gameplay.stats.blood - gameplay.items[id].price) >= 0 and gameplay.items[id].owned == false then
                                                stack:push(PromptState(
                                                    function () 
                                                        --Blood decrease and Item marked as owned
                                                        if gameplay.items[id] then
                                                            gameplay.stats.blood = gameplay.stats.blood - gameplay.items[id].price
                                                            gameplay.items[id].owned = true
                                                            gameplay.stats.owned[id] = true
                                                            Saves:saveGame()
                                                        end
                                                    end))
                                            end
                                        end    ))
    self:getComponent("BoxComponent").selected = selected
    self:addComponent(PositionComponent(x, y))
    table.insert(stack:current().boxes, self)
end