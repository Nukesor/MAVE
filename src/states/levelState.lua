require("core/resources")
require("core/state")

--Events
require("events/mousePressed")
require("events/mouseReleased")
require("events/keyPressed")
require("events/explosionEvent")

-- Draw Systems
require("systems/draw/drawableDrawSystem")
require("systems/draw/polygonDrawSystem")
require("systems/draw/lifebarSystem")
require("systems/draw/stringDrawSystem")
require("systems/draw/itemDrawSystem")
require("systems/draw/bloodUpDisplaySystem")

-- Particle Systems
require("systems/particle/particleDrawSystem")
require("systems/particle/particleUpdateSystem")
require("systems/particle/particlePositionSyncSystem")

-- Physics Systems
require("systems/physic/speedLimitSystem")
require("systems/physic/sideChangeSystem")
require("systems/physic/physicsPositionSyncSystem")
require("systems/physic/bodyDestroySystem")
require("systems/physic/timerSystem")

--Weapon Systems
require("systems/weapon/grenadeRotationSystem")
require("systems/weapon/timerExplosionSystem")
require("systems/weapon/timerShotDeletionSystem")
require("systems/weapon/mineProximitySystem")
require("systems/weapon/shootSystem")
require("systems/weapon/weaponTimerSystem")

-- Logic Gameplay Systems

require("systems/gameplay/focusCheckSystem")

--CutieManipulation Upgrade Systems
        --Cutie
require("systems/cutie/wobbleSystem")
require("systems/cutie/cutieDeleteSystem")
require("systems/cutie/bleedingDetectSystem")
        --Enemy
require("systems/enemy/enemySpawnSystem")
require("systems/enemy/enemyTrackingSystem")
        --Player
require("systems/player/playerMoveSystem")
require("systems/player/dashingSystem")
require("systems/player/playerDeathCheckSystem")

-- Pressed Event Systems
require("systems/pressedevent/mainKeySystem")
require("systems/pressedevent/playerControlSystem")
require("systems/pressedevent/mainMousePressedSystem")
-- Event Systems
require("systems/event/explosionEventSystem")

--GraphicComponents
require("components/graphic/drawableComponent")
require("components/graphic/drawablePolygonComponent")
require("components/graphic/zIndex")
require("components/graphic/stringComponent")
require("components/graphic/bloodUpComponent")

-- Particle Component
require("components/particle/particleComponent")
require("components/particle/particleTimerComponent")

-- PhysicsComponents
require("components/physic/physicsComponent")
require("components/physic/positionComponent")
require("components/physic/destroyComponent")

-- Cutie Components
require("components/cutie/levelComponent")
require("components/cutie/lifeComponent")
require("components/cutie/cutieComponent")
require("components/cutie/wobblyComponent")
require("components/cutie/dashingComponent")
require("components/cutie/enemyComponent")
require("components/cutie/itemComponent")
require("components/cutie/bloodComponent")

--IdentifierComponents
require("components/identifier/isShot")
require("components/identifier/isPlayer")
require("components/identifier/isEnemy")
require("components/identifier/isGrenade")
require("components/identifier/isRocket")


-- Item Components
require("components/items/explosionComponent")
require("components/items/timerComponent")
require("components/items/damageComponent")
require("components/items/proximityExplodeComponent")

-- Models
require("models/shotmodel")
require("models/cutieModel")
require("models/grenadeModel")
require("models/mineModel")
require("models/rocketModel")


-- Collisions

require("collisions/bounceCollision")
require("collisions/collisionDamage")
require("collisions/shotCutieCollision")
require("collisions/shotWallCollision")
require("collisions/explosionShotCollision")
require("collisions/mineGroundCollision")
require("collisions/rocketCollision")


LevelState = class("LevelState", State)

function LevelState:__init()

end

