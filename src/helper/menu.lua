Menu = class("Menu")

function Menu:sortMenu(table)
    for index, box in pairs(table) do
        if index == 1 then
            box:get("BoxComponent").linked[1] = table[#table]
            box:get("BoxComponent").linked[2] = table[index+1]
        elseif index == #table then
            box:get("BoxComponent").linked[1] = table[index-1]
            box:get("BoxComponent").linked[2] = table[1]
        else
            box:get("BoxComponent").linked[1] = table[index-1]
            box:get("BoxComponent").linked[2] = table[index+1]
        end
    end
end

function Menu:sortItemMenu(table, length)
    for index, box in pairs(table) do
        if (index % length) == 0 then
            box:get("BoxComponent").linked[1] = table[index-1]
            box:get("BoxComponent").linked[2] = table[index-length+1]
        elseif (index % length) == 1 then
            box:get("BoxComponent").linked[1] = table[index+length-1]
            box:get("BoxComponent").linked[2] = table[index+1]
        else
            box:get("BoxComponent").linked[1] = table[index-1]
            box:get("BoxComponent").linked[2] = table[index+1]
        end
    end
end

function Menu:sortMenuVertical(table)
    for index, box in pairs(table) do
        if index == 1 then
            box:get("BoxComponent").linked[3] = table[#table]
            box:get("BoxComponent").linked[4] = table[index+1]
        elseif index == #table then
            box:get("BoxComponent").linked[3] = table[index-1]
            box:get("BoxComponent").linked[4] = table[1]
        else
            box:get("BoxComponent").linked[3] = table[index-1]
            box:get("BoxComponent").linked[4] = table[index+1]
        end
    end
end

function Menu:getSelectedBox()
    for index, value in pairs(stack:current().engine:getEntityList("BoxComponent")) do
        if value:get("BoxComponent").selected == true then 
            return value
        end
    end
end