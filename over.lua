over = {}

function over.load()
end

function over.draw()
   love.graphics.setColor(190, 190, 45)
   love.graphics.printf("game done", 0, 0, love.graphics.getWidth(), "center")
   love.graphics.printf("press enter to get back to main menu", 0, 20, love.graphics.getWidth(), "center")
end

function over.keypressed(key, unicode)
   if key == "return" then
      state = "title"
      title.load()
   end
end
