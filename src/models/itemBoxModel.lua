ItemBoxModel = class("ItemBoxModel", Entity)

function ItemBoxModel:initialize(id, w, h, x, y, selected, image, xscale, yscale)
    self:add(BoxComponent(w, h, {}, image, xscale, yscale))
    self:add(FunctionComponent(function ()
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
    self:get("BoxComponent").selected = selected
    self:add(PositionComponent(x, y))
    table.insert(stack:current().boxes, self)
end