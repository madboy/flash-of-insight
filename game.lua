game = {}

function game.load()
   game.clock = 10
   
   game.borderx = 100
   game.bordery = 100
   game.borderw = 300
   game.borderh = 200

   game.pw = 10
   game.ph = 10
   game.px = game.borderx
   game.py = game.bordery

   game.br = 0
   game.bg = 0
   game.bb = 0

   game.exitw = 20
   game.exitx = game.borderx + game.borderw - game.exitw
   game.exity = game.bordery + game.borderh - game.exitw

   game.level = game.create_level1()
end

function game.draw()
   love.graphics.setBackgroundColor(game.br, game.bg, game.bb)
   game.draw_battery()
   game.draw_border()
   game.draw_player()
   game.draw_exit()
   game.draw_level()
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

   game.border_collision()
   game.obstacle_collision()
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

function game.obstacle_collision()
   for _, r in ipairs(game.level) do
      --if (game.px + game.pw) > r.x and game.px < (r.x + r.w)  and (game.py + game.pw) > r.y and game.py < (r.y + r.h) then
      -- if (game.px + game.pw) > r.x and (game.py + game.pw) > r.y and game.px < r.x and game.py < r.y then
      -- 	 game.px = r.x - game.pw
      -- end
      -- if game.px < (r.x + r.w) and (game.px + game.pw) > (r.x + r.w) and game.py < r.y and (game.py + game.pw) > r.y then
      -- 	 game.px = r.x + r.w
      -- end
      -- 1
      if game.px < r.x and game.px + game.pw > r.x and game.py < r.y and game.py + game.ph > r.y then
	 game.px = r.x - game.pw
	 game.py = r.y - game.ph
      end
      -- 2
      if game.px > r.x and game.px < (r.x + r.w) and game.px + game.pw < r.x + r.w and game.py < r.y and game.py + game.ph > r.y then
	 game.py = r.y - game.ph
      end
      -- 3
      -- 4
      if game.px < r.x and game.px + game.pw > r.x and game.px < r.x + r.w and game.py > r.y and game.py + game.ph < r.y + r.h then
	 game.px = r.x - game.pw
      end
      -- 5
      -- 6
      if game.px > r.x and game.px < r.x + r.w and game.px + game.pw > r.x + r.w and game.py > r.y and game.py + game.ph < r.y + r.h then
	 game.px = r.x + r.w
      end
      -- 7
      -- 8
      -- 9
   end
end

function game.exit()
   if game.px > game.exitx and game.py > game.exity then
      game.br = 255
      game.bg = 0
      game.bb = 150
   end
end

function game.draw_battery()
   love.graphics.setColor(255,0,0)
   love.graphics.printf("battery remaining: "..game.clock, 0, 0, love.graphics.getWidth(), "center")
end

function game.draw_border()
   love.graphics.setColor(120,120,120)
   love.graphics.rectangle("line", game.borderx, game.bordery, game.borderw, game.borderh)
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
   love.graphics.setColor(140,0,0)
   for _,r in ipairs(game.level) do
      love.graphics.rectangle("fill", r.x, r.y, r.w, r.h)
   end
end

function game.create_level1()
   local level = {}
   table.insert(level, {x = game.borderx + 100, y = game.bordery + 100, w = 25, h  = 40})
   return level
end
