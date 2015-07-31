local GameObj = import(".GameObj")
local Hero = class("Hero",GameObj)
local HeroX = 400
function Hero:ctor(  )
	Hero.super.ctor(self)
	self:setPosition( cc.p(HeroX, 150) )
end
function Hero:showObj( tlayer)
	-- self.objnode = --"res#json#role#shouren_61#shouren_61"
	-- self.objnode =sg_create_armature("res#json#role#shouren_61#shouren_61")
	-- self.objnode:setPosition( self.pos)
	-- tlayer:addChild( self.objnode)
end
return Hero