
function love.conf(t)
    if love.filesystem.exists("save.lua") then
        chunk = love.filesystem.load("save.lua")
        chunk()
    end
    t.title = "The Most Adorable Violence Ever"        -- The title of the window the game is in (string)
    t.author = "Nukesor"        -- The author of the game (string)
    t.url = nil                 -- The website of the game (string)
    t.identity = nil            -- The name of the save directory (string)
    t.version = "0.8.0"         -- The LÖVE version this game was made for (string)
    t.console = false           -- Attach a console (boolean, Windows only)
    t.release = false           -- Enable release mode (boolean)
    if asdf then
        t.screen.width = asdf.resolution[1]
        t.screen.height = asdf.resolution[2]
        t.screen.fullsceen = asdf.fullscreen
    else
        t.screen.width = 1366       -- The window width (number)
        t.screen.height = 768       -- The window height (number)
        t.screen.fullscreen = false -- Enable fullscreen (boolean)
    end
    t.screen.vsync = true       -- Enable vertical sync (boolean)
    t.screen.fsaa = 0           -- The number of FSAA-buffers (number)
    t.modules.joystick = true   -- Enable the joystick module (boolean)
    t.modules.audio = true      -- Enable the audio module (boolean)
    t.modules.keyboard = true   -- Enable the keyboard module (boolean)
    t.modules.event = true      -- Enable the event module (boolean)
    t.modules.image = true      -- Enable the image module (boolean)
    t.modules.graphics = true   -- Enable the graphics module (boolean)
    t.modules.timer = true      -- Enable the timer module (boolean)
    t.modules.mouse = true      -- Enable the mouse module (boolean)
    t.modules.sound = true      -- Enable the sound module (boolean)
    t.modules.physics = true    -- Enable the physics module (boolean)
end