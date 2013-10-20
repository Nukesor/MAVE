BoxComponent = class("BoxComponent")

function BoxComponent:__init(width, height, linked, typ, image, xscale)
    self.width = width * relation()
    self.height = height * relation()
    self.selected = false
    self.linked = linked
    self.typ = typ
    if image then
        self.image = image
        self.scale = xscale
    end
end