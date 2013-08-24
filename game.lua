game = {}

function game.load()
   game.borderx = 0
   game.bordery = 0
   game.borderw = 0
   game.borderh = 0

   game.levels = {game.create_level1, game.create_level2, game.create_level3}
   game.current_level = 1
   game.reset(game.current_level)
end

function game.reset(level)
   game.pw = 10
   game.ph = 10

   game.level = game.levels[level]()
   game.clock = 10
   game.flashlight = false

   game.px = game.borderx
   game.py = game.bordery

   game.br = 0
   game.bg = 0
   game.bb = 0


end

function game.draw()
   love.graphics.setBackgroundColor(game.br, game.bg, game.bb)
   game.draw_battery()
   if game.flashlight then game.draw_level() end
   game.draw_player()
   game.draw_exit()
   game.draw_border() 
   love.graphics.setColor(255,255,255)
end

function game.update(dt)
   if love.keyboard.isDown(" ") then
      if game.clock > 0 then
	 game.clock = game.clock - dt
	 game.flashlight = true
      else
	 game.clock = 0
      end
      
   end

   -- player movement
   local px = game.px
   local py = game.py
   if love.keyboard.isDown("up") then
      --game.py = game.py - 1
      py = py - 1
   end
   if love.keyboard.isDown("down") then
      --game.py = game.py + 1
      py = py + 1
   end
   if love.keyboard.isDown("left") then
      --game.px = game.px - 1
      px = px - 1
   end
   if love.keyboard.isDown("right") then
      -- game.px = game.px + 1
      px = px + 1
   end


   for _, r in ipairs(game.level) do
      if game.obstacle_collision(px, py, r) then
	 px = game.px
	 py = game.py
	 break
      else
	 px = px
	 py = py
      end
   end
   game.px = px
   game.py = py
   game.border_collision()
   game.exit()
end

function game.keypressed(key, unicode)
end

function game.keyreleased(key, unicode)
   if key == " " then
      game.flashlight = false
   end
end

function game.border_collision()
   if game.px < game.borderx then
      game.px = game.borderx
   end
   if (game.px + game.pw) > (game.borderx + game.borderw) then
      game.px = game.borderx + game.borderw - game.pw
   end
   if game.py < game.bordery then
      game.py = game.bordery
   end
   if (game.py + game.pw) > (game.bordery + game.borderh) then
      game.py = game.bordery + game.borderh - game.ph
   end
end

function game.obstacle_collision(px, py, r)
   return not ((py + game.ph <= r.y) or (py >= r.y + r.h) or (px >= r.x + r.w) or (px + game.pw <= r.x))
end

function game.exit()
   if game.px + game.pw > game.exitx and game.py + game.ph > game.exity and game.py < game.exity + game.exith  and game.px < game.exitx + game.exitw then
      if game.current_level < table.getn(game.levels) then
	 game.current_level = game.current_level + 1
	 game.reset(game.current_level)
      else
	 state = "over"
      end
   end
end

function game.draw_battery()
   love.graphics.setColor(255,0,0)
   love.graphics.printf("battery remaining: "..game.clock, 0, 0, love.graphics.getWidth(), "center")
end

function game.draw_border()
   love.graphics.setColor(120,120,120)
   love.graphics.rectangle("line", game.borderx, game.bordery, game.borderw, game.borderh)
   love.graphics.setColor(255,0,0)
   love.graphics.printf(game.levelname, 0, 30, love.graphics.getWidth(), "center")
end

function game.draw_player()
   love.graphics.setColor(67,198,69)
   love.graphics.rectangle("fill", game.px, game.py, game.pw, game.ph)
end

function game.draw_exit()
   love.graphics.setColor(0,120,120)
   love.graphics.rectangle("fill", game.exitx, game.exity, game.exitw, game.exitw)
end

function game.draw_level()
   love.graphics.setColor(90,90,90)
   love.graphics.rectangle("fill", game.borderx, game.bordery, game.borderw, game.borderh)
   love.graphics.setColor(140,0,0)
   for _,r in ipairs(game.level) do
      love.graphics.rectangle("fill", r.x, r.y, r.w, r.h)
   end
end

function game.create_level1()
   game.levelname = "level 1"
   game.borderx = 100
   game.bordery = 100
   game.borderw = 300
   game.borderh = 200

   game.exitw = 20
   game.exith = 20
   game.exitx = game.borderx + game.borderw - game.exitw
   game.exity = game.bordery + game.borderh - game.exitw

   local level = {}
   return level
end

function game.create_level2()
   game.levelname = "level 2"
   game.borderx = 100
   game.bordery = 100
   game.borderw = 300
   game.borderh = 200

   game.exitw = 20
   game.exith = 20
   game.exitx = game.borderx + game.borderw - game.exitw
   game.exity = game.bordery + game.borderh - game.exitw

   local level = {}
   table.insert(level, {x = game.borderx + 100, y = game.bordery, w = 20, h = game.borderh - 45})
   table.insert(level, {x = game.borderx + 200, y = game.bordery+45, w = 20, h = game.borderh - 45})
   return level
end

function game.create_level3()
   game.levelname = "level 3"
   game.borderx = 100
   game.bordery = 100
   game.borderw = 300
   game.borderh = 200

   game.exitw = 20
   game.exith = 20
   game.exitx = game.borderx + game.borderw  - game.exitw
   game.exity = game.bordery + game.borderh/2 - game.exitw

   local level = {}
   local corner1x = game.borderx + game.borderw - game.exitw * 3
   local corner1y = game.bordery + game.ph*3
   local corner2y = corner1y + game.exith*5
   table.insert(level, {x = corner1x, y = corner1y, w = game.borderx + game.borderw - corner1x, h = game.exith})
   table.insert(level, {x = corner1x, y = corner2y, w = game.borderx + game.borderw - corner1x, h = game.exith})
   table.insert(level, {x = corner1x - game.exith, y = corner1y, w = game.exith, h = game.exith*2.5})
   table.insert(level, {x = corner1x - game.exith, y = corner2y - game.exith*1.5, w = game.exith, h = game.exith*2.5})
   return level
end
