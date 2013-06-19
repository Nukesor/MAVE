require("core/class")

ExplosionEvent = class("ExplosionEvent", Event)

function ExplosionEvent:__init(entity)
    self.__super.__init(self, self.__name)
    self.entity = entity
end
