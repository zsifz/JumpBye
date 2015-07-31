--检测碰撞的函数
local PLUS_INF = 1/0
local NEGATIVE_INF = -1/0
local MCollision = {}

--获取rect1碰撞的边位置, 没有处理rect1 包住rect2的情况
function MCollision.getCollisionSide( rect1, rect2, oldpos1, oldpos2, dt)
-- print("------------------------")
-- print("1.rect1", json.encode(rect1), json.encode(oldpos1))
-- print("1.rect2", json.encode(rect2), json.encode(oldpos2))

	--rect1的上下左右边是否接触到rect2
	local tright = false
	local tleft = false
	local ttop = false
	local tbottom = false
	local ttopblock = false
	local tbottomblock = false
	local tblockright = false--右侧会被挡住不能移动

	local touchstr = ""
	if cc.rectGetMaxX(rect1) >= cc.rectGetMinX(rect2) and cc.rectGetMaxX(rect1) <= cc.rectGetMaxX(rect2)  then
		tright = true
		touchstr = touchstr.." right"
	end

	if cc.rectGetMinX(rect1) <= cc.rectGetMaxX(rect2) and cc.rectGetMinX(rect1) >= cc.rectGetMinX(rect2)  then
		tleft = true
		touchstr = touchstr.." left"
	end

	if cc.rectGetMaxY(rect1) > cc.rectGetMinY(rect2) and cc.rectGetMaxY(rect1) < cc.rectGetMaxY(rect2)  then
		ttop = true
		touchstr = touchstr.." top"
	end

	if cc.rectGetMinY(rect1) > cc.rectGetMinY(rect2) and cc.rectGetMinY(rect1) < cc.rectGetMaxY(rect2)  then
		tbottom = true
		touchstr = touchstr.." bottom"
	end

	if cc.rectGetMaxY(rect1) > cc.rectGetMinY(rect2) and cc.rectGetMaxY(rect1) < cc.rectGetMaxY(rect2)  then
		ttopblock = true
	end

	if cc.rectGetMinY(rect1) > cc.rectGetMinY(rect2) and cc.rectGetMinY(rect1) < cc.rectGetMaxY(rect2)  then
		tbottomblock = true
	end
-------------------------	
	local collisionstat = {}
	collisionstat.deltax = 0--box1 位置修正值
	collisionstat.deltay = 0

	local box1,box2 = MCollision.genBoxs( rect1, rect2, oldpos1, oldpos2, dt )
	-- print("2.box1", json.encode(box1), "box2", json.encode(box2))
	local normalx, normaly, dtx, dty, xEntry, yEntry = MCollision.SweptAABB(box1, box2)
	-- print("4.normalx:", normalx, "normaly", normaly, dtx, dty)

	-- xEntry ==0 边贴着，>0第一次碰撞，<0小于0 已经碰撞
	if xEntry > 0 or (xEntry == 0 and (ttopblock or tbottomblock) ) then
		local movex2 = rect2.x - oldpos2.x
		local movex1 = dtx - math.abs( movex2 )
		collisionstat.deltax = (oldpos1.x + movex1) - rect1.x

		if box1.vx > 0 then
			collisionstat.blockright = true--右边是否会挡住
		end
	end

	if yEntry >= 0 then
		local movey2 = rect2.y - oldpos2.y
		local movey1 = dty - math.abs( movey2 )
		collisionstat.deltay = (oldpos1.y + movey1) - rect1.y

		if box1.vy < 0 then
			collisionstat.blockbottom = true--下边是否会挡住
		end
	end

	
	collisionstat.top = ttop
	collisionstat.bottom = tbottom
	collisionstat.right = tright
	collisionstat.left = tleft
	
	-- print( "5.touch side:", touchstr, json.encode( collisionstat ))
	return collisionstat
end

