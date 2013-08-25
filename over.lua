over = {}

function over.load()
end

function over.draw()
   love.graphics.setColor(255,20,147)
   local scale = 3
   love.graphics.push()
   love.graphics.scale(scale, scale)
   love.graphics.printf("success!", 0, 30, love.graphics.getWidth()/scale, "center")
   scale = 2
   love.graphics.pop()
   love.graphics.push()
   love.graphics.scale(scale, scale)
   love.graphics.printf("you have completed the game!", 0, 90, love.graphics.getWidth()/scale, "center")
   love.graphics.printf("created by: apaneske", 0, 120, love.graphics.getWidth()/scale, "center")
   love.graphics.printf("press enter to get back to main menu", 0, 160, love.graphics.getWidth()/scale, "center")
   love.graphics.pop()
   love.graphics.setColor(255,255,255)
end

function over.keypressed(key, unicode)
   if key == "return" then
      state = "title"
      title.load()
   end
end
