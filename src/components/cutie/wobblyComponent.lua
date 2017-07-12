local WobblyComponent = Component.create("WobblyComponent");

function WobblyComponent:initialize(default)
    self.default = default * relation()
end

return WobblyComponent
