require("core/physicshelper")
require("core/resources")
require("core/state")
require("core/entity")
require("core/engine")
require("core/event")
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
require("systems/weapon/explosionSystem")

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

-- Other Components
require("components/explosionComponent")
require("components/timeComponent")
require("components/timerComponent")
require("components/damageComponent")

-- Models
require("models/shotmodel")
require("models/cutieModel")
require("models/grenadeModel")


MainState = class("MainState", State)

function MainState:__init()

end

function MainState:load()
    love.graphics.setFont(resources.fonts.default)
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*64, true)
    world:setCallbacks(beginContact, endContact)

    engine = Engine()
    engine:addListener("KeyPressed", MainKeySystem())
    engine:addListener("KeyPressed", PlayerControlSystem())
    engine:addListener("BeginContact", CollisionSelectSystem())
    engine:addListener("MousePressed", MainMousePressedSystem())
    engine:addListener("ExplosionEvent", ExplosionEventSystem())

    engine:addSystem(DrawableDrawSystem(), "draw")
    engine:addSystem(PolygonDrawSystem(), "draw")
    engine:addSystem(ParticleDrawSystem(), "draw")
    engine:addSystem(LifebarSystem(), "draw")
    
    engine:addSystem(MaxSpeedSystem(), "logic", 1)
    engine:addSystem(SideChangeSystem(), "logic", 2)
    engine:addSystem(PhysicsPositionSyncSystem(), "logic", 3)
    engine:addSystem(ParticleDeleteSystem(), "logic", 4)
    engine:addSystem(PlayerMoveSystem(), "logic", 5)
    engine:addSystem(EnemyTrackingSystem(), "logic", 6)
    engine:addSystem(SpeedLimitSystem(), "logic", 7)
    engine:addSystem(BleedingDetectSystem(), "logic", 8)
    self.wobbleSystem = engine:addSystem(WobbleSystem(), "logic", 9)
    self.dashingSystem = engine:addSystem(DashingSystem(), "logic", 10)
    engine:addSystem(CutieDeleteSystem(), "logic", 11)
    engine:addSystem(BodyDestroySystem(), "logic", 12)
    engine:addSystem(EnemySpawnSystem(), "logic", 13)
    engine:addSystem(ExplosionSystem(), "logic", 14)
    engine:addSystem(GrenadeRotationSystem(), "logic", 15)

    -- Background und Umgebungselemente
    self.bg = Entity()
    self.bg:addComponent(DrawableComponent(resources.images.level1, 0, 1, 1, 0, 0))
    self.bg:addComponent(PositionComponent(0, 0))
    self.bg:addComponent(ZIndex(1))
    engine:addEntity(self.bg) --]]

    -- Player erstellung
    playercutie = CutieModel(333, 520, resources.images.cutie1, 100)
    playercutie:addComponent(IsPlayer())
    engine:addEntity(playercutie)

    self.wall =  Entity()
    self.wall:addComponent(DrawablePolygonComponent(world, 500, 580, 1050, 10, "static", self.wall))
    engine:addEntity(self.wall)

    self.wall =  Entity()
    self.wall:addComponent(DrawablePolygonComponent(world, 500, -50, 1050, 0, "static", self.wall))
    engine:addEntity(self.wall)

    for i = 0, 4, 1 do 
        local y = 100 + 100 * i
        local xbreite = 200 + 100 * i 
        self.wall = Entity()
        self.wall:addComponent(DrawablePolygonComponent(world, 500, y, xbreite, 10, "static", self.wall))
        engine:addEntity(self.wall)
    end

    for i = 0, 1, 1 do
        local x = 20 + i * 960
        self.wall = Entity()
        self.wall:addComponent(DrawablePolygonComponent(world, x, 200, 10, 200, "static", self.wall))
        engine:addEntity(self.wall)
    end

    -- Slowmospeed
    self.worldspeed = 1;

    -- Shake Variablen
    self.nextShake = 1
    self.shakeX = 0
    self.shakeY = 0
    self.shaketimer = 0
end

function MainState:update(dt)
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
        screenshot = love.graphics.newImage(canvas)
        self.shaketimer = 0
        stack:push(gameover)
    end

    -- Update Functions
    engine:update(dt)
    world:update(dt)
end

function MainState:draw()
    -- Deklaration der lokalen Variablen
    local x, y = playercutie:getComponent("PositionComponent").x, playercutie:getComponent("PositionComponent").y
    local playercutiexv, playercutieyv = playercutie:getComponent("PhysicsComponent").body:getLinearVelocity()

    -- Zeichnen der Grafiken
    if self.shaketimer > 0 then love.graphics.translate(self.shakeX, self.shakeY) end

    engine:draw()

    -- Zeichnen der Schriftzüge
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print(string.format("%.2f ",x) ..  "    " .. "X-Vel: " .. string.format("%.2f ",playercutiexv) .. ", Y-Vel: " .. string.format("%.2f ",playercutieyv), 20, 20,0,1,1)
    love.graphics.print("Your Cutie´s life: " .. playercutie:getComponent("LifeComponent").life, 20, 40, 0, 1, 1)
end

function MainState:restart()
    world:destroy()
    for index, value in pairs(engine.entities) do
        engine:removeEntity(value)
    end
    self:__init()
end

function MainState:keypressed(key, u)
    engine:fireEvent(KeyPressed(key, u))
end


function MainState:mousepressed(x, y, button)
    engine:fireEvent(MousePressed(x, y, button))
end

--Collision function
function beginContact(a, b, coll)
    engine:fireEvent(BeginContact(a, b, coll))
end