require("core/helper")

Particles = class("Particles")

function Particles:__init()
	
	self.hit = love.graphics.newParticleSystem (resources.images.blood1, 200)
	self.hit:setEmissionRate(100)
	self.hit:setSpeed(50, 100)
	self.hit:setGravity(300, 400)
	self.hit:setColors(170, 0, 0, 255, 136, 0, 0, 200)
	self.hit:setSizes(0.3, 0.2)
	self.hit:setPosition(0,0)
	self.hit:setLifetime(0.25) -- Zeit die der Partikelstrahl anhält
	self.hit:setParticleLife( 1, 1.5 ) -- setzt Lebenszeit in min-max
	-- self.hit:setOffset(x, y) Punkt um den der Partikel rotiert
	self.hit:setRotation(0, 360) -- Der Rotationswert des Partikels bei seiner Erstellung
	self.hit:setRadialAcceleration(200, 400)
	self.hit:setDirection(0)
	self.hit:setSpread(360)
	self.hit:stop()


	self.bleeding = love.graphics.newParticleSystem (resources.images.blood1, 200)
	self.bleeding:setEmissionRate(60)
	self.bleeding:setSpeed(30)
	self.bleeding:setGravity(300, 400)
	self.bleeding:setColors(170, 0, 0, 255, 136, 0, 0, 200)
	self.bleeding:setSizes(0.3, 0.2)
	self.bleeding:setPosition(0,0)
	self.bleeding:setLifetime(0.25)
	self.bleeding:setParticleLife( 2, 3 )
	self.bleeding:setRotation(0, 360)
	self.bleeding:setRadialAcceleration(200, 400)
	self.bleeding:setDirection(0)
	self.bleeding:setSpread(360)
	self.bleeding:stop()

end

function Particles:reset()
	self.hit:stop()
	self.bleeding:stop()
    self.hit:reset()
    self.bleeding:reset()
end