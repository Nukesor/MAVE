require("core/helper")
require("core/system")

EnemySpawnSystem = class("EnemySpawnSystem", System)

function EnemySpawnSystem:__init()
    self.__super.__init(self)
	self.spawntimer = 0
	self.fire = false
end

function EnemySpawnSystem:update(dt)

    self.spawntimer = self.spawntimer + dt

    if self.spawntimer > 2 then 
        self.fire = true
    end

	if self.fire == true then
			local height = math.random(300, 500)
			local cutie
			cutie = CutieModel(0, height, resources.images.cutie2)
		    cutie:addComponent(IsEnemy())
		    engine:addEntity(cutie)
	end

	if self.fire == true then
        self.spawntimer = 0
        self.fire = false
    end
end

function EnemySpawnSystem:getRequiredComponents()
	return {}
end