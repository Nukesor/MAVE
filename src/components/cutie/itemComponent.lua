ItemComponent = class("ItemComponent")

function ItemComponent:__init(id, name, owned, price, image, sx, sy, timer, use)
    self.item = item
    self.name = name
    self.owned = owned
    self.price = price
    self.image = image
    self.sx = sx * relation()
    self.sy = sy * relation()
    self.timer = timer
    self.counttimer = timer
    self.use = use
    self.id = id
end