SelectState = class("SelectState", State)

function SelectState:__init()
    self.menupoints = {"Level 1","Level 2", "Shop","Main Menu"}
    self.index = 1
    self.runner = 0
    self.runner2 = 0
    self.font = resources.fonts.big
end

function SelectState:load()
    self.index = 1
    love.graphics.setFont(self.font)
end


function SelectState:update(dt)
    self.runner = self.runner + dt/10
    if self.runner > 0.1 then
        self.runner = -0.1
    end
    love.timer.sleep(0.05)
    self.wobble = 1 + math.abs(self.runner)
    self.runner2 = self.runner2 + dt/7
    if self.runner2 > 0.1 then
        self.runner2 = -0.1
    end
    self.yscale = 1 + math.abs(self.runner2)

    local mousex, mousey = love.mouse.getPosition()
    if (mousey > 450 ) and (mousey < 500) then
        if (mousex > 1) and (mousex < 1) then
            self.index = 1
        end
    end
end


function SelectState:draw()
    love.graphics.setColor(255, 255, 255)
    --love.graphics.draw(resources.images.arena)
    love.graphics.draw(resources.images.cutie3, love.graphics.getWidth()/2, 400, 0, 1, self.yscale, resources.images.cutie2:getWidth()/2, resources.images.cutie2:getHeight())
    love.graphics.print("Select a level or start SHOPPING", love.graphics.getWidth()/2 - resources.fonts.big:getWidth("Select a Level or start SHOPPING")/2, 50, 0, 1, 1, 0, 0)

    for i = 1, 4, 1 do
        local scale = 1
        local text = self.menupoints[i]
        local x = i*love.graphics.getWidth()/5
        if (i-1) == self.index then
            scale = self.wobble
        else
            scale = self.wobble*0.8
        end
        love.graphics.print(text, x, 450, 0, scale-0.25, scale, self.font:getWidth(text)/2, self.font:getHeight(text)/2)
    end
end


function SelectState:keypressed(key, u)
    if key == "right" or key ==  "d" then
        if self.index < 3 then
            self.index = self.index + 1
        elseif self.index == 3 then
            self.index = 0
        end
    elseif key == "left" or key == "a" then
        if self.index > 0 then
            self.index = self.index -1
        elseif self.index == 0 then
            self.index = 3
        end
    elseif key == "return" then
        if self.index == 0 then
            stack:push(main)
        elseif self.index == 1 then
            stack:push(main)
        elseif self.index == 2 then
            stack:push(shop)
        elseif self.index == 3 then
            stack:popload()
        end
    end
end
