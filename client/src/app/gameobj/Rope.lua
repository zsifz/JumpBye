--绳子
local GameObj = import(".GameObj")
local Rope = class("Rope",GameObj)
local speed = GAMESPEED
function Rope:ctor( )
	Rope.super.ctor(self)
end
function Rope:showObj( tlayer )
	self.objnode = CreateSprite("wuqi")
	self.objnode:setAnchorPoint(cc.p(0,0))
	self.objnode:setPosition( self.pos)
	tlayer:addChild( self.objnode,1)

end
function Rope:update( dt )
	self.pos.x=self.pos.x-speed*dt
	self.objnode:setPosition(self.pos )
	self:setPosition(self.pos)
end
return Rope