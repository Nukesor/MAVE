require("lib/resources")
require("lib/state")
require("lovetoys/core/entity")
require("lovetoys/core/engine")
require("lovetoys/core/system")
require("lovetoys/core/eventManager")
require("lovetoys/core/collisionManager")

--Events
require("events/mousePressed")
require("events/keyPressed")
require("events/beginContact")
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

-- PhysicsCompoents
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
require("components/items/timeComponent")
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
    self.eventmanager:addListener("KeyPressed", MainKeySystem())
    self.eventmanager:addListener("KeyPressed", PlayerControlSystem())
    self.eventmanager:addListener("BeginContact", self.collisionmanager)
    self.eventmanager:addListener("MousePressed", MainMousePressedSystem())
    self.eventmanager:addListener("ExplosionEvent", ExplosionEventSystem())

    self.engine:addSystem(DrawableDrawSystem(), "draw")
    self.engine:addSystem(PolygonDrawSystem(), "draw")
    self.engine:addSystem(LifebarSystem(), "draw")
    self.engine:addSystem(StringDrawSystem(), "draw")
    self.engine:addSystem(ItemDrawSystem(), "draw")
    self.engine:addSystem(ParticleDrawSystem(), "draw")
    self.engine:addSystem(BloodUpDisplaySystem(), "draw")
    
    self.engine:addSystem(SideChangeSystem(), "logic")
    self.engine:addSystem(PhysicsPositionSyncSystem(), "logic")
    self.engine:addSystem(ParticleUpdateSystem(), "logic")
    self.engine:addSystem(PlayerMoveSystem(), "logic")
    self.engine:addSystem(EnemyTrackingSystem(), "logic")
    self.engine:addSystem(SpeedLimitSystem(), "logic")
    self.engine:addSystem(BleedingDetectSystem(), "logic")
    self.wobbleSystem = self.engine:addSystem(WobbleSystem(), "logic")
    self.dashingSystem = self.engine:addSystem(DashingSystem(), "logic")
    self.engine:addSystem(CutieDeleteSystem(), "logic")
    self.engine:addSystem(EnemySpawnSystem(), "logic")
    self.engine:addSystem(TimerExplosionSystem(), "logic")
    self.engine:addSystem(MineProximitySystem(), "logic")
    self.engine:addSystem(GrenadeRotationSystem(), "logic")
    self.engine:addSystem(BodyDestroySystem(), "logic")
    self.engine:addSystem(TimerSystem(), "logic")
    self.engine:addSystem(WeaponTimerSystem(), "logic")
    self.engine:addSystem(ShootSystem(), "logic")
    self.engine:addSystem(TimerShotDeletionSystem(), "logic")
    self.engine:addSystem(PlayerDeathCheckSystem(), "logic")


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
    bg:addComponent(DrawableComponent(resources.images.arena, 0, 1, 1, 0, 0))
    bg:addComponent(ZIndex(1))
    bg:addComponent(PositionComponent(0, 0))
    self.engine:addEntity(bg)

    -- Playercreation
    playercutie = CutieModel(0, 0, resources.images.cutie1, 100)
    playercutie:addComponent(IsPlayer())
    self.engine:addEntity(playercutie)

    local str = Entity()
    str:addComponent(StringComponent(resources.fonts.twenty, {255, 0, 0, 255}, "Player's life:  %i", {{playercutie:getComponent("LifeComponent"), "life"}}))
    str:addComponent(PositionComponent(10, 10))
    self.engine:addEntity(str)

    str = Entity()
    str:addComponent(StringComponent(resources.fonts.twenty, {255, 0, 0, 255}, "Blood:  %i", {{gameplay.stats, "blood"}}))
    str:addComponent(PositionComponent(love.graphics.getWidth()-100, 20))
    self.engine:addEntity(str)

    str = Entity()
    str:addComponent(StringComponent(resources.fonts.twenty, {255, 0, 0, 255}, "Kills:  %i", {{gameplay.stats, "kills"}}))
    str:addComponent(PositionComponent(love.graphics.getWidth()-100, 5))
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

function LevelState:keypressed(key, u)
    self.eventmanager:fireEvent(KeyPressed(key, u))
end


function LevelState:mousepressed(x, y, button)
    self.eventmanager:fireEvent(MousePressed(x, y, button))
end

--Collision function
function beginContact(a, b, coll)
    stack:current().eventmanager:fireEvent(BeginContact(a, b, coll))
end
