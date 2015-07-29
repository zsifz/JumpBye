local GameObjManager = class("GameObjManager")
function GameObjManager:ctor( gamescene,gamelayer)
	self.gamescene = gamescene
	self.gamelayer = gamelayer
end
function GameObjManager:addObj( obj )
	-- body
end
return GameObjManager