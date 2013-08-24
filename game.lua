game = {}

function game.load()
   game.clock = 10
   
   game.pw = 10
   game.px = 100
   game.py = 100

   game.br = 0
   game.bg = 0
   game.bb = 0

   game.exitw = 20
   game.exitx = 300 - game.exitw
   game.exity = 200 - game.exitw
end

function game.draw()
   love.graphics.setBackgroundColor(game.br, game.bg, game.bb)
   love.graphics.setColor(255,0,0)
   love.graphics.printf("battery remaining: "..game.clock, 0, 0, love.graphics.getWidth(), "center")
   love.graphics.setColor(120,120,120)
   love.graphics.rectangle("line", 100, 100, 200, 100)
   love.graphics.rectangle("fill", game.px, game.py, game.pw, game.pw)
   love.graphics.setColor(0,120,120)
   love.graphics.rectangle("fill", game.exitx, game.exity, game.exitw, game.exitw)
   love.graphics.setColor(255,255,255)
end

function game.update(dt)
   if love.keyboard.isDown(" ") then
      if game.clock > 0 then
	 game.clock = game.clock - dt
      else
	 game.clock = 0
      end
      game.br = 200
      game.bg = 200
      game.bb = 190
   end

   -- player movement
   if love.keyboard.isDown("up") then
      game.py = game.py - 1
   end
   if love.keyboard.isDown("down") then
      game.py = game.py + 1
   end
   if love.keyboard.isDown("left") then
      game.px = game.px - 1
   end
   if love.keyboard.isDown("right") then
      game.px = game.px + 1
   end

   game.exit()
end

function game.keypressed(key, unicode)
end

function game.keyreleased(key, unicode)
   if key == " " then
      game.br = 0
      game.bg = 0
      game.bb = 0
   end
end

function game.flashlight()
end

function game.exit()
   if game.px > game.exitx and game.py > game.exity then
      game.br = 255
      game.bg = 0
      game.bb = 150
   end
end
