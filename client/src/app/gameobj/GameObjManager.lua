local GameObjManager = class("GameObjManager")
function GameObjManager:ctor( gamescene,gamelayer)
	self.gamescene = gamescene
	self.gamelayer = gamelayer
end
function GameObjManager:addObj( obj )
	obj:showObj(self.gamelayer)
end
return GameObjManager