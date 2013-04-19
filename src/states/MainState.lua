require("core/helper")
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
--CutieManipulation Upgrade Systems
require("systems/playerMoveSystem")
require("systems/wobbleSystem")
require("systems/maxSpeedSystem")
require("systems/dashingSystem")
-- Event Systems
require("systems/mainKeySystem")
require("systems/collisionSelectSystem")
require("systems/playerControlSystem")
-- 
require("components/drawable")
require("components/drawablePolygon")
require("components/zIndex")
require("components/particleComponent")
require("components/position")
-- Cutie Components
require("components/physics")
require("components/level")
require("components/life")
require("components/cutieComponent")
require("components/wobbly")
require("components/dashing")
require("components/isPlayer")
require("components/isEnemy")
require("components/enemyComponent")

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

    engine:addSystem(DrawableDrawSystem(), "draw")
    engine:addSystem(PolygonDrawSystem(), "draw")
    engine:addSystem(ParticleDrawSystem(), "draw")
    
    engine:addSystem(MaxSpeedSystem(), "logic")
    engine:addSystem(SideChangeSystem(), "logic")
    engine:addSystem(PhysicsPositionSyncSystem(), "logic")
    engine:addSystem(ParticleDeleteSystem(), "logic")
    engine:addSystem(PlayerMoveSystem(), "logic")
    engine:addSystem(EnemyTrackingSystem(), "logic")
    engine:addSystem(SpeedLimitSystem(), "logic")
    CollisionSelectSystem()
    self.wobbleSystem = engine:addSystem(WobbleSystem(), "logic")
    self.dashingSystem = engine:addSystem(DashingSystem(), "logic")
 
    -- Player erstellung
    playercutie = CutieModel(333, 520, resources.images.cutie1)
    playercutie:addComponent(IsPlayer())
    engine:addEntity(playercutie)

    -- Background und Umgebungselemente
    self.bg = Entity()
    self.bg:addComponent(Drawable(resources.images.arena, 0, 1, 1, 0, 0))
    self.bg:addComponent(Position(0, 0))
    self.bg:addComponent(ZIndex(1))
    engine:addEntity(self.bg)

    self.wall =  Entity()
    self.wall:addComponent(DrawablePolygon(world, 500, 580, 1050, 10, "static", self.wall))
    engine:addEntity(self.wall)

    self.wall =  Entity()
    self.wall:addComponent(DrawablePolygon(world, 500, -50, 1050, 0, "static", self.wall))
    engine:addEntity(self.wall)

    for i = 0, 4, 1 do 
        local y = 100 + 100 * i
        local xbreite = 200 + 100 * i 
        self.wall = Entity()
        self.wall:addComponent(DrawablePolygon(world, 500, y, xbreite, 10, "static", self.wall))
        engine:addEntity(self.wall)
    end

    for i = 0, 1, 1 do
        local x = 20 + i * 960
        self.wall = Entity()
        self.wall:addComponent(DrawablePolygon(world, x, 200, 10, 200, "static", self.wall))
        engine:addEntity(self.wall)
    end

    -- Slowmospeed
    self.worldspeed = 1;

    -- Shake Variablen
    self.nextShake = 1
    self.shakeX = 0
    self.shakeY = 0
    self.shaketimer = 0

    -- Temporärer Cutie
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
    if playercutie:getComponent("Life").life <= 0 then
        self.shaketimer = 0
        stack:push(gameover)
    end

    -- Update Functions
    engine:update(dt)
	world:update(dt)
end

function MainState:draw()
    -- Deklaration der lokalen Variablen
    local x, y = playercutie:getComponent("Position").x, playercutie:getComponent("Position").y
    local playercutiexv, playercutieyv = playercutie:getComponent("Physics").body:getLinearVelocity()
    local cutie2xv, cutie2yv =  cutie:getComponent("Physics").body:getLinearVelocity()

    -- Zeichnen der Grafiken
    if self.shaketimer > 0 then love.graphics.translate(self.shakeX, self.shakeY) end

    engine:draw()

    -- Zeichnen der Schriftzüge
    love.graphics.print(string.format("%.2f ",x) ..  "    " .. "X-Vel: " .. string.format("%.2f ",playercutiexv) .. ", Y-Vel: " .. string.format("%.2f ",playercutieyv), 20, 20,0,1,1)
    love.graphics.print("Your Cutie´s life: " .. playercutie:getComponent("Life").life, 20, 40, 0, 1, 1)
