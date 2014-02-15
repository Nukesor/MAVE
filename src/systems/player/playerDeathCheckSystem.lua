PlayerDeathCheckSystem = class("PlayerDeathCheckSystem", System)

function PlayerDeathCheckSystem:update()
    for index, entity in pairs(self.targets) do
        -- Checks if Playerlife is below 0, makes a screenshot and pushes the next state.
        if entity:getComponent("LifeComponent").life <= 0 then
            local canvas = love.graphics.newScreenshot()
            local screenshot = love.graphics.newImage(canvas)
            self.shaketimer = 0
            stack:push(GameOverState(screenshot))
        end
    end
end

function PlayerDeathCheckSystem:requires()
    return {"IsPlayer"}
end