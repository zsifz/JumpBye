--绳子
local GameObj = import(".GameObj")
local Rope = class("Rope",GameObj)
local MoveSpeed = GAMESPEED
function Rope:ctor( arg)
	Rope.super.ctor(self)
	self.Properties = {
		angle = math.random(45,60),--0-45度
		height = arg,--50-150像素
		speed = math.random(3,10), --1-10
	}
	-- self.Properties.angle = 0
	-- self.Properties.height = 0
	-- self.Properties.speed = 0
end
function Rope:get_Properties( )
	return self.Properties
end
function Rope:showObj( tlayer )
	-- smalldi_9
	local fullrect = cc.rect(0,0, 45, 47)
	local insetrect = cc.rect(8,8, 37, 39)
	self.objnode = CreateScale9Sprite("smalldi_9")--,fullrect,insetrect)
	self.objnode:setPreferredSize(cc.size(26,100))
	self.objnode:setAnchorPoint(cc.p(1,1))
	self.objnode:setPosition( self.pos)
	tlayer:addChild( self.objnode,1)
	local function RotateAct( speed,angle )
		local time = speed/10
		local rotate=cc.RotateTo:create( time, angle)
		local rotate1=cc.RotateTo:create( time, -angle)
		local seq = cc.Sequence:create( rotate,rotate1)
		local rep = cc.RepeatForever:create( seq)
		return rep
	end
	self.objnode:runAction( RotateAct(self.Properties.speed,self.Properties.angle))
end
function Rope:update( dt )
	self.pos.x=self.pos.x-MoveSpeed*dt
	self.objnode:setPosition(self.pos )
	self:setPosition(self.pos)
end
return Rope