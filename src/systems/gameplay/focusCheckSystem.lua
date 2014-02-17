FocusCheckSystem = class("FocusCheckSystem", System)

function FocusCheckSystem:update(dt)
    if not love.window.hasFocus() then
        local canvas = love.graphics.newScreenshot()
        local screenshot = love.graphics.newImage(canvas)
        stack:push(PauseState(screenshot))
    end
end