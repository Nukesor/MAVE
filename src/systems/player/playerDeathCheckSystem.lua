PlayerDeathCheckSystem = class("PlayerDeathCheckSystem", System)

function PlayerDeathCheckSystem:update()
	for index, entity in pairs(self.targets) do
		-- Checks if Playerlife is below 0, makes a screenshot and pushes the next state.
		if entity:getComponent("LifeComponent").life <= 0 then
			local canvas = love.graphics.newScreenshot()
	        local screenshot = love.graphics.newImage(canvas)
	        self.shaketimer = 0
	        gameover.screenshot = screenshot
	        stack:push(gameover)
	    end
	end
end

function PlayerDeathCheckSystem:getRequiredComponents()
	return {"IsPlayer"}
end