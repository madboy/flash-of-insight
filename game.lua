game = {}

function game.load()
   game.borderx = 0
   game.bordery = 0
   game.borderw = 0
   game.borderh = 0

   game.wt = 20
   --game.clock = 10

   game.levels = {game.create_level1, game.create_level2, game.create_level3, game.create_level4, game.create_level5}
   game.current_level = 1
   game.reset(game.current_level)


end

function game.reset(level)
   game.clock = 10
   game.pw = imgs["player"]:getWidth()
   game.ph = imgs["player"]:getHeight()

   game.exitw = imgs["exit"]:getWidth()
   game.exith = imgs["exit"]:getHeight()

   game.level = game.levels[level]()

   game.flashlight = false

   game.px = game.borderx
   game.py = game.bordery

   game.br = 0
   game.bg = 0
   game.bb = 0


end

function game.draw()
   love.graphics.setBackgroundColor(game.br, game.bg, game.bb)
   if game.flashlight then game.draw_level() end
   game.draw_header()
   game.draw_player()
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
	 game.flashlight = false
      end
      
   end

   -- player movement
   local px = game.px
   local py = game.py
   if love.keyboard.isDown("up") then
      py = py - 1
   end
   if love.keyboard.isDown("down") then
      py = py + 1
   end
   if love.keyboard.isDown("left") then
      px = px - 1
   end
   if love.keyboard.isDown("right") then
      px = px + 1
   end


   for _, r in ipairs(game.level) do
      if game.obstacle_collision(px, py, r) then
	 love.audio.play(wall_s)
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
      love.audio.play(border_s)
      game.px = game.borderx
   end
   if (game.px + game.pw) > (game.borderx + game.borderw) then
      love.audio.play(border_s)
      game.px = game.borderx + game.borderw - game.pw
   end
   if game.py < game.bordery then
      love.audio.play(border_s)
      game.py = game.bordery
   end
   if (game.py + game.pw) > (game.bordery + game.borderh) then
      love.audio.play(border_s)
      game.py = game.bordery + game.borderh - game.ph
   end
end

function game.obstacle_collision(px, py, r)
   return not ((py + game.ph <= r.y) or (py >= r.y + r.h) or (px >= r.x + r.w) or (px + game.pw <= r.x))
end

function game.exit()
   if game.px + game.pw > game.exitx and game.py + game.ph > game.exity and game.py < game.exity + game.exith  and game.px < game.exitx + game.exitw then
      love.audio.play(exit_s)
      if game.current_level < table.getn(game.levels) then
	 game.current_level = game.current_level + 1
	 game.reset(game.current_level)
      else
	 state = "over"
      end
   end
end

function game.draw_header()
   local blvl = 0
   if game.clock > 0 then
      blvl = 11 - math.floor(game.clock)
   else
      blvl = 11
   end
   battery_img = "battery_"..blvl
   love.graphics.draw(imgs[battery_img], game.borderx + game.borderw - imgs["battery_1"]:getWidth(), game.bordery - imgs["battery_1"]:getHeight(), 0, 1, 1, 8, 16)
   love.graphics.setColor(255,20,147)
   local scale = 3
   love.graphics.push()
   love.graphics.scale(scale, scale)
   love.graphics.printf(game.levelname, 0, 30, love.graphics.getWidth()/scale, "center")
   love.graphics.pop()
   love.graphics.setColor(255,255,255)
end

function game.draw_border()
   love.graphics.setColor(120,120,120)
   love.graphics.rectangle("line", game.borderx, game.bordery, game.borderw, game.borderh)
end

function game.draw_player()
   love.graphics.draw(imgs["player"], game.px, game.py)
end

function game.draw_level()
   love.graphics.setColor(90,90,90)
   love.graphics.rectangle("fill", game.borderx, game.bordery, game.borderw, game.borderh)
   love.graphics.setColor(140,0,0)
   for _,r in ipairs(game.level) do
      love.graphics.rectangle("fill", r.x, r.y, r.w, r.h)
   end
   love.graphics.setColor(255,255,255)
   love.graphics.draw(imgs["exit"], game.exitx, game.exity)
   love.graphics.setColor(0,0,0)

   -- draw the covering darkness for the parts that the flashlight don't reach
   local bx = game.px + game.pw/2
   local by = game.py + game.ph/2
   local blx = 75
   local bly = 50
   -- upper
   love.graphics.polygon("fill", bx - blx, by, game.borderx, by, game.borderx, game.bordery, bx, game.bordery, bx, by - bly, bx - blx, by - 25, bx - blx, by)
   love.graphics.polygon("fill", bx + blx, by, game.borderx + game.borderw, by, game.borderx + game.borderw, game.bordery, bx, game.bordery, bx, by - bly, bx + blx, by - 25, bx + blx, by)
   -- lower
   love.graphics.polygon("fill", bx - blx, by, game.borderx, by, game.borderx, game.bordery + game.borderh, bx, game.bordery + game.borderh, bx, by + bly, bx - blx, by + 25, bx - blx, by)
   love.graphics.polygon("fill", bx + blx, by, game.borderx + game.borderw, by, game.borderx + game.borderw, game.bordery + game.borderh, bx, game.bordery + game.borderh, bx, by + bly, bx + blx, by + 25, bx + blx, by)

   love.graphics.setColor(255,255,255)