function LevelState:load()
    love.graphics.setFont(resources.fonts.twenty)
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*80, true)
    world:setCallbacks(beginContact, endContact)

    self.engine = Engine()
    self.eventmanager = EventManager()
    self.collisionmanager = CollisionManager()
    local mainkey = MainKeySystem()
    local mainmouse = MainMousePressedSystem()
    local explosion = ExplosionEventSystem()
    local playercontrol = PlayerControlSystem()
    local wobblesystem = WobbleSystem()
    self.eventmanager:addListener("KeyPressed", {mainkey, mainkey.fireEvent})
    self.eventmanager:addListener("KeyPressed", {playercontrol, playercontrol.fireEvent})
    self.eventmanager:addListener("BeginContact", {self.collisionmanager, self.collisionmanager.fireEvent})
    self.eventmanager:addListener("BeginContact", {wobblesystem, wobblesystem.fireEvent})
    self.eventmanager:addListener("MousePressed", {mainmouse, mainmouse.fireEvent})
    self.eventmanager:addListener("ExplosionEvent", {explosion, explosion.fireEvent})

    self.engine:addSystem(DrawableDrawSystem(), "draw", 1)
    self.engine:addSystem(PolygonDrawSystem(), "draw", 2)
    self.engine:addSystem(LifebarSystem(), "draw", 3)
    self.engine:addSystem(StringDrawSystem(), "draw", 4)
    self.engine:addSystem(ItemDrawSystem(), "draw", 5)
    self.engine:addSystem(ParticleDrawSystem(), "draw", 6)
    self.engine:addSystem(BloodUpDisplaySystem(), "draw", 7)
    
    self.engine:addSystem(SideChangeSystem(), "logic", 1)
    self.engine:addSystem(PhysicsPositionSyncSystem(), "logic", 2)
    self.engine:addSystem(ParticlePositionSyncSystem(), "logic", 3)
    self.engine:addSystem(ParticleUpdateSystem(), "logic", 4)
    self.engine:addSystem(PlayerMoveSystem(), "logic", 5)
    self.engine:addSystem(EnemyTrackingSystem(), "logic", 6)
    self.engine:addSystem(SpeedLimitSystem(), "logic", 7)
    self.engine:addSystem(BleedingDetectSystem(), "logic", 8)
    self.wobbleSystem = self.engine:addSystem(wobblesystem, "logic", 9)
    self.dashingSystem = self.engine:addSystem(DashingSystem(), "logic", 10)
    self.engine:addSystem(CutieDeleteSystem(), "logic", 11)
    self.engine:addSystem(EnemySpawnSystem(), "logic", 12)
    self.engine:addSystem(TimerExplosionSystem(), "logic", 13)
    self.engine:addSystem(MineProximitySystem(), "logic", 14)
    self.engine:addSystem(GrenadeRotationSystem(), "logic", 15)
    self.engine:addSystem(BodyDestroySystem(), "logic", 16)
    self.engine:addSystem(TimerSystem(), "logic", 17)
    self.engine:addSystem(WeaponTimerSystem(), "logic", 18)
    self.engine:addSystem(ShootSystem(), "logic", 19)
    self.engine:addSystem(TimerShotDeletionSystem(), "logic", 20)
    self.engine:addSystem(PlayerDeathCheckSystem(), "logic", 21)
    self.engine:addSystem(FocusCheckSystem(), "logic", 22)


    -- Adding Collisions to CollisionManager

    local bounce = BounceCollision()
    self.collisionmanager:addCollisionAction(bounce.component1, bounce.component2, bounce)
    local damage = CollisionDamage()
    self.collisionmanager:addCollisionAction(damage.component1, damage.component2, damage)
    local shotcutie = ShotCutieCollision()
    self.collisionmanager:addCollisionAction(shotcutie.component1, shotcutie.component2, shotcutie)
    local shotwall = ShotWallCollision()
    self.collisionmanager:addCollisionAction(shotwall.component1, shotwall.component2, shotwall)
    local shotexplosive = ExplosionShotCollision()
    self.collisionmanager:addCollisionAction(shotexplosive.component1, shotexplosive.component2, shotexplosive)
    local mineground = MineGroundCollision()
    self.collisionmanager:addCollisionAction(mineground.component1, mineground.component2, mineground)
    local rocketcollision = RocketCollision()
    self.collisionmanager:addCollisionAction(rocketcollision.component1, rocketcollision.component2, rocketcollision)
    

    -- Slowmospeed
    self.worldspeed = 1;

    -- Shake Variablen
    self.nextShake = 1
    self.shakeX = 0
    self.shakeY = 0
    self.shaketimer = 0

    local bg = Entity()
    bg:add(DrawableComponent(resources.images.level2, 0, 1, 1, 0, 0))
    bg:add(ZIndex(1))
    bg:add(PositionComponent(0, 0))
    self.engine:addEntity(bg)

    -- Playercreation
    local playercutie = CutieModel(0, 0, resources.images.cutie1, 100)
    playercutie:add(IsPlayer())
    playercutie:get("PhysicsComponent").fixture:setFilterData(9, 3, 10)
    self.engine:addEntity(playercutie)

    local str = Entity()
    str:add(StringComponent(resources.fonts.thirty, {255, 0, 0, 255}, "Player's life:  %i", {{playercutie:get("LifeComponent"), "life"}}))
    str:add(PositionComponent(love.graphics.getWidth()*0.005, love.graphics.getHeight()*0.01))
    self.engine:addEntity(str)

    str = Entity()
    str:add(StringComponent(resources.fonts.thirty, {255, 0, 0, 255}, "Blood:  %i", {{gameplay.stats, "blood"}}))
    str:add(PositionComponent(love.graphics.getWidth()*0.9, love.graphics.getHeight()*0.02))
    self.engine:addEntity(str)

    str = Entity()
    str:add(StringComponent(resources.fonts.thirty, {255, 0, 0, 255}, "Kills:  %i", {{gameplay.stats, "kills"}}))
    str:add(PositionComponent(love.graphics.getWidth()*0.9, love.graphics.getHeight()*0.005))
    self.engine:addEntity(str)

