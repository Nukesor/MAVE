require("core/resources")
require("core/state")
require("core/entity")
require("core/engine")
require("core/system")

--Events
require("core/events/mousePressed")
require("core/events/keyPressed")
require("core/events/beginContact")
require("core/events/explosionEvent")

-- Draw Systems
require("systems/draw/drawableDrawSystem")
require("systems/draw/polygonDrawSystem")
require("systems/draw/lifebarSystem")
require("systems/draw/stringDrawSystem")
require("systems/draw/itemDrawSystem")

-- Particle Systems
require("systems/particle/particleDrawSystem")
require("systems/particle/particleDeleteSystem")

-- Physics Systems
require("systems/physic/speedLimitSystem")
require("systems/physic/maxSpeedSystem")
require("systems/physic/sideChangeSystem")
require("systems/physic/physicsPositionSyncSystem")
require("systems/physic/bodyDestroySystem")

--Weapon Systems
require("systems/weapon/grenadeRotationSystem")
require("systems/weapon/timerExplosionSystem")
require("systems/weapon/mineProximitySystem")

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

-- Pressed Event Systems
require("systems/pressedevent/mainKeySystem")
require("systems/pressedevent/playerControlSystem")
require("systems/pressedevent/mainMousePressedSystem")
-- Event Systems
require("systems/event/collisionSelectSystem")
require("systems/event/explosionEventSystem")

--GraphicComponents
require("components/graphic/drawableComponent")
require("components/graphic/drawablePolygonComponent")
require("components/graphic/zIndex")
require("components/graphic/stringComponent")

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
require("components/cutie/goldComponent")

--IdentifierComponents
require("components/identifier/isShot")
require("components/identifier/isPlayer")
require("components/identifier/isEnemy")
require("components/identifier/isGrenade")

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


LevelState = class("LevelState", State)

function LevelState:__init()

end

function LevelState:load()
    love.graphics.setFont(resources.fonts.twenty)
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*64, true)
    world:setCallbacks(beginContact, endContact)

    self.engine = Engine()
    self.engine:addListener("KeyPressed", MainKeySystem())
    self.engine:addListener("KeyPressed", PlayerControlSystem())
    self.engine:addListener("BeginContact", CollisionSelectSystem())
    self.engine:addListener("MousePressed", MainMousePressedSystem())
    self.engine:addListener("ExplosionEvent", ExplosionEventSystem())

    self.engine:addSystem(DrawableDrawSystem(), "draw")
    self.engine:addSystem(PolygonDrawSystem(), "draw")
    self.engine:addSystem(ParticleDrawSystem(), "draw")
    self.engine:addSystem(LifebarSystem(), "draw")
    self.engine:addSystem(StringDrawSystem(), "draw")
    self.engine:addSystem(ItemDrawSystem(), "draw")
    
    self.engine:addSystem(MaxSpeedSystem(), "logic", 1)
    self.engine:addSystem(SideChangeSystem(), "logic", 2)
    self.engine:addSystem(PhysicsPositionSyncSystem(), "logic", 3)
    self.engine:addSystem(ParticleDeleteSystem(), "logic", 4)
    self.engine:addSystem(PlayerMoveSystem(), "logic", 5)
    self.engine:addSystem(EnemyTrackingSystem(), "logic", 6)
    self.engine:addSystem(SpeedLimitSystem(), "logic", 7)
    self.engine:addSystem(BleedingDetectSystem(), "logic", 8)
    self.wobbleSystem = self.engine:addSystem(WobbleSystem(), "logic", 9)
    self.dashingSystem = self.engine:addSystem(DashingSystem(), "logic", 10)
    self.engine:addSystem(CutieDeleteSystem(), "logic", 11)
    self.engine:addSystem(BodyDestroySystem(), "logic", 12)
    self.engine:addSystem(EnemySpawnSystem(), "logic", 13)
    self.engine:addSystem(TimerExplosionSystem(), "logic", 14)
    self.engine:addSystem(MineProximitySystem(), "logic", 15)
    self.engine:addSystem(GrenadeRotationSystem(), "logic", 16 )

    -- Player creation
    playercutie = CutieModel(0, 0, resources.images.cutie1, 100)
    playercutie:addComponent(IsPlayer())
    self.engine:addEntity(playercutie)

    -- Background und Umgebungselemente
    self.bg = Entity()
    self.bg:addComponent(PositionComponent(0, 0))
    self.bg:addComponent(ZIndex(1))
    self.engine:addEntity(self.bg) 

    local string = Entity()
    string:addComponent(PositionComponent(20, 20))
    string:addComponent(StringComponent({"Your Cutie´s life: %s", playercutie:getComponent("LifeComponent").life}, resources.fonts.thirty))

    -- Slowmospeed
    self.worldspeed = 1;

    -- Shake Variablen
    self.nextShake = 1
    self.shakeX = 0
    self.shakeY = 0
    self.shaketimer = 0
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

    -- Spiel-Ende und Pushen des jeweiligen Gamestates
    if playercutie:getComponent("LifeComponent").life <= 0 then
        local canvas = love.graphics.newScreenshot()
        local screenshot = love.graphics.newImage(canvas)
        self.shaketimer = 0
        gameover.screenshot = screenshot
        stack:push(gameover)
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
    self.engine:fireEvent(KeyPressed(key, u))
end


function LevelState:mousepressed(x, y, button)
    self.engine:fireEvent(MousePressed(x, y, button))
end

--Collision function
function beginContact(a, b, coll)
    stack:current().engine:fireEvent(BeginContact(a, b, coll))
end