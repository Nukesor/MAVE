BoxComponent = class("BoxComponent")

function BoxComponent:__init(width, height, linked, typ)
    self.width = width * relation()
    self.height = height * relation()
    self.selected = false
    self.linked = linked
    self.typ = typ
end