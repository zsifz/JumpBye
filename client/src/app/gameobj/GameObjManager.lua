local MCollision = require "app.gameobj.Collision"
local Hero = require "app.gameobj.Hero"
local GameObjManager = class("GameObjManager")
function GameObjManager:ctor( gamescene,gamelayer)
	self.gamescene = gamescene
	self.gamelayer = gamelayer
	self.floorobj_TB={}
	self:init()
end
function GameObjManager:init( )
	self.hero = Hero:create()
	self:addObj( self.hero )
end
function GameObjManager:addObj( obj )
	if obj:getType()==GAMEROPE then
	elseif obj:getType()==GAMEBLOCK then
		self.floorobj_TB[obj:getId()] = obj
	end
	obj:showObj(self.gamelayer)
end
function GameObjManager:update( dt )
	-- body
end
return GameObjManager