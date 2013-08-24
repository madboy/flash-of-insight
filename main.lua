debug = false

require('title')
require('game')

function love.load()
   imgf = {"game_font_15"}
   imgs = {}
   for _,v in ipairs(imgf) do
      imgs[v] = love.graphics.newImage("assets/"..v..".png")
   end
   for _,v in ipairs(imgs) do
      v:setFilter("nearest", "nearest")
   end

   font = love.graphics.newImageFont(imgs["game_font_15"], "abcdefghijklmnopqrstuvwxyz,.!:;?1234567890 \"")
   love.graphics.setFont(font)
   
   state = 'title'
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
   elseif state == "game" then
      game.keypressed(key, unicode)
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
   elseif state == "game" then
      game.draw()
   end
end
