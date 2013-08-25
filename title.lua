title = {}

function title.load()
end

function title.draw()
   love.audio.play(title_s)
   local scale = 3
   love.graphics.draw(imgs["title"], love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, scale, scale, imgs["title"]:getWidth()/2, imgs["title"]:getHeight()/2)
   love.graphics.setColor(255,20,147)
   love.graphics.printf("press enter to continue", 0, 500, love.graphics.getWidth(), "center")
   love.graphics.setColor(255,255,255)
end

function title.update(dt)
end

function title.keypressed(key, unicode)
   if key == "return" then
      state = "intro"
   end
end
