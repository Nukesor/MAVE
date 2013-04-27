require("core/helper")
require("core/physicshelper")
require("core/resources")
require("core/state")
require("core/entity")
require("core/engine")
require("core/event")
require("core/events/keyPressed")
require("core/events/beginContact")

-- Draw Systems
require("systems/particleDrawSystem")
require("systems/drawableDrawSystem")
require("systems/polygonDrawSystem")
require("systems/particleDrawSystem")
-- Upgrade Systems
require("systems/sideChangeSystem")
require("systems/physicsPositionSyncSystem")
require("systems/particleDeleteSystem")
require("systems/enemyTrackingSystem")
require("systems/speedLimitSystem")
require("systems/bleedingDetectSystem")
require("systems/shotDeleteSystem")
--CutieManipulation Upgrade Systems
require("systems/playerMoveSystem")
require("systems/wobbleSystem")
require("systems/maxSpeedSystem")
require("systems/dashingSystem")
require("systems/cutieDeleteSystem")
-- Event Systems
require("systems/mainKeySystem")
require("systems/collisionSelectSystem")
require("systems/playerControlSystem")
-- 
require("components/drawableComponent")
require("components/drawablePolygonComponent")
require("components/zIndex")
require("components/particleComponent")
require("components/timeComponent")
require("components/positionComponent")
-- Cutie Components
require("components/physicsComponent")
require("components/levelComponent")
require("components/lifeComponent")
require("components/cutieComponent")
require("components/wobblyComponent")
require("components/dashingComponent")
require("components/enemyComponent")

require("components/isShot")
require("components/isPlayer")
require("components/isEnemy")

-- Models
require("models/shotmodel")
require("models/cutieModel")


MainState = class("MainState", State)

function MainState:__init()
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*64, true)
    world:setCallbacks(beginContact, endContact)

    engine = Engine()
    engine:addListener("KeyPressed", MainKeySystem())
    engine:addListener("KeyPressed", PlayerControlSystem())
    engine:addListener("BeginContact", CollisionSelectSystem())

    engine:addSystem(DrawableDrawSystem(), "draw")
    engine:addSystem(PolygonDrawSystem(), "draw")
    engine:addSystem(ParticleDrawSystem(), "draw")
    
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
    engine:addSystem(ShotDeleteSystem(), "logic", 12)
 
    -- Player erstellung
    playercutie = CutieModel(333, 520, resources.images.cutie1)
    playercutie:addComponent(IsPlayer())
    engine:addEntity(playercutie)

    -- Background und Umgebungselemente
    self.bg = Entity()
    self.bg:addComponent(DrawableComponent(resources.images.arena, 0, 1, 1, 0, 0))
    self.bg:addComponent(PositionComponent(0, 0))
    self.bg:addComponent(ZIndex(1))
    engine:addEntity(self.bg)

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

    --Temporärer Cutie
    cutie = CutieModel(666, 520, resources.images.cutie2)
    cutie:addComponent(IsEnemy())
    cutie:addComponent(EnemyComponent())
    engine:addEntity(cutie)

end

function MainState:load()
   love.graphics.setFont(resources.fonts.default)
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


function MainState:mousepressed(x, y, key)
    if key == "r" and not playercutie:getComponent("DashingComponent") then
        local xBefore, yBefore = playercutie:getComponent("PhysicsComponent").body:getPosition()
        playercutie:addComponent(DashingComponent({x=xBefore, y=yBefore}, {x=x, y=y}))
    elseif key == "r" and playercutie:getComponent("DashingComponent") then
        playercutie:removeComponent("DashingComponent")
    end
end

--Collision function
function beginContact(a, b, coll)
    engine:fireEvent(BeginContact(a, b, coll))
end