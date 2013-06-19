PauseState = class("PauseState", State)

function PauseState:__init()
    self.menulist = {"Main Menu", "Resume", "Exit"}
end

function PauseState:load()
    self.flag = true
    self.index = 2
    self.shades = 250
    self.runner = -0.5
end

function PauseState:update(dt)
    if self.flag == true and self.shades > 100 then
        self.shades = self.shades - dt * 280
    elseif self.flag == false then
        self.shades = self.shades + dt * 380
        if self.shades > 255 then
            self.shades = 255
        end
    end
    if self.flag == true and self.runner < 1 then
        self.runner = self.runner + dt*3
        if self.runner > 1 then
            self.runner = 1
        end
    elseif self.flag == false then
        self.runner = self.runner - dt*5
    end
    if self.shades > 250 and self.runner < -0.4 then 
        stack:pop()
    end
end

function PauseState:draw()
    love.graphics.setColor(255, 255, 255, self.shades)
    love.graphics.draw(screenshot, 0, 0)

    love.graphics.setColor(255, 255, 255, 255)
    for i, v in pairs(self.menulist) do
        local scroll = i * 80 +20
        if i == self.index then
            love.graphics.setFont(resources.fonts.forty)
            love.graphics.print(v, 120, scroll*self.runner)
        else
            love.graphics.setFont(resources.fonts.thirty)
            love.graphics.print(v, 120, scroll*self.runner)
        end
    end
    love.graphics.setFont(resources.fonts.thirty)
end

function PauseState:keypressed(key, unicode)
    if key == "up" or key == "w" then
        self.index = self.index -1
        if self.index < 1 then self.index = 3 end
    end
    if key == "down" or key == "s" then
        self.index = self.index + 1
        if self.index > 3 then self.index = 1 end
    end
    if key == "return" then
        if self.index == 1 then
            stack:pop()
            stack:pop()
            main:restart()
        elseif self.index == 2 then
            self.flag = false
        elseif self.index == 3 then
            love.event.quit()
        end
    end
end