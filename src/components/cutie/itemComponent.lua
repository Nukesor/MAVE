ItemComponent = class("ItemComponent")

function ItemComponent:__init(name, owned, price, image, sx, sy, use, drawableEntity)
	self.item = item
    self.name = name
    self.owned = owned
    self.price = price
    self.image = image
    self.sx = sx
    self.sy = sy
    self.use = use
    self.drawableEntity = drawableEntity
end