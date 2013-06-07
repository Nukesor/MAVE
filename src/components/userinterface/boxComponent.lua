BoxComponent = class("BoxComponent")

function BoxComponent:__init(width, height, linked, func, typ, string)
	self.width = width
	self.height = height
	self.selected = false
	self.linked = linked
	self.func = func
	self.string = string
	self.pic = pic
	self.typ = typ
end