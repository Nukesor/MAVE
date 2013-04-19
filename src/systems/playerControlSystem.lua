require("core/helper")
require("core/system")

PlayerControlSystem = class("PlayerControlSystem", System)

function PlayerControlSystem:fireEvent(event)
	    -- Playercutie Jump
    if key == "s" or key == "down" then
        playercutie.getComponent("Physics").body:applyLinearImpulse(0, 1)
    --[[elseif key == "w" or key == "up" then
        self.jumpactive = 1
        if self.jumpcount > 0 then
            playercutie.getComponent("Physics").body:applyLinearImpulse(0, -6)
            self.jumpcount = self.jumpcount - 1
        end]]
    end
end