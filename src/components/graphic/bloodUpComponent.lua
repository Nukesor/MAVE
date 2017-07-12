local BloodUpComponent = Component.create("BloodUpComponent")

function BloodUpComponent:initialize(blood)
    self.blood = blood
    self.transparency = 255
end

return BloodUpComponent
