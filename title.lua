title = {}

function title.load()
end

function title.draw()
   love.audio.play(title_s)
   love.graphics.draw(imgs["title"], love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, 3, 3, 50, 37)
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
