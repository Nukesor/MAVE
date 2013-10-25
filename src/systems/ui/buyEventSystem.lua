BuyEventSystem = class("BuyEventSystem", System)

function BuyEventSystem:fireEvent(event)
    if event.boolean == true then
        -- Find selected box and Index for weapon identification.
        local box = getSelectedBox()
        local index
        for i, v in pairs(stack:current().boxes) do
            if v == box then
                index = i 
            end
        end

        --Blood decrease and Item marked as owned
        if gameplay.items[index] then
            gameplay.stats.blood = gameplay.stats.blood - gameplay.items[index].price
            gameplay.items[index].owned = true
            saveGame()
        end
    end
end