end

function game.create_level1()
   game.levelname = "level 1"
   game.borderx = 200
   game.bordery = 200
   game.borderw = 400
   game.borderh = 200

   game.exitx = game.borderx + game.borderw - game.exitw
   game.exity = game.bordery + game.borderh - game.exitw

   local level = {}
   return level
end

function game.create_level2()
   game.levelname = "level 2"
   game.borderx = 200
   game.bordery = 200
   game.borderw = 400
   game.borderh = 200

   game.exitx = game.borderx + game.borderw - game.exitw
   game.exity = game.bordery + game.borderh - game.exitw

   local level = {}
   table.insert(level, {x = game.borderx + 100, y = game.bordery, w = 20, h = game.borderh - game.wt})
   table.insert(level, {x = game.borderx + 200, y = game.bordery + game.wt, w = 20, h = game.borderh - game.wt})
   table.insert(level, {x = game.borderx + 300, y = game.bordery, w = 20, h = game.borderh - game.wt})
   return level
end

function game.create_level3()
   game.levelname = "level 3"
   game.borderx = 200
   game.bordery = 200
   game.borderw = 400
   game.borderh = 200


   local level = {}
   local corner1x = game.borderx + game.borderw - game.exitw * 3
   local corner1y = game.bordery + game.exith*3
   local corner2y = corner1y + game.exith*5

   game.exitx = game.borderx + game.borderw - game.exitw
   game.exity = corner1y + game.exith

   table.insert(level, {x = corner1x, y = corner1y, w = game.borderx + game.borderw - corner1x, h = game.wt})
   table.insert(level, {x = corner1x, y = corner2y, w = game.borderx + game.borderw - corner1x, h = game.wt})
   table.insert(level, {x = corner1x - game.exith, y = corner1y, w = game.wt, h = game.exith*2.5})
   table.insert(level, {x = corner1x - game.exith, y = corner2y-game.wt, w = game.wt, h = game.exith*2.5})
   return level
end


function game.create_level4()
   game.levelname = "level 4"
   game.borderx = 200
   game.bordery = 200
   game.borderw = 400
   game.borderh = 200

   game.exitx = 400 - game.exitw
   game.exity = 310 - game.exith

   local level = {}
   local c1x = 300
   local c1y = 250
   local c2x = c1x + game.wt
   table.insert(level, {x = c1x, y = c1y, w = game.wt, h = 100}) -- 1
   table.insert(level, {x = c1x + game.wt, y = c1y, w = 175, h = game.wt}) -- 2
   table.insert(level, {x = c1x, y = c1y + 100, w = 175 + game.wt, h = game.wt}) -- 3
   table.insert(level, {x = c1x + 175, y = c1y + 50, w = game.wt, h = 50}) -- 4
   table.insert(level, {x = game.exitx+game.exitw+14, y = c1y + game.wt, w = game.wt, h = 60}) -- 5
   table.insert(level, {x = game.exitx - 20, y = c1y + 60, w = 70, h = game.wt}) -- 6
   return level
end

function game.create_level5()
   game.levelname = "level 5"
   game.borderx = 200
   game.bordery = 200
   game.borderw = 400
   game.borderh = 200

   game.exitx = game.borderx + game.borderw - game.exitw
   game.exity = 310 - game.exith

   local level = {}
   table.insert(level, {x = game.borderx, y = game.bordery + 50, w = 25, h = game.wt}) -- 1
   table.insert(level, {x = game.borderx + 60, y = game.bordery, w = game.wt, h = 25}) -- 2
   table.insert(level, {x = game.borderx + 25 + 25, y = game.bordery + 50, w = game.borderw - 25 - 25, h = game.wt}) -- 3
   table.insert(level, {x = game.borderx + 60, y = game.bordery + 50 + game.wt, w = game.wt, h = 60}) -- 4
   table.insert(level, {x = game.borderx + 60, y = game.bordery + 50 + game.wt + 60, w = 120, h = game.wt}) -- 5
   table.insert(level, {x = game.borderx + 60 + 120 + 25, y = game.bordery + 50 + game.wt + 60, w = game.borderw - (60 + 120 + 25), h = game.wt}) -- 6
   table.insert(level, {x = game.borderx + 60, y = game.bordery + 50 + game.wt + 60 + 40, w = game.wt, h = game.borderh - ( 50 + game.wt + 60 + 40)}) -- 7
   table.insert(level, {x = game.borderx + 60 + 120 + 25 + 60, y = game.bordery + 50, w = game.wt, h = 45}) -- 8
   table.insert(level, {x = game.borderx + 60 + 120 + 25 + 60, y = game.bordery + 50 + 45 + 25, w = game.wt, h = 60}) -- 9
   return level
end
