StackHelper = class("StackHelper")

function StackHelper:__init()
	self.states = {}
end

function StackHelper:current()
	if #self.states == 0 then return nil
	
	elseif #self.states > 0 then
		return self.states[#self.states]
	end
end

function StackHelper:push(element)
	if self:current() then self:current():shutdown() end
	table.insert(self.states, element)	
end


function StackHelper:pop()
	if self:current() then 
		table.remove(self.states, #self.states)
	end
end


function StackHelper:draw()
	if self:current() then self:current():draw() end
end


function StackHelper:update(dt)
	if self:current() then self:current():update(dt) end
end

function StackHelper:keypressed(key, u)
	if self:current() then self:current():keypressed(key, u)
	end
end