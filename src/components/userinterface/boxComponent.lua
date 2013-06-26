BoxComponent = class("BoxComponent")

function BoxComponent:__init(width, height, linked, typ)
	self.width = width
	self.height = height
	self.selected = false
	self.linked = linked
	self.typ = typ
end