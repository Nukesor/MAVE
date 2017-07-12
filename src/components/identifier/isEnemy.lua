local IsEnemy = Component.create("IsEnemy")

function IsEnemy:initialize()
    self.check = 0
    self.direction = nil
end

return IsEnemy
