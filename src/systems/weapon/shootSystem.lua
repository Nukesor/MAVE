ShootSystem = class("ShootSystem", System)

function ShootSystem:update(dt)
    for index, entity in pairs(self.targets) do
        if love.mouse.isDown("l") then
            -- Calls the funktion of the equiped item.
            if playercutie:getComponent("ItemComponent") then
                playercutie:getComponent("ItemComponent").use()
            end
        end
    end
end

function ShootSystem:getRequiredComponents()
    return {"IsPlayer"}
end