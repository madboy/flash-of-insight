intro = {}

function intro.load()
end

function intro.draw()
   love.graphics.setColor(255,20,147)
   local scale = 2
   love.graphics.push()
   love.graphics.scale(scale, scale)
   love.graphics.printf("move around with the arrow keys", 0, 30, love.graphics.getWidth()/scale, "center")
   love.graphics.printf("turn on flashligt with space", 0, 60, love.graphics.getWidth()/scale, "center")
   love.graphics.printf("press enter to continue", 0, 120, love.graphics.getWidth()/scale, "center")
   love.graphics.pop()
   love.graphics.setColor(255,255,255)
end

function intro.keypressed(key, unicode)
   if key == "return" then
      state = "game"
      game.load()
   end
end
