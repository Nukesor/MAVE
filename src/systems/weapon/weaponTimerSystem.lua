WeaponTimerSystem = class("WeaponTimerSystem", System)

function WeaponTimerSystem:update(dt)
    for index, entity in pairs(self.targets) do 
        entity:getComponent("ItemComponent").counttimer = entity:getComponent("ItemComponent").counttimer - dt
    end
end


function WeaponTimerSystem:requires()
    return {"ItemComponent"}
end