title = {}

function title.load()
end

function title.draw()
   love.audio.play(title_s)
   love.graphics.setColor(60,190,35)
   love.graphics.printf("flash of insight", 0, 0, love.graphics.getWidth(), "center")
   love.graphics.printf("press enter to start", 0, 20, love.graphics.getWidth(), "center")
   love.graphics.setColor(255,255,255)
end

function title.update(dt)
end

function title.keypressed(key, unicode)
   if key == "return" then
      state = "game"
      game.load()
   end
end
