intro = {}

function intro.load()
end

function intro.draw()
   love.graphics.setColor(255,20,147)
   local scale = 2
   love.graphics.push()
   love.graphics.scale(scale, scale)
   love.graphics.printf("move around with the arrow keys", 0, 30, love.graphics.getWidth()/scale, "center")
   love.graphics.printf("hold space for flashlight", 0, 60, love.graphics.getWidth()/scale, "center")
   love.graphics.printf("battery lasts 10 seconds", 0, 80, love.graphics.getWidth()/scale, "center")
   love.graphics.printf("press n for normal", 0, 120, love.graphics.getWidth()/scale, "center")
   love.graphics.printf("press e for easy", 0, 140, love.graphics.getWidth()/scale, "center")
   love.graphics.printf("esc will quit game", 0, 160, love.graphics.getWidth()/scale, "center")
   love.graphics.pop()
   love.graphics.setColor(255,255,255)
end

function intro.keypressed(key, unicode)
   if key == "n" then
      state = "game"
      gamemode = "normal"
      game.load()
   end
   if key == "e" then
      state = "game"
      gamemode = "easy"
   end
end
