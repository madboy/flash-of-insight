debug = false

require("title")
require("game")
require("over")
require("intro")

function love.load()
   imgf = {"game_font_15", "player", "title", "exit", "floor","battery_1", "battery_2", "battery_3", "battery_4", "battery_5", "battery_6", "battery_7", "battery_8", "battery_9", "battery_10", "battery_11"}
   imgs = {}
   for _,v in ipairs(imgf) do
      imgs[v] = love.graphics.newImage("assets/"..v..".png")
   end
   for _,v in ipairs(imgs) do
      v:setFilter("nearest", "nearest")
   end

   font = love.graphics.newImageFont(imgs["game_font_15"], "abcdefghijklmnopqrstuvwxyz,.!:;?1234567890 \"")
   love.graphics.setFont(font)

   wall_s = love.audio.newSource("assets/wall.ogg", "static")
   exit_s = love.audio.newSource("assets/exit.ogg", "static")
   border_s = love.audio.newSource("assets/border.ogg", "static")
   title_s = love.audio.newSource("assets/title.ogg", "stream")
   title_s:setLooping(true)
   
   state = "title"
   gamemode = "normal"

   title.load()
   intro.load()
   game.load()
   over.load()
end

function love.keypressed(key, unicode)
   if key == "escape" then
      love.event.push("quit")
   end
   if key == "`" then
      debug = not debug
   end
   if state == "title" then
      title.keypressed(key, unicode)
   elseif state == "intro" then
      intro.keypressed(key, unicode)
   elseif state == "game" then
      game.keypressed(key, unicode)
   elseif state == "over" then
      over.keypressed(key, unicode)
   end
end

function love.keyreleased(key, unicode)
   if state == "game" then
      game.keyreleased(key, unicode)
   end
end

function love.update(dt)
   if state == "title" then
      title.update(dt)
   elseif state == "game" then
      game.update(dt)
   end
end

function love.draw()
   if state == "title" then
      title.draw()
   elseif state == "intro" then
      intro.draw()
   elseif state == "game" then
      game.draw()
   elseif state == "over" then
      over.draw()
   end
end
