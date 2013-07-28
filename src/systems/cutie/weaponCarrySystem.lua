WeaponCarrySystem = class("WeaponCarrySystem", System)

-- Makes cuties carry the currently selected weapons
function WeaponCarrySystem:update() 
    for key, entity in pairs(self.targets) do
        local item = entity:getComponent("ItemComponent")
        local drawable = item.drawableEntity
        drawable:addComponent(DrawableComponent(item.image, 0, item.sx, item.sy, 0, 0))
        drawable:addComponent(entity:getComponent("PositionComponent"))
        drawable:addComponent(ZIndex(3))
    end
end

function WeaponCarrySystem:getRequiredComponents() 
    return {"ItemComponent", "PositionComponent"}
end