end

function MainState:restart()
end

function MainState:reset()
end


function MainState:shutdown()
	world:destroy()
end

function MainState:keypressed(key, u)

    engine:fireEvent(KeyPressed(key, u))
end


function MainState:mousepressed(x, y, key)
    if key == "r" and not playercutie:getComponent("Dashing") then
        local xVelBefore, yVelBefore = playercutie:getComponent("Physics").body:getLinearVelocity()
        local xBefore, yBefore = playercutie:getComponent("Physics").body:getPosition()
        playercutie:addComponent(Dashing({x=xVelBefore, y=yVelBefore}, {x=xBefore, y=yBefore}, {x=x, y=y}))
    elseif key == "r" and playercutie:getComponent("Dashing") then
        playercutie:removeComponent("Dashing")
    end
end

--Collision function
function beginContact(a, b, coll)
    engine:fireEvent(BeginContact(a, b, coll))
end
 --[[   local mainstate = self
    return function(a, b, coll)

        local object1 = a:getUserData()[1]
        local object1Entity = a:getUserData()[2]
        local object2 = b:getUserData()[1]
        local object2Entity = b:getUserData()[2]
        mainstate.collisionSystem:beginContact(a, b, coll)
        mainstate.wobbleSystem:beginContact(a, b, coll)
        
        if object1 and object2 then
            if (object1.__name == "Playercutie" or object1.__name == "Cutie") and (object2.__name == "Playercutie" or object2.__name == "Cutie") then
                love.audio.play(resources.sounds.bounce1)
            end

            -- Bei Zusammentreffen von Cutie/Playercutie mit Shot, wird 20 schaden übermittelt und Shot zerstört
            if ((object1.__name == "Shot" or object1.__name == "Cutie") and (object2.__name == "Shot" or object1.__name == "Cutie")) then
                if object1.__name == "Cutie" then
                    object1:loseLife(20)
                elseif object2.__name == "Cutie" then
                    object2:loseLife(20)
                end
                if object1.__name == "Shot" then
                    object1:shutdown()
                elseif object2.__name == "Shot" then
                    object2:shutdown()
                end
            elseif ((object1.__name == "Shot" or object1.__name == "Playercutie") and (object2.__name == "Shot" or object2.__name == "Playercutie")) then
                if object1.__name == "Playercutie" then
                    object1:loseLife(20)
                elseif object2.__name == "Playercutie" then
                    object2:loseLife(20)
                end
                if object1.__name == "Shot" then
                    object1:shutdown()
                elseif object2.__name == "Shot" then
                    object2:shutdown()
                end
            -- Bei auftreffen mit DrawablePolygon wird Shot zerstört
            elseif ((object1.__name == "Shot" or object1.__name == "DrawablePolygon") and (object2.__name == "DrawablePolygon" or object2.__name == "Shot")) then
                if object1.__name == "Shot" then
                    object1:shutdown()
                 elseif object2.__name == "Shot" then
                    object2:shutdown()
                end
            end

            -- Hüpfen der Cuties auf einem bestimmten Level
            if (( object1.__name == "DrawablePolygon" or object1.__name == "Cutie") and (object2.__name == "Cutie" or object2.__name == "DrawablePolygon")) then
                cutie2.jumpcount = 4
                if object1.__name == "Cutie" then
                    local cutiexv, cutieyv = object1.body:getLinearVelocity()
                    object1.body:setLinearVelocity(cutiexv, -200)
                elseif object2.__name == "Cutie" then
                    local cutiexv, cutieyv = object2.body:getLinearVelocity()
                    object2.body:setLinearVelocity(cutiexv, -200)
                end
            end

            -- Hüpfen des Playercuties auf einem bestimmten Level
            if (( object1.__name == "DrawablePolygon" or object1.__name == "Playercutie") and (object2.__name == "Playercutie" or object2.__name == "DrawablePolygon")) then
                playercutie.jumpcount = 2
                if object1.__name == "Playercutie" then
                    local playercutiexv, playercutieyv = object1.body:getLinearVelocity()
                    object1.body:setLinearVelocity(playercutiexv, -200)
                elseif object2.__name == "Playercutie" then
                    local playercutiexv, playercutieyv = object2.body:getLinearVelocity()
                    object2.body:setLinearVelocity(playercutiexv, -200)
                end
            end
        end
    end]]
