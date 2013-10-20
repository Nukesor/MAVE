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

        --Gold decrease
        if gameplay.items[index] then
            gameplay.stats.gold = gameplay.stats.gold - gameplay.items[index].price
            gameplay.items[index].owned = true
        end
    end
end