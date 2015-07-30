local Floor = require "app.gameobj.Floor"
local Rope = require "app.gameobj.Rope"
local GameMap = class("GameMap")
local TMX_OBJNAME = "relayup"
function GameMap:ctor( gamescene,maptb)
	self.objtable = {}
	self.maptable_tmx = maptb
	self.gamescene = gamescene
	print("GameMap")
	self:loadMap( )
end
function GameMap:loadMap(  )
	for i,v in pairs(self.maptable_tmx) do
		local objgroup = v:getObjectGroup( TMX_OBJNAME)
		if objgroup~=nil then
			local obj = objgroup:getObjects()
			for k,v in pairs(obj) do
				-- print("当前是地图",i)
				self:createGameObj( v,i)
			end
		end
	end
end
function GameMap:createGameObj( objv,obji )
	local rope = Rope:create()
	rope:setPosition( cc.p(objv.x+obji*MAPWIDTH,objv.y))
	self.gamescene:get_gameobjmanager():addObj( rope)
	table.insert( self.objtable, rope )
end
function GameMap:remove(  )
	-- body
end
function GameMap:update( dt)
	for k,v in pairs(self.objtable) do
		v:update(dt)
	end
end
return GameMap