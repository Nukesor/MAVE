local LifeComponent = Component.create("LifeComponent")

function LifeComponent:initialize(life)
    self.life = life
    self.maxlife = life
end

return LifeComponent