--把两个运动的物体理解成，rect1是运动的，rect2是静态的，rect1向rect2运动
-- 生成一个碰撞检测盒子,碰撞盒子的顶点是左上角
function MCollision.genBoxs( rect1, rect2, oldpos1, oldpos2, dt)
	
	local dx = rect2.x-oldpos2.x
	local dy = rect2.y-oldpos2.y

	local box1 = {}
	box1.x = oldpos1.x +dx
	box1.y = oldpos1.y +dy
	box1.w = rect1.width
	box1.h = rect1.height
	box1.vx = (rect1.x -(oldpos1.x+dx))/dt
	box1.vy = (rect1.y -(oldpos1.y+dy))/dt

	if rect1.x == (oldpos1.x+dx) then
		box1.vx = 0
	end
	if rect1.y == (oldpos1.y+dy) then
		box1.vy = 0
	end

	local box2 = {}
	box2.x = rect2.x
	box2.y = rect2.y
	box2.w = rect2.width
	box2.h = rect2.height
	box2.vx = 0
	box2.vy = 0

	return box1, box2
end

-- http://gamerboom.com/archives/74041
--SweptAABB 碰撞检测算法
function MCollision.SweptAABB(b1, b2)
	local normalx = 0
	local normaly = 0
	local xInvEntry = 0
	local yInvEntry = 0
    local xInvExit = 0
    local yInvExit = 0

    -- find the distance between the objects on the near and far sides for both x and y
    if (b1.vx > 0) then
        xInvEntry = b2.x - (b1.x + b1.w);--正值
        xInvExit = (b2.x + b2.w) - b1.x;
    else
        xInvEntry = (b2.x + b2.w) - b1.x;--负值
        xInvExit = b2.x - (b1.x + b1.w);
    end

    if (b1.vy > 0) then
        yInvEntry = b2.y - (b1.y + b1.h);--正值
        yInvExit = (b2.y + b2.h) - b1.y;
    else
        yInvEntry = (b2.y + b2.h) - b1.y;--负值
        yInvExit = b2.y - (b1.y + b1.h);
    end

    -- find time of collision and time of leaving for each axis (if statement is to prevent divide by zero)
    local xEntry = 0
    local yEntry = 0
    local xExit = 0
    local yExit = 0

    if (b1.vx == 0) then
        xEntry = NEGATIVE_INF--infinity 无穷大
        xExit = PLUS_INF
    else
        xEntry = xInvEntry / b1.vx;
        xExit = xInvExit / b1.vx;
    end

    if (b1.vy == 0) then
        yEntry = NEGATIVE_INF
        yExit = PLUS_INF
    else
        yEntry = yInvEntry / b1.vy;
        yExit = yInvExit / b1.vy;
    end

    -- find the earliest/latest times of collision
    local entryTime = math.max(xEntry, yEntry);
    local exitTime = math.min(xExit, yExit);
	
	--print(string.format("3.entryTime:%.2f exitTime:%.2f xEntry:%.2f yEntry:%.2f xInvEntry:%.2f yInvEntry:%.2f", entryTime, exitTime, xEntry, yEntry, xInvEntry, yInvEntry) )
    --if there was no collision

    local boxtx = b1.x
    local boxty = b1.y

    if xEntry > NEGATIVE_INF and xEntry < PLUS_INF then
    	boxtx = b1.x+b1.vx * xEntry
    end

    if yEntry > NEGATIVE_INF and yEntry < PLUS_INF then
    	boxty = b1.y+b1.vy * yEntry
    end

    local dtx = boxtx - b1.x
    local dty = boxty - b1.y

      --   if (xEntry > yEntry) then
      --       if (xInvEntry < 0.0) then
      --           normalx = 1;
      --           normaly = 0;
	     --    else
      --           normalx = -1;
      --           normaly = 0;
      --       end
      --   else
      --       if (yInvEntry < 0.0) then
      --           normalx = 0;
      --           normaly = 1;
	     --    else
      --           normalx = 0;
		    --     normaly = -1;
		    -- end
      --   end
    return normalx, normaly, dtx, dty, xEntry, yEntry
end

return MCollision