end

function LevelState:update(dt)
    -- Slowmotion
    dt = dt*self.worldspeed
    if love.keyboard.isDown(" ") and self.worldspeed > 0.2 then
        self.worldspeed = self.worldspeed -0.03
    elseif not love.keyboard.isDown(" ") and self.worldspeed < 1 then
        self.worldspeed = self.worldspeed + 0.03
    end

    -- Camerashake
    if self.shaketimer > 0 then
        self.nextShake = self.nextShake - (dt*50)
        if self.nextShake < 0 then
            self.nextShake = 1
            self.shakeX = math.random(-10, 10)
            self.shakeY = math.random(-10, 10)
        end
        self.shaketimer = self.shaketimer - dt
    end

    -- Update Functions
    self.engine:update(dt)
    world:update(dt)
end

function LevelState:draw()
    -- Zeichnen der Grafiken
    if self.shaketimer > 0 then love.graphics.translate(self.shakeX, self.shakeY) end

    self.engine:draw()
end

function LevelState:restart()
    world:destroy()
    for index, value in pairs(self.engine.entities) do
        self.engine:removeEntity(value)
    end
    self:__init()
end

function LevelState:keypressed(key, isrepeat)
    self.eventmanager:fireEvent(KeyPressed(key, isrepeat))
end

function LevelState:mousereleased(x, y, button)
    self.eventmanager:fireEvent(MouseReleased(x, y, button))
end

function LevelState:mousepressed(x, y, button)
    self.eventmanager:fireEvent(MousePressed(x, y, button))
end

--Collision function
function beginContact(a, b, coll)
    stack:current().eventmanager:fireEvent(BeginContact(a, b, coll))
end
