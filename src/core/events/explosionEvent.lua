require("core/helper")

ExplosionEvent = class("ExplosionEvent", Event)

function ExplosionEvent:__init(entity)
	self.entity = entity
end
